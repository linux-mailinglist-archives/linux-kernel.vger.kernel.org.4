Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF6073DB01
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 11:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjFZJO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 05:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjFZJNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 05:13:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15142E1;
        Mon, 26 Jun 2023 02:11:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 963D160D2C;
        Mon, 26 Jun 2023 09:11:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62601C433C0;
        Mon, 26 Jun 2023 09:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687770715;
        bh=iLYlNZZUWYeCPAHYoPNaCrwZSkSOhiZiARtAbZAablk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nfKAbQ31xMawaI7b/PDj9Cw9hIyccjj3JE9Tll9auIp659XVpCP2/iCO6Cu+Xydte
         Mxl7bm+5+OpbJphkikCTk8/XOM+Ch356hqj3JdS48s1MSO6toqhfh7+wICZAGlgCHV
         R6I2dmYDtgN56gj4N3nZ1bE96HUBfEcroQfK3hOXTh8kF4pnz3wxEBdsv0zKifvkTg
         ntk4Ey0JKOliEpFxAH3T4rtyoAtXqsFYU736z/7czN25I78b7TDYTXbOtSDbTK5vAr
         5ofNw01kFoMM7kN8Pxmwl0tJ2g8IKAmcRReZvP3fkDT001MrqKvJwuN6vuf0a3eaYS
         zrLIqIim5HPdg==
Date:   Mon, 26 Jun 2023 10:11:49 +0100
From:   Lee Jones <lee@kernel.org>
To:     Greg KH <greg@kroah.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-tip-commits@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/mm: Avoid using set_pgd() outside of real
 PGD pages
Message-ID: <20230626091149.GA10378@google.com>
References: <168694160067.404.13343792487331756749.tip-bot2@tip-bot2>
 <20230626085450.GA1344014@google.com>
 <2023062651-random-enjoyment-8838@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2023062651-random-enjoyment-8838@gregkh>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jun 2023, Greg KH wrote:

> On Mon, Jun 26, 2023 at 09:54:50AM +0100, Lee Jones wrote:
> > Dear Stable,
> > 
> > On Fri, 16 Jun 2023, tip-bot2 for Lee Jones wrote:
> > 
> > > The following commit has been merged into the x86/urgent branch of tip:
> > > 
> > > Commit-ID:     d082d48737c75d2b3cc1f972b8c8674c25131534
> > > Gitweb:        https://git.kernel.org/tip/d082d48737c75d2b3cc1f972b8c8674c25131534
> > > Author:        Lee Jones <lee@kernel.org>
> > > AuthorDate:    Wed, 14 Jun 2023 17:38:54 +01:00
> > > Committer:     Dave Hansen <dave.hansen@linux.intel.com>
> > > CommitterDate: Fri, 16 Jun 2023 11:46:42 -07:00
> > > 
> > > x86/mm: Avoid using set_pgd() outside of real PGD pages
> > > 
> > > KPTI keeps around two PGDs: one for userspace and another for the
> > > kernel. Among other things, set_pgd() contains infrastructure to
> > > ensure that updates to the kernel PGD are reflected in the user PGD
> > > as well.
> > > 
> > > One side-effect of this is that set_pgd() expects to be passed whole
> > > pages.  Unfortunately, init_trampoline_kaslr() passes in a single entry:
> > > 'trampoline_pgd_entry'.
> > > 
> > > When KPTI is on, set_pgd() will update 'trampoline_pgd_entry' (an
> > > 8-Byte globally stored [.bss] variable) and will then proceed to
> > > replicate that value into the non-existent neighboring user page
> > > (located +4k away), leading to the corruption of other global [.bss]
> > > stored variables.
> > > 
> > > Fix it by directly assigning 'trampoline_pgd_entry' and avoiding
> > > set_pgd().
> > > 
> > > [ dhansen: tweak subject and changelog ]
> > > 
> > > Fixes: 0925dda5962e ("x86/mm/KASLR: Use only one PUD entry for real mode trampoline")
> > > Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> > > Signed-off-by: Lee Jones <lee@kernel.org>
> > > Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> > > Cc: <stable@vger.kernel.org>
> > > Link: https://lore.kernel.org/all/20230614163859.924309-1-lee@kernel.org/g
> > > ---
> > >  arch/x86/mm/kaslr.c | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
> > > index 557f0fe..37db264 100644
> > > --- a/arch/x86/mm/kaslr.c
> > > +++ b/arch/x86/mm/kaslr.c
> > > @@ -172,10 +172,10 @@ void __meminit init_trampoline_kaslr(void)
> > >  		set_p4d(p4d_tramp,
> > >  			__p4d(_KERNPG_TABLE | __pa(pud_page_tramp)));
> > >  
> > > -		set_pgd(&trampoline_pgd_entry,
> > > -			__pgd(_KERNPG_TABLE | __pa(p4d_page_tramp)));
> > > +		trampoline_pgd_entry =
> > > +			__pgd(_KERNPG_TABLE | __pa(p4d_page_tramp));
> > >  	} else {
> > > -		set_pgd(&trampoline_pgd_entry,
> > > -			__pgd(_KERNPG_TABLE | __pa(pud_page_tramp)));
> > > +		trampoline_pgd_entry =
> > > +			__pgd(_KERNPG_TABLE | __pa(pud_page_tramp));
> > >  	}
> > >  }
> > 
> > Could we have this expedited please?  There are users waiting for it.
> > 
> > Upstream commit is:
> > 
> >   d082d48737c75 ("x86/mm: Avoid using set_pgd() outside of real PGD pages")
> 
> Please look through your emails you got this weekend, it's already
> queued up in the following stable trees:
> 	queue-5.4 queue-5.10 queue-5.15 queue-6.1 queue-6.3

Haven't reached those ones yet - only 160 to go!

Thank you though, very much appreciated.

-- 
Lee Jones [李琼斯]
