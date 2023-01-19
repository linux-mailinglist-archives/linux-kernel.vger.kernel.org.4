Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDEB6740B4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 19:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjASSRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 13:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjASSRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 13:17:14 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970B193721
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 10:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674152230; x=1705688230;
  h=resent-from:resent-date:resent-message-id:resent-to:from:
   to:cc:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=UJGdQbNU1p0G34DMECtmIGs9ax802RzLD9JfEvjugQM=;
  b=bwMRsSVF0KO8ug6TVn2JPlp5S2PutUbXS5Fw11J7gYWFtYBNgZwnojEq
   oDYhdBM9ReZ/40NNza2SSmwC1E9rsRxh2rmFfVKuXZn5sBV2PEWL79PqB
   xhqGban8oQCNdrWYzVY771uGlGJumb4kYW8I9vdROyvEu+1cjNW3Qdtl7
   GxW88lhkvyiaVrpJyZfFPmmEGasiAoYvK1C0ebyIMiOZnUoFM/X4GmmBW
   HOZAg6MBNsuMcPcuCu33zeOHPKkxmxlw8oDwy8zyRrtjRhBQQu/x3HAko
   4jdt5l3v0NWI+Nhs/4pg3KB4ZH19122EVtG4qSepLWcSfcad8hdyJ8eUH
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="389888357"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="389888357"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 10:16:31 -0800
X-ExtLoopCount2: 2 from 10.237.72.184
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="768338522"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="768338522"
Received: from ubik.fi.intel.com (HELO ubik) ([10.237.72.184])
  by fmsmga002.fm.intel.com with ESMTP; 19 Jan 2023 10:16:30 -0800
Received: from ash by ubik with local (Exim 4.96)
        (envelope-from <alexander.shishkin@intel.com>)
        id 1pIZSN-00EPLf-25
        for linux-kernel@vger.kernel.org;
        Thu, 19 Jan 2023 20:16:11 +0200
X-Original-To: alexander.shishkin@linux.intel.com
Received: from linux.intel.com [10.54.29.200]
        by ubik.fi.intel.com with IMAP (fetchmail-6.4.29)
        for <ash@localhost> (single-drop); Thu, 19 Jan 2023 15:59:07 +0200 (EET)
Received: from fmsmga005.fm.intel.com (fmsmga005.fm.intel.com [10.253.24.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 3FE62580AE0;
        Thu, 19 Jan 2023 05:57:19 -0800 (PST)
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
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

