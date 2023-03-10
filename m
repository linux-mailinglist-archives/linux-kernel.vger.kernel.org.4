Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3746B4DAE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 17:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbjCJQzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 11:55:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbjCJQzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 11:55:15 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2061f.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe13::61f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CC459F7;
        Fri, 10 Mar 2023 08:52:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+M1x8YMKINN5ChS3teZgjQMaHMnV9+bdZOH9XB37/4ghWQaNhqiyI6KaKQte2ZCqhQCe7q0DNxCAIFGcl2pdEEXuQhkbRryKfoS6zZ8U15alMxzH+1vWoc428kJpXNWUSOoq1KrpgOFNy6UdHDqOLBxopMquq9tgUgde6V6c5wbBbahGS43vSrjfSp2MsFnxrm3vQMRjafeVZxRr8Yb5SWkF205C+B8aCPn7qqM6SYWbhWPeahFkJH7r2UkSS3Ifsi5MD/V0MrG+aOMgLBAUz/uXOKzjJTqEDdZL5BrQLcdsMFNKAWW1Ynq+lRTYseYyZ3R13amYWjIDurpVj2yYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SESoXQ5p3VCsDX1XQVl2Xu2QU5p8CSjIsoj+vGSeQLk=;
 b=ehhOwogU3ZFoH0T06iQRiFjvXkbx9IJhPAcjb/S4EsmSyFE6jDIFbx7Ywv+w0kRljNV8oPEsMFEtxKfP8xvFPXjzSB3Dz6Z3N+MTh+CtTtAfznJjXu7a+IofvuEUyW2HZnw+9G32G8ywAeZePRKy37Ozc+/U/AvogrJ+wtGENa62iOdZE9UXK4L9z4dYJ+tjncRNMIvg12pOefvi+YpTnWPJjN8D9LbMPJ3cCOg7Dc01MXD2HfSib2dHsodyjj8LdKW3406+9kEWiogPZjTcbB9cm8YGbcZFx1yXfDtRLWqFaZ77pMhTY4Rj+JV+uMqfwZ4LF4jkei6rosMda6mL4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SESoXQ5p3VCsDX1XQVl2Xu2QU5p8CSjIsoj+vGSeQLk=;
 b=dDCaewYB+mN5rsZwISifXYJgBTsDXt6CnnXQvTiicCKrigG5G6gWAHujhGTRBZoS9sEMRO2vvl8nPF3t2iyqIEfZ5aWl43v9HzeC/mPRE5sjtIBJWNwfTYOxHflesCYG9BqJA/mgIhG60UdN33XEHIbiTiTgfBCzlVtnZS/krqpd5rFNL7fqua2otAuT/pQem2QyR2VPKbYb+JJs2eNyGJIxL2O41r9GM78eDsx+6vwWQkZc+VWiO5mECstK2COJF8fUSciwswL3yinqe9ZiSLEgrr1qJWhaJ1zEp2Vk3TeGWu3E1IH2/q2gMS+BcNwmfL+rxRPjwEUG6xp5vH9Rlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by AS4PR04MB9338.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.16; Fri, 10 Mar
 2023 16:51:45 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f%2]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 16:51:45 +0000
Date:   Sat, 11 Mar 2023 00:51:26 +0800
From:   Chester Lin <clin@suse.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Phu Luu An <phu.luuan@nxp.com>,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>,
        Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>,
        Andrei Stefanescu <andrei.stefanescu@nxp.com>,
        Arnd Bergmann <arnd@arndb.de>,
        NXP S32 Linux Team <s32@nxp.com>,
        Matthew Nunez <matthew.nunez@nxp.com>,
        Radu Pirea <radu-nicolae.pirea@nxp.com>,
        Larisa Grigore <larisa.grigore@nxp.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: s32cc: fix !CONFIG_PM_SLEEP build error
