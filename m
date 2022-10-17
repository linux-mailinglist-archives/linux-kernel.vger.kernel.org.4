Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC45600F94
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 14:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiJQMyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 08:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiJQMyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 08:54:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140F91D31B;
        Mon, 17 Oct 2022 05:54:50 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A605A20600;
        Mon, 17 Oct 2022 12:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666011289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e2PdxLW6+r2pi48yfBDZ5ggNpMgA3AiGQmAM/6SfZRo=;
        b=k4/lzhhkSNarfdJL1YvllZxTxqo6AnHSGLSwI+vJHWEaLRA65NddClMbKjlIQ1PEV/72kG
        TLmSusfHmWupditnWdIR21asSISuHyAI+Pyopn/TbnS7QAP0ccVfkR32wPK1ep0N1UzbZX
        HXAwvKSkqO0FPTuZuzaa9kfkTNt1ZUg=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 880532C143;
        Mon, 17 Oct 2022 12:54:49 +0000 (UTC)
Date:   Mon, 17 Oct 2022 14:54:46 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Petr Pavlu <petr.pavlu@suse.com>
Cc:     mcgrof@kernel.org, david@redhat.com, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] module: Merge same-name module load requests
Message-ID: <Y01Qlp0E+3FJVVWW@alley>
References: <20221016123031.3963-1-petr.pavlu@suse.com>
 <20221016123031.3963-4-petr.pavlu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221016123031.3963-4-petr.pavlu@suse.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2022-10-16 14:30:30, Petr Pavlu wrote:
> During a system boot, it can happen that the kernel receives a burst of
> requests to insert the same module but loading it eventually fails
> during its init call. For instance, udev can make a request to insert
> a frequency module for each individual CPU when another frequency module
> is already loaded which causes the init function of the new module to
> return an error.
> 
> The module loader currently serializes all such requests, with the
> barrier in add_unformed_module(). This creates a lot of unnecessary work
> and delays the boot. It can prevent udev from loading drivers for other
> devices and might cause timeouts of services waiting on them and
> subsequently a failed boot.
> 
> The mentioned serialization was introduced as a side-effect of commit
> 6e6de3dee51a. The kernel before that merged some of same load requests
> although it was more by accident and relied on specific timing. The
> patch brings this behavior back in a more explicit form.
> 
> The logic is improved as follows:
> * A check whether a module load matches an already loaded module is
>   moved right after a module name is determined. -EEXIST continues to be
>   returned if the module exists and is live, -EBUSY is returned if
>   a same-name module is going.
> * A new reference-counted shared_load_info structure is introduced to
>   keep track of duplicate load requests. Two loads are considered
>   equivalent if their module name matches. In case a load duplicates
>   another running insert, the code waits for its completion and then
>   returns -EEXIST or -EBUSY depending on whether it succeeded.
> 
> Moving the check for same-name module loads earlier has also a positive
> effect on reducing memory pressure. For instance, David Hildenbrand and
> Lin Liu reported [1] that when KASAN_INLINE is enabled (resulting in
> large module size), with plenty of devices that udev wants to probe and
> with plenty of CPUs that can carry out that probing concurrently, the
> system can actually run out of module vmap space and trigger vmap
> allocation errors. This is fixed by the patch too as it avoids duplicate
> layout_and_allocate() work.
> 
> [1] https://lore.kernel.org/all/20221013180518.217405-1-david@redhat.com/
> 
> Fixes: 6e6de3dee51a ("kernel/module.c: Only return -EEXIST for modules that have finished loading")
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>

All these tags should be in the order of (logical) appearance.
Somethings like:

Suggested-by:  if any
Signed-off-by: author of the patch
Acked-by:      in order of appearance
Revived-by:   in order of appearance
Tested-by:     in order of appearance
Signed-off-by: committer (upstream maintainer)


I know that I provided Reviewed-by before you did the final changes.
Well, you could use my tag only when you did only cosmetic changes or
changes that I requested. You expect that I would agree with the patch
even after it was updated.

Best Regards,
Petr
