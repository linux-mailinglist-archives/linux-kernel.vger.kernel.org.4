Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8208E68160D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 17:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237182AbjA3QMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 11:12:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236272AbjA3QMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 11:12:20 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696D042BDC
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 08:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=23pAo9JSVshof/GsDAaXnVhq9lqul+f0c6BSy4eq+zo=; b=RZ/491jdGkmzMV6UR4tEokPjxM
        QVrFJd0V0gIoQ7FxW5F5luq8VwZYRFhCIE/9XemzJbSdEcCpTIN3ORzitto9t4UrLfmsMNiwW6Bol
        pYcdJxt5Sgwm1aW09OqkOLUifmGd0UPiFXTTMPRrGiPjSM+yB2fXaG/p6sZ4VMWhyr6tf8EIzvKOF
        Lo1AQD/3Gu9wcYlHG5Z9jo8y44Km73kYM6rvonZ05p+p3CwM9r9uk6k7VlayaSjmUjSEBCRPz3M5k
        ntD7DVRiigghw1u2/5tOqwFtUlY+h95iE4Gx8dGgUusav+Muo2muZIf0F11T8czDu4xCfdwmamnXp
        vkdX+i4w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pMWlC-00AUKR-PL; Mon, 30 Jan 2023 16:11:59 +0000
Date:   Mon, 30 Jan 2023 16:11:58 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Sanan Hasanov <sanan.hasanov@knights.ucf.edu>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "contact@pgazz.com" <contact@pgazz.com>,
        "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
        Huang Ying <ying.huang@intel.com>
Subject: Re: kernel BUG in page_add_anon_rmap
Message-ID: <Y9fsTqMPzi9EIUKH@casper.infradead.org>
References: <IA1PR07MB983017D2FBA174D2FF78CEB6ABCE9@IA1PR07MB9830.namprd07.prod.outlook.com>
 <Y9LNCouUvsUFCYkT@casper.infradead.org>
 <adc9152e-c547-12ec-3538-006500619896@redhat.com>
 <713c6242-be65-c212-b790-2b908627c1b4@google.com>
 <9d8fb9c-1b81-67cd-e55b-34517388e1ab@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d8fb9c-1b81-67cd-e55b-34517388e1ab@google.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2023 at 10:49:31PM -0800, Hugh Dickins wrote:
> I guess it will turn out not to be relevant to this particular syzbug,
> but what do we expect an mbind() of just 0x1000 of a THP to do?
> 
> It's a subject I've wrestled with unsuccessfully in the past: I found
> myself arriving at one conclusion (split THP) in one place, and a contrary
> conclusion (widen range) in another place, and never had time to work out
> one unified answer.
> 
> So I do wonder what pte replaces the migration entry when the bug here
> is fixed: is it a pte pointing into the THP as before, in which case
> what was the point of "migration"? is it a Copy-On-Bind page?
> or has the whole THP been migrated?

I have an Opinion!

The important thing about THP (IMO) is the Transparency part.
Applications don't need to do anything special to get memory managed
in larger chunks, the only difference is in performance.  That is, they
get better performance if the kernel can do it, and thinks it worthwhile.

The tradeoff with THP is that we treat all memory in this 2MB chunk the
same way; we track its dirtiness and age as a single thing (position
on LRU, etc).  That assumes we're doing no harm, or less harm than we
would be tracking each page independently.

If userspace gives us a hint like "I want this range of memory on that
node", that's a strong signal that *this* range of memory is considered
by userspace to be a single unit.  So my opinion is that userspace is
letting us know that we previously made a bad decision and we should
rectify it by splitting now.

Zi Yan has a patch to allow pages to be split to arbitrary orders instead
of 0.  We should probably give that a review so that we're not making
the opposite mistake of tracking at too fine a granularity.

> I ought to read through those "estimated mapcount" threads more
> carefully: might be relevant, but I've not paid enough attention.

I'm not sure they're relevant to this, although obviously I'd love
your thoughts on how we could handle mapcount more efficiently.

