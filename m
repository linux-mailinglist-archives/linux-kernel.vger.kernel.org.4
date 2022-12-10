Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383F3648E04
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 10:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiLJJh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 04:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLJJhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 04:37:53 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 43E69140C2
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 01:37:51 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 2BA9bYaw021826;
        Sat, 10 Dec 2022 10:37:34 +0100
Date:   Sat, 10 Dec 2022 10:37:34 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] nolibc: add support for s390
Message-ID: <20221210093734.GE21743@1wt.eu>
References: <20221209141939.3634586-1-svens@linux.ibm.com>
 <20221209141939.3634586-3-svens@linux.ibm.com>
 <20221210090728.GB21743@1wt.eu>
 <yt9dmt7vtxf3.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yt9dmt7vtxf3.fsf@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 10, 2022 at 10:34:08AM +0100, Sven Schnelle wrote:
> Whoops. One of my colleagues suggested that i should name the file
> arch-390x.h. Reason for this is that the architecture name "s390"
> describes the 31bit (compat) architecture mode in userspace, and "s390x"
> the 64 bit mode. To make it a bit more complicated, the architecture in
> the kernel is named "s390". That's because in the beginning the kernel
> could run in 31bit or 64 bit mode, and there can be only one
> architecture name. When support for running 31bit kernels was removed
> years ago, the architecture name s390 was kept because renaming the
> architecture would have been quite some fun. So in short:
> 
> Kernel s390 == 64 bit only
> Userspace s390 == 31 bit
> Userspace s390x == 64 bit

OK, that might be why it's always a bit confusing to me :-)

> So i tried renaming the header file, noted that the Makefile just uses:
> 
> nolibc_arch := $(patsubst arm64,aarch64,$(ARCH))
> arch_file := arch-$(nolibc_arch).h
> 
> which would then need special handling. Obviously i failed to revert the
> change completely during rebase.
> 
> So it should be:
> 
> >> +#elif defined(__s390x__)
> >> +#include "arch-s390.h"
> 
> I'm fine with both - either you fixing it up or me sending a v2.

As you like. If you prefer to rename the file to s390x as your colleague
suggested, I'll then ask you to send a v2. Otherwise either Paul or I can
drop that 'x' in the #include.

Thanks,
Willy
