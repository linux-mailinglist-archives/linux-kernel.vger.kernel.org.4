Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8650B708CCE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 02:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbjESATo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 20:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjESAS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 20:18:57 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE551BD9
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:18:32 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5144a9c11c7so2430657a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684455498; x=1687047498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZHAWRptnKdIlqvPqFYXdDuWL+3gSoggvY6ciXqnI2hE=;
        b=YwsnyLDTEVB6RHnSTyBcSSNNbF0zuMEmj0CAnBs6m0H1bcEppYJF7XnqPU2rhvMi1R
         I9oZhAGma8mBAdEA+NNuxJ5eoKQODw2AFmNBuhWlySf+49qMcSe0kQEbvvYVbS2I4OO9
         3Q8aLUMkVAogIVNVLK20UfxgPdwAVWkeFb2j6EEa7wWwCoadOjJDEggxF8SemIEixA4H
         Hc/d8JkQFfa/sAeTeuko6tDDi6oa28SBKcsyLhJzOSnYZG7kPUilSj8Y2ubOEBLrLCGr
         qcjlnINrTNB+Vo9+4wD6o5563UL8kwkrGnpEwM4J4omUyotpFrbVwwHpH6YipW0+RVIw
         MYQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684455498; x=1687047498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZHAWRptnKdIlqvPqFYXdDuWL+3gSoggvY6ciXqnI2hE=;
        b=WrSboK72l7gDgzTIWdoB1xUwmZHCLABwvMYiBP/olJqJg1z0iHCMFK97N7R9wjonoJ
         ZsrYCckzuC5CPasVQDsCgFi5jloGXfwDMfB5/evN3BLksPqGF727spM29o6qw6XTCyRp
         GX94d12mONQ9KhiqFc3W3plgI+Et+FP9nHcdHj6g5JtqqsnS7YOZ1Cb+mVRWKUJ8XBic
         TdT6muBvnUIkwzpTsJKvYDUfq3TUe/qQ6DWpxHQS0Xy/2yxSCF/Hlx86hXp0Tod69D1X
         Y+uOdACMmMbpvTw2Ylk8r9e6UdpqmMOzuAhVpdtVw1A+XRfzka8Cr0btDWaaSoXWguM7
         QZhA==
X-Gm-Message-State: AC+VfDxM5gOvmaFl3SwnHUzne0qxcTh1n3gNvqfsLTGkKZXR/vCzlrKF
        /kS92VirNDMBQzM7i5Yqr6z+uyo3e74=
X-Google-Smtp-Source: ACHHUZ4IBNJm8GpSOCM7vxMfD3cjcMpiYiEb+SAN4UT+KRsu7raaAGER7S4zG2ioHbJzn+hb4tSZkQ==
X-Received: by 2002:a17:903:11c9:b0:1ac:750e:33d5 with SMTP id q9-20020a17090311c900b001ac750e33d5mr1133414plh.15.1684455497594;
        Thu, 18 May 2023 17:18:17 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id q7-20020a170902edc700b001ae0b373382sm2039958plk.198.2023.05.18.17.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 17:18:17 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        joshdon@google.com, brho@google.com, briannorris@chromium.org,
        nhuck@google.com, agk@redhat.com, snitzer@kernel.org,
        void@manifault.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 22/24] workqueue: Add "Affinity Scopes and Performance" section to documentation
Date:   Thu, 18 May 2023 14:17:07 -1000
Message-Id: <20230519001709.2563-23-tj@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230519001709.2563-1-tj@kernel.org>
References: <20230519001709.2563-1-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With affinity scopes and their strictness setting added, unbound workqueues
should now be able to cover wide variety of configurations and use cases.
Unfortunately, the performance picture is not entirely straight-forward due
to a trade-off between efficiency and work-conservation in some situations
necessitating manual configuration.

