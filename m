Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB969634497
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 20:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbiKVTbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 14:31:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234787AbiKVTbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 14:31:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530DF9150A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 11:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669145404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=i56PR02jE2EWUlpNGIk/oRna4HWRmge9xI1GU0olD7A=;
        b=Ub75uuJi7t2fCuL7+OCvICSdyCXVV33RDz6r+BqN3sd+NrZMgSEprQ25Tp1CzZ1Ps2xZrX
        EFfgNVYF+zI5KlE9jXbnIdbZHdAZsCw9vvI+ck5BbF402LBXOKKy7pQCK9ffWfa8RvK33f
        5ruvOiM51GeJskD5qwy0ce53vcyzmwE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-140-Wc_KOc-TMfaAasY56W91Qg-1; Tue, 22 Nov 2022 14:30:03 -0500
X-MC-Unique: Wc_KOc-TMfaAasY56W91Qg-1
Received: by mail-wm1-f69.google.com with SMTP id v125-20020a1cac83000000b003cfa148576dso8519582wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 11:30:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i56PR02jE2EWUlpNGIk/oRna4HWRmge9xI1GU0olD7A=;
        b=MiZOZuxyFkVeo9jek1kACM7yzbYKe9l4ZEaqclLvFRKEruT6MrYU1ZwVYwWUBMyESQ
         laix60VkFsQQUbz9PXiCjJP05Kdw2pffhDnLmpWgIujkrWcIs46sPjD1bCUSDH2fEjHB
         IqnY+bpdZ7aYSjgnfVkBFr49d4V4trVS1bEROnANEnpWDajZwPaM4RJHF9wXVH04spX8
         UKd7oTVQ1zcSS31W7UdZC/SSILF+6n5t7WhmnmvZjtbpRTt8ZvTg+spxWGQrErixuE/2
         GHapEpHm4gf7zn/kfiWOHRI6c8ZLz+wvW28Qb25oJSKvp4VsUFPv0sUOUyLMhuaS9xgo
         I3dw==
X-Gm-Message-State: ANoB5pmf/utRq2DV5GzL+8++fPj5+xwu0jMJGHL6Eb4kT2G+cx0oWWoT
        oLuOOn/QK8o6nb/sjunfi4A4PURe6AnnhBLrEyhh7O9XjfawWoPxqeIrwIUJpLbKUD6I1Zrq5Ur
        2UV2ui8AvT3RxwNtQI96KTA632XelKBStnTpQLRwZkiEQQvZhPFkMDEjPAA1eVYsw1okj30IaJ2
        mH
X-Received: by 2002:a05:600c:1e12:b0:3cf:9ad3:a20e with SMTP id ay18-20020a05600c1e1200b003cf9ad3a20emr6319801wmb.151.1669145401869;
        Tue, 22 Nov 2022 11:30:01 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7H55ukeD8W4vEMG+tcsgiL0S4YcBa9kMbUf0lKFnmv1zb7RhVghpWe22JOgaV9yh5WOd/W2w==
X-Received: by 2002:a05:600c:1e12:b0:3cf:9ad3:a20e with SMTP id ay18-20020a05600c1e1200b003cf9ad3a20emr6319778wmb.151.1669145401634;
        Tue, 22 Nov 2022 11:30:01 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id r14-20020adff10e000000b002366553eca7sm4173682wro.83.2022.11.22.11.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 11:30:01 -0800 (PST)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH v5 0/5] workqueue: destroy_worker() vs isolated CPUs
Date:   Tue, 22 Nov 2022 19:29:32 +0000
Message-Id: <20221122192937.2386494-1-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

That's v5 (hopefully) addressing Tejun's comments, cf.
  https://lore.kernel.org/lkml/20221004150521.822266-1-vschneid@redhat.com/

Revisions
=========

v4 -> v5
++++++++

o Rebase onto v6.1-rc6

o Overall renaming from "reaping" to "cull"
  I somehow convinced myself this was more appropriate
  
o Split the dwork into timer callback + work item (Tejun)

  I didn't want to have redudant operations happen in the timer callback and in
  the work item, so I made the timer callback detect which workers are "ripe"
  enough and then toss them to a worker for removal.

  This however means we release the pool->lock before getting to actually doing
  anything to those idle workers, which means they can wake up in the meantime.
  The new worker_pool.idle_cull_list is there for that reason.

  The alternative was to have the timer callback detect if any worker was ripe
  enough, kick the work item if so, and have the work item do the same thing
  again, which I didn't like.

RFCv3 -> v4
+++++++++++

o Rebase onto v6.0
o Split into more patches for reviewability
o Take dying workers out of the pool->workers as suggested by Lai

RFCv2 -> RFCv3
++++++++++++++

o Rebase onto v5.19
o Add new patch (1/3) around accessing wq_unbound_cpumask

o Prevent WORKER_DIE workers for kfree()'ing themselves before the idle reaper
  gets to handle them (Tejun)

  Bit of an aside on that: I've been struggling to convince myself this can
  happen due to spurious wakeups and would like some help here.

  Idle workers are TASK_UNINTERRUPTIBLE, so they can't be woken up by
  signals. That state is set *under* pool->lock, and all wakeups (before this
  patch) are also done while holding pool->lock.
  
  wake_up_worker() is done under pool->lock AND only wakes a worker on the
  pool->idle_list. Thus the to-be-woken worker *cannot* have WORKER_DIE, though
  it could gain it *after* being woken but *before* it runs, e.g.:
                          
  LOCK pool->lock
  wake_up_worker(pool)
      wake_up_process(p)
  UNLOCK pool->lock
                          idle_reaper_fn()
                            LOCK pool->lock
                            destroy_worker(worker, list);
			    UNLOCK pool->lock
			                            worker_thread()
						      goto woke_up;
                                                      LOCK pool->lock
						      READ worker->flags & WORKER_DIE
                                                          UNLOCK pool->lock
                                                          ...
						          kfree(worker);
                            reap_worker(worker);
			        // Uh-oh
			  
  ... But IMO that's not a spurious wakeup, that's a concurrency issue. I don't
  see any spurious/unexpected worker wakeup happening once a worker is off the
  pool->idle_list.
  

RFCv1 -> RFCv2
++++++++++++++

o Change the pool->timer into a delayed_work to have a sleepable context for
  unbinding kworkers

Cheers,
Valentin

Lai Jiangshan (1):
  workqueue: Protects wq_unbound_cpumask with wq_pool_attach_mutex

Valentin Schneider (4):
  workqueue: Factorize unbind/rebind_workers() logic
  workqueue: Make too_many_workers() return the worker excess
  workqueue: Convert the idle_timer to a timer + work_struct
  workqueue: Unbind kworkers before sending them to exit()

 kernel/workqueue.c | 224 +++++++++++++++++++++++++++++++++------------
 1 file changed, 168 insertions(+), 56 deletions(-)

--
2.31.1

