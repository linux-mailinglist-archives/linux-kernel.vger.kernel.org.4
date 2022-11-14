Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071CD62878B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 18:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237133AbiKNRyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 12:54:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237828AbiKNRxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 12:53:51 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164231E729
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 09:53:48 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id q1so10869269pgl.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 09:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=knbOKZDiFpA41kgl5NgFlIeuBQLx4K+3AhrI93TxZQE=;
        b=hqx/0/7R+bJR0IOIafym/21OQWxfwNQzRGNB0Kinu+XIYdEefaCjNlOF4QHpAloJJQ
         f7kIzL9Sd8gHCTPYAQSTbXrhjohG7r4tgpcb0uQBvhbuUdtiz5NPPQ6mNArz61XzxgSX
         HW1/N+gg8XD5wLghZ5eNkaM7wmgCLD4qfdDVPd12mwTexkkg+KQOTiVtLT37aJl8hB2t
         UQUf6rWZoZY2HFyXnkEgSpecVhRPMU/s4Ylg52WOJLmueoSuE21pekW906FVPDgEhUde
         Hdt0faQlG2UtRjlykbPvpcPCST5YjJxlSHDCkMDOu7HakSl2tXXJstbPbxPqUUzNVo0K
         +77g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knbOKZDiFpA41kgl5NgFlIeuBQLx4K+3AhrI93TxZQE=;
        b=n7XAuO8vkI4pIZZLOe4pc4rV3xMC5AugijBT5gTmiJyhYKrJfM9FFRlcwJAdyLyCpo
         xATO1+A0D/ncwvRRsIA4Vnw/O4ER4w2GUvz/nJbHfPxdvlrhCDkxHBNh+4mVEQXOc1C6
         sDuO8jqOYbeFYw19nBsrfBdUI+/OiFPR6wLhBYdwN4/vN+tfLS2ncSiQab2mUmlEftky
         ZyNNmEeuwkCqIVNT5kmVj1s5QEJrqC+W6xzBqcxbSBccR/ikBsGNjijEbTR+jzlhTOWC
         vMisdMKI9g5+4yKtSMpizqAPe8Lc9MqkcU/oNnT0Zk8kJ3ul4+6k3uwXkgcAZKdObk8e
         hdew==
X-Gm-Message-State: ANoB5pkaEuFUInXjdUXxLCSVZCT7630Gk6oDRaKc+pUdiNgSi4pXg6u9
        MAfo6c4Ewhj6S0GCnpKtgSva3g==
X-Google-Smtp-Source: AA0mqf4pzNpvaqo3upyfzzheke1niLgWWYav6mAFBWd41t4r71IgB2i+eUKaif1z6SYdoz8cP2tUDw==
X-Received: by 2002:a63:1720:0:b0:46f:f93b:ddc8 with SMTP id x32-20020a631720000000b0046ff93bddc8mr12199883pgl.389.1668448427350;
        Mon, 14 Nov 2022 09:53:47 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id x2-20020a170902b40200b0018685257c0dsm7763635plr.58.2022.11.14.09.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 09:53:46 -0800 (PST)
Date:   Mon, 14 Nov 2022 17:53:43 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        syzbot+ffb4f000dc2872c93f62@syzkaller.appspotmail.com,
        syzbot+8cdd16fd5a6c0565e227@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 5/5] x86/kasan: Populate shadow for shared chunk of
 the CPU entry area
Message-ID: <Y3KAp+yNQ54IKvTn@google.com>
References: <20221110203504.1985010-1-seanjc@google.com>
 <20221110203504.1985010-6-seanjc@google.com>
 <3b7a841d-bbbd-6018-556f-d2414a5f02b2@gmail.com>
 <Y3Ja33LyShqjvmQZ@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3Ja33LyShqjvmQZ@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022, Peter Zijlstra wrote:
> On Mon, Nov 14, 2022 at 05:44:00PM +0300, Andrey Ryabinin wrote:
> > Going back kasan_populate_shadow() seems like safer and easier choice.
> > The only disadvantage of it that we might waste 1 page, which is not
> > much compared to the KASAN memory overhead.
> 
> So the below delta?
> 
> ---
> --- a/arch/x86/mm/kasan_init_64.c
> +++ b/arch/x86/mm/kasan_init_64.c
> @@ -388,7 +388,7 @@ void __init kasan_init(void)
>  	shadow_cea_end = kasan_mem_to_shadow_align_up(CPU_ENTRY_AREA_BASE +
>  						      CPU_ENTRY_AREA_MAP_SIZE);
>  
> -	kasan_populate_early_shadow(
> +	kasan_populate_shadow(
>  		kasan_mem_to_shadow((void *)PAGE_OFFSET + MAXMEM),
>  		kasan_mem_to_shadow((void *)VMALLOC_START));

Wrong one, that's the existing mapping.  To get back to v1:

diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
index af82046348a0..0302491d799d 100644
--- a/arch/x86/mm/kasan_init_64.c
+++ b/arch/x86/mm/kasan_init_64.c
@@ -416,8 +416,8 @@ void __init kasan_init(void)
         * area is randomly placed somewhere in the 512GiB range and mapping
         * the entire 512GiB range is prohibitively expensive.
         */
-       kasan_populate_early_shadow((void *)shadow_cea_begin,
-                                   (void *)shadow_cea_per_cpu_begin);
+       kasan_populate_shadow(shadow_cea_begin,
+                             shadow_cea_per_cpu_begin, 0);
 
        kasan_populate_early_shadow((void *)shadow_cea_end,
                        kasan_mem_to_shadow((void *)__START_KERNEL_map));
