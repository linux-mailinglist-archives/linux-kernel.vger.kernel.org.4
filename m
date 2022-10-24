Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39563609781
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 02:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiJXAgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 20:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiJXAgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 20:36:13 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A50561710
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 17:36:12 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id r14so25723092edc.7
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 17:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rHb6gbIDggMDA41dKCNMQLkyqPbGap5CBWFlyWHfXFo=;
        b=wY/W3mgTWqDQ8m/k6XAHNpokvp1viHHxLfpVYc6QsmD5mSRAzN+IQQvFapmUlOJPaJ
         d+P79mK/u4vElljNrLTAnibmvkTUC3GyzwncKcoYVms9FW5nPvA8/xemue1bYQl1LgDF
         MZ3eSHT/CQpEC952z1e86F5O09+ga9h0tx2QI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rHb6gbIDggMDA41dKCNMQLkyqPbGap5CBWFlyWHfXFo=;
        b=okq2TOdrLowRuCWUy67GQBZcRdfxoxSTSjUItwkAIdDUYVazGGyY0sQuC4Jgfx8tfB
         4vlTp7HMnOnXzNHRLxJN7k6Bzh1QYHLQ1KbMuBNzpE6F4lBw+seBq0fLXAI37biVXB1m
         XMQyAkRQ7rppR1yoIyW5YWVoiOAbHfPkCPzNy4H3joE12NCmqMLQ780ocHldBLTn7Wzo
         UFwfQHlZyV2whGRUOkfrP5ytbQGGonO0LbFMtpxSHiUutSyOtwQsGIPwsQR7sZtsIDtx
         XwHibevb2KVET4GMijZg0cr5RofSb1CGjC5HQzBktPC2UyV3ccKUVAVxp3bniaaHotT2
         X3Yg==
X-Gm-Message-State: ACrzQf2EL8Y20eGKMWmZbFz1KrNE8WW88NSJF8cuTLFPMkHg+0E1bEXg
        QRUgFYvuLdM4tFxVG0aHlrL+XfelMjqFXVNBzCyfuA==
X-Google-Smtp-Source: AMsMyM4uhY6IO76XbaYij5t5Z/ChVREPYqJ/qPCIhCEZZ+p1XFM+sTLK/F5qML/vnnDuXv+c4AX+nwpEAOVyEKmVIr4=
X-Received: by 2002:a05:6402:3551:b0:45d:a52f:2d77 with SMTP id
 f17-20020a056402355100b0045da52f2d77mr29314760edd.67.1666571771048; Sun, 23
 Oct 2022 17:36:11 -0700 (PDT)
MIME-Version: 1.0
References: <20221019225138.GA2499943@paulmck-ThinkPad-P17-Gen-1> <20221019225144.2500095-13-paulmck@kernel.org>
In-Reply-To: <20221019225144.2500095-13-paulmck@kernel.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sun, 23 Oct 2022 20:36:00 -0400
Message-ID: <CAEXW_YQgSwMYisZVctXkjFu6_5YhFCpL_E5o5H4oJooS5Syp+g@mail.gmail.com>
Subject: Re: [PATCH rcu 13/14] workqueue: Make queue_rcu_work() use call_rcu_flush()
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org,
        Uladzislau Rezki <urezki@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Oct 19, 2022 at 6:51 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> From: Uladzislau Rezki <urezki@gmail.com>
>
> call_rcu() changes to save power will slow down RCU workqueue items
> queued via queue_rcu_work(). This may not be an issue, however we cannot
> assume that workqueue users are OK with long delays. Use
> call_rcu_flush() API instead which reverts to the old behavio

On ChromeOS, I can see that queue_rcu_work() is pretty noisy and the
batching is much better if we can just keep it as call_rcu() instead
of call_rcu_flush().

Is there really any reason to keep it as call_rcu_flush() ?  If I
recall, the real reason Vlad's system was slowing down was because of
scsi and the queue_rcu_work() conversion was really a red herring.

Vlad, any thoughts?

thanks,

 - Joel

.
>
> Signed-off-by: Uladzislau Rezki <urezki@gmail.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  kernel/workqueue.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 7cd5f5e7e0a1b..b4b0e828b529e 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -1771,7 +1771,7 @@ bool queue_rcu_work(struct workqueue_struct *wq, struct rcu_work *rwork)
>
>         if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work))) {
>                 rwork->wq = wq;
> -               call_rcu(&rwork->rcu, rcu_work_rcufn);
> +               call_rcu_flush(&rwork->rcu, rcu_work_rcufn);
>                 return true;
>         }
>
> --
> 2.31.1.189.g2e36527f23
>
