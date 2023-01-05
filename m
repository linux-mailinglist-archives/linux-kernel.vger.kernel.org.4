Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259AA65EFB0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 16:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbjAEPJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 10:09:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234252AbjAEPJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 10:09:10 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200C15C1C9;
        Thu,  5 Jan 2023 07:09:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dDOLb4ygaZ8qCELgPEQXNX4ZGP22MCwznXyYn5vFDggcsVbrKKm2ClNh69GLyIUOUGqY3HRFgkU749H4sEjaMvMbCJ5EoJxgaCq/XjmCUAsP/xbabt/Ms9YruPrS/x3i9XbTg8Pix/JFM8/nL/Qj5Pd5hwoJ/q2CA+YPSN2jbkrk2uP7weR2kegsuOikFfdAP2X+DWQRedWmCpILrFocfERLj1ekmEsA03zj15ijFlfVhMec4erWA2iAikty5H779qTQH/JJRMPFnefiGEJ5Uzj0/cK0ig7ITCfpW4XdjDliJyTbozXv6SMyyDKidT0icpds1BV4pvaIUGCfB67Ymg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ees2hQ+Rmb/rhxA/sxJJoUJN6S9BuUAJYgv8EMK5cAw=;
 b=O3/akVrwy68n1tL7fWww2Sb79XZqnifiU8MB+6rxJCDiJWp4h5a941Z498zLK4arAkj5eC7RhtBVLhfbIP+R/nS/q8VJd0sdL/4g0dnfKb3XACXt5agAaM/mdP14hOCgfIDbXQqYbH+tURTd3F2SNAqoD96IAbAKEsuzlffFbTnxOTwAs58P6r757/W+czCHv6Pmt8ouTaLQdYddQYanmFCcZ1PbBl6qpJh/oCuQknJTydZOOiaAACbplfr+2JLPGSut9SZqbrnc1Vh0fM5mPoTWGe9+6GIjYYQW8cY7pFXqEe+O8sQ5WgDW0+VfCA0oPktYEhYG8fpFh7DvyP4dpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ees2hQ+Rmb/rhxA/sxJJoUJN6S9BuUAJYgv8EMK5cAw=;
 b=LFmdVjMRAn+vhWgb4BAgruzUogFwt5T6707D6nVRggP4T9D/SnsDY5WSQhczf5KtKg9XogIOeAHOeGGyPeqq0BNI7IPZ7w1VK0MmcCuJkT2gEbjB4iiewYt+VEg2pVYwa+Z27r26+iKD8K1NebJodlrq4W96I24xFJMjD/Xw6k8=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by CH2PR12MB4263.namprd12.prod.outlook.com (2603:10b6:610:a6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 15:08:58 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::960b:6963:b27e:f9ed]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::960b:6963:b27e:f9ed%8]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 15:08:58 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>
CC:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "Karny, Wyes" <Wyes.Karny@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v9 08/13] cpufreq: amd-pstate: implement suspend and
 resume callbacks
Thread-Topic: [PATCH v9 08/13] cpufreq: amd-pstate: implement suspend and
 resume callbacks
Thread-Index: AQHZGH8OUW0eOYfoXk6+O7KzViQfyK6BC3CAgA7qLcA=
Date:   Thu, 5 Jan 2023 15:08:58 +0000
Message-ID: <DM4PR12MB527827691DAD904349E425519CFA9@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20221225163442.2205660-1-perry.yuan@amd.com>
 <20221225163442.2205660-9-perry.yuan@amd.com>
 <20221227025211.jjkmwtwg6whgavgd@vireshk-i7>
