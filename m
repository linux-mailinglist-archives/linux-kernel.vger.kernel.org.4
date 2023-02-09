Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3706268FDDD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 04:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbjBIDVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 22:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232729AbjBIDVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 22:21:19 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512C11287D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 19:21:17 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1675912875;
        bh=GzTnOHgMbSFV51+peCeUABmUpKMMKHKkU+nhDrjkC3s=;
        h=From:Date:Subject:To:Cc:From;
        b=kM1azusVeo8YqS/mKVwRJyUm02Q35NZ+rnVV3JN2cb5sFe6DiL4ryRaVqK7+YP7dM
         ohxQq7ZITmpe/jwqHistwI0g9lZfXWfeqvt8r4Smo8Z7SqdiP2c1N88oLnQPxNb7pp
         4sOrcH3g4+bRA6U/qqJhqjgt0MDdF7KfBww38TP8=
Date:   Thu, 09 Feb 2023 03:21:13 +0000
Subject: [PATCH] erofs: make kobj_type structures constant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230209-kobj_type-erofs-v1-1-078c945e2c4b@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAKhm5GMC/x2N0QrCMAwAf2Xk2UBW58P8FRFpa+qiox2JijL27
 wYf7+C4FYxV2ODYraD8FpNWHfpdB3mK9cYoV2cIFPYUaMRHS/fL87swsrZiSIXKkEfqaTiAVyk
 aY9JY8+Rdfc2zy0W5yOe/OZ237QcCtezRdgAAAA==
To:     Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1675912873; l=1414;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=GzTnOHgMbSFV51+peCeUABmUpKMMKHKkU+nhDrjkC3s=;
 b=Hu1XTvtiAXnaFLNKa2cFfVQtx11qktQnpeyv0vYantYPjDbxAigCn4m27SeZnx1WtJzmJSljQ
 plY3WVhODHrDUqcZCOn09JhUws1rdrAAZQ7XHMZ9CMuMl4LJeSAR9cP
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
 fs/erofs/sysfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
index fd476961f742..435e515c0792 100644
--- a/fs/erofs/sysfs.c
+++ b/fs/erofs/sysfs.c
@@ -179,13 +179,13 @@ static const struct sysfs_ops erofs_attr_ops = {
 	.store	= erofs_attr_store,
 };
 
-static struct kobj_type erofs_sb_ktype = {
+static const struct kobj_type erofs_sb_ktype = {
 	.default_groups = erofs_groups,
 	.sysfs_ops	= &erofs_attr_ops,
 	.release	= erofs_sb_release,
 };
 
-static struct kobj_type erofs_ktype = {
+static const struct kobj_type erofs_ktype = {
 	.sysfs_ops	= &erofs_attr_ops,
 };
 
@@ -193,7 +193,7 @@ static struct kset erofs_root = {
 	.kobj	= {.ktype = &erofs_ktype},
 };
 
-static struct kobj_type erofs_feat_ktype = {
+static const struct kobj_type erofs_feat_ktype = {
 	.default_groups = erofs_feat_groups,
 	.sysfs_ops	= &erofs_attr_ops,
 };

---
base-commit: 0983f6bf2bfc0789b51ddf7315f644ff4da50acb
change-id: 20230209-kobj_type-erofs-0f0f4c901045

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

