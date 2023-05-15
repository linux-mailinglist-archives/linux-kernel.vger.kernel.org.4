Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66A670230A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 06:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbjEOEtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 00:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjEOEtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 00:49:31 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88A82109;
        Sun, 14 May 2023 21:49:28 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pyQ8c-00912q-Kt; Mon, 15 May 2023 12:48:47 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 15 May 2023 12:48:46 +0800
Date:   Mon, 15 May 2023 12:48:46 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org, David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andy Lutomirski <luto@amacapital.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Bob Gilligan <gilligan@arista.com>,
        Dan Carpenter <error27@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Francesco Ruggeri <fruggeri05@gmail.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ivan Delalande <colona@arista.com>,
        Leonard Crestez <cdleonard@gmail.com>,
        Salam Noureddine <noureddine@arista.com>,
        netdev@vger.kernel.org
Subject: Re: [PATCH v6 01/21] net/tcp: Prepare tcp_md5sig_pool for TCP-AO
Message-ID: <ZGG5rtuHB4lvLyKI@gondor.apana.org.au>
References: <20230512202311.2845526-1-dima@arista.com>
 <20230512202311.2845526-2-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512202311.2845526-2-dima@arista.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 09:22:51PM +0100, Dmitry Safonov wrote:
> TCP-AO, similarly to TCP-MD5, needs to allocate tfms on a slow-path,
> which is setsockopt() and use crypto ahash requests on fast paths,
> which are RX/TX softirqs. Also, it needs a temporary/scratch buffer
> for preparing the hash.
> 
> Rework tcp_md5sig_pool in order to support other hashing algorithms
> than MD5. It will make it possible to share pre-allocated crypto_ahash
> descriptors and scratch area between all TCP hash users.
> 
> Internally tcp_sigpool preferences crypto_clone_ahash() API over
> pre-allocating per-CPU crypto requests. Kudos to Herbert, who provided
> this new crypto API [1]. Currently, there's still per-CPU crypto request
> allocation fallback, that is needed for ciphers, that yet don't support
> cloning (TCP-AO requires cmac(aes128) in RFC5925).
> 
> I was a little concerned over GFP_ATOMIC allocations of ahash and
> crypto_request in RX/TX (see tcp_sigpool_start()), so I benchmarked both
> "backends" with different algorithms, using patched version of iperf3[2].
> On my laptop with i7-7600U @ 2.80GHz:
> 
>                          clone-tfm                per-CPU-requests
> TCP-MD5                  2.25 Gbits/sec           2.30 Gbits/sec
> TCP-AO(hmac(sha1))       2.53 Gbits/sec           2.54 Gbits/sec
> TCP-AO(hmac(sha512))     1.67 Gbits/sec           1.64 Gbits/sec
> TCP-AO(hmac(sha384))     1.77 Gbits/sec           1.80 Gbits/sec
> TCP-AO(hmac(sha224))     1.29 Gbits/sec           1.30 Gbits/sec
> TCP-AO(hmac(sha3-512))    481 Mbits/sec            480 Mbits/sec
> TCP-AO(hmac(md5))        2.07 Gbits/sec           2.12 Gbits/sec
> TCP-AO(hmac(rmd160))     1.01 Gbits/sec            995 Mbits/sec
> TCP-AO(cmac(aes128))     [not supporetd yet]      2.11 Gbits/sec
> 
> So, it seems that my concerns don't have strong grounds and per-CPU
> crypto_request allocation can be dropped/removed from tcp_sigpool once
> ciphers get crypto_clone_ahash() support.

This support is now in the upstream kernel.  Please let me know
if you run into any issues using it.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
