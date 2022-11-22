Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C91F633EE3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 15:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbiKVO1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 09:27:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233697AbiKVO1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 09:27:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AFB2FD
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 06:27:26 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669127244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2P8A3XV3P5YSNLerOfTWhF9UZrwHIZ4tZ207o+/wjSA=;
        b=gcY+ynVjz6rGwbUu5W8l8yCCN7LrTUhmrOn7Q8IsEeVkVCT5eYVo1PiAL47V+IU0qa2+0B
        v828zY7r0Px+A9sK42X6iG+92Fh2+ZzsjsgmcRZwT54nGwkL5QQswD1wDKgA5mIoqdFarb
        K+tx10ACHMrQH7kcBLpkq1E6/7tpHhQmQg2PQQsQNOydPMxHVF3+qKqlw803mi0dgY/BjR
        tOTxomGuVu+5DuNlzjnQhtAcxvqmpBye6Z4v7Rn9kcrO8icELGD79vpIWytr5nYUmznyq9
        JwNJrPRpfnaRq9UhgiW3fn52sIbKNIL9DMo8glVX3uqI/VhLHlsWeterW+mJTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669127244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2P8A3XV3P5YSNLerOfTWhF9UZrwHIZ4tZ207o+/wjSA=;
        b=Tvhhh6wLp/q9lULTAjNqKBC64EZ7UoEMAmUDnk0MyeZyyw0z9YohVgkcPvBHfON3vTcFm2
        tnWOl6fTs3LGYuCg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: next-20221122: tinyconfig: ppc n s390:
 kernel/printk/printk.c:95:1: error: type specifier missing, defaults to
 'int'; ISO C99 and later do not support implicit int
 [-Werror,-Wimplicit-int]
In-Reply-To: <CA+G9fYvCWwndXdsvuW7iJ25wgfN6_iMY-OC_z6ufSwiJkzFFMw@mail.gmail.com>
References: <CA+G9fYvCWwndXdsvuW7iJ25wgfN6_iMY-OC_z6ufSwiJkzFFMw@mail.gmail.com>
Date:   Tue, 22 Nov 2022 15:33:16 +0106
Message-ID: <87o7szoyij.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

On 2022-11-22, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> Today's Linux next 20221122 tag clang-15 tinyconfig builds fails on
> powerpc and s390 architectures.

The problem is that CONFIG_SRCU is not selected. This must be selected
by any modules that requires SRCU. However, printk.c is _always_ built
into the kernel (even if !CONFIG_PRINTK). The registration of consoles
and the console list (which uses SRCU) is _always_ built into the
kernel.

So should CONFIG_SRCU now always be active?

@paulmck: Do you have a problem with permanently activating CONFIG_SRCU?

John Ogness
