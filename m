Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459C97209E5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 21:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235808AbjFBTeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 15:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236141AbjFBTeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 15:34:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A77E19B
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 12:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685734406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=7Z1/Pgz58TbhaQAzpuoEur5XNSR4LavXZhKLTHjF5Cw=;
        b=FlZeDhvsdoVuIeC5RUv0HGDQMjfAbROZdUmW6xV21lgMmSSVDqdsPm/178bwkDAu/RgoC7
        azlDlrKeaXaR9AR4CtHOBxygo2Ixd3qBYpe8S7bv7KvfcijdO02ywssSxvoTqiqnag90LD
        cLtmWlirHa+1SI/7EDv0h8atnxkqPRs=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-4mpDBvSYNBqVaCzvH69W8Q-1; Fri, 02 Jun 2023 15:33:25 -0400
X-MC-Unique: 4mpDBvSYNBqVaCzvH69W8Q-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6237c937691so28208436d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 12:33:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685734403; x=1688326403;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Z1/Pgz58TbhaQAzpuoEur5XNSR4LavXZhKLTHjF5Cw=;
        b=BKqiQGCPrVjw8cjf4vRPtEQhOVcy65IyvjBlzgnHhynY/xTrhlm9iJzConwc6xwV0K
         taous/1LeFp38DF+gmoJHaEbX1jaXrlGKDZ9TrHV0q+DxyOY4OGqav2s4d6gtJ3cS7nc
         UXboY8yVvmSXMB5m6UIypW0vRuayQoBRsVDqIEV2wDlh1VzoZOnL3nQPfP8iajqQ6XQo
         Y1Zm+qaaVsKtmf7AAzTlEaxEcmcbttMd+EzBOOK1HtfHKuKVdMEl4bUP3eTl/dStK08U
         Bv2Qe00lgFWnda8vqIhxn3KsY2OQWNlDtICmohw70qKqc7I8ISYtKo/ekzRpxkRY9hPm
         EBrg==
X-Gm-Message-State: AC+VfDxyOcVXrYsTl5CWKpeL32imJOJRF7NaN2jKFjDZiRxM9uVzhWMT
        DK6fJD7OTbV7x3r9eRuyoE4GgzHIPVGUJ9QzMLQwpFT44ToZcJyaidvLCOsWhOcY+cwPtf/7KYm
        JugqAo8Y+9OT0T9SRjV9mxakOpMzRwxl5xsSP2naTwplkPcT1OD9zPhQVSvnyqmaTYV4qoG4LkV
        TeYLkVFt8bggufmg==
X-Received: by 2002:a05:6214:240b:b0:623:9a08:4edd with SMTP id fv11-20020a056214240b00b006239a084eddmr7805026qvb.25.1685734403696;
        Fri, 02 Jun 2023 12:33:23 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7NZR2ZeuZ9ArjkHu3p5/1mDjjAHhYDJMspDvekkAGQhPg38icwokA4+1iokJfw7YqLFuJqFA==
X-Received: by 2002:a05:6214:240b:b0:623:9a08:4edd with SMTP id fv11-20020a056214240b00b006239a084eddmr7804993qvb.25.1685734403378;
        Fri, 02 Jun 2023 12:33:23 -0700 (PDT)
Received: from fedora (bras-base-wndson1334w-grc-09-142-113-164-22.dsl.bell.ca. [142.113.164.22])
        by smtp.gmail.com with ESMTPSA id f30-20020ad4559e000000b0061c7431810esm1145512qvx.141.2023.06.02.12.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 12:33:22 -0700 (PDT)
Date:   Fri, 2 Jun 2023 15:33:21 -0400
From:   Lucas Karpinski <lkarpins@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        ahalaney@redhat.com, echanude@redhat.com, bmasney@redhat.com,
        quic_shazhuss@quicinc.com
Subject: [PATCH] Revert "arm64: dts: qcom: sa8540p-ride: enable pcie2a node"
Message-ID: <pmodcoakbs25z2a7mlo5gpuz63zluh35vbgb5itn6k5aqhjnny@jvphbpvahtse>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20230517
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 2eb4cdcd5aba2db83f2111de1242721eeb659f71.

