Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566976B3BA6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 11:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbjCJKFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 05:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjCJKFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 05:05:09 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F0910975B;
        Fri, 10 Mar 2023 02:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678442707; x=1709978707;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WbYMpLTqHuybZPfBT+AcMsJCPSn86KbY1LDBukqadOU=;
  b=R9VrH7W8luZZPLLnVmBnafPqNr9ih0TgZynIxM4ixaqqU3sDNHm/waEv
   NvqkX5VK20VrLilkUYzwbOlIcbCkvC1UuSpUn2/271PDv6IYSRoZFd5AT
   1FuFuM0M0npV/fmQMgsw1M7W2A2wyHBpR3hLyZ4y1Whu4ktheN6J1v3gy
   vhGAmVfoFvmQpI2WUk7dYJpNzpVoIrTWW8BYcjdVx4xV+72mETBR1Agzg
   iqiKyc25vpQql2sfS18EoTev7Bn5HavGftIUE3lcaK4Z0kIoxqXv6rDen
   5lF0s3BJR7/2mXGjXNwcq0FyMHWhyETvc/1axMOqwg2ba2knEIWPx2ama
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="399294179"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="399294179"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 02:05:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="923609308"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="923609308"
Received: from fliu-mobl.ger.corp.intel.com (HELO tkristo-desk.intel.com) ([10.252.32.249])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 02:05:04 -0800
From:   Tero Kristo <tero.kristo@linux.intel.com>
To:     rostedt@goodmis.org, bristot@kernel.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCHv2 2/2] trace/hwlat: Do not start per-cpu thread if it is already running
Date:   Fri, 10 Mar 2023 12:04:51 +0200
Message-Id: <20230310100451.3948583-3-tero.kristo@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230310100451.3948583-1-tero.kristo@linux.intel.com>
References: <20230310100451.3948583-1-tero.kristo@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hwlatd tracer will end up starting multiple per-cpu threads with
the following script:

    #!/bin/sh
    cd /sys/kernel/debug/tracing
    echo 0 > tracing_on
    echo hwlat > current_tracer
    echo per-cpu > hwlat_detector/mode
    echo 100000 > hwlat_detector/width
    echo 200000 > hwlat_detector/window
    echo 1 > tracing_on

To fix the issue, check if the hwlatd thread for the cpu is already
running, before starting a new one. Along with the previous patch, this
avoids running multiple instances of the same CPU thread on the system.

Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
---
v2:
  * split into separate patch
  * added reproducer script into commit log

 kernel/trace/trace_hwlat.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index edc26dc22c3f..c4945f8adc11 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -492,6 +492,10 @@ static int start_cpu_kthread(unsigned int cpu)
 {
 	struct task_struct *kthread;
 
+	/* Do not start a new hwlatd thread if it is already running */
+	if (per_cpu(hwlat_per_cpu_data, cpu).kthread)
+		return 0;
+
 	kthread = kthread_run_on_cpu(kthread_fn, NULL, cpu, "hwlatd/%u");
 	if (IS_ERR(kthread)) {
 		pr_err(BANNER "could not start sampling thread\n");
-- 
2.25.1

