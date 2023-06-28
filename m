Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D658D741828
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 20:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbjF1SoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 14:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjF1SoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 14:44:19 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17FF1FE7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 11:44:16 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f954d78bf8so9067265e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 11:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687977855; x=1690569855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rPXl0OE4qlqvKa8g41YgERuIrAW9CuTnSWDn3rM0g5Y=;
        b=Et6aiA5xEhKI1wcXui48Z21cytHNeo2ahz4Xgm70yfnimV2i4uR4o8aTBrNrsd3ZEp
         8l6xxmhc4OwoSwnY+LQOxwp97LU8WFnkN2nY5Z+TZEvBDME2+0Hv6EXv5PGFbkIvMzY3
         KxuctNwn/J2kDytTdtzuVFi/oQpEaVA0FXYtUaHMos3mJ02PHR8jEUK00UYJ9KVVMHY5
         CXroQlu70PoPoMH4JssDXAeSeqqW2UuCxjGjEljMewBNujrSb8ckgcCKqsDiEyC4xGpR
         ljg1oZAuwZUTAbj12oEeKYSpvZl1EtYLL+awsabGOWAhs5x49iC/Y8O0H8EQSZCf3Q/m
         gong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687977855; x=1690569855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rPXl0OE4qlqvKa8g41YgERuIrAW9CuTnSWDn3rM0g5Y=;
        b=WPyTrof+5UA4jOgXYflLTTewgqmk2hbzdQCg28LHUfaHohCMecRnHRvtwXz5rLR3wk
         udjuxGZOCXTkksHe0NJh1xGnS6yr99LYWhILOL0NawarbmpRI01EUlm5sWtOkv058dnN
         DFq0u488dy0w/ThD6zHViOlDEbV7Hvutqov6C80wq3q6y5U+2fW6Ay5IYXULAkrxXfXp
         0h+bP5VZ33pbP8MAYpMziA/pA6JK/aznRLXVC64iDv8anMyPnIpAFrRbvlWG+3Eg0qx8
         VPPXJLvLiUEUwVCSbvEb1wBvryU4tqsALddVQSAWFbpZAeft7vtnmrTTzPXju7AWLcfy
         JB+w==
X-Gm-Message-State: AC+VfDyVas4vsi6m3wtK6NtACodVS4DveDx1TAGXcTsuFw9KxO5A1cv9
        aMcVOBsOBPKc9Gx6tdIrcXT8FlBhma3zovCYldnU303aBC+WX6kydUF2hw==
X-Google-Smtp-Source: ACHHUZ7Ncxn/x+ClrpXtflOawhiQpBWL3izoHetkaYrw6v5DaG1WWEmGIqcRw2hlFrwb5ouM+Uhl0Rrgw+5ZreEUs+4=
X-Received: by 2002:ac2:5f86:0:b0:4fb:7de4:c837 with SMTP id
 r6-20020ac25f86000000b004fb7de4c837mr4705343lfe.68.1687977854660; Wed, 28 Jun
 2023 11:44:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230308073201.3102738-1-avagin@google.com> <20230327102715.GA7701@hirez.programming.kicks-ass.net>
 <CANaxB-wjNAuFGcNErnfz3gy1TG=W6XoJSb0hQM=TtB25YoGSqw@mail.gmail.com> <C7D9CFE1-0FEF-41F1-81CC-E3D5C4E61213@kernel.org>
In-Reply-To: <C7D9CFE1-0FEF-41F1-81CC-E3D5C4E61213@kernel.org>
From:   Andrei Vagin <avagin@google.com>
Date:   Wed, 28 Jun 2023 11:44:02 -0700
Message-ID: <CAEWA0a4gOpVejBEEsO=c5+wu_GwTGqO8cOAuKNAMdpqf0w_m1w@mail.gmail.com>
Subject: Re: [PATCH 0/6 v5 RESEND] seccomp: add the synchronous mode for seccomp_unotify
To:     Kees Cook <kees@kernel.org>
Cc:     Andrei Vagin <avagin@gmail.com>, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Chen Yu <yu.c.chen@intel.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Oskolkov <posk@google.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Will Drewry <wad@chromium.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 5, 2023 at 8:19=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On April 3, 2023 11:32:00 AM PDT, Andrei Vagin <avagin@gmail.com> wrote:
> >On Mon, Mar 27, 2023 at 3:27=E2=80=AFAM Peter Zijlstra <peterz@infradead=
.org> wrote:
> >>
> >> On Tue, Mar 07, 2023 at 11:31:55PM -0800, Andrei Vagin wrote:
> >>
> >> > Kees is ready to take this patch set, but wants to get Acks from the
> >> > sched folks.
> >> >
> >>
> >> > Andrei Vagin (4):
> >> >   seccomp: don't use semaphore and wait_queue together
> >> >   sched: add a few helpers to wake up tasks on the current cpu
> >> >   seccomp: add the synchronous mode for seccomp_unotify
> >> >   selftest/seccomp: add a new test for the sync mode of
> >> >     seccomp_user_notify
> >> >
> >> > Peter Oskolkov (1):
> >> >   sched: add WF_CURRENT_CPU and externise ttwu
> >>
> >> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> >
> >Kees,
> >
> >Could you look at this patch set? You wrote to one of the previous
> >versions that you are ready to take it if sched maintainers approve it.
> >Here is no major changes from that moment. The sched-related part has
> >been cleaned up according with Peter's comments, and I moved the perf
> >test to the perf tool.
>
> Hi!
>
> Yes, thanks for keeping this going! I'm catching up after some vacation, =
but this is on my TODO list. :)

Hi Kees. Do you have any updates on this series?

>
> -Kees
>
>
> --
> Kees Cook