Message-ID: <ZAtgDp4Vq/mkf3vY@linux-8mug>
References: <20230310140250.359147-1-arnd@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230310140250.359147-1-arnd@kernel.org>
X-ClientProxiedBy: FR0P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::7) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|AS4PR04MB9338:EE_
X-MS-Office365-Filtering-Correlation-Id: 595c2de6-0c95-4945-0b38-08db2187bb4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3cjexbRWBYIQDWsF0+cFskzkoCEDk8KTKrgTPlqeoMKuFo+87gXsjPVgyqbaMrpmscHYm8Mk7bGTS0kIzm+bJ014go8TCJIS48Ay5wjxTzVrgBysxF+Iyo3su+ztKZs0LDc2JhrDBATLR05MDJD+AxL4yrn15BVW31aiLEHYFd4HL+iTv8l1mV8aLevwgvBi7AI2S06F6XtQp405UA5Qsl8c9lip6gze2xckUeYRY6F+D9E3wigYICb6ZJnF5EIgqdlkU+66PesfWOXLreg5ZfgTygbdG9Hmo13WRAI0iDHa0VrRNpGI04g+aJKafE/Y+/w4ONiOm3PC8nOem/C+t5gxMv13gvmCYEZqwT3b9XAOaeK5QC4eBxtDi9tLQ+kkS4duHJuMzsOvzg80onFyyp269saL/13w3w+xKjXGNt0u21TqjJ8gwrXuOTHGrRQeMHVqItxAY8u8XRJQoqGOiRlV2aPYQexkCyay76HeIMXR9nlV+YF0u0+FHgY68PX5kdiltDQtzBdipmQQrX1QQ+ZPyzvAbUMnfUhEUL9sRbaMretJHlgYKy2T0NydNfwOXavP0cYGOdH6AHVW096CRDzIKzkQvDH74MnlVVKHFy6+NKGPpK2KuIVbytihxjOB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199018)(2906002)(83380400001)(5660300002)(7416002)(66556008)(66476007)(8936002)(8676002)(4326008)(6916009)(478600001)(316002)(38100700002)(86362001)(54906003)(66946007)(33716001)(26005)(186003)(9686003)(6512007)(6666004)(6486002)(6506007)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ute9gLxKY1Go0Npiqt0SVzgo7+bay7vcvHkQWsd2yo3XE40uMZEjVGYatE2F?=
 =?us-ascii?Q?uw1KEj6MhlkEQSYgTM2nkgZu0/Yw2hytEFdYJIWjND5z9pmEgxMJFtXO5PO3?=
 =?us-ascii?Q?Q3JGK5jQS6QgbcYxQTQUp5IAFSMbBvzDABPWyoxWDLJ2TCI5lEdCRzmvegJC?=
 =?us-ascii?Q?NyWpJQ1FPBeIm57XJEOz34/tjtvMrdIHtD9YZDIP+5gM/Vhz+NitsPL1prlp?=
 =?us-ascii?Q?KepAbpz1Givrw7473iddcwdiNO5erQ4mHL9gIKTz9FWLVMazqipuIjT9no0h?=
 =?us-ascii?Q?HsV0MUgC3O/Lq0/mnJNbvBziKRKqYQ0nl6UyjaL58rv6e1EnQZ+gVWYkuAG/?=
 =?us-ascii?Q?2iuYdme5j+sukD+St6Ojk3C5pstKos244OxdwnUpFfBYAZZt2Rl9zgPfVHbT?=
 =?us-ascii?Q?AvOv1IMJV3D0KDRJbDF6qKLyQtzi3U9TgqZP5khBzPftY7cU6sudrg29vpxM?=
 =?us-ascii?Q?rl2TkIijYzuQe328KDOutfCzCTnBbRYd8s7K4+1HAbnLWutU4DL7e/5gPxYq?=
 =?us-ascii?Q?dW2G+wp1J6oyLiBevv0p0VNR6mdzhQwFtNkF+/lyjl2bsy9jEe04IDosVivT?=
 =?us-ascii?Q?RhGHXuUQW3lb1Z7a7s3k6JanWr2clk355V32iNnzi/B1QctqD6wcc2dL+d8o?=
 =?us-ascii?Q?Vy7lpDNKwtOitaWWZ6XxOHi5rqK/yfpo1W7geVo4FxuA9ngCD31D68qtIqgT?=
 =?us-ascii?Q?2iA4ZWLHW8Uiuq9qao7hYiZxc1YQvdp29wbX2CtiIKYCuBKF6EIK4dL6YYka?=
 =?us-ascii?Q?5pxXair3Ltm3fr5YA5h8hS+pcIw/Q4ULnr9hp1jvetUJhUtC1szKIMC9Dg+G?=
 =?us-ascii?Q?WsQrAGz5wnrpQsv5JkUAtmY1AhynlvHQiESX9pIANJCGHXMtj27xhoPbqOcS?=
 =?us-ascii?Q?la27m5pRsyrRFSOiwdmzDcU9xNHndr+MEc9vwyOnm36xoXaXX2CPWpeu0OkE?=
 =?us-ascii?Q?2ke3n4qt7B80SRpjuj8LQ2we0VifqZEWQzDtfU1M6O9BHUH04qtIMpO6NNRI?=
 =?us-ascii?Q?LyxL1ZrNyZxJeuf9O1LX60pxN+blo31oP+Yg/JwH5zvO3hqVE6KtZNMlnfeE?=
 =?us-ascii?Q?qWsoMuYIBposyqhU4ZY0fQOT9KZxeQLbEXRPCgKQ33HhEVOx/M/2aRhw7HMZ?=
 =?us-ascii?Q?NrAqb6ThIXziDcVvKDR9mIkrlKVKOaSy50ZAY+o2ggCQVilLUT4CvS9WCmVE?=
 =?us-ascii?Q?YbkfGPLiO2uGoxnpN/3lma7n9lkhObv9pxN9jxe6etIyvOjOvBnF6LSNKEgm?=
 =?us-ascii?Q?8EfJkqy4vNyMo879Wbk5bcATWMBQXpc8khf/Tso8hfbcywRFMeDEpcE1cxFf?=
 =?us-ascii?Q?atnKkqd7QdkgC7XUeuAMbQyU9c4ODBnwpEubplSKPRh22qcWzQYB45bAVj+x?=
 =?us-ascii?Q?F0dO3+oT1p5b7BDM3niZ+SKAuoqbKvFqTmi7KLtEv8yJqOOmMBPKiIPYLCT+?=
 =?us-ascii?Q?y/6NrTjtWUL1x6+nZx3q6rzTCZ72jntU7s/scJn9lXdJ0W3JKP9FUQkcnFq1?=
 =?us-ascii?Q?m9vmUpD/gFSRET2uM5Kh2ie4f/3AlE4nyRpRkGaTj9s68X65eQfLxTaeu/YY?=
 =?us-ascii?Q?kY1DTIdX5AuTG/Sz5+I=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 595c2de6-0c95-4945-0b38-08db2187bb4a
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 16:51:45.1425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b9J5a2/f96esQNYO5rZTzTjIx7On+DC6YkGaKPH7GcVu8DAJtrbBprtSrH3n6HGK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9338
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Fri, Mar 10, 2023 at 03:02:35PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The declaration of s32_pinctrl_suspend/s32_pinctrl_resume is hidden
> in an #ifdef, causing a compilation failure when CONFIG_PM_SLEEP is
> disabled:
>=20
> drivers/pinctrl/nxp/pinctrl-s32g2.c:754:38: error: 's32_pinctrl_suspend' =
undeclared here (not in a function); did you mean 's32_pinctrl_probe'?
> drivers/pinctrl/nxp/pinctrl-s32g2.c:754:9: note: in expansion of macro 'S=
ET_LATE_SYSTEM_SLEEP_PM_OPS'
>   754 |         SET_LATE_SYSTEM_SLEEP_PM_OPS(s32_pinctrl_suspend,
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20

Thanks for your patch and hope you don't mind if I ask a stupid question.

To reproduce this issue, I tried disabling the CONFIG_PM_SLEEP and then com=
pile
linux-pinctrl's latest for-next branch [ef455e9e8f76] but I still can't see=
 this
compilation failure. May I know details such as your configs, compiler and =
kernel-tree?

Here are my steps:

1. make defconfig
2. Set CONFIG_PINCTRL_S32G2=3Dy and unset both CONFIG_SUSPEND & CONFIG_HIBE=
RNATION
   so that CONFIG_PM_SLEEP vanished.
3. make oldconfig; make
4. Ensure that both s32_pinctrl_suspend and s32_pinctrl_resume are disappea=
red
   from System.map

I tried the following two gcc versions on both arm64 and x86_64 machines:

1) Native arm64:

