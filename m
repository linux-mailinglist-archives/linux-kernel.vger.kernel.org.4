Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A2F654BB1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 04:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235834AbiLWDUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 22:20:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiLWDUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 22:20:04 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDD73137E;
        Thu, 22 Dec 2022 19:20:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJfQkOiLZ9vQBLgkmzuc+tYhDOtXAZucJjQrcHTHx1i+N9EkWmT8ySedOhmAgPXPVJaJZX467ljmot3k5z7XL4cfNOHtH3CV6N+29JEime0sYNUmNaCHE9anIcPvb7DsDt6RyiVVu3dZSaQ/kevCIlecB8tcvXVTtbNqET9TksEYUXJBHjLiEPVQOZaZnjh1BzHYBrEtk4hmi/kUymY4+EU6vgR9CQozj6K09YsoBb0dToIe/sWlYUI2qpW52v7zi7+eZnkLUQiiw9CQsSJCjv1S8eV3jtk7HeJteT+bE8kVZpGiQJP76FYHEOUkUWmah7EQ+vcRm8pvCL4yObZNAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4PA1uPP4JlrdPG8fEZ95NDcBN+A74md3Lf5RQOVIcEI=;
 b=NsIS77py2nFKmn9sZfgxEzaIuMf4KU+EI29qw1IUrgSdWRColjz1xB+keqTQKzF4D0qwTq407giA7jFP1gGQTEdnPsjwMMFK2QpmDNlqRa0TDjtAimrvINiypASvmQDWrF7LK4b3yf/gMSDViWtXolFw1EYQmREqWXfEuxvnf/qKa9CVluVfLNjrPJpmr7sbqsxShHQmO4xpI3nRwwg+7keGS1kMgJnPjVMo4PKzXCuXzgiZf4sMa8hXxgEJJtIyP1OZX7rYxvnDbewM98Wz74PmJ0VqFkwzP+CxF5Frw541oCKTJWJAsr8xk/2VdZFzz7Zuo1jN3IPSYRdEKD+7fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4PA1uPP4JlrdPG8fEZ95NDcBN+A74md3Lf5RQOVIcEI=;
 b=FR8RrWJKXHGCjf13CbJJ4UFck2Q6SN3jaV1sOSY1RD3/V3r27QS4MGIujGjbENFMSq3kUpkLXtOUbN5vvOFGo3GDj1VlfWKaM0ls+GeNWuStw6bKrkqDU1IWS4srX36EKSh1ICkvHzDgv4aiIb9gGXdj3zkBFicM0jdxR/XoE8Y=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by SJ2PR12MB8012.namprd12.prod.outlook.com (2603:10b6:a03:4c7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.9; Fri, 23 Dec
 2022 03:19:57 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::960b:6963:b27e:f9ed]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::960b:6963:b27e:f9ed%8]) with mapi id 15.20.5924.016; Fri, 23 Dec 2022
 03:19:57 +0000
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
Thread-Index: AQHZE3Tn8xp/2Zbsk0WJLBwepOs8BK56whwAgAAPWCA=
Date:   Fri, 23 Dec 2022 03:19:57 +0000
Message-ID: <DM4PR12MB52780405AB9B24BF1E9B62A99CE99@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20221219064042.661122-1-perry.yuan@amd.com>
 <20221219064042.661122-2-perry.yuan@amd.com> <Y6UPZgtFvlJm3bVR@amd.com>
