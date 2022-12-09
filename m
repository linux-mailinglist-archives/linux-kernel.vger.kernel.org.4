Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98C664848A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 16:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiLIPEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 10:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbiLIPDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 10:03:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EA136C63
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 07:03:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E3AA6B82784
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 15:03:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9523EC433EF;
        Fri,  9 Dec 2022 15:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670598205;
        bh=18Gm+GTjx7z3bOUA1+OzccJAJKlPNwg/R1e2Vl34IPM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=gRkhJ0vy3WdGx5Cxs765pFrL8kSQZ+lgVynCTKII9Z8XCTQ31N5LaQ59vfJUNLb3e
         s1TDxDEDtaT0+xIHLnLiBk2/vwRdqi7HYeZOORGW2ytY8WSZ9YK2VPQp4Df5QfAdUb
         YDwzd0TdocFGMUpwcVD6K6dUYPZ5UpiLWfo/5ge24Il9XVt5mpfljMOhcFAUafYIE1
         04TNcbao9/7yAx5OaOyyPJPwuqiHjrnqLVQXf3Ht4aCmOcMcjLiIqAe5Du3pMpmZHP
         51pR8kFIBCqbfbqnQi3AKNi4iYKv5Ga5QZzEdA2z1LnPdQ6NrliaXdqHbz7Wfv2KCZ
         SjHsoHrTJ8Ctw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3BAE55C095D; Fri,  9 Dec 2022 07:03:25 -0800 (PST)
Date:   Fri, 9 Dec 2022 07:03:25 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Willy Tarreau <w@1wt.eu>, Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] add s390 support to nolibc and rcutorture
Message-ID: <20221209150325.GX4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221209141939.3634586-1-svens@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209141939.3634586-1-svens@linux.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2022 at 03:19:34PM +0100, Sven Schnelle wrote:
> Hi,
> 
> these patches add support for the s390 architecture both to nolibc
> and rcutorture. Note that this only adds support for the 64 bit
> version, no support for 31 bit (compat) is added. For nolibc it
> includes one bugfix to make the fd_set datatype match the kernel
> type.

Nice!!!

The rcutorture patches look plausible to me, but I must defer to Willy
Tarreau on the nolibc changes.

							Thanx, Paul

> Sven Schnelle (5):
>   nolibc: fix fd_set type
>   nolibc: add support for s390
>   selftests/nolibc: add s390 support
>   rcutorture: add support for s390
>   rcutorture: build initrd for rcutorture with nolibc
> 
>  tools/include/nolibc/arch-s390.h              | 213 ++++++++++++++++++
>  tools/include/nolibc/arch.h                   |   2 +
>  tools/include/nolibc/sys.h                    |   2 +
>  tools/include/nolibc/types.h                  |  53 +++--
>  tools/testing/selftests/nolibc/Makefile       |   4 +
>  .../selftests/rcutorture/bin/functions.sh     |   6 +
>  .../selftests/rcutorture/bin/mkinitrd.sh      |   2 +-
>  7 files changed, 258 insertions(+), 24 deletions(-)
>  create mode 100644 tools/include/nolibc/arch-s390.h
> 
> -- 
> 2.34.1
> 
