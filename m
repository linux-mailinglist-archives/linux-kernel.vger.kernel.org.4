Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D4A610973
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 07:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiJ1FCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 01:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiJ1FCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 01:02:51 -0400
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C78E1AFA92;
        Thu, 27 Oct 2022 22:02:50 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1ooHVI-007UvU-0h; Fri, 28 Oct 2022 13:02:37 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 28 Oct 2022 13:02:36 +0800
Date:   Fri, 28 Oct 2022 13:02:36 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Frederick Lawler <fred@cloudflare.com>
Cc:     davem@davemloft.net, ebiggers@google.com, hch@lst.de,
        smueller@chronox.de, dhowells@redhat.com, omosnace@redhat.com,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH 1/1] crypto: af_alg - Support symmetric encryption via
 keyring keys
Message-ID: <Y1tibAzBGI3F+6xw@gondor.apana.org.au>
References: <20221017192500.485962-1-fred@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017192500.485962-1-fred@cloudflare.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 02:25:00PM -0500, Frederick Lawler wrote:
> We want to leverage keyring to store sensitive keys, and then use those
> keys for symmetric encryption via the crypto API. Among the key types we
> wish to support are: user, logon, encrypted, and trusted.
> 
> User key types are already able to have their data copied to user space,
> but logon does not support this. Further, trusted and encrypted keys will
> return their encrypted data back to user space on read, which does not
> make them ideal for symmetric encryption.
> 
> To support symmetric encryption for these key types, add a new
> ALG_SET_KEY_BY_KEY_SERIAL setsockopt() option to the crypto API. This
> allows users to pass a key_serial_t to the crypto API to perform
> symmetric encryption. The behavior is the same as ALG_SET_KEY, but
> the crypto key data is copied in kernel space from a keyring key,
> which allows for the support of logon, encrypted, and trusted key types.
> 
> Keyring keys must have the KEY_(POS|USR|GRP|OTH)_SEARCH permission set
> to leverage this feature. This follows the asymmetric_key type where key
> lookup calls eventually lead to keyring_search_rcu() without the
> KEYRING_SEARCH_NO_CHECK_PERM flag set.
> 
> Signed-off-by: Frederick Lawler <fred@cloudflare.com>
> ---
> RFC: https://lore.kernel.org/all/20221004212927.1539105-1-fred@cloudflare.com/
> 
> We have an idea for handling the case of leaking key data with bad
> algorithms, but asymmetric keys currently have the same problem if any were
> added as a akcipher type. If KEY_*_SEARCH is not good enough, we thought
> of possibly implementing a KConfig such that we disable leaky algorithms
> when selected, or possibly the inverse where if a leaky algorithm is
> enabled, we don't allow to enable this. The problem there is now there's
> a list to maintain.
> ---
>  Documentation/crypto/userspace-if.rst |  15 ++-
>  crypto/af_alg.c                       | 135 +++++++++++++++++++++++++-
>  include/uapi/linux/if_alg.h           |   1 +
>  3 files changed, 147 insertions(+), 4 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
