Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18CD8623B39
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 06:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbiKJFY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 00:24:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiKJFY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 00:24:57 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE06275FC;
        Wed,  9 Nov 2022 21:24:55 -0800 (PST)
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1668057892;
        bh=SIhRYzH//kwaIhdzxST5+Pe24phe7wR7IiS7fLDVIpw=;
        h=From:To:Cc:Subject:Date:From;
        b=EeFpj9ulPKz3ANUzNLdzFGp0I0wnfEyPM0MMNAaFFz/+nWhods7DWc9sKzj8tPZCI
         2+j4VswE9Abb621YrWji9yDudR+qwgbNRDdM/ZL2k8Hg+cdrUZnz15yODHCmkbtHQs
         AH3ueKjuGAVWaMaexKLAnNhPeprXY9QeN9yWLz4I=
To:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, nbd@other.debian.org
Cc:     =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] nbd: automatically load module on genl access
Date:   Thu, 10 Nov 2022 06:24:38 +0100
Message-Id: <20221110052438.2188-1-linux@weissschuh.net>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=ed25519-sha256; t=1668057875; l=727; i=linux@weissschuh.net; s=20211113; h=from:subject; bh=SIhRYzH//kwaIhdzxST5+Pe24phe7wR7IiS7fLDVIpw=; b=TamtngLw5uGYaOiLQpg88P6iUzWfM1ZrfLyQNTSb9ffqCXcn6aghwLYi7eM0GXA0YO6yiR2sr1Hs UqDN2rPwBKx/saBBKi9xXSwr5k8/LNpPVAGDlsq5M6JV4imnTuxh
X-Developer-Key: i=linux@weissschuh.net; a=ed25519; pk=9LP6KM4vD/8CwHW7nouRBhWLyQLcK1MkP6aTZbzUlj4=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of forcing the user to manually load the module do it
automatically.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/block/nbd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 5cffd96ef2d7..1c38a7ea9531 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -2328,6 +2328,7 @@ static struct genl_family nbd_genl_family __ro_after_init = {
 	.mcgrps		= nbd_mcast_grps,
 	.n_mcgrps	= ARRAY_SIZE(nbd_mcast_grps),
 };
+MODULE_ALIAS_GENL_FAMILY(NBD_GENL_FAMILY_NAME);
 
 static int populate_nbd_status(struct nbd_device *nbd, struct sk_buff *reply)
 {

base-commit: f67dd6ce0723ad013395f20a3f79d8a437d3f455
-- 
2.38.1

