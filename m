Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F3F65514C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 15:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiLWOXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 09:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbiLWOXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 09:23:20 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BDB27CF8;
        Fri, 23 Dec 2022 06:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671805399; x=1703341399;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ELTp1mLG7Y9aCL8aO+3yggqOoksNOYkU+LC/pmwgzyA=;
  b=h6WHojs6ZpmqWpG2ottoZdl2pYgLLN2M3eW5A5tU9xF/OQlsT/3lk21H
   c+27dZk3j5L1dN6yN+xTy/Nw2p/XcwLUfb5INN1T1g/0ViZeKJo5dasVa
   2aM6Qe9tY1i/8kBLtimzGb9etHds0Vj1ICf1c6EWPlU8veg+mh8GlRw1f
   H1RVwid1/AgXqzvKKGomudHa9NdK5cWPCTVhnP/tSl3PViN1cgTQlPXxG
   AQqDeqzUnhnC4/YrPK4vlFEzcvUOFF7jMGVaZIH/9U4/Af3L+SOw42Fzh
   ybnz3reqKRmJRugCywjpmYvBfkXpozGjqKHcppjmrXomjjgBb2U1Jx0jJ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10570"; a="322279538"
X-IronPort-AV: E=Sophos;i="5.96,268,1665471600"; 
   d="scan'208";a="322279538"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2022 06:23:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10570"; a="897539227"
X-IronPort-AV: E=Sophos;i="5.96,268,1665471600"; 
   d="scan'208";a="897539227"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by fmsmga006.fm.intel.com with ESMTP; 23 Dec 2022 06:23:13 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 2BNENBXm013561;
        Fri, 23 Dec 2022 14:23:11 GMT
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@vger.kernel.org,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, Arnd Bergmann <arnd@arndb.de>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 00/19] Introduce __xchg, non-atomic xchg
Date:   Fri, 23 Dec 2022 15:23:00 +0100
Message-Id: <20221223142300.1820652-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221222092147.d2bb177c67870884f2e59a9b@linux-foundation.org>
References: <20221222114635.1251934-1-andrzej.hajda@intel.com> <20221222092147.d2bb177c67870884f2e59a9b@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 22 Dec 2022 09:21:47 -0800

> On Thu, 22 Dec 2022 12:46:16 +0100 Andrzej Hajda <andrzej.hajda@intel.com> wrote:
> 
> > Hi all,
> > 
> > I hope there will be place for such tiny helper in kernel.
> > Quick cocci analyze shows there is probably few thousands places
> > where it could be useful.
> 
> So to clarify, the intent here is a simple readability cleanup for
> existing open-coded exchange operations.  The intent is *not* to
> identify existing xchg() sites which are unnecessarily atomic and to
> optimize them by using the non-atomic version.
> 
> Have you considered the latter?
> 
> > I am not sure who is good person to review/ack such patches,
> 
> I can take 'em.
> 
> > so I've used my intuition to construct to/cc lists, sorry for mistakes.
> > This is the 2nd approach of the same idea, with comments addressed[0].
> > 
> > The helper is tiny and there are advices we can leave without it, so
> > I want to present few arguments why it would be good to have it:
> > 
> > 1. Code readability/simplification/number of lines:
> > 
> > Real example from drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c:
> > -       previous_min_rate = evport->qos.min_rate;
> > -       evport->qos.min_rate = min_rate;
> > +       previous_min_rate = __xchg(evport->qos.min_rate, min_rate);
> > 
> > For sure the code is more compact, and IMHO more readable.
> > 
> > 2. Presence of similar helpers in other somehow related languages/libs:
> > 
> > a) Rust[1]: 'replace' from std::mem module, there is also 'take'
> >     helper (__xchg(&x, 0)), which is the same as private helper in
> >     i915 - fetch_and_zero, see latest patch.
> > b) C++ [2]: 'exchange' from utility header.
> > 
> > If the idea is OK there are still 2 qestions to answer:
> > 
> > 1. Name of the helper, __xchg follows kernel conventions,
> >     but for me Rust names are also OK.
> 
> I like replace(), or, shockingly, exchange().
> 
> But...   Can we simply make swap() return the previous value?
> 
> 	previous_min_rate = swap(&evport->qos.min_rate, min_rate);

Unforunately, swap()'s arguments get passed by names, not as
pointers, so you can't do

	swap(some_ptr, NULL);

 -- pretty common pattern for xchg.

Thanks,
Olek
