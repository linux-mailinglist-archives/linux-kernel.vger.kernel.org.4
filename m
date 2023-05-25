Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 356D5710794
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 10:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240226AbjEYIeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 04:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240063AbjEYIeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 04:34:37 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B465E4A
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 01:34:01 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f6e13940daso201105e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 01:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1685003637; x=1687595637;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tDMAZYC6PlfAvsYSrf+M4iyNDJFAF/AM883C7PrISNc=;
        b=ZCGAbdgXCXYDsCVFtmnECOBT5WP2ADILUz9yT/5vEyRqykdrS5zfQQLcLie703Q2vw
         sxlmQh+trkLZBjESDlmT6/A77gjMjNP3+XAYCr1xrSa90A1Cut4KeNY+R+0/nHQ2BxIH
         gmvtnKBwS1nwSS8kPyvoK/V6a9PzwwmMT5EURpa9a12lbxp9jKqDeuWfmC6E7zjA61TB
         ukKYVsf/xZI60BZ57xAANm37s2jgmCUV/0ZPst+LBVtnyPeYCoY0FReF8bp/bgwqvU5g
         ouh6ccna/givG4NbwIhXaw4xjab98Fx+/IKMinEazT8WDFr6fR5hT9foXlzUem/Ppzyy
         sXTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685003637; x=1687595637;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tDMAZYC6PlfAvsYSrf+M4iyNDJFAF/AM883C7PrISNc=;
        b=l0N3Lxg+S+hyOYVD3QeApPv752qJQdH9zVCzrs0Aqfz9o/gIPF2IJVx4O6ugEjnsy+
         gSSDhQCx3d/fYHuU2NCwpx3/eDlm/E2/BjukofqDfNMQzC63G+aZRO60QVF4Dlbe4WcM
         WmvrtmcsyFIhkbKvw5toXA9Omw8qsCXRDnI+spmIARFZ8xU/mSdMKoSkah3mGU4UWjy1
         HNFmE5T6UmcfI/XCpa0bzDMIzHFZ4eT9WjdXoO+aPZHNx9+ikdYdpHs9DUEbFKVMN+4r
         5rR4tkCgp/3iiNIfa0w+jUQOzWCtgjC4xUXHEEEHQ/wpJmEfFA06RW1y5UKrdIpiJKk0
         Vg9A==
X-Gm-Message-State: AC+VfDxEGloTVjNANy8vsvY0SiBfB4B/3CDVy7+rru4LO0qW3VARKxcS
        lRMEWVehqgSnlJ1tWdc2Dxd6HYkskp42YgHbQRA=
X-Google-Smtp-Source: ACHHUZ6NcwZ+FPVEwSPwGU4TT6xlYG7ghCbQwCjTXicvKcWpYEiHaPck+e+02FRlIex3qeCUIJsmCA==
X-Received: by 2002:adf:ec4d:0:b0:306:2db9:cc2c with SMTP id w13-20020adfec4d000000b003062db9cc2cmr1885209wrn.32.1685003636901;
        Thu, 25 May 2023 01:33:56 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id o3-20020a5d6843000000b003095a329e90sm945809wrw.97.2023.05.25.01.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 01:33:56 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Thu, 25 May 2023 10:33:12 +0200
Subject: [PATCH v8 03/10] arm64: dts: mediatek: add watchdog support for
 mt8365 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230203-evk-board-support-v8-3-7019f3fd0adf@baylibre.com>
References: <20230203-evk-board-support-v8-0-7019f3fd0adf@baylibre.com>
In-Reply-To: <20230203-evk-board-support-v8-0-7019f3fd0adf@baylibre.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=940; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=9yZG6Lt2sYetnfjl+HHfU8vcDGstMCEZ7QfVbikE4Lw=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkbx1vNSdMsmnHxJfKXxkhkVDFUZdZstbXniZEAhSF
 PqyPPteJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZG8dbwAKCRArRkmdfjHURSHoD/
 4gN0l5X5LvAdG3O8LVaxW4hbi6wkoRPqNGSZNxWA2LNDNhvLypC84tflW1dqzYi6cHZE9e1QQGNYyp
 S81tq0Ya/Lz/+UEwmabof0XIRJqjp2XLGJC3keI7Lj+OycSXr/jz04/fB38VuxxNagstaArMzgOZUK
 Eq7n5Q4TVJsuL6Kmd4MvEC+8hrJP8T8p3nwMQa4cjtgYKlm84GdPto7kbE/2hrw1KQPtiuFLDyEDv8
 VGaTENuxs+foz8mAgrQ6KPpbrmke0GcwdALY5OTISsEM0xngrDB6aiZRcDuN1Q/EdAslMzQnZlwB0X
 ZNfoP/P0RzNU2hPiQNwcBgD/JH2+sbXd19/Acgqp2n0zJ+3uqtHO0lmpnkOsfuygMV0QER3cZDV8B4
 tdTOK6Chkuq1msbkdFQ+QF/hx2W+YduaCAEIjJ12Pt8XSlKyHl1/y6JBfnDFOZXiwm91Nie3mRGjhr
 Jcme7xRHxCDVO3Syhy6x7thJKZALDyqsxjggnNz+GtAsEvRSkpcXRSOwyOjZ5MYG7WT0HWu6S41PAG
 /TdD/ua3MvaZv0QkDp2yo1tA0ZxLIc6pfMOYFMZUeu4P01e4NTmHhdHEV/S+M1oM9FYVGh+93pA394
 v3muDrQ6mAXOfV3iHGsfql4i+ddMZja91BEwAYbyS8hqwQJ5I6gHaFf26E0g==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add watchdog support.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
index 1f6b48359115..bb45aab2e6a9 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
@@ -162,6 +162,12 @@ syscfg_pctl: syscfg-pctl@10005000 {
 			reg = <0 0x10005000 0 0x1000>;
 		};
 
+		watchdog: watchdog@10007000 {
+			compatible = "mediatek,mt8365-wdt", "mediatek,mt6589-wdt";
+			reg = <0 0x10007000 0 0x100>;
+			#reset-cells = <1>;
+		};
+
 		pio: pinctrl@1000b000 {
 			compatible = "mediatek,mt8365-pinctrl";
 			reg = <0 0x1000b000 0 0x1000>;

-- 
2.25.1

