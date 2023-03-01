Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578BC6A6642
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 04:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjCADHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 22:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjCADHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 22:07:53 -0500
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BCE117;
        Tue, 28 Feb 2023 19:07:51 -0800 (PST)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-176261d7f45so363020fac.11;
        Tue, 28 Feb 2023 19:07:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0OYIdqu7cGwRoKYb7qeOdxt9JMOCFw61RHKnEoHS6Yw=;
        b=XXtAMG/QxrT3RUkraex+/xIspKQwyli1XvcaQnjfyXYZyaQypFv2IQobr8oLCCOp7i
         BRO6/cbuMZlaQrkdqun96vhEadDFfAAZYFepolMn7xGucwM720uHdy269R4vAs+bvss0
         s1WfsuM1vq/LWqJrOZ9C9WiGgZtS2VmPP/FjQ9EhcSfV8amoNNHK+1SifpnIrgEYAwhh
         +Y1BKGn1OmyYd3B4acCPgM1Jmqvcg8MGI3QsYqmWkAAibzDQ8Fax4YihaPztBjutx8KZ
         Zx+dUKEnbrjv94RWl2F1oazcIMdpznfcmEamMYuUVaQzoKl4bUB49Wmb1FqQXfrDb5Zi
         z3Kg==
X-Gm-Message-State: AO0yUKXCTlmYZ+/1I/hvGf6PRyb6GOkOrxoiCAg4dGjhBEeZDZpqfXyM
        6as39FAAY5tx/BxBSccYIw==
X-Google-Smtp-Source: AK7set/BNkM6lS/uEW/4QMAhfCAx0MsrFChPS7Jkh4meSZjWrij3pkePvjFUtnPayLSvZAr2V4XE+A==
X-Received: by 2002:a05:6870:ec86:b0:16d:dd0e:df24 with SMTP id eo6-20020a056870ec8600b0016ddd0edf24mr2986544oab.27.1677640070895;
        Tue, 28 Feb 2023 19:07:50 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id zq19-20020a0568718e9300b0017255c79736sm3938059oab.43.2023.02.28.19.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 19:07:50 -0800 (PST)
Received: (nullmailer pid 297616 invoked by uid 1000);
        Wed, 01 Mar 2023 03:07:49 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        pankaj.gupta@nxp.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        horia.geanta@nxp.com, devicetree@vger.kernel.org,
        gaurav.jain@nxp.com, herbert@gondor.apana.org.au,
        shawnguo@kernel.org, stefan@agner.ch, Peng Fan <peng.fan@nxp.com>,
        robh+dt@kernel.org, s.hauer@pengutronix.de, davem@davemloft.net
In-Reply-To: <20230301015702.3388458-5-peng.fan@oss.nxp.com>
References: <20230301015702.3388458-1-peng.fan@oss.nxp.com>
 <20230301015702.3388458-5-peng.fan@oss.nxp.com>
Message-Id: <167763996749.292641.6380222145723502903.robh@kernel.org>
Subject: Re: [PATCH 4/9] dt-bindings: crypto: add fsl-sec4-snvs DT schema
Date:   Tue, 28 Feb 2023 21:07:49 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 01 Mar 2023 09:56:57 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Convert fsl-sec4.txt SNVS RTC and PowerKey to DT schema
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../bindings/crypto/fsl-sec4-snvs.yaml        | 153 ++++++++++++++++++
>  1 file changed, 153 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/crypto/fsl-sec4-snvs.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/nvmem/snvs-lpgpr.example.dtb: snvs@20cc000: compatible: 'oneOf' conditional failed, one must be fixed:
	['fsl,sec-v4.0-mon', 'syscon', 'simple-mfd'] is too long
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/crypto/fsl-sec4-snvs.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/nvmem/snvs-lpgpr.example.dtb: snvs@20cc000: Unevaluated properties are not allowed ('compatible', 'snvs-lpgpr' were unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/crypto/fsl-sec4-snvs.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230301015702.3388458-5-peng.fan@oss.nxp.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

