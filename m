Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9FE168F059
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 15:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjBHOIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 09:08:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjBHOH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 09:07:59 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 346A6FC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 06:07:57 -0800 (PST)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 318E7ZT7002066;
        Wed, 8 Feb 2023 15:07:35 +0100
Date:   Wed, 8 Feb 2023 15:07:35 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "chris.chenfeiyang" <chris.chenfeiyang@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Feiyang Chen <chenfeiyang@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] nolibc: Add statx() support to implement sys_stat()
Message-ID: <Y+Osp43OQOlllIVl@1wt.eu>
References: <cover.1675734681.git.chenfeiyang@loongson.cn>
 <1af05c1441e9f96870be1cc20b1162e3f5043b2e.1675734681.git.chenfeiyang@loongson.cn>
 <1e7da4e7-392d-4a9e-aa95-0599a0c84419@app.fastmail.com>
 <CACWXhK==yVZGZbY+3DUAuxL34=gKwQv20Cw3y1+QKir0D2F3EQ@mail.gmail.com>
 <Y+MXk9A+gB1W6T/n@1wt.eu>
 <CACWXhKn1N6f7XvtrbDno4UyAhMZbV_htQoRbm0ws9gjF08wnBw@mail.gmail.com>
 <7c98aac5-6b64-4f6b-b242-7ad3b8a334a8@app.fastmail.com>
 <Y+NbF6OrYu62OQCX@1wt.eu>
 <d0df35466db74097b8e70e28d35a4776@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0df35466db74097b8e70e28d35a4776@AcuMS.aculab.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 01:01:48PM +0000, David Laight wrote:
> From: Willy Tarreau
> > Sent: 08 February 2023 08:20
> ....
> > Also looking at the man page I see that statx() only appeared in 4.11,
> > and here we're targetting userland so I'd rather keep a bit of margin
> > when it comes to backwards compatibility, thus not dropping stat() and
> > friends too early when not necessary. However using statx() by default
> > when available sounds fine to me!
> 
> Does that really matter?
> Isn't 'nolibc' really just used for programs built in the
> kernel source tree to be release/run with the current kernel?

Not just that even if mostly related, and even in such a case
we'd rather maintain a low level of breakage when it doesn't
require any effort (and moving the ifdef __NR_statx up 20 lines
is perfectly within what I consider low effort).

> I also wonder if building a 'mini_libc.a' that the programs
> can be linked against might be easier than having to
> generate inline versions of everything?

It's another option but a different approach. There are pros and cons
to different approaches. For this, better not reinvent the wheel,
there's already klibc that does this well. A few of us do value the
simplicity of not having to pre-build anything before the test program,
especially when running tests that cover multiple architectures and/or
versions. I'm not saying it's a solution to everything at all, far from
this (and the level of coverage of that code should be self-explanatory
to remind anyone that it's not the goal). But when working on some small
test programs it's quite handy like this.

Regards,
Willy
