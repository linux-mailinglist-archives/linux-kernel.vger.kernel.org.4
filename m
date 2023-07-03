Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35423745C43
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 14:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjGCMcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 08:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjGCMcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 08:32:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDB011F;
        Mon,  3 Jul 2023 05:32:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1415560F18;
        Mon,  3 Jul 2023 12:32:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B2C0C433C8;
        Mon,  3 Jul 2023 12:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688387529;
        bh=2/husCvkcEMDjaWaMzRO/j2CEaYbnp5CmDWbmX1r1QQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dkIdbcljYerHxxzOkD8YGtGbav2domP/skg5GFO/rT9F5JYTNyeWqmCVQAGu/IG8B
         DJlFy9VDya8IIdUg7hT50LkzzWjxHw8wL9VVOZyA21mCXQjk0S+gwheicj/WnfySeR
         NhRqnKAeQjFp9wRddwfHxvucHvRFsy+wvWxTn7rObIhnSiowZyzc750cgYjyCKWSjF
         5vMiuVl1bWSJB15mx4MbLjwRVr0/ewW5KJFKmh9eDfZjaeDGix44iPYZHwisRwLH92
         TObYw8fL2C1tt8iHS59/T7JMHRJXnavVYm5L3xpQHNarZ9sPKKrF1YNUOOuzjZbJB6
         pcruE309cNNTA==
Message-ID: <f4873823-fd7e-c6dd-fbc0-eac4a9be52b1@kernel.org>
Date:   Mon, 3 Jul 2023 14:31:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 1/5] genirq/devres: Add
 devm_request_threaded_irq_emsg()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, miquel.raynal@bootlin.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, mmayer@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com,
        florian.fainelli@broadcom.com, tglx@linutronix.de,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        bchihi@baylibre.com, wenst@chromium.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230703090455.62101-1-frank.li@vivo.com>
 <20230703090455.62101-2-frank.li@vivo.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230703090455.62101-2-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/2023 11:04, Yangtao Li wrote:
> There are more than 700 calls to the devm_request_threaded_irq method.
> Most drivers only request one interrupt resource, and these error
> messages are basically the same. If error messages are printed
> everywhere, more than 1000 lines of code can be saved by removing the
> msg in the driver.


...

> +int devm_request_threaded_irq_emsg(struct device *dev, unsigned int irq,
> +				   irq_handler_t handler, irq_handler_t thread_fn,
> +				   unsigned long irqflags, const char *devname,
> +				   void *dev_id, const char *emsg)
> +{
> +	int rc;
> +
> +	rc = devm_request_threaded_irq(dev, irq, handler, NULL, irqflags,
> +				       devname, dev_id);
> +	if (rc && rc != -EPROBE_DEFER) {
> +		dev_err(dev, "Failed to request %sinterrupt %u %s %s: %pe\n",
> +			thread_fn ? "threaded " : "", irq, devname ? : dev_name(dev),
> +			emsg ? : "", ERR_PTR(rc));

It is open-coding dev_err_probe(). Just use dev_err_probe instead.

Best regards,
Krzysztof

