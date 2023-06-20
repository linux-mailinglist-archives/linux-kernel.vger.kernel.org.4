Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5DCB737455
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 20:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjFTSde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 14:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjFTSdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 14:33:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7553D1984
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 11:33:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD51B6140F
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 18:33:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1EC1C433C8;
        Tue, 20 Jun 2023 18:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687285998;
        bh=SqvhAodB465EsF7b1FR43lL1U65Vj+cZWCGrIetux8Y=;
        h=From:To:Cc:Subject:Date:From;
        b=chu0PrrFYy6l4aQH5YUrizUqIiYD5ldCLqo6p3KLUKCB3y9OH7OTLvMN2HFEd9QtI
         Q5t/2k4Knhg8mR9SBGuJtIi9QeslPAyiSm/vYJgzqfvV6uzfdUP7w/CCAz7wJVNH4I
         haHcyMwPEXYUcyKw3aWWCIxq33z/CymbhGiodCTE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] mm: backing-dev: make bdi_class a static const structure
Date:   Tue, 20 Jun 2023 20:33:15 +0200
Message-ID: <20230620183314.682822-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1837; i=gregkh@linuxfoundation.org; h=from:subject; bh=K0CQkPBo/+H1fLv6yQzfATV1NVqEuRkRSTLa+uZOhmc=; b=owGbwMvMwCRo6H6F97bub03G02pJDCkTP7zKtLnNftK6O6B49SrPd9OirXJfye8w0fhjYLXqx FF3B+3dHbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjCRPY8Y5mfE3Hxy/ITP3dVT NtxxiN0b3pq0aQXD/NpZH1rF94j09Hdw3VuT/lPH/5ZmJwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ivan Orlov <ivan.orlov0322@gmail.com>

Now that the driver core allows for struct class to be in read-only
memory, move the bdi_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at load time.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/backing-dev.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 7da9727fcdf3..3ffc3cfa7a14 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -20,7 +20,6 @@
 struct backing_dev_info noop_backing_dev_info;
 EXPORT_SYMBOL_GPL(noop_backing_dev_info);
 
-static struct class *bdi_class;
 static const char *bdi_unknown_name = "(unknown)";
 
 /*
@@ -345,13 +344,19 @@ static struct attribute *bdi_dev_attrs[] = {
 };
 ATTRIBUTE_GROUPS(bdi_dev);
 
+static const struct class bdi_class = {
+	.name		= "bdi",
+	.dev_groups	= bdi_dev_groups,
+};
+
 static __init int bdi_class_init(void)
 {
-	bdi_class = class_create("bdi");
-	if (IS_ERR(bdi_class))
-		return PTR_ERR(bdi_class);
+	int ret;
+
+	ret = class_register(&bdi_class);
+	if (ret)
+		return ret;
 
-	bdi_class->dev_groups = bdi_dev_groups;
 	bdi_debug_init();
 
 	return 0;
@@ -1001,7 +1006,7 @@ int bdi_register_va(struct backing_dev_info *bdi, const char *fmt, va_list args)
 		return 0;
 
 	vsnprintf(bdi->dev_name, sizeof(bdi->dev_name), fmt, args);
-	dev = device_create(bdi_class, NULL, MKDEV(0, 0), bdi, bdi->dev_name);
+	dev = device_create(&bdi_class, NULL, MKDEV(0, 0), bdi, bdi->dev_name);
 	if (IS_ERR(dev))
 		return PTR_ERR(dev);
 
-- 
2.41.0