Target: aarch64-suse-linux
Configured with: ../configure --prefix=3D/usr --infodir=3D/usr/share/info -=
-mandir=3D/usr/share/man --libdir=3D/usr/lib64 --libexecdir=3D/usr/lib64 --=
enable-languages=3Dc,c++,objc,fortran,obj-c++,ada,go --enable-checking=3Dre=
lease --disable-werror --with-gxx-include-dir=3D/usr/include/c++/7 --enable=
-ssp --disable-libssp --disable-libvtv --disable-libmpx --disable-libcc1 --=
disable-plugin --with-bugurl=3Dhttps://bugs.opensuse.org/ --with-pkgversion=
=3D'SUSE Linux' --with-slibdir=3D/lib64 --with-system-zlib --enable-libstdc=
xx-allocator=3Dnew --disable-libstdcxx-pch --enable-version-specific-runtim=
e-libs --with-gcc-major-version-only --enable-linker-build-id --enable-linu=
x-futex --enable-gnu-indirect-function --program-suffix=3D-7 --without-syst=
em-libunwind --enable-fix-cortex-a53-835769 --enable-fix-cortex-a53-843419 =
--build=3Daarch64-suse-linux --host=3Daarch64-suse-linux
Thread model: posix
gcc version 7.5.0 (SUSE Linux)

