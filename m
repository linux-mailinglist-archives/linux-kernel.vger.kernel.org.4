Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09B5650A18
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 11:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbiLSK2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 05:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbiLSK2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 05:28:13 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9779E3A;
        Mon, 19 Dec 2022 02:28:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dIiPeiYhmyyXx8NkNWyn47eqWCk1d+yeWWFHnSRnlLVSD1DmZs0tUp9xA1EHK5FNohguE8cv+DZg7nWbvaVa0wKICL1FQ0U/hT5qD6p5WfExxjxwU3ttaD0ZST0cw6zMjqU/szaQqMoRwWerzJ/vCDY3u5+3V0nXkdFh7RE5JboKW8UJctFSyRFwMgeFkVK3iPLL08VhVLv0AbZOFfwh9jGL/Sr7+RHVIo8AY3f9EddlD3FgPRpmQQmjHSm8ASonZddAe0/OqcO/au5BBNbdKBUZz5JI29s3kKYlvxeDHNGst8Bh1wXEcZuIpH9wMZVB51bbcUmBmXDQIm86J1d4hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHiE7kAFy7BYxoMUVoLVt8wwcLBzNTsypLOKSouxP9g=;
 b=nWImSvFS93ug/5Yj8tlVkn7QGoiUP37X85nFPNk+TPu5TlrFwaah5RUvIH34PqRjmWkCbMuJ4u+EVgJe5krouJcLrBC2AZTK8SMo52O8wIX5wW1CeugSDFuS7GYrxZGoUumw8SZ87FfLAwUWBOF0p9YQa9D2AYefyMHoOfNBDOokF3Ovmms1F8pPSXE8CI4MvzrfL6yFvBQIjbaw8rvnfORn+Um4SDwST57IFCi7f5pVnlia8qj8cIhSoP+KTfjwIN8ZOspYXhVeNjC2uZyrjGo/H6NNZEsdboq9xR8ZgQa0LBkHaEys+gUIqPrEMYRvNmkF2Tz5rgHdLTWjoC/a/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHiE7kAFy7BYxoMUVoLVt8wwcLBzNTsypLOKSouxP9g=;
 b=web8twMNBXJHUmE9red/fm7wdnw5DyuIJqYWxTC4RcCv7K5Uz9tBsf+HoX8NHY3Wtvs9pQf6uTn8NIyr1ivzLN5xhY3z1jILhBcvOf2dzP0vU+AOYsXtUElnrckRiFC4uPnxClMqPMUwk6hj8zwrdO1KnPAgIX12XmfPll2kOlQ=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by IA0PR12MB8350.namprd12.prod.outlook.com (2603:10b6:208:40d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 10:27:58 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::960b:6963:b27e:f9ed]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::960b:6963:b27e:f9ed%8]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 10:27:58 +0000
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
Subject: RE: [PATCH v7 06/13] cpufreq: amd-pstate: implement amd pstate cpu
 online and offline callback
Thread-Topic: [PATCH v7 06/13] cpufreq: amd-pstate: implement amd pstate cpu
 online and offline callback
Thread-Index: AQHZCvdNMs+me9E350e/2bofMRpfoa5p+vcAgAsWXuA=
Date:   Mon, 19 Dec 2022 10:27:58 +0000
Message-ID: <DM4PR12MB527856197A5DDC68FC052BAF9CE59@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20221208111852.386731-1-perry.yuan@amd.com>
 <20221208111852.386731-7-perry.yuan@amd.com> <Y5buIL08ovNxYp5f@amd.com>
