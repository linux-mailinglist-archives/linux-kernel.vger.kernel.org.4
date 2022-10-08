Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1FE5F85B7
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 17:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiJHPFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 11:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiJHPE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 11:04:58 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2DA22512
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 08:04:55 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id mx8so4794149qvb.8
        for <linux-kernel@vger.kernel.org>; Sat, 08 Oct 2022 08:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YGpdtOjpskyq7830WM79Ud5JbDY9Fq/HmElSPixR6dc=;
        b=alNwhRF4x6ZRyufvKiYDZTjnCylq0obGk+0Iqb78Q+0iqUgsbpnFYsoxAHjPXYkhGd
         CkF0lTQbMqa8f+qtGn6rSVo0Hf7/KYrVCnisT7cjO5g5jCsVFMLHM7BamfkU5CLsRP0Q
         49Xdw3uNz/mWup0cy+MMz9ogipP92egyq87hw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YGpdtOjpskyq7830WM79Ud5JbDY9Fq/HmElSPixR6dc=;
        b=rvkKSylmTspjDGNVSbE7+hrXpKl22RCn/TYfri1VGBpbbMtbnqE1j01HAwQbTFNy+P
         KlvQ87LCN+ZcC7iJ798HpWhi9gAAgsXC1rLVpl2eazz9nQZI3dKO0fCSgO/T5RpY7dY1
         u61np6RSvRKU6weZ1llKTcrAYsjvMThisg6NoX55q0qUy1CCHyhWf+26Rjq77xq/MOoL
         JLAXGGMH1vWJ5BFfoXPn41AX/aCtdYrwiqGfZp1cgrfaSQ05RWr4XnxJGBLvVMGu5LsE
         faqVLoxursPEkHfmYrW0sVmXGIizQgDc1dO4KX158i5qHOVz04ZDpLUmWs950rX4mcDQ
         TCDg==
X-Gm-Message-State: ACrzQf1cir2JP3PY4dVHpcSH+UX6F/xrc/HCHYJKxal6ULIFzT5DOxX+
        chZmfaEcZGgeT4N7D9j4j/fTtg==
X-Google-Smtp-Source: AMsMyM48jHGfuqInSAbfoHdhnvjDkodK76fpPu8a/umj1o7g065ENRmK+1A7iPhf9tHN4upxVLBIFQ==
X-Received: by 2002:a05:6214:4116:b0:4b1:b795:f7c with SMTP id kc22-20020a056214411600b004b1b7950f7cmr8717446qvb.28.1665241494447;
        Sat, 08 Oct 2022 08:04:54 -0700 (PDT)
Received: from smtpclient.apple ([2600:1003:b858:99c0:95bd:7b48:ffe8:6e89])
        by smtp.gmail.com with ESMTPSA id s2-20020a05620a29c200b006b8e63dfffbsm4746951qkp.58.2022.10.08.08.04.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Oct 2022 08:04:53 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: Sum of weights idea for CFS PI
Date:   Sat, 8 Oct 2022 11:04:52 -0400
Message-Id: <0BFD3887-60A2-4C74-9D37-49B7B6E64299@joelfernandes.org>
References: <CALUeGD0OP4ZqDFcT10=ih40tGsm9gjjno7NP_Jwd1RxiUJZ0CQ@mail.gmail.com>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, juri.lelli@redhat.com,
        vincent.guittot@linaro.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, bristot@redhat.com,
        clark.williams@gmail.com, bigeasy@linutronix.de,
        "Paul E. McKenney" <paulmck@kernel.org>
In-Reply-To: <CALUeGD0OP4ZqDFcT10=ih40tGsm9gjjno7NP_Jwd1RxiUJZ0CQ@mail.gmail.com>
To:     Youssef Esmat <youssefesmat@google.com>
X-Mailer: iPhone Mail (19G82)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 6, 2022, at 3:40 PM, Youssef Esmat <youssefesmat@google.com> wrote:=

>=20
[..]
>>=20
>>> Anyway - just trying to explain how I see it and why C is unlikely to be=
 taking
>>> too much time. I could be wrong. As Youssef said, I think there's no
>>> fundamental problem here.
>>=20
>> I know on Android where they use smaller HZ, the large tick causes
>> lots of problems for large nice deltas. Example if a highly niced task
>> was to be preempted for 1ms, and preempts instead at 3ms, then the
>> less-niced task will not be so nice (even less nice than it promised
>> to be) any more because of the 2ms boost that the higher niced task
>> got. This can lead the the sched_latency thrown out of the window. Not
>> adjusting the weights properly can potentially make that problem much
>> worse IMO.
>=20
> Once C releases the lock it should get adjusted and A will get
> adjusted also regardless of tick. At the point we adjust the weights
> we have a chance to check for preemption and cause a reschedule.

Yes but the lock can be held for potentially long time (and even user space l=
ock). I=E2=80=99m more comfortable with Peter=E2=80=99s PE patch which seems=
 a more generic solution, than sum of weights if we can get it working. I=E2=
=80=99m studying Connor=E2=80=99s patch set now=E2=80=A6

> If C doesn't release the lock quickly (hopefully rare), it should
> continue to run at the adjusted weight since it is still blocking A.

We can=E2=80=99t depend on rare. Even one bad instance is a fail. So if lock=
 holder and releaser go crazy, we can=E2=80=99t destabilize the system. Afte=
r all, this is CFS and fairness should not be broken, even if rarely.

Thanks.


>=20
>>=20
>> Thanks.
