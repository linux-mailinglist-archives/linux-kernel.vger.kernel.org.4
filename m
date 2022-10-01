Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5493F5F1DED
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 18:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiJAQxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 12:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiJAQx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 12:53:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997B83A492
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 09:53:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53731B80762
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 16:53:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8791DC433C1;
        Sat,  1 Oct 2022 16:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664643199;
        bh=n9d/EkdUmcQ99Rqren5otlfYtoFFpWqFgwiTVGSLk98=;
        h=From:To:Cc:Subject:Date:From;
        b=Z8uyqkZukDy2/tNuDwGZj8tsy50tgwkyTh1ahvNOrxUk11K3watLM4P3cnJtnLWNV
         L+ga5SW4VdPDQMf1k0anYv0nUX5hg2TUWp37JuA7UhltjViZfWrVshRap8Gi1o605V
         XYXF0R4x+F10nwiRLY07xPn6OnW2PxXZNzTEBaAY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH] kobject: modify kobject_get_path() to take a const *
Date:   Sat,  1 Oct 2022 18:53:15 +0200
Message-Id: <20221001165315.2690141-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2188; i=gregkh@linuxfoundation.org; h=from:subject; bh=n9d/EkdUmcQ99Rqren5otlfYtoFFpWqFgwiTVGSLk98=; b=owGbwMvMwCRo6H6F97bub03G02pJDMkWBdVvr8auz/6ot41NTMJHrpPlx+v/0d+T410c2LrndIVO 97rREcvCIMjEICumyPJlG8/R/RWHFL0MbU/DzGFlAhnCwMUpABNx/suwYN5C1ylKvHIB689mpF3u2R F2U/X6I4Y5PG8zp7xc2nsyT4XHTrdp/5aWP/ztAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kobject_get_path() does not modify the kobject passed to it, so make the
pointer constant.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/kobject.h |  2 +-
 lib/kobject.c           | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index 57fb972fea05..592f9785b058 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -115,7 +115,7 @@ extern void kobject_put(struct kobject *kobj);
 extern const void *kobject_namespace(struct kobject *kobj);
 extern void kobject_get_ownership(struct kobject *kobj,
 				  kuid_t *uid, kgid_t *gid);
-extern char *kobject_get_path(struct kobject *kobj, gfp_t flag);
+extern char *kobject_get_path(const struct kobject *kobj, gfp_t flag);
 
 struct kobj_type {
 	void (*release)(struct kobject *kobj);
diff --git a/lib/kobject.c b/lib/kobject.c
index 5f0e71ab292c..4b1c30793f49 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -94,10 +94,10 @@ static int create_dir(struct kobject *kobj)
 	return 0;
 }
 
-static int get_kobj_path_length(struct kobject *kobj)
+static int get_kobj_path_length(const struct kobject *kobj)
 {
 	int length = 1;
-	struct kobject *parent = kobj;
+	const struct kobject *parent = kobj;
 
 	/* walk up the ancestors until we hit the one pointing to the
 	 * root.
@@ -112,9 +112,9 @@ static int get_kobj_path_length(struct kobject *kobj)
 	return length;
 }
 
-static void fill_kobj_path(struct kobject *kobj, char *path, int length)
+static void fill_kobj_path(const struct kobject *kobj, char *path, int length)
 {
-	struct kobject *parent;
+	const struct kobject *parent;
 
 	--length;
 	for (parent = kobj; parent; parent = parent->parent) {
@@ -136,7 +136,7 @@ static void fill_kobj_path(struct kobject *kobj, char *path, int length)
  *
  * Return: The newly allocated memory, caller must free with kfree().
  */
-char *kobject_get_path(struct kobject *kobj, gfp_t gfp_mask)
+char *kobject_get_path(const struct kobject *kobj, gfp_t gfp_mask)
 {
 	char *path;
 	int len;
-- 
2.37.3

