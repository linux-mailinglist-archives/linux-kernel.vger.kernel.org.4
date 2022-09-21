Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22E35E4F7B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 20:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiIUScr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 14:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiIUScp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 14:32:45 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8624FA1D1A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 11:32:43 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id k10so10658423lfm.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 11:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=KpQl/fpFQi0WzrdZvxEbMAul4LrjeiUgy45pvWtrUZw=;
        b=Q6bV4x7B/wS2piLzjPI8S2AFFfG9OoXAoz3V3v4bpF4xnb1VnvqkFX0kWFxmcW33kk
         3RGvOsyl9iAajpfumk4y4oeEgybafPVcVh4wyORBlzGRuY62MWX/OeukG0iIusGvSISd
         u+eG4GO7M6ynNWYK8UqZmGnIDb7pIfV8kZE0MuXNLCvYWZ9D5/pdTHQbL3+LafTc+kXj
         YtnQV5IsqsHNFw1HMcT6uZKLKJbosYTjSBJTA1RbDHejKYDWdRJoh2723MLBa25KkGpf
         Q1CJRKnUOXrL1zgJ4HYozeS+lPU37iQ9hTOEVrgWNtwvc7YHDbaFhFJG4jKK058a1h2F
         9aGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=KpQl/fpFQi0WzrdZvxEbMAul4LrjeiUgy45pvWtrUZw=;
        b=gD+Z+eyJKQog9olOSVMrlZi6khQHg8kv5rw2IJrXOgnix670KihmQcKsAOqEhNINbs
         tRxHjkjvV1vsHFqYfH0fRSFW8CgLoS+9j7QRAGIQ2IrPD4ONS6mXfTlqhgZN2JGMsDRh
         MDOVYhBIOAradCrDmTsb9aB1ER59P6ER4Ae4slbmIZKUp2tZHArQBCvpvSwGJBuEzd8Y
         k89pFBkTd8JFXTOx1JeK/nFEd0nNTNfv75O92dgwtvEWb8AHnH5owm+5eUjCh73MhAeU
         jnegojLXirKovvCs662a2idlGHAkWe2c9TGmzYKe2uHbWGPaffP563iOzLMKpqWAvEym
         HZXA==
X-Gm-Message-State: ACrzQf2lkQRLAf6uhNGwfPNe9r/ONipXEO70Vx858dUjmTlveH8q9JZ/
        te1Tu4uGvu8bqcF656L896u3nA==
X-Google-Smtp-Source: AMsMyM7jjPC7hCTwA0n33gWBuiRoixZRhdPfpyrVT4SguIv08DybininZsm8klfDAHYdEizBbjvVGQ==
X-Received: by 2002:a05:6512:32c7:b0:49f:53f2:a51a with SMTP id f7-20020a05651232c700b0049f53f2a51amr10927467lfg.236.1663785161772;
        Wed, 21 Sep 2022 11:32:41 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id j12-20020a056512344c00b00494a1b242dasm551602lfr.14.2022.09.21.11.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 11:32:41 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     mchehab@kernel.org, robh+dt@kernel.org,
        Tony Luck <tony.luck@intel.com>, michal.simek@xilinx.com,
        Sergey.Semin@baikalelectronics.ru, manish.narani@xilinx.com,
        krzysztof.kozlowski+dt@linaro.org, bp@alien8.de
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        punnaiah.choudary.kalluri@xilinx.com, krzk@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        rric@kernel.org, james.morse@arm.com,
        Alexey.Malahov@baikalelectronics.ru, dinguyen@kernel.org,
        robh@kernel.org, Michail.Ivanov@baikalelectronics.ru,
        devicetree@vger.kernel.org, Pavel.Parkhomenko@baikalelectronics.ru,
        fancer.lancer@gmail.com
Subject: Re: (subset) [PATCH v2 14/19] dt-bindings: memory: snps: Detach Zynq DDRC controller support
Date:   Wed, 21 Sep 2022 20:32:36 +0200
Message-Id: <166378514628.18111.5147960761937324813.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220910194237.10142-15-Sergey.Semin@baikalelectronics.ru>
References: <20220910194237.10142-1-Sergey.Semin@baikalelectronics.ru> <20220910194237.10142-15-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Sep 2022 22:42:32 +0300, Serge Semin wrote:
> The Zynq A05 DDRC controller has nothing in common with DW uMCTL2 DDRC:
> the CSRs layout is absolutely different and it doesn't support IRQs unlike
> DW uMCTL2 DDR controller of all versions (v1.x, v2.x and v3.x). Thus there
> is no any reason to have these controllers described in the same bindings.
> Let's split the DT-schema up.
> 
> Note since the synopsys,ddrc-ecc.yaml schema describes the Synopsys DW
> uMCTL2 DDR controller only, we need to accordingly fix the device
> descriptions.
> 
> [...]

Applied, thanks!

[14/19] dt-bindings: memory: snps: Detach Zynq DDRC controller support
        https://git.kernel.org/krzk/linux-mem-ctrl/c/845081313632b6a27dff576cf102b4aecb4654cf

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
