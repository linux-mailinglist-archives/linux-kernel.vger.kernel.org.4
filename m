Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5108D602C08
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 14:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiJRMpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 08:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJRMpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 08:45:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED583BA923
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 05:45:24 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7F14F33CB0;
        Tue, 18 Oct 2022 12:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666097123; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sKipOqzSH18Zplx7+uC+JD42wmy1hZ3JXjFNsBc6m/s=;
        b=qao1nO00ADjQ8yQcW6uTOKI8ljAaHRmB0tSu8lw5e/PK0pix18uddsOLt+MH3eBQ6kHHGN
        iMaoqxdZGCKbEi17mTmgFLciNAgk61S6nYBJrgXvr444dB1mM9yHaH2bHJ5YYhySRLfjFI
        wX5QDMaYs8PbWBSCtXa5ZEbhfaohyZs=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 173632C141;
        Tue, 18 Oct 2022 12:45:23 +0000 (UTC)
Date:   Tue, 18 Oct 2022 14:45:20 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Jane Chu <jane.chu@oracle.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vsprintf: protect kernel from panic due to non-canonical
 pointer dereference
Message-ID: <Y06f4EwisLTU0rEz@alley>
References: <20221017191611.2577466-1-jane.chu@oracle.com>
 <Y02sENwhtpsx5yhP@smile.fi.intel.com>
 <5d987403-a7bf-8996-d639-c99edeaabcdf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d987403-a7bf-8996-d639-c99edeaabcdf@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-10-17 19:31:53, Jane Chu wrote:
> On 10/17/2022 12:25 PM, Andy Shevchenko wrote:
> > On Mon, Oct 17, 2022 at 01:16:11PM -0600, Jane Chu wrote:
> >> While debugging a separate issue, it was found that an invalid string
> >> pointer could very well contain a non-canical address, such as
> >> 0x7665645f63616465. In that case, this line of defense isn't enough
> >> to protect the kernel from crashing due to general protection fault
> >>
> >> 	if ((unsigned long)ptr < PAGE_SIZE || IS_ERR_VALUE(ptr))
> >>                  return "(efault)";
> >>
> >> So instead, use kern_addr_valid() to validate the string pointer.
> > 
> > How did you check that value of the (invalid string) pointer?
> > 
> 
> In the bug scenario, the invalid string pointer was an out-of-bound 
> string pointer. While the OOB referencing is fixed,

Could you please provide more details about the fixed OOB?
What exact vsprintf()/printk() call was broken and eventually
how it was fixed, please?

> the lingering issue
> is that the kernel ought to be able to protect itself, as the pointer 
> contains a non-canonical address.

Was the pointer used only by the vsprintf()?
Or was it accessed also by another code, please?

I wonder if this patch would prevent the crash or if the broken
kernel would crash later anyway.

> That said, I realized that not all
> architecture implement meaningful kern_addr_valid(), so this line
>     if ((unsigned long)ptr < PAGE_SIZE || IS_ERR_VALUE(ptr))
> is still need.  I'll send v2.

Please, add linux-mm@kvack.org into CC. I wonder if kern_addr_valid()
is safe to use anywhere, especially during early boot. I wonder if
it would make sense to implement it on all architectures.

Best Regards,
Petr
