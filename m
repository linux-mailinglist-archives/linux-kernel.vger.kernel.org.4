Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F82A6EB4D9
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 00:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbjDUWcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 18:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233887AbjDUWcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 18:32:16 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6205A2711
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 15:31:59 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5069097bac7so3807526a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 15:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682116317; x=1684708317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pitbg/AnYT+7wXCt2mEuce2KB1B0+ui+WWGwpaQkC98=;
        b=obQptdKkaIozOZTGXFT1iVgi7FGrMW2Lj8aeh2p+N8wIZVxxTSYwSQFbVo0wieyBz5
         dupy9VN1DyQ0aXwyZuqV5tQ+2BcMN0mwDRcy/Vaowqe+qnCSZo6sqQs+xsa1DuwIpwDx
         KkR9b4GhsHpkW32xOTQJjzFUPUmEtO5VPD723rkdbY8KSBYRjgIzrdOzW5S+VqQq/UG5
         UjaSvL6HuXEudfIItlWBTQmFpkvVXXNWaRBt4Z0erOxFDDH+GLFnAT5ZFMasSBkx5iyl
         e42sd0Ax3liSxphHuDrnf4mqnLPQvyMWn5JIIVmb1WAkaMOAGF5JH4TKtSzvs3JiKrlr
         xKdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682116317; x=1684708317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pitbg/AnYT+7wXCt2mEuce2KB1B0+ui+WWGwpaQkC98=;
        b=QepGyB2v1st11DDwfqBD1rdASs8jwzN8K+ZjAX0X0WzkIXgRVIXqUm+pM1cTCzmsJG
         5oatq/VPH76u/Jq3E+OsFaWi0G/xiSGfT6UMVh4gPOUv95zVKQLd1fmkUgLZxo0MkdPp
         4t2+H/Qkmf8O2wB6hU2jfpMBKDU6g2m91P1KvxR5Rbo3p9pQRPSUEpQYBo/XDWU2xuXp
         P1OluDpN6ZeGwS1Usmuu3WP5PM+aojBo592sSRZQucFEpo58IirA5Uw0MLrtcjrh/9BB
         x9TlT6K8nxnYC92Ivk0GULmryRJpZ5pQeB4T+p0EcvkIYw4R4+KLqw6Lvi30VEF+NJmI
         YILg==
X-Gm-Message-State: AAQBX9c4JQdntHx4crr4M2UGD/A2g+OOxYewI356quAg+9A+WIODCTlk
        PZE3mnFifS0c6aHRH6Wci/Y+vA==
X-Google-Smtp-Source: AKy350a4cH/QIL/qloNHWJRinYsd8kmdQ+P6b2qfd9I7RLwogiFF9xZftwYXCGRC7bb0w960Uf+mMg==
X-Received: by 2002:a50:fa89:0:b0:4fa:b302:84d4 with SMTP id w9-20020a50fa89000000b004fab30284d4mr6180279edr.13.1682116317328;
        Fri, 21 Apr 2023 15:31:57 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:687d:8c5:41cb:9883])
        by smtp.gmail.com with ESMTPSA id p15-20020aa7cc8f000000b004aef147add6sm2223867edt.47.2023.04.21.15.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 15:31:56 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        UNGLinuxDriver@microchip.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: microchip: add missing cache properties
Date:   Sat, 22 Apr 2023 00:31:55 +0200
Message-Id: <20230421223155.115339-1-krzysztof.kozlowski@linaro.org>
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
cache-unified and cache-level properties to fix warnings like:

  sparx5_pcb125.dtb: l2-cache0: 'cache-level' is a required property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Please take the patch via sub-arch SoC tree.
---
 arch/arm64/boot/dts/microchip/sparx5.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/microchip/sparx5.dtsi b/arch/arm64/boot/dts/microchip/sparx5.dtsi
index 0367a00a269b..6f7651b06478 100644
--- a/arch/arm64/boot/dts/microchip/sparx5.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5.dtsi
@@ -52,6 +52,8 @@ cpu1: cpu@1 {
 		};
 		L2_0: l2-cache0 {
 			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
-- 
2.34.1

