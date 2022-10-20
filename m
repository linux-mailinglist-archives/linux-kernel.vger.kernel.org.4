Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41EE1606538
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbiJTQBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbiJTQBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:01:13 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2B15302A;
        Thu, 20 Oct 2022 09:01:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BgsBc9HhbQs6mqwDYhE52j8j1mLLQN4vJbat/45jdy6rRuM141meS4DlF37rGW2OLlLSddRIcSb8nu3YM64r0sWz3MHTmEh3bdmcO77fym+o6CYHg1jOaXhuXTxLGgqxuHQ1A9KWteSLcRkXwJlH+wimAT31vZlhHzCIENy475CeNKe2KLuxXx6ODAr0pRjBRodUQnHo2W3T7yBbnWWErmE44X8UMOsEZa1rSG7YoU9stQcIAURy4RFTPHyIpEXxEuZ32+WF3XdOdzEkAko0LrLdv3rxObywyTaQmweodqvcSyNTyxZ6cSDvqm7Gssi/wngIgUCcRX2MNlNLAVW12A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B22AcLTbzVnxqcdHJcYT0no7oEYgezA5HeyiPq8ECYo=;
 b=ktcRjLURNPuewRw28VrjPg6586BWHmX1mKqRG+2aQLxVMB6zFw6tMprRZMtqXzuAKR933HgMk86lE8BGQdk/Ozk8T2n0neQJbnbRNEZi78tGfSI3yDTQ7unl+bx3lOYZQTpTHbXp4opUMXi11oYZE9bDVcnNzcZiKFVrB+sLsXcrUZxG6+8kngRKhAtuf+2d/o0ftdvfzJgEc+EIecJ6LoPKeaViOkBEM+r0FYb47QdxBJcEUREe/Wc/nsCjHizuX3HUz5kxlLD9OZwSHZy1KQnnFegb0CI03wDQvRLluOSBUDv7Cd6qCvnpvk2vIuxdAoosnGk39NY/ch9uBov0wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B22AcLTbzVnxqcdHJcYT0no7oEYgezA5HeyiPq8ECYo=;
 b=c6pH7OxzSFd/DDzM8uKMQOcru8yr4j6o9xmt5h+Mo9R7zGf9keGXSLH9lpZImhL1mPrmc4QF1Phlx0oLTTLqMzqnToG2S1JGQ87WZQYJKqlpTWKjR9P9kiXnMRmq6UdhPvDebzC7JkPA1hsKbvrHLUlBq2pskS7nWTwv1VSpG4w=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Thu, 20 Oct
 2022 16:01:09 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::3bf0:6f5b:fe42:4149]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::3bf0:6f5b:fe42:4149%5]) with mapi id 15.20.5723.034; Thu, 20 Oct 2022
 16:01:09 +0000
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
Subject: RE: [RESEND PATCH V2 4/9] x86/msr: Add the MSR definition for AMD
 CPPC boost state
Thread-Topic: [RESEND PATCH V2 4/9] x86/msr: Add the MSR definition for AMD
 CPPC boost state
Thread-Index: AQHY3MSt/PlF0KNBQ02nB5ERDMK6Va4SZAsAgAUbdVA=
Date:   Thu, 20 Oct 2022 16:01:09 +0000
Message-ID: <DM4PR12MB527826BF143D69100305B1A79C2A9@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20221010162248.348141-1-Perry.Yuan@amd.com>
 <20221010162248.348141-5-Perry.Yuan@amd.com> <Y00m6Fm6AKqh65Fr@amd.com>
