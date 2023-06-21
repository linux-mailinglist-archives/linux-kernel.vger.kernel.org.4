Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948A0739034
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 21:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjFUThM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 15:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjFUThG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 15:37:06 -0400
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8142171C;
        Wed, 21 Jun 2023 12:37:04 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-341c362a851so24553935ab.2;
        Wed, 21 Jun 2023 12:37:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687376224; x=1689968224;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v1W5en0X6o+ZubGP6+969Y3mIZxJYwr7a66wP5yY9ik=;
        b=NfwNsjBL49VZSWITBBChmJJve7q5HcbGBs/henr5MDmQI/yVfa0QugUPmAHjAES6xu
         xEJMd7s3mJUQSLLUAMcNaZk2h5aNhQ8e1rCkWXOJPLzhuC4SySa1CnQ3M7xoQBjmvs6s
         ilIJ4p8/MgELHmdHX/Wu2W4kevm7cLso2hfNHhLj2n1lkxX6zOmauCCBCG5M5ud00YtT
         BIU1W6C1oTgVE4CLJMVB6L+OlCn89IpGkKyv0YeVIOc6mNKN5D2g+bAHdZkEGm3aHkQa
         Hx+bMKY6Ps3MKzoRDc2pZCS/fAXP0fTWFLvETU+bWBp589yWpJlq51wsMB0Nl+Ku/PQM
         djkQ==
X-Gm-Message-State: AC+VfDxQVyFGqbf3LONKXRgdai2jIPsX0n9aN6dMlV5Vo1WBI4l8CuRO
        iAausEDoMJDd99VMeNqgpw==
X-Google-Smtp-Source: ACHHUZ56xWTEeuEUlIWxxD7+8PJ+uta1biB7UfsTJz5OyKBF7NGWPlA3R5cc3fwUFRWz8KewHgTnfA==
X-Received: by 2002:a92:cf50:0:b0:33b:1635:359f with SMTP id c16-20020a92cf50000000b0033b1635359fmr12184456ilr.22.1687376224015;
        Wed, 21 Jun 2023 12:37:04 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id j18-20020a926e12000000b00341c0710169sm1496585ilc.46.2023.06.21.12.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 12:37:03 -0700 (PDT)
Received: (nullmailer pid 3403584 invoked by uid 1000);
        Wed, 21 Jun 2023 19:36:57 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Anjelique Melendez <quic_amelende@quicinc.com>
Cc:     andersson@kernel.org, linux-pwm@vger.kernel.org, pavel@ucw.cz,
        linux-arm-msm@vger.kernel.org, u.kleine-koenig@pengutronix.de,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, conor+dt@kernel.org,
        thierry.reding@gmail.com, linux-leds@vger.kernel.org,
        lee@kernel.org, agross@kernel.org
In-Reply-To: <20230621185949.2068-3-quic_amelende@quicinc.com>
References: <20230621185949.2068-1-quic_amelende@quicinc.com>
 <20230621185949.2068-3-quic_amelende@quicinc.com>
Message-Id: <168737621786.3403563.13933135215667889399.robh@kernel.org>
Subject: Re: [PATCH 2/7] dt-bindings: leds: leds-qcom-lpg: Add support for
 LUT through NVMEM devices
Date:   Wed, 21 Jun 2023 13:36:57 -0600
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


On Wed, 21 Jun 2023 11:59:46 -0700, Anjelique Melendez wrote:
> Update leds-qcom-lpg bindings to support LUT patterns through NVMEM
> devices.
> 
> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
> ---
>  .../bindings/leds/leds-qcom-lpg.yaml          | 85 +++++++++++++++++++
>  1 file changed, 85 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/leds/leds-qcom-lpg.example.dtb: /example-4/led-controller: failed to match any schema with compatible: ['qcom,pmi632-lpg']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230621185949.2068-3-quic_amelende@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

