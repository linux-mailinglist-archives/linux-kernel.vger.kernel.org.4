Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03CD772B98F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 10:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbjFLIBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 04:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbjFLIA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:00:57 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFD410E0;
        Mon, 12 Jun 2023 01:00:22 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f63006b4e3so4657799e87.1;
        Mon, 12 Jun 2023 01:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686556819; x=1689148819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AIVXF0NWT+mxXgpNldoq9Ep8Ze5GWaI0IQCYTwDNGis=;
        b=DnTvzYh/fYzUzxkqBzhHKbj25ROthxEX6h0AV5AOLpd7J9tvQU+utodDahOTLwOZCu
         ZKBjB3YfRca0QVG3aSHP/IrXGjnrQC8Us5Cnb+AXXV9Hib5rANQWeyEcU/NpvW8RRz9n
         WrlqW5aaOwqtffCtPqA1Qb9OAtYLlfiSBzVbCshpTprHWhM2D2ZBvcqZ1nSrh+75J0H8
         AuY+EVYKLSE9xJettCoideYcrrVkEfYQYElcVug8a6Cpdg1ukp4XDV0TXbW822w/LsJA
         KfXZLnBmCQoXiNZViYYZnkwJoebGw+C6tNgGdFzHFsxXDk7hwbXmlUhS7xiP++lJ3p86
         0sTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686556819; x=1689148819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AIVXF0NWT+mxXgpNldoq9Ep8Ze5GWaI0IQCYTwDNGis=;
        b=P/ZFjL9AXtvq1//CP9ekW6hFPnoP7XsYpXX73wRnGXECDVUegE7UjyRUo6b0gawXII
         WLqwBJG+uvkunuV2iIuZIf237A+yTTSTcOq3xlAVCQJJumdtJQF5kJn62WxHRvCa4+Ug
         kBbSNcacYTNomsed4ZrJP0OoR1bX8+DovtcsE2Me9aFqM2g68AlQC52eKLt+iFQ8x7PZ
         SdVc7QQGHTREYnVT2AS2bPh5wVG2ZnsxfpB5A3/96danG69rHyGCEZUUNS/niJ5Df7/q
         GMXYhFgS3NeFVQfO9GgYeRwZ/YXSRHBYpzXYLosyZt3MeP3+tOHninb21osKd/EA5VUF
         X4pQ==
X-Gm-Message-State: AC+VfDwL2zPmwmc9ZarbFl985foevy8ed4uM8dum5mdPG9uFg0G+10DM
        8JPZEOMg9ype0hu9RQO5yGE=
X-Google-Smtp-Source: ACHHUZ7rH24bSvXH68grWUUGmZeBJyddzDfqq2bN6iaVfLMn/bSdgzwUU/lcR0jP8SVBmxzLrMFDsg==
X-Received: by 2002:a19:6d08:0:b0:4f6:3000:4d4d with SMTP id i8-20020a196d08000000b004f630004d4dmr3267707lfc.38.1686556818709;
        Mon, 12 Jun 2023 01:00:18 -0700 (PDT)
Received: from arinc9-Xeront.lan (178-147-169-233.haap.dm.cosmote.net. [178.147.169.233])
        by smtp.gmail.com with ESMTPSA id y22-20020a7bcd96000000b003f7f2a1484csm10552195wmj.5.2023.06.12.01.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 01:00:18 -0700 (PDT)
From:   arinc9.unal@gmail.com
X-Google-Original-From: arinc.unal@arinc9.com
To:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     Landen Chao <landen.chao@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Bartel Eerdekens <bartel.eerdekens@constell8.be>,
        mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH net v4 7/7] MAINTAINERS: add me as maintainer of MEDIATEK SWITCH DRIVER
Date:   Mon, 12 Jun 2023 10:59:45 +0300
Message-Id: <20230612075945.16330-8-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230612075945.16330-1-arinc.unal@arinc9.com>
References: <20230612075945.16330-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arınç ÜNAL <arinc.unal@arinc9.com>

Add me as a maintainer of the MediaTek MT7530 DSA subdriver.

List maintainers in alphabetical order by first name.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
---
 MAINTAINERS | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a73e5a98503a..c58d7fbb40ed 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13259,10 +13259,11 @@ F:	drivers/memory/mtk-smi.c
 F:	include/soc/mediatek/smi.h
 
 MEDIATEK SWITCH DRIVER
-M:	Sean Wang <sean.wang@mediatek.com>
+M:	Arınç ÜNAL <arinc.unal@arinc9.com>
+M:	Daniel Golle <daniel@makrotopia.org>
 M:	Landen Chao <Landen.Chao@mediatek.com>
 M:	DENG Qingfang <dqfext@gmail.com>
-M:	Daniel Golle <daniel@makrotopia.org>
+M:	Sean Wang <sean.wang@mediatek.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/dsa/mt7530-mdio.c
-- 
2.39.2

