Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB2172CB18
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 18:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbjFLQMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 12:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjFLQMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 12:12:00 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2249BC5;
        Mon, 12 Jun 2023 09:11:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NifpRgHX60LhIljyg6+n3DJTes5Wkdkzq3InHMH4ltEXzhgWZBoDJ8zHUIRwzqMf/5MIZOZlURRXuldt2YxmKCig/k4qBOQVbPl/Gl+29b1ROFyOBOU49dcFOIb29TD9g9Hq4B8OcEfXo7z+/B3Q+M34tAuTtMYZKJxU7zjMCIzT3+ED8Zw6pmABcIw3bUypb7jQHxtAvl+D8dRhcMvMe5Gl6lw/ADAnnVZVIimtJ9qS6y3MVRfkvZ22mkKgKoieBG1XR52Y3bQEfKZJxwcKpw3i43lYZqTwtfi8xH208dy7OjDPy565fuQ8amTv1Vabdma7F3eKrd7oN0mtJ+VmNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NeCxhMiEZdxUWFaQ+Rg1KqWSmMu3u/ZOcany21BhDOs=;
 b=LWJeR603prpJMGkuewEUaq0ojsHP8BAFKHGXrh1ONjvSqI7wOmgBhCwq/s0wqV22tvxaZD03uAAH4KXDTGkbKAFETsPHrTb8KN+gTuNr27EPSnI00zHxTUZJvMdvPNAjPhlo+NiRu5xhqPEyz6neizsSdmftYHnaOuRvvBz1wsOH+QRVP1D92v5UsIVsSxbmkGkXxyOpf3i3qwCzyCnV8aztMQLNEr4gaIb0Uq8KHXWmj+8iXf45repM+pFGvhNwfjmfTnHBn+HvOPO5MFieTIrDC2RCrghtQgAcUNhwhmJkQr7Donf2ILrEzdbYEV2u5WT+Z8/OW8W22m5xroL84w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NeCxhMiEZdxUWFaQ+Rg1KqWSmMu3u/ZOcany21BhDOs=;
 b=ph0mA5HoBCgK8WRLfp2wZhioSXUbzTr3gGtgLH1USHasngIiiUqCuz+mdQu+B4Tb0YEqDkxhjbiz7aX0W0XdH+hHZ4JOUkjXLjlnnps8L77VouIN7SICXhq9s5I95/9MjeDzNsyv0K2keHUd3VCwNS8yhE0zI6h8oq+98enzfqY=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by DM4PR12MB5326.namprd12.prod.outlook.com (2603:10b6:5:39a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 12 Jun
 2023 16:11:56 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::8d99:5e7c:3ab:a882]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::8d99:5e7c:3ab:a882%7]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 16:11:56 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Karny, Wyes" <Wyes.Karny@amd.com>,
        "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] cpufreq: amd-pstate: Set default governor to schedutil
Thread-Topic: [PATCH v2] cpufreq: amd-pstate: Set default governor to
 schedutil
Thread-Index: AQHZnNpxmlVNkY+7oky3diCKzMikhK+GxLGAgACSkFA=
Date:   Mon, 12 Jun 2023 16:11:56 +0000
Message-ID: <CYYPR12MB86556045C209552FF99C47C89C54A@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <20230612030321.3097627-1-perry.yuan@amd.com>
 <20230612072627.5wzmsfp64jho3bdj@vireshk-i7>
