Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771396882B2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbjBBPfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:35:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbjBBPez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:34:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3807C7BBD0;
        Thu,  2 Feb 2023 07:34:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E94A61BEA;
        Thu,  2 Feb 2023 15:33:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32748C433EF;
        Thu,  2 Feb 2023 15:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675351980;
        bh=iLS6jB8PnaUfJcgK7/7WcP/XfHedo1QulI0SnIMSF1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q/yRI6r3i9fZcOWPYmkZzMVeJHrtZNlU7+MVXcum1wpWDHq6RgX06A+rhaXN8SWxf
         7TYjJE4yc0BhQ1AoLkky02whJ8PdfQeh/eI3JazJjNkRvzC6qz1GZMEsUWYa6DmnMT
         kXZnCupwJ+CNrvqxxR70R0GEkZpq1zpHckb9Vbys=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-usb@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/13] USB: uhci: fix memory leak with using debugfs_lookup()
Date:   Thu,  2 Feb 2023 16:32:25 +0100
Message-Id: <20230202153235.2412790-3-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230202153235.2412790-1-gregkh@linuxfoundation.org>
References: <20230202153235.2412790-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1405; i=gregkh@linuxfoundation.org; h=from:subject; bh=iLS6jB8PnaUfJcgK7/7WcP/XfHedo1QulI0SnIMSF1c=; b=owGbwMvMwCRo6H6F97bub03G02pJDMm3r09USimuWvPDbun5yTefmwb/6L5ly2bPxrH40QWnqYdP b/A17ohlYRBkYpAVU2T5so3n6P6KQ4pehranYeawMoEMYeDiFICJHHjNMN8nZjfrpZJXm9el6G5IkT rQzPxoXSrD/NKTO+q9Nm7y47zys+TkIdufbHVmbwE=
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

Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/uhci-hcd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/uhci-hcd.c b/drivers/usb/host/uhci-hcd.c
index c22b51af83fc..7cdc2fa7c28f 100644
--- a/drivers/usb/host/uhci-hcd.c
+++ b/drivers/usb/host/uhci-hcd.c
@@ -536,8 +536,8 @@ static void release_uhci(struct uhci_hcd *uhci)
 	uhci->is_initialized = 0;
 	spin_unlock_irq(&uhci->lock);
 
-	debugfs_remove(debugfs_lookup(uhci_to_hcd(uhci)->self.bus_name,
-				      uhci_debugfs_root));
+	debugfs_lookup_and_remove(uhci_to_hcd(uhci)->self.bus_name,
+				  uhci_debugfs_root);
 
 	for (i = 0; i < UHCI_NUM_SKELQH; i++)
 		uhci_free_qh(uhci, uhci->skelqh[i]);
@@ -700,7 +700,7 @@ static int uhci_start(struct usb_hcd *hcd)
 			uhci->frame, uhci->frame_dma_handle);
 
 err_alloc_frame:
-	debugfs_remove(debugfs_lookup(hcd->self.bus_name, uhci_debugfs_root));
+	debugfs_lookup_and_remove(hcd->self.bus_name, uhci_debugfs_root);
 
 	return retval;
 }
-- 
2.39.1

