Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26D2625DED
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 16:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235002AbiKKPJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 10:09:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234903AbiKKPID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 10:08:03 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC83A6A771;
        Fri, 11 Nov 2022 07:06:46 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1otVcD-00037d-04; Fri, 11 Nov 2022 16:06:45 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 86DD8C11F2; Fri, 11 Nov 2022 16:05:19 +0100 (CET)
Date:   Fri, 11 Nov 2022 16:05:19 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: pic32: treat port as signed integer
Message-ID: <20221111150519.GE13465@alpha.franken.de>
References: <20221028132344.1993934-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028132344.1993934-1-Jason@zx2c4.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 03:23:44PM +0200, Jason A. Donenfeld wrote:
> get_port_from_cmdline() returns an int, yet is assigned to a char, which
> is wrong in its own right, but also, with char becoming unsigned, this
> poses problems, because -1 is used as an error value. Further
> complicating things, fw_init_early_console() is only ever called with a
> -1 argument. Fix this up by removing the unused argument from
> fw_init_early_console() and treating port as a proper signed integer.
> 
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
> Thomas - this is part of the -funsigned-char work I've been accumulating
> in my unsigned-char branch. If you want to take this as a fix for 6.1,
> go ahead. Otherwise, Linus asked me to keep the 6.2 unsigned-char
> patches together in my branch, so I'll take this, pending your Ack.
> -Jason
> 
>  arch/mips/include/asm/fw/fw.h             |  2 +-
>  arch/mips/pic32/pic32mzda/early_console.c | 13 ++++++-------
>  arch/mips/pic32/pic32mzda/init.c          |  2 +-
>  3 files changed, 8 insertions(+), 9 deletions(-)

applied to mips-fixes.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
