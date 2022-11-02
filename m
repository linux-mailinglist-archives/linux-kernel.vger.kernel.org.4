Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3653C6167EA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbiKBQNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbiKBQMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:12:07 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACACB2D1C1
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 09:11:38 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id a67so27191142edf.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 09:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/nx0A3jt4d916p+0TTWB9Cat4g/h93+jjZlEFabh3r4=;
        b=CrA9D4GdoDlJzsilzh/L+NKrb9G4nTE4mc75ivd5A3e+iwv2LTp555SfYctr+aqF+8
         7sOxRfi4LB67FD1k0bi7t0W0oZ+7UgeHMTU6UMTnSYBMY26D1mmlmt9bY5sw2OOcYq24
         ib+hWhijSZLMMpQKpZ1+7sp4fBht3oTXoP0ik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/nx0A3jt4d916p+0TTWB9Cat4g/h93+jjZlEFabh3r4=;
        b=ukG03Cp5R1H9KAybuROCOrJeQ9gMgKz1Jm1VjWrk3fS69fuL/YfAAsuJBLtVLq4WvS
         qF/9zemoeptUzWPBYxMRLvWbaHetve196w5b+dsWpM0N33u2TTkvXQRraVEiG7q3BTKH
         /11hTzLSPiTpU2k5Cc0L9sFRhgmjlrITVPVsZwNA00afCRJ5hb9GbhzsAYG6h+7MnFuk
         ou5m/uEykFa0DDL5lfjURUlUg1yPtAZmj7fjzYQ6n3TJA1eddTHQL+3WK2oMzGpMcPx8
         gCK50LYaEf7aD3vCFxhoS/F78HtTytTOg5e80uotgRDi81yyPaU65MvAUvtTtrP2D9Gw
         E99w==
X-Gm-Message-State: ACrzQf2BXEM+FkLyS4uI3uSL/Pk1ZKZyj+Mdzp1lj7HlrTRp4Yn42bkR
        vaIykjQjPYZBzf41bAKGbvzL84KWDvkrOJaT8F5irw==
X-Google-Smtp-Source: AMsMyM5B7tk4hRliW0OLIl6wvvEuEO2HgVMMq3tZe1CHgaJTrdsnjRs6aEFfvnALtydwBc7jERWdcYNrs4p7j6TDjfE=
X-Received: by 2002:aa7:de9a:0:b0:44d:8191:44c5 with SMTP id
 j26-20020aa7de9a000000b0044d819144c5mr24730606edv.232.1667405496949; Wed, 02
 Nov 2022 09:11:36 -0700 (PDT)
MIME-Version: 1.0
References: <20221029132856.3752018-1-joel@joelfernandes.org>
In-Reply-To: <20221029132856.3752018-1-joel@joelfernandes.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 2 Nov 2022 12:11:24 -0400
Message-ID: <CAEXW_YRZ-0LP5Y=sWREkLzPTiAJZTPrSm9YGfg6eqmD5XhwQTA@mail.gmail.com>
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

TODO: As Paul pointed out today in a meeting, we can't just sample
rdp->gp_seq directly as it can jump forward quickly from out-of-date
to non-out-of-date. Such GP can happen before a grace period actually
elapses. Boom!

He did make me feel better though that it is something easy to miss,
and to audit the current code about.

 - Joel



 - Joel



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
