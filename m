Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD3B6887BE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 20:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbjBBTrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 14:47:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjBBTri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 14:47:38 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2048.outbound.protection.outlook.com [40.107.104.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D02DD50D;
        Thu,  2 Feb 2023 11:47:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TlH8v/1kgEadLQ/IaC1T9KNALL6m+QXT/r96kgcX67MIcEfGuX92Rc3hAvD1Rf8BXcbcii6R4JYaJQG4Cg5oRSUOwM8aWwYagKSzTipNLeWTK4ZzOu4DPnXVmXLU/SdCmt9KPaBh22RN/NMEwpAYD1RxPWsDM2XQPhNrLdpnfEcXMbS+AgE5d/JNdkx4ww9s2BgAz+/UIcWp7bzxWvV8Smq9AcUMfzMZ3QzuhnTVCIQ9hshrTKCy+vjJSnWH5zWXVjuwlB8RduaCJ+ARqELdvn3XJikavCVkDk5f5EJNayAt1MpUdxNJSqwlhSgOsN+u42De8JwHoV9SpV9RZTN3OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HkMpbtTgBonQXa7drweD1zQkC2DVUvgcmo8JsRbWI7s=;
 b=k1e2+JF3V8c3fSmp9HdZtM15oEbN6yHznAgpBWo/F0Ao6cc32YteJp6wJwNn0bdhBuhnkFv0d+XTz2PFNbPS6mAXbDw+Ah62R6J5xHGmdy/hSWo2TU38uphKJNAmgSVzItQ+S1XPfJfuI/jsPBzlY5EBLEl06j/f2aOz7VPstlLUC9+UInWCkScTjSiejWfp9z1KkJntYnOGeOczL2xKpJuPfSsRZlXYVXujLLf7+MHw0HjzYML4M09LGh0y3WG/FIz7WLbj3W0XKoXy5YqpnXs3C4/E1riNVMPOWvvl3/3WM5tC4sH3ak6yIWKTHx+j8BMobJVQUqS82H1h6lBQ/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HkMpbtTgBonQXa7drweD1zQkC2DVUvgcmo8JsRbWI7s=;
 b=Ig3Z8E54aiSteaeB4SpxEtsj/lgHsxCfU8DpGOu6gvFnc3f/YnAleTll1YcN05nHVcsV0Y5CqB9sKYlzjn6KtNmMO8FGwzmFuJU9O8P+aGfZqbjKC97caaZ7g+pG8GVeCX6hwDPDmrC3Cp+m6EOYvz7qIjMGHw2GQgAz0UnMuQTkiNXcs80cAtPbyyOrkCcHGvw0EoVEz2Fp5v25fd3tGFLwhUM2oRDCGfEsy00PtPYeo0eTFLHYW0fFaFl8sboRJHiMSrlnGh4AO6SMgJUxVco7n4SbtaL4fh7aa3Yj5HYQ8e6I26VLjoF5CfUaabiDB6v8DHwEOJ8mKCDN2wR4mA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by PR3PR10MB4078.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Thu, 2 Feb
 2023 19:47:35 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ee44:171b:4c40:d42c]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ee44:171b:4c40:d42c%4]) with mapi id 15.20.6064.028; Thu, 2 Feb 2023
 19:47:35 +0000
Date:   Thu, 2 Feb 2023 20:47:30 +0100
From:   Henning Schild <henning.schild@siemens.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] leds: simatic-ipc-leds-gpio: do not run into endless
 EPROBE_DEFER loop
