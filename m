Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD2D630E81
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 12:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbiKSLnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 06:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiKSLnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 06:43:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6926A1BEBD;
        Sat, 19 Nov 2022 03:43:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7FC0B80A08;
        Sat, 19 Nov 2022 11:43:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E45EC433D6;
        Sat, 19 Nov 2022 11:43:36 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="k7SCL6Gy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1668858214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qzzqXgp+p3EZG/kh8YK4KXXSpuAY4zVujZgM6owSO+I=;
        b=k7SCL6GyueUEerP1U7nBsJrRPk19foGVb4qZgKW3xnDVvtjssBuKWHlQPerkCDuxFRwCye
        qHNthRO35gfBi3cFbsQkL0EdjCnyEAsOx/cXsqm03YPVk5UVQ1wey7J9mAFRFL1UBPj74W
        /i1L9i+lsfzpcd7BMAr+oLRR0qivaMk=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 811bb0d6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Sat, 19 Nov 2022 11:43:34 +0000 (UTC)
Date:   Sat, 19 Nov 2022 12:43:31 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>
Subject: Re: [PATCH v4 2/3] random: introduce generic vDSO getrandom()
 implementation
Message-ID: <Y3jBY4p2hEKDaUm+@zx2c4.com>
References: <20221118172839.2653829-1-Jason@zx2c4.com>
 <20221118172839.2653829-3-Jason@zx2c4.com>
 <ecfd265b-49e7-79b2-1818-e08a2c652db0@csgroup.eu>
 <Y3gbVorxZyb4SBJa@zx2c4.com>
 <Y3gdkxq4FjXcmAwA@zx2c4.com>
 <2571f72a-3420-977f-7b08-8f6216bba6a8@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2571f72a-3420-977f-7b08-8f6216bba6a8@csgroup.eu>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 19, 2022 at 07:51:21AM +0000, Christophe Leroy wrote:
> 
> 
> Le 19/11/2022 à 01:04, Jason A. Donenfeld a écrit :
> > On Sat, Nov 19, 2022 at 12:55:02AM +0100, Jason A. Donenfeld wrote:
> >> Sorry if I'm a bit slow here to grok what's up.
> 
> Maybe I should also have mentionned commit ce7d8056e38b ("powerpc/vdso: 
> Prepare for switching VDSO to generic C implementation.") for you to 
> have a complete picture.
> 
> > 
> > Okay, I think I see it now. That's a complicated patch for a simple idea
> > because gettime is more complicated than getrandom. I suspect what you
> > want is something like the below, correct? Seems easy enough.
> 
> Yes it is exactly that, powerpc will then call __cvdso_getrandom_data() 
> directly and pass rng_info pointer.

Okay, I'll do that and send out a v+1.

Jason
