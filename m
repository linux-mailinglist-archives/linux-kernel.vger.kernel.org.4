Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4FC1677D42
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 14:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbjAWN6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 08:58:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbjAWN6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 08:58:52 -0500
Received: from egress-ip33b.ess.de.barracuda.com (egress-ip33b.ess.de.barracuda.com [18.185.115.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6423524128
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 05:58:51 -0800 (PST)
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197]) by mx-outbound23-45.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 23 Jan 2023 13:58:49 +0000
Received: by mail-pl1-f197.google.com with SMTP id k5-20020a170902c40500b001947b539123so7188787plk.19
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 05:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wV+Kj+K4J1wlqE7LHo8AldMdY3VXw5XQ4NiMT571Jh8=;
        b=m4jVDGC3ktM5wMGID4vlTKOBA5NDMsp72YfvG2oaHBfV91+8PvP8TQpwklIAop/BC7
         DjbiPKSdiZIYN/8xWuEc8lviihlxTb7VYwd/HCgTAyMKwo1FMnG/QS2bfaxcP0QJgju7
         7yaAAfGPq5dv8m2e0CSgXEIxEUtdogGAIFIYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wV+Kj+K4J1wlqE7LHo8AldMdY3VXw5XQ4NiMT571Jh8=;
        b=1jKzmPZQsUYjBdAP7QGrv5kVEl/c0z3ZtweuOShFoHXe/cE9hGVMqQ6GZBFmrbSJY4
         9eV50ZezURg4etPw5rQiVME8+F+kDXtVKUh/yGEpPRFJpBNiSTsEHVvOcDc6FLCOwsS8
         QHYWOUa25FUJAUPmp46fhmniVYJEipqp9f6sOSsJ+Zou+/N6tJfX/whfEUQvmGVW9A++
         pvSJWe3TR0f3VBMPqZjoZh6ByIME5L0Yp61z3gnrHuf/UchGgkyFc3Jtr4BsrS1DTs5o
         pds+sQCTde06EJLj/jyJAP/cGDqfBjUZse9N9Y6ZDwclLwj/2wYDZ7aUKSPq4yHlgavH
         sIAw==
X-Gm-Message-State: AFqh2kqA8w9daFxBv5G21ONxYkDgivneYWpE50/r0m4vlGghN9B0QcLo
        0fzAB+KR8ueKqro/3/m2tyyjwdJIjVhHAcOH7YyeIFRQeZ1RBKJQpnpS+tW0x1fsaY9+xulGR0K
        lDUfWwTFWC+2PcTFqf1TtQbWLTQFq0bd1O2fzQjRt1bL3ymxdLhzLR3+Vkq2c
X-Received: by 2002:a17:903:230e:b0:194:d78a:fc80 with SMTP id d14-20020a170903230e00b00194d78afc80mr19523841plh.61.1674482327213;
        Mon, 23 Jan 2023 05:58:47 -0800 (PST)
X-Google-Smtp-Source: AMrXdXueXB596G9dMrW2bfPLFvM2H8cGg3B7CLBYWTUp6CFtuvdyXR9ZAbMJvwRhpi1SKBYN4frPzA==
X-Received: by 2002:a17:903:230e:b0:194:d78a:fc80 with SMTP id d14-20020a170903230e00b00194d78afc80mr19523827plh.61.1674482326956;
        Mon, 23 Jan 2023 05:58:46 -0800 (PST)
Received: from LAP568U.mistral.in ([106.51.227.150])
        by smtp.gmail.com with ESMTPSA id y3-20020a170902b48300b0019309be03e7sm474478plr.66.2023.01.23.05.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 05:58:46 -0800 (PST)
From:   Sinthu Raja <sinthu.raja@mistralsolutions.com>
X-Google-Original-From: Sinthu Raja <sinthu.raja@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sinthu Raja <sinthu.raja@ti.com>
Subject: [PATCH 1/2] arm64: dts: ti: k3-j721s2-mcu-wakeup: Fix IO PADCONFIG size for wakeup domain
Date:   Mon, 23 Jan 2023 19:28:30 +0530
Message-Id: <20230123135831.4184-2-sinthu.raja@ti.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230123135831.4184-1-sinthu.raja@ti.com>
References: <20230123135831.4184-1-sinthu.raja@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1674482327-305933-5381-10046-1
X-BESS-VER: 2019.1_20221214.2106
X-BESS-Apparent-Source-IP: 209.85.214.197
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.245654 [from 
        cloudscan23-149.eu-central-1b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_MISMATCH_TO
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sinthu Raja <sinthu.raja@ti.com>

I/O PADCONFIG size for wkup domain is incorrect for J721S2. Therefore,
update the PADCONFIG size to the correct value for J721S22 SoC.

Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
index 0af242aa9816..517f791932da 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
@@ -50,7 +50,7 @@ mcu_ram: sram@41c00000 {
 	wkup_pmx0: pinctrl@4301c000 {
 		compatible = "pinctrl-single";
 		/* Proxy 0 addressing */
-		reg = <0x00 0x4301c000 0x00 0x178>;
+		reg = <0x00 0x4301c000 0x00 0x190>;
 		#pinctrl-cells = <1>;
 		pinctrl-single,register-width = <32>;
 		pinctrl-single,function-mask = <0xffffffff>;
-- 
2.36.1

