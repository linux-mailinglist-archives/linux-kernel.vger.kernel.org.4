Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37BD96E947F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 14:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234990AbjDTMd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 08:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234936AbjDTMdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 08:33:16 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732E83C30;
        Thu, 20 Apr 2023 05:32:58 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-18665c1776dso615787fac.2;
        Thu, 20 Apr 2023 05:32:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681993977; x=1684585977;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n7z0JmwHaex/uFH0ZYyDvToigtvE+3W/gbf5o0Is7Ho=;
        b=OBkMo2LkzLoVM5h8kQpDEMcnrNY7rC2mn3o58ExbDs9bg55LcP6Pef7/HOnmjZ3AcD
         BkbbQ62RF3hfEbaTI7iTo/rKh6rlRZDFZkWVBlx7ppw0Ar255LmUZO/JWC7rwmzH/zeF
         9/qFWhNaixRJIQIM1NwZVicrTLR5R8wHn5MZMqMBfPr8AKWZiFfHUm3BtlcNYpnPCS/s
         SYhyj66KETnJE9Powihy6xmsavVkx0FSOuJtyarZVYMLKB9bRDSRXw9sTQjhgO4hjI6J
         FGuusluvyG54NbCOKNR9Ltov8RjYURSC5KKT6r/YoqOSqa92mfYUX8gTZ7fe30JKLzv9
         hfhA==
X-Gm-Message-State: AAQBX9cov7AAV7QllXKJFkO56Y2eDFUM/fzIeHwaNusuNPJnK5TtaT8W
        8fg06uUe2bgGQzoazJITDziaWzfO5g==
X-Google-Smtp-Source: AKy350Y107Wu1RAl2s+KH7dc+aZ13lz9F0Ey0F68DyRy1iyrsdRSN2Bux4WCxJa0ZbDCN1BlqkUgiw==
X-Received: by 2002:a05:6871:707:b0:188:5:bc87 with SMTP id f7-20020a056871070700b001880005bc87mr1163265oap.6.1681993977566;
        Thu, 20 Apr 2023 05:32:57 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e21-20020a056830201500b0069f8ff38bcbsm662919otp.16.2023.04.20.05.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 05:32:57 -0700 (PDT)
Received: (nullmailer pid 2632253 invoked by uid 1000);
        Thu, 20 Apr 2023 12:32:54 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Minda Chen <minda.chen@starfivetech.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Pawel Laszczak <pawell@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Mason Huo <mason.huo@starfivetech.com>,
        Roger Quadros <rogerq@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        Peter Chen <peter.chen@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Conor Dooley <conor@kernel.org>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
In-Reply-To: <20230420110052.3182-6-minda.chen@starfivetech.com>
References: <20230420110052.3182-1-minda.chen@starfivetech.com>
 <20230420110052.3182-6-minda.chen@starfivetech.com>
Message-Id: <168199392033.2631023.325205203535545069.robh@kernel.org>
Subject: Re: [PATCH v5 5/7] dt-bindings: usb: Add StarFive JH7110 USB
 controller
Date:   Thu, 20 Apr 2023 07:32:54 -0500
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 20 Apr 2023 19:00:50 +0800, Minda Chen wrote:
> StarFive JH7110 platforms USB have a wrapper module around
> the Cadence USBSS-DRD controller. Add binding information doc
> for that.
> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> Reviewed-by: Peter Chen <peter.chen@kernel.org>
> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  .../bindings/usb/starfive,jh7110-usb.yaml     | 131 ++++++++++++++++++
>  1 file changed, 131 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/starfive,jh7110-usb.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/usb/starfive,jh7110-usb.yaml:73:9: [warning] too many spaces after hyphen (hyphens)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230420110052.3182-6-minda.chen@starfivetech.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

