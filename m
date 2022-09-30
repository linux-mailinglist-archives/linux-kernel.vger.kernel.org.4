Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0AFD5F0278
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 03:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiI3B4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 21:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiI3Bz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 21:55:59 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA91210FE37;
        Thu, 29 Sep 2022 18:55:57 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id s125so3425329oie.4;
        Thu, 29 Sep 2022 18:55:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=qiRw0pTmuHwBycLo8jnnh8c0JQNXJ8LTMj64UFcxJeQ=;
        b=SDgN9hZh8e4MtAyXrKpr4MRFpZ09PBKsTY3r9RLo/M1phHWL8TZxgngORDBrz+Z3O1
         8OgIK2hJTU3N50wBgVxuZjHL4SSZ/fDMkfmsWS71ZOefWKQxQBD5LaP6mV3uswGGQR7w
         ntNL7pW8VTeYqLidzi4W/STXGWicc8Jg7z/WeJzMIZ0kxrJjwEN2fo18IY1CnySOMqUP
         tRqsa/SprSQznUSzRlow2iM5IjYryAaQiCPVsnalcVSqcDji7BeT0dWCU1ATNpCLN7nr
         01Rr5uPaRTUqQKZH9KZ0XfDWSlP9eobgNnpKVAxBthrNhE5Qwx/7yh1i1XqEXVJXHMjG
         izGg==
X-Gm-Message-State: ACrzQf0HAgg/ytWGT3xA9RMtTrS3ZhMRzyq/SkwyBthdvnlXwUE254dE
        c1eckiVOuADqn0wrbSa5qA==
X-Google-Smtp-Source: AMsMyM7TgwvvSOqiFejV1yl+V50bkYmm2hEDsKgeacT+I37/c1Bf/LW8nTKXMuPGrDzcnP+EIzzDAA==
X-Received: by 2002:a05:6808:1496:b0:350:4640:5462 with SMTP id e22-20020a056808149600b0035046405462mr8319344oiw.47.1664502957074;
        Thu, 29 Sep 2022 18:55:57 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n22-20020a056870241600b001317413344esm355801oap.47.2022.09.29.18.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 18:55:56 -0700 (PDT)
Received: (nullmailer pid 3142038 invoked by uid 1000);
        Fri, 30 Sep 2022 01:55:55 -0000
From:   Rob Herring <robh@kernel.org>
To:     Hal Feng <hal.feng@linux.starfivetech.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        linux-gpio@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>
In-Reply-To: <20220929222647.23816-1-hal.feng@linux.starfivetech.com>
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com> <20220929222647.23816-1-hal.feng@linux.starfivetech.com>
Message-Id: <166450294103.3141703.10888748010920074288.robh@kernel.org>
Subject: Re: [PATCH v1 17/30] dt-bindings: clock: Add starfive,jh7110-clkgen-sys bindings
Date:   Thu, 29 Sep 2022 20:55:55 -0500
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Sep 2022 06:26:47 +0800, Hal Feng wrote:
> From: Emil Renner Berthing <kernel@esmil.dk>
> 
> Add bindings for the system clock generator on the JH7110
> RISC-V SoC by StarFive Technology Ltd.
> 
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Signed-off-by: Hal Feng <hal.feng@linux.starfivetech.com>
> ---
>  .../clock/starfive,jh7110-clkgen-sys.yaml     | 69 +++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-clkgen-sys.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/clock/starfive,jh7110-clkgen-sys.example.dts:18.47-31.11: Warning (unit_address_vs_reg): /example-0/clock-controller@13020000: node has a unit name, but no reg or ranges property

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

