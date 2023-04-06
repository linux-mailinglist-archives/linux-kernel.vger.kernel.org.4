Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA866D9167
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 10:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235664AbjDFIX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 04:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234958AbjDFIXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 04:23:25 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0542010FC
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 01:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6yY7l0LhH0k7pjrVFUW8Mv8NnQNaUV8gs7w0W3YY6DA=; b=VaxrVS3njXraoPYywtixGMcp1y
        j2aQjwTOOI7JYZDNvWsObgMRKQvGINrYOYr4rLE6eKogI++AEkUTWOlAHDHe6UJxDUaXe1WpZzhwY
        t7lW5HwxMmKLADUSmIUxcvKL0mQX/3A0SbWtj3sYW/vxEEzicTXA3qOnH+Fo1nhOCKdIbl5ZBy2zd
        GCCouvgk76nMGawbr/VRL7P1QsYG3luFCf84Rb//Zxt3v8SsuVcHLzZYqb85UDRtJDdkUEenmCexo
        rmv+HaSMz0F5lWhQ2VTCJDpXfI2g/9eyPb7lhQKe2p50pyJGIGRux/ljBa0+7eRufzLf9cHvrriag
        qOptZ3Tg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pkKtd-00ATEE-2A;
        Thu, 06 Apr 2023 08:23:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 337BF30008D;
        Thu,  6 Apr 2023 10:23:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C7F8C24C025F1; Thu,  6 Apr 2023 10:23:04 +0200 (CEST)
Date:   Thu, 6 Apr 2023 10:23:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        willy@infradead.org, mgorman@suse.de, rostedt@goodmis.org,
        tglx@linutronix.de, vincent.guittot@linaro.org, jon.grimm@amd.com,
        bharata@amd.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 5/9] x86/clear_pages: add clear_pages()
Message-ID: <20230406082304.GE386572@hirez.programming.kicks-ass.net>
References: <20230403052233.1880567-1-ankur.a.arora@oracle.com>
 <20230403052233.1880567-6-ankur.a.arora@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403052233.1880567-6-ankur.a.arora@oracle.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 02, 2023 at 10:22:29PM -0700, Ankur Arora wrote:
> Add clear_pages() and define the ancillary clear_user_pages().
> 
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>  arch/x86/include/asm/page.h    | 6 ++++++
>  arch/x86/include/asm/page_32.h | 6 ++++++
>  arch/x86/include/asm/page_64.h | 9 +++++++--
>  3 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/page.h b/arch/x86/include/asm/page.h
> index d18e5c332cb9..03e3c69fc427 100644
> --- a/arch/x86/include/asm/page.h
> +++ b/arch/x86/include/asm/page.h
> @@ -28,6 +28,12 @@ static inline void clear_user_page(void *page, unsigned long vaddr,
>  	clear_page(page);
>  }
>  
> +static inline void clear_user_pages(void *page, unsigned long vaddr,
> +				    struct page *pg, unsigned int nsubpages)
> +{
> +	clear_pages(page, nsubpages);
> +}

This seems dodgy, clear_user* has slightly different semantics. It needs
the access_ok() and stac/clac thing on at the very least.

> +
>  static inline void copy_user_page(void *to, void *from, unsigned long vaddr,
>  				  struct page *topage)
>  {
> diff --git a/arch/x86/include/asm/page_32.h b/arch/x86/include/asm/page_32.h
> index 580d71aca65a..3523d1150cfc 100644
> --- a/arch/x86/include/asm/page_32.h
> +++ b/arch/x86/include/asm/page_32.h
> @@ -22,6 +22,12 @@ static inline void clear_page(void *page)
>  	memset(page, 0, PAGE_SIZE);
>  }
>  
> +static inline void clear_pages(void *page, unsigned int nsubpages)
> +{
> +	for (int i = 0; i < nsubpages; i++)
> +		clear_page(page + i * PAGE_SIZE);

cond_resched() ?

> +}
> +
>  static inline void copy_page(void *to, void *from)
>  {
>  	memcpy(to, from, PAGE_SIZE);
