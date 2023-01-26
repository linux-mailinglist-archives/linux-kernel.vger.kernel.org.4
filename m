Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988E467D561
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 20:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbjAZTeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 14:34:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjAZTed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 14:34:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DC35CFEE
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 11:34:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4700BB81EE0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 19:34:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5938EC433EF;
        Thu, 26 Jan 2023 19:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674761668;
        bh=BrWp0Cwv7dgQFnbBztKEsFGGY7vrfI5FQo9nNQNYFe4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NeT0CGAWhDVOBtyPn0u/Hg0Ye2l2TaXg9n6FDOIoujCJQhIlD2bKZTUbPidWvO3Hi
         h94U7zxxVb/ZF7mNLKzPwiFKcottakbG3RxuPrq7RupOFfsxXEeFsoeZjxbll2qs+D
         umYVj64Xpoxf558dwDdQ2XcyF8EnpDMRF91g3bhXCi7FOk5LL/B4DryWpnplcEyxCg
         g5qucrgT+FB5rfZdskYK3pSHhgWz2k6zClixkdq4X4gUkSRjsxy6NvtFxs5wOLJbvf
         g2BrOLZwafNYwmrMkfiRWkXk3dH1H9SnQLI4flSHIt0HIgekVUW07J9rFn3/+eFt8Z
         dNc+dDHXWN+dg==
Date:   Thu, 26 Jan 2023 11:34:26 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Stephane Eranian <eranian@google.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v4 0/3] objtool build improvements
Message-ID: <20230126193426.gu5vc3awe4kdmx2p@treble>
References: <20230126190606.40739-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230126190606.40739-1-irogers@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 11:06:03AM -0800, Ian Rogers wrote:
> Install libsubcmd and then get headers from there, this avoids
> inadvertent dependencies on things in tools/lib. Fix V=1
> support. Clean up how HOSTCC is used to override CC to avoid CFLAGS
> being set for say gcc, and then CC being overridden to clang.
> 
> v4. Rebase and look to address review comments from Josh Poimboeuf
>     <jpoimboe@kernel.org>. Removes the reviewed-by/tested-by given
>     the scope of changes.
> v3. Is a rebase that removes the merged "tools lib subcmd: Add install
>     target" patch. In:
> https://lore.kernel.org/lkml/CAKwvOd=kgXmpfbVa1wiEvwL0tX3gu+dDTGi-HEiRXSojwCLRrg@mail.gmail.com/
>     Nick rightly points out that:
> WARNINGS := $(EXTRA_WARNINGS) -Wno-switch-default -Wno-switch-enum -Wno-packed -Wno-nested-externs
>     became:
> WARNINGS := -Wno-switch-default -Wno-switch-enum -Wno-packed -Wno-nested-externs
>     losing the EXTRA_WARNINGS which v3 now adds back in. Previous
>     testing had added the warnings to the end rather than the
>     beginning, thereby causing unexpected build issues that aren't present in v3.
> v2. Include required "tools lib subcmd: Add install target" that is
>     already in Arnaldo's tree:
> https://lore.kernel.org/lkml/20221109184914.1357295-3-irogers@google.com/
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=perf/core&id=630ae80ea1dd253609cb50cff87f3248f901aca3
>     When building libsubcmd.a from objtool's Makefile, clear the
>     subdir to avoid it being appended onto OUTPUT and breaking the
>     build.
> 
> Ian Rogers (3):
>   objtool: Install libsubcmd in build
>   objtool: Properly support make V=1
>   objtool: Alter how HOSTCC is forced

Thanks, this looks pretty good.  I might tweak the patch subjects to
describe what's being fixed from a user's perspective.

I'll wait a few days for any more reviews before merging.

Independently from this patch set, I discovered that HOSTCFLAGS (and
KBUILD_HOSTCFLAGS which includes -O2 and some other flags) don't work
when building objtool directly from tools/objtool.  But they do work
(for me at least) when building from the top-level Makefile.  So I'm not
sure what Nick's issue is.

-- 
Josh
