Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CECC6678BB9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 00:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbjAWXFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 18:05:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjAWXFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 18:05:44 -0500
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D568E195;
        Mon, 23 Jan 2023 15:05:42 -0800 (PST)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-15085b8a2f7so15831711fac.2;
        Mon, 23 Jan 2023 15:05:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5K+QwMf3q1ON3JuiG+9OW2PVcrwMBDaRZk0RWszHFjI=;
        b=5PUsjfWGiHp83fuOT3YG8x70/wiNbwX3eMg/RohK5wf54JkVheCe9eWrU6h8LFW31b
         w2ZjL6VIIBmNh+51en7wdk/GyiA8mozur1O2GTJ6jeIFQmVoQKFvSrD0rgqZxBlxN+yH
         VMsW0Sb3G3UJtlgxRe6Aoz03PuTjcRP4uIVZzBQfUbicH/5bZyZDLFOS73z8aiWaPMP1
         BPd1tAvpwHR1k5xaZ8wGxgFPKOaF4OBiAqh23B2WcMgdOwud4BPWF1BYmRzFoByLQTwy
         8/JS9Z/bt4OFsgy9deCbfYvrOeRF6kDQStaxU7qGdA+cAOrwFQyJyYpp5XKLjIBNGDYq
         hXeQ==
X-Gm-Message-State: AO0yUKWURauJMKSO51nf2pyNpgXvKPOfb/hFcYfLT8atogcf3+3wUgjM
        VSboe3L8SGxQOuEwoWLBWA==
X-Google-Smtp-Source: AK7set/h7sr6uhQW/0sGu9o6CylIQ3HnC2k/IV6qUD9neLaJawnkv+Apgu0382wuFxmdnJG73B65tg==
X-Received: by 2002:a05:6870:ea93:b0:160:346c:dd97 with SMTP id s19-20020a056870ea9300b00160346cdd97mr1085832oap.24.1674515142027;
        Mon, 23 Jan 2023 15:05:42 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r141-20020a4a3793000000b0050dc3c2f77asm104345oor.8.2023.01.23.15.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 15:05:41 -0800 (PST)
Received: (nullmailer pid 2813085 invoked by uid 1000);
        Mon, 23 Jan 2023 23:05:40 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, - <devicetree@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        Chester Lin <clin@suse.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, Fugang Duan <fugang.duan@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Le Ray <erwan.leray@foss.st.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Pragnesh Patel <pragnesh.patel@sifive.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-amlogic@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20230123151302.368277-11-krzysztof.kozlowski@linaro.org>
References: <20230123151302.368277-1-krzysztof.kozlowski@linaro.org>
 <20230123151302.368277-11-krzysztof.kozlowski@linaro.org>
Message-Id: <167451486467.2795286.1299932821783618559.robh@kernel.org>
Subject: Re: [PATCH 11/13] dt-bindings: serial: restrict possible child node names
Date:   Mon, 23 Jan 2023 17:05:40 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 23 Jan 2023 16:13:00 +0100, Krzysztof Kozlowski wrote:
> The re-usable serial.yaml schema matches every property with ".*"
> pattern, thus any other schema referencing it will not report unknown
> (unevaluated) properties.  This hides several wrong properties.  It is
> a limitation of dtschema, thus provide a simple workaround: expect
> children to be only of few names matching upstream usage (Bluetooth,
> GNSS, GPS and MCU).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/serial/serial.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/bus/intel,ixp4xx-expansion-bus-controller.example.dtb: serial@1,0: Unevaluated properties are not allowed ('intel,ixp4xx-eb-byte-access', 'intel,ixp4xx-eb-cycle-type', 'intel,ixp4xx-eb-t3', 'intel,ixp4xx-eb-write-enable' were unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/serial/8250.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230123151302.368277-11-krzysztof.kozlowski@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

