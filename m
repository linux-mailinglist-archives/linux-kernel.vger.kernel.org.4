Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10466C8156
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 16:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjCXPfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 11:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbjCXPfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 11:35:48 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44759AF02
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 08:35:32 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1679672130;
        bh=ckFawQ1qLSFHu7FH9gpxiQREhNiKA5dRZcnPaoegb24=;
        h=From:Date:Subject:To:Cc:From;
        b=bxV7MelJxdH1rg39V3lDEb+JLrqLBP2PKdDLXWxmrJ9dNGp41MhC8Sdqe1y/0PtsI
         2zkxqzDj/DYAIXDsODYALwK3Ju6mspcHe2xIW4AAs7pIagNfGGmYJUnuMMD3fJRjqh
         QkOMKShGzw9eP7rD41CXhNfeB9umzb1+rlkwvkds=
Date:   Fri, 24 Mar 2023 15:35:27 +0000
Subject: [PATCH] mm/damon/sysfs: make more kobj_type structures constant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230324-b4-kobj_type-damon2-v1-1-48ddbf1c8fcf@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAD7DHWQC/x2NywrCMBBFf6XM2oGadhH9FRHJ42pHa1KSKi2l/
 +7g8pzL4W5UUQSVzs1GBV+pkpPC8dBQGFx6gCUqk2lN13amZ9/zK/vnbV4ncHTvnAzrZoETbLS
 BtPSugn1xKQzaps84qpwK7rL8ry7Xff8Ba5swy3oAAAA=
To:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1679672127; l=1721;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=ckFawQ1qLSFHu7FH9gpxiQREhNiKA5dRZcnPaoegb24=;
 b=Z/mj9pBksJMTxSODV3RjMllkofs/ct51LPHtbxiK/dC93KL/ZL7YClId558U6SprhHAMWSUIs
 xK0D2hUYCFJBAeidOJF/7lUDrF8OYSpPKrQ9XMWC9+EfDqcPIO4oat1
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
the driver core allows the usage of const struct kobj_type.

Take advantage of this to constify the structure definition to prevent
modification at runtime.

These structures were not constified in
commit e56397e8c40d ("mm/damon/sysfs: make kobj_type structures constant")
as they didn't exist when that patch was written.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 mm/damon/sysfs-schemes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 3cdad5a7f936..50cf89dcd898 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -384,7 +384,7 @@ static struct attribute *damon_sysfs_scheme_filter_attrs[] = {
 };
 ATTRIBUTE_GROUPS(damon_sysfs_scheme_filter);
 
-static struct kobj_type damon_sysfs_scheme_filter_ktype = {
+static const struct kobj_type damon_sysfs_scheme_filter_ktype = {
 	.release = damon_sysfs_scheme_filter_release,
 	.sysfs_ops = &kobj_sysfs_ops,
 	.default_groups = damon_sysfs_scheme_filter_groups,
@@ -503,7 +503,7 @@ static struct attribute *damon_sysfs_scheme_filters_attrs[] = {
 };
 ATTRIBUTE_GROUPS(damon_sysfs_scheme_filters);
 
-static struct kobj_type damon_sysfs_scheme_filters_ktype = {
+static const struct kobj_type damon_sysfs_scheme_filters_ktype = {
 	.release = damon_sysfs_scheme_filters_release,
 	.sysfs_ops = &kobj_sysfs_ops,
 	.default_groups = damon_sysfs_scheme_filters_groups,

---
base-commit: 1e760fa3596e8c7f08412712c168288b79670d78
change-id: 20230324-b4-kobj_type-damon2-0238ee9e8d8c

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

