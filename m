Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F85C61234B
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 15:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiJ2Nb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 09:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJ2NbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 09:31:25 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722B33B973
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 06:31:24 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id r14so11570101edc.7
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 06:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H2c4zOpFPU7Fj7fSnkokCJ5cgtQZamEl4/ckihkqxdg=;
        b=guOF+KRUfO2jIMkNmcsWZt0V1qSdphz/s+ep6QkB4OmTkjf9xRsz59bI20Q0juOQEd
         SD2kcYJ3gchvzgQyADVeu5u5c6UbZf0WXIpYK3blhMRTyiSGIko4GFYfYZl8wrGw2afv
         M44AoSeWZXJ7fQx8wp1FxcsK4hxaEGqcZrGZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H2c4zOpFPU7Fj7fSnkokCJ5cgtQZamEl4/ckihkqxdg=;
        b=XL20wxohCieIHB41BcGfsslqPBPo0psCCNktu65CxMQTtDcQQUUUr4DuHUs1sW9DtR
         QvFRV9Qjm9/IMxO+v65R/QcaS0tbrycfkaPJTuKqKOu+lf0ALVP8lL0rtQonLNOoFFfy
         iHUDd0fLVrieAcT85LtOFS4jRD3pFGQjg9zYCOmOy9dYQvrt5m1Bt9nzQGXNCljRpJGH
         NfXNrirkBIq8UZBDeib2oDzzvQHYJckPNUjTGc9/77vC9kpjNM+cC/mIhqo41N8lucnz
         UoEKg7isSp2M01UGGYamxI2sBOutz5rPe31gWg2CxWRW3uhMG4JqkjbE7NQE1MnDocuW
         TzEA==
X-Gm-Message-State: ACrzQf20KxVbOKfd2p696LfthLD++NzQS4irUfdaZzbn92/jo3inUn/t
        ZY1GK7/ixOaprC4brhQp0Gx7UVI1T1PrrNLy3tCU6A==
X-Google-Smtp-Source: AMsMyM5O6N8LOAdxsWmcrYQ/8JYKcf9D+mw6ft1pvLqxKo3lCrzd6MBsvGoRIu/QG/L/J5WBH32qeG3UJ4KVpLeC3SQ=
X-Received: by 2002:a05:6402:3806:b0:450:bad8:8cd5 with SMTP id
 es6-20020a056402380600b00450bad88cd5mr4479230edb.305.1667050282944; Sat, 29
 Oct 2022 06:31:22 -0700 (PDT)
MIME-Version: 1.0
References: <20221029132856.3752018-1-joel@joelfernandes.org>
In-Reply-To: <20221029132856.3752018-1-joel@joelfernandes.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sat, 29 Oct 2022 09:31:12 -0400
Message-ID: <CAEXW_YRbi5yhVnVXunM0MrxJbFLaM9OtoT=8gw7hkm+r2+D_FA@mail.gmail.com>
Subject: Re: [PATCH RFC] rcu/kfree: Do not request RCU when not needed
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, paulmck@kernel.org, urezki@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2022 at 9:29 AM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> On ChromeOS, I am (almost) always seeing the optimization trigger.
> Tested boot up and trace_printk'ing how often it triggers.
>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/rcu/tree.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 591187b6352e..3e4c50b9fd33 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2935,6 +2935,7 @@ struct kfree_rcu_cpu_work {
>
>  /**
>   * struct kfree_rcu_cpu - batch up kfree_rcu() requests for RCU grace period
> + * @rdp: The rdp of the CPU that this kfree_rcu corresponds to.
>   * @head: List of kfree_rcu() objects not yet waiting for a grace period
>   * @bkvhead: Bulk-List of kvfree_rcu() objects not yet waiting for a grace period

Yuck. I forgot to add last_gp_seq to the comments. Will await feedback
before re-spin.

 - Joel


>   * @krw_arr: Array of batches of kfree_rcu() objects waiting for a grace period
> @@ -2964,6 +2965,8 @@ struct kfree_rcu_cpu {
>         struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
>         raw_spinlock_t lock;
>         struct delayed_work monitor_work;
> +       struct rcu_data *rdp;
> +       unsigned long last_gp_seq;
>         bool initialized;
>         int count;
>
> @@ -3167,6 +3170,7 @@ schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
>                         mod_delayed_work(system_wq, &krcp->monitor_work, delay);
>                 return;
>         }
> +       krcp->last_gp_seq = krcp->rdp->gp_seq;
>         queue_delayed_work(system_wq, &krcp->monitor_work, delay);
>  }
>
> @@ -3217,7 +3221,17 @@ static void kfree_rcu_monitor(struct work_struct *work)
>                         // be that the work is in the pending state when
>                         // channels have been detached following by each
>                         // other.
> -                       queue_rcu_work(system_wq, &krwp->rcu_work);
> +                       //
> +                       // NOTE about gp_seq wrap: In case of gp_seq overflow,
> +                       // it is possible for rdp->gp_seq to be less than
> +                       // krcp->last_gp_seq even though a GP might be over. In
> +                       // this rare case, we would just have one extra GP.
> +                       if (krcp->last_gp_seq &&
> +                           rcu_seq_completed_gp(krcp->last_gp_seq, krcp->rdp->gp_seq)) {
> +                               queue_work(system_wq, &krwp->rcu_work.work);
> +                       } else {
> +                               queue_rcu_work(system_wq, &krwp->rcu_work);
> +                       }
>                 }
>         }
>
> @@ -4802,6 +4816,8 @@ static void __init kfree_rcu_batch_init(void)
>         for_each_possible_cpu(cpu) {
>                 struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
>
> +               krcp->rdp = per_cpu_ptr(&rcu_data, cpu);
> +               krcp->last_gp_seq = 0;
>                 for (i = 0; i < KFREE_N_BATCHES; i++) {
>                         INIT_RCU_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_work);
>                         krcp->krw_arr[i].krcp = krcp;
> --
> 2.38.1.273.g43a17bfeac-goog
>
