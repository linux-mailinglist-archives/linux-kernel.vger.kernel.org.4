Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3A5617D85
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiKCNJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiKCNJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:09:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AA4D62
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 06:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667480940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VWFVVjFoPh9//o9VH0sQcghYNck2hp+BNoOr8GX7Wu8=;
        b=BnZUTsbiy9wNVYaJv9C/klsJDIS3BS6CyIcqAUwQZqPoUqOhMrolM4Ax5jonL9zQLYII4I
        CbBTSlRtAgB+dhuo7ttSuUFmYfogj7v8FirW6ZmKjaUsdhzc6ofuWGvkjkBpq/davBA+sk
        RCdh+Igns8IIKM/LodNnJ3A6FVsr29M=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-564-wVY90vqTNouKqYFzQxhDow-1; Thu, 03 Nov 2022 09:08:57 -0400
X-MC-Unique: wVY90vqTNouKqYFzQxhDow-1
Received: by mail-pj1-f72.google.com with SMTP id r10-20020a17090a1bca00b002137a500398so884124pjr.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 06:08:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VWFVVjFoPh9//o9VH0sQcghYNck2hp+BNoOr8GX7Wu8=;
        b=tP7tgCv5PU/g3mcVq/Ij225gR9MafUuog0biPG++YhtdBYJLGKTaCy/J2Bmp2Qf4BQ
         ViOPt7MsssTKRuDw6pSRgGIrlK8wLCFOyWK7P/ehvwnBjQQsYw6+/t1rVOMvrGVcmKmf
         i+XbAjXtWU/Cxw8nQshMII/VCOKe5kqI0PQQqoQIIo3E4lw2qi7BBMLE5h39TEgxpC3V
         LPmWdbTbX18ssIWcPpGKbri8J6kPFTPRQgBTxtiYHoF8qhBgvhNzJIVsemLwEhDXOp1j
         hQAVGi4ir4iY2RRBcDlTGaFmXrbpKH9mQGvHNe+5Y90y4AjAzw+0LJqWDVFT009fobPO
         7Pog==
X-Gm-Message-State: ACrzQf3ZgEabQdUSYeBe6p+ZI1/lgSdXSMCL9YMKn/74uqzsBjWlj/7h
        mfhMMOTzZPweyQjK3vt4zZ12r1Ps13VfymDVrnrPPkuKDZyAeUJSdOholzzbn0Ld3avXWrszrPG
        fX/ix4WTXqxt/3zGEPt8X5N6h
X-Received: by 2002:a05:6a00:1988:b0:56d:315d:e371 with SMTP id d8-20020a056a00198800b0056d315de371mr26331621pfl.20.1667480936719;
        Thu, 03 Nov 2022 06:08:56 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6iSBF/0xkGlp5PD69KA5JXu9lEwVifRIL5cr6mlgd5MXUVIRiMLYuXynw7VvfkZ8niuZKrEw==
X-Received: by 2002:a05:6a00:1988:b0:56d:315d:e371 with SMTP id d8-20020a056a00198800b0056d315de371mr26331604pfl.20.1667480936442;
        Thu, 03 Nov 2022 06:08:56 -0700 (PDT)
Received: from ryzen.. ([240d:1a:c0d:9f00:fc9c:8ee9:e32c:2d9])
        by smtp.gmail.com with ESMTPSA id p6-20020a170902a40600b0017e232b6724sm635952plq.69.2022.11.03.06.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 06:08:55 -0700 (PDT)
From:   Shigeru Yoshida <syoshida@redhat.com>
To:     pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de
Cc:     netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Shigeru Yoshida <syoshida@redhat.com>,
        syzbot+178efee9e2d7f87f5103@syzkaller.appspotmail.com
Subject: [PATCH] netfilter: Cleanup nft_net->module_list from nf_tables_exit_net()
Date:   Thu,  3 Nov 2022 22:08:49 +0900
Message-Id: <20221103130849.1624522-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot reported a warning like below [1]:

WARNING: CPU: 3 PID: 9 at net/netfilter/nf_tables_api.c:10096 nf_tables_exit_net+0x71c/0x840
Modules linked in:
CPU: 2 PID: 9 Comm: kworker/u8:0 Tainted: G        W          6.1.0-rc3-00072-g8e5423e991e8 #47
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-1.fc36 04/01/2014
Workqueue: netns cleanup_net
RIP: 0010:nf_tables_exit_net+0x71c/0x840
...
Call Trace:
 <TASK>
 ? __nft_release_table+0xfc0/0xfc0
 ops_exit_list+0xb5/0x180
 cleanup_net+0x506/0xb10
 ? unregister_pernet_device+0x80/0x80
 process_one_work+0xa38/0x1730
 ? pwq_dec_nr_in_flight+0x2b0/0x2b0
 ? rwlock_bug.part.0+0x90/0x90
 ? _raw_spin_lock_irq+0x46/0x50
 worker_thread+0x67e/0x10e0
 ? process_one_work+0x1730/0x1730
 kthread+0x2e5/0x3a0
 ? kthread_complete_and_exit+0x40/0x40
 ret_from_fork+0x1f/0x30
 </TASK>

In nf_tables_exit_net(), there is a case where nft_net->commit_list is
empty but nft_net->module_list is not empty.  Such a case occurs with
the following scenario:

1. nfnetlink_rcv_batch() is called
2. nf_tables_newset() returns -EAGAIN and NFNL_BATCH_FAILURE bit is
   set to status
3. nf_tables_abort() is called with NFNL_ABORT_AUTOLOAD
   (nft_net->commit_list is released, but nft_net->module_list is not
   because of NFNL_ABORT_AUTOLOAD flag)
4. Jump to replay label
5. netlink_skb_clone() fails and returns from the function (this is
   caused by fault injection in the reproducer of syzbot)

This patch fixes this issue by calling __nf_tables_abort() when
nft_net->module_list is not empty in nf_tables_exit_net().

Link: https://syzkaller.appspot.com/bug?id=802aba2422de4218ad0c01b46c9525cc9d4e4aa3 [1]
Reported-by: syzbot+178efee9e2d7f87f5103@syzkaller.appspotmail.com
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 net/netfilter/nf_tables_api.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 58d9cbc9ccdc..a7579d16f59f 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -10088,7 +10088,8 @@ static void __net_exit nf_tables_exit_net(struct net *net)
 	struct nftables_pernet *nft_net = nft_pernet(net);
 
 	mutex_lock(&nft_net->commit_mutex);
-	if (!list_empty(&nft_net->commit_list))
+	if (!list_empty(&nft_net->commit_list) ||
+	    !list_empty(&nft_net->module_list))
 		__nf_tables_abort(net, NFNL_ABORT_NONE);
 	__nft_release_tables(net);
 	mutex_unlock(&nft_net->commit_mutex);
-- 
2.37.3

