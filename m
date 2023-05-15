Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE7F70240B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 08:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238571AbjEOGFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 02:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238536AbjEOGFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 02:05:19 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E578D49D9;
        Sun, 14 May 2023 22:57:56 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pyRCi-0092NQ-2h; Mon, 15 May 2023 13:57:05 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 15 May 2023 13:57:04 +0800
Date:   Mon, 15 May 2023 13:57:04 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     syzbot <syzbot+a6abcf08bad8b18fd198@syzkaller.appspotmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Taehee Yoo <ap420073@gmail.com>
Cc:     bp@alien8.de, dave.hansen@linux.intel.com, davem@davemloft.net,
        hpa@zytor.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Subject: Re: [syzbot] [crypto?] general protection fault in
 __aria_aesni_avx_gfni_crypt_16way
Message-ID: <ZGHJsNY4P7yoCPDg@gondor.apana.org.au>
References: <0000000000007fa2d705fb29f046@google.com>
 <000000000000b2cbe305fbb2c9d9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000b2cbe305fbb2c9d9@google.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 14, 2023 at 08:09:50PM -0700, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    31f4104e392a Merge tag 'locking_urgent_for_v6.4_rc2' of gi..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11768616280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8bc832f563d8bf38
> dashboard link: https://syzkaller.appspot.com/bug?extid=a6abcf08bad8b18fd198
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: i386
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1737e3be280000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=149d4c06280000

...

> ----------------
> Code disassembly (best guess):
>    0:	d0 10                	rclb   (%rax)
>    2:	c4 e2 69 00 d7       	vpshufb %xmm7,%xmm2,%xmm2
>    7:	c5 11 ef ea          	vpxor  %xmm2,%xmm13,%xmm13
>    b:	c5 e9 72 d0 08       	vpsrld $0x8,%xmm0,%xmm2
>   10:	c4 e2 69 00 d7       	vpshufb %xmm7,%xmm2,%xmm2
>   15:	c5 09 ef f2          	vpxor  %xmm2,%xmm14,%xmm14
>   19:	c4 e2 79 00 d7       	vpshufb %xmm7,%xmm0,%xmm2
>   1e:	c5 01 ef fa          	vpxor  %xmm2,%xmm15,%xmm15
>   22:	c5 f9 6f 05 7a 15 c9 	vmovdqa 0xac9157a(%rip),%xmm0        # 0xac915a4
>   29:	0a
> * 2a:	c5 f9 6f 0d 6a 15 c9 	vmovdqa 0xac9156a(%rip),%xmm1        # 0xac9159c <-- trapping instruction
>   31:	0a
>   32:	c5 f9 6f 15 7a 15 c9 	vmovdqa 0xac9157a(%rip),%xmm2        # 0xac915b4
>   39:	0a
>   3a:	c5                   	.byte 0xc5
>   3b:	f9                   	stc
>   3c:	6f                   	outsl  %ds:(%rsi),(%dx)
>   3d:	1d                   	.byte 0x1d
>   3e:	52                   	push   %rdx
>   3f:	15                   	.byte 0x15

Ard, this looks like something that you recently touched.  Any
ideas what might be causing this?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
