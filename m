Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB795F8193
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 02:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiJHA2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 20:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiJHA2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 20:28:21 -0400
Received: from proxmox1.postmarketos.org (proxmox1.postmarketos.org [213.239.216.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 59BBBBE2CF;
        Fri,  7 Oct 2022 17:28:17 -0700 (PDT)
Received: from [192.168.20.2] (unknown [77.239.252.99])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by proxmox1.postmarketos.org (Postfix) with ESMTPSA id 0E66C1400F8;
        Sat,  8 Oct 2022 00:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
        s=donut; t=1665188895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f0zdQeYgf/ToW2BBlsYl7mtXmi8A/E12FwtrlpMw834=;
        b=y2slcH71PCWLYvM1D/ge/XIMHeAX0ypPRFiTMOfcB4WB5grIYnNPFS0DgyhRXqZo67pjw7
        fU0h3VvKjyL7XBuurKYslV2QYJdbmrTeWwD3b6aes4f+FssClFNZYEiepynYlv4pUa9ax1
        TKSAzdSqcwSc3g4Y9Kg0IorXD8TEsYI=
Message-ID: <fd332d80-b237-08be-e6d1-903364bd5ceb@postmarketos.org>
Date:   Sat, 8 Oct 2022 03:28:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 1/2] drivers: gpu: drm: add driver for samsung
 s6e3fc2x01 cmd mode panel
Content-Language: en-US
To:     Nia Espera <a5b6@riseup.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org
References: <20221007111442.51481-1-a5b6@riseup.net>
 <20221007111442.51481-2-a5b6@riseup.net>
From:   Alexey Minnekhanov <alexeymin@postmarketos.org>
In-Reply-To: <20221007111442.51481-2-a5b6@riseup.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07.10.2022 14:14, Nia Espera wrote:

> +
> +#define dsi_dcs_write_seq(dsi, seq...) do {				\
> +		static const u8 d[] = { seq };				\
> +		int ret;						\
> +		ret = mipi_dsi_dcs_write_buffer(dsi, d, ARRAY_SIZE(d));	\
> +		if (ret < 0)						\
> +			return ret;					\
> +	} while (0)
> +

There is now a standard macro for this - mipi_dsi_dcs_write_seq() [1] , 
so you don't need to reinvent it.

> +static void samsung_s6e3fc2x01_reset(struct samsung_s6e3fc2x01 *ctx)
> +{
> +	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
> +	usleep_range(5000, 6000);
> +	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> +	usleep_range(2000, 3000);
> +	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
> +	usleep_range(10000, 11000);
> +}

There is a high chance that first gpiod_set_value() is not needed, only 
the last 2.

[1] https://elixir.bootlin.com/linux/latest/C/ident/mipi_dsi_dcs_write_seq

-- 
Regards
Alexey Minnekhanov
