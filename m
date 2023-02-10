Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25324691699
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 03:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjBJCQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 21:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjBJCQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 21:16:27 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485D170969
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 18:16:18 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1675995376;
        bh=IcKXUOph5Uq/d7rKrb0onbZjg5XcHRfrd3jO9HnwOtc=;
        h=From:Date:Subject:To:Cc:From;
        b=C1Zl+D0kHHP6WRG/IcJ9m+o7ZDWLuR52OXL9kQ0PXvscuX9Gqhw45LIPxRb4aQyWm
         pofvytHVdbTTdwl4rO/xHeZIJk30zckiwUV0lWrj1WHmK/lU6jl1tAzeQ65GsF8mei
         pEIYkjjMG4jJWWc5lIpXhiPISPA2eGHeVR4+2pJI=
Date:   Fri, 10 Feb 2023 02:16:13 +0000
Subject: [PATCH] ubifs: make kobj_type structures constant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230210-kobj_type-ubifs-v1-1-052419f90fae@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAOyo5WMC/x2N0QqDMAwAf0XyvECtm6K/MkRajRqVKo2ODfHfF
 3y8g+NOEIpMAlVyQqQPC69BIX0k0I4uDITcKYM1NjM2NTivfmr230Z4eO4FX0VpXNY9cyoL0Mo
 7IfTRhXbULhzLonKL1PP33rzr6/oDPO1kK3YAAAA=
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1675995374; l=1131;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=IcKXUOph5Uq/d7rKrb0onbZjg5XcHRfrd3jO9HnwOtc=;
 b=h0oBl2kNVAVRAwQ2FkTKyDUx9MVHRilJY04iy94HQb8x1TyJyARqGBUi9S71Y+mutyUYJTxf/
 i01Zdk1h9O4CnFX8UnzZijYlgogTGypPDMf+V2UrLIEFFhYGzHc5aH3
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

Take advantage of this to constify the structure definitions to prevent
modification at runtime.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 fs/ubifs/sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ubifs/sysfs.c b/fs/ubifs/sysfs.c
index 06ad8fa1fcfb..4404ca4f2ce9 100644
--- a/fs/ubifs/sysfs.c
+++ b/fs/ubifs/sysfs.c
@@ -74,13 +74,13 @@ static const struct sysfs_ops ubifs_attr_ops = {
 	.show	= ubifs_attr_show,
 };
 
-static struct kobj_type ubifs_sb_ktype = {
+static const struct kobj_type ubifs_sb_ktype = {
 	.default_groups	= ubifs_groups,
 	.sysfs_ops	= &ubifs_attr_ops,
 	.release	= ubifs_sb_release,
 };
 
-static struct kobj_type ubifs_ktype = {
+static const struct kobj_type ubifs_ktype = {
 	.sysfs_ops	= &ubifs_attr_ops,
 };
 

---
base-commit: e544a07438522ab3688416e6e2e34bf0ee6d8755
change-id: 20230210-kobj_type-ubifs-5790a3d46e97

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

