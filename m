Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F34C7066B0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 13:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjEQLa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 07:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjEQLaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 07:30:24 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7B44205;
        Wed, 17 May 2023 04:30:12 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1684323010;
        bh=tX5B9YR0enKjdo8Rk63Z+5SJMwlE6xq8HQ4kgSM4ylU=;
        h=From:Date:Subject:To:Cc:From;
        b=hJwrVwFQukiU4UMcCJrA5lzxgA8pOX1JdgG5wrs409bquq+cCFhPJaPpOvhUTKiQ6
         gAmlRrXeNYLhk4wqqunpw/JNawwyVx+jcl/Yr4AVbIxITF+R7cH4NEwCBko8caCqns
         db6bMl9bj0XldY4OxYVYl+8dWzQMV/35+rpLtAZE=
Date:   Wed, 17 May 2023 13:30:05 +0200
Subject: [PATCH v2] nbd: automatically load module on genl access
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230223-b4-nbd-genl-v2-1-64585d9ce4b9@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIALy6ZGQC/zWNQQrCMBBFr1KydkoyqTW48h7iIkmnTSBOJWm1U
 Hp3g+DyfXjv76JQjlTEtdlFpncsceYKeGqED5YngjhUFihRS0QNrgN2A0zECbS9dN722vSmF9V
 wthC4bNmH6vCaUh1fmca4/S7uj8pjnp+whEz2H0allJRn7LRpURkDClLkdbt9KJZSfFhDy7SI4
 /gC2AiDba8AAAA=
To:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org, Wouter Verhelst <w@uter.be>,
        "Richard W.M. Jones" <rjones@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684323007; l=1278;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=tX5B9YR0enKjdo8Rk63Z+5SJMwlE6xq8HQ4kgSM4ylU=;
 b=RTZfwn/ytq5xcFdHDR6ZfgqLHr4gAH0UxLUokOjS5rbCOF9JIRK0Cd8dGjOiYbvJOZYg2yayr
 kkMaoHJCcGmBEw2CS2M5jS/gbBTUajZjw3sB464zeEyofqm7L9U3Cjv
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of forcing the user to manually load the module do it
automatically.

For example this avoids the following error when using nbd-client:

$ nbd-client localhost 10809 /dev/nbd0
...
Error: Couldn't resolve the nbd netlink family, make sure the nbd module is loaded and your nbd driver supports the netlink interface.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v2:
- Expand Cc list to get some reviews
- Add concrete commit example to commit message
- Link to v1: https://lore.kernel.org/lkml/20221110052438.2188-1-linux@weissschuh.net/
---
 drivers/block/nbd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 65ecde3e2a5b..8632dbacd2ef 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -2335,6 +2335,7 @@ static struct genl_family nbd_genl_family __ro_after_init = {
 	.mcgrps		= nbd_mcast_grps,
 	.n_mcgrps	= ARRAY_SIZE(nbd_mcast_grps),
 };
+MODULE_ALIAS_GENL_FAMILY(NBD_GENL_FAMILY_NAME);
 
 static int populate_nbd_status(struct nbd_device *nbd, struct sk_buff *reply)
 {

---
base-commit: f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6
change-id: 20230223-b4-nbd-genl-3a74ca638686

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

