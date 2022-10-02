Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185DA5F20B9
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 02:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiJBAXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 20:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiJBAXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 20:23:31 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3975753024
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 17:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664670211; x=1696206211;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LtFIt5FTKyNGfjeUxeseV6vRVd/REofNRZov49L9ZaM=;
  b=K44iPsYRwI1upZwOhQlaY4wj+HvdFNJHf7Ocmnu06smDL/CgWMO9e23o
   U1mmnWlg0Bu3UUDN3INYrS2pwcaEBpKauoDTFbF1ZuywXbVtmqCcOp+d5
   KWe0qdHQS4EDLrrW/jHN+u+zEbbkjAgeNUlSQUMWq2YBCXVBpRvkqPLpL
   elheVRYdUUb0+ifPko+3fayw+sDE08HpDqjE+tV83aQ7JmxCIIieVpJIh
   Pk/GjFFWwqy1FeprAE/8y6lIHLqc4CooI1Ihl/Y6mNgaxGpWsVk+mYKRi
   PNJF1TeCF74Ec0FBG7zJ0UKh5sf0xVcpJfEJ62716ZAadl4yUJHCZe3iq
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10487"; a="285564519"
X-IronPort-AV: E=Sophos;i="5.93,361,1654585200"; 
   d="scan'208";a="285564519"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2022 17:23:30 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10487"; a="656347031"
X-IronPort-AV: E=Sophos;i="5.93,361,1654585200"; 
   d="scan'208";a="656347031"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.213.181.73])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2022 17:23:30 -0700
From:   ira.weiny@intel.com
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 1/4] highmem: Enhance is_kmap_addr() to check kmap_local_page() mappings
Date:   Sat,  1 Oct 2022 17:23:23 -0700
Message-Id: <20221002002326.946620-2-ira.weiny@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221002002326.946620-1-ira.weiny@intel.com>
References: <20221002002326.946620-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

is_kmap_addr() is only looking at the kmap() address range which may
cause check_heap_object() to miss checking an overflow on a
kmap_local_page() page.

Add a check for the kmap_local_page() address range to is_kmap_addr().

Cc: Matthew Wilcox <willy@infradead.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 include/linux/highmem-internal.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/highmem-internal.h b/include/linux/highmem-internal.h
index 034b1106d022..5fd5cb58f109 100644
--- a/include/linux/highmem-internal.h
+++ b/include/linux/highmem-internal.h
@@ -152,7 +152,10 @@ static inline void totalhigh_pages_add(long count)
 static inline bool is_kmap_addr(const void *x)
 {
 	unsigned long addr = (unsigned long)x;
-	return addr >= PKMAP_ADDR(0) && addr < PKMAP_ADDR(LAST_PKMAP);
+
+	return (addr >= PKMAP_ADDR(0) && addr < PKMAP_ADDR(LAST_PKMAP)) ||
+		(addr >= __fix_to_virt(FIX_KMAP_END) &&
+		 addr < __fix_to_virt(FIX_KMAP_BEGIN));
 }
 #else /* CONFIG_HIGHMEM */
 
-- 
2.37.2

