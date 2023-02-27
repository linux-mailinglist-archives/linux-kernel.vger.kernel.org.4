Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7196A434B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 14:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjB0NuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 08:50:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjB0NuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 08:50:15 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D698821974;
        Mon, 27 Feb 2023 05:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EhR9H533iLJtMrWDRv6QbWK1xC5aZF5Krew4cuVbhkY=; b=pjNHlWPfx/mT2hbu+ptXuX0Bfl
        6zxwF35vF7M+uOcH6tkINiOev6YsMPaubnFo73g9CYU3Ll3T9vll1nI0RNIz3WNlOYgiQa0tIVuKA
        B74bpcIknADwNfdW3qiqy/LodWENLcXyHOE5GDwPy8SDC2sGnAK8XRozKiqv3/orCAw1mdFzv6HIi
        4Fd5+VtHusrJQM9si0oyzylM6PKjlqGcBBcB0+w8I4L93cScTcRI07ARzhig2+xcpAnwonlHY3QlK
        3t2CJ+UJ429TvOFTkQzXQL9J1jWkm2YGGPGX0C52K8tzDWANXamImjRh/q37GBZi3LXqJmVgYbqO9
        qyPvOYaw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pWdt1-00093q-0o; Mon, 27 Feb 2023 13:49:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7835530030B;
        Mon, 27 Feb 2023 14:49:49 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 56A33200AAFE3; Mon, 27 Feb 2023 14:49:49 +0100 (CET)
Date:   Mon, 27 Feb 2023 14:49:49 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-ia64@vger.kernel.org,
        linux-sh@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mips@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-xtensa@linux-xtensa.org, Arnd Bergmann <arnd@arndb.de>,
        intel-gfx@lists.freedesktop.org, linux-m68k@lists.linux-m68k.org,
        openrisc@lists.librecores.org, loongarch@lists.linux.dev,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [Intel-gfx] [PATCH v5 0/7] Introduce __xchg, non-atomic xchg
Message-ID: <Y/y0/VoPAVCXGKp3@hirez.programming.kicks-ass.net>
References: <20230118153529.57695-1-andrzej.hajda@intel.com>
 <Y/ZLH5F8LA3H10aL@hirez.programming.kicks-ass.net>
 <17f40b7c-f98d-789d-fa19-12ec077b756a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17f40b7c-f98d-789d-fa19-12ec077b756a@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 10:24:19PM +0100, Andrzej Hajda wrote:
> On 22.02.2023 18:04, Peter Zijlstra wrote:
> > On Wed, Jan 18, 2023 at 04:35:22PM +0100, Andrzej Hajda wrote:
> > 
> > > Andrzej Hajda (7):
> > >    arch: rename all internal names __xchg to __arch_xchg
> > >    linux/include: add non-atomic version of xchg
> > >    arch/*/uprobes: simplify arch_uretprobe_hijack_return_addr
> > >    llist: simplify __llist_del_all
> > >    io_uring: use __xchg if possible
> > >    qed: use __xchg if possible
> > >    drm/i915/gt: use __xchg instead of internal helper
> > 
> > Nothing crazy in here I suppose, I somewhat wonder why you went through
> > the trouble, but meh.
> 
> If you are asking why I have proposed this patchset, then the answer is
> simple, 1st I've tried to find a way to move internal i915 helper to core
> (see patch 7).
> Then I was looking for possible other users of this helper. And apparently
> there are many of them, patches 3-7 shows some.
> 
> 
> > 
> > You want me to take this through te locking tree (for the next cycle,
> > not this one) where I normally take atomic things or does someone else
> > want this?
> 
> If you could take it I will be happy.

OK, I'll go queue it in tip/locking/core after -rc1. Thanks!
