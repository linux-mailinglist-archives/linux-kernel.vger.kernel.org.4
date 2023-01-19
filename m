Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6E3674AD2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 05:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjATEgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 23:36:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjATEgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 23:36:03 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AA0BCE03
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 20:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674189241; x=1705725241;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UJGdQbNU1p0G34DMECtmIGs9ax802RzLD9JfEvjugQM=;
  b=gGBx0RE89aJJ+stryj38Y4oJjuhPBevBJtHQv1PwmIkNpHpDDN4bBu76
   oXd8zPU3S9pCY5+AkO1fnkHjlbt8mGT8SAKrU+z6dAPVOHlQSqZViVN/x
   ore0EjM+nvLipGMuLRVjrydaoomE1cY5oXOtCvd3GtAjvxDRZQXy3ar02
   rMmOgk4CVLNVE34dgTmvX3oXOzIccudXmvxGSAwYCo4zEH/+NhZFREAGL
   cZg/lGnosIKfWm5LGnjrw0IyNhehE0o+vURV9/sTQDovOjCRuLAdT4DVI
   Dk9OtgQ91/reR92Is+NyvLbFjUG6Q0HXFA0/6wW8uAq8SInd9pfx7lI9f
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="411526173"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="411526173"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 05:57:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="988993981"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="988993981"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 19 Jan 2023 05:57:15 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, elena.reshetova@intel.com,
        kirill.shutemov@linux.intel.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH v1 5/6] virtio_net: Guard against buffer length overflow in xdp_linearize_page()
Date:   Thu, 19 Jan 2023 15:57:20 +0200
Message-Id: <20230119135721.83345-6-alexander.shishkin@linux.intel.com>
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

When reassembling incoming buffers to an xdp_page, there is a potential
integer overflow in the buffer size test and trigger and out of bounds
memcpy().

Fix this by reordering the test so that both sides are of the same
signedness.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
---
 drivers/net/virtio_net.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7723b2a49d8e..dfa51dd95f63 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -751,8 +751,10 @@ static struct page *xdp_linearize_page(struct receive_queue *rq,
 
 		/* guard against a misconfigured or uncooperative backend that
 		 * is sending packet larger than the MTU.
+		 * At the same time, make sure that an especially uncooperative
+		 * backend can't overflow the test by supplying a large buflen.
 		 */
-		if ((page_off + buflen + tailroom) > PAGE_SIZE) {
+		if (buflen > PAGE_SIZE - page_off - tailroom) {
 			put_page(p);
 			goto err_buf;
 		}
-- 
2.39.0

