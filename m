Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD9D6A3F87
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 11:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjB0Kgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 05:36:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjB0Kgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 05:36:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3852A7D9B;
        Mon, 27 Feb 2023 02:36:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA324B80CAE;
        Mon, 27 Feb 2023 10:36:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E1B1C433EF;
        Mon, 27 Feb 2023 10:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677494209;
        bh=md2f8wVmhFytsIMqZYZ7qynQvaxLEApyCdRzFNqQ1Hg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jUH6S2Oaup33tRWsqvK+nqRw5poomPgCXowCEZWxAj0dV1G3QMtYxv2HJ/OXZ3FHJ
         8riU48ONgJgH/TEMNrG+ez8/urspmRKn4nD/RvciD7u3WOx9IPRWLTAQ9twzPwBnAk
         Bt71bXAvQqdLzteF2WfYLx8UQiZpo15CUTnITI4/wLEPoRFX4oVyZnANffJyfVHr6q
         m6umnh+HqHS/SDQVKiPFH6FK7d3B6loL4K+8wIfYtkoFhCCljIzZuh6bZYoGd/ik6s
         RG/MGWsLNLnbibLZerHTwcMrrqmFI1l9i1yXBxV9Bp9wQ2JhmRpXcZePNhanL/FfF7
         Le0wQFJXQAnWg==
Date:   Mon, 27 Feb 2023 11:36:44 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian@brauner.io>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mm tree
Message-ID: <20230227103644.6mxd3uldp7rkawbh@wittgenstein>
References: <20230130161414.25a71a87@canb.auug.org.au>
 <20230130080956.ikb3w5cjkhtxqzcr@wittgenstein>
 <20230227091803.5e29b563@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230227091803.5e29b563@canb.auug.org.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 09:18:03AM +1100, Stephen Rothwell wrote:
> Hi Christian,
> 
> On Mon, 30 Jan 2023 09:09:56 +0100 Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Mon, Jan 30, 2023 at 04:14:14PM +1100, Stephen Rothwell wrote:
> > > Hi all,
> > > 
> > > After merging the mm tree, today's linux-next build (powerpc
> > > ppc64_defconfig) failed like this:
> > > 
> > > kernel/sys.c: In function '__do_sys_prctl':
> > > kernel/sys.c:2664:9: error: duplicate case value
> > >  2664 |         case PR_SET_HIDE_SELF_EXE:
> > >       |         ^~~~
> > > kernel/sys.c:2655:9: note: previously used here
> > >  2655 |         case PR_SET_MDWE:
> > >       |         ^~~~
> > > kernel/sys.c:2669:9: error: duplicate case value
> > >  2669 |         case PR_GET_HIDE_SELF_EXE:
> > >       |         ^~~~
> > > kernel/sys.c:2658:9: note: previously used here
> > >  2658 |         case PR_GET_MDWE:
> > >       |         ^~~~
> > > 
> > > Caused by commit
> > > 
> > >   ab30677b499c ("mm: implement memory-deny-write-execute as a prctl")
> > > 
> > > interacting with commit
> > > 
> > >   966eb1ba050d ("exec: add PR_HIDE_SELF_EXE prctl")
> > > 
> > > from the pidfd tree.
> > > 
> > > I have applied the following merge fix patch.
> > > 
> > > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > > Date: Mon, 30 Jan 2023 16:08:34 +1100
> > > Subject: [PATCH] mm: fixup for "mm: implement memory-deny-write-execute as a prctl"
> > > 
> > > interacting with
> > > 
> > >   966eb1ba050d ("exec: add PR_HIDE_SELF_EXE prctl")
> > > 
> > > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > > ---  
> > 
> > Thanks Stephen,
> > 
> > I'm moving this out of -next for now until we've settled a few more
> > details.
> 
> I am still applying this to the merge of the pidfd tree.  Also I
> noticed that a similar fixup will need to be applied to
> tools/testing/selftests/prctl/hide-self-exe.c

Sorry Stephen, I forgot to drop the patches from this branch. I dropped
them now. Let me know if you still see issues.
