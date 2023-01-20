Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDC967586C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 16:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbjATPWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 10:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjATPWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 10:22:15 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090E4D88D3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 07:22:14 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id y1so660666wru.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 07:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e66wvT2cYhyX/VhocVEC2K4AIk/Eq3siPRf4a8anMOs=;
        b=MJOd3jW56sN+TtE2GfOLbP+U5xkl3RdCC9kDkRCaN7L7kCAMl1EzJg5j0QN/gPTxV5
         D2e3NaNE14+9Gw8lr0KHI4UR5WHy5Nawzg/ozemBWkNFUyGwVenKcx5cYpQUzedWFZWn
         lyn7FvPVoaFjx3+/M1CB71dYdgTzWFBzzNh5kvHSqCP4m1LHGItjhrR8gn9NmnCzzeS4
         3Y4guUqLEFAUhyDHeekzwLPhLvMM7LBCWNMDp3PaaBpROay90Hyv2fOI+KNK6EBSS0gj
         XqTlmEeCoG8qbwQNUyiQfc9EtsXw8AFlpWZCUHSTOPtHDD4N2q5sRp/bkxI4KBbgaZyI
         a3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e66wvT2cYhyX/VhocVEC2K4AIk/Eq3siPRf4a8anMOs=;
        b=77z0d2Jflef5IIUy2SV1AiLB/v6I7J5+hFE+F0vgyMKh920Tu0NZx9ISfEd3OCDF9L
         tX1xP2yVNqII4FlkxmFOHTBLo2QgN0hZmTYoITR/tZEEvqBVWKBlxd+YDi646kyOyS6z
         /ICDn3045o4x3g+7UGsB3zYaHphR3Pf+uCysQmgdAuMPF4zN57Fm3PbabvSIWdlQcTvj
         NcblxkuXMKdAK3LWzx9CBL+RhzOTC1sjMV3G9KuiM68y/Pei8pLeKb4bEziy2GL30sqR
         nh/kbNtQ3sCAU8QR3qg9441RJ19oYl+wgLIT1BeJ7s1QdoVTIWSLHyuDqIcJEt3TCyJP
         8jfg==
X-Gm-Message-State: AFqh2krV2tkGLbL2PV1ezSq7BmtDERq6Q8AndVPP7wTzYWoNgvvDMpYl
        6cX5MFWgVFoKp7XxEJpyLXpxhw==
X-Google-Smtp-Source: AMrXdXuOgJzWPQP060GD7ksOJ6DOg0wj3Av/2do2thSt0DkXEk0SqqqCOrzxE0k1EEUYd4bwLeOnoQ==
X-Received: by 2002:a05:6000:1c0e:b0:26f:6bf:348f with SMTP id ba14-20020a0560001c0e00b0026f06bf348fmr10175721wrb.6.1674228132480;
        Fri, 20 Jan 2023 07:22:12 -0800 (PST)
Received: from aspen.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id j14-20020adff00e000000b0024cb961b6aesm35433341wro.104.2023.01.20.07.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 07:22:11 -0800 (PST)
Date:   Fri, 20 Jan 2023 15:22:09 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Jianhua Lu <lujianhua000@gmail.com>
Cc:     Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v7 1/2] dt-bindings: leds: backlight: Add Kinetic KTZ8866
 backlight
Message-ID: <Y8qxofrfiQbRmsGZ@aspen.lan>
References: <20230120094728.19967-1-lujianhua000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120094728.19967-1-lujianhua000@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 05:47:27PM +0800, Jianhua Lu wrote:
> Add Kinetic KTZ8866 backlight binding documentation.
>
> Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
> [...]
>
> diff --git a/Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml b/Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml
> new file mode 100644
> index 000000000000..b1d0ade0dfb6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml
> @@ -0,0 +1,74 @@
> [...]
> +  current-ramping-time-ms:
> +    description: LED current ramping time in milliseconds.
> +    enum: [2, 4, 8, 16, 32, 64, 128, 192, 256, 320, 384, 448, 512, 576, 640]

This doesn't look like it goes low enough (wasn't there a value lower
than 2?).


Daniel.
