Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4BC6D6A99
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236352AbjDDRax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236725AbjDDRa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:30:29 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B625576BE
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:29:10 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id h8so133692921ede.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 10:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680629305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NecWQKIwxmnyJIeT3PH/bPQJKB8fMgF9ma7fwyCmGrg=;
        b=cxxxAzq4Cdljg7sNjoGKC3kvwoKRGGkmNKveFQLJp13GdGgKx71LR2dtsx8adQCk/w
         cSNrVBNnmlcCel9j8M+TpvXEaD9XNEelPjgApfblEozyf6pwNxJygCB9tHvSVJpUh87t
         Ay3j/O2Xax97CffGKZ5Rh2ZK5ScHcUp/L2uo4kRveNr8Qw0Pm2VZtQve6SosRBCCriej
         gIiE/WuuYsXeMCpTRvqQTRYQ7LK3DJ0ppN60oFwPNO7xjKE6j2Ev+WIjMbAJf9RO5W4a
         DPATaoVTxWg5VDOgMtS/hm2zQK8L8QRiQ6aK534sdpip4C9sfvFqOnOjNKR8myuIeexn
         5nzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680629305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NecWQKIwxmnyJIeT3PH/bPQJKB8fMgF9ma7fwyCmGrg=;
        b=OMEOzrRbLaZ8LA6F2HEUDjBfP46OekFDXC3wVSezbAsgsdjahz/bXECfVbfhbTJ/YQ
         CGxEru8HbU+egqxAGBs7w7YBjEEDleYyfV4M5gDxXgTReXecLj4oE/gI9V/SETFUXDOT
         mKRX+r0QMrhZJ0BQNCr6h2Lp1UuQveXpQ3ddHEt3d4Q5RLja0nJbgFcyCP3z7pnaXNPR
         fl48fp2W0gGTfglxR7/UV0EaY6Kcn/DCwv1iK64LpRcSeO1XpPJMit/Qn30PrSGB7il5
         VISnvK0L7/f6ru8GoTnzRKtA0jYeIQye7JOUtuhE14FE/1zNw0GU9PIISFKEzct5n05u
         V5YA==
X-Gm-Message-State: AAQBX9fu3YLXfZ+UfN8/Cvp4QL1oIs5PBBzcQRZxUxnw9gwJ5M+6j+gj
        lG/TstNU3+8hU+aXhvNWx44=
X-Google-Smtp-Source: AKy350Z5S2pdplYf2F91C5YxmIj8/ziVQERI2jwAp/mvDOwCtZkE9vOgEPiSHQGmzLdQ2OAo6kd5RA==
X-Received: by 2002:a17:906:f145:b0:8af:2a97:91d4 with SMTP id gw5-20020a170906f14500b008af2a9791d4mr409703ejb.14.1680629304727;
        Tue, 04 Apr 2023 10:28:24 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id n13-20020a170906688d00b0093210cf625bsm6200603ejr.187.2023.04.04.10.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 10:28:24 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     gregkh@linuxfoundation.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 25/40] dt-bindings: nvmem: Drop unneeded quotes
Date:   Tue, 04 Apr 2023 19:28:23 +0200
Message-ID: <2276027.ElGaqSPkdT@jernej-laptop>
In-Reply-To: <20230404172148.82422-26-srinivas.kandagatla@linaro.org>
References: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
 <20230404172148.82422-26-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne torek, 04. april 2023 ob 19:21:33 CEST je Srinivas Kandagatla napisal(a):
> From: Rob Herring <robh@kernel.org>
> 
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml      | 2 +-

For Allwinner:
Acked-By: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

>  Documentation/devicetree/bindings/nvmem/apple,efuses.yaml       | 2 +-
>  Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml         | 2 +-
>  Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml | 2 +-
>  Documentation/devicetree/bindings/nvmem/imx-iim.yaml            | 2 +-
>  Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml          | 2 +-
>  .../devicetree/bindings/nvmem/ingenic,jz4780-efuse.yaml         | 2 +-
>  Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml     | 2 +-
>  .../devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml       | 2 +-
>  Documentation/devicetree/bindings/nvmem/mxs-ocotp.yaml          | 2 +-
>  Documentation/devicetree/bindings/nvmem/nintendo-otp.yaml       | 2 +-
>  Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml        | 2 +-
>  Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml     | 2 +-
>  Documentation/devicetree/bindings/nvmem/rmem.yaml               | 2 +-
>  Documentation/devicetree/bindings/nvmem/rockchip-efuse.yaml     | 2 +-
>  .../devicetree/bindings/nvmem/socionext,uniphier-efuse.yaml     | 2 +-
>  Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml     | 2 +-
>  .../devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml         | 2 +-
>  18 files changed, 18 insertions(+), 18 deletions(-)



