Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E404715F4A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 14:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjE3M2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 08:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjE3M2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 08:28:15 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE38FF
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 05:27:42 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5148ebc4b89so6388774a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 05:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685449660; x=1688041660;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mlnk799/MfyB54DQ8/eLtl8DYJIH7QAdWviYq7D2W+E=;
        b=yabZWQjhxV76ieZOcwL1QgqGXFdbyAPcvg4gA6AvveAl2Iz8NAKMYmReuySiJmc1Cg
         tE0SupZtraraFkF2PWWdUNgvLks4oInKExm0cvA3IZ4I026dgvWUKK4VfvqYB3Xq0al1
         YaWqyGUpOXyHXL/gAFpld4uzzD8RPMllYPjgO3JKnvEAKr9ENX218gDzbIm5rfcWfLvC
         owmyR6u/rHAZn1MAg8F6nq6wD7ZnR0nWIE+BUCNrHaHRpPUpLaPeMB1NV7SgKxm5xfaZ
         aYJcg6CnwtfvmjcnEt4ZC2xAL47yxCWJwpltUMT7TuHqkPy0TRpN4Xm18NsWllBZzzQK
         99bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685449660; x=1688041660;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mlnk799/MfyB54DQ8/eLtl8DYJIH7QAdWviYq7D2W+E=;
        b=CRJQBDrfCR9SK/2bl9iZ4kewTs35X+rfbdFbR8MftFt5VITdLAwCfVg8W5BZg0cGr8
         Pl4V/cVFLEHk+wBIKAeMxY4UdRIEibHaTEg3UMrbQ/8c1QYDiVZxLZk89Y4l2axIwRyq
         a3TGT6yWi9DcHZmJurz97ztIsTcB3aYghYUMHpd4+r3UzXAJGtS+TqZVHKKOoapZv2rJ
         NSn7uTbWgfjX0jku7QW9eewE8D7Ib+Y8WXWoNLariH1vH2njne6rTv7HmXep0CVhcsOu
         4OtaVWDdy8CBDROcESjgopUoR0xd54ipNWy+euDADZgfHMPXaCDliUZWAbdZsjA3la/X
         ZyWA==
X-Gm-Message-State: AC+VfDz9JiNs2Dol0yWcSvaEu+BVh00GiL1NIrfYekKfMOoixpArzIFz
        FEbDExrpwl83+iA0bbuAsLOOrA==
X-Google-Smtp-Source: ACHHUZ4FRtZtGdub5NQDntPy9nGyeS/bwj7mFnRDmzYb5VuO1PJh2E+P8gVT3nDseQEkWbZm/MnbqQ==
X-Received: by 2002:a17:907:318d:b0:961:69a2:c8d6 with SMTP id xe13-20020a170907318d00b0096169a2c8d6mr2552988ejb.69.1685449660040;
        Tue, 30 May 2023 05:27:40 -0700 (PDT)
Received: from krzk-bin ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id f18-20020a170906049200b009661484e84esm7356444eja.191.2023.05.30.05.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 05:27:39 -0700 (PDT)
Date:   Tue, 30 May 2023 14:27:36 +0200
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        David Airlie <airlied@gmail.com>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        kernel@dh-electronics.com, Marek Vasut <marex@denx.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        linux-arm-kernel@lists.infradead.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v4 2/4] dt-bindings: display: st,stm32-dsi: Remove
 unnecessary fields
Message-ID: <20230530122736.tflfu5cugbd7ooup@krzk-bin>
References: <20230529091359.71987-1-raphael.gallais-pou@foss.st.com>
 <20230529091359.71987-3-raphael.gallais-pou@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230529091359.71987-3-raphael.gallais-pou@foss.st.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2023 11:13:57 +0200, Raphael Gallais-Pou wrote:
> "#address-cells" and "#size-cells" are two properties that are not
> mandatory. For instance, the DSI could refer to a bridge outside the scope
> of the node rather than include a 'panel@0' subnode. By doing so, address
> and size fields become then unnecessary, creating a warning at build time.
> 
> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Marek Vasut <marex@denx.de>
> ---
>  Documentation/devicetree/bindings/display/st,stm32-dsi.yaml | 2 --
>  1 file changed, 2 deletions(-)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1787034


dsi@40016c00: Unevaluated properties are not allowed ('panel-dsi@0' was unexpected)
	arch/arm/boot/dts/stm32f469-disco.dtb

dsi@5a000000: Unevaluated properties are not allowed ('panel-dsi@0' was unexpected)
	arch/arm/boot/dts/stm32mp157c-ev1.dtb
	arch/arm/boot/dts/stm32mp157c-ev1-scmi.dtb
