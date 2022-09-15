Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721705B9EFF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 17:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbiIOPhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 11:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiIOPhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 11:37:41 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402B658DF3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 08:37:40 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id s11so9865546ilt.7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 08:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=nehrnl7qCn0NK1nnlqs2BA+lH9sUdKNC1UmAyMjCmTk=;
        b=ZjjMAZuXjIpb1p1SnH0Ll3ar6Yst5szVonCq2WmtJ4N5zcT8MCL/tEwl953Y9dW29K
         4ipmgSqieDeE5qOqA9sfeDurFiHRZLI3QrX024rsMg6MefMnvd8xThKchMVF9FMGCklO
         ZDOd0NkCQoKUlW8OJARQCP7jZwGV92FVkHV+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=nehrnl7qCn0NK1nnlqs2BA+lH9sUdKNC1UmAyMjCmTk=;
        b=t1si7qBA7NPPyjpoMg0R6F+cibS6vcoIHmntaVsw5vyGt6SLapsInR1N6zS3ZgxmfN
         z2kkW61jlAIbVoAe+g+Tf0RVhc063++WvNP93X2ZtOY093TrNQNQPgFxva98RMNMooNa
         cOw1Kttp7JPgTwDnF6AZix1b6H1kA2KKmH2ykAbwy/hLDAD2zWCwXDSxPqSqXZnVCPo3
         d/nBSXwyVCJ0bLBLpnmvrOGaq3XqWOmPEry6vqC0zxSZl2EiYj1LRmoDI+2QagpQj+Tf
         TFnW/rizT0iqx/gFDVy9nuEFChWZbJd5Fsi0wRpHxik6m9QazEP8t6X/R6l+jdLfYyfu
         dVSw==
X-Gm-Message-State: ACrzQf3UCULHr9dntln52PrbtCRbwYkX6zr+Vhn/Cad5OBYzTUxcV0F/
        gbvGr+abiRMp2TL3w6XYlmblftrqOOwF4xWtnb/Ufw==
X-Google-Smtp-Source: AMsMyM58fH29YsW9Ko1gSJWkqfqDB+LV/Q54/iTGg2aCjNLSCncmcTZUp5JUkANI0IS5LqMpfTo65SwBIyhdV3ArTBk=
X-Received: by 2002:a05:6e02:198f:b0:2ef:7132:6ace with SMTP id
 g15-20020a056e02198f00b002ef71326acemr284576ilf.148.1663256259610; Thu, 15
 Sep 2022 08:37:39 -0700 (PDT)
MIME-Version: 1.0
References: <YyLksEr05QTNo05Q@hirez.programming.kicks-ass.net>
In-Reply-To: <YyLksEr05QTNo05Q@hirez.programming.kicks-ass.net>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 15 Sep 2022 11:37:30 -0400
Message-ID: <CAEXW_YS9d-VsZsavPTRbDw1ZGWs2PmZwUAj3DiPYFKy-SQC2hw@mail.gmail.com>
Subject: Re: RCU vs NOHZ
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Paul McKenney <paulmck@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2022 at 9:39 AM Peter Zijlstra <peterz@infradead.org> wrote=
:
>
> Hi,
>
> After watching Joel's talk about RCU and idle ticks I was wondering
> about why RCU doesn't have NOHZ hooks -- that is regular NOHZ, not the
> NOHZ_FULL stuff.


Glad the talk stirred up a discussion!

> These deep idle states are only feasible during NOHZ idle, and the NOHZ
> path is already relatively expensive (which is offset by then mostly
> staying idle for a long while).
>
> Specifically my thinking was that when a CPU goes NOHZ it can splice
> it's callback list onto a global list (cmpxchg), and then the
> jiffy-updater CPU can look at and consume this global list (xchg).
>
> Before you say... but globals suck (they do), NOHZ already has a fair
> amount of global state, and as said before, it's offset by the CPU then
> staying idle for a fair while. If there is heavy contention on the NOHZ
> data, the idle governor is doing a bad job by selecting deep idle states
> whilst we're not actually idle for long.
>
> The above would remove the reason for RCU to inhibit NOHZ.
>
>
> Additionally; when the very last CPU goes idle (I think we know this
> somewhere, but I can't reaily remember where) we can insta-advance the
> QS machinery and run the callbacks before going (NOHZ) idle.
>
>
> Is there a reason this couldn't work? To me this seems like a much
> simpler solution than the whole rcu-cb thing.

You mean the =E2=80=9Cwhole rcu-nocb=E2=80=9D thing? The nocb feature does =
not just
eliminate the need to keep idle ticks ON, that=E2=80=99s just one of the
reasons to use nocb. The other reasons is nocb makes the cb invoke in
a thread and not softirq of the queuing cpu, this makes the energy
aware scheduler decide where to place those threads and it seems to do
a really good job of saving power (Vlad Rezki who works on android
checked and I CC=E2=80=99d).

Maybe your suggestion is more about how to keep the idle tick off on
systems without using no-cb (note that nocb has additional overhead
due to thread wake ups and locking)?  If we do the global thing you
mentioned, then that means we won=E2=80=99t get the per cpu cache locality
benefits on those systems that want the cb to execute on same cpu (cb
operating on a hot cache line) since your cb gets invoked on the
jiffie updating cpu per your design.

Outside of RCU, I do remember back in my android days that even with
nocb, we can see idle ticks present quite a bit (this is likely
because of the idle governor in android, but I did not dig much
deeper). I need to go and investigate that again..

Thanks,

- Joel
