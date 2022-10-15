Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B155E5FF956
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 11:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiJOJE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 05:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiJOJEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 05:04:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9F51AF21
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 02:04:50 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1665824688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O2r2z/z0hDoo2fh70QGYrUogL6TlcVgEKV7x78z66rk=;
        b=wZ3A/EFb4G6uurDA8QKXiizxdoxYR3Jam1s3WZDYV9AObyHEPUyugqKotgGPGlttpyyqbZ
        00CYpl+9rAbhzgpo5OEbXraxPEry/QZhxbNDaQXpaN9HXZ6qzRd0FVBn8P43g8E7BmSENn
        1jln89FlJtjTWT78Ie4yq6ppn+aa0g9pXTGAg+CggXj0qaq1QSor9+tCjlxixo2J/6RqT5
        XGHvewENPpjNtEzTJiWGAF+U9W6OXxpHldZoJ/3rcjIeeMMLuEWPWMj83FusJ0vVWoKPUM
        /XKixrvwt8PUouDljQLgmXXAkkTZesN2jyn40BPx2Gm36cCscOkcBIZvItMVag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1665824688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O2r2z/z0hDoo2fh70QGYrUogL6TlcVgEKV7x78z66rk=;
        b=Aduh0A0cNaJ8nQRyYpvXMx8W9EFOUe8/aIlhdsZRrdSd91ovdKPL4JuxWEfVfJ6qnyXeSn
        IAeKSJxHo4/48yAg==
To:     Victor Hassan <victor@allwinnertech.com>,
        daniel.lezcano@linaro.org, wens@csie.org, jernej.skrabec@gmail.com,
        samuel@sholland.org, maxime@cerno.tech
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [RESEND] clocksource: sun4i: Fix the bug that tick_resume stucks
In-Reply-To: <20221009032507.39145-1-victor@allwinnertech.com>
References: <20221009032507.39145-1-victor@allwinnertech.com>
Date:   Sat, 15 Oct 2022 11:04:47 +0200
Message-ID: <87zgdxa24w.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 09 2022 at 11:25, Victor Hassan wrote:
> Currently syscore_resume() will stuck on tick_resume().

This lacks a clear explanation of the problem, i.e. WHY the current
implementation is not working.

> Fix this by changing  `.tick_resume` from
> sun4i_clkevt_shutdown() to a new function sun4i_tick_resume().
>  
> -static struct timer_of to = {
> -	.flags = TIMER_OF_IRQ | TIMER_OF_CLOCK | TIMER_OF_BASE,

How is switching from a statically allocated struct to a runtime
allocated struct related to the problem?

Thanks,

        tglx
