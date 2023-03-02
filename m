Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46EF36A8235
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 13:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjCBMbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 07:31:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjCBMbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 07:31:09 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76FCB472;
        Thu,  2 Mar 2023 04:31:08 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id h9so17443471ljq.2;
        Thu, 02 Mar 2023 04:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vxbzQRxlotF35HoO9qsC+Ig1zQBN/8fFR5R4WuxGdUM=;
        b=LODNGYMJMr5hFdfGCMLk+B+UpONdrwVrqeGQ3sd88plafK5rC+h/UMZyxrIfX/SutQ
         ySM7ASiOms/H/5GKMZpgftIOnwLo1DeDbdd3Zm/b/psDk+d82OBg2vMnwpKBg8zEsiYl
         NH9i/NIuPetDXrXf2xjl6lbF/DtlN3z7pBShvcDZFheHBvgE15qrESIgwTJOgRG89eov
         MbgJmopuNJweo22nFkf7g1qIflQxdfrD3l10u19Eq5/k7jxC3iYE6jfuuefoK7eWzFwt
         uqRTJvxuqllgIkk8om2qL1kfY45OL5WO8FNjBi+C8A4blHAb3fT9Ojb4K7ah2lwgOQP7
         2lzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vxbzQRxlotF35HoO9qsC+Ig1zQBN/8fFR5R4WuxGdUM=;
        b=nWWHwFu5tZffXz5mdlc8s4qbJDLlcWGBrhCSxdeYe9P0My9Ju5c8mb/ekX0wfIvbfs
         JqetA/+il6Od8q8eue46mpZEbc3Xc2L9zB4xbl1RzFXk1GtnJiSAwXn17HUtApbx+1j1
         fy5rSbmmkGcemNdPz4eYyvZn64FtQBE51kZ5GSsoCWdW9WMont009uu9nzYLxVV1fMXH
         bFM7hXJMixrXw7Ht2jf83l1cszkFDbGnDrbBhAKIXDXZzwfJMGgOyhooL00perzK6W62
         ArtjWB7S9kRoeRtBitQ+uWEGIxUZvTAR8VPjS0jp4Cn7bg9lfLZEc68aK1QPV6FdHIv4
         jNYA==
X-Gm-Message-State: AO0yUKX4WljMiXYUq1Cu2T6G1TuSWr825OQlhi+o0hdbG0/PVYnjmSAQ
        QlPitnT4bpuVHHc5sPkbplzv35qtclmupw==
X-Google-Smtp-Source: AK7set8jcER6SpXOZo/GQqUQ5hRHhuPJnv6nMCus0v3GNBgDpeS8J3kTMRybpjGx7JNb7qwRDtC+XQ==
X-Received: by 2002:a05:651c:1691:b0:293:2cc5:47a7 with SMTP id bd17-20020a05651c169100b002932cc547a7mr2813216ljb.52.1677760267178;
        Thu, 02 Mar 2023 04:31:07 -0800 (PST)
Received: from localhost.localdomain (ccv22.neoplus.adsl.tpnet.pl. [83.30.145.22])
        by smtp.gmail.com with ESMTPSA id o15-20020a2eb44f000000b002934fe524d2sm2068942ljm.83.2023.03.02.04.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 04:31:06 -0800 (PST)
From:   Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: qcom: msm8956-loire: Provide rate for xo_board clock
Date:   Thu,  2 Mar 2023 13:30:50 +0100
Message-Id: <20230302123051.12440-2-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230302123051.12440-1-a39.skl@gmail.com>
References: <20230302123051.12440-1-a39.skl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As xo_board is part of board not soc we define rates per device tree,
assign common 19.2Mhz rate to make consumers happy.

Fixes: ff7f6d34ca07 ("arm64: dts: qcom: Add support for SONY Xperia X/X Compact")
Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire.dtsi b/arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire.dtsi
index 67baced639c9..085d79542e1b 100644
--- a/arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire.dtsi
@@ -280,3 +280,7 @@ &usb_hs_phy {
 	vdda3p3-supply = <&pm8950_l13>;
 	status = "okay";
 };
+
+&xo_board {
+	clock-frequency = <19200000>;
+};
-- 
2.25.1