2) Cross-compilation on x86_64:

Using built-in specs.
COLLECT_GCC=3Daarch64-suse-linux-gcc
COLLECT_LTO_WRAPPER=3D/usr/lib64/gcc/aarch64-suse-linux/12/lto-wrapper
Target: aarch64-suse-linux
Configured with: ../configure --prefix=3D/usr --infodir=3D/usr/share/info -=
-mandir=3D/usr/share/man --libdir=3D/usr/lib64 --libexecdir=3D/usr/lib64 --=
enable-languages=3Dc,c++ --enable-checking=3Drelease --disable-werror --wit=
h-gxx-include-dir=3D/usr/include/c++/12 --enable-ssp --disable-libssp --dis=
able-libvtv --enable-cet=3Dauto --disable-libcc1 --disable-plugin --with-bu=
gurl=3Dhttps://bugs.opensuse.org/ --with-pkgversion=3D'SUSE Linux' --with-s=
libdir=3D/usr/aarch64-suse-linux/sys-root/lib64 --with-system-zlib --enable=
-libstdcxx-allocator=3Dnew --disable-libstdcxx-pch --enable-version-specifi=
c-runtime-libs --with-gcc-major-version-only --enable-linker-build-id --ena=
ble-linux-futex --enable-gnu-indirect-function --program-suffix=3D-12 --pro=
gram-prefix=3Daarch64-suse-linux- --target=3Daarch64-suse-linux --disable-n=
ls --with-sysroot=3D/usr/aarch64-suse-linux/sys-root --with-build-sysroot=
=3D/usr/aarch64-suse-linux/sys-root --with-build-time-tools=3D/usr/aarch64-=
suse-linux/bin --enable-fix-cortex-a53-835769 --enable-fix-cortex-a53-84341=
9 --disable-libsanitizer --build=3Dx86_64-suse-linux --host=3Dx86_64-suse-l=
inux
Thread model: posix
Supported LTO compression algorithms: zlib zstd
gcc version 12.2.1 20220830 [revision e927d1cf141f221c5a32574bde0913307e140=
984] (SUSE Linux)

