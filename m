Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0A3686F52
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 20:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbjBATx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 14:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbjBATxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 14:53:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3218016D
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 11:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675281155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=sTvWe2kfUoGBfAaCSxydSPRezZXDlplO8iSUUltKQvQ=;
        b=iSdWvokJmoXkJby0gG/mw1MytJVEeyFGVY7nZMzL/kjtdy6bWimpDHHur4Ub119Z7LJpPB
        XjM9eOPGAkPOBeAIQ8l829vPi/DXIvqHBuX5UAQ5sqftPU2aaJ4OFkg2UepIn2VpNXg9HR
        lvWu2/yf+uYBcs90oCPtXiAbpqV/u74=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-664-FlzSg14TO-WC0NOa6ALVgw-1; Wed, 01 Feb 2023 14:52:30 -0500
X-MC-Unique: FlzSg14TO-WC0NOa6ALVgw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4975A2806051;
        Wed,  1 Feb 2023 19:52:30 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F40FD492B06;
        Wed,  1 Feb 2023 19:52:29 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 0A274403C1B83; Wed,  1 Feb 2023 16:51:49 -0300 (-03)
Message-ID: <20230201195013.881721887@redhat.com>
User-Agent: quilt/0.67
Date:   Wed, 01 Feb 2023 16:50:13 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Christoph Lameter <cl@linux.com>
Cc:     Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 0/5] fold per-CPU vmstats remotely
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series addresses the following two problems:

    1. A customer provided some evidence which indicates that
       the idle tick was stopped; albeit, CPU-specific vmstat
       counters still remained populated.

       Thus one can only assume quiet_vmstat() was not
       invoked on return to the idle loop. If I understand
       correctly, I suspect this divergence might erroneously
       prevent a reclaim attempt by kswapd. If the number of
       zone specific free pages are below their per-cpu drift
       value then zone_page_state_snapshot() is used to
       compute a more accurate view of the aforementioned
       statistic.  Thus any task blocked on the NUMA node
       specific pfmemalloc_wait queue will be unable to make
       significant progress via direct reclaim unless it is
       killed after being woken up by kswapd
       (see throttle_direct_reclaim())

    2. With a SCHED_FIFO task that busy loops on a given CPU,
       and kworker for that CPU at SCHED_OTHER priority,
       queuing work to sync per-vmstats will either cause that
       work to never execute, or stalld (i.e. stall daemon)
       boosts kworker priority which causes a latency
       violation

By having vmstat_shepherd flush the per-CPU counters to the
global counters from remote CPUs.

This is done using cmpxchg to manipulate the counters,
both CPU locally (via the account functions),
and remotely (via cpu_vm_stats_fold).

Thanks to Aaron Tomlin for diagnosing issue 1 and writing
the initial patch series.

 include/linux/mmzone.h |    3 
 mm/vmstat.c            |  424 ++++++++++++++++++++++++++++++++++++++++++++++++------------------------------------------
 2 files changed, 230 insertions(+), 197 deletions(-)



