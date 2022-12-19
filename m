Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C095E651270
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 20:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbiLSTLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 14:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbiLSTK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 14:10:58 -0500
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B503D2F1;
        Mon, 19 Dec 2022 11:10:54 -0800 (PST)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-142b72a728fso12711679fac.9;
        Mon, 19 Dec 2022 11:10:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+5raIVmkATLs5kf4lFGVOCgkR/IHy+HENdY2c/Hj4Z4=;
        b=oBfmtayraGRwH6autp7WzlWg1mOG8lw90RtjXwxntGcpp2pHThFvXAYIjWT5r7ZQfN
         jYPnzbc3X7tPPX693pXmp67xzlrCnaHPlLlJEqktbbKbls9tE+8KGzRiGY8NtwwinnaG
         RVV22ssI4J0s/HjJcN1r4PSieMhYcUb4Nf5WdyFHBhNAFFq9IvuQna2vU0sPR/CuP6uo
         18omsdiIpiM7Qi/zo7Tlz9e169FjxZ+TLQ79JuNYGtXs7VWDtp5yrec2DJ4FOmG1RxkM
         Sr8qKbFB7lzApW2H3uO0vN9p0GJiXwZrhRKx7DXO+lCllpL10GsyM9zzstxxcEngAOeT
         Bbhw==
X-Gm-Message-State: ANoB5plN38XHrUCHkQ9G2wxABXPPiKQN/jf1dQnvhnMmh882DEhTWFa0
        FP1GDCmCbgj4lGvOQ+K2gw==
X-Google-Smtp-Source: AA0mqf5uy2z1Px+lvgd48zxf2Np4GkD7Kjg/b/oNMMimRBtrvEYAW8M9qB2UdQywDGK10wHcqUvDiw==
X-Received: by 2002:a05:6870:50c:b0:137:5344:70ab with SMTP id j12-20020a056870050c00b00137534470abmr21296969oao.15.1671477053900;
        Mon, 19 Dec 2022 11:10:53 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o15-20020a056870524f00b0010d7242b623sm5124258oai.21.2022.12.19.11.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 11:10:53 -0800 (PST)
Received: (nullmailer pid 1974177 invoked by uid 1000);
        Mon, 19 Dec 2022 19:10:52 -0000
From:   Rob Herring <robh@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>
Cc:     linux-rockchip@lists.infradead.org,
        Johan Jonker <jbx6244@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: usb: snps,dwc3: Allow power-domains property
Date:   Mon, 19 Dec 2022 13:10:37 -0600
Message-Id: <20221219191038.1973807-1-robh@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Rockchip RK3399 DWC3 node has 'power-domain' property which isn't
allowed by the schema:

usb@fe900000: Unevaluated properties are not allowed ('power-domains' was unexpected)

Allow DWC3 nodes to have a single power-domains entry. We could instead
move the power-domains property to the parent wrapper node, but the
could be an ABI break (Linux shouldn't care). Also, we don't want to
encourage the pattern of wrapper nodes just to define resources such as
clocks, resets, power-domains, etc. when not necessary.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
index 6d78048c4613..bcefd1c2410a 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
@@ -91,6 +91,9 @@ properties:
         - usb2-phy
         - usb3-phy
 
+  power-domains:
+    maxItems: 1
+
   resets:
     minItems: 1
 
-- 
2.35.1

