Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62ED1633109
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 00:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiKUX4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 18:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbiKUX4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 18:56:13 -0500
X-Greylist: delayed 2254 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Nov 2022 15:56:10 PST
Received: from lizzy.crudebyte.com (lizzy.crudebyte.com [91.194.90.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7A51140
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 15:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
        Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
        Content-Description; bh=O2ndXwHNWzZYBOJ5a+JRMM+u+i9Ll5yf5vhTnt2nMGM=; b=gT6vu
        VeAinBNNo5tAdvTdyXmXVqultC8L6ZWB61YAijycnbdUll4k4hes2GpTHIE3N0hNDcvGBMfDe9mk2
        e2Ohw/x1pTqMthoa8v8E419LXUURYCYeAmVY6G+40DqMF5iylQPVCVPZR/Z/YG7ZI1aNutvNgK4TR
        RQQNdhfCGtvZ5dsrfP5rVwKC6Tigt+JAiqKEdpPuzAqflbG0wb2/soqw3s4V4jHduGNfB9tfCNZtd
        ErWcoo1UxodYFLhzMkIVPvQ2j/yEbSL2VNmd4atPIDIgS8nB3NcAB3SNf1+B5x834VmcuVbrNwfDO
        q5TMmYHeqy+azhGiqnIUSXu7/0ANw==;
Message-Id: <fffb512c532bf1290f0f2b1df6068b2ff6cd14c0.1669072186.git.linux_oss@crudebyte.com>
In-Reply-To: <cover.1669072186.git.linux_oss@crudebyte.com>
References: <cover.1669072186.git.linux_oss@crudebyte.com>
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
Date:   Tue, 22 Nov 2022 00:04:08 +0100
Subject: [PATCH 2/2] net/9p: fix response size check in p9_check_errors()
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

Since 60ece0833b6c (net/9p: allocate appropriate reduced message buffers)
it is no longer appropriate to check server's response size against
msize. Check against the previously allocated buffer capacity instead.

 - Omit this size check entirely for zero-copy messages, as those always
   allocate 4k (P9_ZC_HDR_SZ) linear buffers which are not used for actual
   payload and can be much bigger than 4k.

 - Replace p9_debug() by pr_err() to make sure this message is always
   printed in case this error is triggered.

 - Add 9p message type to error message to ease investigation.

Signed-off-by: Christian Schoenebeck <linux_oss@crudebyte.com>
---
 net/9p/client.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index 30dd82f49b28..63f13dd1ecff 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -514,10 +514,10 @@ static int p9_check_errors(struct p9_client *c, struct p9_req_t *req)
 	int ecode;
 
 	err = p9_parse_header(&req->rc, NULL, &type, NULL, 0);
-	if (req->rc.size >= c->msize) {
-		p9_debug(P9_DEBUG_ERROR,
-			 "requested packet size too big: %d\n",
-			 req->rc.size);
+	if (req->rc.size > req->rc.capacity && !req->rc.zc) {
+		pr_err(
+			 "requested packet size too big: %d does not fit %ld (type=%d)\n",
+			 req->rc.size, req->rc.capacity, req->rc.id);
 		return -EIO;
 	}
 	/* dump the response from server
-- 
2.30.2

