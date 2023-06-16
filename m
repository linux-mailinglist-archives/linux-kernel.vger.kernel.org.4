Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8897333EB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 16:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345729AbjFPOrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 10:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239654AbjFPOro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 10:47:44 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9448530F2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 07:47:37 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f7f7dfc037so125995e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 07:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686926856; x=1689518856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SqsLOY0keNslgPF16eLpofAIxuxhZDzY2/YPx/6K4vY=;
        b=H2y0fBlJ2XYd8JyDq9p6DVUcAGX4avSi+/G6hN4BznMR8M2kQQeGXkGZnPI0ujv2f4
         9QXY9Z486uWtm1sp+0Mb/3ybI4MXd2kXhnpbs7PN9xg0Fl4JYZe2aqvRrzyBi9O24vaA
         0jeuSB+2Fh/1ER4igNyRDtDhd3A6DEMbuBbJDT5KLRVWJL/uAaRyhV1Ic7XggUs+TdI0
         DHM4o/BBaO/mTtACuqXxiu54vk1t1MTXK8Umdnms1O2nda2aGrR1ZcWBpIB9i4E3wf6e
         9o5qPTMcXm8lL4Vfzz/BAjaLCxOalCAZUvl5xftdFXdRd4WCl1BRxFU/70Xej+vNce6R
         EFLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686926856; x=1689518856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SqsLOY0keNslgPF16eLpofAIxuxhZDzY2/YPx/6K4vY=;
        b=RWCjz4zZmkIbqhKEg7lbExAxfRXIDRce3GCKQnfeKOWqUj7ojG8hbBLDx9krLmrMDe
         fKM+OFvXtf1bZgtjRgZWCTC5WZQjuEGFt2ky36iQhauaVQvHAe+K+Vc6obOf1s3jtxOW
         SjYBUsepnHPjkNaETimKC+aVZDHI9xjdn0wv1hKMWUmBFKeAmfboJkwF1pcoszNo9+iK
         V1cXG8hA6YoCBdE0ZOnm/+2DlKyyIpDCccDDGJvZq7KPw8rkTl7ur7gCQ8S3BwmWaM+T
         G/IqfL1R856VnjSU7wjyWiRbgi1jCISJk0NmMjIwRrGftzJr/brrjX1xdLIl/7XdddeO
         Kurg==
X-Gm-Message-State: AC+VfDzWP9cLkt48Dcn/WlBwWA+vDBGjJHgSv/vSrPB1/gUXW1bSw/JT
        NYRQuH4sdTo33zpUlyznRBOT+syEpo937yf/gfqqSw==
X-Google-Smtp-Source: ACHHUZ7mstHD6fpbDagRSRjS8Q8yfEkq0hoEenm6B3kQZ1GOO2mlwy4es3WH21LMO8g48y1IWlRJICX/2NwLGGXj1fU=
X-Received: by 2002:a7b:ce98:0:b0:3f7:32d4:60d0 with SMTP id
 q24-20020a7bce98000000b003f732d460d0mr414344wmj.4.1686926855674; Fri, 16 Jun
 2023 07:47:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230615201252.1009678-1-joshdon@google.com> <20230616133323.GH4253@hirez.programming.kicks-ass.net>
In-Reply-To: <20230616133323.GH4253@hirez.programming.kicks-ass.net>
From:   Josh Don <joshdon@google.com>
Date:   Fri, 16 Jun 2023 07:47:24 -0700
Message-ID: <CABk29NuFreTRe+byiweOWccvjXmt1H8Mw5qEbQfonvpQFbTZGA@mail.gmail.com>
Subject: Re: [PATCH] sched: fix throttle accounting with nested bandwidth limits
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
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

On Fri, Jun 16, 2023 at 6:33=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Thu, Jun 15, 2023 at 01:12:52PM -0700, Josh Don wrote:
> > This fixes two issues:
> > - throttled_clock should only be set on the group that is actually
> >   getting throttled
> > - self-throttled time should only be accounted on entry/exit to
> >   throttled state when we have nested limits
> >
> > Fixes: 88cb2868250c ("sched: add throttled time stat for throttled chil=
dren")
> > Fixes: 3ab150d011da ("sched: don't account throttle time for empty grou=
ps")
> > Signed-off-by: Josh Don <joshdon@google.com>
>
> Hurmph, those are not the sha1 I have in tip/sched/core.
>
> Also, should I rebase and just pull those patches so we can try again?

Oh whoops, I used the SHA's from your queue.git.

Yes, if it is still possible to intercept them then that would be
great. I'm OOO at the moment, but can respin those for you first thing
next week.

Thanks,
Josh
