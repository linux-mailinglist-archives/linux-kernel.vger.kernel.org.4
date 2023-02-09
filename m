Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131746905D1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 11:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjBIK4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 05:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjBIK4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 05:56:38 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017D7457EC
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 02:56:37 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id bg5-20020a05600c3c8500b003e00c739ce4so1178969wmb.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 02:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8K5BTAdm/41pw2lI++GgH00C0SE0jCet8VtGW2Mqre8=;
        b=Zef6VMLJZcfIVwCEekVCGv46hyyCGghuKPKSuvfPuQIezDx0/rQw54pw8u2yiN+WYp
         TTf1AUz/4bTwe8hSJwa8Ima0TJ5CCAMKpQhfOyM48yqlU2u++7JCly8TWrbhbyYy+4kB
         bzftMcStydIOzoGjZu+WwOpzU3PgoUXfa7A8jbqqBZTyMqyDxQSfLn5FRNdbphnaGTQG
         zd82cxmc8KGuzaYxru54ywSbpldfm56Jc9bsRYSFG8CZcIq9MdJldOc5riEqVF0rlZU7
         cwdPkYA3myNUisWVWPJW1AUcZONHlBxuBG6VDYAnyEmyZkUKXtyV9iiILoT4V68NankR
         9hmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8K5BTAdm/41pw2lI++GgH00C0SE0jCet8VtGW2Mqre8=;
        b=mZbkyxhzVb/xq1UsxmHtsi4v4oqoglroISuEq7j0M1nnhsD/HJwHBVJReGpM1OecNY
         3RqYB/qkk9ep22VCz6Oc+KEWuN+UXDKpMLf/5wiKLjL+k+Xlx3KsgjRsvdeNai3gBZoW
         hLTh2yQKP3FcJZ6Xljox1H4A4HYOLft/ibTm2pnBlfLKlXjUfRx06QGpi9yiOT5HOs5C
         4w2nCdwOeaX20KFDKBghLYwyovTrl8JIKvl203GdeC/DcnvL9QLh0L6LNEJshIxDhhF5
         7INBhVlEJr2AnLvaG45Vxi/57AwFemNZMbEMrE1oOnZ4vxZZqQg0Mxhhemib74s4u1IZ
         umLw==
X-Gm-Message-State: AO0yUKWFoPvmnTauhIZJL1Nlh2RWJx0RQV/jUX7gPP6XH2/N2TP9UKVI
        gnjCzXQg1B4MtuYZbu9ld8i9WQ==
X-Google-Smtp-Source: AK7set8J2kRY8jrOhNBF+a/ygnyy2766CJqX11hnvdRms+/MtEyECj/QlPAhN6+Rqaf0oo8W9j5OmQ==
X-Received: by 2002:a05:600c:3198:b0:3e1:12d1:fde0 with SMTP id s24-20020a05600c319800b003e112d1fde0mr2357401wmp.6.1675940195567;
        Thu, 09 Feb 2023 02:56:35 -0800 (PST)
Received: from t480-bl003.. (185.173.185.81.rev.sfr.net. [81.185.173.185])
        by smtp.gmail.com with ESMTPSA id j37-20020a05600c1c2500b003daf6e3bc2fsm9140466wms.1.2023.02.09.02.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 02:56:35 -0800 (PST)
From:   bchihi@baylibre.com
To:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
Subject: [PATCH v14 3/6] arm64: dts: mt8195: Add efuse node to mt8195
Date:   Thu,  9 Feb 2023 11:56:25 +0100
Message-Id: <20230209105628.50294-4-bchihi@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230209105628.50294-1-bchihi@baylibre.com>
References: <20230209105628.50294-1-bchihi@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Balsam CHIHI <bchihi@baylibre.com>

Add efuse node.
This will be required by the thermal driver to get the calibration data.

Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://lore.kernel.org/r/20230124131717.128660-4-bchihi@baylibre.com
Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 5d31536f4c486..09df105f4606d 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -1380,6 +1380,12 @@ pciephy_glb_intr: pciephy-glb-intr@193 {
 			dp_calibration: dp-data@1ac {
 				reg = <0x1ac 0x10>;
 			};
+			lvts_efuse_data1: lvts1-calib@1bc {
+				reg = <0x1bc 0x14>;
+			};
+			lvts_efuse_data2: lvts2-calib@1d0 {
+				reg = <0x1d0 0x38>;
+			};
 		};
 
 		u3phy2: t-phy@11c40000 {
-- 
2.34.1

