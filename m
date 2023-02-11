Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0BD692BBD
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 01:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjBKAHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 19:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjBKAHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 19:07:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AA59006;
        Fri, 10 Feb 2023 16:07:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A96D7B82620;
        Sat, 11 Feb 2023 00:07:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A11CC433EF;
        Sat, 11 Feb 2023 00:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676074059;
        bh=vEoxCb85rv5N0sGWpFT37BdKiUsrb6yPu+MMd9GxDyI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=I7i/yT/cFdCqMkwwRDSdKsHwXl+rBD8fs0UdTZ0LUHzmdpggCdnFgT+IzxFG4EE0t
         VE+9Y7V5S3y7NfJm055YEqkgs4jXEGxSy14VFfe/2emlZg6LhDwdbVUoU12W75vUd8
         6oB0ecTxbcSXzzZnbYK8sYeJEjvKFFShrWJBhehalBRS609SA0Mv2RHLP11G1kPKq7
         FmbqDBFieD+tkLX0iBPet8H/PiSPtoRJJIV45+J2lvEEM7fgZcMxstQikr1uCmp5vL
         66G23NRCD4gL7CyDSqnNloBmFW2uhslyvG637cTK7d4dO0QgFrytbDvVhTV6BF8emf
         g+pn2jk/APVLQ==
Message-ID: <512be61587339db248f5d88dc5240ee3.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230206083305.147582-1-sergio.paracuellos@gmail.com>
References: <20230206083305.147582-1-sergio.paracuellos@gmail.com>
Subject: Re: [PATCH] clk: ralink: fix 'mt7621_gate_is_enabled()' function
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        matthias.bgg@gmail.com
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-clk@vger.kernel.org
Date:   Fri, 10 Feb 2023 16:07:37 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sergio Paracuellos (2023-02-06 00:33:05)
> Compiling clock driver with CONFIG_UBSAN enabled shows the following trac=
e:
>=20
> UBSAN: shift-out-of-bounds in drivers/clk/ralink/clk-mt7621.c:121:15
> shift exponent 131072 is too large for 32-bit type 'long unsigned int'
> CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.15.86 #0
> Stack : ...
>=20
> Call Trace:
> [<80009a58>] show_stack+0x38/0x118
> [<8045ce04>] dump_stack_lvl+0x60/0x80
> [<80458868>] ubsan_epilogue+0x10/0x54
> [<804590e0>] __ubsan_handle_shift_out_of_bounds+0x118/0x190
> [<804c9a10>] mt7621_gate_is_enabled+0x98/0xa0
> [<804bb774>] clk_core_is_enabled+0x34/0x90
> [<80aad73c>] clk_disable_unused_subtree+0x98/0x1e4
> [<80aad6d4>] clk_disable_unused_subtree+0x30/0x1e4
> [<80aad6d4>] clk_disable_unused_subtree+0x30/0x1e4
> [<80aad900>] clk_disable_unused+0x78/0x120
> [<80002030>] do_one_initcall+0x54/0x1f0
> [<80a922a4>] kernel_init_freeable+0x280/0x31c
> [<808047c4>] kernel_init+0x20/0x118
> [<80003e58>] ret_from_kernel_thread+0x14/0x1c
>=20
> Shifting a value (131032) larger than the type (32 bit unsigned integer)
> is undefined behaviour in C.
>=20
> The problem is in 'mt7621_gate_is_enabled()' function which is using the
> 'BIT()' kernel macro with the bit index for the clock gate to check if the
> bit is set. When the clock gates structure is created driver is already
> setting 'bit_idx' using 'BIT()' macro, so we are wrongly applying an extra
> 'BIT()' mask here. Removing it solve the problem and makes this function
> correct. However when clock gating is correctly working, the kernel starts
> disabling those clocks that are not requested. Some drivers for this SoC
> are older than this clock driver itself. So to avoid the kernel to disable
> clocks that have been enabled until now, we must apply 'CLK_IS_CRITICAL'
> flag on gates initialization code.
>=20
> Fixes: 48df7a26f470 ("clk: ralink: add clock driver for mt7621 SoC")
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---

Applied to clk-next
