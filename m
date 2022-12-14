Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8963664CB53
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 14:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238244AbiLNNbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 08:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238126AbiLNNbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 08:31:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C4E248FE
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 05:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671024621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p5nDSovtGcMOmECeVBK2QeZhfWdznopYC9ScdOLMtVw=;
        b=Ro3mMm7YnH7Ptu+BItXyzI49B5S1yb5yruA2AT2RqtdChW47xPMMe1FXHYoztKLu3R7x/D
        8RMBzivkE9mzL4q+AcL1cXs1HAgo0j0vuGK1lSq+eGsak7dImg+H+b4b4bCrXm7cTj/POf
        d8Hl03T5R76eNBeS6n+k4UBthoqVLNg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-381-SkU2T6obNHq0jzOTvgDD4g-1; Wed, 14 Dec 2022 08:30:17 -0500
X-MC-Unique: SkU2T6obNHq0jzOTvgDD4g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 74DA9101A52E;
        Wed, 14 Dec 2022 13:30:17 +0000 (UTC)
Received: from T590 (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C956514171C0;
        Wed, 14 Dec 2022 13:30:13 +0000 (UTC)
Date:   Wed, 14 Dec 2022 21:30:08 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhong Jinghua <zhongjinghua@huawei.com>,
        Dennis Zhou <dennis@kernel.org>
Subject: Re: [PATCH 3/3] lib/percpu-refcount: drain ->release() in
 perpcu_ref_exit()
Message-ID: <Y5nP4JC00zTepHue@T590>
References: <20221214025101.1268437-1-ming.lei@redhat.com>
 <20221214081651.954-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221214081651.954-1-hdanton@sina.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 04:16:51PM +0800, Hillf Danton wrote:
> On 14 Dec 2022 10:51:01 +0800 Ming Lei <ming.lei@redhat.com>
> > The pattern of wait_event(percpu_ref_is_zero()) has been used in several
> 
> For example?

blk_mq_freeze_queue_wait() and target_wait_for_sess_cmds().

> 
> > kernel components, and this way actually has the following risk:
> > 
> > - percpu_ref_is_zero() can be returned just between
> >   atomic_long_sub_and_test() and ref->data->release(ref)
> > 
> > - given the refcount is found as zero, percpu_ref_exit() could
> >   be called, and the host data structure is freed
> > 
> > - then use-after-free is triggered in ->release() when the user host
> >   data structure is freed after percpu_ref_exit() returns
> 
> The race between exit and the release callback should be considered at the
> corresponding callsite, given the comment below, and closed for instance
> by synchronizing rcu.
> 
> /**
>  * percpu_ref_put_many - decrement a percpu refcount
>  * @ref: percpu_ref to put
>  * @nr: number of references to put
>  *
>  * Decrement the refcount, and if 0, call the release function (which was passed
>  * to percpu_ref_init())
>  *
>  * This function is safe to call as long as @ref is between init and exit.
>  */

Not sure if the above comment implies that the callsite should cover the
race.

But blk-mq can really avoid the trouble by using the existed call_rcu():


diff --git a/block/blk-core.c b/block/blk-core.c
index 3866b6c4cd88..9321767470dc 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -254,14 +254,15 @@ EXPORT_SYMBOL_GPL(blk_clear_pm_only);
 
 static void blk_free_queue_rcu(struct rcu_head *rcu_head)
 {
-	kmem_cache_free(blk_requestq_cachep,
-			container_of(rcu_head, struct request_queue, rcu_head));
+	struct request_queue *q = container_of(rcu_head,
+			struct request_queue, rcu_head);
+
+	percpu_ref_exit(&q->q_usage_counter);
+	kmem_cache_free(blk_requestq_cachep, q);
 }
 
 static void blk_free_queue(struct request_queue *q)
 {
-	percpu_ref_exit(&q->q_usage_counter);
-
 	if (q->poll_stat)
 		blk_stat_remove_callback(q, q->poll_cb);
 	blk_stat_free_callback(q->poll_cb);


Thanks, 
Ming

