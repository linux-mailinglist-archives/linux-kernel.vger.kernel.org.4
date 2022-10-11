Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBA35FAA60
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 03:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiJKBwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 21:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiJKBwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 21:52:16 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F4C80493;
        Mon, 10 Oct 2022 18:52:14 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id x188so5510213oig.5;
        Mon, 10 Oct 2022 18:52:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QxUwxjok5J3VmLzpGxMGRLt6oXkHZSszcCJv2zshnl8=;
        b=jLKlp4FyCdPOtRw33ADu+JpKeSj0N2y98wCXffpsHUER+JByj4u8YiUTeOFHDq+FGS
         dG7KjWvGRtWZsXp6gdCTp1dPCtc+v41CXJplXQRITZTnKHjEbgB+vMboMV7TnaU9zO1C
         WUNupJmFWJ7I0U7dhjyZ42bRqYGRo685OUzjwMfl2lIH2qQ4n2ZnOQiR41Y95sbr/UIv
         TurBWfQy1CvtObMQWwQyVfU//s5mg0qvUF3eW79tXHbMtEShjSpSrMuvrrzTpG9GlF2P
         SJ4akdfdDanHc02AWS+lq0zFzB9iYwA+iIikQnzEyZiMGhZde+DQO9PhRtF1fARfjh6K
         SCFA==
X-Gm-Message-State: ACrzQf2dChK7+WRo6Ai9JoryJP0YUCqRPX3EEVVLL91e3vyLhdd6R5Ia
        1UbY9Wdzt7rynuKK3wtcqg==
X-Google-Smtp-Source: AMsMyM6TxutXI/EVb4pA1SbAB9gms8A/ZiuL8AN8F37e2xCxhzLGaK0HMBxnfdPRP72QOEo+XQbK1A==
X-Received: by 2002:a05:6808:1141:b0:354:9a79:2f4f with SMTP id u1-20020a056808114100b003549a792f4fmr2662146oiu.85.1665453133558;
        Mon, 10 Oct 2022 18:52:13 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j18-20020a4ad192000000b004805c328971sm3235447oor.42.2022.10.10.18.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 18:52:13 -0700 (PDT)
Received: (nullmailer pid 1703338 invoked by uid 1000);
        Tue, 11 Oct 2022 01:52:12 -0000
From:   Rob Herring <robh@kernel.org>
To:     Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        ihkose@gmail.com, devicetree@vger.kernel.org,
        rajat.khandelwal@intel.com, lars@metafoo.de, jic23@kernel.org,
        linux-iio@vger.kernel.org, robh+dt@kernel.org
In-Reply-To: <20221011182437.662719-1-rajat.khandelwal@linux.intel.com>
References: <20221011182437.662719-1-rajat.khandelwal@linux.intel.com>
Message-Id: <166545307700.1702218.811193663081885499.robh@kernel.org>
Subject: Re: [PATCH] Change the I2C slave address for ds4422/4424 to its correct value
Date:   Mon, 10 Oct 2022 20:52:12 -0500
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Oct 2022 23:54:37 +0530, Rajat Khandelwal wrote:
> The datasheet states that the slave address for the device is 0x20
> when the pins A0 and A1 are ground. The DT binding has been using
> 0x10 as the value and I think it should be 0x20 as per datasheet.
> 
> Let me know if I am wrong about this.
> 
> Signed-off-by: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
> ---
>  Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/iio/dac/maxim,ds4424.example.dts:22.20-26.15: Warning (i2c_bus_reg): /example-0/i2c/dac@10: I2C bus unit address format error, expected "20"

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