This patch adds "Affinity Scopes and Performance" section to
Documentation/core-api/workqueue.rst which illustrates the trade-off with a
set of experiments and provides some guidelines.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 Documentation/core-api/workqueue.rst | 184 ++++++++++++++++++++++++++-
 1 file changed, 179 insertions(+), 5 deletions(-)

diff --git a/Documentation/core-api/workqueue.rst b/Documentation/core-api/workqueue.rst
index c73a6df6a118..4a8e764f41ae 100644
--- a/Documentation/core-api/workqueue.rst
+++ b/Documentation/core-api/workqueue.rst
@@ -1,6 +1,6 @@
-====================================
-Concurrency Managed Workqueue (cmwq)
-====================================
+=========
+Workqueue
+=========
 
 :Date: September, 2010
 :Author: Tejun Heo <tj@kernel.org>
@@ -25,8 +25,8 @@ there is no work item left on the workqueue the worker becomes idle.
 When a new work item gets queued, the worker begins executing again.
 
 
-Why cmwq?
-=========
+Why Concurrency Managed Workqueue?
+==================================
 
 In the original wq implementation, a multi threaded (MT) wq had one
 worker thread per CPU and a single threaded (ST) wq had one worker
@@ -408,6 +408,180 @@ directory.
   behavior of older kernels.
 
 