The patch introduced a sporadic error where the Qdrive3 will fail to
boot occasionally due to an rcu preempt stall.
Qualcomm has disabled pcie2a downstream:
https://git.codelinaro.org/clo/la/platform/vendor/qcom-opensource/rh-patch/-/commit/447f2135909683d1385af36f95fae5e1d63a7e2f

rcu: INFO: rcu_preempt self-detected stall on CPU
rcu:     0-....: (1 GPs behind) idle=77fc/1/0x4000000000000004 softirq=841/841 fqs=2476
rcu:     (t=5253 jiffies g=-175 q=2552 ncpus=8)
Call trace:
 __do_softirq
 ____do_softirq
 call_on_irq_stack
 do_softirq_own_stack
 __irq_exit_rcu
 irq_exit_rcu

The issue occurs normally once every 3-4 boot cycles.
There is likely a race condition caused when setting up the two pcie
domains concurrently (pcie2a and pcie3a).

The issue is not present when only pcie2a is enabled or when only pcie3a
is enabled.
A workaround was found that allowed the Qdrive3 to boot with both pcie2a
and pcie3a enabled.
Set the .probe_type to PROBE_FORCE_SYNCHRONOUS and add an msleep() to
the probing function.
This is not a solution, so this patch is disabling pcie2a as it seems
Red Hat are the only ones working on the board,
we're find with disabling the node until a root cause is found. If
anyone has further suggestions for debugging, let me know.

Signed-off-by: Lucas Karpinski <lkarpins@redhat.com>
---
 During debugging:
        - Added additional time for clock/regulator stabilization.
        - Reduced the bandwidth across pcie2a and pcie3a.
        - Replaced the interconnect setup from another driver.
        - The 32-bit/64-bit/config-io space for both pcie2a and pcie3a look to be mapped correctly.
        - Verified interconnects were started successfully.

 arch/arm64/boot/dts/qcom/sa8540p-ride.dts | 44 -----------------------
 1 file changed, 44 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
index 24fa449d48a6..d492723ccf7c 100644
--- a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
@@ -186,27 +186,6 @@ &i2c18 {
 	status = "okay";
 };
 
-&pcie2a {
-	ranges = <0x01000000 0x0 0x3c200000 0x0 0x3c200000 0x0 0x100000>,
-		 <0x02000000 0x0 0x3c300000 0x0 0x3c300000 0x0 0x1d00000>,
-		 <0x03000000 0x5 0x00000000 0x5 0x00000000 0x1 0x00000000>;
-
-	perst-gpios = <&tlmm 143 GPIO_ACTIVE_LOW>;
-	wake-gpios = <&tlmm 145 GPIO_ACTIVE_HIGH>;
-
-	pinctrl-names = "default";
-	pinctrl-0 = <&pcie2a_default>;
-
-	status = "okay";
-};
-
-&pcie2a_phy {
-	vdda-phy-supply = <&vreg_l11a>;
-	vdda-pll-supply = <&vreg_l3a>;
-
-	status = "okay";
-};
-
 &pcie3a {
 	ranges = <0x01000000 0x0 0x40200000 0x0 0x40200000 0x0 0x100000>,
 		 <0x02000000 0x0 0x40300000 0x0 0x40300000 0x0 0x20000000>,
@@ -356,29 +335,6 @@ i2c18_default: i2c18-default-state {
 		bias-pull-up;
 	};
 
-	pcie2a_default: pcie2a-default-state {
-		perst-pins {
-			pins = "gpio143";
-			function = "gpio";
-			drive-strength = <2>;
-			bias-pull-down;
-		};
-
-		clkreq-pins {
-			pins = "gpio142";
-			function = "pcie2a_clkreq";
-			drive-strength = <2>;
-			bias-pull-up;
-		};
-
-		wake-pins {
-			pins = "gpio145";
-			function = "gpio";
-			drive-strength = <2>;
-			bias-pull-up;
-		};
-	};
-
 	pcie3a_default: pcie3a-default-state {
 		perst-pins {
 			pins = "gpio151";
-- 
2.40.1