In-Reply-To: <20221227025211.jjkmwtwg6whgavgd@vireshk-i7>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-01-05T15:08:55Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=228eb544-f987-4839-8456-cd134b4d5264;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-01-05T15:08:55Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: fb658940-fa18-451a-ac6f-743542cf78c8
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5278:EE_|CH2PR12MB4263:EE_
x-ms-office365-filtering-correlation-id: 7f9c2176-e26f-41f2-2fc8-08daef2ec57a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NBY2fNRQJDIMgM2tEjfwlQFgTjhBWhJYEHNJ1vDTcJn9w5aGmwACr4/nqYVddUKk4bRi86jSMBM2DOZsbxXbw+mEPCewNzJK8OHFKaM16Zzrh6hHe1y7pmY0sw760Cx8YLzh0y6kYbRolLVCfCasT7FJHu7cAT+SElJTdNe7ol+yyQ+Rwna3FtKUcBaEZAMVWSNfq/660Ks1mOJkLXXdycshavzMIivM4EvnSaVWjWUHxhbk0xsxvbED5esbcNRzIs7vTtYUUq/aGTR7N6msIjjZKVcHAj21GMYBRrV3+XrNkEGa6iR5gFetnV+K9SEZVncwN9VRDLXUIJonILJWHw3rlgMxV5oweTn5xi2SEaUfvgSRtlZIJVhlaUBV+qE3Lp5U/4nflukqvgw0yS1+sN3Xox1VzudAAln+eGt0joWOvdY0yRKtVL+192SsGwmu+WFpkzCQsiAhsjixdSVVvMiWPtMEk32a6/E1UyIF39jd0GkOQm0fjzi1XLUjfFU/IHhjnQn2l01qBWOA67JYa6cv4KdJJPLI2JroA0MkCckyjBlcV/4+0crMtUeV0o8h+Ut8iJEdH2p65hF+UD7N8l+sO7mqeo69rDxgkhzAGqaOOI1GQODZ5r5kdYi0ohNqbVjGs45chDLMn+voTY6ej/jawdsc0b1XQFkOaEc7NZ70qNoh0d47hsFZG/l4TsAxaWokCp5NEI47fOX2Y4q6Qw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(451199015)(33656002)(86362001)(38100700002)(122000001)(83380400001)(71200400001)(26005)(9686003)(53546011)(66946007)(186003)(66446008)(6506007)(7696005)(478600001)(316002)(110136005)(66556008)(76116006)(66476007)(54906003)(6636002)(64756008)(41300700001)(5660300002)(15650500001)(4326008)(2906002)(52536014)(8936002)(8676002)(38070700005)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dRk5nEc7GolQXk2vXk0ZzFvtpnUCG2f6NOXNYjnOaDtOb7IBxGFkqk//s2G6?=
 =?us-ascii?Q?a99dz5ZWO1FTIpUpagAqsZNnw2OCDQgeCxYLBU4OtnAxJbDBZvtlA0L5u+rV?=
 =?us-ascii?Q?jISBHl8pKo0k65G+6Q+wuwmXDvBdt0zly9uXK/vtVgDF0R/oWsjo7p1dqLse?=
 =?us-ascii?Q?pnie8UQYuDT533KdjC1EUb3ayuRpeWf+If9Lk1JIGFtgTDj8euCf8ki8Grwd?=
 =?us-ascii?Q?1XndHDDxwz1g7hyElyyBJVr9fkAMYrTCTRbn7nP2fgMgx7ZsOcuSZ3n2Gzwc?=
 =?us-ascii?Q?nGquW48SOt5zS/VmGVKktKahcJcDUfxd72rH3CTJIsMDpLuQ1mSCgnYaceLU?=
 =?us-ascii?Q?rXHqfLuYWnodL3buH5+mdLlrrI0j7BLpOR0zF259xJR8KsyEHHA5h1ej40ts?=
 =?us-ascii?Q?f/W2e4SrE3xPxLioFhTzKXz2SpxF8G9YvgPPrltv5MOu2IKfGBNHgUm0ozJy?=
 =?us-ascii?Q?HBRXLwMihi4B87L5nr/pOBKPMh48+wYqQoLX/X0oyq53ulUnL1fKxaHDzeS/?=
 =?us-ascii?Q?aG8ADaisBqUwTg4QU4FCSRQaILd3n5Ma3whQ1xpLbrsYcRjTQVDzp1kv3cPQ?=
 =?us-ascii?Q?Klv/754Zy7QyO1ebTZPyYrMalSvCtKAI5o83iDAhUKt3ng685wLssddWHmgU?=
 =?us-ascii?Q?BZ0+XpD1U7DvJQVqIiV2BJpoybOpVjUzQ2b6GufRSPQqLLmpWYIOB5iPihFr?=
 =?us-ascii?Q?Wc84ULWSQIzKg7vVJ0rD9rEqWIPryJ+JlauYlWXjKyLS3nSW6ufjT3MQRngI?=
 =?us-ascii?Q?I2RzhB4DOcTXkvqwqlUO4Jf1538BQORY5+i+VvTpRUZ0BheD+zFvm/JUZ2pE?=
 =?us-ascii?Q?pcwtP/jF5o4f00e87fdK4RuH6pegxgpuHJPfLxlXEurBEPku8F2gHQyiTAod?=
 =?us-ascii?Q?S0RIegHp9PzGd4u+TIGFQccolVz1LOVojLOjk2BRvKYWvGSv7DMiAiE57noe?=
 =?us-ascii?Q?v4taQkg2ebV25VGO0ReX0CkX7+rStA3W8s8ryFrUW/44feBqRzozPIAsk72c?=
 =?us-ascii?Q?x2RN/uiYvWSkWwSVSXcfipDVN7XZDWItDbSjn0+T10WjBJ7ZYpTGgt1VR85g?=
 =?us-ascii?Q?APDKizsulfVBEJgjuhs+MSR7rjZ5L4XZK4PThK9WX7MQkZ6Uh1jP6gLzqAFB?=
 =?us-ascii?Q?XZzFG9KXfg2U6k0cpMYlN3SrRrRCKnVmKh2rt697ERzlfBoErmzvUIcyXYuq?=
 =?us-ascii?Q?IszLCWPnNWSngU/7q7qXXAcs732IrS80g7fzziIxyDKW/KBPQB4XPJzKzf+5?=
 =?us-ascii?Q?bxOGK8NYXzFkUnsGEvwAKIrkQtsJ9I2/G9XZ45vJk1fsa0Jnt9GvrSCGl5rP?=
 =?us-ascii?Q?8JRlFIFoi346ddzGTOmKONTgcDgEuabEMiLj2PK+J1XOu/lkeM0H3hZujZ0V?=
 =?us-ascii?Q?1GLpX5myZKaihpgadorI9Gn+uBcdHufr9VQ1Cnv0J6doPwk0/Mspa/35fxD6?=
 =?us-ascii?Q?9xLbtHGLDWbT5ob20f2lMFIGPobslvfr0qvRhn0hSxolNHpZYOOcXX7zVpsM?=
 =?us-ascii?Q?LITzX64e5i3ohaxsbdlSC0Z6OYYyZu7ZliF73f1m9jlY3jGEGNCDkntjvpKG?=
 =?us-ascii?Q?1actppesWjBLcoib2RiuWCIflDCDjmf+hN5pzYXv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f9c2176-e26f-41f2-2fc8-08daef2ec57a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 15:08:58.6843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 31TAw8csWfT4iqCr9+Ti73ZZqegjsiOwKntdaPlJNasc5atvo6H7aEXui/LNLQFA2zMhr92YwPAGq5kA5Dv6RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4263
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

