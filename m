Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6205E642825
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 13:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbiLEMM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 07:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbiLEMMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 07:12:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1B41A20E
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 04:12:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9F019B80F88
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 12:12:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED0ACC433D7;
        Mon,  5 Dec 2022 12:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670242337;
        bh=/ZRjwpE8MVqj9FdbA8dKxciOYI4zz5mw0HeE6Kg7bRk=;
        h=From:To:Cc:Subject:Date:From;
        b=QsCo3793g7Ra5twgUwIr6bTot9wdAbhKra1sKjxB8gkTtHeGO/8xp/FT2Lis6+Clc
         7xuHvWZt6CPou5KxdSC/d19dEnOp9hXXFerGlHmQtVUOYl8stFSwtIkOWNSvvhilQf
         kKXVWcvqqTZUDev5m+5dAGALqL8IKcsBr4LUzUGU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v2 1/4] container_of: add container_of_const() that preserves const-ness of the pointer
Date:   Mon,  5 Dec 2022 13:12:03 +0100
Message-Id: <20221205121206.166576-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1916; i=gregkh@linuxfoundation.org; h=from:subject; bh=/ZRjwpE8MVqj9FdbA8dKxciOYI4zz5mw0HeE6Kg7bRk=; b=owGbwMvMwCRo6H6F97bub03G02pJDMm9D/irvr074783v8dpCcuj9bfyIjdHSTyZYMB2RTfI5nJk R/mNjlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAbjIEYaZjM4dtUz2HukXJuVod7f9Fa p6u8iLYcFMzklTRBisDvw5xDRD9v8NMfGkXysB
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

Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
Suggested-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v2: - removed one parameter, now matches container_of(), thanks to
      suggestion from Sakari
    - changed Jason's tag to suggested-by and reviewed-by
    - added Andy's tag

 include/linux/container_of.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/container_of.h b/include/linux/container_of.h
index 2008e9f4058c..1d898f9158b4 100644
--- a/include/linux/container_of.h
+++ b/include/linux/container_of.h
@@ -22,4 +22,17 @@
 		      "pointer type mismatch in container_of()");	\
 	((type *)(__mptr - offsetof(type, member))); })
 
+/**
+ * container_of_const - cast a member of a structure out to the containing
+ *			structure and preserve the const-ness of the pointer
+ * @ptr:		the pointer to the member
+ * @type:		the type of the container struct this is embedded in.
+ * @member:		the name of the member within the struct.
+ */
+#define container_of_const(ptr, type, member)				\
+	_Generic(ptr,							\
+		const typeof(*(ptr)) *: ((const type *)container_of(ptr, type, member)),\
+		default: ((type *)container_of(ptr, type, member))	\
+	)
+
 #endif	/* _LINUX_CONTAINER_OF_H */
-- 
2.38.1

