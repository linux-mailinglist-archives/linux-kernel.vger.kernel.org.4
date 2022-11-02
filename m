Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFFA616848
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbiKBQTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiKBQSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:18:52 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27C52FC19
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 09:13:47 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id q9so46713690ejd.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 09:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b6gbNYNfIsALN3TjdDSV5jJLEHJldoUtUzuXbSsMCMY=;
        b=ACYlQeQSzbVN1EazD9bw3Y5Kws7ZhUTuBtLzoUrsC9fSjBQpPF26oNHqqlN+1kggNP
         WeeMTPTjFcqcS2iK5Y3LWoWaGi156QBjbbqlAJAxG5rL9GejixGvz3c3TqRfUBTXmcj3
         D5GDJAlOLRSWfN34ZuQdHvR90MplJQlHYyGm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b6gbNYNfIsALN3TjdDSV5jJLEHJldoUtUzuXbSsMCMY=;
        b=vJ+8O6PLmWBXUakJkTv+B5lPFB2yuWtGsAzrVLdBoxF1x40/F6nFmdBrrnXLJzToui
         Qz6VjOVO3VqN2HG00XhdJ2YHkAxiKdryhf8Ojs5VqVqzGY/kv5JaWeTIOI5MC0qH+yJk
         0vffu8RSZ/49Zlw+OMXAdAmwXO+q6D2tf0NMXaFsXFw9LmVW4+on5iidG5Uv3xXi4P+O
         fpWeoLodXpz/33IPn2yTsXr28YEmG+JvUDXqGf/krKwQIQuvjjEvru5gJZt//+PHZvXV
         q9Mn8o0z0+MEaseh/Y17fdWW0nbY+N1nYHto7cchdfjyviuJdYUmHxV0Aw7+ssARLmLu
         lBag==
X-Gm-Message-State: ACrzQf0qFSZbz+fR/meQUoaxrtZn0EsIDjm9FSxDlf1g0xQ7Su+rJ69o
        1Mh2+ajnxXxXqSGgpeoyGV6mtDwMGmFRTgleDR8CS2ucMto=
X-Google-Smtp-Source: AMsMyM749O/8FjBsJYB8SAD3uXBZ7c3qZcIlJgPJbUwIMHy9hdq7NbguXBwVL/8Oqx/CAdXS3484nQHy+n4h7GLk2Uw=
X-Received: by 2002:a17:906:d550:b0:7ad:d367:fabb with SMTP id
 cr16-20020a170906d55000b007add367fabbmr16392750ejc.285.1667405609634; Wed, 02
 Nov 2022 09:13:29 -0700 (PDT)
MIME-Version: 1.0
References: <20221029132856.3752018-1-joel@joelfernandes.org> <Y2JkoVV3jaVS4y0Q@pc636>
In-Reply-To: <Y2JkoVV3jaVS4y0Q@pc636>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 2 Nov 2022 12:13:17 -0400
Message-ID: <CAEXW_YRZO086TUJCFzuGpAWRpQ-uKD1S5wDipJ9hR9=XddNFSw@mail.gmail.com>
Subject: Re: [PATCH RFC] rcu/kfree: Do not request RCU when not needed
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 2, 2022 at 8:37 AM Uladzislau Rezki <urezki@gmail.com> wrote:
>
> On Sat, Oct 29, 2022 at 01:28:56PM +0000, Joel Fernandes (Google) wrote:
> > On ChromeOS, I am (almost) always seeing the optimization trigger.
> > Tested boot up and trace_printk'ing how often it triggers.
> >
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  kernel/rcu/tree.c | 18 +++++++++++++++++-
> >  1 file changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 591187b6352e..3e4c50b9fd33 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -2935,6 +2935,7 @@ struct kfree_rcu_cpu_work {
> >
> >  /**
> >   * struct kfree_rcu_cpu - batch up kfree_rcu() requests for RCU grace period
> > + * @rdp: The rdp of the CPU that this kfree_rcu corresponds to.
> >   * @head: List of kfree_rcu() objects not yet waiting for a grace period
> >   * @bkvhead: Bulk-List of kvfree_rcu() objects not yet waiting for a grace period
> >   * @krw_arr: Array of batches of kfree_rcu() objects waiting for a grace period
> > @@ -2964,6 +2965,8 @@ struct kfree_rcu_cpu {
> >       struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
> >       raw_spinlock_t lock;
> >       struct delayed_work monitor_work;
> > +     struct rcu_data *rdp;
> > +     unsigned long last_gp_seq;
> >       bool initialized;
> >       int count;
> >
> > @@ -3167,6 +3170,7 @@ schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
> >                       mod_delayed_work(system_wq, &krcp->monitor_work, delay);
> >               return;
> >       }
> > +     krcp->last_gp_seq = krcp->rdp->gp_seq;
> >       queue_delayed_work(system_wq, &krcp->monitor_work, delay);
> >  }
> >
> > @@ -3217,7 +3221,17 @@ static void kfree_rcu_monitor(struct work_struct *work)
> >                       // be that the work is in the pending state when
> >                       // channels have been detached following by each
> >                       // other.
> > -                     queue_rcu_work(system_wq, &krwp->rcu_work);
> > +                     //
> > +                     // NOTE about gp_seq wrap: In case of gp_seq overflow,
> > +                     // it is possible for rdp->gp_seq to be less than
> > +                     // krcp->last_gp_seq even though a GP might be over. In
> > +                     // this rare case, we would just have one extra GP.
> > +                     if (krcp->last_gp_seq &&
> >
> This check can be eliminated i think. A kfree_rcu_cpu is defined as
> static so by default the last_gp_set is set to zero.

Ack.

> > @@ -4802,6 +4816,8 @@ static void __init kfree_rcu_batch_init(void)
> >       for_each_possible_cpu(cpu) {
> >               struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
> >
> > +             krcp->rdp = per_cpu_ptr(&rcu_data, cpu);
> > +             krcp->last_gp_seq = 0;
> >
> Yep. This one can be just dropped.
>
> But all the rest looks good :) I will give it a try from test point of
> view. It is interested from the memory footprint point of view.

Ack. Thanks. Even though we should not sample rdp->gp_seq, I think it
is still worth a test.
