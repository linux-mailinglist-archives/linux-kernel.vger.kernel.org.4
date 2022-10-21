Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32881607660
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 13:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiJULkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 07:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiJULkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 07:40:06 -0400
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641E47B798;
        Fri, 21 Oct 2022 04:39:56 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1olqMc-004e0b-3C; Fri, 21 Oct 2022 19:39:35 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 21 Oct 2022 19:39:34 +0800
Date:   Fri, 21 Oct 2022 19:39:34 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Nathan Huckleberry <nhuck@google.com>
Cc:     ebiggers@kernel.org, ardb@kernel.org, bgoncalv@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, davem@davemloft.net,
        hpa@zytor.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        x86@kernel.org
Subject: Re: [PATCH v3] crypto: x86/polyval - Fix crashes when keys are not
 16-byte aligned
Message-ID: <Y1KE9hXfmrC4JFVT@gondor.apana.org.au>
References: <Y08rHF09/qxCVK+K@sol.localdomain>
 <20221018230412.886349-1-nhuck@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018230412.886349-1-nhuck@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 04:04:12PM -0700, Nathan Huckleberry wrote:
> crypto_tfm::__crt_ctx is not guaranteed to be 16-byte aligned on x86-64.
> This causes crashes due to movaps instructions in clmul_polyval_update.
> 
> Add logic to align polyval_tfm_ctx to 16 bytes.
> 
> Fixes: 34f7f6c30112 ("crypto: x86/polyval - Add PCLMULQDQ accelerated implementation of POLYVAL")
> Reported-by: Bruno Goncalves <bgoncalv@redhat.com>
> Signed-off-by: Nathan Huckleberry <nhuck@google.com>
> ---
>  arch/x86/crypto/polyval-clmulni_glue.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