In-Reply-To: <20230612072627.5wzmsfp64jho3bdj@vireshk-i7>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=cc280909-9e92-4fbd-aa53-87d143ce5135;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-12T16:11:01Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|DM4PR12MB5326:EE_
x-ms-office365-filtering-correlation-id: 8e75b9d8-2c7c-41e0-b0a0-08db6b5fbeb1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iUvmC19tcZUlIFwnLIfDT78qoV/CHtjR9Cu3fQlCYR1x1cgwgj/2Vtafp0lfUafJgvUqtFxB4ip4LSNc6P/F986iXZp2mK9NtK8qNf0BsWvG5132Bbg5Ikazu2kC4dzTyb0FHJ3msS+a0h76d2zGAbfZGuB0l6yQKUjCSqP+r/hZgqiwWTFrMbyiZjvQolLoiu9Pv9f1mc7uR3NbfOiUIQRq2jAOLBXEgtxhK5Roy9dborUJbtMql9U9b7ZEqxXXAcZPu46J4gaUkHKsomDzhb38beW6RGLyTirhF2EtlawfCPwu3QiZpw0gKQ417IoRvBJvSYPFcTo7g4u9IV5m5jPqBFSzHqu5x1Ihylb9v4xnJD237vweD9gyLfUlU0JCq+EYLhZkjNFXXn27ySp5BV6SZcMI9l5VljdtXVn75iDrD/WERY70vhdkiySKOwnunUAks0Aq8UOoef5E7SyFlKSBcfLgSBstdYEySVZi4HG5lCRtlQ2Sn3L7f1OX3s0x2xpLnPWANgE5lLrO1cuCYmLoDvwYmzvV+qBmIJ7r7IpxkUBRJLty8I4pzhJnB5ImFikTX3V+MrI1/QaeKvzTLN9cYyBmpxgcz5XPzYltOyYiepcWRlEu8udSV4eOmX9n
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(451199021)(478600001)(2906002)(83380400001)(38070700005)(53546011)(186003)(6506007)(26005)(9686003)(86362001)(122000001)(38100700002)(33656002)(7696005)(55016003)(71200400001)(52536014)(5660300002)(8936002)(8676002)(41300700001)(66446008)(66476007)(66946007)(76116006)(6916009)(316002)(64756008)(66556008)(4326008)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?azqoC9/rsvv9jYY4dA97h9lcISyIuSPsIE0fo4rWwI8x93i18kKCawkmT7Dy?=
 =?us-ascii?Q?r9Xfd2lKkOTJtsHd+IC/Jp1nIKGv3lWC7Su/6sfypaE0qPVCMerTAzHQWDsb?=
 =?us-ascii?Q?Y3wqP4iUxuK9s2CWlrZ9tuF03M05Ea8U0y+meoGMu1BY0RpcrRbQ/44qvznQ?=
 =?us-ascii?Q?l/QTBMlabIAd66ESzpRv6htzGmsucgye7HVnPf7NhW2ALDVNHfZADcikamSG?=
 =?us-ascii?Q?Qk2/qKFMhww8HEEm8b+xmqoDi1+62KbYlTC4E1asI/1gz/+zBdHM4frT/2fZ?=
 =?us-ascii?Q?sso5a8pUvxKKl4jbbgtKyROdbLRESUhZH2u0QRRkRa5lasqczyArO/19+AoW?=
 =?us-ascii?Q?SNIdDbUGAyAub1oKQi56X5zNUvCyaD38PzUXcSRK1G3KW5jmbUVl19x6kWL2?=
 =?us-ascii?Q?bcWozuWNyqdv/mwbKLno1I8UgTfdpdrEaLD3PXtMgkhrZOyYRd2DjrWeuzib?=
 =?us-ascii?Q?mAjz9vAPlzRyq87eAU7RGSe/1s+JemKQsoW7rs0HeA6bG6lr+wjdHxVAVyfd?=
 =?us-ascii?Q?/CCE/z88wfmOD9333dJBUQrISU56jkRxJ9oigApAmwROpwTLeQ5+SF6dlmGG?=
 =?us-ascii?Q?rV/RVS28FpxRvw9pe7zcsWesMOEgGqaIWHt9SZnWVIr93rpr8qD81aB2r4UG?=
 =?us-ascii?Q?tg62UIUqSJOmqdVkatufR3krWuXs1Je51wxwgTl7605DKIuKP7CWI9SF8evu?=
 =?us-ascii?Q?nCFafqAFhoYjtDKsn5EBj35zY9GCW3WN6I2O0ZosZ7kxKPaDh+IKd7ave9KD?=
 =?us-ascii?Q?lGekOf4/idSrgfGK2XxP2l0SjC5BVcTnCYad1DC9zueO+o2jzBP86hyvfpjL?=
 =?us-ascii?Q?Ifc7/MiO+OF25poC/HMesvXBkfHgAVyUs3/Cq7Z7MN0LTEPN3kBYs7fBuuHR?=
 =?us-ascii?Q?4axiPdRgv6htcmstGWuv3FuTZU8dWXax/0Rsd7BqL8i3DxQFGvlPSfbxhpEu?=
 =?us-ascii?Q?vNtV1BcEih4mNirmf+AsLT/ZeSv+TKcTn2dN8mpav5SnzOq5CiVKcT1cvYGu?=
 =?us-ascii?Q?TkuvPQ2fS3UR9e8sEBN313VcYOsvr3tcmyadTVJLd/ly9bFgODuGzjossIuX?=
 =?us-ascii?Q?bl9eEyMouuQrU2d5BNluDKfjc99RF6wXg7xJFuD05G+jvS/a9Z9p3jBawe71?=
 =?us-ascii?Q?p96aNXeWYgXE+SwhCaBtBu+Df7xuiRF/I80+pX6E2uhfLfnwVVRd6SZ7BA4G?=
 =?us-ascii?Q?m3vJhCfyQzI0BqSlKxW2x1/LXf/vNomx7ozhucgprGEyE5EW7v5zd+GD5KHy?=
 =?us-ascii?Q?fjlslpER6Xsrb1dhNGGCPVewmgNdi1GdaxELlBwqIwV4E8e4TTysSUJyd9SL?=
 =?us-ascii?Q?s/ymupZdVIdW9r21JO1sa3LBNCKa5oIGcSiDK5lWaKwBrXKCGozYou2VfZNi?=
 =?us-ascii?Q?CHowZopq+yHu2afjVP/+xGbNPufkvzFMy9GzIOB1HzR7b4a7d/aq1bI3IcC8?=
 =?us-ascii?Q?i2PZZ6w+FJS3FVtEyBgwErkqY/jDK8S7Ibtb7bk1W1/Hgk2JJ1hRdUBI9pkN?=
 =?us-ascii?Q?Vu/zFLdswvwczoGHhI15EI5OySlD2vKLzcJRTG3ypJ1eY4gSUfQGqwkbJL+Y?=
 =?us-ascii?Q?psAEo7QCW0BTaC4RAuk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8655.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e75b9d8-2c7c-41e0-b0a0-08db6b5fbeb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2023 16:11:56.8039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f+kDM3O8xpRpyZpjWAFLzvDkR7ULjcD/yTsbJPWA22d5kLMuKGalX2QmIAhHdSFPmaXUcNHSQTVHOcW4qZTYqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5326
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]

