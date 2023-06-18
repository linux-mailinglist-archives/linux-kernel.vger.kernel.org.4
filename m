Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3253473495E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 01:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjFRXpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 19:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFRXpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 19:45:23 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F86A99
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 16:45:22 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 1C35792009C; Mon, 19 Jun 2023 01:45:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 0D6CA92009B;
        Mon, 19 Jun 2023 00:45:21 +0100 (BST)
Date:   Mon, 19 Jun 2023 00:45:20 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Randy Dunlap <rdunlap@infradead.org>
cc:     "David S. Miller" <davem@davemloft.net>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, sparclinux@vger.kernel.org,
        linux-parport@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SPARC: Fix parport_pc support for 32-bit platforms
In-Reply-To: <159350f1-bcb2-e81d-ce28-a07a698c468f@infradead.org>
Message-ID: <alpine.DEB.2.21.2306190043160.14084@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2306182347101.14084@angie.orcam.me.uk> <159350f1-bcb2-e81d-ce28-a07a698c468f@infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Jun 2023, Randy Dunlap wrote:

> There is one new warning that should be fixed as well:
> 
> <stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
> In file included from ../include/linux/spinlock.h:88,
>                  from ../include/linux/kref.h:16,
>                  from ../include/linux/mm_types.h:8,
>                  from ../include/linux/buildid.h:5,
>                  from ../include/linux/module.h:14,
>                  from ../drivers/parport/parport_pc.c:46:
> ../arch/sparc/include/asm/parport.h:27:24: warning: 'dma_spin_lock' defined but not used [-Wunused-variable]
>    27 | static DEFINE_SPINLOCK(dma_spin_lock);
>       |                        ^~~~~~~~~~~~~
> ../include/linux/spinlock_types.h:43:44: note: in definition of macro 'DEFINE_SPINLOCK'
>    43 | #define DEFINE_SPINLOCK(x)      spinlock_t x = __SPIN_LOCK_UNLOCKED(x)
>       |                                            ^

 Ah, that's because `sparc32_defconfig' doesn't have CONFIG_WERROR enabled 
and I didn't double-check.  Thanks for your input.  I'll send v2 shortly.

  Maciej
