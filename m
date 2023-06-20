Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6E973716A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 18:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjFTQZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 12:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbjFTQY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 12:24:58 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95EBCE2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 09:24:56 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f8ff5fe50aso30504765e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 09:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687278295; x=1689870295;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hA3RnC1YrQnjyOpyQESOVWrplFY8MJ/sBMjrQnH7QIE=;
        b=WjSm3b/Az0wfDz0jrwLWFY5qRtSeJuViWVvV9AQbFz0JMMYuS5PXqYnoBAqCgZVk0p
         z+uAstrLNiWrTXLPDCwmiNZWftiqP2EhVSiYXs44Fd/rLUHeUXUTvthdyVSDPaaNrzp9
         j38zN5XnguARCr4JyjYrLZDYI8KAtFo3MfBAX62EmIkoOtNBpWtcmQhMbcuSrBGmMofn
         Eyx3TGuO9Wp9LOLGWnUK1/5f1HSWUQ6sbGSin8MovuiTd93uKshiZzztPGatzoXSmy/L
         vvOrCIiGY3FVbncxaltI7m12zJn7UOhkezlphok8EG+asHjDs/bKz/mLh6gXs0bPaD+J
         f8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687278295; x=1689870295;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hA3RnC1YrQnjyOpyQESOVWrplFY8MJ/sBMjrQnH7QIE=;
        b=dh8PQFbpQWea0wChh2Rvpe0Cyl5rEKjrOzNspGOJydRrabVrjtayJi8Pv1rfn4etua
         tylPp4R9pu01o6MuBazPHOyyRsKCiP/aDRTHw+i19tXrNfjo/cSbv2/w3mwEfDYoYSTm
         fIBca8FTmoqv3V0q9IT4NoP3pTjX/0uiaJEaAmI8Ay+fEZosQUusun6frxqp5LWUuf2u
         0Ul27IOx+5QHTaZZdglOCGr5YEEM3m+xsAuN7Wy9jMjyF3VEhQ+Munm6PORQ6c2LZwg9
         8d19w5io13VvJcxXfF03vwFMZxyHF7yTtT8BdCh0K+/mZiMwxIr7CaQMfj9ND7huQKo2
         oCyw==
X-Gm-Message-State: AC+VfDyVQS9GS9bLcWMHOBPUDJ807X0elfP9Aclk0uUJNoc+n4eAWh+f
        S+tTj+yBtHy8fbrFcYgZWc4eFQ==
X-Google-Smtp-Source: ACHHUZ6ZOY4949XEePqmejwhQuU/+GkM9lf9Kw9b1kwgpzzTRLArB4c3EDmY+99EAttggfiYN39mGA==
X-Received: by 2002:a05:600c:10d1:b0:3f7:a20a:561d with SMTP id l17-20020a05600c10d100b003f7a20a561dmr11868460wmd.8.1687278295177;
        Tue, 20 Jun 2023 09:24:55 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id o19-20020a05600c511300b003f8fe1933e4sm15753056wms.3.2023.06.20.09.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 09:24:54 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Tue, 20 Jun 2023 18:24:19 +0200
Subject: [PATCH net 2/6] mptcp: fix possible divide by zero in recvmsg()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-upstream-net-20230620-misc-fixes-for-v6-4-v1-2-f36aa5eae8b9@tessares.net>
References: <20230620-upstream-net-20230620-misc-fixes-for-v6-4-v1-0-f36aa5eae8b9@tessares.net>
In-Reply-To: <20230620-upstream-net-20230620-misc-fixes-for-v6-4-v1-0-f36aa5eae8b9@tessares.net>
To:     mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Florian Westphal <fw@strlen.de>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        stable@vger.kernel.org, Christoph Paasch <cpaasch@apple.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4187;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=gwVsKOeSZ1Q+DNvnQCcm5V3d+d0+4Ts5y6w6X+1gntE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkkdLTLFp+cfdlLpcmh0BNgwoPXpEKhr2Gxlwzb
 qh7VwYaeBuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZJHS0wAKCRD2t4JPQmmg
 c9Y/EADqzILQvimS78/K+siLruTeM2fmt1t16tCRlEuNtGvfRb+ZERBnYKRVm46K8Uk92XTzbGZ
 V3FUtCpbNrZH3lOLvCyz3sI52Y6WHpKBTTDV7dvanNgx7Illq31BPeeKg2PKQtN4mHUg4wst8gh
 3dxHdTaQ/q60K4XsK1huacMnizrIJjHJ5K5gFWTcOdYndCOwLkh68EK9Bf2dC7L998rqqHnl2yP
 qwqHkRhcmfjHf5MpD5wRaOk+oWS9bOCY+g2C0ApynfSihI/ckE7+pdMfy8P9dT5m/NgdVr/UIfS
 9499MsI36fPRw3G7B9330xo+1QE0/y7yUB9FTi0s+1lGJQ7OxslHgEUaREA07kHFwWARTfOI808
 oZTTCTLyVF6ITUK+eAPv7tuja8FADHI59ncdMHUTUk2tpPGqxsSg0b3WcXML4c5WTIhOHBVqa+I
 c1ymhyNdvrdZJfnccGeAZPqpPBzum67i71LrW000toLGu7ZRDpixcC2UZXbHllJXtVFkpDiQg+M
 ukJiQc+I4aqDs2ClmqQYE3cnPIpLzEhxFXzo8bMuepxnHbhfYlVq1iqvbPiJ/kFtbtcUJcNDyyC
 K/TXJI5c4DNC4lsDkPhjeynPzPOls20yuTI+fnoPpLt76syz6lWkhVrl/wMW640xLZdus/0I+CX
 4aPcklDYq7C3poA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Abeni <pabeni@redhat.com>

