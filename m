Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFFBA60FC98
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 18:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235668AbiJ0QB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 12:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236236AbiJ0QBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 12:01:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398AA19347C
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 09:01:25 -0700 (PDT)
Date:   Thu, 27 Oct 2022 18:01:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666886483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aFGE9wVPsNhZKcVw4mBKXRkiezAjFPe++n3HDIMILqk=;
        b=AAbl27QOzJ6iPi9iQlIeR6inGJXMGEocK69Wq5YqvYCVFQTfXHQr04p3WQSwHgx/ocY4kB
        eRn2EohA/e97aabPTwBaEgw0rQMteU5MSq6ciKcWnC4dYBRT5SY3LWbnif07X2Xkc6jDY8
        hT12JUHViHjRLPieO6wJ9HKp5J/YG5628DCp+Isn36vnvSyY5878KW/oOWhIFD5zxGj8o8
        xP5nrzPYt9Uysz8N9SR3lrvpxZtp2uakbhA6CaGWGDvbNrkfoc5MQ+Yqm6Teg8yhIKzFS8
        8Cvf+yipy2JA9gl6JuuZ5h/aK9n6k2ZAOaLjT2BdkgQ98569bk4YDHjQJWSKqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666886483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aFGE9wVPsNhZKcVw4mBKXRkiezAjFPe++n3HDIMILqk=;
        b=2a740U//rvLWPpa3de6HuHqS163e+6a6rKXtbBjM1kbj5a+wN++6+kvQ1ApkW4LXEH8IQH
        keviPkoQlRLURVAQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Sultan Alsawaf <sultan@kerneltoast.com>
Subject: Re: [RFC][PATCH v2 00/31] timers: Use del_timer_shutdown() before
 freeing timers
Message-ID: <Y1qrUXkrZT1CyacK@linutronix.de>
References: <20221027150525.753064657@goodmis.org>
 <Y1qpNZuoIyvT5Edj@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Y1qpNZuoIyvT5Edj@zx2c4.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-27 17:52:21 [+0200], Jason A. Donenfeld wrote:
> On Thu, Oct 27, 2022 at 11:05:25AM -0400, Steven Rostedt wrote:
=E2=80=A6
>=20
> FYI, there's a related issue with add_timer_on(), currently without a
> straight forward solution, in case you're curious, discussed with
> Sebastian and Sultan a few weeks ago. Pasting from that thread, the
> issue is:
=E2=80=A6
=E2=80=A6
>=20
> It would be interesting if your patch fixed this case too. But maybe the
> above is unfixable (and rather niche anyway).

Haven't read the thread, yet, but the issue we talked about a few weeks
ago is unfixable. I plan to document this.
Eitherway CONFIG_DEBUG_OBJECTS_TIMERS should warn you here.

There are watchdogs (clocksource_watchdog()) which rotate CPUs and
invoke add_timer_on() from within the callback. This complicates
things.

> Jason

Sebastian