Hi Viresh.=20

> -----Original Message-----
> From: Viresh Kumar <viresh.kumar@linaro.org>
> Sent: Tuesday, December 27, 2022 10:52 AM
> To: Yuan, Perry <Perry.Yuan@amd.com>
> Cc: rafael.j.wysocki@intel.com; Limonciello, Mario
> <Mario.Limonciello@amd.com>; Huang, Ray <Ray.Huang@amd.com>;
> Sharma, Deepak <Deepak.Sharma@amd.com>; Fontenot, Nathan
> <Nathan.Fontenot@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Huang, Shimmer
> <Shimmer.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Meng,
> Li (Jassmine) <Li.Meng@amd.com>; Karny, Wyes <Wyes.Karny@amd.com>;
> linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v9 08/13] cpufreq: amd-pstate: implement suspend and
> resume callbacks
>=20
> On 26-12-22, 00:34, Perry Yuan wrote:
> > From: Perry Yuan <Perry.Yuan@amd.com>
> >
> > add suspend and resume support for the AMD processors by
> > amd_pstate_epp driver instance.
> >
> > When the CPPC is suspended, EPP driver will set EPP profile to 'power'
> > profile and set max/min perf to lowest perf value.
> > When resume happens, it will restore the MSR registers with previous
> > cached value.
> >
> > Acked-by: Huang Rui <ray.huang@amd.com>
> > Reviewed-by: Mario Limonciello <Mario.Limonciello@amd.com>
> > Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> > ---
> >  drivers/cpufreq/amd-pstate.c | 40
> > ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 40 insertions(+)
> >
> > diff --git a/drivers/cpufreq/amd-pstate.c
> > b/drivers/cpufreq/amd-pstate.c index c671f4955766..e3676d1a85c7 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -1041,6 +1041,44 @@ static int amd_pstate_epp_verify_policy(struct
> cpufreq_policy_data *policy)
> >  	return 0;
> >  }
> >
> > +static int amd_pstate_epp_suspend(struct cpufreq_policy *policy) {
> > +	struct amd_cpudata *cpudata =3D policy->driver_data;
> > +	int ret;
> > +
> > +	/* avoid suspending when EPP is not enabled */
> > +	if (cppc_state !=3D AMD_PSTATE_ACTIVE)
> > +		return 0;
> > +
> > +	/* set this flag to avoid setting core offline*/
> > +	cpudata->suspended =3D true;
> > +
> > +	/* disable CPPC in lowlevel firmware */
> > +	ret =3D amd_pstate_enable(false);
> > +	if (ret)
> > +		pr_err("failed to suspend, return %d\n", ret);
> > +
> > +	return 0;
> > +}
> > +
> > +static int amd_pstate_epp_resume(struct cpufreq_policy *policy) {
> > +	struct amd_cpudata *cpudata =3D policy->driver_data;
> > +
> > +	if (cpudata->suspended) {
>=20
> When will resume get called without being suspended first ?

Sorry for the late reply.
Theoretically the resume() will get called when system suspended firstly.
Checking cpudata->suspended flag to make sure eachtime resume() is called t=
o resume the previous MSR values safely in my view.
Maybe we can drop the checking code, but it will take more time to run test=
ing~ =20
So to be safe , we can keep this, I will try to do some optimization in fut=
ure.=20


Perry.=20

>=20
> > +		mutex_lock(&amd_pstate_limits_lock);
> > +
> > +		/* enable amd pstate from suspend state*/
> > +		amd_pstate_epp_reenable(cpudata);
> > +
> > +		mutex_unlock(&amd_pstate_limits_lock);
> > +
> > +		cpudata->suspended =3D false;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static struct cpufreq_driver amd_pstate_driver =3D {
> >  	.flags		=3D CPUFREQ_CONST_LOOPS |
> CPUFREQ_NEED_UPDATE_LIMITS,
> >  	.verify		=3D amd_pstate_verify,
> > @@ -1062,6 +1100,8 @@ static struct cpufreq_driver
> amd_pstate_epp_driver =3D {
> >  	.exit		=3D amd_pstate_epp_cpu_exit,
> >  	.offline	=3D amd_pstate_epp_cpu_offline,
> >  	.online		=3D amd_pstate_epp_cpu_online,
> > +	.suspend	=3D amd_pstate_epp_suspend,
> > +	.resume		=3D amd_pstate_epp_resume,
> >  	.name		=3D "amd_pstate_epp",
> >  	.attr		=3D amd_pstate_epp_attr,
> >  };
> > --
> > 2.34.1
>=20
> --
> viresh
