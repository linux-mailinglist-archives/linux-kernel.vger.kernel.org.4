Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F768627C4E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234078AbiKNL3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235984AbiKNL2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:28:46 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A43420B;
        Mon, 14 Nov 2022 03:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668425303; x=1699961303;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2tt0pXqyf+X16xT+uW1YvPBZjN8jaC7fs9UiviM7Ozw=;
  b=YrAvqf21nYGAffNIN1j6ibDaOHHeR0tEztOGrAkQBJ/CmfVyy569pbav
   44gSXkysv7z5gaULjsQFFZAB+0exrmGmHRkrP9UXpERcXYdFSYeWqUMgF
   2CthT4Ac/OKwXwfuA8cU3PK7gfW20oEPV81VtZLv/muYAf5pniUZCugX+
   CQUQ7Q3BX1p94Ba4XkB/8MnUWQUy969qQ8Q/nlzXUc86QL7vrTZe/VTyb
   oEn+TwpSghp8TfF9e1HZNt3+28W8QGti+tPeazCVWBmRbRMlqI4O35sZR
   ifPuhooedRjPklAfk1+bJPgrX57I5FdyWzy3OM7bCWsjJQjJzF7nlColM
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="374074728"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="374074728"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 03:28:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="616278550"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="616278550"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 14 Nov 2022 03:28:19 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3FAC8346; Mon, 14 Nov 2022 13:28:44 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jakob Koschel <jakobkoschel@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1 2/4] usb: gadget: hid: Convert to use list_count()
Date:   Mon, 14 Nov 2022 13:28:40 +0200
Message-Id: <20221114112842.38565-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221114112842.38565-1-andriy.shevchenko@linux.intel.com>
References: <20221114112842.38565-1-andriy.shevchenko@linux.intel.com>
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

The list API now provides the list_count() to help with counting
existing nodes in the list. Uilise it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/gadget/legacy/hid.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/legacy/hid.c b/drivers/usb/gadget/legacy/hid.c
index 1187ee4f316a..6196c3456e0b 100644
--- a/drivers/usb/gadget/legacy/hid.c
+++ b/drivers/usb/gadget/legacy/hid.c
@@ -133,14 +133,11 @@ static struct usb_configuration config_driver = {
 static int hid_bind(struct usb_composite_dev *cdev)
 {
 	struct usb_gadget *gadget = cdev->gadget;
-	struct list_head *tmp;
 	struct hidg_func_node *n = NULL, *m, *iter_n;
 	struct f_hid_opts *hid_opts;
-	int status, funcs = 0;
-
-	list_for_each(tmp, &hidg_func_list)
-		funcs++;
+	int status, funcs;
 
+	funcs = list_count(&hidg_func_list);
 	if (!funcs)
 		return -ENODEV;
 
-- 
2.35.1

