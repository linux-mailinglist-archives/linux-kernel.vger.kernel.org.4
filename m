Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB8467B960
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 19:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235628AbjAYSa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 13:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235949AbjAYSar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 13:30:47 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2044.outbound.protection.outlook.com [40.107.8.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F289822DFD;
        Wed, 25 Jan 2023 10:30:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nY2U6FI1huhPubzSwllALkMyoDHqAfaBKKZso9bBKhgWCvDD4s3FHjvmGBn9DcG0xsQ7QtPf4AyD2W2S40DGrEpAVndDmzO5MNtQErf+koxr1nv2QcLV7BAYOkSrfs4FgzxaRfL+q88yEg6wXzado1Fe1cVGgbLNUzRorUcUeuoui6FNUUCFjqbOLTXkCmej++nGulDqVhEIolz9wTjDALdHzojaxdzOe8/iFv7HUe1JjwJzsxyK2kcTJhuO8P3syPhDIa7F52RtiSq+IrutzAClF/h/0s9ktHkr+sgjGYgp2U1pW50EzIHrQ7zbPYscur6iuKkPsywek6bMx+R9UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HsXZFbOqKuKMOwemlZdQQ9d1LzCjXsKWNlPjIeJCiEo=;
 b=oaMbGKwVWfMbeu3NV0GYUWmIUf+h9FHwQAY9UPL6I5QG2M4MacQ7lYd3+XPtE30HyLWBmsK6suGvh1cl3lUV292VbPSddE1PzxTTpg3ujo+JovhmgYRm7rxMgEnanDsBGQfgi3wlJaToUj6n5hOy8HER001SNNEKs9wVW8bOzpWT792uPrg6OxFu316o8W25+odhJtyPFpm6WTa7ZRH8MgZgQ3Kpv09ODjXZyECq9hDRGcU5qiD5cu+GPYJcmhZC1DZi4qLE0yP5gHvFROD71xHFCf7ttYnVwABai+W2gdcVyPVk+OfW809K5gCmBdACYzthZJHHcmXECYVavrPD8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HsXZFbOqKuKMOwemlZdQQ9d1LzCjXsKWNlPjIeJCiEo=;
 b=iYbaP/UXuiWycnfaHBeE4LNpU2h1wcoKOg2os6sMtG/QtHhaNg7WDxhJ9Yw/L7TEoSDzMfQxOftwpus9slRVUIuRkzwbSL5DvhckNZQQG405EJtdA1W78DG80jzQcHZy4VKmvsvveHyNWkDA1gQJgk+WyO/nb4+jpueUAlJ8QV8x7IFBLsC/o/QS/EwxByOwItIzWapYmOZ+JFA45twTMlvXhubQuctpy/7U+8hEUiAULvh7lNgiBo47PWs9AEqlloU+lapQWoqTjYa+zTaJrLSwJnYUWGnJSedlUb0G0efVAyHr33jzt7gUMhAf/MzGmZBI6Y7IiliKsc96LXjhlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by AS8PR10MB6649.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:565::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Wed, 25 Jan
 2023 18:30:37 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bdf0:fdeb:f955:bc79]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bdf0:fdeb:f955:bc79%4]) with mapi id 15.20.6002.033; Wed, 25 Jan 2023
 18:30:37 +0000
Date:   Wed, 25 Jan 2023 19:30:34 +0100
From:   Henning Schild <henning.schild@siemens.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] leds: simatic-ipc-leds-gpio: do not run into endless
 EPROBE_DEFER loop
