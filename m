Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123786882DA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbjBBPk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232391AbjBBPky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:40:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9037EBB9D;
        Thu,  2 Feb 2023 07:40:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74A2C61B8C;
        Thu,  2 Feb 2023 15:33:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C54CC433EF;
        Thu,  2 Feb 2023 15:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675351993;
        bh=OCpQGd9y36W01Js+1AiolPPhc/FDiwwFSG64ouudZug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KtEH7vhpb2gAmASrAaDeEBopioNdxclZKkTX7mUVj6INLSzh8G5eTL1+IguvHPu02
         gfH+ZYc1bWES9rretKPDf19QyNUwUIzRAsyibdHI4jRQe1gYPCGQvzBQhf7e/IFy8W
         TOGpzuL3ZlWBmB6LHJkjbj5mghGUkzObB+CNXp6c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-usb@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/13] USB: gadget: gr_udc: fix memory leak with using debugfs_lookup()
Date:   Thu,  2 Feb 2023 16:32:30 +0100
Message-Id: <20230202153235.2412790-8-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230202153235.2412790-1-gregkh@linuxfoundation.org>
References: <20230202153235.2412790-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1020; i=gregkh@linuxfoundation.org; h=from:subject; bh=OCpQGd9y36W01Js+1AiolPPhc/FDiwwFSG64ouudZug=; b=owGbwMvMwCRo6H6F97bub03G02pJDMm3r0+6Jjrf0IQv3T1LNdVebeNUmRsbr/fMWSLx8o5sYMfp en7rjlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZiIxWGG+TFX25p4vs5aIeC55XN9VO 7r+G07ZzPMj/CSbLzMalPfWxzscXd/XH+DtRA7AA==
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

When calling debugfs_lookup() the result must have dput() called on it,
otherwise the memory will leak over time.  To make things simpler, just
call debugfs_lookup_and_remove() instead which handles all of the logic
at once.

Cc: Jakob Koschel <jakobkoschel@gmail.com>
Cc: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/udc/gr_udc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/gr_udc.c b/drivers/usb/gadget/udc/gr_udc.c
index 22096f8505de..52c12c96c275 100644
--- a/drivers/usb/gadget/udc/gr_udc.c
+++ b/drivers/usb/gadget/udc/gr_udc.c
@@ -215,7 +215,7 @@ static void gr_dfs_create(struct gr_udc *dev)
 
 static void gr_dfs_delete(struct gr_udc *dev)
 {
-	debugfs_remove(debugfs_lookup(dev_name(dev->dev), usb_debug_root));
+	debugfs_lookup_and_remove(dev_name(dev->dev), usb_debug_root);
 }
 
 #else /* !CONFIG_USB_GADGET_DEBUG_FS */
-- 
2.39.1

