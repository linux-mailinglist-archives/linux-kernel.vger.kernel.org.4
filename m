Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F78A613A17
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 16:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbiJaPe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 11:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbiJaPeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 11:34:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406ADD4D;
        Mon, 31 Oct 2022 08:34:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF6B2612AE;
        Mon, 31 Oct 2022 15:34:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85139C433D6;
        Mon, 31 Oct 2022 15:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667230462;
        bh=YZKK1jmMNBRS3vI6+V6mXONYJ1rL8Poxh89EpPkyyfU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vAMNGGe4khNcswkuLi4L+n0qzpu/iT/AunoJGdxwtKzaOwQOXXCc2d+FBwIJamm2z
         8FNaXjtqGU7uyoooVyLHe2eOnM7V3H1YzYVAzZHchnKu9CPUGCsWjxnqQGqH/nm6PB
         l5FM5NcU1otYMejLJvamM4Os0RrOg+UXs5v/kDKNwkByYYxH25gbIGZQ5d46Klfp47
         FNo3E/rg98XtDMsAczlXTrdJzYs0UaTfO28WwVoGNytpyeIwIxe3n3tJXidhvum+RB
         +CgK4B6LMP92YFME8zptRTNETURjy7gzTp24Z7VCGXdC35XqDoV3BAXWbDvXgyuydc
         98mIT8SHrI40w==
Date:   Mon, 31 Oct 2022 15:34:17 +0000
From:   Lee Jones <lee@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: rn5t618: add support for read out bootstatus
Message-ID: <Y1/q+WA+jf0zswrl@google.com>
References: <20221028075019.2757812-1-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221028075019.2757812-1-marcus.folkesson@gmail.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Oct 2022, Marcus Folkesson wrote:

> The PMIC does store the power-off factor internally.
> Read it out and report it as bootstatus.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
>  drivers/watchdog/rn5t618_wdt.c | 12 ++++++++++++

>  include/linux/mfd/rn5t618.h    |  9 +++++++++

Acked-by: Lee Jones <lee@kernel.org>

>  2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/watchdog/rn5t618_wdt.c b/drivers/watchdog/rn5t618_wdt.c
> index 6e524c8e26a8..40d8ebd8c0ac 100644
> --- a/drivers/watchdog/rn5t618_wdt.c
> +++ b/drivers/watchdog/rn5t618_wdt.c
> @@ -144,6 +144,8 @@ static int rn5t618_wdt_probe(struct platform_device *pdev)
>  	struct rn5t618 *rn5t618 = dev_get_drvdata(dev->parent);
>  	struct rn5t618_wdt *wdt;
>  	int min_timeout, max_timeout;
> +	int ret;
> +	unsigned int val;
>  
>  	wdt = devm_kzalloc(dev, sizeof(struct rn5t618_wdt), GFP_KERNEL);
>  	if (!wdt)
> @@ -160,6 +162,16 @@ static int rn5t618_wdt_probe(struct platform_device *pdev)
>  	wdt->wdt_dev.timeout = max_timeout;
>  	wdt->wdt_dev.parent = dev;
>  
> +	/* Read out previous power-off factor */
> +	ret = regmap_read(wdt->rn5t618->regmap, RN5T618_POFFHIS, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val & RN5T618_POFFHIS_VINDET)
> +		wdt->wdt_dev.bootstatus = WDIOF_POWERUNDER;
> +	else if (val & RN5T618_POFFHIS_WDG)
> +		wdt->wdt_dev.bootstatus = WDIOF_CARDRESET;
> +
>  	watchdog_set_drvdata(&wdt->wdt_dev, wdt);
>  	watchdog_init_timeout(&wdt->wdt_dev, timeout, dev);
>  	watchdog_set_nowayout(&wdt->wdt_dev, nowayout);
> diff --git a/include/linux/mfd/rn5t618.h b/include/linux/mfd/rn5t618.h
> index 8aa0bda1af4f..aacb6d51e99c 100644
> --- a/include/linux/mfd/rn5t618.h
> +++ b/include/linux/mfd/rn5t618.h
> @@ -227,6 +227,15 @@
>  #define RN5T618_WATCHDOG_WDOGTIM_S	0
>  #define RN5T618_PWRIRQ_IR_WDOG		BIT(6)
>  
> +#define RN5T618_POFFHIS_PWRON		BIT(0)
> +#define RN5T618_POFFHIS_TSHUT		BIT(1)
> +#define RN5T618_POFFHIS_VINDET		BIT(2)
> +#define RN5T618_POFFHIS_IODET		BIT(3)
> +#define RN5T618_POFFHIS_CPU		BIT(4)
> +#define RN5T618_POFFHIS_WDG		BIT(5)
> +#define RN5T618_POFFHIS_DCLIM		BIT(6)
> +#define RN5T618_POFFHIS_N_OE		BIT(7)
> +
>  enum {
>  	RN5T618_DCDC1,
>  	RN5T618_DCDC2,

-- 
Lee Jones [李琼斯]
