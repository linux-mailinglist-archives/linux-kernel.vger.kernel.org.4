Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA4F73078C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 20:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbjFNSoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 14:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbjFNSnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 14:43:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88F7212C
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 11:43:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4829063FA9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 18:43:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14270C433C8;
        Wed, 14 Jun 2023 18:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686768227;
        bh=NIXlB9+2WkBQ/E/Qxn+H6VTpQkwCpTesI9A9vvN9CeE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZiRPIZzEq2FBbYrmRtsGLLdeSFFu9b8Q2J8fTocoPtIuJCnofrg1Bec5Yp2PbYOVp
         l/NO9PSsw60vOuWoKwlOJB4/NPA4/O9PYBMZXskmIOZ/65qF80usL6zzYvox32T6tF
         +v0gTMY9g9PgFXipLQ8f8Zo4l8B6QAkmclqRu3PMwMQG8rHyuZDvJ6w+gsToVoDMK7
         AW9naZnVLIKx5dXQ28ot6P3H5Q+Q1/H0pKlQ9KWr5nH7adquqZ54HGh+0NXrKfs5U3
         OdvGZfwKz6jDYoV4MOFpRXv63LJs/Rp5zjJ40kIBSb6v/f016GGtDZG/N5SZ3ymDQU
         c6z9G9ehSeqWA==
Date:   Wed, 14 Jun 2023 19:43:41 +0100
From:   Lee Jones <lee@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] x86/mm/KASLR: Store pud_page_tramp into entry
 rather than page
Message-ID: <20230614184341.GC3635807@google.com>
References: <20230614163859.924309-1-lee@kernel.org>
 <20230614163859.924309-2-lee@kernel.org>
 <ZIn9YCcETx+Hlf6Z@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZIn9YCcETx+Hlf6Z@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jun 2023, Nick Desaulniers wrote:

> On Wed, Jun 14, 2023 at 05:38:54PM +0100, Lee Jones wrote:
> > set_pgd() expects to be passed whole pages to operate on, whereas
> > trampoline_pgd_entry is, as the name suggests, an entry.  The
> > ramifications for using set_pgd() here are that the following thread of
> > execution will not only place the suggested value into the
> > trampoline_pgd_entry (8-Byte globally stored [.bss]) variable, PTI will
> > also attempt to replicate that value into the non-existent neighboring
> > user page (located +4k away), leading to the corruption of other global
> > [.bss] stored variables.
> > 
> > Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> > Signed-off-by: Lee Jones <lee@kernel.org>
> 
> Nice work tracking this one down!
> 
> Fixes: 0925dda5962e ("x86/mm/KASLR: Use only one PUD entry for real mode trampoline")
> Cc: <stable@vger.kernel.org>

I was planning on backporting this myself once it hits Mainline.

Happy to submit a RESEND with those pieces added if required though.

Or perhaps someone would be kind enough to add them on merge?

> > ---
> >  arch/x86/mm/kaslr.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
> > index 557f0fe25dff4..37db264866b64 100644
> > --- a/arch/x86/mm/kaslr.c
> > +++ b/arch/x86/mm/kaslr.c
> > @@ -172,10 +172,10 @@ void __meminit init_trampoline_kaslr(void)
> >  		set_p4d(p4d_tramp,
> >  			__p4d(_KERNPG_TABLE | __pa(pud_page_tramp)));
> >  
> > -		set_pgd(&trampoline_pgd_entry,
> > -			__pgd(_KERNPG_TABLE | __pa(p4d_page_tramp)));
> > +		trampoline_pgd_entry =
> > +			__pgd(_KERNPG_TABLE | __pa(p4d_page_tramp));
> >  	} else {
> > -		set_pgd(&trampoline_pgd_entry,
> > -			__pgd(_KERNPG_TABLE | __pa(pud_page_tramp)));
> > +		trampoline_pgd_entry =
> > +			__pgd(_KERNPG_TABLE | __pa(pud_page_tramp));
> >  	}
> >  }
> > -- 
> > 2.41.0.162.gfafddb0af9-goog
> > 

-- 
Lee Jones [李琼斯]
