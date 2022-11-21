Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83D4631D39
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 10:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbiKUJrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 04:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbiKUJq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 04:46:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E35C97EF7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 01:46:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6C18B80DA1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 09:46:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD76DC43470;
        Mon, 21 Nov 2022 09:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669024015;
        bh=6RxV4EYuvPy7DNNaTcdLjKBIoSdpfXyaOictufStsKc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PbmKzyJAiZMH7k7Ui8IWm/NFM8pw2iSgk6LI0XsRucF7hljmIqkn4GSUwdETomb0l
         Wg6XScVHiv7Fb+QE71vFie6vBY8Bu7iJ7yMEfLfuT+N3x4th6qIYkxSP3DVzJfF+K/
         KO21tfF5x4P2mFlkLtCOoqmjRv0LoP5RfZjrOCQQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 2/5] kobject: make kobject_namespace take a const *
Date:   Mon, 21 Nov 2022 10:46:46 +0100
Message-Id: <20221121094649.1556002-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221121094649.1556002-1-gregkh@linuxfoundation.org>
References: <20221121094649.1556002-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3049; i=gregkh@linuxfoundation.org; h=from:subject; bh=6RxV4EYuvPy7DNNaTcdLjKBIoSdpfXyaOictufStsKc=; b=owGbwMvMwCRo6H6F97bub03G02pJDMnVnhynp5UXFyktfsL8qoJxXdzrC3ydl/peF1YZXV7z6NK/ MO78jlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZiIzwmGBceilz0Q+lb9eNX7TT8sO/ KWLlWsXcEwv8jo8vRHv4vdjby+31SYtl3PaP7nnQA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kobject_namespace() should take a const *kobject as it does not modify
the kobject passed to it.  Change that, and the functions
kobj_child_ns_ops() and kobj_ns_ops() needed to also be changed to const
*.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/kobject.h    | 2 +-
 include/linux/kobject_ns.h | 4 ++--
 lib/kobject.c              | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index d978dbceb50d..5a2d58e10bf5 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -112,7 +112,7 @@ extern struct kobject * __must_check kobject_get_unless_zero(
 						struct kobject *kobj);
 extern void kobject_put(struct kobject *kobj);
 
-extern const void *kobject_namespace(struct kobject *kobj);
+extern const void *kobject_namespace(const struct kobject *kobj);
 extern void kobject_get_ownership(const struct kobject *kobj,
 				  kuid_t *uid, kgid_t *gid);
 extern char *kobject_get_path(const struct kobject *kobj, gfp_t flag);
diff --git a/include/linux/kobject_ns.h b/include/linux/kobject_ns.h
index 2b5b64256cf4..be707748e7ce 100644
--- a/include/linux/kobject_ns.h
+++ b/include/linux/kobject_ns.h
@@ -47,8 +47,8 @@ struct kobj_ns_type_operations {
 
 int kobj_ns_type_register(const struct kobj_ns_type_operations *ops);
 int kobj_ns_type_registered(enum kobj_ns_type type);
-const struct kobj_ns_type_operations *kobj_child_ns_ops(struct kobject *parent);
-const struct kobj_ns_type_operations *kobj_ns_ops(struct kobject *kobj);
+const struct kobj_ns_type_operations *kobj_child_ns_ops(const struct kobject *parent);
+const struct kobj_ns_type_operations *kobj_ns_ops(const struct kobject *kobj);
 
 bool kobj_ns_current_may_mount(enum kobj_ns_type type);
 void *kobj_ns_grab_current(enum kobj_ns_type type);
diff --git a/lib/kobject.c b/lib/kobject.c
index 26e744a46d24..6e0bf03f4f36 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -25,7 +25,7 @@
  * and thus @kobj should have a namespace tag associated with it.  Returns
  * %NULL otherwise.
  */
-const void *kobject_namespace(struct kobject *kobj)
+const void *kobject_namespace(const struct kobject *kobj)
 {
 	const struct kobj_ns_type_operations *ns_ops = kobj_ns_ops(kobj);
 
@@ -1039,7 +1039,7 @@ int kobj_ns_type_registered(enum kobj_ns_type type)
 	return registered;
 }
 
-const struct kobj_ns_type_operations *kobj_child_ns_ops(struct kobject *parent)
+const struct kobj_ns_type_operations *kobj_child_ns_ops(const struct kobject *parent)
 {
 	const struct kobj_ns_type_operations *ops = NULL;
 
@@ -1049,7 +1049,7 @@ const struct kobj_ns_type_operations *kobj_child_ns_ops(struct kobject *parent)
 	return ops;
 }
 
-const struct kobj_ns_type_operations *kobj_ns_ops(struct kobject *kobj)
+const struct kobj_ns_type_operations *kobj_ns_ops(const struct kobject *kobj)
 {
 	return kobj_child_ns_ops(kobj->parent);
 }
-- 
2.38.1

