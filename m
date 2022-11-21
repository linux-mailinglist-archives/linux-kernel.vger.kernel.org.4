Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 190CE6318DD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 04:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiKUDXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 22:23:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiKUDXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 22:23:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B1D1409D;
        Sun, 20 Nov 2022 19:23:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 684D760E9E;
        Mon, 21 Nov 2022 03:23:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DD15C433D6;
        Mon, 21 Nov 2022 03:22:59 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="UTJ7/TuL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1669000977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DAa5Mzb5unqukMrdaJuHIYWbZgREOXZOVUCauEOi2ps=;
        b=UTJ7/TuLDD1B+OoUcpwgmLVZFvlUFpMC4gBltI6OxPZ78kzxh84N1P6i4IgYHl0PE4sSYD
        jPUX0NYXAF5uitLAOsAzthyR438A8ATpqZtkPg6Tk1STEcMJzJSDJWZINZsSPjfmWncLIn
        stONI7x5GrBtA2+CGCWBLk6Dnh4vnvo=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ca013759 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 21 Nov 2022 03:22:57 +0000 (UTC)
Date:   Mon, 21 Nov 2022 04:22:54 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-crypto@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>
Subject: Re: [PATCH v5 2/3] random: introduce generic vDSO getrandom()
 implementation
Message-ID: <Y3rvDg9H8lTL8ecU@zx2c4.com>
References: <20221119120929.2963813-1-Jason@zx2c4.com>
 <20221119120929.2963813-3-Jason@zx2c4.com>
 <Y3liVEdYByF2gZZU@sol.localdomain>
 <Y3l6ocn1dTN0+1GK@zx2c4.com>
 <Y3mGQyqPBTcoyPpS@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y3mGQyqPBTcoyPpS@zx2c4.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 20, 2022 at 02:43:31AM +0100, Jason A. Donenfeld wrote:
> On Sun, Nov 20, 2022 at 01:53:53AM +0100, Jason A. Donenfeld wrote:
> > shouldn't fork or something, but that seems disappointing. Or more state
> > could be allocated in the zeroing region, to hold a chacha state, so
> > another 64 bytes, which would be sort of unfortunate. Or something else?
> > I'd be interested to hear your impression of this quandary.
> 
> Another 128 bytes, actually. And the current chacha in there isn't
> cleaning up its stack as one might hope. So maybe the cleanest solution
> would be to just bite the bullet and allocate another 128 bytes per
> state and make a mini chacha that operates over that? (And I guess hope
> it doesn't need to spill and such...)

I've got it implemented without using any stack now. Wasn't so bad. So
all of the additional concerns I added will be addressed in v+1.

Jason
