Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8481613BD0
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 17:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbiJaQ64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 12:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbiJaQ6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 12:58:48 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 16296DFB0;
        Mon, 31 Oct 2022 09:58:47 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.50.127])
        by linux.microsoft.com (Postfix) with ESMTPSA id A1AB620B9F80;
        Mon, 31 Oct 2022 09:58:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A1AB620B9F80
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1667235526;
        bh=WCeWx4JsP2/hoZYvwwN1qjJP0udG2YITWUcVCXmsFuQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N/psBIZq1k58WvtXr5Pvp1oCsCWQPxUFLtlycs3HZjIIKGWPn1ctZJU5L02N+aUsc
         JiJ/Y1P1VKcBOBCptNvycvQZTtPDJL5KZFNvmhvitYps1SPvz3nnhDTu56uQAeiNre
         aawgHMFCVs1KJJktuNpf02+3HMJ/GAYAcOYtKsZk=
Date:   Mon, 31 Oct 2022 09:58:41 -0700
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org,
        dcook@linux.microsoft.com, alanau@linux.microsoft.com,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] tracing/user_events: Fixup enable faults asyncly
Message-ID: <20221031165841.GA149@W11-BEAU-MD.localdomain>
References: <20221027224011.2075-1-beaub@linux.microsoft.com>
 <20221027224011.2075-3-beaub@linux.microsoft.com>
 <7697b674-1dab-4995-9589-9dfb2a65bb73@efficios.com>
 <20221028223545.GA182@W11-BEAU-MD.localdomain>
 <c6799933-d84b-e4dc-433c-bf1acc9ba03a@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6799933-d84b-e4dc-433c-bf1acc9ba03a@efficios.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2022 at 10:23:02AM -0400, Mathieu Desnoyers wrote:
> On 2022-10-28 18:35, Beau Belgrave wrote:
> > On Fri, Oct 28, 2022 at 06:07:34PM -0400, Mathieu Desnoyers wrote:
> > > On 2022-10-27 18:40, Beau Belgrave wrote:
> 
> [...]
> 
> > 
> > > I'm still slightly unsure about using "uint32_t" for enable check, or going
> > > for "unsigned long". The core question there is whether a 32-bit word test
> > > would cause partial register stalls on 64-bit architectures. Going for
> > > unsigned long would require that user events receives information about the
> > > bitness of the word as input from userspace. (bit=63 rather than 31).
> > > Perhaps this is something the user events ABI should accommodate by
> > > reserving more than 5 bits to express the target bit ?
> > > 
> > 
> > Yeah, I thought about this. From the user side you can actually use any
> > arbitrary bits you want by passing a 32-bit aligned value. So you could
> > take the lower or top half of a 64-bit value. The reason I limit to 0-31
> > bits is to ensure no page straddling occurs. Futex also does this, check
> > out get_futex_key() in kernel/futex/core.c.
> 
> We can ensure no page straddling by checking the address alignment compared
> to the size of the integer (4 or 8 bytes) also received as input.
> 

Ok.

> > 
> > I would recommend trying out uint64 but give the upper half to
> > user_events ABI and checking if that works for you if you want say 63
> > bits to user space. You'd tell the ABI bit 31, but in user space it
> > would be bit 63.
> 
> That's tricky because Linux supports both big and little endian, which will
> make the ABI tricky to use if we try to be too clever about this.
> 
> Also, just stating a "pointer" and "bits offset" is not enough if we want to
> support 32-bit and 64-bit integer types, because the bit offset does not
> consider endianness.
> 
> I would recommend to get the following information through the user events
> registration:
> 
> - pointer address,
> - size of integer type (4 or 8 bytes),
> - bit offset (currently 31 or 63).
> 
> This way we have all the information we need to set the right bit in both
> little and big endian. We also have all the information we need to validate
> natural alignment, e.g.:
> 
> /* Check alignment */
> if (addr & (type_size - 1))
> 	return -EINVAL;
> /* Check bit offset range */
> if (bit_offset > (type_size * CHAR_BIT) - 1)
> 	return -EINVAL;
> switch (type_size) {
> case 4:
> 	/* Update 32-bit integer */
> 	break;
> #if BITS_PER_LONG >= 64
> case 8:
> 	/* Update 64-bit integer */
> 	break;
> #endif
> default:
> 	return -EINVAL;
> }
> 

Sounds good, I'll update this.

> 
> > 
> > > > 
> > > > The enable address is disabled while the async fault-in occurs. This
> > > > ensures that we don't attempt fault-in more than is necessary. Once the
> > > > page has been faulted in, the address write is attempted again. If the
> > > > page couldn't fault-in, then we wait until the next time the event is
> > > > enabled to prevent any potential infinite loops.
> > > 
> > > So if the page is removed from the page cache between the point where it is
> > > faulted in and the moment the write is re-attempted, that will not trigger
> > > another attempt at paging in the page, am I correct ?
> > > 
> > 
> > If we fault and the fixup user fault fails still with retries, then we
> > give up until the next enablement of that site.
> > 
> > However, if we fault and the fixup user fault with retries works, and
> > then we fault again trying to write, that will retry.
> > 
> > > I would think this is unexpected. I would expect that failing to fault in
> > > the page would stop any further attempts, but simply failing to pin the page
> > > after faulting it in should simply try again.
> > > 
> > 
> > The issue I repro is mmap() register the enable at that location, then
> > unmap(). All the faulting errors just tell you -EFAULT in this case,
> > even though it was maliciously removed. In this case you could get the
> > kernel to infinite loop trying to page it in.
> > 
> > > Thoughts ?
> > > 
> > 
> > We need to have some sanity toward giving up faulting in data that never
> > will make it. The code currently assigns that line to if
> > fixup_user_fault with retries fails, we give up. pin_user_pages_remote
> > will not stop it from being attempted again.
> 
> What are the legitimate cases that can make fixup_user_fault fail ? If there
> are none, and the only case that can make this fail is userspace unmapping
> memory, then we should very well kill the offending process.
> 

I believe only VM_FAULT_ERROR:
#define VM_FAULT_ERROR (VM_FAULT_OOM | VM_FAULT_SIGBUS |	\
			VM_FAULT_SIGSEGV | VM_FAULT_HWPOISON |	\
			VM_FAULT_HWPOISON_LARGE | VM_FAULT_FALLBACK)

I don't believe in any of the above cases we should retry indefinitely
for.

> An example here is futex fault_in_user_writeable(). When it fails, it
> appears that the futex_wake_op simply returns -EFAULT to the caller.
> 

fault_in_user_writeable() calls fixup_user_fault(), so it should be the
same scenario / failures as above.

> Thanks,
> 
> Mathieu
> 
> > 
> > > Thanks,
> > > 
> > > Mathieu
> > > 
> > 
> > Thanks,
> > -Beau
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com

Thanks,
-Beau
