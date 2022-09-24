Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDEBA5E8919
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 09:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbiIXHZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 03:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbiIXHZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 03:25:35 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7781E12AE9;
        Sat, 24 Sep 2022 00:24:35 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1obzWU-007vmx-Ty; Sat, 24 Sep 2022 17:24:28 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 24 Sep 2022 15:24:26 +0800
Date:   Sat, 24 Sep 2022 15:24:26 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ignat Korchagin <ignat@cloudflare.com>,
        David Howells <dhowells@redhat.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        lei he <helei.sig11@bytedance.com>, kernel-team@cloudflare.com
Subject: Re: [PATCH 0/4] crypto: add ECDSA signature support to key retention
 service
Message-ID: <Yy6wqqVpUCeQKrdh@gondor.apana.org.au>
References: <20220908200036.2034-1-ignat@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908200036.2034-1-ignat@cloudflare.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2022 at 09:00:32PM +0100, Ignat Korchagin wrote:
> Kernel Key Retention Service[1] is a useful building block to build secure
> production key management systems. One of its interesting features is
> support for asymmetric keys: we can allow a process to use a certain key
> (decrypt or sign data) without actually allowing the process to read the
> cryptographic key material. By doing so we protect our code from certain
> type of attacks, where a process memory memory leak actually leaks a
> potentially highly sensitive cryptographic material.
> 
> But unfortunately only RSA algorithm was supported until now, because
> in-kernel ECDSA implementation supported signature verifications only.
> 
> This patchset implements in-kernel ECDSA signature generation and adds
> support for ECDSA signing in the key retention service. The key retention
> service support was taken out of a previous unmerged patchset from Lei He[2]
> 
> [1]: https://www.kernel.org/doc/html/latest/security/keys/core.html
> [2]: https://patchwork.kernel.org/project/linux-crypto/list/?series=653034&state=*
> 
> Ignat Korchagin (2):
>   crypto: add ECDSA signature generation support
>   crypto: add ECDSA test vectors from RFC 6979
> 
> lei he (2):
>   crypto: pkcs8 parser support ECDSA private keys
>   crypto: remove unused field in pkcs8_parse_context
> 
>  crypto/Kconfig                        |   3 +-
>  crypto/Makefile                       |   4 +-
>  crypto/asymmetric_keys/pkcs8.asn1     |   2 +-
>  crypto/asymmetric_keys/pkcs8_parser.c |  46 +++-
>  crypto/ecc.c                          |   9 +-
>  crypto/ecdsa.c                        | 373 +++++++++++++++++++++++++-
>  crypto/ecprivkey.asn1                 |   6 +
>  crypto/testmgr.c                      |  18 ++
>  crypto/testmgr.h                      | 333 +++++++++++++++++++++++
>  include/crypto/internal/ecc.h         |  11 +
>  10 files changed, 788 insertions(+), 17 deletions(-)
>  create mode 100644 crypto/ecprivkey.asn1
> 
> --
> 2.36.1

I need acks for patches 3-4 from David.  Thanks!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
