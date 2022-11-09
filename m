Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAF06225B1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 09:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiKIIpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 03:45:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiKIIpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 03:45:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14572231;
        Wed,  9 Nov 2022 00:44:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 650C3B81D46;
        Wed,  9 Nov 2022 08:44:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC5DC433C1;
        Wed,  9 Nov 2022 08:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667983496;
        bh=gubP5wUhKwsJa2PWsBZNowl7hrwhl0rnCsCJXTmXSnY=;
        h=From:To:Cc:Subject:Date:From;
        b=pBT6BNA5qf/wh+ppx/PLc1yeErH5HcRlf2fmSiKdNg+3QN4nB1uGZQEjSZw/aQs3o
         ZGnMI6DtDXlqry99ie+yx/ba0zE6wv7pd1EqFq8A4rfkiQULuLfEjvsMVfeZxbdeiR
         m4spPUsmqc4dkSfd4OiKDbyaIoQjMtU8IfJZwc4k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v2] USB: gadget: dummy_hcd: switch char * to u8 *
Date:   Wed,  9 Nov 2022 09:44:50 +0100
Message-Id: <20221109084450.2181848-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2518; i=gregkh@linuxfoundation.org; h=from:subject; bh=gubP5wUhKwsJa2PWsBZNowl7hrwhl0rnCsCJXTmXSnY=; b=owGbwMvMwCRo6H6F97bub03G02pJDMnZGQ2T+6cf/i25Rm1n+DX7Tw1cHwu23cg6IX06d8ln9+0/ 30pO74hlYRBkYpAVU2T5so3n6P6KQ4pehranYeawMoEMYeDiFICJFGkxzBW4+Z1X74b99RXchX5pXY oT1jktms+wYGNFXQzT4ll67TtDRHt5P+/749ohDwA=
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

The function handle_control_request() casts the urb buffer to a char *,
and then treats it like a unsigned char buffer when assigning data to
it.  On some architectures, "char" is really signed, so let's just
properly set this pointer to a u8 to take away any potential problems as
that's what is really wanted here.

Use put_unaligned_le16() to copy the full 16bits into the buffer,
it's not a problem just yet as only 7 bits are being used here, but this
protects us when/if the USB spec changes in the future to define more of
these bits.

Cc: Felipe Balbi <balbi@kernel.org>
Cc: Jakob Koschel <jakobkoschel@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v2: - use put_unaligned_le16() on Linus's recommendation as a simpler and
      more obvious way to describe the data being copied here.
    - update device: comment based on Alan's review

 drivers/usb/gadget/udc/dummy_hcd.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
index 899ac9f9c279..7c59c20c8623 100644
--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -1740,13 +1740,13 @@ static int handle_control_request(struct dummy_hcd *dum_hcd, struct urb *urb,
 		if (setup->bRequestType == Dev_InRequest
 				|| setup->bRequestType == Intf_InRequest
 				|| setup->bRequestType == Ep_InRequest) {
-			char *buf;
+			u8 *buf;
 			/*
-			 * device: remote wakeup, selfpowered
+			 * device: remote wakeup, selfpowered, LTM, U1, or U2
 			 * interface: nothing
 			 * endpoint: halt
 			 */
-			buf = (char *)urb->transfer_buffer;
+			buf = urb->transfer_buffer;
 			if (urb->transfer_buffer_length > 0) {
 				if (setup->bRequestType == Ep_InRequest) {
 					ep2 = find_endpoint(dum, w_index);
@@ -1755,10 +1755,9 @@ static int handle_control_request(struct dummy_hcd *dum_hcd, struct urb *urb,
 						break;
 					}
 					buf[0] = ep2->halted;
-				} else if (setup->bRequestType ==
-					   Dev_InRequest) {
-					buf[0] = (u8)dum->devstatus;
-				} else
+				} else if (setup->bRequestType == Dev_InRequest)
+					put_unaligned_le16(dum->devstatus, buf);
+				else
 					buf[0] = 0;
 			}
 			if (urb->transfer_buffer_length > 1)
-- 
2.38.1

