Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4A2658D14
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 14:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbiL2N1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 08:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233125AbiL2N1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 08:27:39 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3133CFAEA
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 05:27:37 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id z26so27495945lfu.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 05:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gZSCpbFYEqU4kXdvZagC2f9wuaUgm6zGDC72Dg77aBg=;
        b=EwfxI6MHyfLh+RSomgQ/cBEJaIlk0FfQzfv/1WmxeBnIqFl+gB6RBwDJjb6x2mq5xV
         i74mE6DVGWFPrVoCO9sqzlYASEzyvDfz6oS2BwoyAVRfmmwuIgg3+VwrJ6DZ0XWwB3nk
         KKL2qZYJ4M0emp+ggc19qQhLyiohmz2/MYqxv+B0g/V/5naXND6T1B7YL3SADG9+6RaV
         I94ex3DIgPZL9BHtpCFYGTOgUn/3rNJP/OaueAMsBr/6XKAvlO9l7e+8nTwNYzJNDm4d
         sbsyZa3JprKLvqb/Om/QIawYIMq2EtLzVqF8KCWv5HbvZBFrFanYXbhwsIGdFr+KddNp
         jAIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gZSCpbFYEqU4kXdvZagC2f9wuaUgm6zGDC72Dg77aBg=;
        b=Q284nTzrU4yHalW/j6QKsFMbW45mF0Kquga0PYB9rvRkuvtTCCBNfczy58Oq8DfMQF
         M//oBKtPIEP7AjPQ8BL3aNi70FB4hcE7zUWmmFlH+KMEUHHEe47KyuNGCFKXNXFCOk6V
         ZEhhqwjvUUQ4pqFjefcIbHV4oMz6FW10PTo2zy5nGcxLzktPcVtemlKpmQwsAtAOdH2/
         P2OZseA3+B1p+o4D83QRlOfrHkfjBBaXQ+JxFovdd4Vn14dGCtzE+ozKya2UjILJuOQ/
         D/SDmkO26iTr7ocHTGCqj5j1r+XDym45giLTG2I4Qi4Nuk4u6QCP0xojDc+FWrX216Fl
         5LcQ==
X-Gm-Message-State: AFqh2kr+lSx60NmL49VQedh1yiVOV44l9+Q7oPlUpVeWzWxYcJJiVypf
        EPyhAoOogh2DkEpPSS7AbT07zw==
X-Google-Smtp-Source: AMrXdXsZF5PMbIvZk9Qtlm7oBw6pmmt5L+LuelrSLsR94OcdSMuTwoN6ZdPt/P+Mn+1tEN8QXaqxhg==
X-Received: by 2002:ac2:5327:0:b0:4b6:e64c:aec1 with SMTP id f7-20020ac25327000000b004b6e64caec1mr7226461lfh.53.1672320455538;
        Thu, 29 Dec 2022 05:27:35 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id 3-20020ac25f43000000b004996fbfd75esm3040595lfz.71.2022.12.29.05.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 05:27:35 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: qcom: sm8250: add cache size
Date:   Thu, 29 Dec 2022 14:27:31 +0100
Message-Id: <20221229132731.1193713-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add full cache description to DTS to avoid:
1. "Early cacheinfo failed" warnings,
2. Cache topology detection which leads to early memory allocations and
   "BUG: sleeping function called from invalid context" on PREEMPT_RT
   kernel:

  smp: Bringing up secondary CPUs ...
  Detected VIPT I-cache on CPU1
  BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:46
  in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 0, name: swapper/1
  preempt_count: 1, expected: 0
  RCU nest depth: 1, expected: 1
  3 locks held by swapper/1/0:
   #0: ffff5e337eee5f18 (&pcp->lock){+.+.}-{3:3}, at: get_page_from_freelist+0x20c/0xffc
   #1: ffffa9e24a900b18 (rcu_read_lock){....}-{1:3}, at: rt_spin_trylock+0x40/0xe4
   #2: ffff5e337efc8918 (&zone->lock){+.+.}-{3:3}, at: rmqueue_bulk+0x54/0x720
  irq event stamp: 0
  Call trace:
   __might_resched+0x17c/0x214
   rt_spin_lock+0x5c/0x100
   rmqueue_bulk+0x54/0x720
   get_page_from_freelist+0xcfc/0xffc
   __alloc_pages+0xec/0x1150
   alloc_page_interleave+0x1c/0xd0
   alloc_pages+0xec/0x160
   new_slab+0x330/0x454
   ___slab_alloc+0x5b8/0xba0
   __kmem_cache_alloc_node+0xf4/0x20c
   __kmalloc+0x60/0x100
   detect_cache_attributes+0x2a8/0x5a0
   update_siblings_masks+0x28/0x300
   store_cpu_topology+0x58/0x70
   secondary_start_kernel+0xc8/0x154

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

The patch extends and depends in context on:
https://lore.kernel.org/r/20221107155825.1644604-17-pierre.gondois@arm.com

Cache sizes from publicly available data:
https://en.wikichip.org/wiki/qualcomm/snapdragon_800/865
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 4478bf0e7b22..4555345ee42e 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -111,10 +111,14 @@ CPU0: cpu@0 {
 			L2_0: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-size = <0x20000>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 				L3_0: l3-cache {
 					compatible = "cache";
 					cache-level = <3>;
+					cache-size = <0x400000>;
+					cache-unified;
 				};
 			};
 		};
@@ -137,6 +141,8 @@ CPU1: cpu@100 {
 			L2_100: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-size = <0x20000>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -159,6 +165,8 @@ CPU2: cpu@200 {
 			L2_200: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-size = <0x20000>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -181,6 +189,8 @@ CPU3: cpu@300 {
 			L2_300: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-size = <0x20000>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -203,6 +213,8 @@ CPU4: cpu@400 {
 			L2_400: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-size = <0x40000>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -225,6 +237,8 @@ CPU5: cpu@500 {
 			L2_500: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-size = <0x40000>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 
@@ -248,6 +262,8 @@ CPU6: cpu@600 {
 			L2_600: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-size = <0x40000>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -270,6 +286,8 @@ CPU7: cpu@700 {
 			L2_700: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-size = <0x80000>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
-- 
2.34.1

