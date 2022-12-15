Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E92064E301
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 22:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiLOVWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 16:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiLOVWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 16:22:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1252D6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 13:22:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49ED561F1F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 21:22:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62755C433D2;
        Thu, 15 Dec 2022 21:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1671139357;
        bh=zbIyW6IxeKD2HydxptNfmQ9f408xfblS77FoSfDXhoQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MfAzS0Dwhw6jr1ddIb38y+X/5DMS0034FSBQ/4BWmnEjXALKeNBFsOuP1E9DPn2c+
         L7UJfNTy4zgpD+clLXMLaHu7y12vM1g0Bj6omFkJdN2n/zaA0lbdkRn0VZVAE4VJ4H
         XMmf4/3zCOJrV8y7MPoDYcrj1hPn+ZK37d+NIe/o=
Date:   Thu, 15 Dec 2022 13:22:36 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Anastasia Belova <abelova@astralinux.ru>
Cc:     Max Filippov <jcmvbkbc@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        Vineet Gupta <vgupta@kernel.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Geert Uytterhoeven <geert@linux-m68k.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] mm: Add check for NULL for unlocked in fixup_user_fault
Message-Id: <20221215132236.195e6f3ac1e1cc4e9e012c8f@linux-foundation.org>
In-Reply-To: <20221215093930.22026-1-abelova@astralinux.ru>
References: <20221215093930.22026-1-abelova@astralinux.ru>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Dec 2022 12:39:30 +0300 Anastasia Belova <abelova@astralinux.ru> wrote:

> Check unlocked for NULL before dereference.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> ...
>
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1282,7 +1282,8 @@ int fixup_user_fault(struct mm_struct *mm,
>  		 * could tell the callers so they do not need to unlock.
>  		 */
>  		mmap_read_lock(mm);
> -		*unlocked = true;
> +		if (unlocked)
> +			*unlocked = true;
>  		return 0;
>  	}

I don't believe this is necessary unless the caller passed
FAULT_FLAG_KILLABLE or FAULT_FLAG_ALLOW_RETRY in fault_flags.

It's clear as mud and some code comments would help.
