Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBE6655DC2
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 17:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbiLYQlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 11:41:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbiLYQlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 11:41:51 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2600E313;
        Sun, 25 Dec 2022 08:41:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jlvf8aS07Kx96fyG10IX7WK7Gig1LkYhVJPvflQhQS4cr8K2GK8b/hKgCaSh2ysGXEuIzfEutfyeRXqSkP+E6ppebDsDrc7HF61SYQvKIw8wnKO4AXBvbS8ZfoR0fKx5tY1o/CmTY6fSHvbJ/+PIjlf9hkwonITuKGdOLBTsML+DQXIgycUOfCyTMw2QWomdWNc8nJdbgf/4lzC8Ur/cifAy/9lbB4vvVmMM19j5N9FF2IB4+tVcEuIW41R0izSAw0wxzDQycoTr1DxtafaPr2yeU7KddG/z/79BMo0+wgRZrYzho2ui3bSESmDumV5pzjUH8ma8qd2isRUXTfeb0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6EwRzqTFvwURTbUMN6NNtmXk791Yj+kBOPSVR7Mmo6M=;
 b=YM1jEP08FdipYrN8bc4uM2EkdAzOAQhJ8WlpWNrkj4qf49ki9hLprpVoJrTx3VeXB6R/EXIIRcLTkt0iROAqpGFNpPcRLzkXJ7+DomB4fQg+AQvb5WjMGykuSf9DclsdJ9Bn6VPg/GhDakqCbUZH3j7Dx2jS1gq4Lq0iHyf9aokH0AMIslquPlug1+A6j1owOsWw/O8xU0Cluh0VxpdCkYg/ig+MK8ZvZ+1Ta3feISeW+LxxKI+PY7lKMnyHlNZPUO+jfwigncL2EOoXDs5PanhlUJHK496pczrG4eFIwEDxAfCbr2RZ/Nm+2cj7/tujbHcg5eLUsD3ZrA/UB0yP4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6EwRzqTFvwURTbUMN6NNtmXk791Yj+kBOPSVR7Mmo6M=;
 b=DAFpnZYtq80BH3bOlNupilVdUInoiZuRoIfjU5aS1MW7v9XcuIl/7foDhc6ysZGGO4cyspETZ67Vko1xtgnamzy7+IF8Gz7dcCEMq7N7z89xt4PsYTgexrMISYP+NgzmrE6+aHC/vW97BnVVSBkY8OXeB7ETz8o01f/UPXVSpe0=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by CH2PR12MB4860.namprd12.prod.outlook.com (2603:10b6:610:6c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.14; Sun, 25 Dec
 2022 16:41:47 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::960b:6963:b27e:f9ed]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::960b:6963:b27e:f9ed%9]) with mapi id 15.20.5944.015; Sun, 25 Dec 2022
 16:41:47 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     "Huang, Ray" <Ray.Huang@amd.com>
CC:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "Karny, Wyes" <Wyes.Karny@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v8 01/13] ACPI: CPPC: Add AMD pstate energy performance
 preference cppc control
Thread-Topic: [PATCH v8 01/13] ACPI: CPPC: Add AMD pstate energy performance
 preference cppc control
Thread-Index: AQHZE3Tn8xp/2Zbsk0WJLBwepOs8BK56whwAgAAPWCCAAGM5gIADoivg
Date:   Sun, 25 Dec 2022 16:41:47 +0000
Message-ID: <DM4PR12MB527894D36373B772ECEA41949CEF9@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20221219064042.661122-1-perry.yuan@amd.com>
 <20221219064042.661122-2-perry.yuan@amd.com> <Y6UPZgtFvlJm3bVR@amd.com>
 <DM4PR12MB52780405AB9B24BF1E9B62A99CE99@DM4PR12MB5278.namprd12.prod.outlook.com>
 <Y6VvgSO8XNBbP4Xw@amd.com>
