Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846A36005E7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 06:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbiJQEDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 00:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233022AbiJQEDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 00:03:13 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F32537FD
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 21:03:11 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id z30so5934049qkz.13
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 21:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Qbjw7XShP57T4f7zH57+eoqDv1BZ7woutj0qbOq6v4=;
        b=lyGJKAzJP54/ff3wSqZ7o66vm71QTUXHd52mpGZLMJr1hCnhnIpPteiQm4GBfM3rJ4
         38ZcJ5Q76crlK4relGzWUmUFTf5CneQXWBuOT5CmPkymPQYSCX1zO0edYqNaUAZsPi5m
         dxB8ZrudBwwZ7wYI0/YlFxPf1QB6ZeaowgOWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Qbjw7XShP57T4f7zH57+eoqDv1BZ7woutj0qbOq6v4=;
        b=N40TCjSBimedORWwjnBm1CJ5X0Nd8U+qhDwsFmz7BkYLQCtW1H5x0HrOmgaPC2do0c
         Z8PPKRvYeykc4NjasYJTcOGtPPWCvS/ngdxKjk6SzRZygMAT30HG4aMy4tmSWKAjSj2S
         0v1WQW1AYNXx8d/GDoCe59V7kj5HaqP8D9tujmU6I1Qc2vsT7tn7zysBaXtT7ComwLZn
         EcjvlZyCOLOJk90w6L11YDlOL5qPKUAFOdjwe48QUJUCvdT1NROBlvQs0RfmSGQXSDcm
         SH8J1xVBRUSqisMlYBgjTBvrswUHjZULkZUqkDa4v/3w5YUjGjuGqj/C5R/SumvqPSpc
         MtOw==
X-Gm-Message-State: ACrzQf0xgdLleoMTCiOH04bYkkTlwntwLp3mIXMpmgz1GEuZuczuBQVX
        sORtTYfdB90THp8OPYt1pzVpdQ==
X-Google-Smtp-Source: AMsMyM4vXbdrnrlKiDGIWdF0LlTpZPLOuZbLCiFhur70PNGZL2eqK31WkJR8MinsCR3AXI8E1AdPbQ==
X-Received: by 2002:a05:620a:298d:b0:6ea:58bd:51a5 with SMTP id r13-20020a05620a298d00b006ea58bd51a5mr6399060qkp.493.1665979390129;
        Sun, 16 Oct 2022 21:03:10 -0700 (PDT)
Received: from smtpclient.apple (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id o184-20020a375ac1000000b006ce515196a7sm8353703qkb.8.2022.10.16.21.03.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Oct 2022 21:03:09 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH 07/11] sched: Add proxy execution
Date:   Mon, 17 Oct 2022 00:03:09 -0400
Message-Id: <F34EC553-9C1E-4027-A4BB-BAA8D443235F@joelfernandes.org>
References: <20221016164809.6cd6871f@rorschach.local.home>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Connor O'Brien <connoro@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        John Stultz <jstultz@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, youssefesmat@google.com
In-Reply-To: <20221016164809.6cd6871f@rorschach.local.home>
To:     Steven Rostedt <rostedt@goodmis.org>
X-Mailer: iPhone Mail (19G82)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 16, 2022, at 4:48 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
> =EF=BB=BFOn Sat, 15 Oct 2022 15:53:19 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
>=20
>>> =46rom this it is easy to see that the critical secion executes with the=
 =20
>> direct sum of the blockchain as a whole (all of them will have donated
>> their relative time to make the owner elegible again) -- provided the
>> critical section is of course long enough for this to matter (or it's
>> owner's weight small enough etc..).
>=20
> Does this mean that a lower priority task could do a sort of DOS attack
> on a high priority task, if it creates a bunch of threads that
> constantly grabs a shared lock from the higher priority task? That is,
> the higher priority task could possibly lose a lot of its quota due to
> other tasks running on its behalf in the critical section?

Just my opinion: I can see that as a problem, but on the other hand, if a bu=
nch of threads are acquiring a shared lock to block a high priority task, th=
en they are probably causing a DOS-type of issue anyway whether PE is enable=
d or not.  Even if a prio inheritance mechanism boosts them, they=E2=80=99re=
 still making the progress of the blocking high priority tasks slower. Or, d=
id I miss something in this use case?

Thanks.

