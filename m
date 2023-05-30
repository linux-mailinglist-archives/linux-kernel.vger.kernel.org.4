Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB93B7160AE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 14:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbjE3M4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 08:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbjE3M4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 08:56:05 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B99127
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 05:55:36 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-96fe2a1db26so788135666b.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 05:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685451331; x=1688043331;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OBcNGihsby3nj+yLS8cmdJG0F3BB5BsBxPISYSYV4c0=;
        b=vOUygGpSI91sliwnKNGkbKUjiWID0a6Zy9yngzauWwYH5G6b/J50mnaOcyaw8kBuAc
         AKn3dLMHZlu62OOCNyWLLJ241P+sorNPfWYZUltKjsjh+4CUs7bBJRilCxQKLldsZaGN
         1Dkk0NWUd/EcHeXwQohcL9AV/k6TCJk3308LTOAarrIOytJ9zSfZEqeEhfv2QX40mwt3
         fQsfrOD0DfpbMqTgHpMdxt8qbTxm+TZsnbW4M2UaY/0LVFCI6ivoynRFqjpgwpTp+qkt
         v4jrVT3SDpl7d54jUwpMe1OD5O8EjWmrFKvz2br86YgAkFEo8qJtajItbMt81YFBPTqH
         Q76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685451332; x=1688043332;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBcNGihsby3nj+yLS8cmdJG0F3BB5BsBxPISYSYV4c0=;
        b=gZiuGmIpL3lvL6rcm+vflCyj/CfC268g1/rP+PDQT0JihfuHpVAWk7iKOkjcVBaVKJ
         PyZO6ECTr4odg8/FV58NnOfW1RmOWDyPOa6OS8NUtG5Xmpub6grF2JJXAcgb9Nd7dF62
         4P2lRRU4co2Rvp9JVpcs58acEP3LtbTNcHaftcyyvv1VPKfEduW4BkRy6Nhy45sF4lwa
         iR6Mmd3T8epcWgmipI7psm8qOy6wpyD1Nd8j0chNq7PJwbPx2lj8hHQj2zyETYQtLBCd
         MHyHe4dlvbwBih1C6t2yzA0h117KlaHKHbiAy7jEf7BvQVBbkXfsBLER/tuPHwZ2IJeL
         S2mw==
X-Gm-Message-State: AC+VfDwLDxWI/5T3UV8Ltk0Hc3uCfZX3rTlyFvorthZQ/9Rm2FNXHgDZ
        iTXLmV4kSQBBkmiNKjUdQnBVWA==
X-Google-Smtp-Source: ACHHUZ4IMgAZuXXdvozMz2uholz0ow06YVqNtFGTrdlJYmkd7L3nbEjn05xSWKVVBeKy+YB9FWdlaQ==
X-Received: by 2002:a17:906:58d3:b0:96f:e7cf:5004 with SMTP id e19-20020a17090658d300b0096fe7cf5004mr2564087ejs.73.1685451331674;
        Tue, 30 May 2023 05:55:31 -0700 (PDT)
Received: from krzk-bin ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id dv22-20020a170906b81600b0096f78953b77sm7363868ejb.147.2023.05.30.05.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 05:55:31 -0700 (PDT)
Date:   Tue, 30 May 2023 14:55:27 +0200
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-riscv@lists.infradead.org, Icenowy Zheng <uwu@icenowy.me>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Guo Ren <guoren@kernel.org>, Yangtao Li <frank.li@vivo.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>, Wei Fu <wefu@redhat.com>
Subject: Re: [PATCH v2 4/9] dt-binding: riscv: add T-HEAD CPU reset
Message-ID: <20230530125527.njppujzixnv3bbjd@krzk-bin>
References: <20230518184541.2627-1-jszhang@kernel.org>
 <20230518184541.2627-5-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230518184541.2627-5-jszhang@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 May 2023 02:45:36 +0800, Jisheng Zhang wrote:
> The secondary CPUs in T-HEAD SMP capable platforms need some special
> handling. The first one is to write the warm reset entry to entry
> register. The second one is write a SoC specific control value to
> a SoC specific control reg. The last one is to clone some CSRs for
> secondary CPUs to ensure these CSRs' values are the same as the
> main boot CPU. This DT node is mainly used by opensbi firmware.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  .../bindings/riscv/thead,cpu-reset.yaml       | 69 +++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/riscv/thead,cpu-reset.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/riscv/thead,cpu-reset.example.dts:18.35-25.11: Warning (unit_address_vs_reg): /example-0/cpurst@ffff019050: node has a unit name, but no reg or ranges property
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/riscv/thead,cpu-reset.example.dtb: cpurst@ffff019050: control-reg:0: [255, 4278276100] is too long
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/riscv/thead,cpu-reset.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1783487

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.
