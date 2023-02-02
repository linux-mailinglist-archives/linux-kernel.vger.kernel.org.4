Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13686882D4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbjBBPjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:39:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbjBBPj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:39:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F51C728E2;
        Thu,  2 Feb 2023 07:39:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1AFBB826B3;
        Thu,  2 Feb 2023 15:32:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C19C433EF;
        Thu,  2 Feb 2023 15:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675351973;
        bh=/fC3SKgXnhxkXkgQHHlU+wUOPEms2EA6dwlfaZmQUFI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ljXSTmo5e1AygfdcBvZlTUrri+5OrgrYA+B7M82PQBBUvhJOk0Uyr1dxqqrWOpSr6
         3oAh5RQ79jcrFefSbvk6Ly114d308Mf99Xw5z0C9beUri33KwgBBoML0vc+SjRgYGT
         X9brIiiRr/f178w3E+8sdpWQe7UT1qQSliFxgsQg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-usb@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/13] USB: gadget: pxa27x_udc: fix memory leak with using debugfs_lookup()
Date:   Thu,  2 Feb 2023 16:32:34 +0100
Message-Id: <20230202153235.2412790-12-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230202153235.2412790-1-gregkh@linuxfoundation.org>
References: <20230202153235.2412790-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1140; i=gregkh@linuxfoundation.org; h=from:subject; bh=/fC3SKgXnhxkXkgQHHlU+wUOPEms2EA6dwlfaZmQUFI=; b=owGbwMvMwCRo6H6F97bub03G02pJDMm3r0/etLQ/unLpHTYdy6KS726bn5Tt2bf2cMaXxhk3Xh39 kK14siOWhUGQiUFWTJHlyzaeo/srDil6GdqehpnDygQyhIGLUwAmwm3LMD+uQXpG2tcFieaKy5Z/Za 047SBsP4dhDr/5t2o77oy4p/svO/5Nak0/8prdFQA=
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

When calling debugfs_lookup() the result must have dput() called on it,
otherwise the memory will leak over time.  To make things simpler, just
call debugfs_lookup_and_remove() instead which handles all of the logic
at once.

Cc: Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/udc/pxa27x_udc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/pxa27x_udc.c b/drivers/usb/gadget/udc/pxa27x_udc.c
index ac980d6a4740..0ecdfd2ba9e9 100644
--- a/drivers/usb/gadget/udc/pxa27x_udc.c
+++ b/drivers/usb/gadget/udc/pxa27x_udc.c
@@ -215,7 +215,7 @@ static void pxa_init_debugfs(struct pxa_udc *udc)
 
 static void pxa_cleanup_debugfs(struct pxa_udc *udc)
 {
-	debugfs_remove(debugfs_lookup(udc->gadget.name, usb_debug_root));
+	debugfs_lookup_and_remove(udc->gadget.name, usb_debug_root);
 }
 
 #else
-- 
2.39.1

