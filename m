Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB3962BCE1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbiKPMC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233510AbiKPMBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:01:44 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF0D20189;
        Wed, 16 Nov 2022 03:54:12 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5so11727425wmo.1;
        Wed, 16 Nov 2022 03:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LF0LjuwpVD5bvELJ2ZgPUI3haSAQ4UjC1mWIKy2m4Y8=;
        b=XftHchxXAdJvPyzYZpTP/XYZOeYDMvA1r0Ol9Auq1iSOdj/fvlbzk1YFkKfgWrNjxV
         xAyIAoxyuFjWHhATL3yjLt5PKtgOSZxx8xgg8GmphdNp08sk5/lDxCvnwisr+XZF9bhv
         wUD025DdU6GR1Go+wG3Zbzml8IH5b+9JEbLXADukYnwdidVPu85cHtfiqtA0ogJzB1m7
         gO2H6R39H8JhEviXKSO3F60cCsja6XAMUz21Ls+Ov5oKrScWPEgibpd2DS4/89nwtjTj
         HBgvl+yfrlupmwC7/qYZ+eQrtxEU8u7MWRg4kwhlo+4TfK3MshWgJfvoIvsmQIAIVcxK
         LsQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LF0LjuwpVD5bvELJ2ZgPUI3haSAQ4UjC1mWIKy2m4Y8=;
        b=PdqrjsEz9DipEdbAKbxMTBp+MUUuF7nUk4bylFf10JurkgwtBq/IYdxgS3pxox5UWe
         9F+a1g0j+gN6BTg/Uh2fl4Hps/6+2v6YL+QwOoHFDOMmC6vqA+OCuj180rY812vQSr+9
         sDYfK4crIaSn3dt82a7RVK/G9RTignRF4lNuMBZEY2cMIhs225kKEudGWjWrbJpVNh/A
         1+KAcnC4HyBARaeXReBNENkiEfyP7UM8kSvqeJh/WvUPHHm/grdveMBaL2KAmhd574Gs
         4agZ2e4sgttfJoyISG9LOtIs1FZ2XuOjyVDHrSbJk1rh3FGwjRlBQtaRolUsFYxjIRxC
         JTBA==
X-Gm-Message-State: ANoB5pkH4/IcLzllWH8DcmiLYCoe5p/OubSf6Tx8zaYO7PJGQWPHAMb/
        O6Bgmy9jfQM2qQJySLW1b8Q=
X-Google-Smtp-Source: AA0mqf5ONZTEN2oLJRD8V3MZpSxDHVHSjCcPWyfLWgcxe0Q6mTew2HFN7qcklPrBY9BxRRETnYaYJw==
X-Received: by 2002:a05:600c:6890:b0:3cf:497c:c4c1 with SMTP id fn16-20020a05600c689000b003cf497cc4c1mr1899998wmb.117.1668599650821;
        Wed, 16 Nov 2022 03:54:10 -0800 (PST)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id bt14-20020a056000080e00b002417e7f0685sm14576047wrb.9.2022.11.16.03.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 03:54:10 -0800 (PST)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] dt-bindings: arm: rockchip: Add SOQuartz Blade
Date:   Wed, 16 Nov 2022 12:53:34 +0100
Message-Id: <20221116115337.541601-2-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116115337.541601-1-frattaroli.nicolas@gmail.com>
References: <20221116115337.541601-1-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an enum for the SOQuartz Blade base board to the rockchip
platforms binding.

The SOQuartz Blade is a PoE-capable carrier board for the CM4 SoM
form factor, designed around the SOQuartz CM4 System-on-Module.

The board features the usual connectivity (GPIO, USB, HDMI,
Ethernet) and an M.2 slot for SSDs. It may also be powered from
a 5V barrel jack input, and has a 3.5mm jack for UART debug
output.

Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index e40a3da90000..19797aca1fa0 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -578,6 +578,7 @@ properties:
       - description: Pine64 SoQuartz SoM
         items:
           - enum:
+              - pine64,soquartz-blade
               - pine64,soquartz-cm4io
           - const: pine64,soquartz
           - const: rockchip,rk3566
-- 
2.38.1

