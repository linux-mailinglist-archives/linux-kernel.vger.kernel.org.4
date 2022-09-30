Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0965F0CA5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 15:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbiI3NpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 09:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbiI3NpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 09:45:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF3E29815;
        Fri, 30 Sep 2022 06:44:59 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664545497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1OZgTaBWEcaQzJ86Oz30/kJlR6az74vxKOsEdbTFAX8=;
        b=A0hH8MBaojWkXd5MBGXcx223TV1FAeFKbsOV7KO33rF8lOh1R+g+timvuUZRci0tjKOY/6
        4WSp5XDEnq9s8dmyh+lD4UgBe99oiQSBnJlWTBSpQlP+hL5f3f56XQkhA5Gek+yaXvQMA4
        1ex1ZtEifGPYeytDCd4vKMK5at2db6tQwsJHHdlEQyR2gne4qMw8O6/LR6GVoi4FZVrdHr
        3MlN0xXdJ8Ws8yxf8Gy7X5I2Ka6Bh+EENVAln4K8v7CJxi1go+y5n3YRllExpunejo1OfM
        n9PfbjD5wmnFsp2oP6ZXz/CRyhz72AXZx31Vz+3jdKFEMg4vaOShZP2SI84mbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664545497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1OZgTaBWEcaQzJ86Oz30/kJlR6az74vxKOsEdbTFAX8=;
        b=ml64D/XgKJ0aKgPtgkwESGaanTx5W5HjeWZ6FbPWgTg4fCFqFLXodxONMIjY2+soQIrz7R
        yMn32SAGpGeSqyBw==
To:     Petr Mladek <pmladek@suse.com>,
        Doug Anderson <dianders@chromium.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Aaron Tomlin <atomlin@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org
Subject: Re: [PATCH printk 10/18] kgbd: Pretend that console list walk is safe
In-Reply-To: <YzarXlj1NyFGTC08@alley>
References: <20220924000454.3319186-1-john.ogness@linutronix.de>
 <20220924000454.3319186-11-john.ogness@linutronix.de>
 <CAD=FV=U3m_mVLpWna3pgi4=b7OCzUxmKh666g62zPNaB+6QHUA@mail.gmail.com>
 <YzarXlj1NyFGTC08@alley>
Date:   Fri, 30 Sep 2022 15:50:56 +0206
Message-ID: <87o7uxugbr.fsf@jogness.linutronix.de>
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

On 2022-09-30, Petr Mladek <pmladek@suse.com> wrote:
> Anyway, what about using the later added SRCU walk here?
> After all, this is exactly what RCU is for, isn't it?

So I think a lot of the problems with this series is that SRCU is
introduced too late. We are debating things in patch 6 that are
irrelevant by patch 12.

I will rework the series so that the changes come in the following
order:

1. provide an atomic console_is_enabled()

2. convert the list to SRCU

3. move all iterators from console_lock()/console_trylock() to SRCU

Step 3 may result in console_lock()/console_trylock() calls disappearing
or relocating to where they are needed for non-list-synchronization
purposes.

John