In-Reply-To: <Y5buIL08ovNxYp5f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-12-19T10:27:53Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=81896d42-681b-4d1e-bc35-040f659019b4;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-12-19T10:27:53Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 4b319e01-016d-4be1-86f8-cde7ccc4e179
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5278:EE_|IA0PR12MB8350:EE_
x-ms-office365-filtering-correlation-id: dc238234-0692-4f21-cb14-08dae1abb2eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eo9BmPoeeU53jyxbURzXQpzx0dBDRWDFkD5JaSKqDZPbAafYgQciI0bswJri478YTSM/XKPkn43BJc5FNBT35QRep98cd0JIIclP4iNJM847o94sS0uonYrDculAf6Fsw46BEgQBhuN2pAe7KjAO2vb8fNwxqxnBHArOd4qLSAtHbU7E6ditlFeZpEHGg/70xM9F5ih4kHAMGmtaugUnPWd1FV1KTnDxq2pFOaBl8KAkqjRl8IQ/gi608nZ1sUTIj40oHFq/AU/s3KG4s5l9VLVuoTP8UTj8gOJ7DxPjpM4hMmk/1vfCW7qTuO3G9xG8U0fKBe5ifMAAotqwo2hw+oaRS1PlqtXr+QWPM9QZn9oeUJkaQ8qCHEpA4PmzKB6RS81Hyf0RiDdlJ9rptKWiK3Ur/GYjT8JD0Q9QYKEBOrkAgVZ36dwF2DPgY0mkeFY2VFntOPIVeIRohzvQATNZD0S4StY0yQnm/hLkL0ix/PwfdN1KVPGKRerjXWioUfKvrDEsRr2aogxu9enUCsMuhPtqCcf2i+N3BDQMBBaxxXV2etnhzfb09t2RBuz04596MlrFDtSW2Xnj6Um6fnAgoAMi99Z07nv+A3gZPOkVvOT5G6OirWvmBbZ+SqubkRVyIh2rYEqA0kgZLYwm74IGdeI4wOXlWy3ZBvVL7YlfOS/sxm63hXuIQzZsRYc7BRwO0TJ1u0sj0IzJbhnK4Vou1A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(451199015)(5660300002)(8676002)(4326008)(54906003)(52536014)(6636002)(76116006)(66556008)(66946007)(2906002)(66446008)(64756008)(66476007)(71200400001)(478600001)(9686003)(26005)(186003)(7696005)(53546011)(41300700001)(6506007)(86362001)(55016003)(83380400001)(38100700002)(8936002)(38070700005)(6862004)(316002)(33656002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?h8tPnpljNNerAtTAYSKHW3/vPz/cSm1963FsmJpws9xNOY2M18ouCU7pJL2V?=
 =?us-ascii?Q?phVEIoxncJ5aMgbEwRxO7seAeqiCQXXE7je+9m5Vm+SUBrOHfHfl0zmEd8Yx?=
 =?us-ascii?Q?mjYRY3YcaLa9swge9lNziy1FN4yJtcx6xfLqXVNYE1tL7P2382NgOEniqXjh?=
 =?us-ascii?Q?6ypTUdR5axO+WU0zjfCx1hU1kjJ2dBpADqlKnwKiojCGltX1M42tUbcE9MxZ?=
 =?us-ascii?Q?LJgNRNKK9amjMlQwnMzLQO+NkTsnqjm6gy7PNgw6F22nqyVakHyfn4VIMxlg?=
 =?us-ascii?Q?Gw2klP4Gp5Sp1K7E16xpQ2pQaPrz0+Tx1t/u0LnBkscWKuYFbNhUDsg26qkq?=
 =?us-ascii?Q?Bv/vwPnSJG8DKN2UbVAmIPGYqWJxZe6j0Uy1OIxwWUhYACvEN+rJanE199hM?=
 =?us-ascii?Q?X5OXfAtZFIbCY+p6OZFBozufMfP0NDInUkeFmTWe1x3ts1Vk7K0++9P8/G+A?=
 =?us-ascii?Q?0DVKC1W0HEkunlr+h48F+yjQTf6MfCxDvcehiEu/SHSb40VwzjC3QbwfX3Sx?=
 =?us-ascii?Q?rj4gF8wlio0syurdD4NeuhpLMzQNVeuGKxjG762mxwY6gdWxKO4ceZ9a7QK/?=
 =?us-ascii?Q?428fk8AhM+UpS2DjvaUr0UUZjipzeD8xjh6Dl0SLiMAlt4W0cBjic2DbRicr?=
 =?us-ascii?Q?sDh6fmlg+LlqAX38fmESZgJygmtVUYelrBEP9lXvAd43hqXeFgTxM2vgMYRq?=
 =?us-ascii?Q?p2jjyxumpWA1Q9mTs89tyM2ykypciwjS4+9u6/biOPFqouf15tSgd61ZHkqI?=
 =?us-ascii?Q?uIP0616VF1D9lNROpSngpisO0kqYCgn/7uLWRJ59yYUS1lEEVMk6NO0xZSzY?=
 =?us-ascii?Q?imPBCQLQGKwCw05cPFHvI/4R2yEdo5TGuDEuguYZ2/1+9qsFAFartLbLZp5K?=
 =?us-ascii?Q?O75lW3/6gqRpb6cC7PtgYUzKuixGJI+HS+0pxYpLRxMqGu9QJGInZ3IkybK4?=
 =?us-ascii?Q?sp1z1vxZO519ywCsS3snGu7uV0Op2Ax2d+vtbhDZMJQfiH1jbVlpVARdH132?=
 =?us-ascii?Q?dsXM2uJ4q17wdTim+bnAYbANwpRme3QQqMOGGWFWLDDf2CJCdliIHshOaIVS?=
 =?us-ascii?Q?yELiyS0UeIyurRndOHSQ06XpQ5PtEoHBZ9lEC/FEzU20/LrJRkixuCIB9Q5D?=
 =?us-ascii?Q?3pIXe6Vx8/H/+OBJSbz+JRGjBjsvZZb4bIXlsqvctW3M+KrVgLQVmHX09aeK?=
 =?us-ascii?Q?8Hx+v7BXAWT59bH4rvmRPnGRNQPgJh/Q1OWfP2HL2mhMoTGIc+kV6ApBh8U3?=
 =?us-ascii?Q?KuvNJ+sts/ViHdIrnfVF3YN35sNH/uurCoY23Rm5IoOc1rOJI0MJuZrzyKOr?=
 =?us-ascii?Q?dtnjqTuCXNW9epEB8BCGOv8GHSNwGPKWFNRXmKRGppJ1xlGD3h/V5NuVl2Nf?=
 =?us-ascii?Q?/ghbfcvEdbZ6y+83TFC+7E44OkxyNp45cPk6M0/CaZSRjj3xV6I8nHxFra8W?=
 =?us-ascii?Q?3rKbE8GAunnwwJm9/lxzNE7/RC7Z5XNW+u8qubTzWIs8oSmrcwpZWZkcBRrY?=
 =?us-ascii?Q?oKGbXMYNYR7bd2V7jnpVv9oTQ6YnwD/7NR4HdT3yszUNjFxFH24u8RC2MGti?=
 =?us-ascii?Q?kGouowF/qtDRTf7tDs/+qIFKv2zB38ISAwfi9H/C?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc238234-0692-4f21-cb14-08dae1abb2eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2022 10:27:58.3041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kGMGr4GHM43B+ItN5WwAuJsSd0IdrK29x0i/LytMTSj4zXMG6BkE70aEvxo7uyq4kqXGjTmK1nhK1en/VKHYKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8350
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
> Sent: Monday, December 12, 2022 5:02 PM
> To: Yuan, Perry <Perry.Yuan@amd.com>
> Cc: rafael.j.wysocki@intel.com; Limonciello, Mario
> <Mario.Limonciello@amd.com>; viresh.kumar@linaro.org; Sharma, Deepak
> <Deepak.Sharma@amd.com>; Fontenot, Nathan
> <Nathan.Fontenot@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Huang, Shimmer
> <Shimmer.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Meng,
> Li (Jassmine) <Li.Meng@amd.com>; Karny, Wyes <Wyes.Karny@amd.com>;
> linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v7 06/13] cpufreq: amd-pstate: implement amd pstate
> cpu online and offline callback
>=20
> On Thu, Dec 08, 2022 at 07:18:45PM +0800, Yuan, Perry wrote:
> > From: Perry Yuan <Perry.Yuan@amd.com>
> >
> > Adds online and offline driver callback support to allow cpu cores go
> > offline and help to restore the previous working states when core goes
> > back online later for EPP driver mode.
> >
> > Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> > ---
> >  drivers/cpufreq/amd-pstate.c | 89
> ++++++++++++++++++++++++++++++++++++
> >  include/linux/amd-pstate.h   |  1 +
> >  2 files changed, 90 insertions(+)
> >
> > diff --git a/drivers/cpufreq/amd-pstate.c
> > b/drivers/cpufreq/amd-pstate.c index 0a521be1be8a..412accab7bda
> 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -1186,6 +1186,93 @@ static int amd_pstate_epp_set_policy(struct
> cpufreq_policy *policy)
> >  	return 0;
> >  }
> >
> > +static void amd_pstate_epp_reenable(struct amd_cpudata *cpudata) {
> > +	struct cppc_perf_ctrls perf_ctrls;
> > +	u64 value, max_perf;
> > +	int ret;
> > +
> > +	ret =3D amd_pstate_enable(true);
> > +	if (ret)
> > +		pr_err("failed to enable amd pstate during resume,
> return %d\n",
> > +ret);
> > +
> > +	value =3D READ_ONCE(cpudata->cppc_req_cached);
> > +	max_perf =3D READ_ONCE(cpudata->highest_perf);
> > +
> > +	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> > +		wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
> > +	} else {
> > +		perf_ctrls.max_perf =3D max_perf;
> > +		perf_ctrls.energy_perf =3D
> AMD_CPPC_ENERGY_PERF_PREF(cpudata->epp_cached);
> > +		cppc_set_perf(cpudata->cpu, &perf_ctrls);
> > +	}
> > +}
> > +
> > +static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy) {
> > +	struct amd_cpudata *cpudata =3D all_cpu_data[policy->cpu];
> > +
> > +	pr_debug("AMD CPU Core %d going online\n", cpudata->cpu);
> > +
> > +	if (cppc_active) {
> > +		amd_pstate_epp_reenable(cpudata);
> > +		cpudata->suspended =3D false;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void amd_pstate_epp_offline(struct cpufreq_policy *policy) {
> > +	struct amd_cpudata *cpudata =3D all_cpu_data[policy->cpu];
> > +	struct cppc_perf_ctrls perf_ctrls;
> > +	int min_perf;
> > +	u64 value;
> > +
> > +	min_perf =3D READ_ONCE(cpudata->lowest_perf);
> > +	value =3D READ_ONCE(cpudata->cppc_req_cached);
> > +
> > +	mutex_lock(&amd_pstate_limits_lock);
> > +	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> > +		cpudata->epp_policy =3D CPUFREQ_POLICY_UNKNOWN;
> > +
> > +		/* Set max perf same as min perf */
> > +		value &=3D ~AMD_CPPC_MAX_PERF(~0L);
> > +		value |=3D AMD_CPPC_MAX_PERF(min_perf);
> > +		value &=3D ~AMD_CPPC_MIN_PERF(~0L);
> > +		value |=3D AMD_CPPC_MIN_PERF(min_perf);
> > +		wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
> > +	} else {
> > +		perf_ctrls.desired_perf =3D 0;
> > +		perf_ctrls.max_perf =3D min_perf;
> > +		perf_ctrls.energy_perf =3D
> AMD_CPPC_ENERGY_PERF_PREF(HWP_EPP_POWERSAVE);
> > +		cppc_set_perf(cpudata->cpu, &perf_ctrls);
> > +	}
>=20
> Could you double confirm whether these registers will be cleared or
> modified while the CPU cores enter/exit online/offline? I remember Joe ga=
ve
> a test before, the register value will be saved even it gets back to idle=
/offline.
>=20
> Thanks,
> Ray

We cannot guarantee the MSR values are not changed after suspended for each=
 BIOS/CPU combination.=20
But we can save and restore the MSR content for suspend/resume.
So to be safe, save the register to be restored is more safe here.=20

The key point is that, we need to set the core to be lowest perf when it is=
 offline for power saving.
And restore the MSR value after bring back online. =20
That is the reason why driver save/restore the MSR here.=20


>=20
> > +	mutex_unlock(&amd_pstate_limits_lock);
> > +}
> > +
> > +static int amd_pstate_cpu_offline(struct cpufreq_policy *policy) {
> > +	struct amd_cpudata *cpudata =3D all_cpu_data[policy->cpu];
> > +
> > +	pr_debug("AMD CPU Core %d going offline\n", cpudata->cpu);
> > +
> > +	if (cpudata->suspended)
> > +		return 0;
> > +
> > +	if (cppc_active)
> > +		amd_pstate_epp_offline(policy);
> > +
> > +	return 0;
> > +}
> > +
> > +static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
> > +{
> > +	amd_pstate_clear_update_util_hook(policy->cpu);
> > +
> > +	return amd_pstate_cpu_offline(policy); }
> > +
> >  static void amd_pstate_verify_cpu_policy(struct amd_cpudata *cpudata,
> >  					   struct cpufreq_policy_data *policy)
> { @@ -1220,6 +1307,8 @@
> > static struct cpufreq_driver amd_pstate_epp_driver =3D {
> >  	.init		=3D amd_pstate_epp_cpu_init,
> >  	.exit		=3D amd_pstate_epp_cpu_exit,
> >  	.update_limits	=3D amd_pstate_epp_update_limits,
> > +	.offline	=3D amd_pstate_epp_cpu_offline,
> > +	.online		=3D amd_pstate_epp_cpu_online,
> >  	.name		=3D "amd_pstate_epp",
> >  	.attr		=3D amd_pstate_epp_attr,
> >  };
> > diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> > index 888af62040f1..3dd26a3d104c 100644
> > --- a/include/linux/amd-pstate.h
> > +++ b/include/linux/amd-pstate.h
> > @@ -99,6 +99,7 @@ struct amd_cpudata {
> >  	u64	cppc_cap1_cached;
> >  	struct	update_util_data update_util;
> >  	struct	amd_aperf_mperf sample;
> > +	bool suspended;
> >  };
> >
> >  /**
> > --
> > 2.34.1
> >
