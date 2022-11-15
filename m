Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5C9629222
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 08:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbiKOHIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 02:08:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbiKOHIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 02:08:49 -0500
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA05124
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 23:08:48 -0800 (PST)
Received: by mail-vk1-xa35.google.com with SMTP id g4so6136920vkk.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 23:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=noh/j1I2Nfqmg70jSTXPnVlIuOy6GPQXk/DeN87GQSc=;
        b=lAr927BTluZcNXMKOC0MimOAVuXGSqAeMbyqx8/z/YUM5s6un9kPKNbevgVOeVyNzp
         y4K89hIVCru8LGLs2H/RB59XSLlvuSt1x8KcxBDLtvK6lRSJGk5U8m298v3sfYp411uy
         MDGUrmmpS3gawg4x28r+zm27HHHxSIybpR9rAWsbfSTEM3eV5qvjGL8MO9wYtfnvC8Hb
         vk505YIa4DrODRClGQy6iK7K0z7MkvRJHzZsoovvzSpopQpy4b/rzHd6U/OhVp32A49P
         zIQe/O5Od2sOYr5qSgwwaAici055IvE8Gwy5sbCiUuot03OE2NNuRTFYa9NJvLN+o5ux
         1BiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=noh/j1I2Nfqmg70jSTXPnVlIuOy6GPQXk/DeN87GQSc=;
        b=3v1t3lnlFkt1DrQcP7745lSa22/a77mIrgH0UdwcoiueHHWyNTScBFciEy+/WfI+T/
         ZboaLLUV+M1/wTb1GVKNDTfqatJX3CSq3tYfLTFV5Pmskn0/rmLqcw4T+NsgY4ouwVqK
         eV1GVmXumycWzl33Uc77dG6yIVHk6DipoOqfPLAmALXlBsibFkDLwsQaofZsw+mBEm9L
         7eD5m8ZIq68OtP8J/5wLymh9Pnw+8K/bVL7Fr4jpupBjRCLs52aGkZ0pwtUoxp0QEmOi
         L7U9mPZAVAZneyrUU8DAZFXDL+TGIt7IUv38o+Cv+5t/cDyKzo+jG0qx+cXaomxDKSXQ
         /b6w==
X-Gm-Message-State: ANoB5pllgKwhyqBfojk0lx+pS2xKNwm2w4309V0jdnIcyKnOHRtlSErd
        tFPM9SdzhERhCgyo9s5yOiMWBdFb9sMLyEfqbpmAyO85C94X
X-Google-Smtp-Source: AA0mqf6oqbxUdHrks669LJv6lUsL530VCRZ3XXoV4DB9AH6Eq97LjdMQraK4EswSSUrlvDWNmKKtjIxGXMBgFi3rVZA=
X-Received: by 2002:a05:6122:2007:b0:3b8:3b0b:222f with SMTP id
 l7-20020a056122200700b003b83b0b222fmr8510224vkd.36.1668496127733; Mon, 14 Nov
 2022 23:08:47 -0800 (PST)
MIME-Version: 1.0
References: <20221003232033.3404802-1-jstultz@google.com> <20221003232033.3404802-3-jstultz@google.com>
 <Y01NPB4sa8Z98ntK@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
 <CANDhNCoTGNANDnOQ6touhreG_UEn1-N4T4BktWFxpLPSWVfrdA@mail.gmail.com>
 <Y0+/SAWUNRnhIW9b@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
 <CANDhNCpQuQn_84yqErF2noAYDwdwNJQF-pr4JKVp1eZzH=+f9w@mail.gmail.com>
 <Y1FDegctcU2LrYGT@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
 <Y1Q3vYjlFt/Imu5w@google.com> <Y1TxCTq5gxh4fIEd@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
In-Reply-To: <Y1TxCTq5gxh4fIEd@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
From:   John Stultz <jstultz@google.com>
Date:   Mon, 14 Nov 2022 23:08:36 -0800
Message-ID: <CANDhNCreB=Bm-X7WFp-oUtfR9uNRD=Vx8TehJ59HvF4Ke48ehQ@mail.gmail.com>
Subject: Re: [PATCH RFC v4 2/3] sched: Avoid placing RT threads on cores
 handling long softirqs
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Connor O'Brien" <connoro@google.com>,
        John Dias <joaodias@google.com>, Rick Yiu <rickyiu@google.com>,
        John Kacur <jkacur@redhat.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
        "J . Avila" <elavila@google.com>
Content-Type: text/plain; charset="UTF-8"
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

On Sun, Oct 23, 2022 at 12:45 AM Alexander Gordeev
<agordeev@linux.ibm.com> wrote:
>
> On Sat, Oct 22, 2022 at 06:34:37PM +0000, Joel Fernandes wrote:
> > > In my reading of your approach if you find a way to additionally
> > > indicate long softirqs being handled by the remote ksoftirqd, it
> > > would cover all obvious/not-corner cases.
> >
> > How will that help? The long softirq executing inside ksoftirqd will disable
> > preemption and prevent any RT task from executing.
>
> Right. So the check to deem a remote CPU unfit would (logically) look like this:
>
> (active | pending | ksoftirqd) & LONG_SOFTIRQ_MASK
>

Alexander,
  Apologies for the late response here, some other work took priority for a bit.

Thanks again for the feedback. But I wanted to follow up on your
suggestion here, as I'm not quite sure I see why we need the separate
ksoftirqd bitmask here?

As run_ksoftirqd() basically looks at the pending set and calls
__do_softirq() which then moves the bits from the pending mask  to
active mask while they are being run.

So (pending|active)&LONG_SOFTIRQ_MASK seems like it should be a
sufficient check regardless of if the remote cpu is in softirq or
ksoftirqd, no?

thanks
-john
