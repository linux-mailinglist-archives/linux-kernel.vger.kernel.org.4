Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF9A69575F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 04:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjBNDVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 22:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjBNDU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 22:20:59 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065C2869C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 19:20:59 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1676344857;
        bh=l509B6JSeU+8vu09VCB2XMYyL5OSKdktVVV0A47CNNk=;
        h=From:Date:Subject:To:Cc:From;
        b=uEkWon0wY3c84CDaPBZmrDpLx+9Y8KyUimc25s8XQcYA12YA5tTMm1yyQZFktGsUY
         6uBLYcbaCFZZ1JD9F/ipnzthM6BhnlRRvVYzHOMxbqmapJoMhK9LhPUSDDqTQq6j1f
         kqmwymGc1Aeaq4pi3iX+A/KZu6nCbv7JtYD0xmQA=
Date:   Tue, 14 Feb 2023 03:20:55 +0000
Subject: [PATCH] dm sysfs: make kobj_type structure constant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230214-kobj_type-dm-v1-1-f1e0ffee5373@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIABb+6mMC/x2NzQqDMBAGX0X23IUk/hx8lVJKol91rY2StKUiv
 rtLjzMwzE4ZSZCpLXZK+EqWJSrYS0Hd6OMAll6ZnHGlcbbi5xKm+3tbwf2LmwYBFpWpS0OaBJ/
 BIfnYjRrFzzyrXBMe8vs/rrfjOAGEf9SNcwAAAA==
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676344855; l=991;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=l509B6JSeU+8vu09VCB2XMYyL5OSKdktVVV0A47CNNk=;
 b=t4RJry/Zs8Bb9v35RfLtQosyNKrTqcuQO9hoT/iSqbm11M1KXOcJVnjg9LN4Mfbo727DRCW5s
 bra94Dw7MyoD9+W42CErMJZLOtZ+dzTyGBA6k8njIZ6+8b9lw4ScigO
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
 drivers/md/dm-sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-sysfs.c b/drivers/md/dm-sysfs.c
index e28c92478536..dc281162f1d4 100644
--- a/drivers/md/dm-sysfs.c
+++ b/drivers/md/dm-sysfs.c
@@ -119,7 +119,7 @@ static const struct sysfs_ops dm_sysfs_ops = {
 	.store	= dm_attr_store,
 };
 
-static struct kobj_type dm_ktype = {
+static const struct kobj_type dm_ktype = {
 	.sysfs_ops	= &dm_sysfs_ops,
 	.default_groups	= dm_groups,
 	.release	= dm_kobject_release,

---
base-commit: f6feea56f66d34259c4222fa02e8171c4f2673d1
change-id: 20230214-kobj_type-dm-66ebe1e40530

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

