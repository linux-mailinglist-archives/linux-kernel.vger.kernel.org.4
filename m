Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F71063F856
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 20:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiLATb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 14:31:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbiLATbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 14:31:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D76CA159
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 11:31:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C524620E1
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 19:31:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A56C433C1;
        Thu,  1 Dec 2022 19:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669923063;
        bh=V6x+RCOV8HEtgHyu8YD+ZG1KCpXzbM+R80b0/e3k1x0=;
        h=From:To:Cc:Subject:Date:From;
        b=PRWtp1FAmzKQBnFDts9+ZBt+yu0QYpTlEmmPr075Nc0tRS1Wsl9ZzWTsDq+QrALGO
         Defb0cyDgFIigMBWcvHqnhehNxFPDkWcqkfrhQl2aAiOZ8Z9bJUaUrMCuPiDwBrLV1
         PJys0f3u6lMP/4F11PIr/lm44OBCdMPA1q2dYW8w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 1/4] container_of: add container_of_const() that preserves const-ness of the pointer
Date:   Thu,  1 Dec 2022 20:30:54 +0100
Message-Id: <20221201193057.1195255-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1763; i=gregkh@linuxfoundation.org; h=from:subject; bh=V6x+RCOV8HEtgHyu8YD+ZG1KCpXzbM+R80b0/e3k1x0=; b=owGbwMvMwCRo6H6F97bub03G02pJDMmdDO+XG9uorNbftaru1mNx/kXnU4+VrCw6wTirTGWap/f0 93JFHbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjCRiw8YFkxZxPacZ86aF/+FZG/7cG Xfun8rgoFhQWt+5v+ep39XOzzOuLRCksFI85/ZBAA=
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

container_of does not preserve the const-ness of a pointer that is
passed into it, which can cause C code that passes in a const pointer to
get a pointer back that is not const and then scribble all over the data
in it.  To prevent this, container_of_const() will preserve the const
status of the pointer passed into it using the newly available _Generic()
method.

Co-developed-by: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/container_of.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/container_of.h b/include/linux/container_of.h
index 2008e9f4058c..3c290e865151 100644
--- a/include/linux/container_of.h
+++ b/include/linux/container_of.h
@@ -22,4 +22,18 @@
 		      "pointer type mismatch in container_of()");	\
 	((type *)(__mptr - offsetof(type, member))); })
 
+/**
+ * container_of_const - cast a member of a structure out to the containing
+ *			structure and preserve the const-ness of the pointer
+ * @ptr_type:		the type of the pointer @ptr
+ * @ptr:		the pointer to the member
+ * @member_type:	the type of the container struct this is embedded in.
+ * @member:		the name of the member within the struct.
+ */
+#define container_of_const(ptr_type, ptr, member_type, member)		\
+	_Generic(ptr,							\
+		const ptr_type *: ((const member_type *)container_of(ptr, member_type, member)),\
+		ptr_type *: ((member_type *)container_of(ptr, member_type, member))	\
+	)
+
 #endif	/* _LINUX_CONTAINER_OF_H */
-- 
2.38.1

