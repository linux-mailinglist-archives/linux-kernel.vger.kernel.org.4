Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197946E7253
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 06:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbjDSEfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 00:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjDSEfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 00:35:34 -0400
X-Greylist: delayed 1710 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 18 Apr 2023 21:35:32 PDT
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [221.12.31.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3937E7297
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 21:35:31 -0700 (PDT)
Received: from h3cspam02-ex.h3c.com (localhost [127.0.0.2] (may be forged))
        by h3cspam02-ex.h3c.com with ESMTP id 33J46x6Q095474
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 12:06:59 +0800 (GMT-8)
        (envelope-from zhang.zhengming@h3c.com)
Received: from mail.maildlp.com ([172.25.15.154])
        by h3cspam02-ex.h3c.com with ESMTP id 33J469be094211;
        Wed, 19 Apr 2023 12:06:09 +0800 (GMT-8)
        (envelope-from zhang.zhengming@h3c.com)
Received: from DAG2EX07-IDC.srv.huawei-3com.com (unknown [172.20.54.130])
        by mail.maildlp.com (Postfix) with ESMTP id 7012522EB027;
        Wed, 19 Apr 2023 12:10:33 +0800 (CST)
Received: from localhost.localdomain (10.99.222.162) by
 DAG2EX07-IDC.srv.huawei-3com.com (172.20.54.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.6; Wed, 19 Apr 2023 12:06:08 +0800
From:   zhangzhengming <zhang.zhengming@h3c.com>
To:     <akpm@linux-foundation.org>, <surenb@google.com>,
        <wuchi.zero@gmail.com>, <Ilia.Gavrilov@infotecs.ru>,
        <xu.panda@zte.com.cn>, <colin.i.king@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <zhou.kete@h3c.com>,
        Zhang Zhengming <zhang.zhengming@h3c.com>
Subject: [PATCH] relayfs: fix out-of-bounds access in relay_file_read
Date:   Wed, 19 Apr 2023 12:02:03 +0800
Message-ID: <20230419040203.37676-1-zhang.zhengming@h3c.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.99.222.162]
X-ClientProxiedBy: BJSMTP01-EX.srv.huawei-3com.com (10.63.20.132) To
 DAG2EX07-IDC.srv.huawei-3com.com (172.20.54.130)
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: h3cspam02-ex.h3c.com 33J46x6Q095474
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Zhengming <zhang.zhengming@h3c.com>

There is a crash in relay_file_read, as the var from 
point to the end of last subbuf.
The oops looks something like:
pc : __arch_copy_to_user+0x180/0x310
lr : relay_file_read+0x20c/0x2c8
Call trace:
 __arch_copy_to_user+0x180/0x310
 full_proxy_read+0x68/0x98
 vfs_read+0xb0/0x1d0
 ksys_read+0x6c/0xf0
 __arm64_sys_read+0x20/0x28
 el0_svc_common.constprop.3+0x84/0x108
 do_el0_svc+0x74/0x90
 el0_svc+0x1c/0x28
 el0_sync_handler+0x88/0xb0
 el0_sync+0x148/0x180

We get the condition by analyzing the vmcore:
1). The last produced byte and last consumed byte
    both at the end of the last subbuf
2). A softirq who will call function(e.g __blk_add_trace)
    to write relay buffer occurs when an program calling
    function relay_file_read_avail.
        relay_file_read
                relay_file_read_avail
                        relay_file_read_consume(buf, 0, 0);
                        //interrupted by softirq who will write subbuf
                        ....
                        return 1;
                //read_start point to the end of the last subbuf
                read_start = relay_file_read_start_pos
                //avail is equal to subsize
                avail = relay_file_read_subbuf_avail
                //from  points to an invalid memory address             
                from = buf->start + read_start
                //system is crashed
                copy_to_user(buffer, from, avail)

Signed-off-by: Zhang Zhengming <zhang.zhengming@h3c.com>
Reviewed-by: Zhao Lei <zhao_lei1@hoperun.com>
Reviewed-by: Zhou Kete <zhou.kete@h3c.com>
---
 kernel/relay.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/relay.c b/kernel/relay.c
index 9aa70ae..a80fa01 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -989,7 +989,8 @@ static size_t relay_file_read_start_pos(struct rchan_buf *buf)
 	size_t subbuf_size = buf->chan->subbuf_size;
 	size_t n_subbufs = buf->chan->n_subbufs;
 	size_t consumed = buf->subbufs_consumed % n_subbufs;
-	size_t read_pos = consumed * subbuf_size + buf->bytes_consumed;
+	size_t read_pos = (consumed * subbuf_size + buf->bytes_consumed)
+			% (n_subbufs * subbuf_size);
 
 	read_subbuf = read_pos / subbuf_size;
 	padding = buf->padding[read_subbuf];
-- 
2.17.1

