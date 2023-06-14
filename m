Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2037303D5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 17:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245244AbjFNP1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 11:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343774AbjFNP0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:26:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9821E6C
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:26:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38267643B9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 15:26:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E991AC433C0;
        Wed, 14 Jun 2023 15:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686756398;
        bh=1FUrBPPtTuYhiCmgJTnF19xPmAmzMqjMGMN08AUS778=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Spmc2zDprQXdxWiUIGY8bhorL/WQL2Zx6swDV1mnoYUkk8wT0OoDVnACS9v3qsSff
         9ZChIce1SHG4Ejj7Hz7qzzxrRGSuW4+HyT4HgJpjx5nNfb32rx52SWamd0eVazUBRU
         CeBGw0/zrj7gNtq75bYYK14puAWnZvifpaLu1VdxTtmk+/zzZSXUIpeeV+9HObYkbx
         4MZaDtZEXhWYmudhpjutQXOwWw9//bc9JYEcPF/MDtJaUh6HEtQ5r+uKwqmj4/trRe
         /jPSXIOxxVkqkxqG+s42kiLbyhbp1S5S1cj2sAviuaLMRRfMTiOAyykGPPuLyNg6RF
         87J4Cgt8Hak0g==
Date:   Wed, 14 Jun 2023 16:26:32 +0100
From:   Lee Jones <lee@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: x86: pgtable / kaslr initialisation (OOB) help
Message-ID: <20230614152632.GZ3635807@google.com>
References: <20230614132339.GS3635807@google.com>
 <20230614141654.GA1640123@hirez.programming.kicks-ass.net>
 <20230614143732.GW3635807@google.com>
 <0cefb67a-6fae-daa2-c871-ae35b96aac08@intel.com>
 <20230614150615.GX3635807@google.com>
 <20230614151003.GY3635807@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230614151003.GY3635807@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jun 2023, Lee Jones wrote:

> On Wed, 14 Jun 2023, Lee Jones wrote:
> 
> > Thanks for chiming in Dave.  I hoped you would.
> > 
> > On Wed, 14 Jun 2023, Dave Hansen wrote:
> > 
> > > On 6/14/23 07:37, Lee Jones wrote:
> > > > Still unsure how we (the kernel) can/should write to an area of memory
> > > > that does not belong to it.  Should we allocate enough memory
> > > > (2*PAGE_SIZE? rather than 8-Bytes) for trampoline_pgd_entry to consume
> > > > in a more sane way?
> > > 
> > > No.
> > > 
> > > I think this:
> > > 
> > >                 set_pgd(&trampoline_pgd_entry,
> > >                         __pgd(_KERNPG_TABLE | __pa(p4d_page_tramp)));
> > > 
> > > is bogus-ish.  set_pgd() wants to operate on a pgd_t inside a pgd
> > > *PAGE*.  But it's just being pointed at a single  _entry_.  The address
> > > of 'trampoline_pgd_entry' in your case  also just (unfortunately)
> > > happens to pass the:
> > > 
> > > 	__pti_set_user_pgtbl -> pgdp_maps_userspace()
> > > 
> > > test.  I _think_ we want these to just be something like:
> > > 
> > > 	trampoline_pgd_entry = __pgd(_KERNPG_TABLE |
> > > 				     __pa(p4d_page_tramp);
> > > 
> > > That'll keep us away from all of the set_pgd()-induced nastiness.
> > 
> > Okay.  Is this what you're suggesting?
> > 
> > diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c                 v
> > index d336bb0cb38b..803595c7dcc8 100644
> > --- a/arch/x86/mm/kaslr.c
> > +++ b/arch/x86/mm/kaslr.c
> > @@ -176,7 +176,7 @@ void __meminit init_trampoline_kaslr(void)
> >                 set_pgd(&trampoline_pgd_entry,
> >                         __pgd(_KERNPG_TABLE | __pa(p4d_page_tramp)));
> >         } else {
> > -               set_pgd(&trampoline_pgd_entry,
> > -                       __pgd(_KERNPG_TABLE | __pa(pud_page_tramp)));
> > +               trampoline_pgd_entry =
> > +                       __pgd(_KERNPG_TABLE | __pa(p4d_page_tramp);
> 
> Note the change of *.page_tramp here.
> 
>   s/pud/p4d/
> 
> I'm assuming that too was intentional?

Never mind.  I can see that p4d_page_tramp is local to the if() segment.

While we're at it, does the if() segment look correct to you:

  if (pgtable_l5_enabled()) {
        p4d_page_tramp = alloc_low_page();

        p4d_tramp = p4d_page_tramp + p4d_index(paddr);

        set_p4d(p4d_tramp,
                __p4d(_KERNPG_TABLE | __pa(pud_page_tramp)));

        set_pgd(&trampoline_pgd_entry,
                __pgd(_KERNPG_TABLE | __pa(p4d_page_tramp)));
  } else {
        trampoline_pgd_entry =
                __pgd(_KERNPG_TABLE | __pa(pud_page_tramp));
  }

 - pud_page_tramp is being passed to set_p4d()
 - p4d_page_tramp is being passed to set_pgd()

Should those be the other way around, or am I missing the point?

-- 
Lee Jones [李琼斯]
