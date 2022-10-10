Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D565FA2FA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 19:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiJJRyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 13:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJJRyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 13:54:02 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF95213E14
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 10:53:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1BDB3CE1300
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 17:53:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C90ABC433D6;
        Mon, 10 Oct 2022 17:53:54 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="GzntsIxB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1665424433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yHVOQOudIXpHMrYSnvsH1AW7USNI2N8tlztxsr+u22A=;
        b=GzntsIxBkLi0+G8PY289Bpw/8LwaoXHdrkfmC1ASAwpKir4YWd20vp9rdHzk25T/3BRt6x
        c+t6Fo6LrscwkOzA01RqEamWauRStLpiZ4it5bgOcesmrlvQYCfj78QQvlXzq8CqqdEpPR
        9AcwQPdkuDXDinsG+7HyHA/wgbGRv9s=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 04885d67 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 10 Oct 2022 17:53:52 +0000 (UTC)
Date:   Mon, 10 Oct 2022 19:53:51 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "Jason A. Donenfeld" <zx2c4@kernel.org>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [crng-random:jd/get_random_u32_below 23/23]
 include/linux/random.h:64:69: sparse: sparse: cast truncates bits from
 constant value (1f4 becomes f4)
Message-ID: <Y0RcL2j98CatloRr@zx2c4.com>
References: <202210100722.Wc2gmfS6-lkp@intel.com>
 <a473cc4da4874235b2b98fd1a57e782e@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a473cc4da4874235b2b98fd1a57e782e@AcuMS.aculab.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 05:18:40PM +0000, David Laight wrote:
> From: kernel test robot <lkp@intel.com>
> > Sent: 10 October 2022 00:32
> > To: Jason A. Donenfeld <zx2c4@kernel.org>
> ...
> 
> I'm missing the main mailing list email for this change.
> I'm guessing the non-inlined code for non-constant ceil
> is similar.

It's part of a development tree I already linked you to. It's not done
yet. This alert is just about needing a __force.

> 
> > vim +64 include/linux/random.h
> > 
> >     53
> >     54	u32 __get_random_u32_below(u32 ceil);
> >     55	/* Returns a random integer in the interval [0, ceil), with uniform distribution. */
> >     56	static inline u32 get_random_u32_below(u32 ceil)
> >     57	{
> >     58		if (!__builtin_constant_p(ceil))
> >     59			return __get_random_u32_below(ceil);
> >     60
> >     61		for (;;) {
> >     62			if (ceil <= 1U << 8) {
> >     63				u32 mult = ceil * get_random_u8();
> >   > 64				if (is_power_of_2(ceil) || (u8)mult >= -(u8)ceil % ceil)
> >     65					return mult >> 8;
> 
> If you are going to check is_power_of_2() then you might as well do:
> 		u32 val = get_random_u8();
> 		if (is_power_of_2(ceil))
> 			return ceil == 0x100 ? val : val & (ceil - 1);
> Except that you don't want to loop on zero - so !(ceil & (ceil - 1))

I thought I opted out of the Laight drive-bys?

Either way, I don't understand your comments or how they pertain to the
current code in that unfinished development branch. Please just send
real patches.

Jason
