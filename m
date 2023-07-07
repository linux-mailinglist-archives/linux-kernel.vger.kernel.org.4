Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C6E74AC95
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 10:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbjGGINQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 04:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbjGGINP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 04:13:15 -0400
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB071FDA
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 01:13:13 -0700 (PDT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-53f06f7cc74so2204027a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 01:13:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688717593; x=1691309593;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bo4MAJ4BG1isgQnCAcKhexSWW5SZFcBYqjHiQhX1gxE=;
        b=WqUfpEL+w4rmEGWUqePdpo3bkGv64M5nsdgRtnGE89e+aQFuAD7R+XPYLNFhMVLYah
         FmWg8Lodwu53lOsUwZ+fIniNAgOR9DUASK7D+2IOHuRxkPJdzwvIktD9vW0RA7WlFvOd
         sDaqZ1MiloOGe8o2HKq3c38oMvf0f2YaIusrkFXi2rBn06jAMi66BXZsQQ6bP9qz/QAt
         fS3ix9Nq7ytnjV7o5SfoOCI020HYy6PD1OUEno4NTkgh7yv3eJGMgBchCJMx1q8bXbR2
         tQT1iUQXeLLktP/63DFss7KnAcjDj6vahyshA2/K9uTYJtmia+QnID3nlwdi2l2O5S9C
         HKxQ==
X-Gm-Message-State: ABy/qLZmVlpViLmlDYiRK5nbuf5+onyAJyTJR0srQAMAjPYB66S1Ge67
        6dhI4alqRWBlFcpEz9u3g5oIGhWmc+a0GAv+7rnEg8Fk96Q1
X-Google-Smtp-Source: APBJJlE8hdToDJUDSlXhxZYGiozwGB/sggmA9Bou6VF3XK3kUJgxxs4q8gGavIF8Kn9djr+rnYwWBB6vWfCEmjnY26ERZZsdnAjy
MIME-Version: 1.0
X-Received: by 2002:a63:b253:0:b0:553:9efa:1159 with SMTP id
 t19-20020a63b253000000b005539efa1159mr3380049pgo.0.1688717593343; Fri, 07 Jul
 2023 01:13:13 -0700 (PDT)
Date:   Fri, 07 Jul 2023 01:13:13 -0700
In-Reply-To: <2225020.1688717586@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004700d505ffe1348d@google.com>
Subject: Re: [syzbot] [crypto?] KASAN: slab-out-of-bounds Write in
 crypto_sha3_final (2)
From:   syzbot <syzbot+e436ef6c393283630f64@syzkaller.appspotmail.com>
To:     dhowells@redhat.com
Cc:     davem@davemloft.net, dhowells@redhat.com,
        herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm pretty certain this is the same as:
>
> 	https://syzkaller.appspot.com/bug?extid=689ec3afb1ef07b766b2
>
> as I sometimes see the same trace when running the reproducer from there.
> ---
>
> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

This crash does not have a reproducer. I cannot test it.

>
>     crypto: algif/hash: Fix race between MORE and non-MORE sends
>     
>     The 'MSG_MORE' state of the previous sendmsg() is fetched without the
>     socket lock held, so two sendmsg calls can race.  This can be seen with a
>     large sendfile() as that now does a series of sendmsg() calls, and if a
>     write() comes in on the same socket at an inopportune time, it can flip the
>     state.
>     
>     Fix this by moving the fetch of ctx->more inside the socket lock.
>     
>     Fixes: c662b043cdca ("crypto: af_alg/hash: Support MSG_SPLICE_PAGES")
>     Reported-by: syzbot+689ec3afb1ef07b766b2@syzkaller.appspotmail.com
>     Link: https://lore.kernel.org/r/000000000000554b8205ffdea64e@google.com/
>     Signed-off-by: David Howells <dhowells@redhat.com>
>     cc: Herbert Xu <herbert@gondor.apana.org.au>
>     cc: Paolo Abeni <pabeni@redhat.com>
>     cc: "David S. Miller" <davem@davemloft.net>
>     cc: Eric Dumazet <edumazet@google.com>
>     cc: Jakub Kicinski <kuba@kernel.org>
>     cc: linux-crypto@vger.kernel.org
>     cc: netdev@vger.kernel.org
>
> diff --git a/crypto/algif_hash.c b/crypto/algif_hash.c
> index 0ab43e149f0e..82c44d4899b9 100644
> --- a/crypto/algif_hash.c
> +++ b/crypto/algif_hash.c
> @@ -68,13 +68,15 @@ static int hash_sendmsg(struct socket *sock, struct msghdr *msg,
>  	struct hash_ctx *ctx = ask->private;
>  	ssize_t copied = 0;
>  	size_t len, max_pages, npages;
> -	bool continuing = ctx->more, need_init = false;
> +	bool continuing, need_init = false;
>  	int err;
>  
>  	max_pages = min_t(size_t, ALG_MAX_PAGES,
>  			  DIV_ROUND_UP(sk->sk_sndbuf, PAGE_SIZE));
>  
>  	lock_sock(sk);
> +	continuing = ctx->more;
> +
>  	if (!continuing) {
>  		/* Discard a previous request that wasn't marked MSG_MORE. */
>  		hash_free_result(sk, ctx);
>
