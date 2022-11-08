Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E3D621D60
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 21:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiKHUDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 15:03:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiKHUDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 15:03:41 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEDD1AF0C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 12:03:40 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id b62so14350298pgc.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 12:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UabFGB3dgHdDGh8rYKaeDmUDo6Yz1+GrAprP6mnLPVs=;
        b=WfTYpQNyDJezun0scrrYkgN5kOzozjxRJesX99og1g2FWnFHsFQhSW5hJaYGvdyNNU
         jrPNbxpCjz5OQZE9neQx4nceeBX2V8HAapvLl5sJvakxwiNDX4e2RKGY+xBmd80cZK36
         yXtIHa1sgZ6OUah9NP4H4VX9WR4tT5C1UpDODajvrBweEZW/i78Qyn5ginOCrVshndbu
         uMlx/n2K2ydfLql3C6DuPrv3/3hve82YQB4AouzqS9Cv6Eq2VbfC9EQo3nK9o45sjthj
         +giz5tY1/ABeEbtrg2lfeo0K1uPgfof7KTBhrhon1hPti0c1uakQLatrukR9xwhYmNBV
         jGGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UabFGB3dgHdDGh8rYKaeDmUDo6Yz1+GrAprP6mnLPVs=;
        b=1+/W1FqjuHa6dVPdO4TEu9vt1ZdGzucIV/S54WLWqmYXjatzUvTnyHjRQo3TeKZsHA
         nw2mP1+uWr6gfBE4HzY8knL+HWW9t3hPcZ93RF8X+f8qW1f/hd1K+Bm8T1UCnDkxmji9
         zJlKpatYHx3UlpOIeTNDw5WxVLy/iPohD8fFksuO6HyP1c2KSiOo/aifiEhBmLi2oR/i
         37+gZcgcPsK/TzKvopL6/e2bbB666fNUWS0hwXT+epQna4ZmGNUdWhdhTQ51OtIVDFDz
         go1hU36DAnnnZW5/p1ZBt2lvh2LCNrnfr6DEim6Dd29h02GUd0Td9+7LE+FwYuQGAFxl
         uLmw==
X-Gm-Message-State: ACrzQf2qpqFXlrYa2bjrbRvqgofSBlDSiknXNJYSTKHyjRsxvQAfdz0w
        1bImF4P8avGmcSQB0HWo2iFwsw==
X-Google-Smtp-Source: AMsMyM49BTXjwcisXJONM3dl57ISGPzbrtfdjF1FlSG9ZWqE52ZRy8EoJixFF07LWVmnHNbC+6vdIA==
X-Received: by 2002:a05:6a00:b82:b0:56c:d5bf:1019 with SMTP id g2-20020a056a000b8200b0056cd5bf1019mr57436217pfj.72.1667937820352;
        Tue, 08 Nov 2022 12:03:40 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id e13-20020a17090301cd00b001782398648dsm7424642plh.8.2022.11.08.12.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 12:03:39 -0800 (PST)
Date:   Tue, 8 Nov 2022 20:03:36 +0000
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
Message-ID: <Y2q2GFWjLKMp5eUr@google.com>
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

Is that the only difference between the "early" and "normal" variants?  If so,
renaming them to kasan_populate_ro_shadow() vs. kasan_populate_rw_shadow() would
make this code much more intuitive for non-KASAN folks.

> 
> >  	kasan_populate_early_shadow((void *)shadow_cea_end,
> >  			kasan_mem_to_shadow((void *)__START_KERNEL_map));
> >  
