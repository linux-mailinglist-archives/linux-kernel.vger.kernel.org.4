Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA0E62E73D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 22:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240783AbiKQVoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 16:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240319AbiKQVo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 16:44:26 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E42654FE
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 13:44:25 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-3704852322fso32023747b3.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 13:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0dEySP+67Qj/8hz+k7RmfDq3r5ZO5uceZ2qx/Czfr+M=;
        b=omnRQJUQBaSHQeWZbMGNBkbJ+SnZ5V1BQjcZAa495uLQ1wVGH0DTgBo+MG+ihfuYSq
         AU7So10AWNKX24Js4oaY7jasYv59XVn3qoyi41ZJKUO768yQ1FhjG8sdavJIKFSm+0Ho
         d51rh1Dwn2zBcjkzj7CG/CqDn+qKcD4KKPZmm7wFze7PpuiUe7JpedP3Tps91N6PBkNa
         4ERbjjTu9M5iNr0Z7U+mx4jzcXALPpIJfxfppsT1K7AFDZLk/W/Tfi+nsuoi3vlzRNXI
         UJLlPDquXJWZyipp194uzndT00am22SjimPMZkDo9VxFeA08UV4Ji0eU1V3zU4smQRWt
         YMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0dEySP+67Qj/8hz+k7RmfDq3r5ZO5uceZ2qx/Czfr+M=;
        b=Ga+/KC/t4rpvua+CVN9VLfkjToeui0h+TjUYhAGswxe5vx1LdzOvfLUQq0puUTvMyS
         Pj+LjWLDh4iLZUZT3r7HsQD2ONem+F8KAv7Isbv34pa1vLN8BU3+TtHFpgV3uKV+Mixo
         cPDo/qHBmlL13ss0hykZ8xN7ZeMwDTpS4uMTHbqANS94PpvZRcL8XuOaj5YfrMxEUUNL
         0c3tckZTQX9wTW2cfHXRg8V/AJsG2rtg3ceyACwYUWoRy5Il8ctX2kW7qXlnY3tbD1Gx
         jqXVyVAO63HwE2L4O/5wYSAMHouRswk/Tli2M8cjpARNaTkUckc8aIhG5QQx+dqZnU76
         oBAA==
X-Gm-Message-State: ANoB5pkmQTrc/pdfwEuLHj5L2PXcJBnXXKLVBp63Q/1RTf0kphPQZG2H
        phCx1Fz2xZjuAkysKDgPmjB+BxEyZBsiYBPshIGAhg==
X-Google-Smtp-Source: AA0mqf631fAYnWegGJdIShhSJBXQaE2RbCmkeJ51neWtuvbN2uJaFUii0vw1s59iT9DZBR4RufY1V9jQSFUbL4DFWbs=
X-Received: by 2002:a81:5f04:0:b0:393:ab0b:5a31 with SMTP id
 t4-20020a815f04000000b00393ab0b5a31mr1799919ywb.55.1668721463959; Thu, 17 Nov
 2022 13:44:23 -0800 (PST)
MIME-Version: 1.0
References: <20221117031551.1142289-1-joel@joelfernandes.org>
In-Reply-To: <20221117031551.1142289-1-joel@joelfernandes.org>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 17 Nov 2022 13:44:12 -0800
Message-ID: <CANn89iJuy=PuAiwrjF3qZY0M+86eRQ=o_x-m-eoxOdyAM8yoSg@mail.gmail.com>
Subject: Re: [PATCH rcu/dev 1/3] net: Use call_rcu_flush() for qdisc_free_cb
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>, rcu@vger.kernel.org,
        rostedt@goodmis.org, paulmck@kernel.org, fweisbec@gmail.com
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

On Wed, Nov 16, 2022 at 7:16 PM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> In a networking test on ChromeOS, we find that using the new CONFIG_RCU_LAZY
> causes a networking test to fail in the teardown phase.
>
> The failure happens during: ip netns del <name>
>
> Using ftrace, I found the callbacks it was queuing which this series fixes. Use
> call_rcu_flush() to revert to the old behavior. With that, the test passes.
>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  net/sched/sch_generic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> index a9aadc4e6858..63fbf640d3b2 100644
> --- a/net/sched/sch_generic.c
> +++ b/net/sched/sch_generic.c
> @@ -1067,7 +1067,7 @@ static void qdisc_destroy(struct Qdisc *qdisc)
>
>         trace_qdisc_destroy(qdisc);
>
> -       call_rcu(&qdisc->rcu, qdisc_free_cb);
> +       call_rcu_flush(&qdisc->rcu, qdisc_free_cb);
>  }

I took a look at this one.

qdisc_free_cb() is essentially freeing : Some per-cpu memory, and the
'struct Qdisc'

I do not see why we need to force a flush for this (small ?) piece of memory.