In-Reply-To: <Y00m6Fm6AKqh65Fr@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-10-20T16:01:06Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a4a59061-ebe0-43dd-bc41-c69ecb678add;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-10-20T16:01:06Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 205c12e0-30a8-449d-90a6-f4ad0c82ce5b
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5278:EE_|DM4PR12MB6280:EE_
x-ms-office365-filtering-correlation-id: bede2e3e-ca62-43fc-e2fe-08dab2b44d99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /UMuiCpqyVuWoD5GEgFj5mhWOXLHdnKa+kTPCw4U3sSgOlMVJfR49eYmlUqKgu1IUyskc1CGIXIG/rw68pQuPrj0Mq7VxNR2dnKAsEtqNNFttJw6Q0qlt6wXQ38GMbCFAmOdG5J7BwMIqQ/oaZ+Skao9REdohgH0wMURzCv/rGxNL7L4UNYoV0st6UxdE287chq8nVK4SuuLn2zDFdHyo+Kp3yt5liwJNRleScYh3Y8uiEIXvRUq5M+ZtK1NO4CjuAlfQA2COvXyxaaEcjd1ofCsrPh67+xRbiB1LgN4q2rzo2HODEc1TeyuKPTYr8TveoqvTBySi448jDCKljBEuGfq4b7l4zu/AmdNXBVd5XBR1MloD/VUoFRaAzD+RuwHbLsT1F4Y8KFBLJxQeyHxNz2BbgIL+4hzHtn+VXeZYJk2eRoto2rsBzQhMPmGGSicPA7knn5IF0PZABDcBry6Pqtc7LBupFCHRdP0+mKRBSZtJw2UtQCve81VnoVwIvpuqhtk1W7spxp+prttCmb+9qTqESX9gnSoH+hpr5y+HBPSDwc3tww4gotw/gJO1h3h9D2sTeGuj8YwwlKbtKTW59LVlndYeaMxzhuBIYD2+6XWgL+IC3tMyVYJ/ZKaZenCoxATh+F8IPXkaiIaX6W2mafjzq1AGtxQBEeGvAk6DKr+4rgFlfibh/44F9ipz8HF6wSC5nb2Pdjn0Fj5S03ZQjcald6tJpvZ8fkAU7HgigR77YliQWYH4q2gzh08bvyGsVdyj8TG14z7/byKsbNDV5wPStHfK0uAxfFXJIj+296zq9kUwM9ovlv+RfiB0f0jR9LB2ACHqofWUL2hHzNwMQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(136003)(346002)(396003)(39860400002)(451199015)(8936002)(6862004)(5660300002)(66476007)(64756008)(66446008)(6636002)(4326008)(52536014)(38100700002)(66556008)(8676002)(33656002)(9686003)(2906002)(122000001)(38070700005)(41300700001)(26005)(86362001)(7696005)(6506007)(966005)(54906003)(53546011)(71200400001)(478600001)(66946007)(76116006)(55016003)(186003)(83380400001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2XXc69Rz/HxI+OSRHtYv1fWLfYcrLqlHrZvk2ni+hCuX/vZUIpEyDXuRQzPn?=
 =?us-ascii?Q?oPyt/DkAHQTg64XrWt5jhRbeLqoc+HY/+9C3tMSRZ32zlVeJOlxtfhKSIT3m?=
 =?us-ascii?Q?/7WpQM0YDiq95W6/FfCkBLoM40/AfsvYo98CPMLE7KxE02LYMNfLfXQZUuHx?=
 =?us-ascii?Q?2EwOGPrtH0RMPo11ABtOifE+0HRETJHsSX+rbjiEr7qrKaR+yM08AMpf8aN5?=
 =?us-ascii?Q?1nymJ14nZYPTnS7cLqNA1XAXMo7muGMpxQOGlPrCV4Q5cjLCCBy44nRr8Nk1?=
 =?us-ascii?Q?vXQE15Y200r+A/qRWCPObUpc1iWjBHtxcxyfiQKfm+Pd+bnGxZbCekmrsLtN?=
 =?us-ascii?Q?pdl82y+ZTwfftqgAXhLMGh5qnd1HhdRsCxC27x+4U4YNDl1X/hE7AAxySE4S?=
 =?us-ascii?Q?csFswGt9LokGcwO+KK9VDpQH00jAs963+TgmKuK225Z8hD6p6wM+9Ydkm5qK?=
 =?us-ascii?Q?2cmW5klzqI257VBtdKsk9EA2gCcwfrK45V8GKgwPMr4XgEJNTsHyBwJfJPdZ?=
 =?us-ascii?Q?N9IK+4Q91/D6TgUB8cB9O6yYB/Cm94aobKXNGjJVqWtOzTDVqbMHAbD+/lZd?=
 =?us-ascii?Q?EUJP//uovV7QzxifZSkMPhhRVWGnX/LdqxbeZ82qJz/rAK5del2qYAm+asAJ?=
 =?us-ascii?Q?MVmI4udm9XkhOWxZDxxkCassLzY7yAYKpFB77KU9wyQ5V/m3d/8b3rl8Slte?=
 =?us-ascii?Q?kuV4lu5VmFn8bEZwc8SJ0L2aRKM0Ta53/LIyEud6Ovqq+eE1/yE0hxQ4mfJB?=
 =?us-ascii?Q?xe7SfhkS82/7Z1Ju9kSdLBZAH+Tm/s6RfNxyE9SCa7UxPssEbTSyYBoA35ql?=
 =?us-ascii?Q?R8OvlPsZMAu4Ai9W8nyJeCz7a8hgAwusQhMELc93VM3oDy0fNw6/pyU1AlIZ?=
 =?us-ascii?Q?Nk0XJlqImN6WnpU7IVylykr90U5da6B4oa5hGZYsTR52BWhb8+YdUpWwnKeJ?=
 =?us-ascii?Q?CGLXuPXeSkQu6niwvajLkSAqU7demVsj69HkZ6Qh+ZKanlFRXtZt0+HizDQj?=
 =?us-ascii?Q?YcOOqwzUcxJs1E/OZRs9gJhJ1iNclWClhP3iIxNXNvNgS7Wxfe4pSny9Su4u?=
 =?us-ascii?Q?qhTGRqFugGc07J1y3WbY79sar6WRBbsT8gAk8qEGHFaCBQqoC5kBz5yBWu73?=
 =?us-ascii?Q?jHrqErAkgdzJs5BDy7eiFah8LEFARfOlTB3Wlw2ywPmOo2hGk1Ym8qFsVp1r?=
 =?us-ascii?Q?xx1Ffr8r/v1U/n+loEM9R2UXxveLHSpgIBl6Fmqlmuy8Jj/b9zHpRk0qfWOf?=
 =?us-ascii?Q?5VKaqfiqNkWM8uhp6TA4KvCIv0oj95CZrmYT1sprbyZNUPE33OON76dfbOAj?=
 =?us-ascii?Q?Rb3KbpDc9xHW71XFkJif5zrBYl1vjiXJupqW6cUY/+rBBB7F/T3h8k39cvUd?=
 =?us-ascii?Q?Ez3NLgAOElZ3rHoOmpqo60L9WacJqtcWtk5/T7eL8w92okN0GqRPnzrcAM7b?=
 =?us-ascii?Q?OAdgs+gkGJngpl2ehzr1AP2Wmo4z24+F0iatq88e57qI8rzoSLARxS+SDXPd?=
 =?us-ascii?Q?znaOYk/mskgF2oDjuGhAJrRLDtpGOwAoVpoyD0W7ghxlkQB/S+X2/F+hHszI?=
 =?us-ascii?Q?UhSBm19hIw2pu/hh4LcjsQ16waxU+dsVBS/nWVMC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bede2e3e-ca62-43fc-e2fe-08dab2b44d99
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2022 16:01:09.1666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YvTkxx8BziWKN4leGYyk9aoYH6SfrUIq9v8x2ZkQgrzqSpz4raG8hYm9mUUa7sLzF4W5115bINvhQ/UfFnKAOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6280
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

Hi Ray.=20

> -----Original Message-----
> From: Huang, Ray <Ray.Huang@amd.com>
> Sent: Monday, October 17, 2022 5:57 PM
> To: Yuan, Perry <Perry.Yuan@amd.com>
> Cc: rafael.j.wysocki@intel.com; viresh.kumar@linaro.org; Sharma, Deepak
> <Deepak.Sharma@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>; Fontenot, Nathan
> <Nathan.Fontenot@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Huang, Shimmer
> <Shimmer.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Meng,
> Li (Jassmine) <Li.Meng@amd.com>; linux-pm@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [RESEND PATCH V2 4/9] x86/msr: Add the MSR definition for
> AMD CPPC boost state
>=20
> On Tue, Oct 11, 2022 at 12:22:43AM +0800, Yuan, Perry wrote:
> > This MSR can be used to check whether the CPU frequency boost state is
> > enabled in the hardware control. User can change the boost state in
> > the BIOS setting,amd_pstate driver will update the boost state
> > according to this msr value.
> >
> > AMD Processor Programming Reference (PPR)
> > Link: https://www.amd.com/system/files/TechDocs/40332.pdf [p1095]
> > Link: https://www.amd.com/system/files/TechDocs/56569-A1-PUB.zip
> > [p162]
> >
> > Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> > ---
> >  arch/x86/include/asm/msr-index.h | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/arch/x86/include/asm/msr-index.h
> > b/arch/x86/include/asm/msr-index.h
> > index 6674bdb096f3..e5ea1c9f747b 100644
> > --- a/arch/x86/include/asm/msr-index.h
> > +++ b/arch/x86/include/asm/msr-index.h
> > @@ -569,6 +569,7 @@
> >  #define MSR_AMD_CPPC_CAP2		0xc00102b2
> >  #define MSR_AMD_CPPC_REQ		0xc00102b3
> >  #define MSR_AMD_CPPC_STATUS		0xc00102b4
> > +#define MSR_AMD_CPPC_HW_CTL		0xc0010015
> >
> >  #define AMD_CPPC_LOWEST_PERF(x)		(((x) >> 0) & 0xff)
> >  #define AMD_CPPC_LOWNONLIN_PERF(x)	(((x) >> 8) & 0xff)
> > @@ -579,6 +580,8 @@
> >  #define AMD_CPPC_MIN_PERF(x)		(((x) & 0xff) << 8)
> >  #define AMD_CPPC_DES_PERF(x)		(((x) & 0xff) << 16)
> >  #define AMD_CPPC_ENERGY_PERF_PREF(x)	(((x) & 0xff) << 24)
> > +#define AMD_CPPC_PRECISION_BOOST_BIT   25
> > +#define AMD_CPPC_PRECISION_BOOST_ENABLED
> BIT_ULL(AMD_CPPC_PRECISION_BOOST_BIT)
>=20
> I had commented the MSR_AMD_CPPC_HW_CTL is duplicated with
> MSR_K7_HWCR
>=20
> https://lore.kernel.org/lkml/YtX+uF/nAIG0ykHN@amd.com/
> https://lore.kernel.org/lkml/YtX586RDd9Xw44IO@amd.com/
>=20
> Could you please make sure address the commments?
>=20
> Thanks,
> Ray

If I rename that the MSR definition string, that will cause lots of driver =
file change.=20
So I suggest to add one new MSR macro for the CPPC, the MSR_K7_HWCR is  mis=
matching in the CPPC Pstate driver.
If you refuse to use this new one, I will reuse that old one.=20

Perry.=20
