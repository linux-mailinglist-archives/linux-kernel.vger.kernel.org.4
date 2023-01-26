Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D42D67D985
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 00:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbjAZXQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 18:16:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjAZXQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 18:16:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEC6F742
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 15:16:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE06861950
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 23:16:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41345C433EF;
        Thu, 26 Jan 2023 23:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1674774971;
        bh=DzMj8quRGZzfP4LzqMW0/0WiOG9K84kclaczDPTR9hQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vZzkHXUd55UHlrFSl5UYOQw8xTPzkkHQEKTaR4XMmM9nNadmhN+z+9mTzMMZX9lMH
         bGc6MHUao0uGuWpbN1v38qLNyGnedkywv7FbN7loN/hZKfIurtPWdoG1xEp6pITmo8
         BiSQ6TGuZUIg2rCAK0XF0Girj0Op/z62q9SUHPyA=
Date:   Thu, 26 Jan 2023 15:16:10 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mikhail Zaslonko <zaslonko@linux.ibm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH 0/8] lib/zlib: Set of s390 DFLTCC related patches for
 kernel zlib
Message-Id: <20230126151610.29e25c9870b77f0c880382bb@linux-foundation.org>
In-Reply-To: <20230126131428.1222214-1-zaslonko@linux.ibm.com>
References: <20230126131428.1222214-1-zaslonko@linux.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jan 2023 14:14:20 +0100 Mikhail Zaslonko <zaslonko@linux.ibm.com> wrote:

> Patches 1-7 represent a set of s390 zlib hardware support (DFLTCC) related fixes
> and enhancements integrated from zlib-ng repo relevant to kernel zlib
> (https://github.com/zlib-ng/zlib-ng).
> Since the official zlib repository never got DFLTCC support code merged, all
> the patches have been picked from zlib-ng fork (zlib data compression library
> for the next generation systems). This repo contains new optimizations and
> fixes not getting implemented into the official zlib repository and falls under
> the same zlib License. All of the original patches from zlib-ng were authored
> by Ilya Leoshkevich <iii@linux.ibm.com>. Coding style has been preserved for
> future maintainability.
> Patches 1-2 should have no effect for the kernel zlib but make the code
> closer to zlib-ng for future maintainability.
> Only Patch 3 touches common zlib_deflate code, other patches are relevant to
> s390 tree only.
> 
> Patch 8 is separate and intends to resolve an issue with kernel PPP driver
> which can use kernel zlib for packet compression. Without this patch PPP
> decompression can fail due to error code returned by hardware (dfltcc_inflate)
> and PPP disables zlib compression for further packets.
> 
> @Andrew, would you pick this patch series yourself (which is totally fine
> with me) or shall we carry it via s390 tree?

I'll grab.  zlib changes are pretty rare, but perhaps someone else will
do something..

> Mikhail Zaslonko (8):
>   lib/zlib: Adjust offset calculation for dfltcc_state
>   lib/zlib: Implement switching between DFLTCC and software
>   lib/zlib: Fix DFLTCC not flushing EOBS when creating raw streams
>   lib/zlib: Fix DFLTCC ignoring flush modes when avail_in == 0
>   lib/zlib: DFLTCC not writing header bits when avail_out == 0
>   lib/zlib: Split deflate and inflate states for DFLTCC
>   lib/zlib: DFLTCC support inflate with small window
>   lib/zlib: DFLTCC always switch to software inflate for Z_PACKET_FLUSH
>     option

Most of these have a github link in lieu of a changelog.  And most of
the github commits are unchangelogged.  That's pretty sad, but the zlib
audience is small and zlib isn't really kernel code anyway, so I guess
we can look the other way.
