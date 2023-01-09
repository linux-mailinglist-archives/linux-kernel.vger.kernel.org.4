Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494BE663029
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 20:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237638AbjAITQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 14:16:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237335AbjAITPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 14:15:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E72F6586
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 11:15:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92FAC61315
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 19:15:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6371C433F0;
        Mon,  9 Jan 2023 19:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673291734;
        bh=iKNIjUrA5oUEQdbm/yRWdQXgKfWpS6LTKUIKKgclyfk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=CBrfvOKEwuGZSjc1TsDYGLruQUIZ+td2cVwD69aLW3rRDgu9treHTYakNi12UUD9n
         E/KW200lVAB6SVfIvUZyRbNJSpV8jUqb1+nUZaUiAGlGMi01r/0bwGqFlIQ2bQaVhJ
         8rlFg7TxgpQPyR2fkv6RMcQ46y4kfqwv8b55RCJVJ0cyAhCCoP0/4zDjF9sBRYM6hu
         hAQeSAoRshhXEZVRgOQhAh/Mb9bW6U+369mYVTZIFmo9/VvfncCLro//BHYiuRk7iz
         NXS39Zh4kOSN8FpuQiOwTkaCOLWxarBO+LJp3xUkSR9CumevDbjKddAF35oV+7eB++
         K92lx1v7WV3UQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 55BA15C05C8; Mon,  9 Jan 2023 11:15:34 -0800 (PST)
Date:   Mon, 9 Jan 2023 11:15:34 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     linux-kernel@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH 0/4] nolibc: add support for the s390 platform
Message-ID: <20230109191534.GU4028633@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230109080910.26594-1-w@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230109080910.26594-1-w@1wt.eu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 09:09:06AM +0100, Willy Tarreau wrote:
> Hello Paul,
> 
> this series adds support for the s390x platform to nolibc and rcutorture,
> reducing the init size from ~600kB to ~1kB. The work was contributed by
> Sven Schnelle. It depends on the fixes series I sent previously:
> 
>   https://lore.kernel.org/lkml/20230109075442.25963-1-w@1wt.eu/
> 
> It passes the self-tests correctly and the patches are clean, please
> consider queuing it.

"80 test(s) passed" and successful exit code.  I will assume that the
decrease in tests from 81 to 80 is intended.  I have these queued,
but it may be some hours before they are externally visible.

Thank you!

							Thanx, Paul

> Thank you!
> Willy
> 
> ---
> Sven Schnelle (4):
>   nolibc: add support for s390
>   selftests/nolibc: add s390 support
>   rcutorture: add support for s390
>   rcutorture: build initrd for rcutorture with nolibc
> 
>  tools/include/nolibc/arch-s390.h              | 222 ++++++++++++++++++
>  tools/include/nolibc/arch.h                   |   2 +
>  tools/include/nolibc/sys.h                    |   2 +
>  tools/testing/selftests/nolibc/Makefile       |   7 +-
>  .../selftests/rcutorture/bin/functions.sh     |   6 +
>  .../selftests/rcutorture/bin/mkinitrd.sh      |   2 +-
>  6 files changed, 239 insertions(+), 2 deletions(-)
>  create mode 100644 tools/include/nolibc/arch-s390.h
> 
> -- 
> 2.17.5
> 