In-Reply-To: <Y6VvgSO8XNBbP4Xw@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-12-25T16:35:49Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=77b5510d-e2c6-4abc-870d-c3e81d52a6ac;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-12-25T16:35:49Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 3c1b1c54-baf6-4a19-8d9b-f5755ba56278
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5278:EE_|CH2PR12MB4860:EE_
x-ms-office365-filtering-correlation-id: 4cdac607-9dde-4ef5-5bbb-08dae696ea07
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GKJptDxWLeeCfyQf8Afmnd5Knyi+Nvqxs6qL3ZAwN+YzA8qmWwsJSOKNLDeDty+XL2iJXFncX04J9ON6sTtqaBxFUqqhPtc8uJkft7LozG5Ckth6d3g83w777gt537Jes3wHtTftKwxE31PFngfvrfCktVWqhnSppvo54aVYt36gleYgnnEus7Y+fwYPFVB0ZF5d6KWzB+xY1npxniM0kUycFhxTPI9aT3JxDCxceKncthFKuVdF/qKSL1Nwy1nWEqoQbXeSwji0j+qXjF4I0CDSHUZysRaGYbHApIvFRT1hi2t7diusbip4HtFciEDD0cqGdBKpQnftCiY9QXRUk/8/q9ZF8+4f4cASxhVyngDBwoZOcN+Eyk6Yu3GnP4fSPjeGVx1A1w8eEa0qlLEe6Wum1oL7g3CnOVYk+sLDcfj9LxoKD02DHljqKUVcooOEWxMJRAvt6reVZBfCJXfOb/0D/oc69CgKQSZR06BwYqtrBR1syykYG0KNIo/JLpJwIuJmzUrfRIdsKP6hkS0E1j29eGyxG8wCG+/enRgAmmee2xUhNAT7XXnU9LKYKGvIQcWcUOJDvkknTz1E+fBTqr2HtYnDFw7sh3N/7psUL9F/o5A5Gr+3INSckEn0w1KIiTzCNoPhgvEbfKbqHMPASQI1d5+lJFU8VBxjCSbSnho05k/r5bpfdlDUVxkWH2Ud50he7+ZUo98i8bpuonLoxQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(366004)(396003)(39860400002)(376002)(451199015)(83380400001)(2906002)(54906003)(6636002)(33656002)(316002)(38070700005)(26005)(478600001)(9686003)(186003)(53546011)(122000001)(38100700002)(7696005)(6506007)(71200400001)(86362001)(55016003)(4326008)(66476007)(8676002)(66556008)(64756008)(52536014)(66446008)(6862004)(8936002)(41300700001)(76116006)(66946007)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?j0Gh4ygLjiLSSA8F8ZYeWi5vwSQFwvrf+uvNz4kPle/imGx3cQN3dgUp8klb?=
 =?us-ascii?Q?WldLA6y+6JPxvTD5SmAE+O/hGQC8lV3L/LQ2fVyTMGETX6LsIjkNScj8w/UB?=
 =?us-ascii?Q?tdLOB0gBvg7VuQU6QKYV7rBr3JdP4ZrBoNI96bHej0/xwHiX/LoqCx2XdqCY?=
 =?us-ascii?Q?QA8lcHnuEe9GKmuxLJuuMWfAcMqx5VoOBxl5Bq7aQFRp0cCoeg3GcjCJfjM9?=
 =?us-ascii?Q?RonPda6KYFmtXszIfvU/Xjil/CkiFjfaQaKt22mESUAm0cSRLLuOkqo1UUMx?=
 =?us-ascii?Q?YbgCkigziN4SmJS0tRllakOdNA7gyBujvLsXAXYZNxxfTl6TAoMPW23k+dlI?=
 =?us-ascii?Q?A+VgZe1QnylTN8UlNR3dtJjogV1AmLnMC+/wtmZL+wFopHScnH5Atp+Hpvi3?=
 =?us-ascii?Q?hmNLvqcc5y+4alDfM4zIMdOeD7dCvDIe0Uuq+ysGErbneaxsr0fN2oKl+XNj?=
 =?us-ascii?Q?U+xj1pPRXO5FvBf2ZkCU5XIhEPWn7Fwec5mWapraIeCSQq0cQPmVYKXIYCA5?=
 =?us-ascii?Q?1q2qTaIOHz3SH+ZXtHYsdesace409huudNrAMt6Zlpo+iZHH/LTiTOr235VB?=
 =?us-ascii?Q?2/hQmkjDgBxZ2cAD3IaEIFmQXcBUY/5cpI3ql7LLJbflykDUSaB00YrRpSff?=
 =?us-ascii?Q?pmdoV1YrcDs5WE55p9TtiviyEGK5v6Fs4ppLU2wzkyVZQdDUhuItnkpBhHdD?=
 =?us-ascii?Q?GVvp3vVjzn8U5uaqWuTfRFCnNoPUO8io09JsjpxrPuEuBrKmtEQ1OYEU/SiI?=
 =?us-ascii?Q?wro+qKiy7QupHqJ+0lpDtqhEXt8Sbx60VZCjSCxDbjr+iCrcppU0Bp4nx30d?=
 =?us-ascii?Q?1V1vOWfIWJhcNAoT67btwg31gN9opgrsBnAc3mnkD1TTllLee20SSCrxZWqe?=
 =?us-ascii?Q?BeY8ELJDD61rr3tlT0Y4X8UUuDNsu4WUhJVWVQCjziXEcxQxT9pdvwEMzW0o?=
 =?us-ascii?Q?ggnPNOGhfvVm4BAZQLmOsR/Sww+QcA/kHPjtGblSXwSH4XlaOrOvm0P/Q2AU?=
 =?us-ascii?Q?IU4Ixo3RzZ7cK+zRvTfkpF5JIwjJz6R7YV/3thObkGqLimmRC+gVvbabLSKf?=
 =?us-ascii?Q?LK/GLfvUGXrdEKbhUALU4SCHKO4sjYggUk9S4vZdrlvm0hWQEZ1/SI/TuMJ8?=
 =?us-ascii?Q?TlnV+7wPsn4JLSLwutPivRaUpaw7a/0nmYVoFhtbW1y8ZSqzUnBbB9+P7a5/?=
 =?us-ascii?Q?dzFaHRKLeyB3DdniVzVo7K1j3qyJT4JXGnngs3cSU1Ee2r/CWl0VPsdkZHQl?=
 =?us-ascii?Q?TfW/6WFd4maEvrSCsHMz93FpUG85wkaoirV99BWIwDgB67yXgTTvQrbU1+ra?=
 =?us-ascii?Q?uczghtOKJUwC/Lk9IscScplutnlwo/aQeiGKRjFsqFk4qTkZxcvE8uHYJnzv?=
 =?us-ascii?Q?oiMpdg9WKL/yona25m5gskGKNc448//DHz1mzGG5PbYkAQCEzFlqgT6mi7zh?=
 =?us-ascii?Q?pZrDFkOrt0bkGa9kw4JJbbjbX/6xesaMMaUOk+ofHjKavKTozbUWbJwRyurc?=
 =?us-ascii?Q?EvnJCRuSdAgTB2O32Ib/YZC12oDyVo6p/y/QB2GEsjYwPLc3yMuFTsU/eeoZ?=
 =?us-ascii?Q?XGhw0xKFpXE/cQRs3jP5fdlpWKycebRnF6T3s0E2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cdac607-9dde-4ef5-5bbb-08dae696ea07
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Dec 2022 16:41:47.1555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mk/zh89oIJjcrmH2HmfTx+v1s/gZefPittAqWo3rNX4IjbjjmHXogYUm9YaJCT1IDr+pE16O/W4Um9bpHxiY2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4860
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]



