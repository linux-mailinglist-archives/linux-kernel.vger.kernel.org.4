Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF7061EF6C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 10:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbiKGJpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 04:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbiKGJpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 04:45:09 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A73955AC;
        Mon,  7 Nov 2022 01:45:06 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667814304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r8Z4Zi1uANBreU8pmHg5GxgTJ8KVuf0bPgW9y6lD8Pk=;
        b=ViMCNpcArCVmGhGZmToYhiU7CH8jdvYCPOCpKIjq5QfnEATVb3hQdDi6S6qTSV/2Kw7h+Q
        OdViPMuE4JxyXMipMIPWE0wYqLvjO7yEpyaV6TSYXuoPVSNadVko5LTquik1ZqtTUSTGEd
        bjX8YLv/q8upm4LydNdEMJx/ToubWtcSC/fqD+11Pe7DbXnv0Jt7WWw5507GQcem/MZPGh
        iXQeK/aXH61DFjN3NHbwJ+C/oGqZnPLPObtN6XaV6Jqv0JH63cwPz7Mc9sfIqE8Ozx/6Ll
        122mw92La0GRrntkR+CZqv9o2zU4quvOENjMwrgpP8jXa5MtEEPoVMJwAlS3Lw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667814304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r8Z4Zi1uANBreU8pmHg5GxgTJ8KVuf0bPgW9y6lD8Pk=;
        b=+pOpX581v8MitwoMCwXj5R0Idf95XwqAw037HFjQ/WUPsrAezfzKPtLPXf0dwnN5uD6lAc
        lV7uGAHBobKHaFAA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Doug Anderson <dianders@chromium.org>,
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
In-Reply-To: <Y2jGKnSw02QLecx+@alley>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
 <20221019145600.1282823-13-john.ogness@linutronix.de>
 <CAD=FV=VFxKL=sOMdhyHrgy2JOtzKJdOe4euwZRRAK7P-rNVjuQ@mail.gmail.com>
 <CAD=FV=WF2S9wQ6uR+VKU4EfDTVd0JnKkuU3Wyfo6P8E_FouebQ@mail.gmail.com>
 <87czagf8hf.fsf@jogness.linutronix.de>
 <87bkpm7kp8.fsf@jogness.linutronix.de> <Y2jGKnSw02QLecx+@alley>
Date:   Mon, 07 Nov 2022 10:51:03 +0106
Message-ID: <87cz9z9jz4.fsf@jogness.linutronix.de>
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

On 2022-11-07, Petr Mladek <pmladek@suse.com> wrote:
>> /*
>>  * Hold the console_lock to guarantee that no consoles are
>               ^^^^^^^^^^^^
>>  * unregistered until the kgdboc_earlycon setup is complete.
>
> My understanding is that this is synchronized by console_list_lock.
> Or do I miss something?

Yes, in the end the comment will say console_list_lock. At this point in
the series, the console_lock is still used. The comment is updated later
(as in patch 34 of the v2 series).

John
