Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2285B3793
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 14:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbiIIMUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 08:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbiIIMTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 08:19:35 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5264F11452
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 05:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662725852; x=1694261852;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UAAQ+YLzvmmUI6dBHAsDTOGyqlQLeOvNNzTP+cKD4uk=;
  b=RRVm+v3ML6ZI55FuhTAZaubBujoKuP2qAvoJov8ypCW0EtTB/jbT0c70
   CRyd/YKCEYKJUkWs9yWAkwfG9qcgZX5ogvsn9Jngzc9iPih8v7OSMYkYe
   GWJd8c8HekVb5Wc2EpjPaK5NTWUard5WOxk/2mTH/FTecu152uANGVIrX
   X5cpBtqs1Hv4gpn4jQHEqgMvuPztdULFNehgWaXiC+7Cv2tXoiPmjZ9VG
   OpjCphR6GQM9d6x5lgNkUQWu5c/+YuzOFlGd0BfcV96oO6lYfoqZMH23K
   EgjcL9zMXXgS0k5gCYt6vtMegP2hZMnMcYXbuAw7jWbQUh0VzGVzkrmYg
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="361416745"
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="361416745"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 05:17:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="645516055"
Received: from linux-pnp-server-13.sh.intel.com ([10.239.176.176])
  by orsmga008.jf.intel.com with ESMTP; 09 Sep 2022 05:17:28 -0700
From:   Jiebin Sun <jiebin.sun@intel.com>
To:     akpm@linux-foundation.org, vasily.averin@linux.dev,
        shakeelb@google.com, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, ebiederm@xmission.com, legion@kernel.org,
        manfred@colorfullife.com, alexander.mikhalitsyn@virtuozzo.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     tim.c.chen@intel.com, feng.tang@intel.com, ying.huang@intel.com,
        tianyou.li@intel.com, wangyang.guo@intel.com, jiebin.sun@intel.com
Subject: [PATCH v5 0/2] ipc/msg: mitigate the lock contention in ipc/msg
Date:   Sat, 10 Sep 2022 04:36:34 +0800
Message-Id: <20220909203636.2652466-1-jiebin.sun@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220902152243.479592-1-jiebin.sun@intel.com>
References: <20220902152243.479592-1-jiebin.sun@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Here are two patches to mitigate the lock contention in ipc/msg.

The 1st patch is to add the new interface percpu_counter_add_local and
percpu_counter_sub_local. The batch size in percpu_counter_add_batch should
be very large in heavy writing and rare reading case. Add the "_local"
version, and mostly it will do local adding, reduce the global updating and
mitigate lock contention in writing.

The 2nd patch is to use percpu_counter instead of atomic update in ipc/msg.
The msg_bytes and msg_hdrs atomic counters are frequently updated when IPC
msg queue is in heavy use, causing heavy cache bounce and overhead. Change
them to percpu_counter greatly improve the performance. Since there is one
percpu struct per namespace, additional memory cost is minimal. Reading of
the count done in msgctl call, which is infrequent. So the need to sum up
the counts in each CPU is infrequent.

Changes in v5:
1. Use INT_MAX as the large batch size in percpu_counter_local_add and
percpu_counter_sub_local.
2. Use the latest kernel 6.0-rc4 as the baseline for performance test.
3. Move the percpu_counter_local_add and percpu_counter_sub_local from
percpu_counter.c to percpu_counter.h.

Changes in v3:
1. Add comment and change log for the new function percpu_counter_add_local.
Who should use it and who shouldn't.

Changes in v2:
1. Separate the original patch into two patches.
2. Add error handling for percpu_counter_init.

The performance gain increases as the threads of workload become larger.
Performance gain: 3.99x

CPU: ICX 8380 x 2 sockets
Core number: 40 x 2 physical cores
Benchmark: pts/stress-ng-1.4.0
-- system v message passing (160 threads)


Regards
Jiebin

