Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDBB074FD17
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 04:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbjGLCcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 22:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbjGLCcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 22:32:31 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728F81732;
        Tue, 11 Jul 2023 19:32:30 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-57eb0df5265so930597b3.3;
        Tue, 11 Jul 2023 19:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689129149; x=1691721149;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hBKRW0S5Mf8blCkjHGiPQy6RjmAAGKAQMgdU5bPh7yg=;
        b=TN9VpxjghrJpLa6pizkPJyUxH7T0CXkRCDx1lqBd1LQ3tE0xAcvpvplgsJcF0TGpBe
         AW0oX5aKcY5dh1gk/gc0QUBPLUKnPdpIeqWmddVDCMk73PJ/Yd6L1veOv1MQGBDePBUi
         MOmEX39OQ4r2GzwDLIEVF/BAIaovClWBCHozGcYKkhQMYDdrRFEEr1AId0Bzo6RI21xo
         5X7IXzsW1Af1PJZb2hWD0PZeKFDLr3zGDz8BGNffp7kJHEfkgaL/q9s4zQqfiZk6UEw8
         nN15HhNesNe0Rie+QchwYSeJqcrQ4lcezdLUIOWSeFXmlYHkAjW+5+wPyZXuz7vVes2I
         qamA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689129149; x=1691721149;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hBKRW0S5Mf8blCkjHGiPQy6RjmAAGKAQMgdU5bPh7yg=;
        b=K2vYrqMGLfrbiOp/5OrgAovPzJQMXNOYblZYa/k0PPf6od0pCpgR70ialhTqhvHIQm
         qRQhXanAIwzSQjWvaVVVbvWlOsjvsqw+d52SxOqNelcMInwSXgOAk+Tz9YQOUf4ZPxdp
         EHQmc/6vmW38w9NodkmB/AhbI9/mFtox6QJxIg2E87YSHEoGKtD6UXEyIb3DGUDxsFyZ
         pJazT5L18KXUUZYOQUlhcFnlx7wLDuvMbfu05oQo/U5YJ4S6tZbexUE5XcS2+5Z6s0gL
         RkrAN6luE5pcvM+B9GgCPGgntsFzBBCHBMeRGL4Jy2uKZY+QCvcNmHe5DG6gkhdXHv4I
         +F0w==
X-Gm-Message-State: ABy/qLbP43J8KruzfA/Jj9VqykPGlcAF1DbBJypAZl5/vXy7eItNIehU
        4ATDnG2u4P7VgnPs3EENR0lyD8zwVOA=
X-Google-Smtp-Source: APBJJlE/yn2HzUXc1Hn94yj0zHnXdSrZLWYykA7s7blZ+3XMAgHzzwVEhwzl/44UKkqUMAla+V3cJg==
X-Received: by 2002:a81:6dd7:0:b0:559:ed0a:96c4 with SMTP id i206-20020a816dd7000000b00559ed0a96c4mr15761340ywc.44.1689129149398;
        Tue, 11 Jul 2023 19:32:29 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v145-20020a814897000000b0057a8de72338sm918311ywa.68.2023.07.11.19.32.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 19:32:28 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <165cf95b-663b-5dac-b686-a515f2111656@roeck-us.net>
Date:   Tue, 11 Jul 2023 19:32:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
To:     huaqian.li@siemens.com, wim@linux-watchdog.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     huaqianlee@gmail.com, nm@ti.com, vigneshr@ti.com,
        kristo@kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jan.kiszka@siemens.com,
        baocheng.su@siemens.com
References: <20230711091713.1113010-1-huaqian.li@siemens.com>
 <20230711091713.1113010-4-huaqian.li@siemens.com>
