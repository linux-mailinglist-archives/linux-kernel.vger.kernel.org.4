Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551646CCB65
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 22:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjC1UTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 16:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjC1UTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 16:19:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A2510C2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 13:19:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ED28BB81E5F
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 20:19:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62E5BC433D2;
        Tue, 28 Mar 2023 20:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680034763;
        bh=c4X4UarW8BUeoFTnNxKw16LGyvWcYJv8v6XPLNTgq9M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HnFfjScwgUayrZeU+4+PotXmOMlcQ0uQvWx4X0mQyTi+0UIOY/dUvlQOFMoU4NVga
         m0z4w/3ScXappDc9CQry31E4r/P9I3Ihj9KGIF1AvrVVpXxROK2VA+MLEk2fzD2R7g
         O9zpdUlwkl+GBmIUPgzScDLaAjxgaRwIbEcy8X44ktejkqY8yYl8NdQitfnB9lUboM
         DA3x4dmg5YgYhFNCcSHE3TliqCNqWWd8X41/OHT9GTGSlbAZNQmSRShJIroxSzuF/d
         +w8STkDOlB/gFcccD7SbXKkvJjVSaHffea0df3Gc5gk2NycZQ2DZCGCT068cYy7IbJ
         Aom7BAdrGw2XA==
Date:   Tue, 28 Mar 2023 13:19:21 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH 2/5] objtool: Combine '--backtrace' with '--verbose'
Message-ID: <20230328201921.ccl7p65le5aysa6j@treble>
References: <cover.1679932620.git.jpoimboe@kernel.org>
 <ef477e7cf3f188c623279764e831772eab2a4016.1679932620.git.jpoimboe@kernel.org>
 <20230328080743.GC4253@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230328080743.GC4253@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 10:07:43AM +0200, Peter Zijlstra wrote:
> On Mon, Mar 27, 2023 at 09:00:45AM -0700, Josh Poimboeuf wrote:
> > Get rid of the '--backtrace' option, instead including that
> > functionality in '--verbose'.  This makes it easy to gather all the
> > information needed for diagnosing objtool warnings.
> 
> Hurmm.. can't we have verbose imply backtrace but keep the separate
> option? I'm not sure if I always want the objdump thing -- esp with
> multiple warnings on vmlinux that's going to be really slow -- better to
> dump the whole of vmlinux.o once at the end.

That's a good point, vmlinux would be unbearable for multiple warnings.

We could accumulate a list of affected functions and then supply that to
objdump-func.sh at the end and dump them all at the same time.

objdump-func.sh would need to be changed to look for multiple funcs at
once.

If I do that, do you still want the separate backtrace option?

-- 
Josh
