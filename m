Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47CA6C31DC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 13:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjCUMjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 08:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjCUMjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 08:39:06 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC1F7ABE
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 05:38:57 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id d13so15452967pjh.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 05:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679402337;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=psQ3fndUzPOiGZuluVjcHdDi70vc5YYFSkEQm/+7Ln8=;
        b=hdAg+kbUcsvf35SFZgqeAGJMawvQhmOUfrDyR9ABe9kykcf+VIR7cOeYnjotRn5GCU
         SN3P+J0/zkbbbrU6/PdrZZDVbFmNF8URpez3d5j18iFxVuGLUTDKErbnxiMn5/uUYu2d
         W2Qjo11+YNkyxMN4Z8IMgSt7Fjr1jFRHF96uJICH1mQQwuoYfqvWMItvu74dQruHtQo0
         u0y/iRFf3bC3Ir34xlg7I4bkG6Q5emFpwfoX9M213wEhR8VUdXFtusENkvLJKGMGA2uU
         r0L5IqrQOWS4+9OycTV05CAW02JmzqBW88fi2SC2w0/S3nVVdDhJC1HduABnLvgGNFOQ
         lkAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679402337;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=psQ3fndUzPOiGZuluVjcHdDi70vc5YYFSkEQm/+7Ln8=;
        b=0KImXxvZC5fPC1A0x5Ooa/brMMYvQth808Jkp5M6lKMfputqJyf/sCONYe9nvLiU5f
         GaITkmIThyBycplYOakSJbR/iMeA3dBMJlYJd9llxRL9XThokYLKqYxiyt7mIpf0Yymh
         nsiUgWtNDTwUNuZQdGf64DAyqItTRMI3+kHUj9ntPnFAek/+35uPQgozNX/ODFKRO3tz
         TMJkecEKST0eoe3ikaJqFqvcLN7kPMr934GSvY//Ke3d1JbBUx7gIgpb9GpVJK4ySu6w
         RFui4AoxD9VWfr5Rp35627PI9nXSQYB3Kadz1v7v6dP4ndw/i/V2B+gBr2nlVfDKDLU/
         yc8A==
X-Gm-Message-State: AO0yUKVvtaWzijRel9vO4NcDMoQKioIjHGcEX6mrF6LDOs6WRpUltOcj
        P5AKDjqHDzd9HgO09ysiDy6uvzsQ2zDr0KrPXrS5Ig==
X-Google-Smtp-Source: AK7set8Y6ZbQ8GATAMTM9rGHzakUBlONUXTzVdrc4Qcz+6gcS5yhwvuBoj2pwKFBIlMSPKONpFYT3ABZL6MIqjb/dXo=
X-Received: by 2002:a17:90a:ca8d:b0:23d:4e0e:cf2c with SMTP id
 y13-20020a17090aca8d00b0023d4e0ecf2cmr620323pjt.3.1679402336886; Tue, 21 Mar
 2023 05:38:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230317160810.107988-1-vincent.guittot@linaro.org> <20230321122846.GK2234901@hirez.programming.kicks-ass.net>
In-Reply-To: <20230321122846.GK2234901@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 21 Mar 2023 13:38:45 +0100
Message-ID: <CAKfTPtD28wd17cdUqrpVp71Vkw0kReyLSK86N4ZUmV5A2h+fSw@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: sanitize vruntime of entity being migrated
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, zhangqiao22@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Mar 2023 at 13:28, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Mar 17, 2023 at 05:08:10PM +0100, Vincent Guittot wrote:
> > Commit 829c1651e9c4 ("sched/fair: sanitize vruntime of entity being placed")
> > fixes an overflowing bug, but ignore a case that se->exec_start is reset
> > after a migration.
> >
> > For fixing this case, we delay the reset of se->exec_start after
> > placing the entity which se->exec_start to detect long sleeping task.
> >
> > In order to take into account a possible divergence between the clock_task
> > of 2 rqs, we increase the threshold to around 104 days.
> >
> >
> > Fixes: 829c1651e9c4 ("sched/fair: sanitize vruntime of entity being placed")
> > Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>
> Just noticed, that SoB chain isn't valid, should Zhang be something
> like: Originally-by or Suggested-by or whatever?

Originally-by would be the right tag
