Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44673638691
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 10:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiKYJr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 04:47:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiKYJrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 04:47:00 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81683E098;
        Fri, 25 Nov 2022 01:45:48 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oyVH4-000hxk-AD; Fri, 25 Nov 2022 17:45:35 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 25 Nov 2022 17:45:34 +0800
Date:   Fri, 25 Nov 2022 17:45:34 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        Nicolai Stange <nstange@suse.de>,
        Martin Doucha <mdoucha@suse.cz>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] padata: Always leave BHs disabled when running
 ->parallel()
Message-ID: <Y4COvhZ6hqPK6hBT@gondor.apana.org.au>
References: <20221117012802.62504-1-daniel.m.jordan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117012802.62504-1-daniel.m.jordan@oracle.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 08:28:02PM -0500, Daniel Jordan wrote:
> A deadlock can happen when an overloaded system runs ->parallel() in the
> context of the current task:
> 
>     padata_do_parallel
>       ->parallel()
>         pcrypt_aead_enc/dec
>           padata_do_serial
>             spin_lock(&reorder->lock) // BHs still enabled
>               <interrupt>
>                 ...
>                   __do_softirq
>                     ...
>                       padata_do_serial
>                         spin_lock(&reorder->lock)
> 
> It's a bug for BHs to be on in _do_serial as Steffen points out, so
> ensure they're off in the "current task" case like they are in
> padata_parallel_worker to avoid this situation.
> 
> Reported-by: syzbot+bc05445bc14148d51915@syzkaller.appspotmail.com
> Fixes: 4611ce224688 ("padata: allocate work structures for parallel jobs from a pool")
> Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> Acked-by: Steffen Klassert <steffen.klassert@secunet.com>
> ---
> 
> About the potential deadlock in padata_find_next(), I think this fix
> covers us there since that function is only called from
> padata_do_serial(), where BHs should now always be off, or
> invoke_padata_reorder(), where BHs are off as well.  The _bh spinlock
> variants in padata_reorder() seem redundant.
> 
>  kernel/padata.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
