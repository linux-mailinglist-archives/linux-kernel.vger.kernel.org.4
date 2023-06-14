Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3597730054
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 15:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245081AbjFNNpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 09:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245065AbjFNNpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 09:45:50 -0400
Received: from mail.sdinet.de (hydra.sdinet.de [136.243.3.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C08B2102
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 06:45:45 -0700 (PDT)
Received: from aurora48.sdinet.de (aurora48.sdinet.de [193.103.159.48])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: haegar)
        by mail.sdinet.de (bofa-smtpd) with ESMTPSA id 05EBE34034B;
        Wed, 14 Jun 2023 15:44:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sdinet.de; s=mail;
        t=1686750289; bh=cqI6kYniynqv2aekEIshJYC4NhMe2RLMnPA7QqMC0F8=;
        l=1041; h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=jzYq3HEJNOsS5pBd81eaIv3yWYB8ihOcwqbipHrK8oI0VtckWYj5lfmzya+TIIx+d
         eUBU+na81KNiDI6M6YDh4m7nv2X7noxQbaOnA05Ik3gZo6xpcTgGTlbV36Kc1E5G1R
         EybWuPW+8IowVJKgUBfxod2pOzH1Ed8fXPVGodOp1nqXQtz04QqTg7BKNSpT6vRxzG
         jZJfqALeO0aOPV3hjjx44OhcI5f6R6ugLwoXGtGREai/9FiVKdhZ5JLBx/BYkMM+Ji
         dJXfuKodFBnIScd9lPNO8xCSLQhajm5Yv4pqIZMMEHj+zbuJxcL5cn4INe4Un64nb2
         FapLvhO8KTl4A==
Date:   Wed, 14 Jun 2023 15:45:41 +0200 (CEST)
From:   Sven-Haegar Koch <haegar@sdinet.de>
To:     Luiz Capitulino <luizcap@amazon.com>
cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Bhatnagar, Rishabh" <risbhat@amazon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "sashal@kernel.org" <sashal@kernel.org>, abuehaze@amazon.com,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: Observing RCU stalls in kernel 5.4/5.10/5.15/6.1 stable trees
In-Reply-To: <4c4178a1-1050-ced4-e6fb-f95c3bdefc98@amazon.com>
Message-ID: <2a3fa097-8ba0-5b0e-f506-779fee5b8fef@sdinet.de>
References: <12c6f9a3-d087-b824-0d05-0d18c9bc1bf3@amazon.com> <c4724b40-89f6-5aa7-720d-c4a4af57cf45@amazon.com> <2023061428-compacter-economic-b648@gregkh> <20230614092045.tNY8USjq@linutronix.de> <4c4178a1-1050-ced4-e6fb-f95c3bdefc98@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jun 2023, Luiz Capitulino wrote:

> On 2023-06-14 05:20, Sebastian Andrzej Siewior wrote:
>  
> > On 2023-06-14 11:14:49 [+0200], gregkh@linuxfoundation.org wrote:
> > > Oops, missed this.
> > > 
> > > Yes, there might be, can you do 'git bisect' and track down the patch
> > > that fixed this?
> > 
> > There was a report of a lockup during boot in VMs yesterday. If I
> > remember correctly this still exists and might be related to this
> > report. I'm going to have a look.
> 
> Thanks, Sebastian. Do you have a link for the discussion?

May be this, talking about the same commit as cause as this thread:

Subject: Re: [PATCH] timekeeping: Align tick_sched_timer() with the HZ 
tick. -- regression report
https://lore.kernel.org/lkml/5a56290d-806e-b9a5-f37c-f21958b5a8c0@grsecurity.net/

May not have been the best idea to respond with such big analysis to a 3 
months old dead thread, gets lost extremely easy.

c'ya
sven-haegar

-- 
Three may keep a secret, if two of them are dead.
- Ben F.
