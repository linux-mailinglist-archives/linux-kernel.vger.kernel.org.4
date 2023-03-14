Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83BB86B9760
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 15:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbjCNOKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 10:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbjCNOKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 10:10:45 -0400
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0F2746E7;
        Tue, 14 Mar 2023 07:10:39 -0700 (PDT)
Received: by mail-il1-f179.google.com with SMTP id h7so8694039ila.5;
        Tue, 14 Mar 2023 07:10:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678803039;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eS4/esiARLcOTfS3GdLeqZGAcqprgtcpPQrawrBj7eg=;
        b=Wof+pzJSIpP/hCNcTRLZCf8BALpfc8Kg8hF62PWzeH9cklITZwUr0Py53Y+e66ZCqc
         XFPMkAzwU2gZSsKszOmd9/2d4XvgjbtCF+hq6I5ijPKqkkIMrWNIT9FEl76XYHKJZap0
         dyh2U2TNswLOErHc9qH1/BA4HPqm299X0r4MIrssO4oU0K3j6LUGvQ5FklKoApuXMlUi
         00K1uI1UspuIDru82VkTjWhRKr+czYofEjLV6Mn6dgKc3r36KKC5ABQ4YPodl4mc9M+I
         zh/GnOVY7hoyHYDdOD/EAy4f8teU6XmLZSMxHBGQdzTqWdG86VZHQrC/5TP+avPCTKmT
         fX9w==
X-Gm-Message-State: AO0yUKW15Nh5iSmMcrx6vqxoaExNb/8+Wnfr1TfpF9nIvPMBLj1eZWvt
        819YceqhI0Z5WwAgXuCvutOnHFCppQ==
X-Google-Smtp-Source: AK7set9vurV8ePdJ3YUU8JtLsv59fy96jE59gbECky++E2PvPP3k8EJn8p4ZlNE3D5AbxhNRcvvApg==
X-Received: by 2002:a92:ce12:0:b0:316:e6e5:f0db with SMTP id b18-20020a92ce12000000b00316e6e5f0dbmr2485972ilo.0.1678803038894;
        Tue, 14 Mar 2023 07:10:38 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id f12-20020a926a0c000000b003231580e8e2sm841024ilc.6.2023.03.14.07.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 07:10:37 -0700 (PDT)
Received: (nullmailer pid 83774 invoked by uid 1000);
        Tue, 14 Mar 2023 14:10:19 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Joel Selvaraj <joelselvaraj.oss@gmail.com>
Cc:     phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        linux-input@vger.kernel.org, Caleb Connolly <caleb@connolly.tech>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jeff LaBundy <jeff@labundy.com>, devicetree@vger.kernel.org,
        Jean Delvare <jdelvare@suse.de>,
        Job Noorman <job@noorman.info>,
        Alistair Francis <alistair@alistair23.me>,
        Markuss Broks <markuss.broks@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>
In-Reply-To: <20230312093249.1846993-2-joelselvaraj.oss@gmail.com>
References: <20230312093249.1846993-1-joelselvaraj.oss@gmail.com>
 <20230312093249.1846993-2-joelselvaraj.oss@gmail.com>
Message-Id: <167880254230.25342.652645660925907921.robh@kernel.org>
Subject: Re: [PATCH 1/5] dt-bindings: input: touchscreen: add bindings for
 focaltech,fts
Date:   Tue, 14 Mar 2023 09:10:19 -0500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 12 Mar 2023 04:32:45 -0500, Joel Selvaraj wrote:
> Add devicetree bindings for the Focaltech FTS touchscreen drivers.
> 
> Signed-off-by: Joel Selvaraj <joelselvaraj.oss@gmail.com>
> Signed-off-by: Caleb Connolly <caleb@connolly.tech>
> ---
>  .../input/touchscreen/focaltech,fts.yaml      | 81 +++++++++++++++++++
>  1 file changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/focaltech,fts.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/input/touchscreen/focaltech,fts.example.dts:23.9-14 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/input/touchscreen/focaltech,fts.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1512: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230312093249.1846993-2-joelselvaraj.oss@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

