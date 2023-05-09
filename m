Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DECD6FC1E9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 10:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234625AbjEIIqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 04:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234593AbjEIIqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 04:46:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CFE8A67;
        Tue,  9 May 2023 01:46:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E081631D6;
        Tue,  9 May 2023 08:46:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DECEAC433D2;
        Tue,  9 May 2023 08:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683622000;
        bh=Rosg6MIt+oWekqphy3JytZbJCDw525kHM44ZeRKAImo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UpK6iwdYthvcjHN6+BKNYjrGU+DfDKrInQ+XVJ3y3LF2xzUsyz0f7cMpW0Z3+s0a6
         RovtM+pwcK3eCbIQqgQaGmCcLA8md8hEEk79Sah39rXSCBXtA72kOindkgCAA7IQj+
         wLTIVZFV1dJvJsaFby6YJtzwZHsyCI93l4bRPI5A=
Date:   Tue, 9 May 2023 10:46:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     gary@garyguo.net, alex.gaynor@gmail.com, benno.lossin@proton.me,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, ojeda@kernel.org,
        patches@lists.linux.dev, rust-for-linux@vger.kernel.org,
        wedsonaf@gmail.com
Subject: Re: [PATCH v2] rust: error: add missing error codes
Message-ID: <2023050937-scouring-truck-d7c0@gregkh>
References: <20230508124701.443ba331.gary@garyguo.net>
 <20230509080700.1608146-1-aliceryhl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509080700.1608146-1-aliceryhl@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2023 at 08:07:00AM +0000, Alice Ryhl wrote:
> On Mon, 8 May 2023 12:47:01 +0100
> Gary Guo <gary@garyguo.net> wrote:
> > On Thu,  4 May 2023 06:48:54 +0000
> > Alice Ryhl <aliceryhl@google.com> wrote:
> > > This adds the error codes from `include/linux/errno.h` to the list of
> > > Rust error constants. These errors were not included originally, because
> > > they are not supposed to be visible from userspace. However, they are
> > > still a perfectly valid error to use when writing a kernel driver. For
> > > example, you might want to return ERESTARTSYS if you receive a signal
> > > during a call to `schedule`.
> > 
> > `include/linux/errno.h` also includes all of `asm/errno.h`,
> > which defines EDEADLK - EHWPOISON, which is not included in this patch.
> > I feel like these error codes should be added first?
> 
> It seems like there are a lot of asm/errno.h files:
> 
> $ find . -name errno.h
> ./arch/powerpc/include/uapi/asm/errno.h
> ./arch/mips/include/asm/errno.h
> ./arch/mips/include/uapi/asm/errno.h
> ./arch/alpha/include/uapi/asm/errno.h
> ./arch/parisc/include/uapi/asm/errno.h
> ./arch/sparc/include/uapi/asm/errno.h
> ./arch/x86/include/generated/uapi/asm/errno.h
> ./tools/arch/powerpc/include/uapi/asm/errno.h
> ./tools/arch/mips/include/asm/errno.h
> ./tools/arch/mips/include/uapi/asm/errno.h
> ./tools/arch/alpha/include/uapi/asm/errno.h
> ./tools/arch/parisc/include/uapi/asm/errno.h
> ./tools/arch/sparc/include/uapi/asm/errno.h
> ./tools/arch/x86/include/uapi/asm/errno.h
> ./tools/include/nolibc/errno.h
> ./tools/include/uapi/asm/errno.h
> ./tools/include/uapi/asm-generic/errno.h

You can ignore the tool ones.

> ./include/uapi/asm-generic/errno.h
> ./include/uapi/linux/errno.h
> ./include/linux/errno.h
> 
> How should I proceed with this? You mention EDEADLK - EHWPOISON, but its
> not clear to me which asm/errno.h file I should base this on.

It depends on which arch you are building for.  That's why we have
per-platform errno.h files, the values are different for different ones.
So you need to handle them all properly somehow.  How is rust going to
handle per-arch stuff like this?

thanks,

greg k-h
