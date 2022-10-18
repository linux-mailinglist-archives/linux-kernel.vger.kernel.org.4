Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261D06036B4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 01:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiJRXjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 19:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJRXjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 19:39:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783D7C8209
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 16:38:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D90E2B8218A
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 23:38:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A61C433C1;
        Tue, 18 Oct 2022 23:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666136336;
        bh=esm08ZulWwZ80WMHJ6WXGV+D01NZx6TnxbzZ8V0xbFQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RU4sxfZU6VWLNJWMi2463MZILGF+3y9ghSy3+WCddc4NvggJshJFs5LIaZdNgu74K
         Tvfv4JuOtLZnRdoLSA6QtMpY4skIWOQTNttItNhhTxlzJ8vjOW7yv5D59CJjyKhmME
         M4lzxopDiWwE5QHD+hRH7HPk8EdimkM7lva1sOC5WukLc/FMFqbP2ATaZYZqQ81GJ3
         2I8pf5DwEgSY4rXFH6OivXIg1L1KhwYRE8Tf45xCDK2+URu0DulDZIbsn9vOs7iRyf
         cUDoEgy8jG1we5Trw0FOW+FKcFpB0qJAf8S0/8fCaMp9tdKx1kdWZoge052puqj+Sb
         z8a4u5xOL9uYQ==
Date:   Tue, 18 Oct 2022 16:38:54 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/ibt: Implement FineIBT
Message-ID: <20221018233854.qj3vrdxsnc6ds7qs@treble>
References: <Y06rtoE9BsERG9uv@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y06rtoE9BsERG9uv@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 03:35:50PM +0200, Peter Zijlstra wrote:
> 
> Implement an alternative CFI scheme that merges both the fine-grained
> nature of kCFI but also takes full advantage of the coarse grained
> hardware CFI as provided by IBT.
> 
> To contrast:
> 
>   kCFI is a pure software CFI scheme and relies on being able to read
> text -- specifically the instruction *before* the target symbol, and
> does the hash validation *before* doing the call (otherwise control
> flow is compromised already).
> 
>   FineIBT is a software and hardware hybrid scheme; by ensuring every
> branch target starts with a hash validation it is possible to place
> the hash validation after the branch. This has several advantages:
> 
>    o the (hash) load is avoided; no memop; no RX requirement.
> 
>    o IBT WAIT-FOR-ENDBR state is a speculation stop; by placing
>      the hash validation in the immediate instruction after
>      the branch target there is a minimal speculation window
>      and the whole is a viable defence against SpectreBHB.
> 
> Obviously this patch relies on kCFI (upstream), but additionally it also
> relies on the padding from the call-depth-tracking patches
> (tip/x86/core). It uses this padding to place the hash-validation while
> the call-sites are re-written to modify the indirect target to be 16
> bytes in front of the original target, thus hitting this new preamble.

Can the objtool changes be moved to a separate patch?

The RFC was 11 patches, is it now much smaller because of the new
dependencies?  The RFC had some eBPF changes and a test module, are
those no longer needed?

-- 
Josh
