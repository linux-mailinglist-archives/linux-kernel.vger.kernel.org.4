Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03F369BF4A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 10:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjBSJDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 04:03:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjBSJDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 04:03:05 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 24F8F10404;
        Sun, 19 Feb 2023 01:03:04 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1pTfaz-0000LC-03; Sun, 19 Feb 2023 10:02:57 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 24C47C28CF; Sun, 19 Feb 2023 09:40:43 +0100 (CET)
Date:   Sun, 19 Feb 2023 09:40:43 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Dengcheng Zhu <dzhu@wavecomp.com>,
        John Crispin <john@phrozen.org>, linux-mips@vger.kernel.org,
        Qais Yousef <qyousef@layalina.io>
Subject: Re: [PATCH] MIPS: vpe-mt: provide a default 'physical_memsize'
Message-ID: <20230219084043.GD2924@alpha.franken.de>
References: <20230214010942.25143-1-rdunlap@infradead.org>
 <7a2eca01-8420-dd98-9d4d-edf192f099fb@linaro.org>
 <a2a7806b-ba53-9f37-938b-d3f48ea217f2@infradead.org>
 <20230217115713.GA7701@alpha.franken.de>
 <fec9d8ca-b385-b2e4-8f20-db427c2ae964@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fec9d8ca-b385-b2e4-8f20-db427c2ae964@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 03:24:04PM -0800, Randy Dunlap wrote:
> 
> 
> On 2/17/23 03:57, Thomas Bogendoerfer wrote:
> > On Wed, Feb 15, 2023 at 10:59:35PM -0800, Randy Dunlap wrote:
> >>> I agree this is where this variable has be be declared / initialized,
> >>> but having this dependent on CONFIG_MIPS_MALTA/CONFIG_LANTIQ machines
> >>> doesn't seem right.
> >>
> >> So far I have been able to consolidate the LANTIQ code into a general
> >> patch, but not MALTA.
> > 
> > if I didn't miss something physical_memory is always 0 for LANTIQ 
> > and something for MALTA depending on command line/DT. Now
> > 
> > arch/mips/kernel/vpe-mt.c contains
> > 
> >         /*
> >          * The sde-kit passes 'memsize' to __start in $a3, so set something
> >          * here...  Or set $a3 to zero and define DFLT_STACK_SIZE and
> >          * DFLT_HEAP_SIZE when you compile your program
> >          */
> >         mttgpr(6, v->ntcs);
> >         mttgpr(7, physical_memsize);
> > 
> > so the 0 for LANTIQ is fine with the correct VPE payload. But for
> > MALTA could cause major problems, if the VPE payload uses the top
> > of memory for it's stack. So I would guess nobody uses this "mode".
> > Therefore let's get rid of physical_memory in vpe.c completly.
> 
> Hi Thomas,
> 
> What is this line doing?
>           mttgpr(6, v->ntcs);

from a quick glance over the code, it's probably the number of thread
contexts (TCs) the VPE is allowed to use.

> Does it need to stay?

yes.

> But the comment and mttgpr(7, physical_memsize); can be deleted?

replace it with

	/*
	 * we don't pass the memsize here, so VPE programs need to be
	 * compiled with DFLT_STACK_SIZE and DFLT_HEAP_SIZE defined
	 */
	mttgpr(7, 0);

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
