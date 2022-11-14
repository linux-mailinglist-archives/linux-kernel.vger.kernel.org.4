Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE30627CD4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236619AbiKNLsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:48:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236940AbiKNLra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:47:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BF824087
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 03:45:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1881EB80E78
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 11:45:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58D34C433C1;
        Mon, 14 Nov 2022 11:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668426326;
        bh=F41S5/OfJJjx4Qyx7KDXsJWPyr7ThQmJ94m+jQiNNUU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=la1ciPpE+MIEVxztF90HGogzquhV08rLd3CsVUecIZyEyXFO5P7K4UPkoTyfnvLqe
         oUMOIiKfbnSMlLH8X67gdclvvmnSs5uh/T5YUsCNDd3DXFnt2rd+wfoXNIpEdxsFcv
         TZRrtnoHYltBZ7AWs9y146QMRODFePDO4jpkTqcx6Aal5rcpFilq/Eak7oKV5xkEy/
         V6+LPxwF7j1bSe9M7pjGIOt2c4yw7tnK6WEWxpIrge8ihcc+HmUtpvbi1ieF0BFe19
         Lulw23FgtYKiIrJ5/qmL8ISkxM9W9u0k/OtloelPjQZrVLX9gUIIIR0DqsxVtL/EHQ
         1CpfBlSEyzcfw==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andi Kleen <andi@firstfloor.org>, Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Martin Liska <mliska@suse.cz>, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 37/46] Compiler attributes, lto: disable __flatten with LTO
Date:   Mon, 14 Nov 2022 12:43:35 +0100
Message-Id: <20221114114344.18650-38-jirislaby@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114114344.18650-1-jirislaby@kernel.org>
References: <20221114114344.18650-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <andi@firstfloor.org>

Using __flatten causes a simple gcc 12 LTO build not fit into 16GB
anymore. Disable flatten with LTO. With gcc 12, the build still does not
finish linking in 10 minutes, eating 40GB of RAM at that point.

There is an upstream bug about this:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=107014

Until this is resolved, simply disable __flatten with LTO.

In the future, instead of this patch, we should likely drop __flatten
and its only user (pcpu_build_alloc_info()) and use always_inline to all
functions which shall be inlined there.

Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Andi Kleen <andi@firstfloor.org>
Signed-off-by: Martin Liska <mliska@suse.cz>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 include/linux/compiler_attributes.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index be6c71fd5ebb..09cf8eebcb0d 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -229,7 +229,12 @@
  * gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#Common-Function-Attributes
  * clang: https://clang.llvm.org/docs/AttributeReference.html#flatten
  */
+#ifndef CONFIG_LTO_GCC
 # define __flatten			__attribute__((flatten))
+#else
+/* Causes very large memory use with gcc in LTO mode */
+# define __flatten
+#endif
 
 /*
  * Note the missing underscores.
-- 
2.38.1

