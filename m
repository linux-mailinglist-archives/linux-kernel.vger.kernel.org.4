Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E730633DCB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 14:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbiKVNf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 08:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233422AbiKVNfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 08:35:44 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D4C51C1D;
        Tue, 22 Nov 2022 05:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669124143; x=1700660143;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Yd43EAZ8yFG+UVVrj0IDOTJiGeWfCBxtGeYjjE4QLKQ=;
  b=bsahibRUZSCcBwHECal1SPvf8SRA4rF1yIOWDtOBTHX2bJCk36tN4edZ
   r8gK7YSeJgEJB6DjCnVCwHD2xQn7zszq4ooNPij+t7WmMtrZn/YxfvdJm
   kc2aFVoGYKgdByugmJBbBd4h5/U4QWdlaTjQT9UQw/+Lk7LrQittdhq0a
   ECkFQZbzjZl2jXj9VUBfWHSJ44xbdM117SLRsUHsSl7viL6lF3ZylQO1Z
   PNaDiMxyxBzC/b4dwK4BhYCValeGvBnCZWFncZ6Neb64RBn4xcSUImTRw
   9w2Ckth6aTBthpRcCOCbjiAOR2n8FK2D8cRTc8Etg0j17wilaCm+iav3f
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="311442551"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="311442551"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 05:35:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="672484471"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="672484471"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 22 Nov 2022 05:35:38 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 834A5184; Tue, 22 Nov 2022 15:36:04 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Daniel Scally <djrscally@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v4 3/4] device property: Rename goto label to be more precise
Date:   Tue, 22 Nov 2022 15:35:59 +0200
Message-Id: <20221122133600.49897-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221122133600.49897-1-andriy.shevchenko@linux.intel.com>
References: <20221122133600.49897-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the fwnode_property_match_string() the goto label out has
an additional task. Rename the label to be more precise on
what is going to happen if goto it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v4: new patch
 drivers/base/property.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index f7b5aa8fcf28..ed74083c179d 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -482,12 +482,13 @@ int fwnode_property_match_string(const struct fwnode_handle *fwnode,
 
 	ret = fwnode_property_read_string_array(fwnode, propname, values, nval);
 	if (ret < 0)
-		goto out;
+		goto out_free;
 
 	ret = match_string(values, nval, string);
 	if (ret < 0)
 		ret = -ENODATA;
-out:
+
+out_free:
 	kfree(values);
 	return ret;
 }
-- 
2.35.1

