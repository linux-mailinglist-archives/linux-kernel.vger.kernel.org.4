Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9259667A12D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 19:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbjAXSdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 13:33:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233062AbjAXSdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 13:33:09 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380F817161
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 10:33:07 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id z13so15591067plg.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 10:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:author:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UsWJpCZ2MiktbEP0bUIDKCE2SHIVUBqnn1o3x0TI6io=;
        b=YdDsRg3YLjc2/9zOKTNbV5dW2fAzUhZvv6N+sLI9WR5porWWWVLGOEESxfGtJsv1YD
         HaPdnonpHJoF0mAOOMa37SYLyxHngir9M3NRQUyUTrS6/p62LBXn4Sz9s5kwj2Wn/riK
         R4bv7Eov+1LdOHJD2Dk91oVBGILUFR+00vVuGfo4Z2VQHFRCkexBf1zUVHuJSOqeQ5Ls
         wVs7S8RB7VyqkuJ5qNOxP1F0jjKmYLqRe2vW1gEWU8YX9mhl3oWHcWTE1Z0CkaAfuP4b
         HaRrPVY/puZJZIm08vTO3rGM4ksLeJOaprTeNfhuBgU+NbEs6tdye9YVNAvhE4Ctdtwb
         Sl8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:author:mime-version:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UsWJpCZ2MiktbEP0bUIDKCE2SHIVUBqnn1o3x0TI6io=;
        b=cZaV0ZmxePAwv51EuN2zqEof6LG4hUH9Gc9njYywM6Ll7uBqmzgih/xjmFyUlb8raF
         5KAfWy9l28EDPX4IkWmzSBYTfkCPX7GGC8ccJpkb74fBspQrQ9FPHHMxUh8sg9h6/CA/
         cTAiioi+FQy/HrPnM6P5WyaLhwkILfAs4NFjeZh4NB4tPEdto7cxaJG/sDVMC+qcgrja
         5yhg58MWZdfmEAyXPky9iE9SpM0YMIYw4X546mW+ktO+OY++/3dCA1vT0auH79wc99WJ
         WavTDxfPJixdguy7D9mKbq9P6VXs61VtVW/o5+oAFWAHLZSZkI/Mo9bpEmtdi9P9hZAz
         PPVw==
X-Gm-Message-State: AFqh2koqBM36NADWHYaf18c/Hd/2VVR7lQfb21IaIMrXSCDsbbGNigAc
        WWgG6WYs/Z0gwVad4ZwyZ7jNPw==
X-Google-Smtp-Source: AMrXdXuriSuX4HGqunHblAH+Z5NPF9OltDIuJkqmRr3gtJB9j7vPP67/BJL9BAlupctMwtOKvTuCJQ==
X-Received: by 2002:a17:903:2306:b0:193:3540:c54d with SMTP id d6-20020a170903230600b001933540c54dmr39612857plh.26.1674585186710;
        Tue, 24 Jan 2023 10:33:06 -0800 (PST)
Received: from localhost.localdomain ([122.171.17.192])
        by smtp.gmail.com with ESMTPSA id x7-20020a170902ec8700b001943d58268csm1997229plg.55.2023.01.24.10.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 10:33:06 -0800 (PST)
From:   Amit Pundir <amit.pundir@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Joel Selvaraj <joelselvaraj.oss@gmail.com>
Cc:     linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dt <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        phone-devel <phone-devel@vger.kernel.org>
Subject: [PATCH] arm64: dts: qcom: sdm845-xiaomi-beryllium-tianma: Add reserved memory region
Date:   Wed, 25 Jan 2023 00:02:57 +0530
Message-Id: <20230124183257.1525376-1-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Author: Amit Pundir <amit.pundir@linaro.org>
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Put cont splash memory region under the reserved-memory as
confirmed by the downstream code for Tianma variant as well.

Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
---
This change should probably go in sdm845-xiaomi-beryllium-common but
I don't have EBBG variant's downstream code nor the device to test.

 .../boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dts      | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dts
index 8e176111e599..47cbf725b0e3 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dts
@@ -7,6 +7,14 @@
 / {
 	model = "Xiaomi Pocophone F1 (Tianma)";
 	compatible = "xiaomi,beryllium", "qcom,sdm845";
+
+	reserved-memory {
+		/* Cont splash region set up by the bootloader */
+		cont_splash_mem: framebuffer@9d400000 {
+			reg = <0x0 0x9d400000 0x0 0x2400000>;
+			no-map;
+		};
+	};
 };
 
 &display_panel {
-- 
2.25.1

