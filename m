Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6406FC242
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 11:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbjEIJC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 05:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234247AbjEIJCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 05:02:51 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC7AD87C
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 02:02:46 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-3f38824a025so128761cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 02:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683622965; x=1686214965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cQMbOwK6UYUwP4h+X9ffrgGRqDFyDl3hTELKhL2KLRY=;
        b=ddHO5YVlQ1k4ASnusUqx9tc+JVzlf+tQbh4Gdn+HbeY+pKzC/a+VgLV0AgN0LagWz/
         ArL3VnF/Pj2P7rinLP5b7MF/8kziKaG7TvoAs77uCq5FcyN+CR4SUU4RX5VlLVPD7zZL
         U/e8Obxe5plDiMpKDbVsYsFtiNV7qXyPUYvJDrRGzKCdrovK7N1lloFDk3lYESTlSml3
         lDD8ubJopiXPiJTmqf5aMWEPdl2oDrI55jnokpxjATrszf3NbWADNDSc/NbKRimorDBD
         VLwctjYRZvd5+3mtqEHnrSL1cXmn2jhSRrH+K4pAc3t9ef39l7rJ+BKu4mfZ3I0AfBv5
         +RXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683622965; x=1686214965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cQMbOwK6UYUwP4h+X9ffrgGRqDFyDl3hTELKhL2KLRY=;
        b=H5nuGZGydXmjRmXelBmsD19JLCJNls0ND6LVryuPsunDc4rnZTGV0sCbwwRtkE7ZDW
         o9xNlgoJqkFvH7JgXgAN6R0jtBcCFPhReeveCiwEu7qPOYhb1WkcOHDJKZt+4j7YiRSj
         u4ydSrbvZTrvqrqdhkaQC0QN9c8/DjYD+y30C8A84hvDSnmuCIIgX1yKCo1JgeWu4Vu1
         4iIAtfmk5BqVKfnbhLqJeXBvxyWKkq4DWADnMtRYI2xcYI7xY477PqbaZTCXvL1WzB7r
         u71chs/yKHnaBJVzsVttXcnK6GERrkdJy9jDLOaVKnc9peS92KMCeDvENR2cGqL1roob
         UyGw==
X-Gm-Message-State: AC+VfDxHPeSjMtj+LYcwAUJGDVxNHeg+ksLBe0M9iLV9x+qh37VaIp7L
        TcZ95hzq9PBB9JwCqy/+GGtWaHogVMI0MXp8NPp9wg==
X-Google-Smtp-Source: ACHHUZ5aQwhgwj/qWG83MeZFJnYduMtgU13qiDC9ksdyPsMzKkTIqz9lHLF930e5/pXsqRmHy7+SS648OohflQdddNA=
X-Received: by 2002:a05:622a:1308:b0:3ef:4319:c6c5 with SMTP id
 v8-20020a05622a130800b003ef4319c6c5mr158583qtk.19.1683622965469; Tue, 09 May
 2023 02:02:45 -0700 (PDT)
MIME-Version: 1.0
References: <57e66b364f1b6f09c9bc0316742c3b14f4ce83bd.1683526542.git.pabeni@redhat.com>
 <20230508184219.4049952c@kernel.org>
In-Reply-To: <20230508184219.4049952c@kernel.org>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 9 May 2023 11:02:34 +0200
Message-ID: <CANn89iKLuSq8aGhVpB7CkT2Q7aWBPWMWcUek+U7kgfHU5tEyTA@mail.gmail.com>
Subject: Re: [PATCH] revert: "softirq: Let ksoftirqd do its job"
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, peterz@infradead.org,
        netdev@vger.kernel.org, Jason Xing <kerneljasonxing@gmail.com>
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

On Tue, May 9, 2023 at 3:42=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Mon,  8 May 2023 08:17:44 +0200 Paolo Abeni wrote:
> > Due to the mentioned commit, when the ksoftirqd processes take charge
> > of softirq processing, the system can experience high latencies.
> >
> > In the past a few workarounds have been implemented for specific
> > side-effects of the above:
> >
> > commit 1ff688209e2e ("watchdog: core: make sure the watchdog_worker is =
not deferred")
> > commit 8d5755b3f77b ("watchdog: softdog: fire watchdog even if softirqs=
 do not get to run")
> > commit 217f69743681 ("net: busy-poll: allow preemption in sk_busy_loop(=
)")
> > commit 3c53776e29f8 ("Mark HI and TASKLET softirq synchronous")
> >
> > but the latency problem still exists in real-life workloads, see the
> > link below.
> >
> > The reverted commit intended to solve a live-lock scenario that can now
> > be addressed with the NAPI threaded mode, introduced with commit
> > 29863d41bb6e ("net: implement threaded-able napi poll loop support"),
> > and nowadays in a pretty stable status.
> >
> > While a complete solution to put softirq processing under nice resource
> > control would be preferable, that has proven to be a very hard task. In
> > the short term, remove the main pain point, and also simplify a bit the
> > current softirq implementation.
> >
> > Note that this change also reverts commit 3c53776e29f8 ("Mark HI and
> > TASKLET softirq synchronous") and commit 1342d8080f61 ("softirq: Don't
> > skip softirq execution when softirq thread is parking"), which are
> > direct follow-ups of the feature commit. A single change is preferred t=
o
> > avoid known bad intermediate states introduced by a patch series
> > reverting them individually.
> >
> > Link: https://lore.kernel.org/netdev/305d7742212cbe98621b16be782b0562f1=
012cb6.camel@redhat.com/
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > Tested-by: Jason Xing <kerneljasonxing@gmail.com>
>
> Reviewed-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.
