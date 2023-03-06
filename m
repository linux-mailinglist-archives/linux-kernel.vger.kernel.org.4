Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA38F6ACCA4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 19:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjCFSbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 13:31:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjCFSbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 13:31:31 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B72D39BB7
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 10:31:09 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-536b7ffdd34so200286017b3.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 10:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678127463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mOAkoKLlevveLNJpCs8p9NNIZTcCJBN7Cc5dg19sMq8=;
        b=bzjrQ42/S9HCCFLlIbne056K2dGArwOltBMGhh5o7Jn/YVWDSw1w4bjrN7FBS3lLO8
         u5ZHb6JnXn0JUCi7LP6ot8i9HtM02UHjDXmXTMTpFnxAO8KjhQ9kWyV0SK9WQ+EIX23E
         yr7UroArm9rPGY0TWvmQfE8/3q3C1X+9A0ve87T0d3zZXKguTh5IfNqRmYY4a2pSrJFC
         4K3EK1jPhiTdx/KLibpb8w8Icg5yCJZrJbq3WW6COVpRkG4h22ryTG4eyeAzXS2aJV+z
         ygJKBZC/T0+XmNgRZebADdAbVDvqF5INz9cWmBCfOjTUu2lk1OR1UXbHLPyL3YiYAo/u
         rRzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678127463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mOAkoKLlevveLNJpCs8p9NNIZTcCJBN7Cc5dg19sMq8=;
        b=zVu2XhC3n3zzwYAZlk2VP0A8gIkYw9Oo4nQz0WcaMhDLtsFKiATo1/Ekp2eAtCfweC
         kmFCF7vNjS6YFVKZ0kGpZO20Z5nsXwnFVXY8b/4SPTJR6YhaBzaBaJuzYpd5Pi5QvNKi
         U39tldXFJIhPJmKea+FWn4wLuMIiJsGyyRDp8jipQemZjLc0fmXWdOfcluvu0A+qdLl5
         HtIWywttnCtTz3/iFZLzYUdSHAc/VYMwQCngLz8ZzMAiA63dRepP5FgvX9QGVb9U8uI5
         PSIDnY3OcZoKnCjSnyOy6CEzpOivgSI60xPvhM+VikyQ4F/qRljwViL3uHSAOkmu5J5z
         fX5g==
X-Gm-Message-State: AO0yUKU4sF8SyY+E5KO1Bcdpsm1so9mBg1T1BYh7iKc2wvb14hBT2hJo
        SCwYoVOf8lprayffEDmvEl9bmrGclVZVjIqKwDQC
X-Google-Smtp-Source: AK7set/oW/Q5d1twxqYnAAbbxuvPPrlRep5V3Q9mn+0RBZjA87nzZ4QeBiC4a9W7N5/4pyhIdIOCEcgVbj4OOkqmak8=
X-Received: by 2002:a81:ac28:0:b0:536:55e5:2eaa with SMTP id
 k40-20020a81ac28000000b0053655e52eaamr7446501ywh.3.1678127463083; Mon, 06 Mar
 2023 10:31:03 -0800 (PST)
MIME-Version: 1.0
References: <20230302062741.483079-1-jstultz@google.com> <20230302082414.77613351@gandalf.local.home>
 <CANDhNCo4ruC4pP+iDe49b3e1nAcWtYQj4bx82+oZhyLFYkdFJQ@mail.gmail.com>
 <20230302152103.2618f1b7@gandalf.local.home> <20230302163253.541ac3a8@gandalf.local.home>
 <20230302163603.223313ba@gandalf.local.home> <20230302165613.2dcc18ca@gandalf.local.home>
 <20230302200136.381468f0@gandalf.local.home>
In-Reply-To: <20230302200136.381468f0@gandalf.local.home>
From:   John Stultz <jstultz@google.com>
Date:   Mon, 6 Mar 2023 10:30:51 -0800
Message-ID: <CANDhNCqiXVQoKYYegb6gFuYn0JXPqxLUghV8g5-59RuyvKCDNw@mail.gmail.com>
Subject: Re: [PATCH] pstore: Revert pmsg_lock back to a normal mutex
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Wei Wang <wvw@google.com>,
        Midas Chien <midaschieh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Tony Luck <tony.luck@intel.com>, kernel-team@android.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 2, 2023 at 5:01=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
> On Thu, 2 Mar 2023 16:56:13 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > Knowing that rcu_read_lock() keeps the tasks safe, I made the optimizat=
ion
> > to only grab the spinlock (and disable interrupts) once, or whenever th=
e
> > top waiter changes.
>
> v3 as I found that there were too places to test for top waiter that had =
to
> be removed:

Hey Steven,
  Unfortunately previous versions didn't improve the situation for the
reporter, and this version is causing crashes (BUG at
kernel/locking/rtmutex_common.h:118!) for them.

I'm going to spend some time today to get a local reproducer so I can
tinker a bit here as well.

thanks
-john
