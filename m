Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCBC26E408E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 09:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjDQHTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 03:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjDQHTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 03:19:01 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A08040D0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:18:48 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.187.55])
        by albert.telenet-ops.be with bizsmtp
        id ljJk2900L1C8whw06jJk4X; Mon, 17 Apr 2023 09:18:46 +0200
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1poJ8O-00GyYx-Gn;
        Mon, 17 Apr 2023 09:18:44 +0200
Date:   Mon, 17 Apr 2023 09:18:44 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
cc:     linux-spi@vger.kernel.org, linux-um@lists.infradead.org
Subject: Re: Build regressions/improvements in v6.3-rc7
In-Reply-To: <20230417071429.965980-1-geert@linux-m68k.org>
Message-ID: <1ab2158e-dda-c1c5-4a3b-301cd41f9ef@linux-m68k.org>
References: <CAHk-=wjwK59PegTZb9r=EVuCPwbigcbbby5AwEboMBgykhL-KA@mail.gmail.com> <20230417071429.965980-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Apr 2023, Geert Uytterhoeven wrote:
> JFYI, when comparing v6.3-rc7[1] to v6.3-rc6[3], the summaries are:
>  - build errors: +1/-2

   + /kisskb/src/drivers/spi/spi-stm32-qspi.c: error: 'op' is used uninitialized [-Werror=uninitialized]:  => 564:27, 523:27

um-x86_64-gcc12/um-all{mod,yes}config

Seen before, and looks completely bogus to me, unless there's a bug in
the UML implementation of memcpy() and memset(), which are used to
initialize "op".

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/6a8f57ae2eb07ab39a6f0ccad60c760743051026/ (all 152 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/09a9639e56c01c7a00d6c0ca63f4c7c41abe075d/ (all 152 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
