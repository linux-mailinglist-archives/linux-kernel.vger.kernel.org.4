Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108A76A2E32
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 05:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjBZEbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 23:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBZEa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 23:30:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214052739;
        Sat, 25 Feb 2023 20:30:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C3D57B80B6F;
        Sun, 26 Feb 2023 04:30:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC66C433EF;
        Sun, 26 Feb 2023 04:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1677385855;
        bh=3AVpRW1qfx5u4fWuk1ExehO1c3toNqap5A2JD2mWud8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Z2x2VghRbdvldniWzOgtOOVwyu0YcNwIgHAUww07sKBomB2aMml+GfGgFSjEm34ag
         ddby0Tqvtv0krNdAwmEmS6JKUrXdexhqg2T4oUOk/1zi+L62ZyPkqtmmpwSZxUnsct
         ix3PxjxK9VDp5LSf9VE+OX9MObQbT1hGdLTE7JBs=
Date:   Sat, 25 Feb 2023 20:30:52 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zram: Use atomic_long_read() to read atomic_long_t
Message-Id: <20230225203052.0fd823a1ccf0619e89b315d8@linux-foundation.org>
In-Reply-To: <20230225121523.3288544-1-geert+renesas@glider.be>
References: <20230225121523.3288544-1-geert+renesas@glider.be>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Feb 2023 13:15:23 +0100 Geert Uytterhoeven <geert+renesas@glider.be> wrote:

> On 32-bit:
> 
>     drivers/block/zram/zram_drv.c: In function ‘mm_stat_show’:
>     drivers/block/zram/zram_drv.c:1234:23: error: passing argument 1 of ‘atomic64_read’ from incompatible pointer type [-Werror=incompatible-pointer-types]
>      1234 |    (u64)atomic64_read(&pool_stats.objs_moved));
> 	  |                       ^~~~~~~~~~~~~~~~~~~~~~
> 	  |                       |
> 	  |                       atomic_long_t * {aka struct <anonymous> *}
>     In file included from ./include/linux/atomic.h:82,
> 		     from ./include/linux/mm_types_task.h:13,
> 		     from ./include/linux/mm_types.h:5,
> 		     from ./include/linux/buildid.h:5,
> 		     from ./include/linux/module.h:14,
> 		     from drivers/block/zram/zram_drv.c:18:
>     ./include/linux/atomic/atomic-instrumented.h:644:33: note: expected ‘const atomic64_t *’ {aka ‘const struct <anonymous> *’} but argument is of type ‘atomic_long_t *’ {aka ‘struct <anonymous> *’}
>       644 | atomic64_read(const atomic64_t *v)
> 	  |               ~~~~~~~~~~~~~~~~~~^
> 
> Fix this by using atomic_long_read() instead.
> 
> Reported-by; noreply@ellerman.id.au

That's an interesting one.  Was this mpe@?

I like it when a Reported-by: is followed by a Link: to the report, so
I can go hunt down such things.


