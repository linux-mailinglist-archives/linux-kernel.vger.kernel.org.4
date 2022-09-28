Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D249F5EEA43
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 01:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbiI1Xmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 19:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233803AbiI1Xmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 19:42:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA94E91D1E
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 16:42:31 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664408549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WTOgTFN3mrB5eF0ajXBTEQkEAN2ef2EKya8g7yeWxwI=;
        b=S+5iEcmaNjMWAyM6QO3oelSgAraE7XZnuRaI5jqVrT3xxRKa/PTbPNkXEMh9NhWniKRf4T
        S00/DKhwP2V/QfynC4ABbNCS1GtACBSKZ4dDc9Blk0mZWTr7Md8LaHtC0RUGkkhYYEvT7a
        ksta9NYy9kh9/z1JHkpCWjOLzFBtCAhIuDnPiZCtSOS8rx5NFGBVSZ4bq9xI8KHvKy+WpZ
        RDWY5FSmmNMtBG/24C6pcCR3HtSwZ04p04B8SXQLmhKnauwGjKddcUmEBkJU+kvATvrVXh
        hAqTAPDSecxFEffxqxB4zCXJ22u6ljOsRbJCdxwoz+HXj36fWjVt9diZXQMK1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664408549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WTOgTFN3mrB5eF0ajXBTEQkEAN2ef2EKya8g7yeWxwI=;
        b=jHD6encmVSt90l0i5Q3WdUnthRPC5LjIyJ7PfpZvdGIS6KMdsPjHanl2DJLsg5N8XMxT0C
        QweR/5Vw/hs9SEDg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk 06/18] printk: Protect [un]register_console()
 with a mutex
In-Reply-To: <YzMT27FVllY3u05k@alley>
References: <20220924000454.3319186-1-john.ogness@linutronix.de>
 <20220924000454.3319186-7-john.ogness@linutronix.de>
 <YzMT27FVllY3u05k@alley>
Date:   Thu, 29 Sep 2022 01:48:29 +0206
Message-ID: <87mtajkqvu.fsf@jogness.linutronix.de>
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

On 2022-09-27, Petr Mladek <pmladek@suse.com> wrote:
> Hmm, the new mutex is really nasty. It has very strange semantic.
> It makes the locking even more complicated.

We are working to replace the BKL-console_lock with new separate clearly
defined mechanisms.

The new mutex provides full synchronization for list changes as well as
changes to items of that list. (Really console->flags is the only change
to items of the list.)

For some places in the code it is very clear that the console_lock can
be completely replaced (either with srcu or the new mutex). For other
places, it is not yet clear why the console_lock is being used and so
both console_lock and mutex are used.

> The ideal solution would be take console_lock() here.

We should be looking where we can remove console_lock, not identifying
new locations to add it.

> A good enough solution might be call this under the later added
> srcu_read_lock(&console_srcu) and use for_each_console_srcu().

@console_srcu does not allow safe reading of console->flags. It only
provides safe list iteration and reading of immutable fields. The new
mutex must be used for reading console->flags.

Note that for the NOBKL consoles (not part of this series), a new atomic
state variable is used so that console->flags is not needed. That means
for NOBKL consoles the new mutex is further reduced in scope to provide
only list synchronization.

> Or is this part of some strategy to remove console_sem later, please?

Yes! One of the main points of this final phase of the rework is to
remove console_sem usage (for NOBKL consoles). If a system is running
with only NOBKL consoles registered, ideally that system should never
call console_lock()/console_trylock(). Once all drivers have converted
over to the NOBKL interface, console_sem will serve no purpose for the
printk and console frameworks, so it can be removed.

John
