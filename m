Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376E86EB4C3
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 00:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbjDUWbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 18:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbjDUWbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 18:31:41 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867601BF5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 15:31:40 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-953343581a4so311229966b.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 15:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682116299; x=1684708299;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tHsoXDxz1/UTx6EBnwD4GozBhAQVv+WOC5RetDWcnZ4=;
        b=uHsMB7x0Xp2Q+ayCfEMDyPvNll3SI8+ipJ52v+0W/l6PZk6dTdooXFXz7/uSwn+gb7
         TGmOk+N5FQpWWnnVTFtrERp3aAELYIt5pO3/N8z0/qInvjfEW9+LXKZO1zATX1NTBK8K
         /w0m3FMltIhO7NGnlMFqDxTCO+G0J5FG+tjnvkS/+PXn/+nZd03zVwOpxUSdcEnOS1Pg
         c5zi5Kn2WvByRHRNogglHMlDIaBv0XY0+G3T2ZNmSO870iiGBPw3+/4oclcjlGgoigYk
         YxYcwFKCBzKnt9ULlO4qV/C8KhFfA9/ZfmPejU/H6ih4OFMYLYp77zCn3nYTUb/eZabQ
         JYIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682116299; x=1684708299;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tHsoXDxz1/UTx6EBnwD4GozBhAQVv+WOC5RetDWcnZ4=;
        b=assXL7bd3emeA94ts9m7MGVutGh60cv7MEEMbZr4boCzDSMLsQTgqwaieyNgIDdhGr
         HNEuE4evYmPouQV3r2ImtwFsYck36BLrN2C3rL9eyk166LBgG+RQPJ9kWs/UBIjI/8k4
         ZjATzVNyumL8sKGAD2SkX36VfWJ8ysH+rEtNg5HJMw3KDOYiaQteQAVn1sj7oEf7SQpo
         WKI1wbJFNw9bcFpEwZp8TxHiD+K+3gVVN4G+ZzcI0CoTDxJBNMjEhgaNH28Af6ClVEYG
         Fi+pNgU+19tLknk1nkoXp4XLw5+H1H9gtDrXVLuxeryNBwSjl2rhXT8DqvhO/aa+LTOL
         WhUw==
X-Gm-Message-State: AAQBX9cm35VN77jUDVSgR3EZ0d94b9gmHljmH3TuS7RqF4qlLnG9wuLA
        GBQ0QCw6SQFMuHNO+BhM4yygJA==
X-Google-Smtp-Source: AKy350Y2WtdIrB8KUkVxhNUfP+cw41JryLuepwl1MmDWr8r7jE/LiFDauoeJJ2LjhOQ/r86bda7hjg==
X-Received: by 2002:a17:906:b147:b0:933:868:413a with SMTP id bt7-20020a170906b14700b009330868413amr3914177ejb.15.1682116299030;
        Fri, 21 Apr 2023 15:31:39 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:687d:8c5:41cb:9883])
        by smtp.gmail.com with ESMTPSA id sd22-20020a1709076e1600b009572bd99281sm1077677ejc.224.2023.04.21.15.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 15:31:38 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: allwinner: a64: add missing cache properties
Date:   Sat, 22 Apr 2023 00:31:37 +0200
Message-Id: <20230421223137.115015-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As all level 2 and level 3 caches are unified, add required
cache-unified property to fix warnings like:

  sun50i-a64-pine64-lts.dtb: l2-cache: 'cache-unified' is a required property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Please take the patch via sub-arch SoC tree.
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 62f45f71ec65..a9c7f82c2c66 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -93,6 +93,7 @@ cpu3: cpu@3 {
 		L2: l2-cache {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
-- 
2.34.1

