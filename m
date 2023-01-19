Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6850674ACD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 05:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjATEg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 23:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjATEgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 23:36:02 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB3DBC8B3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 20:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674189240; x=1705725240;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fPAfZ1maazfHk0jrppfuINceGDxLy9M8OHmBMIa7oqg=;
  b=kzwo2nURpl/u66qgiLGnqnJHv88xucyijmDvmMJCSceEWl5+Gy2/NtzZ
   bcWO/r2x5Q/a03W/+GcI3mJw0Rh4niwefB5IGjdPQ6NHP8pTYUGPiSwhv
   Fagsv1IBKkRMl8RIRfko4gvMOhsUqYuyMi/1hOAhMG6H2MGhxQxZTbgHR
   iIqRSKoH9RMhcwIlI4rYHKvz8n2jX2yIQIsJwoqmJ49sixnBAqgUOulSr
   wBg1mxRKOEdnxj8rsST/41iIVcTiu70bSl17b1th6HXjegDLdgaJtkrHE
   ifRTOQsYHEWKBEXOjJmXcGDhQ55h0vLJSjJ1xiPASwIov+MUTx/5doSP/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="411526128"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="411526128"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 05:57:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="988993922"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="988993922"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 19 Jan 2023 05:57:09 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, elena.reshetova@intel.com,
        kirill.shutemov@linux.intel.com, Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        v9fs-developer@lists.sourceforge.net
Subject: [PATCH v1 3/6] virtio 9p: Fix an overflow
Date:   Thu, 19 Jan 2023 15:57:18 +0200
Message-Id: <20230119135721.83345-4-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119135721.83345-1-alexander.shishkin@linux.intel.com>
References: <20230119135721.83345-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

tag_len is read as a u16 from the untrusted host. It could overflow
in the memory allocation, which would lead to a too small buffer.

Some later loops use it when extended to 32bit, so they could overflow
the too small buffer.

Make sure to do the arithmetic for the buffer size in 32bit to avoid
wrapping.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Eric Van Hensbergen <ericvh@gmail.com>
Cc: Latchesar Ionkov <lucho@ionkov.net>
Cc: Dominique Martinet <asmadeus@codewreck.org>
Cc: v9fs-developer@lists.sourceforge.net
---
 net/9p/trans_virtio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 3c27ffb781e3..a78e4d80e5ba 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -629,7 +629,7 @@ static int p9_virtio_probe(struct virtio_device *vdev)
 		err = -EINVAL;
 		goto out_free_vq;
 	}
-	tag = kzalloc(tag_len + 1, GFP_KERNEL);
+	tag = kzalloc((u32)tag_len + 1, GFP_KERNEL);
 	if (!tag) {
 		err = -ENOMEM;
 		goto out_free_vq;
-- 
2.39.0

