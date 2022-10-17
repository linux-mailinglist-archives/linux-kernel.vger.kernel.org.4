Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F25601258
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 17:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbiJQPC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 11:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbiJQPCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 11:02:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3121006D
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 08:02:19 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C102E34302;
        Mon, 17 Oct 2022 14:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666018640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YwPRndPIKbMGfHiI0+b6VWLwGq2HJgw8Lxgojln60d0=;
        b=HKcy6ZR4cdX6/c9CqhGRg4sgBXQwSPhSamrRzBggpNOrM/tvut9/JdMLFIUmb5wlS6fPOK
        uo/3BpWgSmEgh3TH1CfXLT+jL/8jp89dQ2gvllD/ZS+FXc1N0Yia7Zp1urELENWZd+6mpr
        0D/ZFHle+DPIACKhWgMYKeRGe14e4Z8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666018640;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YwPRndPIKbMGfHiI0+b6VWLwGq2HJgw8Lxgojln60d0=;
        b=hmgiBOoEphiWs8FNXs041Qr6u6sF6OybuJeezD2qfhPru+YQzZFSMBHfVKpNbBh3BtTFtp
        qjVN/enU8IxS1uBQ==
Received: from suse.de (mgorman.tcp.ovpn2.nue.suse.de [10.163.32.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id AA9512C141;
        Mon, 17 Oct 2022 14:57:17 +0000 (UTC)
Date:   Mon, 17 Oct 2022 15:57:12 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Linus Torvalds <torvalds@linuxfoundation.org>
Cc:     Nadav Amit <nadav.amit@gmail.com>, Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Rik van Riel <riel@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <sasha.levin@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [BUG?] X86 arch_tlbbatch_flush() seems to be lacking
 mm_tlb_flush_nested() integration
Message-ID: <20221017145712.5tdedsrrkbopptzl@suse.de>
References: <CAG48ez0B18eh3Q1853Cug8WSip7dPb2G9fhgqsPWzr0D_TBjRQ@mail.gmail.com>
 <0484E294-D6D6-45CE-87F7-5AFDA5309BA1@gmail.com>
 <CAHk-=wh+dMSbeuEDatZbtycm9_RFyLe60nigQA8o5w0W_HkQSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAHk-=wh+dMSbeuEDatZbtycm9_RFyLe60nigQA8o5w0W_HkQSg@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 15, 2022 at 04:47:16PM -0700, Linus Torvalds wrote:
> On Fri, Oct 14, 2022 at 8:51 PM Nadav Amit <nadav.amit@gmail.com> wrote:
> >
> > Unless I am missing something, flush_tlb_batched_pending() is would be
> > called and do the flushing at this point, no?
> 
> Ahh, yes.
> 
> That seems to be doing the right thing, although looking a bit more at
> it, I think it might be improved.
> 

To be fair, I originally got it wrong and Nadav caught it almost 2 years
later. However, I think the current behaviour is still ok.

> At least in the zap_pte_range() case, instead of doing a synchronous
> TLB flush if there are pending batched flushes, it migth be better if
> flush_tlb_batched_pending() would set the "need_flush_all" bit in the
> mmu_gather structure.
> 

I think setting need_flush_all would miss the case if no PTEs were updated
due to a race during unmap. I think it would be safer to check for deferred
TLB flush in mm_tlb_flush_nested but didn't dig too deep.

> That would possibly avoid that extra TLB flush entirely - since
> *normally* fzap_page_range() will cause a TLB flush anyway.
> 
> Maybe it doesn't matter.
> 

While it could be better, I still think the simple approach is sufficient
and it can be used in each affected area. For example, move_ptes does not
use mmu_gather and either that would have to be converted to use mmu_gather
or have mmu_gather and !mmu_gather detection of deferred TLB flushing from
reclaim context and I'm not sure it's worth it.

Once reclaim is active, the performance is slightly degraded as TLBs
are being flushed anyway and it's possible that active pages are being
reclaimed that will have to be refaulted which is even more costly. For the
scenario Jann was concerned with, pages belonging to the task are being
reclaimed while mmap/munmap operations are also happening. munmap/mmap
is sufficiently expensive that a spurious flush due to parallel reclaim
should have negligible additional overhead and I'd be surprised if the
additional runtime cost can be reliably measured.

-- 
Mel Gorman
SUSE Labs