Hi Viresh.

> -----Original Message-----
> From: Viresh Kumar <viresh.kumar@linaro.org>
> Sent: Monday, June 12, 2023 3:26 PM
> To: Yuan, Perry <Perry.Yuan@amd.com>
> Cc: rafael.j.wysocki@intel.com; Huang, Ray <Ray.Huang@amd.com>;
> Limonciello, Mario <Mario.Limonciello@amd.com>; Sharma, Deepak
> <Deepak.Sharma@amd.com>; Karny, Wyes <Wyes.Karny@amd.com>;
> Shenoy, Gautham Ranjal <gautham.shenoy@amd.com>; Li, Sun peng (Leo)
> <Sunpeng.Li@amd.com>; Huang, Shimmer <Shimmer.Huang@amd.com>;
> Du, Xiaojian <Xiaojian.Du@amd.com>; Meng, Li (Jassmine)
> <Li.Meng@amd.com>; linux-pm@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v2] cpufreq: amd-pstate: Set default governor to
> schedutil
>
> On 11-06-23, 23:03, Perry Yuan wrote:
> > From: Mario Limonciello <mario.limonciello@amd.com>
> >
> > The Kconfig currently defaults the governor to schedutil on x86_64
> > only when intel-pstate and SMP have been selected.
> >
> > If the kernel is built only with amd-pstate, the default governor
> > should also be schedutil.
> >
> > Cc: Sun Peng (Leo) Li <sunpeng.li@amd.com>
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > Reviewed-by: Leo Li <sunpeng.li@amd.com>
> > Acked-by: Huang Rui <ray.huang@amd.com>
> > Tested-by: Perry Yuan <Perry.Yuan@amd.com>
> > ---
> >  drivers/cpufreq/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig index
> > 2c839bd2b051..a1c51abddbc5 100644
> > --- a/drivers/cpufreq/Kconfig
> > +++ b/drivers/cpufreq/Kconfig
> > @@ -38,7 +38,7 @@ choice
> >     prompt "Default CPUFreq governor"
> >     default CPU_FREQ_DEFAULT_GOV_USERSPACE if
> ARM_SA1110_CPUFREQ
> >     default CPU_FREQ_DEFAULT_GOV_SCHEDUTIL if ARM64 || ARM
> > -   default CPU_FREQ_DEFAULT_GOV_SCHEDUTIL if X86_INTEL_PSTATE
> && SMP
> > +   default CPU_FREQ_DEFAULT_GOV_SCHEDUTIL if
> (X86_INTEL_PSTATE ||
> > +X86_AMD_PSTATE) && SMP
> >     default CPU_FREQ_DEFAULT_GOV_PERFORMANCE
> >     help
> >       This option sets which CPUFreq governor shall be loaded at
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> --
> Viresh

Thank you help to provide the ack flag.
I have added it to the V3.

Perry.
