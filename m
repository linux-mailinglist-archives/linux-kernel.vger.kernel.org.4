Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E07E6794FB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 11:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbjAXKPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 05:15:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjAXKPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 05:15:51 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547C52B614
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 02:15:50 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id k16so11025779wms.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 02:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8un66zLwO3rwD/g45VoCRqCtHHjJIgDrgaIv4nHBGpE=;
        b=5IzoJ/Bo+JeI4g40vilzNuB+88HZ/EY6bz6sZzs5cuM8K3Z4Jag+2N+Bt9AH1ZDhTs
         wTd1EpkTQNdqmImQ5tjSPfe/5WpGGQCx/vE/eN6pF/CgzysDahv0gn/vAbORoZno+AHg
         lUfo5jRmwW2PhE7+z8HMDAMpPxiF6mA4Uxc/Vp4ybinBds0zTCEzMRaBhZfVfs7g4fRI
         KjZxBHqVLv8OodHM4I2P7bBxipJCN5n/ojhaZjmYZTpVEnKjVjJGQr4BSw6s1J3NB6pu
         DKQckZDidtxrIUoM/j8IumK5yd2uDp/LBgfT2Hnmfnehbvg1MCGda+h/++crN2fXSn/W
         loFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8un66zLwO3rwD/g45VoCRqCtHHjJIgDrgaIv4nHBGpE=;
        b=rAfxDUL6MzMP+X9YeFrHwfFMi0mxcCxMgkJ9+ZEu/PmwlOXttms6aynoStX4bwDacr
         jGGN9Npg5EhG4C+UR0MgT0GCIg5Uq75zBlckH6rhOWZCv7TxI9H1eic8FCwuFR/80Aiv
         Uc8Zdl3d9rjWKSBaZUGtg/2nVtSGkEE190JY0a87LnKoEENUG34S4LhuDHpXqFM6YMT+
         ETkgiRkz5TE7iZBfBiEDbI0vYJhBr6REfMclsckFf6wTGFrLbXzy8p7AORYIdEZpHEFD
         cUzpDnDUp/naeSQefYqgBNU74CCXDEVLnRv3alXo6LR15U5MNE1kKVkF0frTEgyaCyHd
         xsGg==
X-Gm-Message-State: AFqh2koVBX7SDcSPZnPCpx0M18v/K95hrkP12CB3eucTFaCgFhuL0KxN
        ndBbXNGr/29HmDy36yl+wtyhJg==
X-Google-Smtp-Source: AMrXdXtQiMObKKnyrAyRqjP0D7+AWlOOZakV4ioA/j5cJIYDShX8yJFxBIZJDH9OEpfYy+gS2u1A8A==
X-Received: by 2002:a05:600c:46cb:b0:3db:1afd:ac45 with SMTP id q11-20020a05600c46cb00b003db1afdac45mr22087623wmo.7.1674555348765;
        Tue, 24 Jan 2023 02:15:48 -0800 (PST)
Received: from localhost ([82.66.159.240])
        by smtp.gmail.com with ESMTPSA id g10-20020a05600c310a00b003d99da8d30asm14069634wmo.46.2023.01.24.02.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 02:15:48 -0800 (PST)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Miaoqian Lin <linmq006@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Rob Herring <robh@kernel.org>, Eric Anholt <eric@anholt.net>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        linux-input@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] input: raspberrypi-ts: Fix refcount leak in
 rpi_ts_probe
In-Reply-To: <20221223074657.810346-1-linmq006@gmail.com>
References: <20221223074657.810346-1-linmq006@gmail.com>
Date:   Tue, 24 Jan 2023 11:15:47 +0100
Message-ID: <87zga81bn0.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 11:46, Miaoqian Lin <linmq006@gmail.com> wrote:

> rpi_firmware_get() take reference, we need to release it in error paths
> as well. Use devm_rpi_firmware_get() helper to handling the resources.
> Also remove the existing rpi_firmware_put().
>
> Fixes: 0b9f28fed3f7 ("Input: add official Raspberry Pi's touchscreen driver")
> Fixes: 3b8ddff780b7 ("input: raspberrypi-ts: Release firmware handle when not needed")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
> changes in v2:
> - use devm_rpi_firmware_get().
> - remove rpi_firmware_put().

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  drivers/input/touchscreen/raspberrypi-ts.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/input/touchscreen/raspberrypi-ts.c b/drivers/input/touchscreen/raspberrypi-ts.c
> index 5000f5fd9ec3..45c575df994e 100644
> --- a/drivers/input/touchscreen/raspberrypi-ts.c
> +++ b/drivers/input/touchscreen/raspberrypi-ts.c
> @@ -134,7 +134,7 @@ static int rpi_ts_probe(struct platform_device *pdev)
>  		return -ENOENT;
>  	}
>  
> -	fw = rpi_firmware_get(fw_node);
> +	fw = devm_rpi_firmware_get(&pdev->dev, fw_node);
>  	of_node_put(fw_node);
>  	if (!fw)
>  		return -EPROBE_DEFER;
> @@ -160,7 +160,6 @@ static int rpi_ts_probe(struct platform_device *pdev)
>  	touchbuf = (u32)ts->fw_regs_phys;
>  	error = rpi_firmware_property(fw, RPI_FIRMWARE_FRAMEBUFFER_SET_TOUCHBUF,
>  				      &touchbuf, sizeof(touchbuf));
> -	rpi_firmware_put(fw);
>  	if (error || touchbuf != 0) {
>  		dev_warn(dev, "Failed to set touchbuf, %d\n", error);
>  		return error;
> -- 
> 2.25.1
