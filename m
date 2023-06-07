Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056A072598E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 11:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239647AbjFGJI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 05:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239322AbjFGJHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 05:07:49 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF1126B9
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 02:07:07 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6b29c972e00so946967a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 02:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686128826; x=1688720826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1oMUOQweNkFHrLBYGCRkYWKHPdRqVZlt9YUEgkC1xGo=;
        b=YzqZuJikN44AANBQIeQ24Hb3eDg0RnpxZA4TvXJJ3RzBfTYK6A+PmLH0jhuLpe0ktZ
         x43yz46wMbqMdNlPqd6hfhCbBphIlT1+Vk/gAtT9cdkjnjcmrbmPv0DDFFyW7UZlObUR
         BAds9fl8sjNg9eA6uuzo4Fm+coqH38JBWnlzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686128826; x=1688720826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1oMUOQweNkFHrLBYGCRkYWKHPdRqVZlt9YUEgkC1xGo=;
        b=cOtN5mO9H/FikBQ688d2LYNyzpXd70s2ExhyrhISBdg1lbNZcQ1d2xlH9p3spYGjo2
         b7FhnOq9PgT9tHJGQBdfEZv3PJXI7Aa5TNqduIFdc7M+NEfwvHyIKl6esye/pJyZx4he
         uu6WKeJ+Ur7sbvP0CD7WA3wUHyeb3kj9LgmM/zUrx+YdBGWAzWuML9XHE91Wq6hUvnuk
         fG25CYmPP9CEoXEU+Adf0S5y0qKRhnkrZTVM5CwaSZrquA2XqXpUoYQ3QoZGrDvm9tqQ
         ZfzyAtNaZYVzZFZHy4RNKs6diX5KXqMvAaZQ/pz85c20Vf0X8CFwyYHTtDTVdIFQMyg3
         d5AA==
X-Gm-Message-State: AC+VfDxgXvuVfotu0vrk9iTsDBElEBt+buAHW1gntdnssP/tL49qfxyX
        OJkG6fknZN/IzaTu8v9QPWmdPA==
X-Google-Smtp-Source: ACHHUZ5ibECzd/kZUl2bbXqDpahU54iioKVNky/2QpxDRw4sHqajO7VAsic8EWY+GLNDHBLHKRubEg==
X-Received: by 2002:aca:240a:0:b0:39b:f558:8cbf with SMTP id n10-20020aca240a000000b0039bf5588cbfmr4422662oic.12.1686128826597;
        Wed, 07 Jun 2023 02:07:06 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:443b:29bb:b677:185d])
        by smtp.gmail.com with ESMTPSA id b38-20020a631b66000000b0051eff0a70d7sm8505732pgm.94.2023.06.07.02.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 02:07:06 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH 3/4] arm64: dts: mediatek: mt8186: Add GPU speed bin NVMEM cells
Date:   Wed,  7 Jun 2023 17:06:51 +0800
Message-ID: <20230607090653.2468317-4-wenst@chromium.org>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
In-Reply-To: <20230607090653.2468317-1-wenst@chromium.org>
References: <20230607090653.2468317-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the MT8186, the chip is binned for different GPU voltages at the
highest OPPs. The binning value is stored in the efuse.

Add the NVMEM cell, and tie it to the GPU.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
index 6735c1feb26d..c58d7eb87b1d 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
@@ -1567,6 +1567,11 @@ efuse: efuse@11cb0000 {
 			reg = <0 0x11cb0000 0 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
+
+			gpu_speedbin: gpu-speed-bin@59c {
+				reg = <0x59c 0x4>;
+				bits = <0 3>;
+			};
 		};
 
 		mipi_tx0: dsi-phy@11cc0000 {
@@ -1599,6 +1604,8 @@ gpu: gpu@13040000 {
 					<&spm MT8186_POWER_DOMAIN_MFG3>;
 			power-domain-names = "core0", "core1";
 			#cooling-cells = <2>;
+			nvmem-cells = <&gpu_speedbin>;
+			nvmem-cell-names = "speed-bin";
 			status = "disabled";
 		};
 
-- 
2.41.0.rc0.172.g3f132b7071-goog

