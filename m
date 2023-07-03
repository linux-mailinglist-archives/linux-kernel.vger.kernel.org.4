Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564367460E7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 18:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjGCQlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 12:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGCQlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 12:41:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE82E49
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 09:41:35 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-215-029.ewe-ip-backbone.de [91.248.215.29])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 01E206606F6C;
        Mon,  3 Jul 2023 17:41:34 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688402494;
        bh=B0URFXgImNMOKALU8VS0EvBoWTwaU4+U/GaqYEktyFs=;
        h=From:To:Cc:Subject:Date:From;
        b=BMfTbVp3pDQZF4LAVvTLSGGR61z5ggRm8jnjTib/HV9Ot5jRcI/poXVrBbrYueekA
         WjIMbrhiSEL+r1a4KraEd+kbEiph37/qfUkFTLgeJRAyqy/3tL7mRrN6iIHt3vA7/s
         YEyM82LNnqqlU2hPD3IF1yAjGLlJTtZgdCPAgT1D2TluR0pjVMc0IBNjoDmXliAz+G
         onWLTXc2lzkHcu14r9+fYsE6P3EIy38Rx1XFhTepLqu3uvFC6djLi/pjOR0jv5YUlL
         Hz0BNoZze96xk6jMfsMbZAaTCO4nxYElSF2qXc8xMlwsmI3LHwgfQK0+ZEyo8daPr0
         AQWYPIxT299tw==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 025444829F6; Mon,  3 Jul 2023 18:41:30 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Chris Morgan <macromorgan@hotmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v1 1/1] irqchip/gic-v3: Enable Rockchip 3588001 erratum workaround for RK3588S
Date:   Mon,  3 Jul 2023 18:41:29 +0200
Message-Id: <20230703164129.193991-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a8707f553884 ("irqchip/gic-v3: Add Rockchip 3588001 erratum
workaround") mentioned RK3588S (the slimmed down variant of RK3588)
being affected, but did not check for its compatible value. Thus the
quirk is not applied on RK3588S. Since the GIC ITS node got added to the
upstream DT, boards using RK3588S are no longer booting without this
quirk being applied.

Fixes: 06cdac8e8407 ("arm64: dts: rockchip: add GIC ITS support to rk3588")
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
I recently got a Rock 5A and noticed this issue. Apart from it, the Indiedroid
Nova should also be affected (I don't have that board). There are no other
upstream RK3588S boards at the moment.
---
 drivers/irqchip/irq-gic-v3-its.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 1994541eaef8..034ece9ac47c 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -4727,7 +4727,8 @@ static bool __maybe_unused its_enable_rk3588001(void *data)
 {
 	struct its_node *its = data;
 
-	if (!of_machine_is_compatible("rockchip,rk3588"))
+	if (!of_machine_is_compatible("rockchip,rk3588") &&
+	    !of_machine_is_compatible("rockchip,rk3588s"))
 		return false;
 
 	its->flags |= ITS_FLAGS_FORCE_NON_SHAREABLE;
-- 
2.40.1

