Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5B167D5C8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 20:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbjAZT5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 14:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjAZT5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 14:57:09 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B666B9A2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 11:57:08 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674763026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xoCYNeTYXghqJNCexdyTIWXssu9di5YdD5Pp45rmI6M=;
        b=XfZ2u+E4RVYrfJduRB/7lyTj+smZ5NtTvaSW4uHCP7HsTMyq2hsS+tTe6H/uuwlcaA2JaM
        c51YGzKiqxlOoUIxsC+4vW9gMHRbmvawlNjKVPxBxLCL8vbXEjryUAolQAkCFrGuuEGCOQ
        HqPNJaCd1tKug+eINxKFe+y3keT3KfCxAJYRAvEYFK+YCsN9v1tiGgg5jciHm+ux4wsr+f
        vt2uINVsdC8OZe+Wp4kvhD1VZtVVp7+jCbxOJ935A+t8WrOWbf2AtaYEx6/Y2GQcpLV/ca
        WeAvOfSM8rj5bhA/GAvqc05Gw3/IFJRmX0fEnWPi+4aA+v4fkJNmUj6vft0Trg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674763026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xoCYNeTYXghqJNCexdyTIWXssu9di5YdD5Pp45rmI6M=;
        b=714jIiFnFi31IhidWiKrBeK49Cnq5XLBMbsiLkF1UsEDIiBh0p88ERAycKCaTU/TH8SE8H
        vCCS+bCtBbskUdAg==
To:     Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>
Cc:     oleg@redhat.com, linux-kernel@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v4] posix-timers: Prefer delivery of signals to the
 current thread
In-Reply-To: <CANpmjNM=PVigDZKu-H_-cLECUJKSx7TH+kxSjfF=4UHdrGBj+g@mail.gmail.com>
References: <20230126105128.2249938-1-dvyukov@google.com>
 <20230126154118.2393850-1-dvyukov@google.com>
 <CANpmjNM=PVigDZKu-H_-cLECUJKSx7TH+kxSjfF=4UHdrGBj+g@mail.gmail.com>
Date:   Thu, 26 Jan 2023 20:57:05 +0100
Message-ID: <87o7qlgjce.ffs@tglx>
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

On Thu, Jan 26 2023 at 18:51, Marco Elver wrote:
> On Thu, 26 Jan 2023 at 16:41, Dmitry Vyukov <dvyukov@google.com> wrote:
>>
>> Prefer to deliver signals to the current thread if SIGEV_THREAD_ID
>> is not set. We used to prefer the main thread, but delivering
>> to the current thread is both faster, and allows to sample actual thread
>> activity for CLOCK_PROCESS_CPUTIME_ID timers, and does not change
>> the semantics (since we queue into shared_pending, all thread may
>> receive the signal in both cases).
>
> Reviewed-by: Marco Elver <elver@google.com>
>
> Nice - and and given the test, hopefully this behaviour won't regress in future.

The test does not tell much. It just waits until each thread got a
signal once, which can take quite a while. It does not tell about the
distribution of the signals, which can be completely randomly skewed
towards a few threads.

Also for real world use cases where you have multiple threads with
different periods and runtime per period I have a hard time to
understand how that signal measures anything useful.

The most time consuming thread might actually trigger rarely while other
short threads end up being the ones which cause the timer to fire.

What's the usefulness of this information?

Thanks,

        tglx
