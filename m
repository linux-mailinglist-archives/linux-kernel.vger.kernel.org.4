Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F27D63310E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 00:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbiKUX4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 18:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbiKUX4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 18:56:35 -0500
X-Greylist: delayed 2262 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Nov 2022 15:56:19 PST
Received: from lizzy.crudebyte.com (lizzy.crudebyte.com [91.194.90.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FF695A5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 15:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
        Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
        Content-Description; bh=tgnR9mH97CXxQYgNtREObSMAVVccFgQyvaAQftuBqys=; b=E9Yu+
        lHkliZDAoyYvYAD6jturTuDXX+OCItfkoQ9Us5KZk7bSgBReREC3t2Bpcr6UkKd9ETiChHrPGOwe7
        iQS2thSmpmd9V/g5fuDg7AMtf5Q57oO1hhwBYvemFEoPKAhRJIn2bEHWfa0sAtxCPsDZy86YeWprr
        QTS3qy4ysHe2yTIoxz1pTXzQSdpnHGyJdR1GF0nszCwYRXlcng+Zf68ouQGuhrtLlxG8sOA9CoMaq
        a83gUSLgLXcojhlsPYAYwdmbh+yHprDhY0T3KqXq56VMeMuNrz+is5VOehP8KHl5NwGLBJIMkAArk
        45P4UsYoQ0jEBTmuMGC3dgI7k94YA==;
Message-Id: <5b4019594a93bc77b0e3298457c3d9ec0e08fbb5.1669072186.git.linux_oss@crudebyte.com>
In-Reply-To: <cover.1669072186.git.linux_oss@crudebyte.com>
References: <cover.1669072186.git.linux_oss@crudebyte.com>
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
Date:   Tue, 22 Nov 2022 00:03:58 +0100
Subject: [PATCH 1/2] net/9p: distinguish zero-copy requests
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

Signed-off-by: Christian Schoenebeck <linux_oss@crudebyte.com>
---
 include/net/9p/9p.h | 2 ++
 net/9p/client.c     | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/include/net/9p/9p.h b/include/net/9p/9p.h
index 13abe013af21..b0a6dec20b92 100644
--- a/include/net/9p/9p.h
+++ b/include/net/9p/9p.h
@@ -530,6 +530,7 @@ struct p9_rstatfs {
  * @tag: transaction id of the request
  * @offset: used by marshalling routines to track current position in buffer
  * @capacity: used by marshalling routines to track total malloc'd capacity
+ * @zc: whether zero-copy is used
  * @sdata: payload
  *
  * &p9_fcall represents the structure for all 9P RPC
@@ -546,6 +547,7 @@ struct p9_fcall {
 
 	size_t offset;
 	size_t capacity;
+	bool zc;
 
 	struct kmem_cache *cache;
 	u8 *sdata;
diff --git a/net/9p/client.c b/net/9p/client.c
index aaa37b07e30a..30dd82f49b28 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -680,6 +680,8 @@ p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...)
 	if (IS_ERR(req))
 		return req;
 
+	req->tc.zc = req->rc.zc = false;
+
 	if (signal_pending(current)) {
 		sigpending = 1;
 		clear_thread_flag(TIF_SIGPENDING);
@@ -778,6 +780,8 @@ static struct p9_req_t *p9_client_zc_rpc(struct p9_client *c, int8_t type,
 	if (IS_ERR(req))
 		return req;
 
+	req->tc.zc = req->rc.zc = true;
+
 	if (signal_pending(current)) {
 		sigpending = 1;
 		clear_thread_flag(TIF_SIGPENDING);
-- 
2.30.2

