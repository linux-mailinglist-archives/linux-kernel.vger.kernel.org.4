Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC2762C840
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 19:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239047AbiKPSxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 13:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239387AbiKPSwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 13:52:31 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B9265877
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 10:50:17 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id b3so31006851lfv.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 10:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iQh/dm/l5pZ34/VZO2TmQSqjFgee06I/tw8Wk6CAbGE=;
        b=VMQ2GiJPZTloLJ15Oad3ZmSx/jY0iKbZmunImFEiSgchUzsWVfOKANFOFcj9J6FjdJ
         u29vBA31eP1jzFvRjiO1WaX2hCj/3ve7bUe2kClBs0VXQSo2N/cMjHWBCAB722PHM8XI
         VKf+t2hia/Txsw2uzXUv5Byi5sY0/eVD5kfPd/Z5eDR+8OXRFUNiN3lDsIDLqYWWSZMN
         kEaPr8ZST68N6MaOK1BoBCMiGjfsilSmaMaAHLdIXjZuQDbm+b87c4rU4lYmE/fdktrP
         MQEVkqJyj2HJNh+EtydAgUx1+NVp9X+h745a4oVQfG+1zhnLreHaWz2LwTavtmF8gdJD
         jB4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iQh/dm/l5pZ34/VZO2TmQSqjFgee06I/tw8Wk6CAbGE=;
        b=54VMmx7vB1weoFLLaLsNqP/vHSzpG94j316kkmkPvYsrw0E65RL53Kbx8V5Hq7dUF6
         /9RNmbnz9TaOKUU9KfIOT+/uwSsfd5gUeKxdC6OOf6caJcXn03qWa1/Jcd7M9ExBCLv/
         2qM69g1P2irIRHSTRLtITlYjtlDa2GRhrK9Mh6aZ4iTGqwUxLsuSG2tJ6RB7KNwtaVeu
         PO1C8UScqWGPwLon0Ob5f4dq5p291vwNMNLuiF7yiVBjalKZ3nC2cefyhVcdDnzK63Oh
         2kMEV/62SqsOfnHtlpjU4Y6qQnlzX6ChwAttQWRgZJHqSm+8qPXQDO3dEoUcoV91hTNl
         JEpA==
X-Gm-Message-State: ANoB5plEHc1taqBlaWJjVxjo/YIkk17g+Lvm1rFpqGVh5R8Ldke+LhQ3
        MdAo9gD+72E+gPlhdZOJxf2CL+IxjQPIJpNFq+g=
X-Google-Smtp-Source: AA0mqf7W9MGZvbNFZ0Qf8rc9j+xY+fsifP3bb7ei8HsP9rjRVN0izInsEjYEqY1GTtHlBp4xKhCQeJQ7eFO7Hwbq6do=
X-Received: by 2002:a05:6512:258e:b0:4a2:500e:2bfa with SMTP id
 bf14-20020a056512258e00b004a2500e2bfamr7192966lfb.629.1668624615210; Wed, 16
 Nov 2022 10:50:15 -0800 (PST)
MIME-Version: 1.0
References: <20221027202603.670616-1-avagin@google.com> <Y1/GO1eWt+oTNA24@hirez.programming.kicks-ass.net>
 <20221116105725.6hyyexgwexo52i5j@suse.de>
In-Reply-To: <20221116105725.6hyyexgwexo52i5j@suse.de>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Wed, 16 Nov 2022 10:50:03 -0800
Message-ID: <CANaxB-yEgFuDZZ3w3JudNOSJr3tZfmbYgZ+txhBSc8WHXGRvaA@mail.gmail.com>
Subject: Re: [PATCH] sched: consider WF_SYNC to find idle siblings
To:     Mel Gorman <mgorman@suse.de>, kprateek.nayak@amd.com
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andrei Vagin <avagin@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mel and Prateek,

Thank you both for running tests and publishing results here.

On Wed, Nov 16, 2022 at 2:57 AM Mel Gorman <mgorman@suse.de> wrote:
<snip>
>
> This is not too surprising as UDP_STREAM is blasting packets so there are
> wakeups but the waker is not going to sleep immediately. So yeah, there are
> cases where the patch helps but when it hurts, it can hurt a lot. The patch
> certainly demonstrates that there is room for improvement on how WF_SYNC is
> treated but as it stands, it would start a game of apply/revert ping-pong
> as different bisections showed the patch caused one set of problems and
> the revert caused another.

I agree with these conclusions. The situation is more complex than how
I saw it initially.

Thanks,
Andrei
