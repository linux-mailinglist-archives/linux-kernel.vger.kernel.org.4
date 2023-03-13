Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3B96B803F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjCMSUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbjCMSTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:19:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC5D73AF5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 11:19:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE331B811C0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 18:19:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D214C433EF;
        Mon, 13 Mar 2023 18:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678731554;
        bh=szmWxxlKK1lpnJMOqI7+K9rZ0evjPWH8tPPEJqg6IYI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L/prsK3d5eMLJSUtM19pWW3OtCKZMYdC8cIk3+mm4fHduQmV/QkjKtt3qGkKPtJKC
         9dp86oL20pxJvV289wGmf5WjVVn9YedllXHF82lY9GrIojlahq9vjPhrxT7veN8xfW
         KueEm2nvTBxzJXTI4Y2T9ryfa90Yq3udQ7H1tGls=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 06/12] driver core: class: make class_for_each_device() options const
Date:   Mon, 13 Mar 2023 19:18:37 +0100
Message-Id: <20230313181843.1207845-6-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313181843.1207845-1-gregkh@linuxfoundation.org>
References: <20230313181843.1207845-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1685; i=gregkh@linuxfoundation.org; h=from:subject; bh=szmWxxlKK1lpnJMOqI7+K9rZ0evjPWH8tPPEJqg6IYI=; b=owGbwMvMwCRo6H6F97bub03G02pJDCn8mUwJB9viH22ZsmK2xKaKR381U14Fu1wV4ubss1G81 RPzRHVRRywLgyATg6yYIsuXbTxH91ccUvQytD0NM4eVCWQIAxenAEwk5jnDXFkXBpY2ISeWpGeV 1dXXnVg2J71dwbBgdlJ7vPbMee9cyvW6ziRIN8YEfA8BAA==
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

class_for_each_device() does not modify the struct class or the struct
device passed into it, so mark them as const * to enforce that.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/class.c         | 2 +-
 include/linux/device/class.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/class.c b/drivers/base/class.c
index 5a60e8895165..4937d660c571 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -355,7 +355,7 @@ EXPORT_SYMBOL_GPL(class_dev_iter_exit);
  * @fn is allowed to do anything including calling back into class
  * code.  There's no locking restriction.
  */
-int class_for_each_device(struct class *class, struct device *start,
+int class_for_each_device(const struct class *class, const struct device *start,
 			  void *data, int (*fn)(struct device *, void *))
 {
 	struct class_dev_iter iter;
diff --git a/include/linux/device/class.h b/include/linux/device/class.h
index 1f5cfae8db88..fdbcd487e508 100644
--- a/include/linux/device/class.h
+++ b/include/linux/device/class.h
@@ -109,7 +109,7 @@ extern void class_dev_iter_init(struct class_dev_iter *iter,
 extern struct device *class_dev_iter_next(struct class_dev_iter *iter);
 extern void class_dev_iter_exit(struct class_dev_iter *iter);
 
-extern int class_for_each_device(struct class *class, struct device *start,
+extern int class_for_each_device(const struct class *class, const struct device *start,
 				 void *data,
 				 int (*fn)(struct device *dev, void *data));
 extern struct device *class_find_device(struct class *class,
-- 
2.39.2

