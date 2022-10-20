Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C1D60655A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbiJTQF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbiJTQFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:05:02 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8683341A;
        Thu, 20 Oct 2022 09:04:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fbBlIt/MwpCgGA5ljdsh9FjxaLGYW04XXRYpXqPW8+u9x4AP8dGjLPO/sFYV4aoBZ/XV1WB+6XTm3/ztF95RsEaCb1OI4GgRH+nIpXKRd+6Ai+i5jEM2u/B0ZEHAdwbAgr9k6ORBJfwPDj2RJ0JKaAFrVLpb24jbfTbI94HmY29Li2TxbGE960EQQi0iGJJ8gh2LHf1ZbcfWB0jZKlfRtPvAeVP62VOrmNwC44ZfUgQeIvFI8VF6SgYFIMHmkjEbZXyJ2vmlkBGQKNEKtcgZ2aGL2fLPTrN03UdO7klEAb9j0cSpjy5VxyFOofwpJ135OBgIzN/+nASb06eLKtv3Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/1ONv8Ktty5DsoCLfj8KDvKkCR5nVCQ641Dc6eb6xHE=;
 b=eceI8frubaUVQiP7szjse1frwnCnsQQlOeV6JuUFsfjFArq7bLYBX5xjWTYlNTStZES1run847I3NlD3DrnnRudB5yVHU6gUHCpBxbp58sOXnNOZIKuNdMQyadfUkyGFbJqz+18Vt0TWY4uF04vRkBEDAm+qIwk7AebL2qMjvmAQzFw73QrCPSs9/nUrCQg6ZA/H8MgU6YHEAyfo5G/R9IqIYm+Owb00Rz56+lVrVizdSmiPIxpUn8j0uGtUkt3yrBYHNTq3RnvdaY+moGowFTT1QZZJyACbMIoNJZZoktjuRxQmkB2l2rSzhblu+tZs0tIJbfP309SYCsEHF8EmsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1ONv8Ktty5DsoCLfj8KDvKkCR5nVCQ641Dc6eb6xHE=;
 b=jICTcqLGphoj0Yq/ZP+1PNXKoUKw4wlUSjxQo6UKRk4O71vVinTeUfpBTgTslXmu0EkahonBnHFO+hJ+DGGmkgIPNLD3ymEfZHTnlDwx2ZtGrsLDpZ4y0zWudAGoSvUZgp2Hy0Uo1lRxvZFbBY1dlkaDAPSjaIjZRo8kaK2RfAY=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by IA0PR12MB7601.namprd12.prod.outlook.com (2603:10b6:208:43b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Thu, 20 Oct
 2022 16:04:26 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::3bf0:6f5b:fe42:4149]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::3bf0:6f5b:fe42:4149%5]) with mapi id 15.20.5723.034; Thu, 20 Oct 2022
 16:04:26 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     "Huang, Ray" <Ray.Huang@amd.com>
CC:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RESEND PATCH V2 6/9] cpufreq: amd_pstate: add AMD pstate EPP
 support for shared memory type processor
Thread-Topic: [RESEND PATCH V2 6/9] cpufreq: amd_pstate: add AMD pstate EPP
 support for shared memory type processor
Thread-Index: AQHY3MSxpFudfW2z6kud+yIApakAX64SdDYAgAUMwPA=
Date:   Thu, 20 Oct 2022 16:04:26 +0000
Message-ID: <DM4PR12MB52781C923DDA85CB93F7D3129C2A9@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20221010162248.348141-1-Perry.Yuan@amd.com>
 <20221010162248.348141-7-Perry.Yuan@amd.com> <Y000eLQY/nKqiNFZ@amd.com>
