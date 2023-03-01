Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028606A6A1A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 10:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjCAJyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 04:54:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjCAJyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 04:54:38 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614EF17166
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 01:54:37 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id p20so12180728plw.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 01:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NCmVhit3ZxUnFfJa9Eg0PdbeeaxDV2n5h2R0f8D1TDQ=;
        b=IsHSPoW4qTvdJtki81JnLpv6tsZtbF3JjQTnxZtxQVSUQGmA5m4P4l7BvzWWQoNSuS
         xSD7jhrZm5QV8FZgZVY6Vi6i2BsMnBSpJLgydkl+zYdbJIqcQndZEjqX37xcEDJgmC0c
         TPU+3aj1+91b6bEp6UBwb9eQzhY5SgGORcupta75GhZ6a8NG9EIbpze96tzJAPRaFgV3
         nfzpjnt1I7yRAJjoUQhSyjgGBPpm8B7vgKkKYJkkgb1YCHhuDWM4jaZSGVWsyg+rQzrX
         2qVI8QGugWl/wFcet/8u7+DNcMzjoJsfCBlORiD3WC6gUIsBA9ytVc3ampWd2mB3HwJw
         R46A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NCmVhit3ZxUnFfJa9Eg0PdbeeaxDV2n5h2R0f8D1TDQ=;
        b=vXtI3avWYsjwagOwipwJnH9HyQPs12DHQoSAt9R04su1ALk57FGUVI4ubpOCFajLzO
         AQd1ZT7utZpycOTtwVmL7QlPxgSytdr+q6avt093BJecAk4oPp4WLBc+CPilQs/yMcqT
         sgwBFVvMJYWW98nqv5SsL7AsrM+q0DACMXps4+bqGGiw9h4z2U0xSrHKaj+/PCQMmUdV
         poEZAqcDLkkhoPBkOHSorB/LjrdooJUDaljgsC8IWMD9w6PWtBgRGxwZR3RONBA6GLIC
         IelQ1eBcRQxPlkUmhdqlQQGPx2UAA2Yizp9Dvk5AjscvG5YC3JDjSCOJRmkCoYmKZ3Dn
         aEXQ==
X-Gm-Message-State: AO0yUKWrUCL7LNxV+vph8lx6lLGtL4XwHxsrBdN5eb2kDvUauAo+XpNh
        Cfb7jDCe+TRFMUnOkYoResQ=
X-Google-Smtp-Source: AK7set9yjx1OHgmVb8mksaGcbLhfEq+vire/eemNETYF7Uujz6AR4vXtJwEeT/YvwzBAuROhUh6OKQ==
X-Received: by 2002:a17:90b:4b8d:b0:234:68d:b8ea with SMTP id lr13-20020a17090b4b8d00b00234068db8eamr6626136pjb.39.1677664476789;
        Wed, 01 Mar 2023 01:54:36 -0800 (PST)
Received: from localhost ([2400:8902::f03c:93ff:fe27:642a])
        by smtp.gmail.com with ESMTPSA id e18-20020a656892000000b004fbd91d9716sm7103203pgt.15.2023.03.01.01.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 01:54:35 -0800 (PST)
Date:   Wed, 1 Mar 2023 09:54:21 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, paulmck@kernel.org, mingo@redhat.com,
        will@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com, chriscli@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        gurua@google.com, arjunroy@google.com, soheil@google.com,
        leewalsh@google.com, posk@google.com,
        michalechner92@googlemail.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v4 24/33] mm: fall back to mmap_lock if vma->anon_vma is
 not yet set
Message-ID: <Y/8gzRg3voRhNOsM@localhost>
References: <20230227173632.3292573-1-surenb@google.com>
 <20230227173632.3292573-25-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230227173632.3292573-25-surenb@google.com>
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 09:36:23AM -0800, Suren Baghdasaryan wrote:
> When vma->anon_vma is not set, page fault handler will set it by either
> reusing anon_vma of an adjacent VMA if VMAs are compatible or by
> allocating a new one. find_mergeable_anon_vma() walks VMA tree to find
> a compatible adjacent VMA and that requires not only the faulting VMA
> to be stable but also the tree structure and other VMAs inside that tree.
> Therefore locking just the faulting VMA is not enough for this search.
> Fall back to taking mmap_lock when vma->anon_vma is not set. This
> situation happens only on the first page fault and should not affect
> overall performance.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  mm/memory.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index bda4c1a991f0..8855846a361b 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5243,6 +5243,10 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
>  	if (!vma_is_anonymous(vma))
>  		goto inval;
>  
> +	/* find_mergeable_anon_vma uses adjacent vmas which are not locked */
> +	if (!vma->anon_vma)
> +		goto inval;
> +
>  	if (!vma_start_read(vma))
>  		goto inval;

Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

> -- 
> 2.39.2.722.g9855ee24e9-goog
> 
> 
