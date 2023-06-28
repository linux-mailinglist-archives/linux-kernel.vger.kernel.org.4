Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76657412FD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 15:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjF1NsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 09:48:12 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:55859 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbjF1NsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 09:48:04 -0400
Received: from fsav113.sakura.ne.jp (fsav113.sakura.ne.jp [27.133.134.240])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 35SDm20A095922;
        Wed, 28 Jun 2023 22:48:02 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav113.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp);
 Wed, 28 Jun 2023 22:48:02 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 35SDm2QM095917
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 28 Jun 2023 22:48:02 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <c16e9ab9-13e0-b911-e33a-c9ae81e93a8d@I-love.SAKURA.ne.jp>
Date:   Wed, 28 Jun 2023 22:48:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: [PATCH] net: tls: enable __GFP_ZERO upon tls_init()
Content-Language: en-US
To:     Boris Pismenny <borisp@nvidia.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     glider@google.com, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+828dfc12440b4f6f305d@syzkaller.appspotmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Aviad Yehezkel <aviadye@nvidia.com>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>
References: <0000000000008a7ae505aef61db1@google.com>
 <20200911170150.GA889@sol.localdomain>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20200911170150.GA889@sol.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot is reporting uninit-value at aes_encrypt(), for block cipher assumes
that bytes to encrypt/decrypt is multiple of block size for that cipher but
tls_alloc_encrypted_msg() is not initializing padding bytes when
required_size is not multiple of block cipher's block size.

In order to make sure that padding bytes are automatically initialized,
enable __GFP_ZERO flag when setsockopt(SOL_TCP, TCP_ULP, "tls") is called.

Reported-by: syzbot <syzbot+828dfc12440b4f6f305d@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=828dfc12440b4f6f305d
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
According to C reproducer, this problem happens when bpf_exec_tx_verdict() is
called with lower 4 bits of required_size being 0001 and does not happen when
being 0100. Thus, I assumed that this problem is caused by lack of initializing
padding bytes.
But I couldn't figure out why KMSAN reports this problem when bpf_exec_tx_verdict()
is called with lower 4 bits of required_size being 0001 for the second time and
does not report this problem when bpf_exec_tx_verdict() is called with lower
4 bits of required_size being 0001 for the first time. More deeper problem exists?
KMSAN reporting this problem when accessing u64 relevant?

 net/tls/tls_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index f2e7302a4d96..cd5366966864 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -1025,6 +1025,7 @@ static int tls_init(struct sock *sk)
 	struct tls_context *ctx;
 	int rc = 0;
 
+	sk->sk_allocation |= __GFP_ZERO;
 	tls_build_proto(sk);
 
 #ifdef CONFIG_TLS_TOE
-- 
2.34.1