Message-ID: <20230202204730.7ee24c01@md1za8fc.ad001.siemens.net>
In-Reply-To: <20230125181711.30844-1-henning.schild@siemens.com>
References: <20230125181711.30844-1-henning.schild@siemens.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.35; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0099.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::17) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|PR3PR10MB4078:EE_
X-MS-Office365-Filtering-Correlation-Id: 64411481-3fc7-42d0-6c69-08db05565460
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LRdYWrh4thkj/c8Why4tEpFMvzyhbPo5GzxWDDOQh9UXN3Jz6QIpjr4tvjSnFlt4Fp64glqvtST9OU6dzZDr2o6C9RX5NnJWiHN3T38vIGRFBNAczLKhWvVU9YWkVf3qofaZ0YpLyFk+25IIXBqPfyspC7LB0fCCs062Mw3qtHxfZobCwZloKOBq1v15fPGbGL8KVW+hdMPBHiqz8sG6rrREtneJCGpNmCVBrYhbQblhZjSaPdkghWWn9TbHgzIFG/xmgpx3FZFfKt+t54FkD1OjCeInoQr+M+NsyWn9xpT3EvP98/Acf6HAAEx8wQYqi90/+iqQKvwfIAhBpVPh4lM7PcBY+a4EepMDYBOTmyZppjeUfRcb/7MNgYQhnqjVYVfKYleA8NO7+rZFUhyoIyd7IdU+/Kwra5xJXa3iv+rmkN9KWmfaYFo3EBNVEEc5VjmQRRYXN21mC8IDThqBHdqQc9J+2r01YohRQUHFiW2KaLJ+eMwWBnDu89BE46wBMTVWRUjCNqfU0nYORbYhfUTpCHhngB4O/Wq2NtlAfhIc0LkCJ8xvJP9lqmICwtB16FEOI0Qx4NIQSOCOnzKN0HTdwImbfRdJwluVt90fjo+9KgwkbTgGL/EhenFJciHjl3m9dfz7wgEO2hCgRXABog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(376002)(366004)(39860400002)(396003)(451199018)(66556008)(6666004)(86362001)(66946007)(6506007)(9686003)(6512007)(66476007)(1076003)(6486002)(478600001)(82960400001)(8676002)(83380400001)(316002)(41300700001)(5660300002)(8936002)(38100700002)(186003)(44832011)(2906002)(110136005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xOkFJY5Omylxfz+70avdPM9RGnFEXJcQzWYprvw0H0BX1QYM0YtGJXsMVX/K?=
 =?us-ascii?Q?spTRKV302NV5MoqDxcCFe3MoGEZVf2lvtNRDY/Idxdp1/HLnVwJFsrMH/Vep?=
 =?us-ascii?Q?IGa7adMIqBRC2T7H5TzVhwuCQ8FjcH17Pn9wZeWtHcfGkT3ThA97NDSbUgfF?=
 =?us-ascii?Q?sg8YXpgDP3HyH05G/Kv5pEKUXUmIdFDWeJ1jPhMxBZwgyY2bQL5Ek0hvfUze?=
 =?us-ascii?Q?sVpvRBVaOvBFN2SbVHkbmAxzpn10rikkkDWQFkEaSeekE/8utU2ptH4MOazQ?=
 =?us-ascii?Q?i0HsMt1xCREnl0smBrifvbPl378hgxSdDyBEn95YEmkYamZcLLZ9ZdPXe1Hs?=
 =?us-ascii?Q?5c/QrKdEaauA0ZVTJzR+lfxNLxmbVPoIGu5iFZ+Kk9/9WRAxmpsd8nL8NZBf?=
 =?us-ascii?Q?CtCHSCXNavYSLva8f7s6giZ89HmbxdxXaWdmSv/BtYfY8ImA2Goo4biNMw6c?=
 =?us-ascii?Q?1FRKCGKnPQOau5C7wrkYUt/RAShlkxtcv8jwfm/7V0Ctnl5s8D4vuYqFS2p3?=
 =?us-ascii?Q?snjFZd/c9IqIsCTDuxAbUCfPurnTAkU9Gqst/8vz1nC/kOSoQtK//xXQwlKD?=
 =?us-ascii?Q?p98OqR8vdvMpEs5WOONPTZ11mnjfHZ2bOOqjkGLGSyUirTWIgQzUe7IN+il7?=
 =?us-ascii?Q?SQR3QAQDKK3oP9lBETRu+H/pmdrYllt/JpUDNE1Xcr5C5LjXc2UmF+Zlwty8?=
 =?us-ascii?Q?IEYF1grQV5niUFfEBaUCBqA8u6mS/7kMwY8k2oNhCZ3GBNAMu+yG0UDimKZl?=
 =?us-ascii?Q?+PHm4X3qrW2pdXcVuVAI16nc0iMYSDQkAXpOVAnDUgiZt+J6uceqHXwX3+8H?=
 =?us-ascii?Q?qsjGfxK4zf7+NqcVwLJTdigqi/tj0YerFR2jOL3jRisal7ax5AtMp5ucgxXG?=
 =?us-ascii?Q?WTCd3TDnrSQ5vOVx/f1IrwxEbXah8NpaM9xnh2Ki7Z8anMTnnYUstZbL7Cqo?=
 =?us-ascii?Q?YulHGsFb1/khk2ZatZkPSila20/X9UqxZjGBB6EUBZAWFidK5IezBnL/p/iM?=
 =?us-ascii?Q?9FUr5gfBjDLjgMZ+6980FScmJrSnUG2QqQc+tBeTi1zbHsJmHjFVHnCiDVAC?=
 =?us-ascii?Q?05+qoUYtsQ2nRSUHhOHopqYRFxjWVZKDurLAN6vkk8DPhp1TWvELoAc1YhTi?=
 =?us-ascii?Q?Dox+q344fWervNeCdd+IsR/IE4zfX3d62XX/TzFxADPqyvHygGMxx1LobJaY?=
 =?us-ascii?Q?nnfFQSkJYY+BAOwYQbmqz6pM0qHHx9YUMsYmFjqPBNAGZKh+i36itwgTZXcw?=
 =?us-ascii?Q?8tA0BudR7yu0rRa/FPFWbsTRTJ+ulFbQANyR/bx2IomRr0eyB0i3qj6fELjy?=
 =?us-ascii?Q?6KWsrwaBONfsWQieJUowZThhffHOrGWJehbxsWLJbZ3QeFDvzKFCpvRa+FD5?=
 =?us-ascii?Q?9Fjq1X46Mb1jMKsbzzXrKWFIJM6U9KrpzXzBmgZK1HG7WLSwXUiHuNluympf?=
 =?us-ascii?Q?fH8+1HYgMHCoLgQ5QIKpuRIJ5qU7CiMRpkUwcL2Asiv1ANGoxRudywxjOvbK?=
 =?us-ascii?Q?DAzKx76OwUkGxI2OeYMxfJ0DKLvhtsUpxIO3lnta9q3/b3biywlqJGhq2Vig?=
 =?us-ascii?Q?Rtr0weME5fmgqI9Uh98665OF3c2jKiU+YhBKhhwcejulN2BBRQVJ5iHYefG+?=
 =?us-ascii?Q?ZifWWHfpUx5R97niSRX3xGe3MctejFdx3regPu3u8woMkCm6DYsGLDnZdUSR?=
 =?us-ascii?Q?RIF3DQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64411481-3fc7-42d0-6c69-08db05565460
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 19:47:34.7594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DY1slQge68+RCbYbi9RuwQY/2cy1zGuIk5Q6fou9ZrBji63H/RSOFKNq/Yp7d1ZQ9+AarMOgkkCBcM6zW6W0r9andHdcSaBTJckS4oWMRcc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4078
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Wed, 25 Jan 2023 19:17:11 +0100
schrieb Henning Schild <henning.schild@siemens.com>:

> Should the driver providing our GPIOs not be available we used to
> return -EPORBE_DEFER out of the probe function and cause a
> potentially endless loop that also printed a lot to the kernel log.
> 
> ...
> leds-gpio leds-gpio: cannot find GPIO chip igpio-f7188x-2, deferring
> leds-gpio leds-gpio: Skipping unavailable LED gpio 0 (red:status-1)
> ...
> 
> The "leds-gpio" just ignores all entries and would never try again
> even if the GPIOs show up later. But our extra two GPIOs could cause
> that loop, in which we would even register/unregister "leds-gpio" and
> cause all the printing.
> 
> If any of those two extra GPIOs is not there, return with -ENODEV
> instead of -EPROBE_DEFER.

This is a really bad idea. The real fix for the future will be to
write individual drivers which clearly describe their dep chains.

This patch should not be merged.

Henning
 
> Fixes: a6c80bec3c93 ("leds: simatic-ipc-leds-gpio: Add GPIO version
> of Siemens driver") Signed-off-by: Henning Schild
> <henning.schild@siemens.com> ---
>  drivers/leds/simple/simatic-ipc-leds-gpio.c | 29
> +++++++++------------ 1 file changed, 13 insertions(+), 16
> deletions(-)
> 
> diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio.c
> b/drivers/leds/simple/simatic-ipc-leds-gpio.c index
> 07f0d79d604d..4e2595e684c6 100644 ---
> a/drivers/leds/simple/simatic-ipc-leds-gpio.c +++
> b/drivers/leds/simple/simatic-ipc-leds-gpio.c @@ -74,14 +74,13 @@
> static int simatic_ipc_leds_gpio_probe(struct platform_device *pdev)
> const struct simatic_ipc_platform *plat = pdev->dev.platform_data;
> struct gpio_desc *gpiod; int err;
> +	int i;
>  
>  	switch (plat->devmode) {
>  	case SIMATIC_IPC_DEVICE_127E:
>  		simatic_ipc_led_gpio_table =
> &simatic_ipc_led_gpio_table_127e; break;
>  	case SIMATIC_IPC_DEVICE_227G:
> -		if (!IS_ENABLED(CONFIG_GPIO_F7188X))
> -			return -ENODEV;
>  		request_module("gpio-f7188x");
>  		simatic_ipc_led_gpio_table =
> &simatic_ipc_led_gpio_table_227g; break;
> @@ -99,21 +98,19 @@ static int simatic_ipc_leds_gpio_probe(struct
> platform_device *pdev) goto out;
>  	}
>  
> -	/* PM_BIOS_BOOT_N */
> -	gpiod = gpiod_get_index(&simatic_leds_pdev->dev, NULL, 6,
> GPIOD_OUT_LOW);
> -	if (IS_ERR(gpiod)) {
> -		err = PTR_ERR(gpiod);
> -		goto out;
> -	}
> -	gpiod_put(gpiod);
> -
> -	/* PM_WDT_OUT */
> -	gpiod = gpiod_get_index(&simatic_leds_pdev->dev, NULL, 7,
> GPIOD_OUT_LOW);
> -	if (IS_ERR(gpiod)) {
> -		err = PTR_ERR(gpiod);
> -		goto out;
> +	for (i = 0; i < 2; i++) {
> +		gpiod = gpiod_get_index(&simatic_leds_pdev->dev,
> NULL,
> +
> ARRAY_SIZE(simatic_ipc_gpio_leds) + i, GPIOD_OUT_LOW);
> +		if (IS_ERR(gpiod)) {
> +			err = PTR_ERR(gpiod);
> +			if (err == -EPROBE_DEFER) {
> +				dev_err(&pdev->dev, "GPIO driver
> seems missing\n");
> +				err = -ENODEV;
> +			}
> +			goto out;
> +		}
> +		gpiod_put(gpiod);
>  	}
> -	gpiod_put(gpiod);
>  
>  	return 0;
>  out:

