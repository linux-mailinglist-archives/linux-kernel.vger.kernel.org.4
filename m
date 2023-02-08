Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA64C68E9B3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 09:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjBHITz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 03:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjBHITx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 03:19:53 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 90F8EB46A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 00:19:52 -0800 (PST)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 3188JZ6H030993;
        Wed, 8 Feb 2023 09:19:35 +0100
Date:   Wed, 8 Feb 2023 09:19:35 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "chris.chenfeiyang" <chris.chenfeiyang@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Feiyang Chen <chenfeiyang@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] nolibc: Add statx() support to implement sys_stat()
Message-ID: <Y+NbF6OrYu62OQCX@1wt.eu>
References: <cover.1675734681.git.chenfeiyang@loongson.cn>
 <1af05c1441e9f96870be1cc20b1162e3f5043b2e.1675734681.git.chenfeiyang@loongson.cn>
 <1e7da4e7-392d-4a9e-aa95-0599a0c84419@app.fastmail.com>
 <CACWXhK==yVZGZbY+3DUAuxL34=gKwQv20Cw3y1+QKir0D2F3EQ@mail.gmail.com>
 <Y+MXk9A+gB1W6T/n@1wt.eu>
 <CACWXhKn1N6f7XvtrbDno4UyAhMZbV_htQoRbm0ws9gjF08wnBw@mail.gmail.com>
 <7c98aac5-6b64-4f6b-b242-7ad3b8a334a8@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c98aac5-6b64-4f6b-b242-7ad3b8a334a8@app.fastmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 09:06:24AM +0100, Arnd Bergmann wrote:
> On Wed, Feb 8, 2023, at 08:42, Feiyang Chen wrote:
> > On Wed, 8 Feb 2023 at 11:31, Willy Tarreau <w@1wt.eu> wrote:
> >>
> >> I generally agree with the Arnd's points overall and I'm fine with the
> >> rest of your series. On this specific point, I'm fine with your proposal,
> >> let's just start with sys_statx() only on this arch, please add a comment
> >> about this possibility in the commit message that brings statx(),
> >> indicating that other archs are likely to benefit from it as well, and
> >> let's see after this if we can migrate all archs to statx.
> >>
> >
> > We have a problem if we just start with sys_statx() only on this arch.
> > When struct stat is not defined, what should we do with stat() in the
> > nolibc selftest?
> 
> To clarify: your proposed implementation of the stat() function that
> fills the nolibc 'struct stat' based on information from 'struct statx'
> is fine here. Just remove the 'struct sys_stat_struct' definition
> loongarch but keep 'struct stat'.

Ah I think now I understand the problem Feiyang is facing. Since "struct
stat" is just between libc and userland, there's the "sys_stat_struct"
that we're using to abstract the syscalls in sys_stat() and that is
compatible with each variant of the stat() syscall on each arch. Here
there's simply no stat() syscall so it's best not to try to abstract
this function at all since types will not match between stat and statx,
so it will be better to just implement it like this:

#if defined(__NR_statx)
    static __attribute__((unused))
    int sys_stat(const char *path, struct stat *buf)
    {
       struct statx statx;
       long ret;

       ret = statx(...);
       buf->xxx = statx.xxx;
       ...
       return ret;
    }
#else ...
   // keep the regular sys_stat() here
#endif

Also looking at the man page I see that statx() only appeared in 4.11,
and here we're targetting userland so I'd rather keep a bit of margin
when it comes to backwards compatibility, thus not dropping stat() and
friends too early when not necessary. However using statx() by default
when available sounds fine to me!

Cheers,
Willy
