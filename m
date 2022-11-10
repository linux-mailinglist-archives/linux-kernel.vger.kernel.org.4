Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2FFB6248FD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 19:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbiKJSDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 13:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbiKJSD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 13:03:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE774B983
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 10:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0lolm9EzIEZe48IwqLoW/AKyDhF3rMTovRRwaEQ3o6o=; b=b59SJKKUXJz1oAvXbChneQ4BvU
        xfjBc1daZrvE3OhJmkmnl96HbBxGs9dPK4SLG6NBkHuXSDdoOmwxs57ia6oYTkNO7aFAvNM+n+Usd
        nEyVfYAnFJSYa5DzjaKs+FNxoRaaAYxrWLkX+H9jhYTdcqEgbSArzskCthAuefHQsvN60BNXhIPNh
        VF3xBG6PuOZMMet6udUx4W/E0BmtXBpWiHsYredG7OGcA7UeHOt2WBmISGzF0TB/VkwL97MNFOTYw
        scCvFdiy9E2++jubutBQ2R1Wdspbfo3c9Ez91ep8Rwc7G88aW0/Z9CUf0xHnPu3qXyC1hldzw9vzR
        F5eF1BEg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1otBsr-00CHEo-Tl; Thu, 10 Nov 2022 18:02:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 30366300209;
        Thu, 10 Nov 2022 19:02:31 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D7F512BB18BC7; Thu, 10 Nov 2022 19:02:31 +0100 (CET)
Date:   Thu, 10 Nov 2022 19:02:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86@kernel.org, dave.hansen@intel.com,
        linux-kernel@vger.kernel.org, oliver.sang@intel.com
Subject: Re: [PATCH 1/4] x86/mm: Add a few comments
Message-ID: <Y208t7Lw9n+3CNz3@hirez.programming.kicks-ass.net>
References: <20221110125253.240704966@infradead.org>
 <20221110125544.460677011@infradead.org>
 <CAHk-=wg8UrshBBLioF0+FaJvAkSTRkH3-aqKT3eAWHtBp57hxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg8UrshBBLioF0+FaJvAkSTRkH3-aqKT3eAWHtBp57hxw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 08:22:54AM -0800, Linus Torvalds wrote:
> On Thu, Nov 10, 2022 at 4:58 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > It's a shame to hide useful comments in Changelogs, add some to the
> > code.
> >
> > Shamelessly stolen from commit:
> 
> When the comment says how the image is mapped into two places,
> wouldn't it be good to also have the reason *why* rather than just
> what..

Agreed, and I think I can actually answer this. How about I change it
into something like this:

/*
 * The kernel image is mapped into two places in the virtual address space
 * (addresses without KASLR, of course):
 *
 * 1. The kernel direct map (0xffff880000000000)
 * 2. The "high kernel map" (0xffffffff81000000)
 *
 * We actually execute out of #2. If we get the address of a kernel symbol, it
 * points to #2, but almost all physical-to-virtual translations point to #1.
 *
 * This is so that we can have both a directmap of all physical memory
 * *and* take full advantage of the limited (s32) immediate addressing
 * range (2G) of x86_64.
 *
 * See Documentation/x86/x86_64/mm.rst for more details.
 */

> That said, my real commentary for this patch set is not that
> particular instance, but the bigger picture - that this code is still
> a bit opaque as to why these things are done.

Yes, small steps I suppose. It took me way longer than it should have to
figure out what this code was actually doing. And why we shouldn't
propagate those NX bits in the various cases.

> Do we need any of those alias passes at all for pure protection bit
> changes? I thought we only did these because things like cacheability
> bits have to be in sync due to machine checks etc?
> 
> Or am I missing some case where writability matters too?

I _think_, but I'm not actually sure, that it matters in exactly that
case dhansen mentions, where we do a physical to virtual address
translation and expect access to match whatever alias we originally came
from.
