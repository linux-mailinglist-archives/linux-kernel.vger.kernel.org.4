Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29FED70753A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 00:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjEQWVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 18:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjEQWU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 18:20:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C753940F4
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 15:20:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 658CD64B99
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 22:20:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 842E5C433EF;
        Wed, 17 May 2023 22:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1684362029;
        bh=NytFsz7TaWpQ0xHSi4FEPFoDMRh4D1j2c+g6k9t3n5Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Aq61Wmrq0K6xc/wL30oB3UkxyHJ6Uh9hXcZBrdPGcHI4q5pNWgufSkg5RwAAWDNoD
         MAn83CSWtOuNJbqAT0yyjyU4mzXMtKbDQ3OTB5r9iKHpO6HXDytYgtMlea7n8vQKkP
         LRBlUK9k2mYMbLsmmZ6RPvWFyz1LyUsMWhbDNPzk=
Date:   Wed, 17 May 2023 15:20:28 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Michael Ellerman' <mpe@ellerman.id.au>,
        "glider@google.com" <glider@google.com>,
        "elver@google.com" <elver@google.com>,
        "zhangpeng.00@bytedance.com" <zhangpeng.00@bytedance.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] mm: kfence: Fix false positives on big endian
Message-Id: <20230517152028.86b6d2d5afa4541b4269131b@linux-foundation.org>
In-Reply-To: <826f836f41db41eeb0fc32061994ac39@AcuMS.aculab.com>
References: <20230505035127.195387-1-mpe@ellerman.id.au>
        <826f836f41db41eeb0fc32061994ac39@AcuMS.aculab.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 May 2023 16:02:17 +0000 David Laight <David.Laight@ACULAB.COM> wrote:

> From: Michael Ellerman
> > Sent: 05 May 2023 04:51
> > 
> > Since commit 1ba3cbf3ec3b ("mm: kfence: improve the performance of
> > __kfence_alloc() and __kfence_free()"), kfence reports failures in
> > random places at boot on big endian machines.
> > 
> > The problem is that the new KFENCE_CANARY_PATTERN_U64 encodes the
> > address of each byte in its value, so it needs to be byte swapped on big
> > endian machines.
> > 
> > The compiler is smart enough to do the le64_to_cpu() at compile time, so
> > there is no runtime overhead.
> > 
> > Fixes: 1ba3cbf3ec3b ("mm: kfence: improve the performance of __kfence_alloc() and __kfence_free()")
> > Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> > ---
> >  mm/kfence/kfence.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/mm/kfence/kfence.h b/mm/kfence/kfence.h
> > index 2aafc46a4aaf..392fb273e7bd 100644
> > --- a/mm/kfence/kfence.h
> > +++ b/mm/kfence/kfence.h
> > @@ -29,7 +29,7 @@
> >   * canary of every 8 bytes is the same. 64-bit memory can be filled and checked
> >   * at a time instead of byte by byte to improve performance.
> >   */
> > -#define KFENCE_CANARY_PATTERN_U64 ((u64)0xaaaaaaaaaaaaaaaa ^ (u64)(0x0706050403020100))
> > +#define KFENCE_CANARY_PATTERN_U64 ((u64)0xaaaaaaaaaaaaaaaa ^ (u64)(le64_to_cpu(0x0706050403020100)))
> 
> What at the (u64) casts for?
> The constants should probably have a ul (or ull) suffix.
> 

I tried that, didn't fix the sparse warnings described at
https://lkml.kernel.org/r/202305132244.DwzBUcUd-lkp@intel.com.

Michael, have you looked into this?

I'll merge it upstream - I guess we can live with the warnings for a while.
