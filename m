Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0361D715CA0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbjE3LH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjE3LH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:07:28 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F1FC93;
        Tue, 30 May 2023 04:07:26 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 39AC492009C; Tue, 30 May 2023 13:07:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 3298B92009B;
        Tue, 30 May 2023 12:07:26 +0100 (BST)
Date:   Tue, 30 May 2023 12:07:26 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
cc:     Paul Cercueil <paul@crapouillou.net>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH 1/2] MIPS: Allow MIPS32R2 kernel to run on P5600 and
 M5150
In-Reply-To: <684C1A48-C743-4045-AF12-B0846FCE8EBE@flygoat.com>
Message-ID: <alpine.DEB.2.21.2305301152080.42601@angie.orcam.me.uk>
References: <20230529135245.4085-1-jiaxun.yang@flygoat.com> <alpine.DEB.2.21.2305300321520.25569@angie.orcam.me.uk> <684C1A48-C743-4045-AF12-B0846FCE8EBE@flygoat.com>
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

On Tue, 30 May 2023, Jiaxun Yang wrote:

> >> M5150 and P5600 are two MIPS32R5 kernels, however as MIPS32R5 is
> >> backward compatible with MIPS32R2 there is no reason to forbid
> >> M5150 and P5600 on MIPS32R2 kernel.
> > 
> > What problem are you trying to solve?  The CONFIG_SYS_HAS_CPU_* settings 
> > denote overall platform's support for the given CPU and have nothing to do 
> > with what architecture level a given kernel has been configured for.  You 
> > do need to get the settings right for your platform, just as you do in 
> > 2/2, but this 1/2 part looks wrong to me.
> 
> Well the universal target is to allow R2 generic kernel to run on R5 CPUs.
> As R5 is backward compatible we can just have one universal kernel binary.

 Sure, but this change is not needed for it.  You just need to declare 
which ISA revisions your platform supports and leave `__get_cpu_type' 
alone.  It has worked like that for a decade now.

 Back in the day I used to run R1 kernels on R2 hardware myself.  And 
maybe MIPS IV on R1 even, as we had MIPS Malta CPU modules with both MIPS 
IV devices (QED RM5261/RM7061) and MIPS64r1 devices (MIPS 5Kc/20Kc/25Kf) 
and switching the kernel when swapping modules was a nuisance.  The Malta 
config still supports these devices although some may not exist anymore.

  Maciej
