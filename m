Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E05B721C97
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 05:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbjFEDf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 23:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjFEDfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 23:35:23 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F89A4;
        Sun,  4 Jun 2023 20:35:21 -0700 (PDT)
Received: from dggpeml500010.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QZK4636wlzTkjG;
        Mon,  5 Jun 2023 11:35:02 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500010.china.huawei.com
 (7.185.36.155) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 5 Jun
 2023 11:35:18 +0800
From:   Xin Liu <liuxin350@huawei.com>
To:     <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <hsinweih@uci.edu>,
        <jakub@cloudflare.com>, <john.fastabend@gmail.com>,
        <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
        <liuxin350@huawei.com>, <netdev@vger.kernel.org>,
        <pabeni@redhat.com>,
        <syzbot+49f6cef45247ff249498@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>, <yanan@huawei.com>,
        <wuchangye@huawei.com>, <xiesongyang@huawei.com>,
        <kongweibin2@huawei.com>, <zhangmingyi5@huawei.com>
Subject: [PATCH] libbpf:fix use empty function pointers in ringbuf_poll
Date:   Mon, 5 Jun 2023 11:34:49 +0800
Message-ID: <20230605033449.239123-1-liuxin350@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500010.china.huawei.com (7.185.36.155)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhangmingyi <zhangmingyi5@huawei.com>

The sample_cb of the ring_buffer__new interface can transfer NULL. However,
the system does not check whether sample_cb is NULL during 
ring_buffer__poll, null pointer is used.

Signed-off-by: zhangmingyi <zhangmingyi5@huawei.com>
---
 tools/lib/bpf/ringbuf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index 02199364db13..3661338a1d2e 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -248,7 +248,7 @@ static int64_t ringbuf_process_ring(struct ring *r)
 			got_new_data = true;
 			cons_pos += roundup_len(len);
 
-			if ((len & BPF_RINGBUF_DISCARD_BIT) == 0) {
+			if (r->sample_cb && ((len & BPF_RINGBUF_DISCARD_BIT) == 0)) {
 				sample = (void *)len_ptr + BPF_RINGBUF_HDR_SZ;
 				err = r->sample_cb(r->ctx, sample, len);
 				if (err < 0) {
-- 
2.33.0

