Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7119F5F4C9F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 01:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiJDX0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 19:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiJDX0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 19:26:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A5266A46
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 16:26:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2369761539
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 23:26:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FA2EC433D6;
        Tue,  4 Oct 2022 23:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664925972;
        bh=hg5t47yAStpJb95gYWxc3f1CRgOEIT4RkUFnxKN6WNQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uM7FOR41lUjVTQLYowd2dzmS5mPYqsJVz6/XGBli3WjJT+fNQQmJSAOa/TvozpcBp
         RwwpHb2WKSIgyfnoCTsNhV7QNE6iLN1MIhcvckrzByCWfhedpYdolXoCr4aA9A5mbQ
         FppFMByjZE00QhMzKtfvzwAgFYUYaOze5xHXpYNo4ATySt2B0VswrPsDvUBdOPWYsk
         VGOb17Ae9c4m9+tZ3RD5psSECYR0n4rZF5a28tXWzgNkpsruxLZd9/CLNm8MPv4X6b
         RKE+i+1byKNNbpU12FaUxW7A+xUOluEe8gdbZne/zMQuCieFesRtp+w0yHs7hqtX0u
         /CIf9NheBMM9g==
Date:   Tue, 4 Oct 2022 16:26:10 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Tom Rix <trix@redhat.com>, ntfs3@lists.linux.dev,
        llvm@lists.linux.dev, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] fs/ntfs3: Don't use uni1 uninitialized in
 ntfs_d_compare()
Message-ID: <YzzBEoDiseHUG0P1@dev-arch.thelio-3990X>
References: <20221004144145.1345772-1-nathan@kernel.org>
 <CAKwvOdm=ZHjoF+j+ivj17t3OMpTA-5Dx71+g3KRSHO=L6RRpEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdm=ZHjoF+j+ivj17t3OMpTA-5Dx71+g3KRSHO=L6RRpEA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 03:56:45PM -0700, Nick Desaulniers wrote:
> On Tue, Oct 4, 2022 at 7:42 AM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > Clang warns:
> >
> >   fs/ntfs3/namei.c:445:7: error: variable 'uni1' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
> >                   if (toupper(c1) != toupper(c2)) {
> >                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> >   ./include/linux/ctype.h:64:20: note: expanded from macro 'toupper'
> >   #define toupper(c) __toupper(c)
> >                     ^
> >   fs/ntfs3/namei.c:487:12: note: uninitialized use occurs here
> >           __putname(uni1);
> >                     ^~~~
> >   ./include/linux/fs.h:2789:65: note: expanded from macro '__putname'
> >   #define __putname(name)         kmem_cache_free(names_cachep, (void *)(name))
> >                                                                         ^~~~
> >   fs/ntfs3/namei.c:445:3: note: remove the 'if' if its condition is always false
> >                   if (toupper(c1) != toupper(c2)) {
> >                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >   fs/ntfs3/namei.c:434:7: error: variable 'uni1' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
> >                   if (!lm--) {
> >                       ^~~~~
> >   fs/ntfs3/namei.c:487:12: note: uninitialized use occurs here
> >           __putname(uni1);
> >                     ^~~~
> >   ./include/linux/fs.h:2789:65: note: expanded from macro '__putname'
> >   #define __putname(name)         kmem_cache_free(names_cachep, (void *)(name))
> >                                                                         ^~~~
> >   fs/ntfs3/namei.c:434:3: note: remove the 'if' if its condition is always false
> >                   if (!lm--) {
> >                   ^~~~~~~~~~~~
> >   fs/ntfs3/namei.c:430:22: note: initialize the variable 'uni1' to silence this warning
> >           struct cpu_str *uni1, *uni2;
> >                               ^
> >                               = NULL
> >   2 errors generated.
> >
> > There is no point in calling __putname() in these particular error
> > paths, as there has been no corresponding __getname() call yet. Just
> > return directly in these blocks to clear up the warning.
> >
> > Fixes: a3a956c78efa ("fs/ntfs3: Add option "nocase"")
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1729
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > ---
> >  fs/ntfs3/namei.c | 12 ++++--------
> >  1 file changed, 4 insertions(+), 8 deletions(-)
> >
> > diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
> > index 315763eb05ff..5d3a6ce3f05f 100644
> > --- a/fs/ntfs3/namei.c
> > +++ b/fs/ntfs3/namei.c
> > @@ -431,10 +431,8 @@ static int ntfs_d_compare(const struct dentry *dentry, unsigned int len1,
> >
> >         /* First try fast implementation. */
> >         for (;;) {
> > -               if (!lm--) {
> > -                       ret = len1 == len2 ? 0 : 1;
> > -                       goto out;
> > -               }
> > +               if (!lm--)
> > +                       return len1 == len2 ? 0 : 1;
> 
> I know the code originally used this, but I can't help but look at
> this and think that it should be:
> 
> return len1 != len2;
> 
> Do you mind cleaning it up while you're here?
> 
> Otherwise LGTM;
> 
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> 
> You may retain my RB tag whether you send that suggestion in a v2 or not.

I sent a v2 but I kept the changes separate:

https://lore.kernel.org/20221004232359.285685-1-nathan@kernel.org/
https://lore.kernel.org/20221004232359.285685-2-nathan@kernel.org/

Thanks for taking a look!

> >
> >                 if ((c1 = *n1++) == (c2 = *n2++))
> >                         continue;
> > @@ -442,10 +440,8 @@ static int ntfs_d_compare(const struct dentry *dentry, unsigned int len1,
> >                 if (c1 >= 0x80 || c2 >= 0x80)
> >                         break;
> >
> > -               if (toupper(c1) != toupper(c2)) {
> > -                       ret = 1;
> > -                       goto out;
> > -               }
> > +               if (toupper(c1) != toupper(c2))
> > +                       return 1;
> >         }
> >
> >         /*
> >
> > base-commit: d45da67caedacd500879de5e649360cc70777af7
> > --
> > 2.37.3
> >
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers
