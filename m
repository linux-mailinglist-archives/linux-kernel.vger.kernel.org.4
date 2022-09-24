Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D5B5E8F60
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 20:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbiIXSeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 14:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbiIXSd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 14:33:58 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 657673B707
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 11:33:57 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 28OIUpan005575;
        Sat, 24 Sep 2022 13:30:51 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 28OIUoYF005572;
        Sat, 24 Sep 2022 13:30:50 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Sat, 24 Sep 2022 13:30:50 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/irq: Modernise inline assembly in irq_soft_mask_{set,return}
Message-ID: <20220924183050.GP25951@gate.crashing.org>
References: <178f30ff62c0317061f019b3dbbc079073f104c3.1663656058.git.christophe.leroy@csgroup.eu> <CN3LB8F3D9LM.3W1RQRVS64UXU@bobo> <20220923121829.GL25951@gate.crashing.org> <CN3X6YN1FRQ3.1Z9BVD6WYQY3M@bobo> <20220923221543.GN25951@gate.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923221543.GN25951@gate.crashing.org>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 05:15:43PM -0500, Segher Boessenkool wrote:
> On Sat, Sep 24, 2022 at 02:26:52AM +1000, Nicholas Piggin wrote:
> > I still don't see what clauses guarantees asm("%0" ::"r"(foo)) to give
> > 13. It doesn't say access via inline assembly is special,
> 
> But it is.  It is for all register variables, local and global.  I agree
> this isn't documented clearly.  For local register variables this is the
> *only* thing guaranteed; for global register vars there is more (it
> changes the ABI, there are safe/restore effects, that kind of thing).

I filed <https://gcc.gnu.org/PR107027> to improve the docs.  Thanks for
bringing this to our attention!


Segher
