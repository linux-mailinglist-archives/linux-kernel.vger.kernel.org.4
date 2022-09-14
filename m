Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5205B7DFD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 02:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiINAwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 20:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiINAwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 20:52:15 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A1A3E75B;
        Tue, 13 Sep 2022 17:52:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 43F29CE1382;
        Wed, 14 Sep 2022 00:52:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49906C433C1;
        Wed, 14 Sep 2022 00:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1663116731;
        bh=HhfvOX/urEKCqD/galW5El2921ZPvKAuj3jSUQUgd0c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LtUyuDbx4rnXrkrCZ5oYFM/E73o1qDkpaZK4tlkv0/4OEtTHYGMiqt8uicQCfwdI2
         tc5xXrvEGcLozpTNqgMMnaPdivZl2ZcwIvUK2lNGfovt4M4i0QVrmfHCc/I5wJtZQQ
         jHDF8U1rcBcvlSKgfoY4R7J5MIOf5KD06k0b2agU=
Date:   Tue, 13 Sep 2022 17:52:10 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Robert Elliott <elliott@hpe.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org
Subject: Re: [PATCH -next 1/2] x86: crypto: kmsan: revert !KMSAN
 dependencies
Message-Id: <20220913175210.50945edb0738bf95300dc500@linux-foundation.org>
In-Reply-To: <20220909095811.2166073-1-glider@google.com>
References: <20220909095811.2166073-1-glider@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  9 Sep 2022 11:58:10 +0200 Alexander Potapenko <glider@google.com> wrote:

> This patch reverts "crypto: Kconfig: fix up for "crypto: kmsan: disable
> accelerated configs under KMSAN" used by Stephen Rothwell to cleanly
> merge KMSAN patches into linux-next.
> 
> Because now arch-specific crypto configs reside in a separate Kconfig
> file, we can disable them all by adding a single !KMSAN before including
> that file (done in the following patch).
> 
> Among others, this patch reverts !KMSAN check for
> CONFIG_CRYPTO_AEGIS128_SIMD, which is ARM-only and is hence unnecessary,
> because KMSAN does not support ARM yet.

As I understand it, these patches are against linux-next and only
linux-next because they pertain to linux-next's resolution of conflicts
between the MM tree and the crypto tree?

I'm not sure how to handle that, even if anyone wants to.  How about
you send an update to
git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm's mm-unstable
branch so the code which is there makes sense?  Then we'll ask Stephen
to redo the crypto tree resolution?

