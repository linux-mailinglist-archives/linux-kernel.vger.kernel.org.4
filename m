Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59BBC6C2854
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 03:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjCUCvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 22:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjCUCvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 22:51:16 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5F92943C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 19:51:14 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5445009c26bso257845867b3.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 19:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679367074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOHsBhkyJyIeL/LfM4zy19LMgi9G92SBazBIUXEA+oc=;
        b=nyBKsbo1wsKGomR1FWl5yJiwiqnO4wz/gEAzufuxohXz9NzRuR5q4ci61fwSRLgOsZ
         DALyjUszIYSEmcjHHrX7bkjkEfrRG20BqodWhftjtQ6OGWTI1wNG4Zk+A0VDICz7Sd33
         kfY0dNqYEQUxFHnPXhZvUc7iJBo9+ZXjN8U1hUCfuR/3ZB6bwLpv3bXdUN28NCbPlkJv
         vlXCD7ILFijoZxmMy+uMBHA5Q+CVOLA4mYIRkHJXFJYWy/gSiy6np1rwAmTW1JUISDvZ
         WeSlmE4mSxpqsZRNohHWSE1rmQsu94Zt0iShmOUxSj3plN35iMtZsRLHMODWeOUi0Z4e
         LnlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679367074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZOHsBhkyJyIeL/LfM4zy19LMgi9G92SBazBIUXEA+oc=;
        b=4fZQNTRe8/0oH2ebRnvk4NjeZ/zA2vDtehhtRmN2IOmG05qLVvOLnuLuDuF69i1w0q
         dm0tNnCVhs3m4EXGa5OQDXiuvXay1tEogSA1yFIMt30TxbbRTsxxkz0nbW8cug9wrelo
         +kMDmycRnegzlCHCZvkN0xLidfCSvXfJN9g/DNZpuV07sRORSKGzbJEgkHujxPmVfqvm
         lHbZ/TvcboVR6ywlevA6g4Fez0jsBd+z5o6yJ7yctBSpqFG9NJrrJdU8RXwd9/hgatr+
         4IZymNGN8XzvsR77G18DdudtpNGJFsG1tUE2sjCdvUXAbIDwBlpHTSwbWqfnxPeMRJYV
         /TGg==
X-Gm-Message-State: AAQBX9fWAdv/Ve07vqkALntuZvMcCZcMOb3lKjnrwgfRJCGC4urPqje5
        ziTo4VoliUMLzowJWhlgti4E/rMlUVSuVAnNpghtKFooiOo/IaNtu/LpyRk=
X-Google-Smtp-Source: AKy350alWfOGMI0o+I1+LvOmIA8ZYVS4C2iO9a3U+TdaC/tMb/elLg/8Z5rZe5glHzQb5heYAIjlalT4rcxRhN7ZE7k=
X-Received: by 2002:a81:4524:0:b0:541:8a9a:5445 with SMTP id
 s36-20020a814524000000b005418a9a5445mr195678ywa.5.1679367073898; Mon, 20 Mar
 2023 19:51:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230320233720.3488453-1-jstultz@google.com>
In-Reply-To: <20230320233720.3488453-1-jstultz@google.com>
From:   John Stultz <jstultz@google.com>
Date:   Mon, 20 Mar 2023 19:51:03 -0700
Message-ID: <CANDhNCq90WkGkA1Q-u8tWirik7i52zGN1ks_4-A_A5MpU+Gkpg@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] Reviving the Proxy Execution Series v2
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qyousef@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, kernel-team@android.com
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

On Mon, Mar 20, 2023 at 4:37=E2=80=AFPM John Stultz <jstultz@google.com> wr=
ote:
> Changes since Connor=E2=80=99s last submission:
> ---------------------------------------
> * I dropped the patch changing mutex::wait_lock to always save/restore ir=
q
>   flags (as Joel raised a concern that the patch wasn=E2=80=99t actually
>   necessary).

Well, despite a bit of testing prior, it is of course immediately
after sending it I managed to trip lockdep to get a warning on this
(though it tripped on the blocked_lock not the wait_lock), so I'll be
re-adding that patch (or a variant) back in in the next series.

[    1.351993]        CPU0                    CPU1
[    1.351993]        ----                    ----
[    1.351993]   lock(&p->blocked_lock);
[    1.351993]                                local_irq_disable();
[    1.351993]                                lock(&rq->__lock);
[    1.351993]                                lock(&p->blocked_lock);
[    1.351993]   <Interrupt>
[    1.351993]     lock(&rq->__lock);

thanks
-john
