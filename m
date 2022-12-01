Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F91863F0BC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 13:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiLAMmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 07:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiLAMmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 07:42:03 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1C97B620
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 04:41:59 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669898517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EcUf0DGBfy7IMc8yMKGRfn8SaHMFa/0nE+FUd+/NaJI=;
        b=pcImPuX7ehGh06LEgmyl+yQVxS380weLWhYOlHG41VJK8qgPpk8IR6M7v1akHpcg5PyGF8
        L/1pL0J/rW3xhMJoYkXpk40kQh5auAp6CxngIlwDfx67CnrzRLKkesDh4VwUR0BuUSQb/G
        eMG/arSH9EvYmAgAbBG0UsXJhirQ6+k6DryWriqRfbSA7aXVeKE8ZPPHJQQSWrs7QsqAWg
        PRVVgbmrZSo5xApeAjbEGywuhSO/iSQxEaRkiqTVpVo8foNRl7TuVwpcW2wJ1yr4DZeFjQ
        jvyHdxoYEnx1BHCXsJe3T1WjMK660/cJW3dsL4aTKvECHDnHwuDIDtGMGHrLZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669898517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EcUf0DGBfy7IMc8yMKGRfn8SaHMFa/0nE+FUd+/NaJI=;
        b=jK4/+UibXprDEGKSyy0LZioDxzf18qtzqC/ZI9PZpwzZotmOlg5Mt+6vByT0hYF1df6SLi
        OtyC0gKmlAdS3KDQ==
To:     Arnd Bergmann <arnd@arndb.de>, John Stultz <jstultz@google.com>,
        Jacob Macneal <jake.macneal@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] time: copy tai value (International Atomic Time, in
 seconds) to output __user struct in get_old_timex32().
In-Reply-To: <7d95f4bb-01a3-44db-af08-275daa9ffb1e@app.fastmail.com>
References: <20221121055345.111567-1-jake.macneal@gmail.com>
 <CANDhNCqCYkv7Ja4RT2_DEPh2zFFL+SD82wru_FC6dupCo6_4RA@mail.gmail.com>
 <7d95f4bb-01a3-44db-af08-275daa9ffb1e@app.fastmail.com>
Date:   Thu, 01 Dec 2022 13:41:56 +0100
Message-ID: <87a647s3cb.ffs@tglx>
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

On Wed, Nov 23 2022 at 20:53, Arnd Bergmann wrote:
> On Wed, Nov 23, 2022, at 19:54, John Stultz wrote:
>>> --- a/kernel/time/time.c
>>> +++ b/kernel/time/time.c
>>> @@ -311,6 +311,7 @@ int get_old_timex32(struct __kernel_timex *txc, const struct old_timex32 __user
>>>         txc->calcnt = tx32.calcnt;
>>>         txc->errcnt = tx32.errcnt;
>>>         txc->stbcnt = tx32.stbcnt;
>>> +       txc->tai = tx32.tai;
>>>
>>
>> This does seem like something that was overlooked.
>>
>> Arnd: There isn't something more subtle I'm missing here, right?
>
> I agree. Looking at the git history, it seems that the tai field
> was added a long time ago in 153b5d054ac2 ("ntp: support for TAI").
> The commit correctly did the conversion for copying the data out
> of the kernel and did not copy the value in because it wasn't
> needed at the time.
>
> I don't see any user of the tai field that gets copied into
> the kernel, so the bug appears harmless, but Jacob's fix is
> nevertheless correct, as we should not use any uninitialized
> data in a structure that comes from userspace.

There is no uninitialized data. txc is zeroed at the beginning of that
function.

I agree that it's inconsistent vs. the regular adjtimex(), but as there
is no usage of the txc->tai value coming from user space it's pretty
much cosmetic.

Thanks,

        tglx