Content-Language: en-US
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 3/3] watchdog:rit_wdt: Add support for WDIOF_CARDRESET
In-Reply-To: <20230711091713.1113010-4-huaqian.li@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/23 02:17, huaqian.li@siemens.com wrote:
> From: Li Hua Qian <huaqian.li@siemens.com>
> 
> This patch adds the WDIOF_CARDRESET support for the platform watchdog
> whose hardware does not support this feature, to know if the board
> reboot is due to a watchdog reset.
> 
> This is done via reserved memory(RAM), which indicates if specific
> info saved, triggering the watchdog reset in last boot.
> 
> Signed-off-by: Li Hua Qian <huaqian.li@siemens.com>
> ---
>   drivers/watchdog/rti_wdt.c | 48 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 48 insertions(+)
> 
> diff --git a/drivers/watchdog/rti_wdt.c b/drivers/watchdog/rti_wdt.c
> index ce8f18e93aa9..77fd6b54137c 100644
> --- a/drivers/watchdog/rti_wdt.c
> +++ b/drivers/watchdog/rti_wdt.c
> @@ -18,6 +18,7 @@
>   #include <linux/pm_runtime.h>
>   #include <linux/types.h>
>   #include <linux/watchdog.h>
> +#include <linux/of.h>
>   
>   #define DEFAULT_HEARTBEAT 60
>   
> @@ -52,6 +53,11 @@
>   
>   #define DWDST			BIT(1)
>   
> +#define PON_REASON_SOF_NUM	0xBBBBCCCC
> +#define PON_REASON_MAGIC_NUM	0xDDDDDDDD
> +#define PON_REASON_EOF_NUM	0xCCCCBBBB
> +#define PON_REASON_ITEM_BITS	0xFFFFFFFF
> +
>   static int heartbeat = DEFAULT_HEARTBEAT;
>   
>   /*
> @@ -198,6 +204,11 @@ static int rti_wdt_probe(struct platform_device *pdev)
>   	struct rti_wdt_device *wdt;
>   	struct clk *clk;
>   	u32 last_ping = 0;
> +	u32 reserved_mem_size;
> +	unsigned long *vaddr;
> +	unsigned long paddr;
> +	u32 data[3];
> +	u32 reg[8];
>   
>   	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
>   	if (!wdt)
> @@ -284,6 +295,43 @@ static int rti_wdt_probe(struct platform_device *pdev)
>   		}
>   	}
>   
> +	ret = of_property_read_variable_u32_array(pdev->dev.of_node, "reg", reg,
> +					 0, ARRAY_SIZE(reg));
> +	if (ret < 0) {
> +		dev_err(dev, "cannot read the reg info.\n");
> +		goto err_iomap;
> +	}

This aborts if the property does not exist, which is unacceptable.
Any such addition must be optional.

> +
> +	/*
> +	 * If reserved memory is defined for watchdog reset cause.
> +	 * Readout the Power-on(PON) reason and pass to bootstatus.
> +	 */
> +	if (ret == 8) {
> +		paddr = reg[5];
> +		reserved_mem_size = reg[7];

It seems odd that reserved_mem_size is not checked, and that it is even provided
given that it needs to be (at least) 24 bytes, and any other value does not really
make sense.

> +		vaddr = memremap(paddr, reserved_mem_size, MEMREMAP_WB);
> +		if (vaddr == NULL) {
> +			dev_err(dev, "Failed to map memory-region.\n");
> +			goto err_iomap;

This returns 8, which would be an odd error return.

> +		}
> +
> +		data[0] = *vaddr & PON_REASON_ITEM_BITS;
> +		data[1] = *(vaddr + 1) & PON_REASON_ITEM_BITS;
> +		data[2] = *(vaddr + 2) & PON_REASON_ITEM_BITS;
> +

The & seems pointless / wasteful. Why ignore the upper 32 bits of each location ?
Either make it u32 or make it u64 and use the entire 64 bit. Besides,
vaddr[0..2] would make the code much easier to read.

> +		dev_dbg(dev, "Watchdog: sof = %lX, data = %lX, eof = %lX\n",
> +			data[0], data[1], data[2]);
> +
> +		if ((data[0] == PON_REASON_SOF_NUM)
> +		    && (data[1] == PON_REASON_MAGIC_NUM)
> +		    && (data[1] == PON_REASON_MAGIC_NUM)) {

Unnecessary inner (), and I don't see the point of checking data[1] twice.

> +			dev_info(dev, "Watchdog reset cause detected.\n");

Unnecessary noise.

> +			wdd->bootstatus |= WDIOF_CARDRESET;
> +		}
> +		memset(vaddr, 0, reserved_mem_size);
> +		memunmap(vaddr);
> +	}

And some random data in the property is acceptable ? That is odd, especially
after mandating the property itself.

> +
>   	watchdog_init_timeout(wdd, heartbeat, dev);
>   
>   	ret = watchdog_register_device(wdd);

