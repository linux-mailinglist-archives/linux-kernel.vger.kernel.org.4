Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3456F0297
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 10:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243115AbjD0IbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 04:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243044AbjD0Ia5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 04:30:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1845635A6;
        Thu, 27 Apr 2023 01:30:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FAB263B95;
        Thu, 27 Apr 2023 08:30:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B45CFC433D2;
        Thu, 27 Apr 2023 08:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682584255;
        bh=IjxCeFXNKWQY8KVcSMtLu5/gGhTGtBIACEOnd4UUKAY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DnWrxOYe0uv6FWThGph9NFDloKu5HSdxqADr2R2ACQAoVF9AKj/K04MBdUrKI6NeA
         1jvnvbsfsYNxW7wYtnLOOrza9gQK0Yt5O8XPasYy3PavJ9B9ubsXyXHdU/3kdVgmx7
         UOeOMN9DxOSWld/wjXnWg4dPf9s1NYn/Pkh1I3yU=
Date:   Thu, 27 Apr 2023 10:30:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, David Gow <davidgow@google.com>,
        Sergio =?iso-8859-1?Q?Gonz=E1lez?= Collado 
        <sergio.collado@gmail.com>, Richard Weinberger <richard@nod.at>,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org
Subject: Re: [PATCH AUTOSEL 6.1 04/13] rust: arch/um: Disable FP/SIMD
 instruction to match x86
Message-ID: <2023042745-unclasp-briar-5b2a@gregkh>
References: <20230314124325.470931-4-sashal@kernel.org>
 <20230425000118.45838-1-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230425000118.45838-1-sj@kernel.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 12:01:18AM +0000, SeongJae Park wrote:
> Hello Sasha and Greg,
> 
> 
> On Tue, 14 Mar 2023 08:43:16 -0400 Sasha Levin <sashal@kernel.org> wrote:
> 
> > From: David Gow <davidgow@google.com>
> > 
> > [ Upstream commit 8849818679478933dd1d9718741f4daa3f4e8b86 ]
> > 
> > The kernel disables all SSE and similar FP/SIMD instructions on
> > x86-based architectures (partly because we shouldn't be using floats in
> > the kernel, and partly to avoid the need for stack alignment, see:
> > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=53383 )
> > 
> > UML does not do the same thing, which isn't in itself a problem, but
> > does add to the list of differences between UML and "normal" x86 builds.
> > 
> > In addition, there was a crash bug with LLVM < 15 / rustc < 1.65 when
> > building with SSE, so disabling it fixes rust builds with earlier
> > compiler versions, see:
> > https://github.com/Rust-for-Linux/linux/pull/881
> > 
> > Signed-off-by: David Gow <davidgow@google.com>
> > Reviewed-by: Sergio González Collado <sergio.collado@gmail.com>
> > Signed-off-by: Richard Weinberger <richard@nod.at>
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> There is a followup fix of this patch that merged into the mainline by commit
> a3046a618a28 ("um: Only disable SSE on clang to work around old GCC bugs"), but
> it has not added to 6.1.y so far.  Without it, compiling on some setup using an
> old version of gcc fails, as the followup is also mentioning.  I also confirmed
> the issue can be reproduced on latest 6.1.y.
> 
> Could you please add the followup fix to 6.1.y?  I confirmed the commit can be
> cleanly cherry-picked on latest 6.1.y, and fixes the issue as expected.

Now queued up, thanks.

greg k-h
