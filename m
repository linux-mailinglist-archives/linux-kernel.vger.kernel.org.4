Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE1B68E989
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 09:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjBHIIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 03:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbjBHIII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 03:08:08 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 06826E055
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 00:08:05 -0800 (PST)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 31887icH030895;
        Wed, 8 Feb 2023 09:07:44 +0100
Date:   Wed, 8 Feb 2023 09:07:44 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Feiyang Chen <chris.chenfeiyang@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Feiyang Chen <chenfeiyang@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] nolibc: Add statx() support to implement sys_stat()
Message-ID: <Y+NYUBMhYq4vVzrR@1wt.eu>
References: <cover.1675734681.git.chenfeiyang@loongson.cn>
 <1af05c1441e9f96870be1cc20b1162e3f5043b2e.1675734681.git.chenfeiyang@loongson.cn>
 <1e7da4e7-392d-4a9e-aa95-0599a0c84419@app.fastmail.com>
 <CACWXhK==yVZGZbY+3DUAuxL34=gKwQv20Cw3y1+QKir0D2F3EQ@mail.gmail.com>
 <Y+MXk9A+gB1W6T/n@1wt.eu>
 <CACWXhKn1N6f7XvtrbDno4UyAhMZbV_htQoRbm0ws9gjF08wnBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACWXhKn1N6f7XvtrbDno4UyAhMZbV_htQoRbm0ws9gjF08wnBw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 03:42:56PM +0800, Feiyang Chen wrote:
> Hi, Arnd, Willy,
> 
> We have a problem if we just start with sys_statx() only on this arch.
> When struct stat is not defined, what should we do with stat() in the
> nolibc selftest?

You need to have a struct stat regardless of the syscalls you implement,
because it is what userland will see and use. Even if your implementation
of stat() is based on statx(), you'll need that struct stat that your
stat() function will feed. Right now it is defined in types.h.

As you can see in sys.h where sys_stat() is implemented, each arch's
specific syscall is used with a local sys_stat_struct that is specific
to that syscall, then the fields are stuffed into the userland-compatible
stat struct.

aarch64 is a good example, as its stat() implementation relies on
newfstatat() that uses a different one, but all fields are properly
mapped.

Just let me know if anything is not clear and if you need more help.

Thanks!
Willy
