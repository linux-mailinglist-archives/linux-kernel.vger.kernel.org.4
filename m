Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB0468A813
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 05:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbjBDEGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 23:06:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbjBDEGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 23:06:48 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EAB93E3F
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 20:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675483607; x=1707019607;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=T75P/a7C6FXtvE4L4LzphFH5nPphv2diXLDPq5xM7Wg=;
  b=YiTweZh0+aAllsHYnxB5tuEiSQNHdILndxAPsmHkbAV50pdeP4/Gv5j9
   h8OwNVnX9q57Z5upohu4oRxYZDG6m/Y1yFyBPA1GAHjR4cCnWsiZS0seg
   APZ3pQ4u5dpNMbbrKDkjGQq4I52WCvAfnJzqtci6fgkDWUWgikkTzj9DD
   Wf9cSSDd90LzJykVTMc5CsKECzKD+B2/bP4WCDSeIb0EYdclMSqOMX5Z2
   53MeqiEjU2YI6IgJyEtJMtyGydMXtrOmMyXhf8Ktq9gwTKuISGYfJPE/2
   mDUPWObWv/N9NLtxYYByZTJszQ2B55qjhxSCZu2GCfJgvANnbj0lPj/RN
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="391309354"
X-IronPort-AV: E=Sophos;i="5.97,272,1669104000"; 
   d="scan'208";a="391309354"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 20:06:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="734573722"
X-IronPort-AV: E=Sophos;i="5.97,272,1669104000"; 
   d="scan'208";a="734573722"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.209.125.166])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 20:06:45 -0800
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Fri, 03 Feb 2023 20:06:32 -0800
Subject: [PATCH v2 1/4] highmem: Enhance is_kmap_addr() to check
 kmap_local_page() mappings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230203-get_kernel_pages-v2-1-f1dc4af273f1@intel.com>
References: <20230203-get_kernel_pages-v2-0-f1dc4af273f1@intel.com>
In-Reply-To: <20230203-get_kernel_pages-v2-0-f1dc4af273f1@intel.com>
To:     Sumit Garg <sumit.garg@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        linux-mm@kvack.org, Jens Wiklander <jens.wiklander@linaro.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
X-Mailer: b4 0.12-dev-cc11a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1675483603; l=1291;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=T75P/a7C6FXtvE4L4LzphFH5nPphv2diXLDPq5xM7Wg=;
 b=0B27CfriIJ0dEfMl8Am+J8B+vWOf/F2xdBWsw+oYNclAM5NadCqEGNnPN+iFuLdkXLXByDbAxosU
 okv9YtfrCVqkAntku9KClpR74B47/CFM0FjeMzURUnTIqo2RDh/w
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index e098f38422af..a3028e400a9c 100644
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
2.39.1
