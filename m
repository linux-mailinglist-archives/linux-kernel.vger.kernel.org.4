Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F302263452B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 21:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbiKVUId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 15:08:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbiKVUIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 15:08:31 -0500
X-Greylist: delayed 2102 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Nov 2022 12:08:29 PST
Received: from lizzy.crudebyte.com (lizzy.crudebyte.com [91.194.90.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315E060689
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 12:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
        Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
        Content-Description; bh=RO9sw++pfIwBQdkuVrGjUBNV/KCLhBvtU55dRc8P7k8=; b=SEDZw
        uJPp3QAdKV2/6R69RAmA2HRkixKOkz0+jR19ECNUXvqsSL6i2E3aamX7XldA0sdG46uR2X5/ehEdV
        eZoeBcw145ak0lHUN9vdkr0oB5QkX4p8D7oRju6wZUzxBN6IBxbJ6CQ6gZ48uHwEBPCIz8djTg/eT
        ELv1xOnFQ3GYraTqq9xrSu0gh/R9NSCK6kSbP/rDdQMKQ3gVg96O9EKv98wD2ZMflzzkTOwMBBCpB
        kx7pPsWvXKnTgNTXMzwM3paxurtqMkJdEtLQ5Z7368M2rpuxNyCCKT2qkj2R4DTy2rc2POpetL+O+
        8S1+NAtLQ45UHlmK2taD/jO2NWV3Q==;
Message-Id: <e0edec84b1c80119ae937ce854b4f5f6dbe2d08c.1669144861.git.linux_oss@crudebyte.com>
In-Reply-To: <cover.1669144861.git.linux_oss@crudebyte.com>
References: <cover.1669144861.git.linux_oss@crudebyte.com>
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
Date:   Tue, 22 Nov 2022 20:20:29 +0100
Subject: [PATCH v2 2/2] net/9p: fix response size check in p9_check_errors()
To:     Dominique Martinet <asmadeus@codewreck.org>,
        Stefano Stabellini <sstabellini@kernel.org>
Cc:     v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        GUO Zihua <guozihua@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 60ece0833b6c ("net/9p: allocate appropriate reduced message
buffers") it is no longer appropriate to check server's response size
against msize. Check against the previously allocated buffer capacity
instead.

- Omit this size check entirely for zero-copy messages, as those always
  allocate 4k (P9_ZC_HDR_SZ) linear buffers which are not used for actual
  payload and can be much bigger than 4k.

- Replace p9_debug() by pr_err() to make sure this message is always
  printed in case this error is triggered.

- Add 9p message type to error message to ease investigation.

Signed-off-by: Christian Schoenebeck <linux_oss@crudebyte.com>
Tested-by: Stefano Stabellini <sstabellini@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
---
 net/9p/client.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index c7935e392812..0ff25c2157ab 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -514,10 +514,9 @@ static int p9_check_errors(struct p9_client *c, struct p9_req_t *req)
 	int ecode;
 
 	err = p9_parse_header(&req->rc, NULL, &type, NULL, 0);
-	if (req->rc.size >= c->msize) {
-		p9_debug(P9_DEBUG_ERROR,
-			 "requested packet size too big: %d\n",
-			 req->rc.size);
+	if (req->rc.size > req->rc.capacity && !req->rc.zc) {
+		pr_err("requested packet size too big: %d does not fit %zu (type=%d)\n",
+		       req->rc.size, req->rc.capacity, req->rc.id);
 		return -EIO;
 	}
 	/* dump the response from server
-- 
2.30.2

