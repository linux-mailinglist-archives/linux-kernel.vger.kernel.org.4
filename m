Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6C56B803E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjCMSTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbjCMSTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:19:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8197040B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 11:19:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FDBC6144F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 18:19:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 781A0C433EF;
        Mon, 13 Mar 2023 18:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678731551;
        bh=eL8AL4F0jNTjCSEwd7KB4ZZv2YCEbrUBP13L3d02KJQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wRVCdq2KXQPrskbdbmZzBP8IHk4ySVOU7XxYP8/BB18LW31aPGJmHYMveHXFRKTaw
         L1rc4KJVbAiH7bGIsvy4ikzpt6Um3vgvRjYetFNLEyq4kgnytwqxGgfZ8P3nYO76Iu
         4TIHYM+cpLq9amMtkXQC592ySJBcQ0ChCmFPZP70=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 05/12] driver core: class: make class_dev_iter_init() options const
Date:   Mon, 13 Mar 2023 19:18:36 +0100
Message-Id: <20230313181843.1207845-5-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313181843.1207845-1-gregkh@linuxfoundation.org>
References: <20230313181843.1207845-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1723; i=gregkh@linuxfoundation.org; h=from:subject; bh=eL8AL4F0jNTjCSEwd7KB4ZZv2YCEbrUBP13L3d02KJQ=; b=owGbwMvMwCRo6H6F97bub03G02pJDCn8mUwKM339wg5/dPeRWqKV6rZj4R0rxTz+X5L9V2Vmy V3MWf+gI5aFQZCJQVZMkeXLNp6j+ysOKXoZ2p6GmcPKBDKEgYtTACZSOoNhwUkj/o4f3rvFN0VO /px4dKfp9BNFDAwLjmz8ny+ecixTRuTSmc+HW+rihX9PBgA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

class_dev_iter_init() does not modify the struct class or the struct
device passed into it, so mark them as const * to enforce that.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/class.c         | 4 ++--
 include/linux/device/class.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/base/class.c b/drivers/base/class.c
index 9439c6c7466f..5a60e8895165 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -284,8 +284,8 @@ EXPORT_SYMBOL_GPL(class_destroy);
  * otherwise if it is NULL, the iteration starts at the beginning of
  * the list.
  */
-void class_dev_iter_init(struct class_dev_iter *iter, struct class *class,
-			 struct device *start, const struct device_type *type)
+void class_dev_iter_init(struct class_dev_iter *iter, const struct class *class,
+			 const struct device *start, const struct device_type *type)
 {
 	struct klist_node *start_knode = NULL;
 
diff --git a/include/linux/device/class.h b/include/linux/device/class.h
index cda598fc5fa0..1f5cfae8db88 100644
--- a/include/linux/device/class.h
+++ b/include/linux/device/class.h
@@ -103,8 +103,8 @@ void class_compat_remove_link(struct class_compat *cls, struct device *dev,
 			      struct device *device_link);
 
 extern void class_dev_iter_init(struct class_dev_iter *iter,
-				struct class *class,
-				struct device *start,
+				const struct class *class,
+				const struct device *start,
 				const struct device_type *type);
 extern struct device *class_dev_iter_next(struct class_dev_iter *iter);
 extern void class_dev_iter_exit(struct class_dev_iter *iter);
-- 
2.39.2

