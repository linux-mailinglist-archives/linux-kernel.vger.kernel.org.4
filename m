Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D289C6D507F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 20:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbjDCSc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 14:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233221AbjDCScS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 14:32:18 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246EB2708
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 11:32:15 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id i5-20020a05600c354500b003edd24054e0so20431001wmq.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 11:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680546733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5hJVfr+pZOKQdYeUl80fYK2BWog9NCo5b9KkrKzvXk8=;
        b=ftT/NfmLMMiFIKqIM5RW3DUMBs5F/0RFUoOadrehIXjhvcGHec773vV4KommFextkK
         UV3hg8p/96rWUBLYeL8UWIlzQ0aOCD5qkRlvkw+zJVuB6+J0pl/yMDahuQN1AUaMt8Mq
         JsZu/zwEfqsJYCV//C5/9n+SfdX0Z94is7w5tuFc9KSswkrtIX9LT9neEBwC3SmM1uWM
         UTXk97PREAVJTR3u1th1OZT6Muzgvkilct02sRBN5mr6ubab3iIMocTjBZvnFnuvwPNC
         OLMo1+NqrPgd9mksdUKy0mMcAf9ZMmps1Ff8uDsmDrGwoglUFPFTaAby90ZrB1p+YZmP
         g5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680546733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5hJVfr+pZOKQdYeUl80fYK2BWog9NCo5b9KkrKzvXk8=;
        b=m9De/VGSnmJAIHWx9lfcoGwX1oMM8oJFjkrmtw3clZnaIAnMxPTGwunYSEghWuoUtt
         XWmDKfVAuL5Nn67NNUEvpdx6W15y0thgVAplJxIfbm2p9vYDH3k/sWxuRRTvDnfzvo+y
         /yPOgQ7evEAxqTTT4gwmQw0RL8gW9zhGYq1DVO54+IsBTVV9TR1WJXho2foDVUw+xRDo
         xtueRCyCxAm1tcaI49P4Eme2IwpbZCwEmgr2t9cYLSQ1sG+37Q66oY3S2H5T/ZimvLi6
         yOiYICzR9ZxZ4SdlaQ2HXEe2edRmTbxslGDEczGttQk7IkZCzKLG9NsE1L79EFAV8wdM
         QoFw==
X-Gm-Message-State: AAQBX9cOhajkJlDIMsAt97ZjwjApmAH4rWNenFBxhp92W7Zv+G0RNpiB
        qAQ2uEUFTE/ZshTRc5Yy/fb1whD6R/2CitNnJhs=
X-Google-Smtp-Source: AKy350b+LXMOSb/4oHFXU+JptGpX+Wb3l17T0i9SkSEaq729hfGAbA+J+Y3qoHC2Nd8uIIalI6rtWW0Wzalm58A6OPM=
X-Received: by 2002:a05:600c:2259:b0:3ed:b4e8:630f with SMTP id
 a25-20020a05600c225900b003edb4e8630fmr319129wmm.10.1680546733405; Mon, 03 Apr
 2023 11:32:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230308073201.3102738-1-avagin@google.com> <20230327102715.GA7701@hirez.programming.kicks-ass.net>
In-Reply-To: <20230327102715.GA7701@hirez.programming.kicks-ass.net>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Mon, 3 Apr 2023 11:32:00 -0700
Message-ID: <CANaxB-wjNAuFGcNErnfz3gy1TG=W6XoJSb0hQM=TtB25YoGSqw@mail.gmail.com>
Subject: Re: [PATCH 0/6 v5 RESEND] seccomp: add the synchronous mode for seccomp_unotify
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrei Vagin <avagin@google.com>, linux-kernel@vger.kernel.org,
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
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 3:27=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Tue, Mar 07, 2023 at 11:31:55PM -0800, Andrei Vagin wrote:
>
> > Kees is ready to take this patch set, but wants to get Acks from the
> > sched folks.
> >
>
> > Andrei Vagin (4):
> >   seccomp: don't use semaphore and wait_queue together
> >   sched: add a few helpers to wake up tasks on the current cpu
> >   seccomp: add the synchronous mode for seccomp_unotify
> >   selftest/seccomp: add a new test for the sync mode of
> >     seccomp_user_notify
> >
> > Peter Oskolkov (1):
> >   sched: add WF_CURRENT_CPU and externise ttwu
>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Kees,

Could you look at this patch set? You wrote to one of the previous
versions that you are ready to take it if sched maintainers approve it.
Here is no major changes from that moment. The sched-related part has
been cleaned up according with Peter's comments, and I moved the perf
test to the perf tool.

Thanks,
Andrei
