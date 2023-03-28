Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43036CCB6E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 22:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjC1UWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 16:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjC1UWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 16:22:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BADB1FD8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 13:22:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9EFA2B81CAB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 20:22:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34E4EC433D2;
        Tue, 28 Mar 2023 20:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680034927;
        bh=54nMkls0+I29HMEM1YCHcejfYPJPJVWADs2YaBN33sw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KZUnYdIOdDiJtnu7j2PijSL5084ft6vcFDLeUBBtbtPMLaj7m/84vxZxKnFQsqBpn
         XRaTLvIlD3OS0q8KB5r+/EBbwIztblt8V7FpUE8/z9W0FvEZc0lLGXJB37hhkcRRds
         1XoSyNn8yPyKzNnExDsXFgwUP3vrjl6VNCWmqC5KBiL8HvH7zIQ0MCPhprGQFhF1SS
         plP/T7P5++OtFywJfUnqymBaZ8D3G4fO+bwbZua5JBSpe/KLJIjKtKzbIsVAFz7np6
         lIior2JwoFrl7dUz2QZ+JfZ9tWQY9qix5DLUzeaZnuEMCmcBDGS4xk9yenS1xlM+xp
         IrIQmG24p8YnQ==
Date:   Tue, 28 Mar 2023 13:22:05 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] objtool: Add per-function rate limiting for
 unreachable warnings
Message-ID: <20230328202205.cfd7hvpj74rv7ry4@treble>
References: <cover.1679932620.git.jpoimboe@kernel.org>
 <b21f7791b30c54cf8c4d0f489decdc4a47a18963.1679932620.git.jpoimboe@kernel.org>
 <20230328081105.GD4253@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230328081105.GD4253@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 10:11:05AM +0200, Peter Zijlstra wrote:
> On Mon, Mar 27, 2023 at 09:00:47AM -0700, Josh Poimboeuf wrote:
> > Unreachable instruction warnings are rate limited to once per object
> > file.  That no longer makes sense for vmlinux validation, which might
> > have other unreachable instructions lurking in other places.  Change it
> > to once per function.
> 
> Do we want a negative option to disable this? --no-ratelimit or such?

Per-function rate-limiting is almost always the right thing, personally
I don't envision needing to disable it.

-- 
Josh
