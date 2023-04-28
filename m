Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63286F1D77
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 19:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346262AbjD1Rbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 13:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjD1Rbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 13:31:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369C11BE9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 10:31:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5440644D8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 17:31:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E305C433D2;
        Fri, 28 Apr 2023 17:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682703098;
        bh=nTrHMfz3vPJx3oi2/uvqoUmHHzqYEqSJ71L1PpJVF5k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eScoA/5ZP8alfHZ8o78LZ1GE0HnI6I8hyXtZhqgUqqK2xX+T9igHAfCiyuT8/BsCB
         x8CIHSqmwK2QEotDTh91A/gUXqZlegowLRf7LO1CdQej469i2VkmDj0N2epwy2qX05
         0OJdj4vjUsvMI++7z9BSoE8bTJwA4kvZT+obuDF8=
Date:   Fri, 28 Apr 2023 19:31:35 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jiri Slaby <jirislaby@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+b7c3ba8cdc2f6cf83c21@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] tty: tty_io: remove hung_up_tty_fops
Message-ID: <2023042859-kosher-specimen-9a0f@gregkh>
References: <20230423233433.GF3390869@ZenIV>
 <e1fe6a44-3021-62ad-690a-69146e39e1ac@I-love.SAKURA.ne.jp>
 <20230424004431.GG3390869@ZenIV>
 <8e21256a-736e-4c2d-1ff4-723775bcac46@I-love.SAKURA.ne.jp>
 <2fca7932-5030-32c3-dd61-48dd78e58e11@I-love.SAKURA.ne.jp>
 <20230425160344.GS3390869@ZenIV>
 <1b405689-ea0a-6696-6709-d372ce72d68c@I-love.SAKURA.ne.jp>
 <5cebade5-0aa9-506c-c817-7bcf098eba89@I-love.SAKURA.ne.jp>
 <20230428162718.GA1099174@dev-arch.thelio-3990X>
 <6dca757e-74ac-773d-2a50-4e48b2f56880@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6dca757e-74ac-773d-2a50-4e48b2f56880@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 29, 2023 at 01:41:02AM +0900, Tetsuo Handa wrote:
> On 2023/04/29 1:27, Nathan Chancellor wrote:
> > I see this change has shown up in -next as commit 4c87e9e5479b ("tty:
> > tty_io: remove hung_up_tty_fops"), where it causes the following warning
> > for configurations without CONFIG_COMPAT (I used ARCH=arm defconfig):
> > 
> >   drivers/tty/tty_io.c:446:13: warning: 'hung_up_tty_compat_ioctl' defined but not used [-Wunused-function]
> >     446 | static long hung_up_tty_compat_ioctl(struct file *file,
> >         |             ^~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > I am not sure if you just added that patch for additional test coverage
> > or for final acceptance but the following diff resolves this warning for
> > me, perhaps it can be folded in for a v2?
> 
> Thank you for reporting. Yes, moving the definition will solve the warning.
> 
> I'm testing this patch using my volatile tree before getting merged to a
> permanent tree.

How are you adding new stuff to linux-next right now when the tree
should be "closed"?  And I haven't reviewed this yet, what tree has
picked it up?

Please wait until after -rc1 is out for new stuff, you know this...

thanks,

greg k-h
