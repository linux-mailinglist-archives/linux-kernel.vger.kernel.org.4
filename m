Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6C262321D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 19:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiKISOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 13:14:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKISOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 13:14:50 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3B9B8F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 10:14:50 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso2654311pjc.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 10:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qY9r/2KvCiduXiHY2T0U0gealLH3/TCB5NroFDjcvQE=;
        b=KLlx0AC4f++cWN9m+wd0N7L1bYzddU+pMqqGhUVAJNFphvVys3a4q9/mnGH313D9Rs
         ov47UD7E/3FtmaqGah8PEOOBESVe+Ewj+966rzYGfMgM/0KkCTEiEX2a9P6Oe6nknLvI
         EWuwquHksEO3eDUui6nsRlgeGi4Pl9ri59Vuh3/UzjkHj/xjk2NkkTjN5LTrZGWMj4Yw
         MwlKXbpuKc5FIZj8wWfMbnICJ4aGYvnZ9DLnJmV7NpwD1pACuFk8U1cbamaKSz1Uq92O
         wb3HyT+O0KY9ji8AbMv/BtBtXnOQPs7Pig1KMbkAlhDsrnj4YTi32lxTVKHyzDUqNfNJ
         ufBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qY9r/2KvCiduXiHY2T0U0gealLH3/TCB5NroFDjcvQE=;
        b=pgljERWORVkYmYLKdD/vELXG+gKwW6MWud/dnRn0O143fq+HofAvwIjUJ0cZtkSqKo
         F0YwNwhJhWoe8Q4rEuvbaG1x0A/UQ+gxr3O85sWYjLBVAmyuZdcH4mIIxhUB25jf8uwk
         zIsk7fcHD5K/2XO1ktIlXrvPMhva5UxKt/gAEdU4JWBxH6VfgiNU14RfqPfRdHZM6HWg
         j5KvG203eGJUCEGZZKR380FBF7B37JanH+928EtmjLqMKfe13nfpmMfKgLxKDssOhqlv
         UCYLh4U5xMSrHw3rJenuMMvylSTTJjKv/khE9CjrO+o1omIfGkXE44r35WldUD00pAAh
         iM/Q==
X-Gm-Message-State: ACrzQf0uNZN00hyw8FDvuHtx3iRhM3UTgI0RbLgv2HhD/Z4GCKULFEjM
        HOkh2p6Wl4hUO0MG+HSf7F/7IQ==
X-Google-Smtp-Source: AMsMyM6K1qOsUCEtO0ERCwBWHt281nROHHUSnpgnrHpRjUCi3Zt5sQ8cdCti0c8XrHmzMt6sXcnnpA==
X-Received: by 2002:a17:902:c1c6:b0:186:994f:6e57 with SMTP id c6-20020a170902c1c600b00186994f6e57mr61654253plc.17.1668017689459;
        Wed, 09 Nov 2022 10:14:49 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id oj17-20020a17090b4d9100b00212d9a06edcsm1502645pjb.42.2022.11.09.10.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 10:14:48 -0800 (PST)
Date:   Wed, 9 Nov 2022 18:14:45 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        syzbot+8cdd16fd5a6c0565e227@syzkaller.appspotmail.com
Subject: Re: [PATCH 3/3] x86/kasan: Populate shadow for shared chunk of the
 CPU entry area
Message-ID: <Y2vuFY6NOuX7moeT@google.com>
References: <20221104183247.834988-1-seanjc@google.com>
 <20221104183247.834988-4-seanjc@google.com>
 <06debc96-ea5d-df61-3d2e-0d1d723e55b7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06debc96-ea5d-df61-3d2e-0d1d723e55b7@gmail.com>
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

On Tue, Nov 08, 2022, Andrey Ryabinin wrote:
> 
> On 11/4/22 21:32, Sean Christopherson wrote:
> > @@ -409,6 +410,15 @@ void __init kasan_init(void)
> >  		kasan_mem_to_shadow((void *)VMALLOC_END + 1),
> >  		(void *)shadow_cea_begin);
> >  
> > +	/*
> > +	 * Populate the shadow for the shared portion of the CPU entry area.
> > +	 * Shadows for the per-CPU areas are mapped on-demand, as each CPU's
> > +	 * area is randomly placed somewhere in the 512GiB range and mapping
> > +	 * the entire 512GiB range is prohibitively expensive.
> > +	 */
> > +	kasan_populate_shadow(shadow_cea_begin,
> > +			      shadow_cea_per_cpu_begin, 0);
> > +
> 
> I think we can extend the kasan_populate_early_shadow() call above up to
> shadow_cea_per_cpu_begin point, instead of this.
> populate_early_shadow() maps single RO zeroed page. No one should write to the shadow for IDT.
> KASAN only needs writable shadow for linear mapping/stacks/vmalloc/global variables.

Any objection to simply converting this to use kasan_populate_early_shadow(),
i.e. to keeping a separate "populate" call for the CPU entry area?  Purely so
that it's more obvious that a small portion of the overall CPU entry area is
mapped during init.