Christoph reported a divide by zero bug in mptcp_recvmsg():

divide error: 0000 [#1] PREEMPT SMP
CPU: 1 PID: 19978 Comm: syz-executor.6 Not tainted 6.4.0-rc2-gffcc7899081b #20
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2.el7 04/01/2014
RIP: 0010:__tcp_select_window+0x30e/0x420 net/ipv4/tcp_output.c:3018
Code: 11 ff 0f b7 cd c1 e9 0c b8 ff ff ff ff d3 e0 89 c1 f7 d1 01 cb 21 c3 eb 17 e8 2e 83 11 ff 31 db eb 0e e8 25 83 11 ff 89 d8 99 <f7> 7c 24 04 29 d3 65 48 8b 04 25 28 00 00 00 48 3b 44 24 10 75 60
RSP: 0018:ffffc90000a07a18 EFLAGS: 00010246
RAX: 000000000000ffd7 RBX: 000000000000ffd7 RCX: 0000000000040000
RDX: 0000000000000000 RSI: 000000000003ffff RDI: 0000000000040000
RBP: 000000000000ffd7 R08: ffffffff820cf297 R09: 0000000000000001
R10: 0000000000000000 R11: ffffffff8103d1a0 R12: 0000000000003f00
R13: 0000000000300000 R14: ffff888101cf3540 R15: 0000000000180000
FS:  00007f9af4c09640(0000) GS:ffff88813bd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b33824000 CR3: 000000012f241001 CR4: 0000000000170ee0
Call Trace:
 <TASK>
 __tcp_cleanup_rbuf+0x138/0x1d0 net/ipv4/tcp.c:1611
 mptcp_recvmsg+0xcb8/0xdd0 net/mptcp/protocol.c:2034
 inet_recvmsg+0x127/0x1f0 net/ipv4/af_inet.c:861
 ____sys_recvmsg+0x269/0x2b0 net/socket.c:1019
 ___sys_recvmsg+0xe6/0x260 net/socket.c:2764
 do_recvmmsg+0x1a5/0x470 net/socket.c:2858
 __do_sys_recvmmsg net/socket.c:2937 [inline]
 __se_sys_recvmmsg net/socket.c:2953 [inline]
 __x64_sys_recvmmsg+0xa6/0x130 net/socket.c:2953
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x47/0xa0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x72/0xdc
RIP: 0033:0x7f9af58fc6a9
Code: 5c c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 4f 37 0d 00 f7 d8 64 89 01 48
RSP: 002b:00007f9af4c08cd8 EFLAGS: 00000246 ORIG_RAX: 000000000000012b
RAX: ffffffffffffffda RBX: 00000000006bc050 RCX: 00007f9af58fc6a9
RDX: 0000000000000001 RSI: 0000000020000140 RDI: 0000000000000004
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000f00 R11: 0000000000000246 R12: 00000000006bc05c
R13: fffffffffffffea8 R14: 00000000006bc050 R15: 000000000001fe40
 </TASK>

mptcp_recvmsg is allowed to release the msk socket lock when
blocking, and before re-acquiring it another thread could have
switched the sock to TCP_LISTEN status - with a prior
connect(AF_UNSPEC) - also clearing icsk_ack.rcv_mss.

Address the issue preventing the disconnect if some other process is
concurrently performing a blocking syscall on the same socket, alike
commit 4faeee0cf8a5 ("tcp: deny tcp_disconnect() when threads are waiting").

Fixes: a6b118febbab ("mptcp: add receive buffer auto-tuning")
Cc: stable@vger.kernel.org
Reported-by: Christoph Paasch <cpaasch@apple.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/404
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Tested-by: Christoph Paasch <cpaasch@apple.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/protocol.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 86f8a7621aff..ee357700b27b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3082,6 +3082,12 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
+	/* Deny disconnect if other threads are blocked in sk_wait_event()
+	 * or inet_wait_for_connect().
+	 */
+	if (sk->sk_wait_pending)
+		return -EBUSY;
+
 	/* We are on the fastopen error path. We can't call straight into the
 	 * subflows cleanup code due to lock nesting (we are already under
 	 * msk->firstsocket lock).
@@ -3148,6 +3154,7 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 		inet_sk(nsk)->pinet6 = mptcp_inet6_sk(nsk);
 #endif
 
+	nsk->sk_wait_pending = 0;
 	__mptcp_init_sock(nsk);
 
 	msk = mptcp_sk(nsk);

-- 
2.40.1

