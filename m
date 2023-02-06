Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5973F68C8F7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 22:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjBFVtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 16:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjBFVtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 16:49:41 -0500
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4DF301A2;
        Mon,  6 Feb 2023 13:49:11 -0800 (PST)
Received: by mail-oi1-f175.google.com with SMTP id p185so11001618oif.2;
        Mon, 06 Feb 2023 13:49:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZFI+/lEvE5K9+MX/lX7wGVqblszW07L3zZfHhu2VpE8=;
        b=i0nzIKP+oJPN3n1pL5H+wlaJE5pVygsEGbCrb5XuS4Dr0naE8V0QXIc5URhEYT17/0
         sc0a1oijm9kBlrxIoSUQSKXyi6FYCHImi0BN0aDMeW9C+WxmiPmVzuZFG1zICyAmVZht
         kMRIQbO6m0gwHTb3/2s4IY9s2hWQXb3Fo60QQJDbBSu6meW7Ff9mUk93ji7kKmBDBslF
         /E97x202+1eNkSGFjolavkVCgteaKakluU658bojLYL8wi2tattUfV/LT4sR30XSCGeH
         46DQ1LdGcZEqEyAepst2A05wG4L5J/ySGmtJlmie3drjXnj5FMJRD1CSlQ1NCCVl9HR2
         kBLQ==
X-Gm-Message-State: AO0yUKVLqIVdaGe8zCz7zajDHLov2y+xWUN0qPKL+Gyb/McainGGAhBx
        UW7Nr+lVWAjHE/BMVogiCw==
X-Google-Smtp-Source: AK7set/b9EK0D0dcwYXOHIkT9giyg++xP/90Rp97QYsgMQU7HZYqOVA5S9DL/zc4egmaNaVWRMDoUQ==
X-Received: by 2002:a05:6808:3cf:b0:36e:bb55:d51a with SMTP id o15-20020a05680803cf00b0036ebb55d51amr104844oie.52.1675720150212;
        Mon, 06 Feb 2023 13:49:10 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bm49-20020a0568081ab100b0035c073aa0d8sm4716586oib.18.2023.02.06.13.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 13:49:09 -0800 (PST)
Received: (nullmailer pid 1563640 invoked by uid 1000);
        Mon, 06 Feb 2023 21:49:09 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Evan Green <evan@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, heiko@sntech.de,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        slewis@rivosinc.com, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, vineetg@rivosinc.com,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@rivosinc.com>
In-Reply-To: <20230206201455.1790329-5-evan@rivosinc.com>
References: <20230206201455.1790329-1-evan@rivosinc.com>
 <20230206201455.1790329-5-evan@rivosinc.com>
Message-Id: <167571795981.1495930.2331543227113728240.robh@kernel.org>
Subject: Re: [PATCH v2 4/6] dt-bindings: Add RISC-V misaligned access
 performance
Date:   Mon, 06 Feb 2023 15:49:09 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 06 Feb 2023 12:14:53 -0800, Evan Green wrote:
> From: Palmer Dabbelt <palmer@rivosinc.com>
> 
> This key allows device trees to specify the performance of misaligned
> accesses to main memory regions from each CPU in the system.
> 
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> Signed-off-by: Evan Green <evan@rivosinc.com>
> ---
> 
> (no changes since v1)
> 
>  Documentation/devicetree/bindings/riscv/cpus.yaml | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/riscv/cpus.yaml:91:72: [error] syntax error: mapping values are not allowed here (syntax)

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/riscv/cpus.example.dts'
Documentation/devicetree/bindings/riscv/cpus.yaml:91:72: mapping values are not allowed here
make[1]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/riscv/cpus.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/riscv/cpus.yaml:91:72: mapping values are not allowed here
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/riscv/cpus.yaml: ignoring, error parsing file
make: *** [Makefile:1508: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230206201455.1790329-5-evan@rivosinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

