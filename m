Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD0F697DE3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 14:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjBONwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 08:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjBONwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 08:52:15 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBD6301B1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 05:52:14 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676469132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qxBlouBZ383xLuWMSYZoEGNKvUrxTyL2mIde+iA7Tw0=;
        b=ND3AzjUGuOFo8helN1g+NpBQvzXtKEojZg6H2IHaT9AiorXmLnkq4svTICqK1y2d/SeX37
        aRwjH3wmEwnZkdETIMO4YpQ+eXTY7oiE+d5FJtGff1PKcMhMHF0xLpwPw+n/pwke0+oXQt
        sGOl99BF26pWNn+gVRZv822eHxneVKtQCZsNu0JB65VeKtxxNrfspfzVxs9z9qrg4OVqgE
        DzPQhixDtFLucUtkzlVO50CNHmS3tLqpXn/VW6Ee6WYDJ04WFpdGCuBE22xJG7Wyvil3pL
        kotlnmKtU9cWKtuNELZbnI1GCHw8ONo++R/1E70RX5Mef9BkMtWB5bpkw7VTgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676469132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qxBlouBZ383xLuWMSYZoEGNKvUrxTyL2mIde+iA7Tw0=;
        b=X4zGHIpF2Ypny9Jc+orIMfM9YsSA86g/VV5xuwDsmXiad5aT2pPShxjSJ9/pbx0FkAjXrZ
        SV7ttZdnjNEjmZAQ==
To:     Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
        John Stultz <jstultz@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Michael <michael@mipisi.de>, kernel-team@android.com
Subject: Re: [RFC][PATCH 2/2] time: alarmtimer: Use TASK_FREEZABLE to
 cleanup freezer handling
In-Reply-To: <CAOf5uwn4NPsXp91aUAwa0RFP9jFRyaNDzOQr6FzUHTC26Y6+bg@mail.gmail.com>
References: <20230211064527.3481754-1-jstultz@google.com>
 <20230211064527.3481754-2-jstultz@google.com>
 <CAOf5uwn4NPsXp91aUAwa0RFP9jFRyaNDzOQr6FzUHTC26Y6+bg@mail.gmail.com>
Date:   Wed, 15 Feb 2023 14:52:12 +0100
Message-ID: <87sff7qbn7.ffs@tglx>
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

On Wed, Feb 15 2023 at 09:22, Michael Nazzareno Trimarchi wrote:
> On Sat, Feb 11, 2023 at 7:45 AM John Stultz <jstultz@google.com> wrote:
>>  /**
>>   * clock2alarm - helper that converts from clockid to alarmtypes
>>   * @clockid: clockid.
>> @@ -750,7 +703,7 @@ static int alarmtimer_do_nsleep(struct alarm *alarm, ktime_t absexp,
>>         struct restart_block *restart;
>>         alarm->data = (void *)current;
>>         do {
>> -               set_current_state(TASK_INTERRUPTIBLE);
>> +               set_current_state(TASK_INTERRUPTIBLE | TASK_FREEZABLE);
>
> For kernel 5.10.x and lts is possible to use freezable_schedule and
> let this set_current_state as was before.
> I have seen patch that introduce the new state but I suppose that in
> order to be compatible to stable this should be the
> change. Am I right?

We always work against upstream first and there freezable_schedule() is
gone. Backports have to be sorted seperately.

Thanks,

        tglx
