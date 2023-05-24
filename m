Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389CE70F0B9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 10:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239917AbjEXIax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 04:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239474AbjEXIau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 04:30:50 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C814512B
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 01:30:48 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f6147227a7so2461085e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 01:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1684917047; x=1687509047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFkeXmTsUMY8GSw8DO1YxsHt1wzgz+ONEfDUI+8GUAE=;
        b=Ky164TgIAjXoNCRewjAvpvhOJ4Fq2aqesYTLjaP4MsCdZWaK7nNI1q4ACUHyf0yARP
         khE4z1B4Wq3htHoGGiNu+1mMFFRKUkdv/98piGwOHRcsYTzoseEHnt4dQ+gSAMSTXTSb
         1j75EhptJA+nEMLiybke6sENFCRCPbdkvcEZISCZtt8Ps/JPEsyGSZrxNu9oMC0r5Ecz
         9O72t84s/Ms51QhGIloJa0e3TS2IsckqzZwn1CpJz4yOfg0/yCZbJbjr8Q0u71l0fRdV
         HudbAm0rHClx0bTFzAbc85WUmKaoTxiHzJUYrkQYS5aT4NIx1ofDL7RZIuX5kDA6y4nB
         IbMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684917047; x=1687509047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GFkeXmTsUMY8GSw8DO1YxsHt1wzgz+ONEfDUI+8GUAE=;
        b=RuScWkbsYD1rrwQjb0yjZvbatlBz7tShlboO3N8D5e2Jv13E15hU2SyTlQ1hAGagI9
         uOTSjHLip/iv14hE7RQR/LrKf6grQlZXhsg5FgjK17plMPtmQLQ3Ea/et6sUnBw8+aK5
         PP3QcB9WBfelongkqaygpvRiXSLA8xkeJltk1c0F0tRf/dYKhNIFcYdGhFhsmrAj4tSp
         WutPpxNeqGZqcrzuiYyUltxMXkcitamgPQ+dVTyVLF1xdMv83SvFrkPVnMGpB78M5HWv
         BkSACOJYf8A9uipnj5PrWUD+PNxIaL8zwtQNsY3dN+qThh5i89ESuMn5CL2H5mjl9VFc
         h30Q==
X-Gm-Message-State: AC+VfDxSFqnI/hA/2PVWhbAzZlTwNi/Ilvd4N/kMbAbnSXKjefb2jg9z
        98ydp3mspSAaIy+Qr9EUTrIzkg==
X-Google-Smtp-Source: ACHHUZ6JqNOn6TctkUQ6E/Zh8dcU2trBSmopBqGdD7CTtYD4boZi1njHtt373XgOG0bq+Mr+DhVFKQ==
X-Received: by 2002:adf:f80d:0:b0:306:4613:e0f0 with SMTP id s13-20020adff80d000000b003064613e0f0mr11012487wrp.68.1684917047325;
        Wed, 24 May 2023 01:30:47 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:55f:21e0:9e19:4376:dea6:dbfa])
        by smtp.gmail.com with ESMTPSA id n11-20020a5d484b000000b00307c0afc030sm13871832wrs.4.2023.05.24.01.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 01:30:46 -0700 (PDT)
From:   Julien Stephan <jstephan@baylibre.com>
Cc:     mkorpershoek@baylibre.com, khilman@baylibre.com,
        Julien Stephan <jstephan@baylibre.com>,
        Andy Hsieh <andy.hsieh@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v3 1/3] dt-bindings: phy: add PHY_TYPE_CDPHY definition
Date:   Wed, 24 May 2023 10:30:30 +0200
Message-Id: <20230524083033.486490-2-jstephan@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230524083033.486490-1-jstephan@baylibre.com>
References: <20230524083033.486490-1-jstephan@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add definition for CDPHY phy type that can be configured in either D-PHY
mode or C-PHY mode

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 include/dt-bindings/phy/phy.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/phy/phy.h b/include/dt-bindings/phy/phy.h
index 6b901b342348..a19d85dbbf16 100644
--- a/include/dt-bindings/phy/phy.h
+++ b/include/dt-bindings/phy/phy.h
@@ -23,5 +23,6 @@
 #define PHY_TYPE_DPHY		10
 #define PHY_TYPE_CPHY		11
 #define PHY_TYPE_USXGMII	12
+#define PHY_TYPE_CDPHY		13
 
 #endif /* _DT_BINDINGS_PHY */
-- 
2.40.1

