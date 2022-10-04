Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9BB5F4622
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 17:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiJDPGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 11:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiJDPGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 11:06:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE325A3DF
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 08:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664895962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=X7rj0Zc4usQorUfBw1daWC9I8GVQiUZ2Q5oxzBkpoSM=;
        b=ORvwNExtqmhfC3Tr6um8F4oedMWoVDaV1seec+YbSHMLDnY3K+WqcrGyJauWq1yzUnEjZc
        iVqsRdgDIqYKu7JBtlxwOB1rK3kX82vFVir4UBH8ZMANqmsg26xoAAQJPaauoJQC5BFk0n
        ZP0w1lzuylwMhP380PDV3PpbmRpD+UQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-612-MroT0sopPzynombKLWQMsA-1; Tue, 04 Oct 2022 11:06:01 -0400
X-MC-Unique: MroT0sopPzynombKLWQMsA-1
Received: by mail-wm1-f71.google.com with SMTP id ay21-20020a05600c1e1500b003b45fd14b53so463822wmb.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 08:06:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=X7rj0Zc4usQorUfBw1daWC9I8GVQiUZ2Q5oxzBkpoSM=;
        b=wfeERrBhshwSYQc1qmnVsYtSsLx0IJ1jX852rqK/ZsDNZk7sWAKLICmG57QVNlESjv
         +wwP1IJPe3z767jS4AmzrjRafywxOQDNnLwFA+mYU/vU4jRIdXABQVCJ+epkoMmObv2f
         zelCEBnLdpzdgvLT6jLQ/5DhmgHCs3w9lASeV/GLgB+h3LYAfL1DVsdrjq0E4eJC8Yw5
         pyvFA4Wp5rzxYrNcTH7bccNe/kmpcRyTXFoMSWqU3ipRjqGmGOKp25sLh+4DABBxXFhe
         EYVZdXKRSThmeL8H5ToB3sdbZM3Mo3tfivdZ7aATnDJL/DmXEfVMhdmS+52r6lAJS2G/
         0ULQ==
X-Gm-Message-State: ACrzQf2RNly6t1wEzoJy3la5cIDELmHgmhSg+Cm37cYsZaCCYa69uBXb
        sd4AtkSj4kQleuhwBVoiFfRlUJEY2nnerjUPIzb5ZFmvMopSOsLpw8/y76QwvioH/5EpnPAiuIw
        /O2u8Zz3mp0jvwpMq+GRPK+jKwu2DklkR3j+x33O41o+sAyk5paWj6sgnD6PZAf2t7NU0cARMLG
        pV
X-Received: by 2002:a5d:4342:0:b0:22c:9161:7776 with SMTP id u2-20020a5d4342000000b0022c91617776mr15686155wrr.228.1664895959117;
        Tue, 04 Oct 2022 08:05:59 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4RFMuNA+0/qdhKca+57Bt+L5+zBM+VWMyYEp159QXTmjLvmNtyg5W5hWfikTGIh1yuIfr0aA==
X-Received: by 2002:a5d:4342:0:b0:22c:9161:7776 with SMTP id u2-20020a5d4342000000b0022c91617776mr15686127wrr.228.1664895958793;
        Tue, 04 Oct 2022 08:05:58 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
        by smtp.gmail.com with ESMTPSA id w10-20020a05600c474a00b003b4ac05a8a4sm25777717wmo.27.2022.10.04.08.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 08:05:57 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH v4 0/4] workqueue: destroy_worker() vs isolated CPUs
Date:   Tue,  4 Oct 2022 16:05:17 +0100
Message-Id: <20221004150521.822266-1-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I haven't sent an update for this in a while, but the issue has risen again in
some other environment so I'm getting more reasons to push this out.

Revisions
=========

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

Valentin Schneider (3):
  workqueue: Factorize unbind/rebind_workers() logic
  workqueue: Convert the idle_timer to a delayed_work
  workqueue: Unbind workers before sending them to exit()

 kernel/workqueue.c | 195 +++++++++++++++++++++++++++++++--------------
 1 file changed, 136 insertions(+), 59 deletions(-)

--
2.31.1

