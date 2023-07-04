Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E3B746820
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 05:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjGDDwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 23:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjGDDwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 23:52:22 -0400
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D552BD;
        Mon,  3 Jul 2023 20:52:21 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-345ff33d286so15440665ab.3;
        Mon, 03 Jul 2023 20:52:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688442740; x=1691034740;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IXXXDTVnhiGaQdLwuFieMKLCVwc40SyI0FbqGubyrKA=;
        b=P4U9AhC17qVshjHyRoYrH8n0zwKPuvTdBgU2kj3GOAdVBFp09svLrkL5rUlF+3XyJ1
         zvSdW5/M8HqbHKqmfg1eFTVwrVVdfYrvOKNyckrBDV4rNFCChRTtblVSBNeVTOG6H6xA
         CkA6I7T6fCrbyMo/ZmQx1QMj6f6/DdumEQrCQnDtZHusZDNgvC51VHbsFjWYJlqfAoF7
         O0RrySgBfvkyiUuxBzoo/dDNpI9/3LcWl6s7ZzvJiyVOqURyOXELnykKtVijrHCvWAza
         H3idOox9Yo398niPT+GSCYHUkEUcvUbhLUGCugTcaIs0blbTYT1nR2fEQEJsS1ZIfyUN
         otGw==
X-Gm-Message-State: ABy/qLbc24L/buUrcv5WzUag3yqN2AyQXHoIIxdrUYbQEqyP8uzdz+eC
        i9Xff6337pOZoEJ+OhA9C2hn2meQGw==
X-Google-Smtp-Source: APBJJlFisZIe/mCHVFeOU6gtwM361wCFX79fK+RHHjG0iFC8fAd+9ogQkO+uKBCPLpsfr4mdrftZCQ==
X-Received: by 2002:a92:d4c7:0:b0:345:a201:82c0 with SMTP id o7-20020a92d4c7000000b00345a20182c0mr10514925ilm.32.1688442740419;
        Mon, 03 Jul 2023 20:52:20 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id t14-20020a92c0ce000000b00345950d7e94sm6626965ilf.20.2023.07.03.20.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 20:52:19 -0700 (PDT)
Received: (nullmailer pid 800694 invoked by uid 1000);
        Tue, 04 Jul 2023 03:52:16 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Xingyu Wu <xingyu.wu@starfivetech.com>
Cc:     linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        William Qiu <william.qiu@starfivetech.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20230704020239.288500-3-xingyu.wu@starfivetech.com>
References: <20230704020239.288500-1-xingyu.wu@starfivetech.com>
 <20230704020239.288500-3-xingyu.wu@starfivetech.com>
Message-Id: <168844273679.800666.7152631195397313900.robh@kernel.org>
Subject: Re: [PATCH v6 2/7] dt-bindings: soc: starfive: Add StarFive syscon
 module
Date:   Mon, 03 Jul 2023 21:52:16 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 04 Jul 2023 10:02:34 +0800, Xingyu Wu wrote:
> From: William Qiu <william.qiu@starfivetech.com>
> 
> Add documentation to describe StarFive System Controller Registers.
> 
> Co-developed-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> ---
>  .../soc/starfive/starfive,jh7110-syscon.yaml  | 93 +++++++++++++++++++
>  MAINTAINERS                                   |  7 ++
>  2 files changed, 100 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.example.dtb: syscon@13030000: reg: [[0, 318963712], [0, 4096]] is too long
	from schema $id: http://devicetree.org/schemas/mfd/syscon.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.example.dtb: syscon@13030000: reg: [[0, 318963712], [0, 4096]] is too long
	from schema $id: http://devicetree.org/schemas/soc/starfive/starfive,jh7110-syscon.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.example.dtb: syscon@17010000: reg: [[0, 385941504], [0, 4096]] is too long
	from schema $id: http://devicetree.org/schemas/mfd/syscon.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.example.dtb: syscon@17010000: reg: [[0, 385941504], [0, 4096]] is too long
	from schema $id: http://devicetree.org/schemas/soc/starfive/starfive,jh7110-syscon.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230704020239.288500-3-xingyu.wu@starfivetech.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

