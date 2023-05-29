Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E456F7146BE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 10:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbjE2I6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 04:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjE2I6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 04:58:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FA591;
        Mon, 29 May 2023 01:58:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 364D16137C;
        Mon, 29 May 2023 08:58:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A396C433EF;
        Mon, 29 May 2023 08:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685350690;
        bh=t2lj466261TGVeHMuyfw6d01BSLRoZETH0n0ShM8crM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R5FDQfcm8SUNyzpKDat8ojVSi4y8fmhImkdGup3zXnGIsJRsK3eJUlNeQZESjT9Gx
         S2dvoJ/khyHlknve2mX2V1Pd+pMy1J60DyeL4+/TV+s8kQQcAQmKeKNiqrSN7gDQaS
         hgO++m+zR2PlpJB45PJF+VWuRIIB2b+rn/ywHnY/ihuutRVOVGCkGtqkRP+ipK1xfF
         u0TczxO2dm1/bUG6dvdW9R8FcabA/r+zU2FNkhfM/6Q+JY4d8Jh7nG3BkTu628dAwS
         TP0hw3M2sEqF9b1WVPkJTr4rsf4MFs944By1iyFDCuUPB8MBgBE34BDs8sGeoWwIcT
         wQkhvy2HfChBg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1q3Yhb-0004Ym-74; Mon, 29 May 2023 10:58:07 +0200
Date:   Mon, 29 May 2023 10:58:07 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Petr Pavlu <petr.pavlu@suse.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, song@kernel.org, lucas.de.marchi@gmail.com,
        christophe.leroy@csgroup.eu, peterz@infradead.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com, yujie.liu@intel.com, david@redhat.com,
        tglx@linutronix.de, hch@lst.de, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com, prarit@redhat.com,
        lennart@poettering.net
Subject: Re: [PATCH 2/2] module: add support to avoid duplicates early on load
Message-ID: <ZHRpH-JXAxA6DnzR@hovoldconsulting.com>
References: <20230524213620.3509138-1-mcgrof@kernel.org>
 <20230524213620.3509138-3-mcgrof@kernel.org>
 <8fc5b26b-d2f6-0c8f-34a1-af085dbef155@suse.com>
 <CAHk-=wiPjcPL_50WRWOi-Fmi9TYO6yp_oj63a_N84FzG-rxGKQ@mail.gmail.com>
 <6gwjomw6sxxmlglxfoilelswv4hgygqelomevb4k4wrlrk3gtm@wrakbmwztgeu>
 <CAHk-=whu8Wh4JP1hrc80ZvGgVW4GV6hw1vwzSiwOo9-1=Y1dWw@mail.gmail.com>
 <ZG/a+nrt4/AAUi5z@bombadil.infradead.org>
 <CAHk-=whiXzqprmQNRui3LbKQwvM8fg4nyAzWcU5qZs+kxBVzrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whiXzqprmQNRui3LbKQwvM8fg4nyAzWcU5qZs+kxBVzrA@mail.gmail.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 06:39:52PM -0700, Linus Torvalds wrote:

> Ok, I decided to just move it from my experimental tree to my main tree.
> 
> I think I used about three times the time and effort (and lines of
> text) on writing the commit message compared to what I did on the
> patch itself.
> 
> I tried to lay out the background and the implications of the change -
> it may be pretty darn simple, but it does have some subtle issues.
> 
> Anyway: I've committed it to my tree. This is not necessarily the best
> time to do that, but let's get this behind us, and in particular,
> let's get it out and into wider testing asap.
> 
> If it causes any problems what-so-ever, I'll just revert it very
> aggressively (unless the problem is trivially and obviously fixable).
> It is, after all, not a fix for a _kernel_ bug per se, and whil eI
> think the patch is very benign, it does change user-visible behavior.
> Very intentionally so, but still..

This change breaks module loading during boot on the Lenovo Thinkpad
X13s (aarch64).

Specifically it results in indefinite probe deferral of the display and
USB (ethernet) which makes it a pain to debug. Typing in the dark to
acquire some logs reveals that other modules are missing as well.

Fortunately commit 9828ed3f695a ("module: error out early on concurrent
load of the same module file") stood out when skimming the changes that
went into -rc4, and reverting it make all the expected modules be loaded
again.

I have not tried to figure out exactly why things break, but it does
seem like this one should be reverted.

Johan
