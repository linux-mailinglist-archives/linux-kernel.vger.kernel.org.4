Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEE060CAE6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 13:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiJYL2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 07:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiJYL2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 07:28:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21C218D45C;
        Tue, 25 Oct 2022 04:28:15 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666697293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j00FzWp2DyoqTFDqRk0YLSglffeF01Js6+w7bEZmwNM=;
        b=l71XfcAhxqUMYyLb6J5362OAWgdW/zU2metRCyQUk7jOeuO+qmyxwZk/2zhBXKftgtJ9c/
        bRHczdniYcmsyegXhM13t92O8y72FeWj8VD8myypiPI37cst1nwyc1m0zTmjxnu24/pkS6
        bSEvn3tUTVhTEAkpk6tQUDNjG+aLUgwyF6tyy1yjWJrUnyxzr75UWrgeb3tU33jgUb9us4
        1ClP9zuZmBDOuuNaqILy3vDM8Xm+f23jPY8yrOQrl9wAEzfc5MWHF4gShl5wbP8vz4/Yw3
        fddhFgaYlJ6GrKyVFzci65mSr3QctPaX0hsbHzsWynLNuPjyih5X13S+Y8Bh0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666697293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j00FzWp2DyoqTFDqRk0YLSglffeF01Js6+w7bEZmwNM=;
        b=5Z7hvJgeW/8IOsZH9zCVaPGCmsM2TtwRxk3HhpkgSGk1Tg9j/Fsmj079UEvOlSz4baTZa7
        Kjm45zFlSoDy59Dg==
To:     Doug Anderson <dianders@chromium.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org
Subject: Re: [PATCH printk v2 12/38] tty: serial: kgdboc: use
 console_is_enabled()
In-Reply-To: <CAD=FV=WF2S9wQ6uR+VKU4EfDTVd0JnKkuU3Wyfo6P8E_FouebQ@mail.gmail.com>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
 <20221019145600.1282823-13-john.ogness@linutronix.de>
 <CAD=FV=VFxKL=sOMdhyHrgy2JOtzKJdOe4euwZRRAK7P-rNVjuQ@mail.gmail.com>
 <CAD=FV=WF2S9wQ6uR+VKU4EfDTVd0JnKkuU3Wyfo6P8E_FouebQ@mail.gmail.com>
Date:   Tue, 25 Oct 2022 13:34:12 +0206
Message-ID: <87czagf8hf.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-24, Doug Anderson <dianders@chromium.org> wrote:
> It actually only holds console_list_lock() even at the end of the
> series. Still, it seems weird that we're declaring the `data_race` on
> CON_ENABLED but not CON_BOOT ?

You are correct that it is not a data race (because of the
console_list_lock being held.) Petr has suggested adding a separate
function for non-data-race callers. For v3 I will do this and use it
here, probably called console_is_enabled_locked().

Usually CON_ENABLED is the only flag that is interesting during normal
operation. The kgdboc case is an exception. I thought about if we should
have console_flags() and console_flags_locked() to be able to handle
general con->flags access. console_flags() would be marked with
data_race(), console_flags_locked() would use lockdep to ensure the
console_list_lock is held.

But I would also like to have the _is_enabled special variant because
how we check if a console is enabled will be different for the atomic
consoles. I would like to hide those details in the _is_enabled
implementation.

John Ogness
