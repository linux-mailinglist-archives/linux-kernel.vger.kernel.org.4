Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C4564CDAF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 17:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238641AbiLNQHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 11:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238460AbiLNQHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 11:07:32 -0500
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2503F30;
        Wed, 14 Dec 2022 08:07:31 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-3b10392c064so3674527b3.0;
        Wed, 14 Dec 2022 08:07:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bNPYOl0nk3HHh4COLE6JtJRUE8GJlPrM/TAjh0/IX1o=;
        b=nC0VqB8Lx5cz/f7fcU4kAnuTdLu/EL5uUbrEi2TySGuxTL6QvrD7IUM8ZQ3JwWNr6O
         fiwo3pVXxS8Zy8+p8gOFgJQm2zt4+D4Ki0C4NKSToTRKThC+8+ql7Xqy76fK9uvxznfB
         Q33L40XCn52lRlB0JtJod2ZsHyY8uUemG210eO4y+Rz4FojSiKhWfdtZBWQ7Ug1isLM4
         3Ww8g4rKGDv2qCRmIiVzG7QTsp2eZMMlVI/mSXkvRfjcmrBiWibDG3fsxL+enJ/ZYgz7
         DyMboKzKCcJ213yLIDOAQjo4a0wVhx1uRAXuRqs+yR5AkJbJT71skJfD917GPDJSoJ/Q
         YVZg==
X-Gm-Message-State: ANoB5pmRS0Ip9IXPN9KXPVpbtLGm0W8FHvIPXOnvZi5nI7uP4XETq4qg
        jJb6bvY8vidWz8CUJowHpF4=
X-Google-Smtp-Source: AA0mqf5PPKdpCCVd2dt1Wd58E4OVKCgMgrMiNCd2OIhoJc6dwu5xU6x6ObGCMyJET4rEpRrOJ6T2+w==
X-Received: by 2002:a05:7500:5690:b0:ec:6821:d1f5 with SMTP id ca16-20020a057500569000b000ec6821d1f5mr2059283gab.34.1671034050747;
        Wed, 14 Dec 2022 08:07:30 -0800 (PST)
Received: from fedora ([216.211.255.155])
        by smtp.gmail.com with ESMTPSA id bl14-20020a05620a1a8e00b006faa2c0100bsm10189901qkb.110.2022.12.14.08.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 08:07:30 -0800 (PST)
Date:   Wed, 14 Dec 2022 08:07:28 -0800
From:   Dennis Zhou <dennis@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Hillf Danton <hdanton@sina.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zhong Jinghua <zhongjinghua@huawei.com>
Subject: Re: [PATCH 3/3] lib/percpu-refcount: drain ->release() in
 perpcu_ref_exit()
Message-ID: <Y5n0wBarpw7IEQX4@fedora>
References: <20221214025101.1268437-1-ming.lei@redhat.com>
 <20221214081651.954-1-hdanton@sina.com>
 <Y5nP4JC00zTepHue@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5nP4JC00zTepHue@T590>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Dec 14, 2022 at 09:30:08PM +0800, Ming Lei wrote:
> On Wed, Dec 14, 2022 at 04:16:51PM +0800, Hillf Danton wrote:
> > On 14 Dec 2022 10:51:01 +0800 Ming Lei <ming.lei@redhat.com>
> > > The pattern of wait_event(percpu_ref_is_zero()) has been used in several
> > 
> > For example?
> 
> blk_mq_freeze_queue_wait() and target_wait_for_sess_cmds().
> 
> > 
> > > kernel components, and this way actually has the following risk:
> > > 
> > > - percpu_ref_is_zero() can be returned just between
> > >   atomic_long_sub_and_test() and ref->data->release(ref)
> > > 
> > > - given the refcount is found as zero, percpu_ref_exit() could
> > >   be called, and the host data structure is freed
> > > 
> > > - then use-after-free is triggered in ->release() when the user host
> > >   data structure is freed after percpu_ref_exit() returns
> > 
> > The race between exit and the release callback should be considered at the
> > corresponding callsite, given the comment below, and closed for instance
> > by synchronizing rcu.
> > 
> > /**
> >  * percpu_ref_put_many - decrement a percpu refcount
> >  * @ref: percpu_ref to put
> >  * @nr: number of references to put
> >  *
> >  * Decrement the refcount, and if 0, call the release function (which was passed
> >  * to percpu_ref_init())
> >  *
> >  * This function is safe to call as long as @ref is between init and exit.
> >  */
> 
> Not sure if the above comment implies that the callsite should cover the
> race.
> 
> But blk-mq can really avoid the trouble by using the existed call_rcu():
> 

I struggle with the dependency on release(). release() itself should not
block, but a common pattern would be to through a call_rcu() in and
schedule additional work - see block/blk-cgroup.c, blkg_release().

I think the dependency really is the completion of release() and the
work scheduled on it's behalf rather than strictly starting the
release() callback. This series doesn't preclude that from happening.

/**
 * percpu_ref_exit - undo percpu_ref_init()
 * @ref: percpu_ref to exit
 *
 * This function exits @ref.  The caller is responsible for ensuring that
 * @ref is no longer in active use.  The usual places to invoke this
 * function from are the @ref->release() callback or in init failure path
 * where percpu_ref_init() succeeded but other parts of the initialization
 * of the embedding object failed.
 */

I think the percpu_ref_exit() comment explains the more common use case
approach to percpu refcounts. release() triggering percpu_ref_exit() is
the ideal case.

Thanks,
Dennis

> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 3866b6c4cd88..9321767470dc 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -254,14 +254,15 @@ EXPORT_SYMBOL_GPL(blk_clear_pm_only);
>  
>  static void blk_free_queue_rcu(struct rcu_head *rcu_head)
>  {
> -	kmem_cache_free(blk_requestq_cachep,
> -			container_of(rcu_head, struct request_queue, rcu_head));
> +	struct request_queue *q = container_of(rcu_head,
> +			struct request_queue, rcu_head);
> +
> +	percpu_ref_exit(&q->q_usage_counter);
> +	kmem_cache_free(blk_requestq_cachep, q);
>  }
>  
>  static void blk_free_queue(struct request_queue *q)
>  {
> -	percpu_ref_exit(&q->q_usage_counter);
> -
>  	if (q->poll_stat)
>  		blk_stat_remove_callback(q, q->poll_cb);
>  	blk_stat_free_callback(q->poll_cb);
> 
> 
> Thanks, 
> Ming
> 