In-Reply-To: <Y000eLQY/nKqiNFZ@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-10-20T16:04:23Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=19589e05-c916-47b2-a6ee-6b7ed5c0dba2;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-10-20T16:04:23Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 3be10aa9-a272-4dbd-afac-fe84c8b11b6b
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5278:EE_|IA0PR12MB7601:EE_
x-ms-office365-filtering-correlation-id: 6fdd5ab8-a314-46b4-0082-08dab2b4c2f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pvCeo6X/goIWVnZjGnwv49LbG281wSWx36FGK/udgu6lOySaZJ71GC4Z337yg0CxG6cxu8H4ujTfKHskOpWnL8nEhoSpBcT7GxdjSb+Szy0pPOSyOiDreEO3kppBWtPbhzDiyl1+JJUQVqk2LaQCA8YmJN0mnZS2gBbudnjQtuujpOy72hSNWTrnfUmUbwKIIc+EsQtYTK2sK3vS4LN6+vkWT+oOf+jC3ZpGIkEHA34606qu9kIE9YeKPJ6n6tEZ8yrzVzXNeer0TbTLC2Z556T+qOJ4nbY7czJ+c7PCLvwcejDxO9ihBalWgUtucd8Dpdju1V6klkkYcXBqcRMdKrju/kTDfOUlZ3pA/HmogDOHhPzbJX6yOioZHsyGvXwEWslLtAIs6Fw5R32NGBTW2lKmPXXg2vv7cC/5l+WCy1e3nTCDqG2T5bI9xH8r8t/3iFFMjb+nDx/hPgK4v7dYDIOwkXtEh4aoKwmjZTKfHeJfZKS2ZRjcp/GjIHB44KhEeTwHo9EN6vEi/kbkm9ln7pH/r47qYg9dtQRaSw5wg2wzNttWtd3dWNuHdgbWaEiTwxnjScaRalUZSiEV+sYWvS6Ktz4es/fFi2dVsxG+ju5BvnBWFRfElUmjs+xXp7rB8vw0twpxaC7f3Vn75Hu4zC0/ILo9EKrQDHKuG4LRfiMKsGt5yx/EVEbqAIdinE/TUyI3eUz8OM9HcdSxlxeyPp9PWGnvKh4uvXgJEY5CD7nHu0Z3bloyl0LBi9a8LbNVlq4EKpiDRIcL35qnsWWyyQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(396003)(376002)(366004)(451199015)(9686003)(122000001)(33656002)(6506007)(38070700005)(66446008)(26005)(7696005)(2906002)(4326008)(86362001)(8936002)(64756008)(6862004)(5660300002)(66476007)(8676002)(41300700001)(66556008)(52536014)(38100700002)(55016003)(76116006)(66946007)(83380400001)(316002)(6636002)(53546011)(186003)(54906003)(478600001)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?N8s36fHO2NZIVyYX4QYKS3EuNxFaAmcCru66Kffd817bWCg66h6o8b0lNU4I?=
 =?us-ascii?Q?u3wfO22bTfGHZ3r0qabQ5rv9nYbEsHpECnr+jfwbCahmaKaiZNDacSxhh/L9?=
 =?us-ascii?Q?fCPg5O5WfbsQX3iHz/zaTln27Nn9cTRCMLtbZaAZVwUIGKoDwQKDNPsVNnsX?=
 =?us-ascii?Q?E4hstwW+1OSGYvqCvK19lxbzPwMgBbTO/AiClbEjLGkd62njn3yv2CSFpaB0?=
 =?us-ascii?Q?2ZEEz4v3F4rCJD5iWKbsAfb+80764qU7xEUvNjm20vCaGo+dGOO7ncsCcuSV?=
 =?us-ascii?Q?pTiUPu/lVkKX3BSm+9DJ+4BzM3aLtE5eJPOVDSzep6fLc3pVwTC/rha0Hzy5?=
 =?us-ascii?Q?5Ilk2jVzJF5HivAf6s/Db2DR9pRqIiIxOZ+JMRgSCPrJPVUVPK3HIEiJT46R?=
 =?us-ascii?Q?7DhvUUr3XFBF9MB2gckN+vQ0cXQK+oPyS1Xafyo+EPCTf0Hve5zOh30pRR1k?=
 =?us-ascii?Q?xiKniTkd4VdN2t56HamjTS7qzaHfc8iQyUFNHuR3TH4BITccEy3LmYT5Xe2Y?=
 =?us-ascii?Q?HGY5n9vTz5t/a64wgoXV+Pn0AsRtrUmzg+ye73XZ21tb7kgSvdhpPyolz7cq?=
 =?us-ascii?Q?e0sQNsr8hdO6WnkWl0mEWk1fIrraGNhx6wwdNtdG42oHPzMABe43WVoNfO88?=
 =?us-ascii?Q?sbOvQ1eoeh3EHp//J2BMJ6U79XD3j8X/DaO8Bbv9YfJ4N9WOcqeydA5BbPF2?=
 =?us-ascii?Q?77FRYPIBbSO1bPCRXTMXdWCW9k0BwZDArZCLTVJQ85PiEsPetXpuCYfoX6t4?=
 =?us-ascii?Q?7dS+3PzFfekNB+XwCSSmWjyEo8qfnK/fWJHDDpkRfSd0Ozm4ugxDTjHeLdgo?=
 =?us-ascii?Q?HR6fPkwJc09Tx6L1JeHnd2MSKXTTPtqMhUib60IhjGyEmLKRG+hrA041G8dY?=
 =?us-ascii?Q?PrI4hdWllSDBQeaovA6OwtOex2HYwy12QYqie+VnZG4DgX07JL96XgXmkOT3?=
 =?us-ascii?Q?MHuHH2xvYXyQZFq93HGpqACmNo/W3LTzVkvouxx7sWXHV3RWsvPrnFyltj4U?=
 =?us-ascii?Q?hZh9F3rVTQKMgqQdmdi7h1i4gxo27ker0Ijjl7VLU4Km9/WhpFlG85IEe/PZ?=
 =?us-ascii?Q?2UZNc+9fOMUGgaVvnl98NAB3lmdwpRusA6EiHoEqszJAje37wmB5ijpvKp5O?=
 =?us-ascii?Q?sgJw/N84oKIRuMlIz/wf+ZFfaH9jsCDYzxc4y0RJ4jpnlLpsiVecExv4MjqN?=
 =?us-ascii?Q?Iqiiw4uGOo9yUEIYbgx1DRCZHNz7OAoKqEobSTRPbQIrgU2/XmugwacX0i1R?=
 =?us-ascii?Q?nw2iwTKU/1sPU8ue+nTdLjrGu85KSzCavE85oXQ7o5srKi6v+sITh4jXdXUS?=
 =?us-ascii?Q?fme4rXoa1zXlS5mbYgPSdbXbmiZ5HCjoUFWlpu6iqM1AiS1eE6c64nfxewZH?=
 =?us-ascii?Q?avdAszskhysYKoIVpNq+C3D1tFfqVDhgoaiBqEGJpOEqrTvynDT/iQCnHfPR?=
 =?us-ascii?Q?XjzVsFX3bdQFr5bmMjQhBsW6bvVbb9ndo3IzilMLjecco78aSQ0OWvBpt0s2?=
 =?us-ascii?Q?INDNwgvg5zSk3NCkxLiipcd9VBSNcQWxcp+8Kd4RXyvmtif/6tXwf0Ta67S9?=
 =?us-ascii?Q?wSqWWmhlldRw8eZtxyZbYS+XV8KatOj3+j3swlmu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fdd5ab8-a314-46b4-0082-08dab2b4c2f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2022 16:04:26.0702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8tFB8+jJyrd0U7NePw0STZaIrnPA/9/lU+7n2e8z6Ty5t0HmZCe7pTJ4Gbv8vqutXG/53pV5XcPTZ/z7jEaw9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7601
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]