> -----Original Message-----
> From: Huang, Ray <Ray.Huang@amd.com>
> Sent: Friday, December 23, 2022 5:06 PM
> To: Yuan, Perry <Perry.Yuan@amd.com>
> Cc: rafael.j.wysocki@intel.com; Limonciello, Mario
> <Mario.Limonciello@amd.com>; viresh.kumar@linaro.org; Sharma, Deepak
> <Deepak.Sharma@amd.com>; Fontenot, Nathan
> <Nathan.Fontenot@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Huang, Shimmer
> <Shimmer.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Meng,
> Li (Jassmine) <Li.Meng@amd.com>; Karny, Wyes <Wyes.Karny@amd.com>;
> linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v8 01/13] ACPI: CPPC: Add AMD pstate energy
> performance preference cppc control
>=20
> On Fri, Dec 23, 2022 at 11:19:57AM +0800, Yuan, Perry wrote:
> > [AMD Official Use Only - General]
> >
> >
> >
> > > -----Original Message-----
> > > From: Huang, Ray <Ray.Huang@amd.com>
> > > Sent: Friday, December 23, 2022 10:16 AM
> > > To: Yuan, Perry <Perry.Yuan@amd.com>
> > > Cc: rafael.j.wysocki@intel.com; Limonciello, Mario
> > > <Mario.Limonciello@amd.com>; viresh.kumar@linaro.org; Sharma,
> Deepak
> > > <Deepak.Sharma@amd.com>; Fontenot, Nathan
> <Nathan.Fontenot@amd.com>;
> > > Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Shimmer
> > > <Shimmer.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>;
> Meng,
> > > Li (Jassmine) <Li.Meng@amd.com>; Karny, Wyes
> <Wyes.Karny@amd.com>;
> > > linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org
> > > Subject: Re: [PATCH v8 01/13] ACPI: CPPC: Add AMD pstate energy
> > > performance preference cppc control
> > >
> > > On Mon, Dec 19, 2022 at 02:40:30PM +0800, Yuan, Perry wrote:
> > > > From: Perry Yuan <Perry.Yuan@amd.com>
> > > >
> > > > Add support for setting and querying EPP preferences to the
> > > > generic CPPC driver.  This enables downstream drivers such as
> > > > amd-pstate to discover and use these values
> > > >
> > > > Downstream drivers that want to use the new symbols
> > > > cppc_get_epp_caps and cppc_set_epp_perf for querying and setting
> > > > EPP preferences will need to call cppc_set_epp_perf to enable the E=
PP
> function firstly.
> > > >
> > > > Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> > > > ---
> > > >  drivers/acpi/cppc_acpi.c | 76
> > > > +++++++++++++++++++++++++++++++++++++---
> > > >  include/acpi/cppc_acpi.h | 12 +++++++
> > > >  2 files changed, 83 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> > > > index 093675b1a1ff..81081eb899ea 100644
> > > > --- a/drivers/acpi/cppc_acpi.c
> > > > +++ b/drivers/acpi/cppc_acpi.c
> > > > @@ -1093,6 +1093,9 @@ static int cppc_get_perf(int cpunum, enum
> > > > cppc_regs reg_idx, u64 *perf)  {
> > > >  	struct cpc_desc *cpc_desc =3D per_cpu(cpc_desc_ptr, cpunum);
> > > >  	struct cpc_register_resource *reg;
> > > > +	int pcc_ss_id =3D per_cpu(cpu_pcc_subspace_idx, cpunum);
> > > > +	struct cppc_pcc_data *pcc_ss_data =3D NULL;
> > > > +	int ret =3D -EINVAL;
> > > >
> > > >  	if (!cpc_desc) {
> > > >  		pr_debug("No CPC descriptor for CPU:%d\n", cpunum); @@
> > > -1102,10
> > > > +1105,6 @@ static int cppc_get_perf(int cpunum, enum cppc_regs
> > > > +reg_idx,
> > > u64 *perf)
> > > >  	reg =3D &cpc_desc->cpc_regs[reg_idx];
> > > >
> > > >  	if (CPC_IN_PCC(reg)) {
> > > > -		int pcc_ss_id =3D per_cpu(cpu_pcc_subspace_idx, cpunum);
> > > > -		struct cppc_pcc_data *pcc_ss_data =3D NULL;
> > > > -		int ret =3D 0;
> > > > -
> > >
> > > Do you have any specific reason to move this piece out of if-conditio=
n?
> >
> > Move the declaration ahead of the If conditions like other functions di=
d.
> > It looks more reasonable and no functions impact.
> >
>=20
> If one platform doesn't have any CPC registers, it even won't need define
> these variables like pcc_ss_id, pcc_ss_data, and it will save more time.
>=20
> Thanks,
> Ray

Make sense , get it fixed in V9=20
