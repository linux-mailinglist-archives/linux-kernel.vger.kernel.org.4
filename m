Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95F074C5D4
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 17:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbjGIPUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 11:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233791AbjGIPTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 11:19:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C84A2696;
        Sun,  9 Jul 2023 08:16:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7761660C20;
        Sun,  9 Jul 2023 15:15:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B84C433CD;
        Sun,  9 Jul 2023 15:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688915737;
        bh=Iv1BFatToubikTkhf2czmBwhaxZ6c5DrTdzQrwkrpsc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j5E+idJxqKYTrmOfpt7mwQJgyXmN+s79e/paLu/x62r92UCbBz1nmfvR09F90cYcm
         +3nieeOaLzWyfaFSYno8O6T/g89cWkA06mQOylFVYbPE5kQe2LvG/AWrgeQw9s2nXN
         tzzm7kUo39xX/GENc8gYDLC9KokGbxtKaecgQUkHGv2fjrDEpEE78wThdmVu9r5+gt
         7EZ8LgU4NZuok0Y4F9H4mMFwz0h9LtwihdspVFQpHV0LeEeiI4zhdFAUvvhnLweZpO
         Mr1qNpN/lk0SBZSnEmhMtXtaEaAvEMbEa2JT59rrDNzC6jSC9BJDzbe3Zdq1XKjuAH
         j7pHBH0Y54lQQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Aditi Ghag <aditi.ghag@isovalent.com>,
        Yonghong Song <yhs@meta.com>,
        Stanislav Fomichev <sdf@google.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Sasha Levin <sashal@kernel.org>, edumazet@google.com,
        davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 04/10] bpf: tcp: Avoid taking fast sock lock in iterator
Date:   Sun,  9 Jul 2023 11:15:22 -0400
Message-Id: <20230709151528.513775-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230709151528.513775-1-sashal@kernel.org>
References: <20230709151528.513775-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.120
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aditi Ghag <aditi.ghag@isovalent.com>

[ Upstream commit 9378096e8a656fb5c4099b26b1370c56f056eab9 ]

This is a preparatory commit to replace `lock_sock_fast` with
`lock_sock`,and facilitate BPF programs executed from the TCP sockets
iterator to be able to destroy TCP sockets using the bpf_sock_destroy
kfunc (implemented in follow-up commits).

Previously, BPF TCP iterator was acquiring the sock lock with BH
disabled. This led to scenarios where the sockets hash table bucket lock
can be acquired with BH enabled in some path versus disabled in other.
In such situation, kernel issued a warning since it thinks that in the
BH enabled path the same bucket lock *might* be acquired again in the
softirq context (BH disabled), which will lead to a potential dead lock.
Since bpf_sock_destroy also happens in a process context, the potential
deadlock warning is likely a false alarm.

Here is a snippet of annotated stack trace that motivated this change:

```

Possible interrupt unsafe locking scenario:

      CPU0                    CPU1
      ----                    ----
 lock(&h->lhash2[i].lock);
                              local_bh_disable();
                              lock(&h->lhash2[i].lock);
kernel imagined possible scenario:
  local_bh_disable();  /* Possible softirq */
  lock(&h->lhash2[i].lock);
*** Potential Deadlock ***

process context:

lock_acquire+0xcd/0x330
_raw_spin_lock+0x33/0x40
------> Acquire (bucket) lhash2.lock with BH enabled
__inet_hash+0x4b/0x210
inet_csk_listen_start+0xe6/0x100
inet_listen+0x95/0x1d0
__sys_listen+0x69/0xb0
__x64_sys_listen+0x14/0x20
do_syscall_64+0x3c/0x90
entry_SYSCALL_64_after_hwframe+0x72/0xdc

bpf_sock_destroy run from iterator:

lock_acquire+0xcd/0x330
_raw_spin_lock+0x33/0x40
------> Acquire (bucket) lhash2.lock with BH disabled
inet_unhash+0x9a/0x110
tcp_set_state+0x6a/0x210
tcp_abort+0x10d/0x200
bpf_prog_6793c5ca50c43c0d_iter_tcp6_server+0xa4/0xa9
bpf_iter_run_prog+0x1ff/0x340
------> lock_sock_fast that acquires sock lock with BH disabled
bpf_iter_tcp_seq_show+0xca/0x190
bpf_seq_read+0x177/0x450

```

Also, Yonghong reported a deadlock for non-listening TCP sockets that
this change resolves. Previously, `lock_sock_fast` held the sock spin
lock with BH which was again being acquired in `tcp_abort`:

```
watchdog: BUG: soft lockup - CPU#0 stuck for 86s! [test_progs:2331]
RIP: 0010:queued_spin_lock_slowpath+0xd8/0x500
Call Trace:
 <TASK>
 _raw_spin_lock+0x84/0x90
 tcp_abort+0x13c/0x1f0
 bpf_prog_88539c5453a9dd47_iter_tcp6_client+0x82/0x89
 bpf_iter_run_prog+0x1aa/0x2c0
 ? preempt_count_sub+0x1c/0xd0
 ? from_kuid_munged+0x1c8/0x210
 bpf_iter_tcp_seq_show+0x14e/0x1b0
 bpf_seq_read+0x36c/0x6a0

bpf_iter_tcp_seq_show
   lock_sock_fast
     __lock_sock_fast
       spin_lock_bh(&sk->sk_lock.slock);
	/* * Fast path return with bottom halves disabled and * sock::sk_lock.slock held.* */

 ...
 tcp_abort
   local_bh_disable();
   spin_lock(&((sk)->sk_lock.slock)); // from bh_lock_sock(sk)

```

With the switch to `lock_sock`, it calls `spin_unlock_bh` before returning:

```
lock_sock
    lock_sock_nested
       spin_lock_bh(&sk->sk_lock.slock);
       :
       spin_unlock_bh(&sk->sk_lock.slock);
```

Acked-by: Yonghong Song <yhs@meta.com>
Acked-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
Link: https://lore.kernel.org/r/20230519225157.760788-2-aditi.ghag@isovalent.com
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp_ipv4.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index db05ab4287e30..9ac6bca83fadb 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2941,7 +2941,6 @@ static int bpf_iter_tcp_seq_show(struct seq_file *seq, void *v)
 	struct bpf_iter_meta meta;
 	struct bpf_prog *prog;
 	struct sock *sk = v;
-	bool slow;
 	uid_t uid;
 	int ret;
 
@@ -2949,7 +2948,7 @@ static int bpf_iter_tcp_seq_show(struct seq_file *seq, void *v)
 		return 0;
 
 	if (sk_fullsock(sk))
-		slow = lock_sock_fast(sk);
+		lock_sock(sk);
 
 	if (unlikely(sk_unhashed(sk))) {
 		ret = SEQ_SKIP;
@@ -2973,7 +2972,7 @@ static int bpf_iter_tcp_seq_show(struct seq_file *seq, void *v)
 
 unlock:
 	if (sk_fullsock(sk))
-		unlock_sock_fast(sk, slow);
+		release_sock(sk);
 	return ret;
 
 }
-- 
2.39.2

