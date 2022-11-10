Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEF66242DC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 14:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiKJNGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 08:06:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbiKJNF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 08:05:59 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1038F725CC;
        Thu, 10 Nov 2022 05:05:58 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id p8so3067574lfu.11;
        Thu, 10 Nov 2022 05:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gXSsQ43cxptIUGrnVbHJLQbqSy0z5WlgGe/E7rMDumo=;
        b=GTADl5+ADYwPS3Z/F0wEmSZ5vBiBHx81HK2pdsyCIMsXocLkAg9wbZCNW0HVLROxzr
         bjSQZsb+TniODMbCynU2wQePWOkoy+vXUzs2uy5Mh5fWviUPHAzNkW+2E9GRlrKfl6h0
         +TQZt+yUb6go4BGpZwjHTpcqa8cpSBak5xZm4oKoWoo8cIw4Ayf8eAa4DOP+x7aIHt/a
         f4OhrXKLHA5mI2bk2xANHeT1tQHJFnjDH2caql6s2JQTUoSZlzQVf7PlPHCSf8SqbCMP
         yhpU7MVmsnvW2iIY0A+jyeH8tSOeAQ+D5ZDS2ZaZFmFs4FALm/qXWRJTpU/xFZcCP2zF
         8vDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gXSsQ43cxptIUGrnVbHJLQbqSy0z5WlgGe/E7rMDumo=;
        b=VwcjP72CiHTIKpyhtlE0yHLt5DxfE0ZBvOuv8q6ReREAf8Wnj/s+JJWlYlRyhxgP/t
         s/jgz91CtlXas3H+9HRrz16gmaNmMohx+VXbYmxKpHryi9MoqkVuyDMVhDlmuBLmcg/y
         sQKuYU4WaeGBTE+WGrY8JYpZ5OYdWQ4AmuD9zMldi+XGuhK/t6o3fA/vgl2gUddJw5Ap
         xlcejA4iSkDDUf6n+///0vsxpZGH+Bniz4EpdgtlCxi4fHQBgz2IpUzz4rDldT+1U8dt
         TXi6R77D98qI6pYh0esOL6sPhHN+7aiDII8qLeb1FsXhbYr01NIVouQGDrhKgO3/pfUw
         rQcw==
X-Gm-Message-State: ANoB5pmrC0ZO6dqo+eGLtN6ujS2i3MZhITjRrqcI4d2yZdH3yfnVKcSC
        QmsBcfLFcMj9mvOY7R7/YbM=
X-Google-Smtp-Source: AA0mqf62YWagAoYYXmqkjGcdev1AuYkfO2TQZlg7+FFf18TqalLgsqP+/ekBILmQbqV6u5viwUB5fg==
X-Received: by 2002:ac2:4d91:0:b0:4b4:1208:4b2 with SMTP id g17-20020ac24d91000000b004b4120804b2mr1034514lfe.536.1668085556157;
        Thu, 10 Nov 2022 05:05:56 -0800 (PST)
Received: from pc636 (host-90-235-24-194.mobileonline.telia.com. [90.235.24.194])
        by smtp.gmail.com with ESMTPSA id p3-20020a2e7403000000b002770e6c620bsm2584457ljc.106.2022.11.10.05.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 05:05:55 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 10 Nov 2022 14:05:53 +0100
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        paulmck@kernel.org, urezki@gmail.com
Subject: Re: [PATCH v2] rcu/kfree: Do not request RCU when not needed
Message-ID: <Y2z3Mb3u8bFZ12wY@pc636>
References: <20221109024758.2644936-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109024758.2644936-1-joel@joelfernandes.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On ChromeOS, using this with the increased timeout, we see that we almost always
> never need to initiate a new grace period. Testing also shows this frees large
> amounts of unreclaimed memory, under intense kfree_rcu() pressure.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
> v1->v2: Same logic but use polled grace periods instead of sampling gp_seq.
> 
>  kernel/rcu/tree.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 591187b6352e..ed41243f7a49 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2935,6 +2935,7 @@ struct kfree_rcu_cpu_work {
>  
>  /**
>   * struct kfree_rcu_cpu - batch up kfree_rcu() requests for RCU grace period
> + * @gp_snap: The GP snapshot recorded at the last scheduling of monitor work.
>   * @head: List of kfree_rcu() objects not yet waiting for a grace period
>   * @bkvhead: Bulk-List of kvfree_rcu() objects not yet waiting for a grace period
>   * @krw_arr: Array of batches of kfree_rcu() objects waiting for a grace period
> @@ -2964,6 +2965,7 @@ struct kfree_rcu_cpu {
>  	struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
>  	raw_spinlock_t lock;
>  	struct delayed_work monitor_work;
> +	unsigned long gp_snap;
>  	bool initialized;
>  	int count;
>  
> @@ -3167,6 +3169,7 @@ schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
>  			mod_delayed_work(system_wq, &krcp->monitor_work, delay);
>  		return;
>  	}
> +	krcp->gp_snap = get_state_synchronize_rcu();
>  	queue_delayed_work(system_wq, &krcp->monitor_work, delay);
>  }
>
How do you guarantee a full grace period for objects which proceed
to be placed into an input stream that is not yet detached?

>  
> @@ -3217,7 +3220,10 @@ static void kfree_rcu_monitor(struct work_struct *work)
>  			// be that the work is in the pending state when
>  			// channels have been detached following by each
>  			// other.
> -			queue_rcu_work(system_wq, &krwp->rcu_work);
> +			if (poll_state_synchronize_rcu(krcp->gp_snap))
> +				queue_work(system_wq, &krwp->rcu_work.work);
> +			else
> +				queue_rcu_work(system_wq, &krwp->rcu_work);
>  		}
>
Why do you want to queue a work over RCU-core?

1.
call_rcu()
   -> queue_work();
      -> do reclaim

if it can be improved and simplified as:

2.
queue_work();
    -> cond_synchronize_rcu(), do reclaim

Could you please clarify it?

--
Uladzislau Rezki
