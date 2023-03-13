Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36036B8042
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjCMSUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbjCMSTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:19:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F363B79B0A
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 11:19:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BC126147A
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 18:19:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F5B8C433D2;
        Mon, 13 Mar 2023 18:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678731559;
        bh=JS9C7IGfylyo5Tx9AQ/9FAAw1hnxWblRtBybqCiSb00=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2fKwdA1UaoQtZkycHxLrojCmmUkHBg/OEjaQxxI8zM+MRxkAULFjzlJM6BDE3Oeph
         7iYwZ3WKlKW00i9AoQPXTaFDhajufanzbK2skcTr5ainbpO/2JqcqdcYUjsKUotANw
         ofefyr1MChJV78i1phEYxTWJJbqVGEMLSFO/WY6Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 08/12] driver core: class: make class_create/remove_file*() options const
Date:   Mon, 13 Mar 2023 19:18:39 +0100
Message-Id: <20230313181843.1207845-8-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313181843.1207845-1-gregkh@linuxfoundation.org>
References: <20230313181843.1207845-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2514; i=gregkh@linuxfoundation.org; h=from:subject; bh=JS9C7IGfylyo5Tx9AQ/9FAAw1hnxWblRtBybqCiSb00=; b=owGbwMvMwCRo6H6F97bub03G02pJDCn8mUz3hauuHLQQW/JvGdMT1pW+ER7Nbz97BifPa7prc iPCUnhNRywLgyATg6yYIsuXbTxH91ccUvQytD0NM4eVCWQIAxenAEykfhbDgqb1HLz5RoLnunQr xVillr6MbW6ZwDA/eZfwxoBIZ1PB35xpp5Q2W15Z+a4fAA==
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

The class_create_file*() and class_remove_file*() functions do not
modify the struct class at all, so mark them as const * to enforce that.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/class.c         |  4 ++--
 include/linux/device/class.h | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/base/class.c b/drivers/base/class.c
index 52ba0187e66d..3d65221b0dcb 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -87,7 +87,7 @@ static const struct kobj_type class_ktype = {
 static struct kset *class_kset;
 
 
-int class_create_file_ns(struct class *cls, const struct class_attribute *attr,
+int class_create_file_ns(const struct class *cls, const struct class_attribute *attr,
 			 const void *ns)
 {
 	int error;
@@ -101,7 +101,7 @@ int class_create_file_ns(struct class *cls, const struct class_attribute *attr,
 }
 EXPORT_SYMBOL_GPL(class_create_file_ns);
 
-void class_remove_file_ns(struct class *cls, const struct class_attribute *attr,
+void class_remove_file_ns(const struct class *cls, const struct class_attribute *attr,
 			  const void *ns)
 {
 	if (cls)
diff --git a/include/linux/device/class.h b/include/linux/device/class.h
index dfa8958105e7..75c1451fcc63 100644
--- a/include/linux/device/class.h
+++ b/include/linux/device/class.h
@@ -200,20 +200,20 @@ struct class_attribute {
 #define CLASS_ATTR_WO(_name) \
 	struct class_attribute class_attr_##_name = __ATTR_WO(_name)
 
-extern int __must_check class_create_file_ns(struct class *class,
+extern int __must_check class_create_file_ns(const struct class *class,
 					     const struct class_attribute *attr,
 					     const void *ns);
-extern void class_remove_file_ns(struct class *class,
+extern void class_remove_file_ns(const struct class *class,
 				 const struct class_attribute *attr,
 				 const void *ns);
 
-static inline int __must_check class_create_file(struct class *class,
-					const struct class_attribute *attr)
+static inline int __must_check class_create_file(const struct class *class,
+						 const struct class_attribute *attr)
 {
 	return class_create_file_ns(class, attr, NULL);
 }
 
-static inline void class_remove_file(struct class *class,
+static inline void class_remove_file(const struct class *class,
 				     const struct class_attribute *attr)
 {
 	return class_remove_file_ns(class, attr, NULL);
-- 
2.39.2

