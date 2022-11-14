Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9328B62886B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 19:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235636AbiKNSiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 13:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235782AbiKNSig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 13:38:36 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15C610A1;
        Mon, 14 Nov 2022 10:38:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F0E4ECE125E;
        Mon, 14 Nov 2022 18:38:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64680C433C1;
        Mon, 14 Nov 2022 18:38:29 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="hWgqPtZi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1668451107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uKUJi9cbk9TdF0FmuLuGLjhTZmnTZ6dC4XWfVqw8Lws=;
        b=hWgqPtZiUEhZyt77/C1ccAVG7AIRCO0qyMkSGT6GXzYETYqyBz45dMxCaE1jy50qU85XlP
        jxLhj+LIL+iOAN11uBWJsvQ6A+Sh+pEjoqC6CMnG/cM6wZ/YtxMC5J77NNG/8lnMthdOXC
        2akCyIEFMlGhHMqw5fXGAGGIT1mu9yA=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 2cc5e0b3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 14 Nov 2022 18:38:26 +0000 (UTC)
Date:   Mon, 14 Nov 2022 19:38:23 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Yann Droneaud <ydroneaud@opteya.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Theodore Ts'o <tytso@mit.edu>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/5] random: add helpers for random numbers with given
 floor or range
Message-ID: <Y3KLH4FqFbJ7bfY0@zx2c4.com>
References: <20221022014403.3881893-1-Jason@zx2c4.com>
 <20221022014403.3881893-4-Jason@zx2c4.com>
 <60574e8f-20ff-0996-5558-e9bd35e42681@opteya.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <60574e8f-20ff-0996-5558-e9bd35e42681@opteya.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 07:04:13PM +0100, Yann Droneaud wrote:
> I have a bad feeling about this one, and can't help but thinking it's going
> to bite someone: when asked to pick a number *between* 0 and 10,
> I usually think I'm allowed to pick 10 (even if I'm going to answer 7 as it should).

This is one of those bikeshed things you see all over the place, like
whether slices in a language should be [start index, end index] or
[start index, length], or whether arrays should be 0-based or 1-based.
We'll never settle this variety of dispute here.

But in this case, there are some particular reasons why it must be this
way. Firstly, usage of it this way matches most of the ways the function
is actually used in the kernel, and fits existing semantics. This alone
I find compelling. But also, having all of these functions use half-open
intervals means that each function can take care of its entire range,
without having to resort to using 64-bit arithmetic, and no function is
a complete subset of any other function. So doing it this way makes
these maximally useful too.

So anyway I think the function has to be defined like this. If you'd
like to bikeshed over a different name than "between", though, be my
guest. Maybe you'd like "from" better. But probably "between" is fine,
and with enough good examples (as my conversion patch does) and the
clear succinct documentation comment, we should be good.

Jason
