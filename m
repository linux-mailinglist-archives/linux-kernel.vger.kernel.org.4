Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B892B60704A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 08:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiJUGpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 02:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiJUGo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 02:44:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B608A1F9;
        Thu, 20 Oct 2022 23:44:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9917061B39;
        Fri, 21 Oct 2022 06:44:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82F38C433B5;
        Fri, 21 Oct 2022 06:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666334697;
        bh=Lh39dsSR2kSBUfou8Tu7BCiRrPulwLvLeS/qMsODS1s=;
        h=From:To:Cc:Subject:Date:From;
        b=CB7H0A4ZiBfH7FVc3Lc7ipzsK2/dBVP4OCKdl8GxWDL86BFWVJUxCZ0ZCfUO+vxej
         Vri98ayv2EJ5QNqBf40vZatfVuFFA4tqWkFhKmW0Aa4EGCQW7iV0wzHokPugCuobAi
         E4XmKtRgiLLbtHKesoGq4nkfvF3htpjWobmycpNc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] USB: gadget: dummy_hcd: switch char * to u8 *
Date:   Fri, 21 Oct 2022 08:44:53 +0200
Message-Id: <20221021064453.3341050-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1528; i=gregkh@linuxfoundation.org; h=from:subject; bh=Lh39dsSR2kSBUfou8Tu7BCiRrPulwLvLeS/qMsODS1s=; b=owGbwMvMwCRo6H6F97bub03G02pJDMlB9o/D/S72sPYcWagmYZi1s8eZVSl4z+xKKeu/BztnWzN9 dBPsiGVhEGRikBVTZPmyjefo/opDil6Gtqdh5rAygQxh4OIUgIkYHWeY7//j275+Vaa8Uvbvd983H2 +2CH41j2F+uYPzhicx03i0PRRPyAWItZhGCbMCAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

Cc: Felipe Balbi <balbi@kernel.org>
Cc: Jakob Koschel <jakobkoschel@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Ira Weiny <ira.weiny@intel.com>
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/udc/dummy_hcd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
index 899ac9f9c279..774781968e55 100644
--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -1740,13 +1740,13 @@ static int handle_control_request(struct dummy_hcd *dum_hcd, struct urb *urb,
 		if (setup->bRequestType == Dev_InRequest
 				|| setup->bRequestType == Intf_InRequest
 				|| setup->bRequestType == Ep_InRequest) {
-			char *buf;
+			u8 *buf;
 			/*
 			 * device: remote wakeup, selfpowered
 			 * interface: nothing
 			 * endpoint: halt
 			 */
-			buf = (char *)urb->transfer_buffer;
+			buf = urb->transfer_buffer;
 			if (urb->transfer_buffer_length > 0) {
 				if (setup->bRequestType == Ep_InRequest) {
 					ep2 = find_endpoint(dum, w_index);
-- 
2.38.1

