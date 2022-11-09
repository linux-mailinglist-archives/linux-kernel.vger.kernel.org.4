Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F82622E1C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 15:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbiKIOin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 09:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbiKIOil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 09:38:41 -0500
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548CAC76A;
        Wed,  9 Nov 2022 06:38:36 -0800 (PST)
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id E30EDD55; Wed,  9 Nov 2022 08:38:34 -0600 (CST)
Date:   Wed, 9 Nov 2022 08:38:34 -0600
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Paul Moore <paul@paul-moore.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, serge@hallyn.com
Subject: Re: [GIT PULL] LSM fixes for v6.1 (#1)
Message-ID: <20221109143834.GB24561@mail.hallyn.com>
References: <CAHC9VhSSafrkW4VbTVoAUJmjFQdCwPTGDqTP8yBnLBqc7rW7iQ@mail.gmail.com>
 <CAHk-=wj_6Df1NAMs14S0OOqX1Z=460j-mfwn_qm-7EK1eK76qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj_6Df1NAMs14S0OOqX1Z=460j-mfwn_qm-7EK1eK76qw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 12:22:29PM -0700, Linus Torvalds wrote:
> On Mon, Oct 31, 2022 at 4:07 AM Paul Moore <paul@paul-moore.com> wrote:
> >
> > A single patch to the capabilities code to fix a potential memory leak
> > in the xattr allocation error handling.  Please apply for v6.1-rcX.
> 
> Pulled.
> 
> However, I react to the strange test condition. Sure, it's
> pre-existing, but does it really make sense?
> 
> It does
> 
> +       if (ret < 0 || !tmpbuf) {
> +               size = ret;
> +               goto out_free;
> +       }
> 
> and how the heck can 'tmpbuf' be NULL if vfs_getxattr_alloc() succeeded?

I had to go through the history a bit - the !tmpbuf check was added

https://www.spinics.net/lists/stable/msg463010.html

because of a gcc warning.  Perhaps there's a better way to tell gcc
that it can't remain NULL if ret was < 0 ?

> I think that's not only impossible in the first place, but if it *was*
> possible, then that
> 
>                 size = ret;
>                goto out_free;
> 
> would be wrong, because this function would return success even if it
> wasn't successful.
> 
> That whole "cast to int, and then cast back to size_t" also smells of
> some serious confusion in the return value handling. It looks to me
> like vfs_getxattr_alloc() fundamentally returns an 'int', not a
> 'ssize_t', just by looking at the ->get function. But it just all
> looks weird.
> 
> So this code has all kinds of oddities.
> 
>                Linus
