Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE625E4F87
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 20:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiIUSfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 14:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiIUSfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 14:35:43 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CFEA0248
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 11:35:41 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id b24so8087111ljk.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 11:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=rX3tKAGP22NXS1+8Ua7JiXck4vVPPfafM55grLJVBbk=;
        b=ZLq6W90a27gT6Oaj3rsLcYyQazpCcY0LHIwmomwzAYcC+iaPSGt3isBNfYGQ3vuDSu
         ecyBTDg4okE7kN1jve0kczzF2tJVDAoKYb+QLZRF0HwJYVy7hcuEmuj33eZC7xmiSg57
         zQXBxNA05Ua46d890085SW1YVNZIqyrlwzjRlbMseHlIV58IXjQ+UsacfOi+4mqLIU7/
         Q6zxHPFXbKemUOT3bqQD6ZNXsPWLHm6A59XDF7I1lOZYFwBlj/Ar+bY77kG2Pi4rDiMZ
         krM90ANjYEbkXjZiieyQ56Ct3vXrvDOhZpKzLdlBgVje64guQyqgaCnoIuwMzDXptSlq
         R+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=rX3tKAGP22NXS1+8Ua7JiXck4vVPPfafM55grLJVBbk=;
        b=WIhkPwvMsG2cRE/Zv2+jj6thyqjFb0JWOG6v5plzAswD+xosmwFfiUC4Lz3UIKzf/e
         419iAhff6r/HCLBolbJBKMunrPG50dFZ6CBqiVymzkkNu6FupzODdoCyf/Gjv5Dtx9XW
         BsncoeXywh8DHfbuv8T+6oK+O/qhRV5wLBhEazQrSpNaHaX8JGk00XGtmakuRJsmU8TR
         JOvo5vPYC8c2hNUT3I4nuHrvyVFoJHDKyMIFMe8/ZsyHO3didY5CFLl7rctLCBul2U/R
         jH9YkUrvpYNCiHu8pg1BDKYjAA4R1LEUvxSt7tcKTQaIbwtbmxDthvEFqpVFN2dIVFRm
         HDaA==
X-Gm-Message-State: ACrzQf3yTvqJO+gY/Fv/Mz+aJAbrhzRin8n6YoBgs5sk29TXjXvX/Mna
        YitQZa7VN18Z/QHlEHfIit/icA==
X-Google-Smtp-Source: AMsMyM7Y47aktrpfjX9A5ySItg2POAMxPHPuJCU7ku4hFeTGVM+z0MJ26W+MvZGvDV7NHsNq2KCLEA==
X-Received: by 2002:a2e:9304:0:b0:26c:64af:5f5e with SMTP id e4-20020a2e9304000000b0026c64af5f5emr1999988ljh.211.1663785339477;
        Wed, 21 Sep 2022 11:35:39 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id i1-20020a2e2201000000b0026c0158b87csm549538lji.29.2022.09.21.11.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 11:35:38 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     robh+dt@kernel.org, Tony Luck <tony.luck@intel.com>,
        krzysztof.kozlowski+dt@linaro.org, manish.narani@xilinx.com,
        mchehab@kernel.org, michal.simek@xilinx.com,
        Sergey.Semin@baikalelectronics.ru, bp@alien8.de
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        rric@kernel.org, linux-kernel@vger.kernel.org, krzk@kernel.org,
        linux-edac@vger.kernel.org, Michail.Ivanov@baikalelectronics.ru,
        dinguyen@kernel.org, punnaiah.choudary.kalluri@xilinx.com,
        linux-arm-kernel@lists.infradead.org,
        Pavel.Parkhomenko@baikalelectronics.ru, robh@kernel.org,
        james.morse@arm.com, Alexey.Malahov@baikalelectronics.ru,
        devicetree@vger.kernel.org, fancer.lancer@gmail.com
Subject: Re: (subset) [PATCH v2 02/15] dt-bindings: memory: snps: Extend schema with IRQs/resets/clocks props
Date:   Wed, 21 Sep 2022 20:35:35 +0200
Message-Id: <166378533309.18832.8073645732601460899.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220910195659.11843-3-Sergey.Semin@baikalelectronics.ru>
References: <20220910195659.11843-1-Sergey.Semin@baikalelectronics.ru> <20220910195659.11843-3-Sergey.Semin@baikalelectronics.ru>
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

On Sat, 10 Sep 2022 22:56:46 +0300, Serge Semin wrote:
> First of all the DW uMCTL2 DDRC IP-core supports the individual IRQ lines
> for each standard event: ECC Corrected Error, ECC Uncorrected Error, ECC
> Address Protection, Scrubber-Done signal, DFI Parity/CRC Error. It's
> possible that the platform engineers merge them up in the IRQ controller
> level. So let's add both configuration support to the DT-schema.
> 
> Secondly the DW uMCTL2 DDRC IP-core can have clock sources like APB
> reference clock, AXI-ports clock, main DDRC core reference clock and
> Scrubber low-power clock. In addition to that each clock domain can have a
> dedicated reset signal. Let's add the properties for at least the denoted
> clock sources and the corresponding reset controls.
> 
> [...]

Applied, thanks!

[02/15] dt-bindings: memory: snps: Extend schema with IRQs/resets/clocks props
        https://git.kernel.org/krzk/linux-mem-ctrl/c/5514acb0dd030356e628cdd88b266efaa0a22315

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
