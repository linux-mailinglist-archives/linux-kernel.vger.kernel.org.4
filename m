Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307696B7C4A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 16:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjCMPoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 11:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjCMPox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 11:44:53 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C56434031;
        Mon, 13 Mar 2023 08:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678722293; x=1710258293;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LjDvHTVQePXvglarBOFK7GWK0Gk9FTqTCiXJf74BQlA=;
  b=fqGzaoeOfp2T/M+8AWjhXO3T/lgS5dOYxqjuRK/6eAKaKPJotf2VzXH9
   1RfrD4xsn4xaJ2zmHA5sfTB2GKF0lQ2yfDmJTS780/7/XPj9MA1PVUFQu
   FJtxmaB3YsVESBfelT65NKXfFEF7R0lxeTaf2eXwnp+eZStLqvm4NtOnd
   nEQvHAsgx/hlnTGiIzeqAYKxlqI1GOgR8ZDl+6MCIi29WZNtwVj5oyf0Y
   zja1lOGjGEErKlG1nJU/BL73Dbw8g76DRUhB/JXA0wH8Jk7RChNDE2lkz
   aaJeqFAXUPNgyXkfDLLPkiIhDRnv6sDabq1LUqdLn9liARDfk9yiDbIGM
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="399773126"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="399773126"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 08:44:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="678717857"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="678717857"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 13 Mar 2023 08:44:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4945C365; Mon, 13 Mar 2023 17:45:35 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?J=C3=B3=20=C3=81gila=20Bitsch?= <jgilab@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] usb: gadget: Use correct endianness of the wLength field for WebUSB
Date:   Mon, 13 Mar 2023 17:45:22 +0200
Message-Id: <20230313154522.52684-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WebUSB code uses wLength directly without proper endianness conversion.
Update it to use already prepared temporary variable w_length instead.

Fixes: 93c473948c58 ("usb: gadget: add WebUSB landing page support")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/gadget/composite.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index fa7dd6cf014d..5377d873c08e 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -2079,10 +2079,9 @@ composite_setup(struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 				sizeof(url_descriptor->URL)
 				- WEBUSB_URL_DESCRIPTOR_HEADER_LENGTH + landing_page_offset);
 
-			if (ctrl->wLength < WEBUSB_URL_DESCRIPTOR_HEADER_LENGTH
-					    + landing_page_length)
-				landing_page_length = ctrl->wLength
-					- WEBUSB_URL_DESCRIPTOR_HEADER_LENGTH + landing_page_offset;
+			if (w_length < WEBUSB_URL_DESCRIPTOR_HEADER_LENGTH + landing_page_length)
+				landing_page_length = w_length
+				- WEBUSB_URL_DESCRIPTOR_HEADER_LENGTH + landing_page_offset;
 
 			memcpy(url_descriptor->URL,
 				cdev->landing_page + landing_page_offset,
-- 
2.39.2