Regards,
Chester

> Remove the bogus #ifdef and __maybe_unused annation on the global
> functions, and instead use the proper LATE_SYSTEM_SLEEP_PM_OPS()
> macro to pick set the function pointer.
>=20
> As the function definition is still in the #ifdef block, this leads
> to the correct code in all configurations.
>=20
> Fixes: fd84aaa8173d ("pinctrl: add NXP S32 SoC family support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/pinctrl/nxp/pinctrl-s32.h   | 6 ++----
>  drivers/pinctrl/nxp/pinctrl-s32cc.c | 4 ++--
>  drivers/pinctrl/nxp/pinctrl-s32g2.c | 3 +--
>  3 files changed, 5 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/pinctrl/nxp/pinctrl-s32.h b/drivers/pinctrl/nxp/pinc=
trl-s32.h
> index b6d530a62051..545bf16b988d 100644
> --- a/drivers/pinctrl/nxp/pinctrl-s32.h
> +++ b/drivers/pinctrl/nxp/pinctrl-s32.h
> @@ -68,8 +68,6 @@ struct s32_pinctrl_soc_info {
> =20
>  int s32_pinctrl_probe(struct platform_device *pdev,
>  			struct s32_pinctrl_soc_info *info);
> -#ifdef CONFIG_PM_SLEEP
> -int __maybe_unused s32_pinctrl_resume(struct device *dev);
> -int __maybe_unused s32_pinctrl_suspend(struct device *dev);
> -#endif
> +int s32_pinctrl_resume(struct device *dev);
> +int s32_pinctrl_suspend(struct device *dev);
>  #endif /* __DRIVERS_PINCTRL_S32_H */
> diff --git a/drivers/pinctrl/nxp/pinctrl-s32cc.c b/drivers/pinctrl/nxp/pi=
nctrl-s32cc.c
> index 2c945523af80..e1da332433a3 100644
> --- a/drivers/pinctrl/nxp/pinctrl-s32cc.c
> +++ b/drivers/pinctrl/nxp/pinctrl-s32cc.c
> @@ -658,7 +658,7 @@ static bool s32_pinctrl_should_save(struct s32_pinctr=
l *ipctl,
>  	return false;
>  }
> =20
> -int __maybe_unused s32_pinctrl_suspend(struct device *dev)
> +int s32_pinctrl_suspend(struct device *dev)
>  {
>  	struct platform_device *pdev =3D to_platform_device(dev);
>  	struct s32_pinctrl *ipctl =3D platform_get_drvdata(pdev);
> @@ -685,7 +685,7 @@ int __maybe_unused s32_pinctrl_suspend(struct device =
*dev)
>  	return 0;
>  }
> =20
> -int __maybe_unused s32_pinctrl_resume(struct device *dev)
> +int s32_pinctrl_resume(struct device *dev)
>  {
>  	struct platform_device *pdev =3D to_platform_device(dev);
>  	struct s32_pinctrl *ipctl =3D platform_get_drvdata(pdev);
> diff --git a/drivers/pinctrl/nxp/pinctrl-s32g2.c b/drivers/pinctrl/nxp/pi=
nctrl-s32g2.c
> index 7dd0b4f8904d..5028f4adc389 100644
> --- a/drivers/pinctrl/nxp/pinctrl-s32g2.c
> +++ b/drivers/pinctrl/nxp/pinctrl-s32g2.c
> @@ -751,8 +751,7 @@ static int s32g_pinctrl_probe(struct platform_device =
*pdev)
>  }
> =20
>  static const struct dev_pm_ops s32g_pinctrl_pm_ops =3D {
> -	SET_LATE_SYSTEM_SLEEP_PM_OPS(s32_pinctrl_suspend,
> -				     s32_pinctrl_resume)
> +	LATE_SYSTEM_SLEEP_PM_OPS(s32_pinctrl_suspend, s32_pinctrl_resume)
>  };
> =20
>  static struct platform_driver s32g_pinctrl_driver =3D {
> --=20
> 2.39.2
>=20
