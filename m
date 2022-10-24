Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6678360B2FC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 18:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235066AbiJXQyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 12:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235427AbiJXQte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 12:49:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703FA183E32
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 08:32:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64A1DB818A7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 12:56:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5490C433D6;
        Mon, 24 Oct 2022 12:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666616207;
        bh=PCI6tEJdeb5cr0TT+br6JH/c5LPc/5OCtHMIqdIbwGk=;
        h=From:To:Cc:Subject:Date:From;
        b=MVaVZ1McalaJgbNPMmtxQ0nxlBBPOiM62rw89vuIixE73VIcaUQMXr82uDCT1xr7G
         f9pr3DuabDNvrSp6VYom3lH0pFSv1N2hgtDLBX2OXLU8L00Tc10NHMIwHByR4kMyD4
         lgvZ+C2fBX1HhFQsDfySn9zWeS/ML7up8zvafQ6A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH] container_of: remove container_of_safe()
Date:   Mon, 24 Oct 2022 14:39:33 +0200
Message-Id: <20221024123933.3331116-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1576; i=gregkh@linuxfoundation.org; h=from:subject; bh=PCI6tEJdeb5cr0TT+br6JH/c5LPc/5OCtHMIqdIbwGk=; b=owGbwMvMwCRo6H6F97bub03G02pJDMlh7c1X17N9qIsPWDBfLFEwuPD4r5U5pTk7i1PvxMhKRHD1 nxXoiGVhEGRikBVTZPmyjefo/opDil6Gtqdh5rAygQxh4OIUgIl4ODEsOP8nXPaifruM1fXQNwe419 +StCpYx7BgtUVbz6ygtZW5MxfNmZL0KO6GsG4aAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It came in from a staging driver that has been long removed from the
tree, and there are no in-kernel users of the macro, and it's very
dubious if anyone should ever use this thing, so just remove it
entirely.

Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/container_of.h | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/include/linux/container_of.h b/include/linux/container_of.h
index 2f4944b791b8..a6f242137b11 100644
--- a/include/linux/container_of.h
+++ b/include/linux/container_of.h
@@ -21,20 +21,4 @@
 		      "pointer type mismatch in container_of()");	\
 	((type *)(__mptr - offsetof(type, member))); })
 
-/**
- * container_of_safe - cast a member of a structure out to the containing structure
- * @ptr:	the pointer to the member.
- * @type:	the type of the container struct this is embedded in.
- * @member:	the name of the member within the struct.
- *
- * If IS_ERR_OR_NULL(ptr), ptr is returned unchanged.
- */
-#define container_of_safe(ptr, type, member) ({				\
-	void *__mptr = (void *)(ptr);					\
-	static_assert(__same_type(*(ptr), ((type *)0)->member) ||	\
-		      __same_type(*(ptr), void),			\
-		      "pointer type mismatch in container_of_safe()");	\
-	IS_ERR_OR_NULL(__mptr) ? ERR_CAST(__mptr) :			\
-		((type *)(__mptr - offsetof(type, member))); })
-
 #endif	/* _LINUX_CONTAINER_OF_H */
-- 
2.38.1

