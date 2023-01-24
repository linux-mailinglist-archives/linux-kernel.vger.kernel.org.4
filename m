Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF48E67954C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 11:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbjAXKeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 05:34:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233578AbjAXKeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 05:34:37 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A5140BC5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 02:34:27 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id j17so11097322wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 02:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SgP0cw5fx/i+2eK9QIjVGPdzg1sK0wxXwC3QQeMgW+4=;
        b=gYuWo5AV7I67iDn889BBqUGZq3cacMS4y2uWUsiSTm1YBoaqp+7ie0uZQOXE5yMTct
         haSTlh6HKBd4ZxU5ytkotToybZnPBuLxcpkpIb+kWZVOkmXoGKwX65R3djcD0qiGyph6
         hrKfZB/EKLbhFevt/VDakLTe4l7QOBV4ofUdTf1VYuyfbdmu8RXTMs2HLb9vX4XPEHR7
         +rZf52FAFCTUIEX5lWLLu7Hh5LvRADnloJCdJlOsw47+81CTlX7l/G81uRrqvuAePh+G
         GdNIKr9BJYU13oGTqN+XqUrvsqVzycyrGfP5WdZ19pRYe3fGVxW/x7bLqRuMFrNnpF3d
         9d2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SgP0cw5fx/i+2eK9QIjVGPdzg1sK0wxXwC3QQeMgW+4=;
        b=VWijvAIa/ksoqBw+mn0VkKcgTTBT2d8mZk9zCLVv5xLDqTDVV+Mh9aHa7evGE1S9eo
         0crRAVtDd8Wv/0MODqt2FAuzsQn0xSCxNXevcAXgKHtuMxmR/UHSyoyaMV2GxvCrA956
         B9OiUQlRvNMX/gsi9EFW6MTpedxSBqvbI58orETW33voYTQAd8vnPT0ctGqLdLFoXkaY
         02FD3Ku6CQFp752qyLrd65naj9AxR5yLTmy7GKjfj3udBrRgFI7k2eFQD27RmyocLwpe
         gJTWncc0oLEqD/9fIhhHPVNgL5Zo7wf/vTnrurGdjKIhPe4h/wIexDGRS4qhgQ3CexEj
         XFWg==
X-Gm-Message-State: AFqh2koxze2kvMRwQXM09e2Q/qaiaGCPoTa7/t9MGtRUfmCKY3uvkZXG
        gOImNb+o9jlY5oVw1+lVx2051A==
X-Google-Smtp-Source: AMrXdXvC5sKP/orS0sFdGP+jXhVFRAlaxxJEH33JUUod6+5y/LerkdNqkh7Ez4SoOsCCmaHh3E42Kg==
X-Received: by 2002:a05:600c:3c92:b0:3d3:4007:9c88 with SMTP id bg18-20020a05600c3c9200b003d340079c88mr27615743wmb.18.1674556465674;
        Tue, 24 Jan 2023 02:34:25 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id q6-20020adfcd86000000b002bded7da2b8sm1551889wrj.102.2023.01.24.02.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 02:34:25 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 24 Jan 2023 11:34:22 +0100
Subject: [PATCH 01/14] arm64: dts: amlogic: meson-gx: fix SCPI clock dvfs
 node name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230124-b4-amlogic-bindings-fixups-v1-1-44351528957e@linaro.org>
References: <20230124-b4-amlogic-bindings-fixups-v1-0-44351528957e@linaro.org>
In-Reply-To: <20230124-b4-amlogic-bindings-fixups-v1-0-44351528957e@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes:
scpi: clocks: 'clock-controller' does not match any of the regexes: '^clocks-[0-9a-f]+$', 'pinctrl-[0-9]+'

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index a79a35e84281..11f3b3a4df97 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -250,7 +250,7 @@ scpi {
 		scpi_clocks: clocks {
 			compatible = "arm,scpi-clocks";
 
-			scpi_dvfs: clock-controller {
+			scpi_dvfs: clocks-0 {
 				compatible = "arm,scpi-dvfs-clocks";
 				#clock-cells = <1>;
 				clock-indices = <0>;

-- 
2.34.1

