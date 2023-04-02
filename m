Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C546D3A69
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 23:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjDBVYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 17:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDBVYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 17:24:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1709EC5
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 14:24:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E4732B80FF2
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 21:24:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD62C433EF;
        Sun,  2 Apr 2023 21:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680470645;
        bh=Bhk1NvODXF0op6yKbbwQDWwfvsZ2GC/kb/TLI3m77WU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=kv3zRQVRlz1Q56x/WOcUzlPQRyORSFN9BZMhR1BzBE0+WQJqNgEPb+/9un214z0W3
         bjjKWduSO5zZcKe0p9+DpI801DqD84vDXY8x5+FjpAgRZdf2WfFQErEHNUKZqzBLxN
         QUKI1FOCcec7BiUoBLyA7iZHjc+k//Eu6CsEwYCeltRycGUh1VdK1GnONb2rZcH6Xc
         EsM917QQplbQu0ppcEBQGBk0E2IVC4lLPaqGRNnofWl9MLBFVTx8Kl++GsPJAOwcJp
         IcZRZaPPfxx1VnQAbZEat3LQ752dE5yWdCjTE2v+9F6+aZswTpRIhDRIwczmzK1z/K
         BW8kbBoSeS0gQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D5829154047C; Sun,  2 Apr 2023 14:24:04 -0700 (PDT)
Date:   Sun, 2 Apr 2023 14:24:04 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     linux@weissschuh.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] tools/nolibc: add testcases for vfprintf
Message-ID: <530708ce-92af-41ad-84da-a691a518852b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230402184806.12440-1-w@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230402184806.12440-1-w@1wt.eu>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 02, 2023 at 08:48:02PM +0200, Willy Tarreau wrote:
> Hello Paul,
> 
> Thomas added new tests for vfprintf(), which is a good idea because it
> was a new implementation, we use it a lot in the tests so we'd rather
> make sure it works! This required to implement support for memfd_create()
> that is used to collect the output into a buffer, as well as to complete
> a little bit the minimalistic FILE emulation with fileno(), fdopen(),
> fflush() and fclose(). The result is neat and works equally on glibc and
> nolibc. We just had to cheat on the pointer test because for NULL nolibc
> prints "0x0" while glibc prints "(nil)" so we check 0x1 instead to avoid
> this special case.
> 
> Finally Thomas added a new target to the makefile to ease building the
> test against the default libc. This should help detect incompatibilities
> when new features are added.
> 
> I've tested it locally with my libc and against all supported architectures
> (userland tests only), and all tests passed.
> 
> This can be added to your dev tree for 6.5 on top of the previous series.

Looks like some useful code to make testing more comprehensive, thank
you both!  Queued and pushed.

							Thanx, Paul

> Thanks!
> Willy
> 
> Thomas Weißschuh (4):
>   tools/nolibc: add libc-test binary
>   tools/nolibc: add wrapper for memfd_create
>   tools/nolibc: implement fd-based FILE streams
>   tools/nolibc: add testcases for vfprintf
> 
>  tools/include/nolibc/stdio.h                 | 95 ++++++++++++++------
>  tools/include/nolibc/sys.h                   | 23 +++++
>  tools/testing/selftests/nolibc/.gitignore    |  1 +
>  tools/testing/selftests/nolibc/Makefile      |  6 ++
>  tools/testing/selftests/nolibc/nolibc-test.c | 86 ++++++++++++++++++
>  5 files changed, 184 insertions(+), 27 deletions(-)
> 
> -- 
> 2.17.5
> 