> -----Original Message-----
> From: Huang, Ray <Ray.Huang@amd.com>
> Sent: Monday, October 17, 2022 6:55 PM
> To: Yuan, Perry <Perry.Yuan@amd.com>
> Cc: rafael.j.wysocki@intel.com; viresh.kumar@linaro.org; Sharma, Deepak
> <Deepak.Sharma@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>; Fontenot, Nathan
> <Nathan.Fontenot@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Huang, Shimmer
> <Shimmer.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Meng,
> Li (Jassmine) <Li.Meng@amd.com>; linux-pm@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [RESEND PATCH V2 6/9] cpufreq: amd_pstate: add AMD pstate
> EPP support for shared memory type processor
>=20
> On Tue, Oct 11, 2022 at 12:22:45AM +0800, Yuan, Perry wrote:
> > Add Energy Performance Preference support for AMD SOCs which do not
> > contain a designated MSR for CPPC support. A shared memory interface
> > is used for CPPC on these SOCs and the ACPI PCC channel is used to
> > enable EPP and reset the desired performance.
> >
> > Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> > ---
> >  drivers/cpufreq/amd-pstate.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/drivers/cpufreq/amd-pstate.c
> > b/drivers/cpufreq/amd-pstate.c index 2d28f458589c..08f9e335f97c 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -135,12 +135,25 @@ static inline int pstate_enable(bool enable)
> >
> >  static int cppc_enable(bool enable)
> >  {
> > +	struct cppc_perf_ctrls perf_ctrls;
> >  	int cpu, ret =3D 0;
> >
> >  	for_each_present_cpu(cpu) {
> >  		ret =3D cppc_set_enable(cpu, enable);
> >  		if (ret)
> >  			return ret;
> > +		if (epp) {
> > +			/* Enable autonomous mode for EPP */
> > +			ret =3D cppc_set_auto_epp(cpu, enable);
> > +			if (ret)
> > +				return ret;
> > +
> > +			/* Set desired perf as zero to allow EPP firmware
> control */
> > +			perf_ctrls.desired_perf =3D 0;
> > +			ret =3D cppc_set_perf(cpu, &perf_ctrls);
> > +			if (ret)
> > +				return ret;
> > +		}
>=20
> This patch only writes the desired_perf as 0 to enable the EPP function, =
but it
> cannot be an independent function or patch without the dependency of the
> next one (patch 7).
>=20
> Thanks,
> Ray

Do you mean that I could squash this patch into Patch 7 ?
If so , I will get this into V3.=20

Perry.
