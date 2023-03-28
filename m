Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6B56CB3C5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 04:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbjC1CTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 22:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbjC1CT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 22:19:29 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D4B2736;
        Mon, 27 Mar 2023 19:19:26 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id om3-20020a17090b3a8300b0023efab0e3bfso13724161pjb.3;
        Mon, 27 Mar 2023 19:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679969966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CaSv0fqLKCElmpWFPdMbQfJoPfoV6HUW2XrOse+W9mw=;
        b=dZefeMxtwXiPA+uVGntQkHb5kQ5RvKohl3FkllwFiBehryzS/ywPXlplhTOaVz8D44
         4RRnIXm0SVaJ/CfN+GCx8TnkElLDPRSGCOOTBd/1s8edMs/RzB3W4A++03yPZKVJEWxB
         1Kloimvlua9SIGbrHh/+rERyq+sH5/tFfGAYYuZLQBItUaNPI6qA0TxSaGjfXtLYMoO0
         04q3Tnq+0cnXy3eK3B5sos1HrdNhapzxfOelfEe3hE74WmAP0SoaAXZiYS+aJJ7Run2X
         x+RTviBksxvi7YgWGbgw4W4jScG47xXhFuSKcaZPLWXI9D7Jk+ELqZoNVo4mLFW0ckpd
         QmKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679969966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CaSv0fqLKCElmpWFPdMbQfJoPfoV6HUW2XrOse+W9mw=;
        b=Qp6t/TpcQyK91avqTl+F5EIgjGjGIGWSlzhdQs1G3VaaeBAmxjnd3yzNUxPYsy6afR
         x25bDOxnTqa1wlYTUgWlk/mOpLwK3BnO8wUu5DixMI5soCOMTfbWZjqHOsPBhRYQIxCf
         MIl5klWZ1RpmvDuw0xCiATKaikLy7d8Wk+k8WZBofZKbi11mr6wOnWAZRohkSulKyfrU
         C6/R0SnBQ9pnlTEC+O/duc67jE91EddtW8gXHLfPE6TcJlTIWYLkAhhMKX1qX966fshe
         z+HYvs2dR2p2xmbJBDu2Bvd85WUa9yAxIV7NzjISAsevGcTL8cEz9wx6ulJKBqIyiJIA
         bjAA==
X-Gm-Message-State: AAQBX9e9QJvRxZbWvW0p6PjQKum2/rNIjmxXvrUzllC51wt1/wbwAgEM
        4d2cEnmwsRYRJXdfiHHu9no=
X-Google-Smtp-Source: AKy350ZZyf1nEh9VkNgaBZVXfsQcFR+H0vcOCtB3IuysSh6TfYnrWyClBBi3MRCPyVeXT8U2OO6BZw==
X-Received: by 2002:a17:90b:1e01:b0:23f:b35b:7789 with SMTP id pg1-20020a17090b1e0100b0023fb35b7789mr15353524pjb.28.1679969965791;
        Mon, 27 Mar 2023 19:19:25 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id f17-20020a17090ac29100b00232cc61e16bsm5029301pjt.35.2023.03.27.19.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 19:19:25 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH v6 02/12] arm64: defconfig: Add support for Nuvoton MA35 family SoCs
Date:   Tue, 28 Mar 2023 02:19:02 +0000
Message-Id: <20230328021912.177301-3-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230328021912.177301-1-ychuang570808@gmail.com>
References: <20230328021912.177301-1-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Huang <ychuang3@nuvoton.com>

This adds support for the Nuvoton MA35 family SoCs which
are based on the Cortex-A35 Armv8-A 64-bit architecture.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 7790ee42c68a..c96189acb02c 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -53,6 +53,7 @@ CONFIG_ARCH_LAYERSCAPE=y
 CONFIG_ARCH_MXC=y
 CONFIG_ARCH_S32=y
 CONFIG_ARCH_NPCM=y
+CONFIG_ARCH_NUVOTON=y
 CONFIG_ARCH_QCOM=y
 CONFIG_ARCH_RENESAS=y
 CONFIG_ARCH_ROCKCHIP=y
-- 
2.34.1

