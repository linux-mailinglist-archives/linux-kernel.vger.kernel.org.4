Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C447D680226
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 23:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235371AbjA2WKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 17:10:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbjA2WKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 17:10:51 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 876761C315
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 14:10:50 -0800 (PST)
Received: (qmail 382400 invoked by uid 1000); 29 Jan 2023 17:10:49 -0500
Date:   Sun, 29 Jan 2023 17:10:49 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
        paulmck@kernel.org, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        dlustig@nvidia.com, joel@joelfernandes.org, urezki@gmail.com,
        quic_neeraju@quicinc.com, frederic@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] tools/memory-model: Make ppo a subrelation of po
Message-ID: <Y9bu6RMCSsI+wDYf@rowland.harvard.edu>
References: <20230126134604.2160-1-jonas.oberhauser@huaweicloud.com>
 <20230126134604.2160-3-jonas.oberhauser@huaweicloud.com>
 <Y9Kr+GntQyGKPH3K@rowland.harvard.edu>
 <47acbaa7-8280-48f2-678f-53762cf3fe9d@huaweicloud.com>
 <Y9V+CyKIjg8sgVAC@rowland.harvard.edu>
 <Y9WeOTmGCCfjMUtG@andrea>
 <Y9Wo6OttHC4sUxCS@rowland.harvard.edu>
 <Y9aoA2UxvWyNwOtx@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9aoA2UxvWyNwOtx@andrea>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2023 at 06:11:12PM +0100, Andrea Parri wrote:
> > The reason why Wx=1 ->ww-vis Wx=2:
> > 
> > 	0:Wx=1 ->po-rel 0:Wy=1 and po-rel < fence < ww-post-bounded.
> > 
> > 	0:Wy=1 ->rfe 1:Ry=1 ->(hb* & int) 1:Rdy=1 and
> > 		(rfe ; hb* & int) <= (rfe ; xbstar & int) <= vis.
> > 
> > 	1:Rdy=1 ->po 1:unlock ->rfe 3:lock ->po 3:Wx=2
> > 		so 1:Rdy=1 ->po-unlock-lock-po 3:Wx=2
> > 		and po-unlock-lock-po <= mb <= fence <= w-pre-bounded.
> > 
> > Finally, w-post-bounded ; vis ; w-pre-bounded <= ww-vis.
> 
> To clarify, po-unlock-lock-po is not a subrelation of mb; see what
> happens without the smp_mb__after_unlock_lock().

Ah, thank you again.  That was what I got wrong, and it explains why the 
data race appears with Jonas's patch.

This also points out an important unstated fact: All of the inter-CPU 
extended fences in the memory model are A-cumulative.  In this case the 
fence links Rdy=1 on P1 to Wx=3 on P3.  We know that 0:Wx=1 is visible 
to P1 before the Rdy executes, but what we need is that it is visible to 
P3 before Wx=3 executes.  The fact that the extended fence is strong 
(and therefore A-cumulative) provides this extra guarantee.

Alan