+Affinity Scopes and Performance
+===============================
+
+It'd be ideal if an unbound workqueue's behavior is optimal for vast
+majority of use cases without further tuning. Unfortunately, in the current
+kernel, there exists a pronounced trade-off between locality and utilization
+necessitating explicit configurations when workqueues are heavily used.
+
+Higher locality leads to higher efficiency where more work is performed for
+the same number of consumed CPU cycles. However, higher locality may also
+cause lower overall system utilization if the work items are not spread
+enough across the affinity scopes by the issuers. The following performance
+testing with dm-crypt clearly illustrates this trade-off.
+
+The tests are run on a CPU with 12-cores/24-threads split across four L3
+caches (AMD Ryzen 9 3900x). CPU clock boost is turned off for consistency.
+``/dev/dm-0`` is a dm-crypt device created on NVME SSD (Samsung 990 PRO) and
+opened with ``cryptsetup`` with default settings.
+
+
+Scenario 1: Enough issuers and work spread across the machine
+-------------------------------------------------------------
+
+The command used: ::
+
+  $ fio --filename=/dev/dm-0 --direct=1 --rw=randrw --bs=32k --ioengine=libaio \
+    --iodepth=64 --runtime=60 --numjobs=24 --time_based --group_reporting \
+    --name=iops-test-job --verify=sha512
+
+There are 24 issuers, each issuing 64 IOs concurrently. ``--verify=sha512``
+makes ``fio`` generate and read back the content each time which makes
+execution locality matter between the issuer and ``kcryptd``. The followings
+are the read bandwidths and CPU utilizations depending on different affinity
+scope settings on ``kcryptd`` measured over five runs. Bandwidths are in
+MiBps, and CPU util in percents.
+
+.. list-table::
+   :widths: 16 20 20
+   :header-rows: 1
+
+   * - Affinity
+     - Bandwidth (MiBps)
+     - CPU util (%)
+
+   * - system
+     - 1159.40 ±1.34
+     - 99.31 ±0.02
+
+   * - cache
+     - 1166.40 ±0.89
+     - 99.34 ±0.01
+
+   * - cache (strict)
+     - 1166.00 ±0.71
+     - 99.35 ±0.01
+
+With enough issuers spread across the system, there is no downside to
+"cache", strict or otherwise. All three configurations saturate the whole
+machine but the cache-affine ones outperform by 0.6% thanks to improved
+locality.
+
+
+Scenario 2: Fewer issuers, enough work for saturation
+-----------------------------------------------------
+
+The command used: ::
+
+  $ fio --filename=/dev/dm-0 --direct=1 --rw=randrw --bs=32k \
+    --ioengine=libaio --iodepth=64 --runtime=60 --numjobs=8 \
+    --time_based --group_reporting --name=iops-test-job --verify=sha512
+
+The only difference from the previous scenario is ``--numjobs=8``. There are
+a third of the issuers but is still enough total work to saturate the
+system.
+
+.. list-table::
+   :widths: 16 20 20
+   :header-rows: 1
+
+   * - Affinity
+     - Bandwidth (MiBps)
+     - CPU util (%)
+
+   * - system
+     - 1155.40 ±0.89
+     - 97.41 ±0.05
+
+   * - cache
+     - 1154.40 ±1.14
+     - 96.15 ±0.09
+
+   * - cache (strict)
+     - 1112.00 ±4.64
+     - 93.26 ±0.35
+
+This is more than enough work to saturate the system. Both "system" and
+"cache" are nearly saturating the machine but not fully. "cache" is using
+less CPU but the better efficiency puts it at the same bandwidth as
+"system".
+
+Eight issuers moving around over four L3 cache scope still allow "cache
+(strict)" to mostly saturate the machine but the loss of work conservation
+is now starting to hurt with 3.7% bandwidth loss.
+
+
+Scenario 3: Even fewer issuers, not enough work to saturate
+-----------------------------------------------------------
+
+The command used: ::
+
+  $ fio --filename=/dev/dm-0 --direct=1 --rw=randrw --bs=32k \
+    --ioengine=libaio --iodepth=64 --runtime=60 --numjobs=4 \
+    --time_based --group_reporting --name=iops-test-job --verify=sha512
+
+Again, the only difference is ``--numjobs=4``. With the number of issuers
+reduced to four, there now isn't enough work to saturate the whole system
+and the bandwidth becomes dependent on completion latencies.
+
+.. list-table::
+   :widths: 16 20 20
+   :header-rows: 1
+
+   * - Affinity
+     - Bandwidth (MiBps)
+     - CPU util (%)
+
+   * - system
+     - 993.60 ±1.82
+     - 75.49 ±0.06
+
+   * - cache
+     - 973.40 ±1.52
+     - 74.90 ±0.07
+
+   * - cache (strict)
+     - 828.20 ±4.49
+     - 66.84 ±0.29
+
+Now, the tradeoff between locality and utilization is clearer. "cache" shows
+2% bandwidth loss compared to "system" and "cache (struct)" whopping 20%.
+
+
+Conclusion and Recommendations
+------------------------------
+
+In the above experiments, the efficiency advantage of the "cache" affinity
+scope over "system" is, while consistent and noticeable, small. However, the
+impact is dependent on the distances between the scopes and may be more
+pronounced in processors with more complex topologies.
+
+While the loss of work-conservation in certain scenarios hurts, it is a lot
+better than "cache (strict)" and maximizing workqueue utilization is
+unlikely to be the common case anyway. As such, "cache" is the default
+affinity scope for unbound pools.
+
+* As there is no one option which is great for most cases, workqueue usages
+  that may consume a significant amount of CPU are recommended to configure
+  the workqueues using ``apply_workqueue_attrs()`` and/or enable
+  ``WQ_SYSFS``.
+
+* An unbound workqueue with strict "cpu" affinity scope behaves the same as
+  ``WQ_CPU_INTENSIVE`` per-cpu workqueue. There is no real advanage to the
+  latter and an unbound workqueue provides a lot more flexibility.
+
+* Affinity scopes are introduced in Linux v6.5. To emulate the previous
+  behavior, use strict "numa" affinity scope.
+
+* The loss of work-conservation in non-strict affinity scopes is likely
+  originating from the scheduler. There is no theoretical reason why the
+  kernel wouldn't be able to do the right thing and maintain
+  work-conservation in most cases. As such, it is possible that future
+  scheduler improvements may make most of these tunables unnecessary.
+
+
 Examining Configuration
 =======================
 
-- 
2.40.1

