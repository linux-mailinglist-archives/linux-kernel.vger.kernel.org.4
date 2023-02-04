Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930B368A876
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 06:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbjBDFrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 00:47:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjBDFrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 00:47:08 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14824C3C;
        Fri,  3 Feb 2023 21:47:07 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1675489626;
        bh=SU52QghoEUEGHtxX/Ww5tgflq7zi3OTDWQ53k9fgItc=;
        h=From:Date:Subject:To:Cc:From;
        b=EH36quhguSNTCnorAPpXFMVeN3/4jS1AB1KQauSPyCkSZKuJkGSR3tu71+o9h6HDX
         huY+D7SZTr1eq2z8A9vL8V6BNR/mCPRmka7eEYVBVCcDtbfAc4HRLvGMh9sTahrZbR
         wWxjpZKfC/y+bVU6Nls4xCkft0FF9d/xWE3+0e9Y=
Date:   Sat, 04 Feb 2023 05:47:03 +0000
Subject: [PATCH] of: make of_node_ktype constant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230204-kobj_type-of-v1-1-5910c8ecb7a3@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAFbx3WMC/x2N0QqDMAwAf0XybCBWQdivjCFNjTMqrbTb2BD/f
 cHHOzjugCJZpcCtOiDLR4umaNDUFYTZx6egjsbgyLXkqMM18TK8frtgmjCEnhoe2fUtgSXsiyB
 nH8NsUXxvm8k9y6Tf63F/nOcfAYKWMHMAAAA=
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1675489623; l=1382;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=SU52QghoEUEGHtxX/Ww5tgflq7zi3OTDWQ53k9fgItc=;
 b=0sX3Qr/JE4D6QmmbPRip0GrP3EG94OKoJjE34MpcSomeaZQFP5zKVNwLBQ9B1vsBa7MNRJedL
 Vz1GsV8NseHAz3EEeEfEfLLQaar1/N1x2bpL/vdNsF8SB+YMMQRynj4
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
the driver core allows the usage of const struct kobj_type.

Take advantage of this to constify the structure definition to prevent
modification at runtime.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/of/kobj.c  | 2 +-
 include/linux/of.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/of/kobj.c b/drivers/of/kobj.c
index 7d3853a5a09a..3dbce1e6f184 100644
--- a/drivers/of/kobj.c
+++ b/drivers/of/kobj.c
@@ -24,7 +24,7 @@ static void of_node_release(struct kobject *kobj)
 }
 #endif /* CONFIG_OF_DYNAMIC */
 
-struct kobj_type of_node_ktype = {
+const struct kobj_type of_node_ktype = {
 	.release = of_node_release,
 };
 
diff --git a/include/linux/of.h b/include/linux/of.h
index 8b9f94386dc3..8bb348666709 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -101,7 +101,7 @@ struct of_reconfig_data {
 };
 
 /* initialize a node */
-extern struct kobj_type of_node_ktype;
+extern const struct kobj_type of_node_ktype;
 extern const struct fwnode_operations of_fwnode_ops;
 static inline void of_node_init(struct device_node *node)
 {

---
base-commit: 0136d86b78522bbd5755f8194c97a987f0586ba5
change-id: 20230204-kobj_type-of-cc701bdb2730

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

