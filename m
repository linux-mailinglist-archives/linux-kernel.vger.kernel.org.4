Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576D0634049
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 16:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbiKVPfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 10:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232791AbiKVPfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 10:35:16 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A8A697ED;
        Tue, 22 Nov 2022 07:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669131315; x=1700667315;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S4XpqXdqGWk1whCKjTw1Tbea2OWWldUyTEhirb3Ex2I=;
  b=CDs97KAwtHnZL1ESISARre7fQaI0xQdm9nkVAzIlECDgFYEBaSgUeN2p
   izbUOnjRcSZyDuVysWVYeWP2L9mANgcFGY3PadxkiC36mv36MnaVNb8LT
   mD+XEMv/+PvE8Xuj1xydkYehBs9yiuKFzz8a2nd4Q6bBV868+x9om/y8P
   b7HGxqBRgkDt0Ua94X1dGzhvxo8Qc0thtf89hnXna9EW4oZ0pM5oP3lIL
   pTVLDpFMWTusJsCwzhPCB8DoxfytQR5L/92kxUtQ5vypY9gBfYaHKAVbZ
   cYLfehyYLnqPmOWvFvaF96ONPb3ea8KVhpCfzMCJuGs8mc/GyKVH4JTSH
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="315662396"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="315662396"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 07:35:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="747395673"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="747395673"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 22 Nov 2022 07:35:00 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4E543F7; Tue, 22 Nov 2022 17:35:26 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jakob Koschel <jakobkoschel@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Cernekee <cernekee@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 2/4] usb: gadget: hid: Convert to use list_count()
Date:   Tue, 22 Nov 2022 17:35:14 +0200
Message-Id: <20221122153516.52577-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221122153516.52577-1-andriy.shevchenko@linux.intel.com>
References: <20221122153516.52577-1-andriy.shevchenko@linux.intel.com>
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
existing nodes in the list. Utilise it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v3: fixed typo in the commit message (Fabio)
v2: no change
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

