Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C7273319A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345449AbjFPMtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234741AbjFPMt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:49:29 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE7930E8;
        Fri, 16 Jun 2023 05:49:27 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3984B1EC08FF;
        Fri, 16 Jun 2023 14:49:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1686919764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Vv2QU/w8rhSsIFn0VHIup0DFXdObdqI0RdbTGpIzqCA=;
        b=jTz5cyee918BM7iwqTLeQFV0GTHbvckxdpbSyvKThEqDaTHMZ06ZvrHtb7Oym4oz9WzGwz
        agtIQpfVq/LTxwVvRouuuMXt8dvZ+aOGhG46IbwGObFrUDpDVWuCoypZ0S+O9sfLTXSo6e
        pIV7NQ0FQwupCySUAZcRzYslr1fJTEg=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YhmmwQNjZKrT; Fri, 16 Jun 2023 12:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1686919761; bh=Vv2QU/w8rhSsIFn0VHIup0DFXdObdqI0RdbTGpIzqCA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DC7VEcHYZ+wKNEE6GHKFu6rL19uySErezSOUdl+6Zo7/qKw569+EtfBozkORqAW5Q
         OduHtPw+rzHJKU+FtIJHqBYvQL3I/eo5ltSgk3LEPfoIng36jeJa/Y+Jwq2tasQ8xz
         oVdZ1yWt1EGeirjUsOaP6xJxwo8kHpU6waoL4TvKn9hx513G2yOXmticq5NJkYxw6s
         ecReuRx58OotM/Q9hvTU/yjG6Klg/glocXBFSJwPhGdEk667Vvt3sP/ui5thpfO4U+
         QA9COn6gTMWxytPc2SrSYqmawIs+lOID8ZnTd9OiMUoIM1TXxgjq/ovzigjQ7S37oI
         d9IoOIk0tRHh8uX7WAtRSDPU92leND2m7YOVaQn9tsDgMGD0uiGgkbfHuPzElUIVaB
         xpxI0dJ5EgDycidru3bq3J/AMjkXP0Z8dUhnvHrdVJp+DphIy9jm5Pg9frnCgs7vl2
         33x/aTO1EUW/5oqSGEqgqY+UzYQshu1uOoMijlCs49iK4sSif1jjITEhrF9rbqD6sn
         ZB4OqEm0g2t6P//WeW5bljGEIMsGAEoT1zFxCkiSFGItvtzPf9OX6cy0sMSfZNAbUZ
         bgASSWxsnEj9Ih0McftCJO5LHUr8n+4LQug0FsCVNc7zWUZ9rKJ9SUPg3esu55w9sh
         bKawjxXTDHA47h/WDqzaWXRc=
Received: from zn.tnic (p200300ea971Dc5D8329c23fFFeA6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971d:c5d8:329c:23ff:fea6:a903])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4257940E018C;
        Fri, 16 Jun 2023 12:49:15 +0000 (UTC)
Date:   Fri, 16 Jun 2023 14:49:05 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the block tree
Message-ID: <20230616124905.GAZIxaQVw47RGtWHDp@fat_crate.local>
References: <20230327120017.6bb826d7@canb.auug.org.au>
 <20230327162630.wmxpycxhllt4clpt@treble>
 <20230328104719.65133586@canb.auug.org.au>
 <20230412073416.73a8ea1a@canb.auug.org.au>
 <20230411215518.u2fgi7napfcwyuce@treble>
 <4959d0b8-96fe-7fe5-8b36-7e0a266d1d17@kernel.dk>
 <20230412001400.yraku5fwsjdchxvk@treble>
 <20230412114400.GB628377@hirez.programming.kicks-ass.net>
 <20230412162517.gji52t34zlvcu5bh@treble>
 <20230616124354.GD4253@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230616124354.GD4253@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 02:43:54PM +0200, Peter Zijlstra wrote:
> I've been getting reports from some anonymous people still using ancient
> GCCs (10.4) that also need the following:
> 
> ---
> Subject: iov_iter: Mark copy_iovec_from_user() noclone
> 
> Extend commit 50f9a76ef127 ("iov_iter: Mark
> copy_compat_iovec_from_user() noinline") to also cover
> copy_iovec_from_user(). Different compiler versions cause the same
> problem on different functions.
> 
> lib/iov_iter.o: warning: objtool: .altinstr_replacement+0x1f: redundant UACCESS disable
> lib/iov_iter.o: warning: objtool: iovec_from_user+0x84: call to copy_iovec_from_user.part.0() with UACCESS enabled
> lib/iov_iter.o: warning: objtool: __import_iovec+0x143: call to copy_iovec_from_user.part.0() with UACCESS enabled
> 
> Fixes: 50f9a76ef127 ("iov_iter: Mark copy_compat_iovec_from_user() noinline")
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 960223ed9199..061cc3ed58f5 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1795,7 +1795,7 @@ static __noclone int copy_compat_iovec_from_user(struct iovec *iov,
>  	return ret;
>  }
>  
> -static int copy_iovec_from_user(struct iovec *iov,
> +static __noclone int copy_iovec_from_user(struct iovec *iov,
>  		const struct iovec __user *uiov, unsigned long nr_segs)
>  {
>  	int ret = -EFAULT;

Tested-by: Borislav Petkov (AMD) <bp@alien8.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
