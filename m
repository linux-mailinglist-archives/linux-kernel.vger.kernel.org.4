Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D52662D7A1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 11:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234312AbiKQKAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 05:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbiKQKAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 05:00:48 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E15525C;
        Thu, 17 Nov 2022 02:00:46 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668679244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=maOat5H9gR3gEndNJY08JL9PAhjiKE0EY6OpaWP1/04=;
        b=RGSf5GbhYCWO2dgXgAK/4MemOTdiWzdlP2kHg1EY3iV82/jd6MD8qutFDOfZyP9AVki+J/
        RJ3tnnq6qLSJqqLRr72tXKSu30sMmZ40MFaLZbHPv5iVTEioxdnQWXBGw2O5N8hagYae8C
        eCB4colyFEdiZ5ue+ppMaKiDDXUTmIYbgrfRYPfZIInqUaDu9aBDcjuxngxWMw2cLoyVmy
        YQbMsvPmhg8jJHFTlEbypw0KgTemn+F6bHK3dPe+RmIxFbhPe/VOto2MlBZj9l2nBJZypQ
        8POBvrR40jv9J1kVauY3ttDgvETw6SrqQHB+svEGkXwXN5pZ5ACVmn4odhHzLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668679244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=maOat5H9gR3gEndNJY08JL9PAhjiKE0EY6OpaWP1/04=;
        b=OlNG+d1h/dgED4we7sPNyAacUdRGHP68b+yrWn7eSaSHsibUbUaAIusgf57rSNw5GtbQqm
        6kHebCFDUDCB26Bw==
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
Subject: Re: [PATCH printk v5 37/40] tty: serial: kgdboc: synchronize
 tty_find_polling_driver() and register_console()
In-Reply-To: <CAD=FV=WWZAAhw7rWjCvtqz6VGh-PzG_zMnugX_KkG7gZ+a9Qpw@mail.gmail.com>
References: <20221116162152.193147-1-john.ogness@linutronix.de>
 <20221116162152.193147-38-john.ogness@linutronix.de>
 <CAD=FV=WWZAAhw7rWjCvtqz6VGh-PzG_zMnugX_KkG7gZ+a9Qpw@mail.gmail.com>
Date:   Thu, 17 Nov 2022 11:06:40 +0106
Message-ID: <87pmdloq7r.fsf@jogness.linutronix.de>
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

On 2022-11-16, Doug Anderson <dianders@chromium.org> wrote:
> Seems OK to me, though I guess I would have moved console_lock() up
> too just because this isn't a case we need to optimize and then we can
> be extra certain that nobody else is messing with console structures
> while we're looking at them.

Actually this series is not about optimization. It is about reducing the
scope of console_lock and removing unnecessary use of it.

If tty_find_polling_driver() needs to be called under the console_lock,
then we need to document exactly why. I could not find any situations
where it is necessary.

Also keep in mind that in the long term we will be completely removing
the console_lock. It is a painful process of identifying and dismantling
its scope and replacing it with multiple clearly scoped locking
mechanisms.

> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Thanks.

John
