Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB926C9781
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 20:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbjCZSpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 14:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjCZSpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 14:45:13 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F36D186
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 11:45:11 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 32QIj4MQ011555;
        Sun, 26 Mar 2023 20:45:04 +0200
Date:   Sun, 26 Mar 2023 20:45:04 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] tools/nolibc: tests: add test for -fstack-protector
Message-ID: <ZCCSsFGqTFWknGBL@1wt.eu>
References: <89a960c7-0c9b-43ab-9fc8-a68405f7ed6a@p183>
 <8e156377-e7d9-48ec-a7ee-292aba002201@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e156377-e7d9-48ec-a7ee-292aba002201@t-8ch.de>
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 26, 2023 at 01:42:35PM -0500, Thomas Weißschuh  wrote:
> 
> Mar 26, 2023 13:30:21 Alexey Dobriyan <adobriyan@gmail.com>:
> 
> > Willy Tarreau wrote:
> >> #if defined(__clang__)
> >> __attribute__((optnone))
> >> #elif defined(__GNUC__)
> >> __attribute__((optimize("O0")))
> >> #endif
> >> static int smash_stack(void)
> >> {
> >>     char buf[100];
> >>
> >>     for (size_t i = 0; i < 200; i++)
> >>         buf[i] = 'P';
> >>
> >>     return 1;
> >> }
> >
> > If you want to corrupt the stack, corrupt the stack!
> 
> I do!
> 
> > asm(
> > ".globl f\n"
> > "f:\n"
> > "movq $0, (%rsp)\n"
> > "ret\n"
> > ".type f,@function\n"
> > ".size f,.-f"
> > );
> > > No problems with optimisation levels.
> 
> Wouldn't this be architecture-specific?

Yes it would. I'm not seeing any issue with your approach instead, let's
keep it as-is for now (also it does what the stack protector is supposed
to catch anyway).

Willy
