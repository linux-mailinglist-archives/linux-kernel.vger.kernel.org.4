Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9062660A00B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 13:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiJXLQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 07:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiJXLQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 07:16:03 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642015F11D
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 04:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666610162; x=1698146162;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bjhqc5XhXHy+win/gLYj6TzJI0CmJ2ZsazUDU3tvEls=;
  b=T7sQbPBjw1rc6eBz5l/c5k1qM4+aHJqT6VAhpVvsBE5KXRs8OhpatH4O
   lHxJ1O7s74gudN/a+lA2D4s5l2dwMI+pJnvkmf3XXQNq92WatTprNongT
   UwAxRKi9+regCQyGN+UKr05s1Zzg14KtG2d0YD2L++gR4lK5AEV/2cAUw
   HSbhRJpti+DV/xl6AsIoCWRstRPRvcyVywJg4DHHgFPm79nBOLHgy3y/S
   /0QI8VEV4F5bmU2bFDzsJYoyx+pCrJp9AympWSdhD0GULGuRjdLsF/UF8
   N0bXbX+30f7R0TdVdfQ+pDTB7zpVGskMngt9bPr8WQEmc+SIARsVleFbb
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="309078117"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="309078117"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 04:16:01 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="582384741"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="582384741"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 04:16:00 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id 1D7C3201D5;
        Mon, 24 Oct 2022 14:15:58 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1omvRT-000JZQ-AC; Mon, 24 Oct 2022 14:16:27 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        David Laight <David.Laight@ACULAB.COM>
Subject: [PATCH v2 1/1] linux/container_of.h: Warn about loss of constness
Date:   Mon, 24 Oct 2022 14:16:27 +0300
Message-Id: <20221024111627.75183-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

container_of() casts the original type to another which leads to the loss
of the const qualifier if it is not specified in the caller-provided type.
This easily leads to container_of() returning a non-const pointer to a
const struct which the C compiler does not warn about.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 include/linux/container_of.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/container_of.h b/include/linux/container_of.h
index 2f4944b791b81..591db643269aa 100644
--- a/include/linux/container_of.h
+++ b/include/linux/container_of.h
@@ -13,6 +13,7 @@
  * @type:	the type of the container struct this is embedded in.
  * @member:	the name of the member within the struct.
  *
+ * WARNING: any const qualifier of @ptr is lost.
  */
 #define container_of(ptr, type, member) ({				\
 	void *__mptr = (void *)(ptr);					\
-- 
2.30.2

