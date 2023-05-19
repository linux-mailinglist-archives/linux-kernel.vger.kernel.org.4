Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88AF709A75
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 16:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbjESOv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 10:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjESOv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 10:51:56 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6433FA1;
        Fri, 19 May 2023 07:51:55 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-309382efe13so2156580f8f.2;
        Fri, 19 May 2023 07:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684507914; x=1687099914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMQZECFtXym11ziYXl+wIoNNwzMeR1Bxy8iSX/Q997A=;
        b=VPDps51pUY/EJFHxafPUzqLLQCefvQWUOZysrtOX/RzXO060iImM98vSPbI4oyXa04
         BCHUKWnNwi3h8bw/86pZYipH+lVfrBYqOfNJugL55cJuGQRV97p3NZWLoYbe/ZyTDDDZ
         eGKWC2MF68BfcvWuz5P5H2FZ8s/fOXyPNoNlVYZc6mwmG4wWhfiLut2Ad6qjlr3TrrOE
         7gnX+tCpMafN61s7aA2ngKLyuNMifrbogrS7bkjBvQgYAXb1aZrg5eSPT5zXPzZ3hzcj
         i2K/9x9/U/9LN6LiNB/fiIVO0OFGsvZkmbsEVLFdKUEAf9cfmVjDQQkrQMLrjP5XEuui
         hFlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684507914; x=1687099914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZMQZECFtXym11ziYXl+wIoNNwzMeR1Bxy8iSX/Q997A=;
        b=IEy9EIwxFX9C2V9Qrd3FzOYyTD082aqrUC/vn3DOkIWfAzjClkZiwI6EAKgP23H0qh
         2LXftNU7Nhn7f5/dtGxkSajgNchRVW9W8KdrseAQCkEfoTu3vR78fxMnmAJCCUJhK/6p
         Mm3AxaGunkzmhzxmeMA6ZaT12Uhm1eT911Akp1EwsMjRpSbnFtfVMMizTzDkJMi0XcvL
         UCiRrjMZ1Mkyq9aeqDn0flnXsfTJ89I5CJcmPva81hBF5Z3eYqSqEeNwfO4++UrSeiVc
         ugSrP33mvixCx4cZ+b5Tlcu0PdjWrwmBcptSl3rrGcRUk76YFuxRgJZeeUqA2t5Bd3Zu
         Eebw==
X-Gm-Message-State: AC+VfDxeRf66GKDb79Xn8vKH9zVN246ChuFkujMyRiioEeaeC6aBaoFL
        sFo1OyG8kx4y2D6CfyBseUc=
X-Google-Smtp-Source: ACHHUZ41Leun+h+YErHotZC3zd8Np65RkNQeBYIROMArGqFz6AajgszDwsnVl4ekPuFpw5pJrEFoPA==
X-Received: by 2002:a5d:4811:0:b0:307:9a49:da89 with SMTP id l17-20020a5d4811000000b003079a49da89mr1642332wrq.38.1684507913493;
        Fri, 19 May 2023 07:51:53 -0700 (PDT)
Received: from localhost (host81-154-179-160.range81-154.btcentralplus.com. [81.154.179.160])
        by smtp.gmail.com with ESMTPSA id 18-20020a05600c229200b003f42d8dd7d1sm2691633wmf.7.2023.05.19.07.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 07:51:52 -0700 (PDT)
Date:   Fri, 19 May 2023 15:51:51 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] [suggestion] mm/gup: avoid IS_ERR_OR_NULL
Message-ID: <5b071f65-7f87-4a7b-a76a-f4a1c1568ae7@lucifer.local>
References: <20230519093953.10972-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519093953.10972-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Given you are sharply criticising the code I authored here, is it too much
to ask for you to cc- me, the author on commentaries like this? Thanks.

On Fri, May 19, 2023 at 11:39:13AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> While looking at an unused-variable warning, I noticed a new interface coming
> in that requires the use of IS_ERR_OR_NULL(), which tends to indicate bad
> interface design and is usually surprising to users.

I am not sure I understand your reasoning, why does it 'tend to indicate
bad interface design'? You say that as if it is an obvious truth. Not
obvious to me at all.

There are 3 possible outcomes from the function - an error, the function
failing to pin a page, or it succeeding in doing so. For some of the
callers that results in an error, for others it is not an error.

Overloading EIO on the assumption that gup will never, ever return this
indicating an error seems to me a worse solution.

>
> Change get_user_page_vma_remote() to return -EIO when no pages were
> found and adapt the callers to match.
>
> Fixes: eca1a00155df ("mm/gup: remove vmas parameter from get_user_pages_remote()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I see the real bug is already fixed, but this seemed worth pointing out still.
> Not sure if this is the best way to handle the return types here, but the version
> in linux-next doesn't look great either.
> ---
>  arch/arm64/kernel/mte.c | 4 ++--
>  include/linux/mm.h      | 2 +-
>  kernel/events/uprobes.c | 5 ++++-
>  mm/memory.c             | 2 +-
>  4 files changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> index 4c5ef9b20065..6983ba35ce16 100644
> --- a/arch/arm64/kernel/mte.c
> +++ b/arch/arm64/kernel/mte.c
> @@ -434,8 +434,8 @@ static int __access_remote_tags(struct mm_struct *mm, unsigned long addr,
>  		struct page *page = get_user_page_vma_remote(mm, addr,
>  							     gup_flags, &vma);
>
> -		if (IS_ERR_OR_NULL(page)) {
> -			err = page == NULL ? -EIO : PTR_ERR(page);
> +		if (IS_ERR(page)) {
> +			err = PTR_ERR(page);
>  			break;
>  		}
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 42ff3e04c006..4bb172e4818c 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2397,7 +2397,7 @@ static inline struct page *get_user_page_vma_remote(struct mm_struct *mm,
>  	if (got < 0)
>  		return ERR_PTR(got);
>  	if (got == 0)
> -		return NULL;
> +		return ERR_PTR(-EIO);
>
>  	vma = vma_lookup(mm, addr);
>  	if (WARN_ON_ONCE(!vma)) {
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index cac3aef7c6f7..9cf2d4ba760e 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -474,7 +474,10 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
>  		gup_flags |= FOLL_SPLIT_PMD;
>  	/* Read the page with vaddr into memory */
>  	old_page = get_user_page_vma_remote(mm, vaddr, gup_flags, &vma);
> -	if (IS_ERR_OR_NULL(old_page))
> +	if (old_page == ERR_PTR(-EIO))
> +		return 0;
> +
> +	if (IS_ERR(old_page))
>  		return PTR_ERR(old_page);

I hate this, you're now using an error to indicate a non-error state.

Also you have no idea whether get_user_page_vma_remote() has encountered an
error condition returning -EIO rather than not pinning anything so this
could also be broken.

>
>  	ret = verify_opcode(old_page, vaddr, &opcode);
> diff --git a/mm/memory.c b/mm/memory.c
> index 8358f3b853f2..f9a81278e76d 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5604,7 +5604,7 @@ int __access_remote_vm(struct mm_struct *mm, unsigned long addr, void *buf,
>  		struct page *page = get_user_page_vma_remote(mm, addr,
>  							     gup_flags, &vma);
>
> -		if (IS_ERR_OR_NULL(page)) {
> +		if (IS_ERR(page)) {
>  #ifndef CONFIG_HAVE_IOREMAP_PROT
>  			break;
>  #else
> --
> 2.39.2
>

Not a fan at all of this patch, it doesn't achieve anything useful, is in
service of some theoretical improvement, and actually introduces a new
class of bug (differentiating EIO and failing to pin).
