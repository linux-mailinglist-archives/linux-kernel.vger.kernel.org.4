Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39FE860014A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 18:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiJPQ04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 12:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiJPQ0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 12:26:40 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E13D40E17
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 09:25:42 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id y17so4795760ilq.8
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 09:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oZr/t9CrGerPuq1rQliI5Up78H2QXgmNcAEP1OgdStw=;
        b=tvrVvsf968LGEqhZT/+sH14P9zlqwnUJTC8J10JSuxmz+Zip2qtuZPvjiXS5OHDPOF
         hMnpiW7v6pndo6bLQrskAfEfoasvFzvzBvlSI6M2gp4KHiPjX08onpn4D1nTOY8y364u
         sh8Y26aO9vVKh3xJev9hxqckdkpx8wbVgDl1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oZr/t9CrGerPuq1rQliI5Up78H2QXgmNcAEP1OgdStw=;
        b=26SCj015tn5bS4ZtPs6oIuimfXH5I8mUNG3bRROQBDo1OtverAQ7WcEnN7JExz0zZ6
         yryGoh2i7K+u/OMwe36eAIws/bDs8aZOH5ivgv1TzklD12j76h7oUCqXZGtBp62LkxdT
         H7IKzaZeeztIrILMYCj8X0uAnh1BkYP9P3VV2ZWZ5I/E2a2/R3A/RyLvK/XCeFNyhEEZ
         3ulX5UdNN7gn6islKr+s0fczUjFZmUhvvnEyWbNBUyr9d3JZEJ3788QVBohVaLZMnXhl
         jSYLvlb8sn9uM+xkb9mrNQpSf1WGodXooi9vN1JhcgnqycVZBnYk94G3f0bLi+7c+dPa
         Tq5g==
X-Gm-Message-State: ACrzQf0zQUXxuhLxm7XCmfZP144ko6hW7VL1l2L1dnGdt/HFGr7Ihwlp
        G9/ZlgAykFUqj5+fZp+Vw3jbKhHlywAPyCkb5jqaCQ==
X-Google-Smtp-Source: AMsMyM7Y+TBfO97EW9jrKBG5hEgn4YXnvT3+j0xrcWNSiGbalXdTlJ0tJc4JEVLAjICZAPJtpJMuo+33y2B4Z91ScrQ=
X-Received: by 2002:a05:6e02:164c:b0:2fc:7179:bc41 with SMTP id
 v12-20020a056e02164c00b002fc7179bc41mr3180933ilu.190.1665937541112; Sun, 16
 Oct 2022 09:25:41 -0700 (PDT)
MIME-Version: 1.0
References: <20221016162305.2489629-1-joel@joelfernandes.org> <20221016162305.2489629-2-joel@joelfernandes.org>
In-Reply-To: <20221016162305.2489629-2-joel@joelfernandes.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sun, 16 Oct 2022 12:25:32 -0400
Message-ID: <CAEXW_YTqgs__LBdyho4ZNuMbmY01KmH-8k_2j87qPS6kx1i8FA@mail.gmail.com>
Subject: Re: [PATCH v9 01/13] rcu: Fix missing nocb gp wake on rcu_barrier()
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, frederic@kernel.org,
        paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 16, 2022 at 12:23 PM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> From: Frederic Weisbecker <frederic@kernel.org>
>
> In preparation of RCU lazy changes, wake up the RCU nocb gp thread if
> needed after an entrain. Otherwise, the RCU barrier callback can wait in
> the queue for several seconds before the lazy callbacks in front of it
> are serviced.
>
> Reported-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Change-Id: I830269cd41b18862a1a58b26ce3292c6c4457bc7

Ah, sorry for the Change-id Paul! If you don't mind, please edit this
out from the change log for this and the next patch (it is only in
these 2!)

 - Joel


> ---
>  kernel/rcu/tree.c      | 11 +++++++++++
>  kernel/rcu/tree.h      |  1 +
>  kernel/rcu/tree_nocb.h |  5 +++++
>  3 files changed, 17 insertions(+)
>
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 5ec97e3f7468..67a1ae5151f5 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3894,6 +3894,8 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
>  {
>         unsigned long gseq = READ_ONCE(rcu_state.barrier_sequence);
>         unsigned long lseq = READ_ONCE(rdp->barrier_seq_snap);
> +       bool wake_nocb = false;
> +       bool was_alldone = false;
>
>         lockdep_assert_held(&rcu_state.barrier_lock);
>         if (rcu_seq_state(lseq) || !rcu_seq_state(gseq) || rcu_seq_ctr(lseq) != rcu_seq_ctr(gseq))
> @@ -3902,7 +3904,14 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
>         rdp->barrier_head.func = rcu_barrier_callback;
>         debug_rcu_head_queue(&rdp->barrier_head);
>         rcu_nocb_lock(rdp);
> +       /*
> +        * Flush bypass and wakeup rcuog if we add callbacks to an empty regular
> +        * queue. This way we don't wait for bypass timer that can reach seconds
> +        * if it's fully lazy.
> +        */
> +       was_alldone = rcu_rdp_is_offloaded(rdp) && !rcu_segcblist_pend_cbs(&rdp->cblist);
>         WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies));
> +       wake_nocb = was_alldone && rcu_segcblist_pend_cbs(&rdp->cblist);
>         if (rcu_segcblist_entrain(&rdp->cblist, &rdp->barrier_head)) {
>                 atomic_inc(&rcu_state.barrier_cpu_count);
>         } else {
> @@ -3910,6 +3919,8 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
>                 rcu_barrier_trace(TPS("IRQNQ"), -1, rcu_state.barrier_sequence);
>         }
>         rcu_nocb_unlock(rdp);
> +       if (wake_nocb)
> +               wake_nocb_gp(rdp, false);
>         smp_store_release(&rdp->barrier_seq_snap, gseq);
>  }
>
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index d4a97e40ea9c..925dd98f8b23 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -439,6 +439,7 @@ static void zero_cpu_stall_ticks(struct rcu_data *rdp);
>  static struct swait_queue_head *rcu_nocb_gp_get(struct rcu_node *rnp);
>  static void rcu_nocb_gp_cleanup(struct swait_queue_head *sq);
>  static void rcu_init_one_nocb(struct rcu_node *rnp);
> +static bool wake_nocb_gp(struct rcu_data *rdp, bool force);
>  static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
>                                   unsigned long j);
>  static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index f77a6d7e1356..094fd454b6c3 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -1558,6 +1558,11 @@ static void rcu_init_one_nocb(struct rcu_node *rnp)
>  {
>  }
>
> +static bool wake_nocb_gp(struct rcu_data *rdp, bool force)
> +{
> +       return false;
> +}
> +
>  static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
>                                   unsigned long j)
>  {
> --
> 2.38.0.413.g74048e4d9e-goog
>