In-Reply-To: <Y6UPZgtFvlJm3bVR@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-12-23T03:19:54Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=eb1674de-4191-4344-9984-9b9b1a9dd002;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-12-23T03:19:54Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: f95b8101-ace9-4060-a38a-5e8d8381f680
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5278:EE_|SJ2PR12MB8012:EE_
x-ms-office365-filtering-correlation-id: 01f66919-3ae3-499b-3787-08dae4949186
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /KRAedXNQE1yWM/xb/aXQIgZeZyy1DhyGg15amNiymvJGbAE6pWE3YOO+lexx833BjD4FszgDrqmpxtYCUmU/+fPZZqGCIa+lVPVOC5z5Wcjb6kSOBWezxgH3+ycS2IphCDAPwnB+lWr2QaeG+SILKxkWM9m8Nskcan3QYCk9TpgLSGTlq62KCBI5ZaFVchOXp/T/efwED3l/z4pn7FDDywQ7rUCifwFPRjGUDfwyieuTRFpHPaZ2NtbN7fx198cj3i8IpA2dOwkM4DPBsUTtnlBIR3hslCOs8t9o32Xi7mTPjQlTN67fv399kt13dmKvSXcwgwF86QCWHmrslV4vi2GnjNws4BLAxmGiyjhRevB/zFGEV9trgeMRtg3bvSvvmQEayfqNpRtIXIuh8sRHPQc8tg9/Kl6VG05giTIsNQU+VzR1K/qcKkUKB5P2X7mKP5/7t79Ly+TDFuPgw/jlBe/UomUtE2BkHXWVqKndchMQXTNMt5q1fJjtD2IXSJak581imUxX+kTx4vgLAZClVqy7EKbRCGFhOcoDcr7vllZ2GSF7Ti6DG++GoeYj6m0HtILuL2M1NzJeVEgDEnqIvjXJ1AD1INCPj0mF6pDDbFBSl5lEzUUrPqQl8v0fgHYHCpHC9QiM1UiEmw5QdXCekwpJJAOz04lpSIdmszwzQI/tX9AlBfCYjfRXZi8HqKY9CGaNX1LwYjZGrk26c+N/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(366004)(39860400002)(136003)(396003)(451199015)(86362001)(71200400001)(41300700001)(186003)(26005)(52536014)(9686003)(53546011)(38100700002)(4326008)(5660300002)(83380400001)(8676002)(66476007)(66446008)(66556008)(66946007)(64756008)(55016003)(76116006)(33656002)(8936002)(38070700005)(6636002)(6862004)(2906002)(54906003)(316002)(122000001)(7696005)(6506007)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XG3cgbUAVyUObEDS2o0O5PBVFNzL+kcDjJRfyDF0qwGU3nhEY78znB7xDyXb?=
 =?us-ascii?Q?zWO9NVtvQEP9VnOvPZ8mysYZc4R0AsFr4J+ZwDDuZvFNeO0NVgDbcnCtA5/6?=
 =?us-ascii?Q?bcEQGd3Z25pTkqOb7UAs4w/d536Bnk8fTSyo974bCgHy78q5FDdoB9wupBmO?=
 =?us-ascii?Q?4AQBFK8HMq1GWwL2Km1Hee+3j1TldEeFHu74vK4JEzUoSnXogJ1wNgOXI3my?=
 =?us-ascii?Q?Y/diI6HwQosDPUkSAdD9wYTX7A3UWViAz/QbOwdV7+8ajrKshYKe59bmldFk?=
 =?us-ascii?Q?wcnLW47pLR1jCO42DcGwRyrTugsNXkQkVbfGwfzapaMZd9hc0aoQ//zjtTa6?=
 =?us-ascii?Q?A2Kig0D2gUANm22AJ+qzdIkTCnGa5enWRo9Q67vlsewM+ZNogHWYzCZgrz8D?=
 =?us-ascii?Q?n5ZKByfnO6uCU7SwIRNFKO0VJZiTs6ksuPbyAHy6tjpKacr+IwHZ+OevjxQL?=
 =?us-ascii?Q?8ElRK50v9b1WMbbuS2lvQCs1jMDavXn655v5gbdIjSJB62yNmrQB9kJY/2uN?=
 =?us-ascii?Q?J68+61TWQYll5JxHxzIVYQsCrrjv18L8SZcFqMK5ghUcDlSkFT0oQYGrTTGY?=
 =?us-ascii?Q?uSA1pq2HHve+iZPYozshc+Mm9qdllBiVqqmRqH+U1r49Q8iD2JxVN8KL5ik6?=
 =?us-ascii?Q?8FkWSQvnTDYxOJmI0VILn6WNerjc4NTgp1GLdvzdzC8wZzITHD1q8/b0J7M8?=
 =?us-ascii?Q?p3a/6jcF2GgnZZC9DJUiFFbE5yp70JdR2zA2TjNrH9a1pxmXDGYCNuRaWQ1R?=
 =?us-ascii?Q?3neu8wJWJbxMo47fNwUWaxuhmwXLyrn8xSHWeO7ONhWND+aB4daFFe4MKnoM?=
 =?us-ascii?Q?99Ej6Wz7GgFsLdHxuAbVuTmTlSHTv4inmUvSh58Ld9p5urIwTpyWbb8AA62l?=
 =?us-ascii?Q?8ae9FdeW7s25VSrbD2OeYx6KEp90VrvJNKT2PiLt0g9zr9M2u/pueK9DNyOw?=
 =?us-ascii?Q?BXeD2A1tvo1PZU7+Gd6mnKBk4qm8sKUnVdNzV8eH1+YRh+/jpVYldxr6Jgo0?=
 =?us-ascii?Q?YLB30IenWIzvEoT0sKRMviYUQL3qgj5ni/hNIC7D/3VXWaESYgx99CEzuOgT?=
 =?us-ascii?Q?+4ZZpqSePuhlz/dywngpYwHUQk78ulcM77qOMch114/T0QvsOj9Wcy/lu4GR?=
 =?us-ascii?Q?h4FYYxhR4MdLxa2zE0UmY69z0yOTk3sC64INNyYmShS7FJOOsQoM/oFosGmr?=
 =?us-ascii?Q?48EdakCsOWnFdYzuHglnVbpJd/VHw4a53RYMC2583zHJoxFYflTKytFSFsD5?=
 =?us-ascii?Q?33PP0qDl2d7aupK3TLDCQCysestvaqGdLRnY9cTosiWKYwwNK/4i0FDxvURP?=
 =?us-ascii?Q?o+hvWvvF6EZmzYmsbJB3lAUv6qD/gaGap8pd7hLMuoVuBmw9iB+cXk4cCMAK?=
 =?us-ascii?Q?DY1AQEDkuTskxDRR+OpnEDOp/84GX/RsLxEfz0K+HZ9FTZAJpQZjvMZ++V+Y?=
 =?us-ascii?Q?UPAGHWNpcXZ9UlQwAG4GCo5oxKOZt+FF3CaWdw+dnuavKU15J0nCKdGkoXgp?=
 =?us-ascii?Q?NSgJ+B8Aw1cgHDrajTTjMTgJ9sgpPjCxeCuwq/EdlbGs6+8byz0He2UII8qu?=
 =?us-ascii?Q?hT9sodKhGUyopnFIHtE4VqRRDG4+jwrbfCmNnaK8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01f66919-3ae3-499b-3787-08dae4949186
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2022 03:19:57.3819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e0jxZfoouLaTjWWv5vHRbi508vd/MB6CQMkLyOeG/KZx8FGN81hiK0BrM+4e/N2QZoB903auOXJ0BrioCi2gXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8012
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
> Sent: Friday, December 23, 2022 10:16 AM
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
> On Mon, Dec 19, 2022 at 02:40:30PM +0800, Yuan, Perry wrote:
> > From: Perry Yuan <Perry.Yuan@amd.com>
> >
> > Add support for setting and querying EPP preferences to the generic
> > CPPC driver.  This enables downstream drivers such as amd-pstate to
> > discover and use these values
> >
> > Downstream drivers that want to use the new symbols cppc_get_epp_caps
> > and cppc_set_epp_perf for querying and setting EPP preferences will
> > need to call cppc_set_epp_perf to enable the EPP function firstly.
> >
> > Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> > ---
> >  drivers/acpi/cppc_acpi.c | 76
> > +++++++++++++++++++++++++++++++++++++---
> >  include/acpi/cppc_acpi.h | 12 +++++++
> >  2 files changed, 83 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c index
> > 093675b1a1ff..81081eb899ea 100644
> > --- a/drivers/acpi/cppc_acpi.c
> > +++ b/drivers/acpi/cppc_acpi.c
> > @@ -1093,6 +1093,9 @@ static int cppc_get_perf(int cpunum, enum
> > cppc_regs reg_idx, u64 *perf)  {
> >  	struct cpc_desc *cpc_desc =3D per_cpu(cpc_desc_ptr, cpunum);
> >  	struct cpc_register_resource *reg;
> > +	int pcc_ss_id =3D per_cpu(cpu_pcc_subspace_idx, cpunum);
> > +	struct cppc_pcc_data *pcc_ss_data =3D NULL;
> > +	int ret =3D -EINVAL;
> >
> >  	if (!cpc_desc) {
> >  		pr_debug("No CPC descriptor for CPU:%d\n", cpunum); @@
> -1102,10
> > +1105,6 @@ static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx,
> u64 *perf)
> >  	reg =3D &cpc_desc->cpc_regs[reg_idx];
> >
> >  	if (CPC_IN_PCC(reg)) {
> > -		int pcc_ss_id =3D per_cpu(cpu_pcc_subspace_idx, cpunum);
> > -		struct cppc_pcc_data *pcc_ss_data =3D NULL;
> > -		int ret =3D 0;
> > -
>=20
> Do you have any specific reason to move this piece out of if-condition?

Move the declaration ahead of the If conditions like other functions did.
It looks more reasonable and no functions impact.=20

Perry.=20

>=20
> >  		if (pcc_ss_id < 0)
> >  			return -EIO;
> >
> > @@ -1125,7 +1124,7 @@ static int cppc_get_perf(int cpunum, enum
> > cppc_regs reg_idx, u64 *perf)
> >
> >  	cpc_read(cpunum, reg, perf);
> >
> > -	return 0;
> > +	return ret;
> >  }
> >
> >  /**
> > @@ -1153,6 +1152,19 @@ int cppc_get_nominal_perf(int cpunum, u64
> *nominal_perf)
> >  	return cppc_get_perf(cpunum, NOMINAL_PERF, nominal_perf);  }
> >
> > +/**
> > + * cppc_get_epp_perf - Get the epp register value.
> > + * @cpunum: CPU from which to get epp preference value.
> > + * @epp_perf: Return address.
> > + *
> > + * Return: 0 for success, -EIO otherwise.
> > + */
> > +int cppc_get_epp_perf(int cpunum, u64 *epp_perf) {
> > +	return cppc_get_perf(cpunum, ENERGY_PERF, epp_perf); }
> > +EXPORT_SYMBOL_GPL(cppc_get_epp_perf);
> > +
>=20
> This function is enough to get the epp value.
>=20
> Thanks,
> Ray
>=20
> >  /**
> >   * cppc_get_perf_caps - Get a CPU's performance capabilities.
> >   * @cpunum: CPU from which to get capabilities info.
> > @@ -1365,6 +1377,60 @@ int cppc_get_perf_ctrs(int cpunum, struct
> > cppc_perf_fb_ctrs *perf_fb_ctrs)  }
> > EXPORT_SYMBOL_GPL(cppc_get_perf_ctrs);
> >
> > +/*
> > + * Set Energy Performance Preference Register value through
> > + * Performance Controls Interface
> > + */
> > +int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls,
> > +bool enable) {
> > +	int pcc_ss_id =3D per_cpu(cpu_pcc_subspace_idx, cpu);
> > +	struct cpc_register_resource *epp_set_reg;
> > +	struct cpc_register_resource *auto_sel_reg;
> > +	struct cpc_desc *cpc_desc =3D per_cpu(cpc_desc_ptr, cpu);
> > +	struct cppc_pcc_data *pcc_ss_data =3D NULL;
> > +	int ret =3D -EINVAL;
> > +
> > +	if (!cpc_desc) {
> > +		pr_debug("No CPC descriptor for CPU:%d\n", cpu);
> > +		return -ENODEV;
> > +	}
> > +
> > +	auto_sel_reg =3D &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
> > +	epp_set_reg =3D &cpc_desc->cpc_regs[ENERGY_PERF];
> > +
> > +	if (CPC_IN_PCC(epp_set_reg) || CPC_IN_PCC(auto_sel_reg)) {
> > +		if (pcc_ss_id < 0) {
> > +			pr_debug("Invalid pcc_ss_id\n");
> > +			return -ENODEV;
> > +		}
> > +
> > +		if (CPC_SUPPORTED(auto_sel_reg)) {
> > +			ret =3D cpc_write(cpu, auto_sel_reg, enable);
> > +			if (ret)
> > +				return ret;
> > +		}
> > +
> > +		if (CPC_SUPPORTED(epp_set_reg)) {
> > +			ret =3D cpc_write(cpu, epp_set_reg, perf_ctrls-
> >energy_perf);
> > +			if (ret)
> > +				return ret;
> > +		}
> > +
> > +		pcc_ss_data =3D pcc_data[pcc_ss_id];
> > +
> > +		down_write(&pcc_ss_data->pcc_lock);
> > +		/* after writing CPC, transfer the ownership of PCC to
> platform */
> > +		ret =3D send_pcc_cmd(pcc_ss_id, CMD_WRITE);
> > +		up_write(&pcc_ss_data->pcc_lock);
> > +	} else {
> > +		ret =3D -ENOTSUPP;
> > +		pr_debug("_CPC in PCC is not supported\n");
> > +	}
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(cppc_set_epp_perf);
> > +
> >  /**
> >   * cppc_set_enable - Set to enable CPPC on the processor by writing th=
e
> >   * Continuous Performance Control package EnableRegister field.
> > diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h index
> > c5614444031f..6b487a5bd638 100644
> > --- a/include/acpi/cppc_acpi.h
> > +++ b/include/acpi/cppc_acpi.h
> > @@ -108,12 +108,14 @@ struct cppc_perf_caps {
> >  	u32 lowest_nonlinear_perf;
> >  	u32 lowest_freq;
> >  	u32 nominal_freq;
> > +	u32 energy_perf;
> >  };
> >
> >  struct cppc_perf_ctrls {
> >  	u32 max_perf;
> >  	u32 min_perf;
> >  	u32 desired_perf;
> > +	u32 energy_perf;
> >  };
> >
> >  struct cppc_perf_fb_ctrs {
> > @@ -149,6 +151,8 @@ extern bool cpc_ffh_supported(void);  extern bool
> > cpc_supported_by_cpu(void);  extern int cpc_read_ffh(int cpunum,
> > struct cpc_reg *reg, u64 *val);  extern int cpc_write_ffh(int cpunum,
> > struct cpc_reg *reg, u64 val);
> > +extern int cppc_get_epp_perf(int cpunum, u64 *epp_perf); extern int
> > +cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool
> > +enable);
> >  #else /* !CONFIG_ACPI_CPPC_LIB */
> >  static inline int cppc_get_desired_perf(int cpunum, u64
> > *desired_perf)  { @@ -202,6 +206,14 @@ static inline int
> > cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val)  {
> >  	return -ENOTSUPP;
> >  }
> > +static inline int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls
> > +*perf_ctrls, bool enable) {
> > +	return -ENOTSUPP;
> > +}
> > +static inline int cppc_get_epp_perf(int cpunum, u64 *epp_perf) {
> > +	return -ENOTSUPP;
> > +}
> >  #endif /* !CONFIG_ACPI_CPPC_LIB */
> >
> >  #endif /* _CPPC_ACPI_H*/
> > --
> > 2.34.1
> >
