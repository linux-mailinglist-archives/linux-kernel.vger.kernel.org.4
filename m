Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B67367FF9E
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 15:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjA2OvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 09:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjA2OvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 09:51:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB80E1C5BC
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 06:51:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4091760D57
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 14:51:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 223F7C433EF;
        Sun, 29 Jan 2023 14:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675003866;
        bh=lCnGajDczmgjdfaOaigtlGKys56hqbLDWWrpKImZVQI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J9liH0mmRLx7j3YSfhxlIGHTXOIbsjhwWxrlUml/4CFcGmfwCIZGylUUfveJMhPEA
         WpteS9BJH/b3mnhdpzzThQc/zHlniwKln5qCvbSr/DLjAK61Wg64ZONPWIcf7QcsgV
         hhR/+9nLCWevQsrxrDmiqxXQevO9hFF6LU8hhHNuiBbDf5+LqAbtsuZNpAMbUNDM1i
         3TEz99Bv6fjscFhJ72WyG31a9fZvk9TMsQLa1pSuNfB+I7/8C87RjvZjFxlhi2a9cU
         TLX2gOhG5XOywyWt2nKg8Omsfevxris2wbEOKKnOfJS7FoJQV0WB3g8IOK0LfLDZt8
         LAdU+0Pt6bUFg==
Date:   Sun, 29 Jan 2023 07:51:04 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev
Subject: Re: [PATCH] ARM: Allow pre-ARMv5 builds with ld.lld 16.0.0 and newer
Message-ID: <Y9aH2AzDpwQXFlx+@dev-arch.thelio-3990X>
References: <20230118-v4-v4t-lld-16-v1-1-e3d9a00ae47c@kernel.org>
 <1206e990-23b3-44c8-97c9-869ec0aeead0@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1206e990-23b3-44c8-97c9-869ec0aeead0@app.fastmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 10:56:06PM +0100, Arnd Bergmann wrote:
> On Wed, Jan 18, 2023, at 20:22, Nathan Chancellor wrote:
> > Commit 6a7ee50f8f56 ("ARM: disallow pre-ARMv5 builds with ld.lld")
> > prevented v4 or v4t kernels when ld.lld will link the kernel due to
> > inserting unsupported blx instructions.
> >
> > ld.lld has been fixed in current main (16.0.0) to avoid inserting these
> > instructions by inserting position independent thunks instead. Allow
> > these configurations to be enabled when ld.lld 16.0.0 is used to link
> > the kernel.
> >
> > Additionally, add a link to the upstream LLVM issue so that the reason
> > for this dependency is clearly documented.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/964
> > Link: 
> > https://github.com/llvm/llvm-project/commit/6f9ff1beee9d12aca0c9caa9ae0051dc6d0a718c
> > Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> 
> Thanks a lot for getting this fixed!
> 
> I gave this a spin on my randconfig build setup, which showed
> nothing unusual.
> 
> Tested-by: Arnd Bergmann <arnd@arndb.de>
> 
> Please add this to Russell's patch tracker.

Done, thanks for testing!

https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=9289/1

Cheers,
Nathan