Message-ID: <20230125193034.77ab5aec@md1za8fc.ad001.siemens.net>
In-Reply-To: <20230125181711.30844-1-henning.schild@siemens.com>
References: <20230125181711.30844-1-henning.schild@siemens.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.35; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR0202CA0013.eurprd02.prod.outlook.com
 (2603:10a6:203:69::23) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|AS8PR10MB6649:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b7df591-2edf-4fa1-ff99-08daff024111
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2D53LIPUrvnCBBWx4RLivrVCEbRZEXZriGAwdqh68oEv/poFvlSA3QLAP0O9vqs+q868LosfRRu5AKjU4fwYQ79G94G7uzw324yUlneENPhEbvxkxpapVcQI1AuqpZYJd0pAeX86y4h6UTxAb1P89ALWZpxnNWZUc0e7mE+GxmD2f4MHW9Dm4hZeYnB75tmJ3xw28fq+oivLvLtinzU53GMGIoA0jxNLpoxxeahSODE9atQMXwERm5uFuJ5YOPvkLWIprwYAU8bzXHbXyQhIj+sHlRd1jPg8LNU9ofpYL6iLqrHA5IA4KZQ9DsodTKHso/1swdvjmx29biZMLtg7OXJWofZVVtFBWUn+wzTVbDpiqHv88zU7a7RhK+TV+pN//Ka/1hoh2iPTLvsX81ObTTHN1G+BJlj5K0mYWIpHLbU/n/OR/IbrzoB6pOsGYDxuMGvxZZXVqFzeOxIP4gV60zV6r3Msa4hQKl/gCQz5S2AhmY2YebjrU6KWyt/IvQe04WiLtsh1EZJOJHWa2KY8p0Twb1LSC3XFxQ+HJH5X0H/tz5WnMi3htIh/7daACs0vqbPygrUPqV4t/EiQSaFcbCeLxb06H99uknZ7RIfi5Mi8QxtK1viVgY7aRbUjgjvJ77OiVRZrtNZo9AXjws0U7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(39860400002)(346002)(366004)(376002)(451199018)(83380400001)(316002)(41300700001)(2906002)(186003)(6666004)(6512007)(8936002)(38100700002)(9686003)(478600001)(82960400001)(86362001)(6486002)(6506007)(8676002)(5660300002)(66946007)(66476007)(110136005)(66556008)(1076003)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U2dkC5a2ijBqBNr+yXesDutW/dBYz1t8H8sR02Vp2I7zhovIp62Rnur2wJAa?=
 =?us-ascii?Q?dnc/4spUMejyWDEU+L8+VPMrvtlWFrj0oMT9WyLkEJMO42XjdeMuSDGUZUa/?=
 =?us-ascii?Q?yNL8DMnQrJSS8WJusbhjbIeXoMFz+R4TUPO0LUmzS+/VpAMTdgGMBSn7is2i?=
 =?us-ascii?Q?WV2ctFya1XHvPoo6diNPsXdCaB2F5dJ/+Rks8okcz0qWfyjyzEJWKvSELiCd?=
 =?us-ascii?Q?5owYF3R4Rw1i7+0tnjIrDu16eKlmCn2yGES2QRX8rCIk4edBBXsaaT89LlPy?=
 =?us-ascii?Q?PkXoWuIzepgizLWj5lqMrJ+aiKoTMr7wqsLjFXsoKBaGx6MAYVrftwTPvSXB?=
 =?us-ascii?Q?VoMg+vkg2KlDOG1XB6G1+bhbFWGfZU1cHCPuAU6UTxYCAiii+2q2anjq6Krj?=
 =?us-ascii?Q?LGmiut2hyVPxqAFFjfOGdOroVx+voscQKp3nTgcMU3LVkArwpqUFJu9Cwqf3?=
 =?us-ascii?Q?n9sxuMZErTR2RNHPiCYOk73+7sL5+ZXyNrVdY9QMEP+4fGyooSa+V/2ImzEQ?=
 =?us-ascii?Q?aYf567dILpQkgGgSHKePudIDiKWB9qRmqNEZWAVvpNryGxygMWZZaM7fkq2y?=
 =?us-ascii?Q?oBtUCvdhR8SGSB4SZO2UNVmqaRnwDiO5s3IB9l1SphvR6s4UOgPDVkfSi6+D?=
 =?us-ascii?Q?dZzL1SybLUldVYbWnbJscIGFQbIrNJ2fNj4a7mlIvuhGD9/fEkLRJLeEMcNP?=
 =?us-ascii?Q?MZl5sNcIyzucnnHbe+jluu47R+RkMFUF2kBUlOZV8FVl4l8+hSZqJ+zue/Ug?=
 =?us-ascii?Q?YquARn8/nOGDoLocDMyq0qu7eckLz1TvylqSrRQQi2VSbzsY+SXiyXFtg51b?=
 =?us-ascii?Q?1eetsqJ5SaMnld53A9RKN7flNmYD176mtzFh7nJ8kbd5yYm94IAQysypATH0?=
 =?us-ascii?Q?5XucNxsWQGb8PN8FoHd4a/96Dnui2R/75wn+/+5tSSMXX213uo5PZStsUYkG?=
 =?us-ascii?Q?SWYgWbU7AFGdnY++9gk6jpKB8rYBcHR9Sr4AsgElFzFTJcwFBfxRd6fB/Ao7?=
 =?us-ascii?Q?KvTlKSTADsHp4cURU9mtkiPU1GQQZY2ZSZsvhF612E+BjC21efxEcevT2bQO?=
 =?us-ascii?Q?uaALltTGN3ynJUvsZYx4I1j1r5Ngb6IwT5OZQb/AiIhSKQ5m6Ti6EssfaCFv?=
 =?us-ascii?Q?Xnsj6xEU0BPI+zOBK0nwPiwZVXBq2tR9yjtfMnB+obse33cHJ1zdwFIRh+B/?=
 =?us-ascii?Q?a2OzVVyf5HaqlMGgyMk+0YNaEUulzJIzpq2/7QMWiON/kmat6uGmKLMZpZ+A?=
 =?us-ascii?Q?RxlRkLw4SXzo4b74awGmJomcDtAMHXd01eYYTcsT5FJGAnBFomN6/FQVD7As?=
 =?us-ascii?Q?Dgai3QlP9i3TkFKNgZbN8Nt2p0OMfWCUN/2gx7kwFwwPW96tUo0c4J8RLSHT?=
 =?us-ascii?Q?7LEqTgCqio0f9HJmjqsONgLzCYAv12hRL9ifriqcpnU9GtH4crkHUc/Av8k8?=
 =?us-ascii?Q?aJsOZNhscmu12bcEZr8F5HVykN7N0eR4LEyEbEwTG4lKEkBnTAM1XIv6mn/B?=
 =?us-ascii?Q?1/HTuc6h3SnDMhjy0ExewUtiqM4T5EpJAY1YC74OLCdkBZ+zpT74gUAp6DG1?=
 =?us-ascii?Q?XuoLMdCbK3O6OFDSvvQKdnnoxbHub+zHG/Wd+Eu2nwx4PAbIE6U0PVT26y7f?=
 =?us-ascii?Q?e4wjSI36r68X5lWCpwBLLubqIL1eMH7W83HFrQAbtWWR8ug1pKGa1yTp+127?=
 =?us-ascii?Q?kRtWpQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b7df591-2edf-4fa1-ff99-08daff024111
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 18:30:37.4937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KUJYmRsibgkzWuflHOhN4HYWr6zB4+cM2iy6Q6Tq/tQgYUP0xglQ82PUYhxqK+L3Im+ixDvWcsebm8CH1AjK8LZAxnNNkXX7a74XdT3tKes=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6649
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a replacement of what was sent as

[PATCH v4] leds: simatic-ipc-leds-gpio: make sure we have the GPIO
providing driver

earlier.

While that one is still valid, what i propose here is based on a
hopefully better understanding of the problem i was trying to solve.

That other one already entered some "about to merge" stages, so not
sure it can or should be stopped. If this one makes it the other one
can be reverted should it ever be merged as well.

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
> 
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

I tested this and it does work. But so far i could only test it on the
Super-IO based tigerlake box which uses
"request_module("gpio-f7188x");", not on the broxton where the pinctrl
driver gets loaded via some P2SB platform detection magic.

Not sure the probe order i want is guaranteed here. I always need the
probe order so that the pinctl driver is probed and create the GPIOs
before this driver probes. Otherwise this driver will give up early and
never try again.

Maybe it is already guaranteed or maybe i can also use request_module
for pinctrl-broxton as well to express the order i want. The
request_module for that Super-IO is actually not there for "ordering"
but to actually load a module which otherwise would not probe at all.

If request_module is an option and anything needs to be done, i will
add a comment to the two calls to say why there are there.

Henning

> +			}
> +			goto out;
> +		}
> +		gpiod_put(gpiod);
>  	}
> -	gpiod_put(gpiod);
>  
>  	return 0;
>  out:

