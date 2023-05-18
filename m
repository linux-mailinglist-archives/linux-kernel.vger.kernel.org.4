Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C07708875
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 21:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjERTjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 15:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjERTjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 15:39:37 -0400
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B711A6;
        Thu, 18 May 2023 12:39:31 -0700 (PDT)
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-54f8b7a4feeso705911eaf.2;
        Thu, 18 May 2023 12:39:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684438771; x=1687030771;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MDn5p8Ib+y9CgNrg+FXBfqG/I7AiFjWJTabxe3lq0Yo=;
        b=ddQyndsHKhnN9Qool3IakuTy/45mjOyoN3HA1C3RFyZFaO5e6t4ma5Opi33vCazFE8
         lBIZUwux60FsPYYNVxBty46mHYI+zDbT5Z8sH3SJJTcOIQYloPFbd4aJSZui9Or3MW8H
         rGz5DcwLSZrRk+3D2LQP+YomIlfWNVIdZr+neaXrsl+f8DGceEP7Dm9THnMcbpsPdljb
         bIHr92FUuvZ47f/Q2YDPJfIVkqiM8N/8RzWWkaVjQ9Y2wKvaUAV1cnyajJeXoRR06jX4
         qZm7MnHWFZwvUrD314jtoKPkNCm/wwpuvB1aaQ4/5AXxrMefY7d3wrgHxGK6UQPZnHJC
         gdcg==
X-Gm-Message-State: AC+VfDwx+mCMXYOE/sp5nI08YG5vDB8QHinRJRkL8n9L9iFzu/88lR+Z
        Zek78e/XJDMxNLAfolQ+TsrC/ONhnA==
X-Google-Smtp-Source: ACHHUZ6Z5ocjGCz/xPSu9pMLuSMlz+bPgbUY8RawLZcETmIHHgksQOd/VkJV/2yOqFSssJd7wa3JJg==
X-Received: by 2002:a05:6808:308a:b0:395:df6e:a845 with SMTP id bl10-20020a056808308a00b00395df6ea845mr2002207oib.4.1684438770739;
        Thu, 18 May 2023 12:39:30 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i4-20020aca3b04000000b0039208555951sm983744oia.29.2023.05.18.12.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 12:39:30 -0700 (PDT)
Received: (nullmailer pid 2547178 invoked by uid 1000);
        Thu, 18 May 2023 19:39:29 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     linux-riscv@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Yangtao Li <frank.li@vivo.com>,
        Rob Herring <robh+dt@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Icenowy Zheng <uwu@icenowy.me>, Wei Fu <wefu@redhat.com>,
        Guo Ren <guoren@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
In-Reply-To: <20230518184541.2627-5-jszhang@kernel.org>
References: <20230518184541.2627-1-jszhang@kernel.org>
 <20230518184541.2627-5-jszhang@kernel.org>
Message-Id: <168443876898.2547162.12784151548808128613.robh@kernel.org>
Subject: Re: [PATCH v2 4/9] dt-binding: riscv: add T-HEAD CPU reset
Date:   Thu, 18 May 2023 14:39:29 -0500
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230518184541.2627-5-jszhang@kernel.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

