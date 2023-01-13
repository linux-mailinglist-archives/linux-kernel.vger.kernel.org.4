Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17981669103
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 09:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbjAMIb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 03:31:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234479AbjAMIbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 03:31:24 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD172559E0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 00:31:23 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso26353046pjt.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 00:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cIstlIhP9pl3goBvQueMqsqc9cYboCHYREaZayJsVqk=;
        b=VxkzPvdFgcDm1yhAVvF640GkpkEldw2iJ2plMjabFbxP/U2ml+k2FrHjB0c9vNhm9r
         b1ChL2D6l8uVud094zZmrky/pN6MrUtexVryIoLYRkUdX6PgJBxufcsJzOlXrtMtYUdG
         q7IR2lpZd0OLFR46EOsxwv0UxQ6wGSnQhUUZi1ZA3/mEO7onNLpI/FfhT7x3f2Xmsza+
         wkhCSxYbn0mAyZzaOOcHVSooIj51FH1QLpUnklX10mq/Dr9CRdWmyvC4yrbOA2mgPvRG
         F/rhfy9N/kQxKQDFhhLTqTa5mVC53drVDMFusknIexal5ErMvTgnBzlg/MmnL6tJHLRy
         NlwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cIstlIhP9pl3goBvQueMqsqc9cYboCHYREaZayJsVqk=;
        b=ulyMTcs3jL33gHjyjiJUH17zuStJignO0qMSNwMq0TJNoUKZ9TW6yHe1fuNfYWBtvk
         +DQjAEmSKnbcpTZKepCLzuqnSJGdrmiQR9UaW5cq56fOYlHQYAWjSNv+RZ6mD55wDgOT
         paKqxkWe18ClpjJR8+ULISp4KOHj9LKo8kep/GWL3xtKBISAdQmUn9cbPtDE1ge9s7cI
         NUjKmqYF08Otru8u2mdcMq780Dw549VCh8IkGtLVelHER0zy2m32RRoBXeVJiGR9XXG7
         LaJ4BFBejNx8vPUMXN4nVKeixmPdx8DVEeUDeZTCxLprpU4HoHaqAFrCShqN1yHtzPMY
         vMyA==
X-Gm-Message-State: AFqh2krPW3boa7kdLqwpTEWikq8vLhcPo6qtlp6PQBLc42MUQ3FPJc8E
        Yx/HrY4Zbfnjk5Q+OsgYp31Lyw==
X-Google-Smtp-Source: AMrXdXtiMdLCb6FbPHWbu4MyygTsweBV7FsXTLoXbv682Z3U55psFNKQ/EyatQWxw1DVR/JXzi5TmA==
X-Received: by 2002:a17:902:ef4d:b0:194:65fa:c354 with SMTP id e13-20020a170902ef4d00b0019465fac354mr4402952plx.20.1673598683253;
        Fri, 13 Jan 2023 00:31:23 -0800 (PST)
Received: from hsinchu15.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id s7-20020a170902988700b0017f73caf588sm13466123plp.218.2023.01.13.00.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 00:31:22 -0800 (PST)
From:   Nylon Chen <nylon.chen@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     nylon7717@gmail.com, zong.li@sifive.com, greentime.hu@sifive.com,
        vincent.chen@sifive.com, Nylon Chen <nylon.chen@sifive.com>
Subject: [PATCH 1/2] riscv: dts: sifive unmatched: Remove PWM controlled LED's active-low properties
Date:   Fri, 13 Jan 2023 16:31:14 +0800
Message-Id: <20230113083115.2590-2-nylon.chen@sifive.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230113083115.2590-1-nylon.chen@sifive.com>
References: <20230113083115.2590-1-nylon.chen@sifive.com>
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

This removes the active-low properties of the PWM-controlled LEDs in
the HiFive Unmatched device tree.

Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
Reviewed-by: Vincent Chen <vincent.chen@sifive.com>
---
 arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
index 07387f9c135c..11f08a545ee6 100644
--- a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
+++ b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
@@ -52,7 +52,6 @@ led-controller-1 {
 
 		led-d12 {
 			pwms = <&pwm0 0 7812500 PWM_POLARITY_INVERTED>;
-			active-low;
 			color = <LED_COLOR_ID_GREEN>;
 			max-brightness = <255>;
 			label = "d12";
@@ -69,19 +68,16 @@ multi-led {
 
 			led-red {
 				pwms = <&pwm0 2 7812500 PWM_POLARITY_INVERTED>;
-				active-low;
 				color = <LED_COLOR_ID_RED>;
 			};
 
 			led-green {
 				pwms = <&pwm0 1 7812500 PWM_POLARITY_INVERTED>;
-				active-low;
 				color = <LED_COLOR_ID_GREEN>;
 			};
 
 			led-blue {
 				pwms = <&pwm0 3 7812500 PWM_POLARITY_INVERTED>;
-				active-low;
 				color = <LED_COLOR_ID_BLUE>;
 			};
 		};
-- 
2.36.1

