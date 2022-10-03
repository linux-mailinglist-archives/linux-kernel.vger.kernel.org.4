Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC07E5F329A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 17:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbiJCPfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 11:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbiJCPfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 11:35:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C3B13FAD
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 08:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664811293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9qKy0mrwb1ZaeVcnoJdtpT0vU2IyZpITeq2cNcv3elU=;
        b=QI25XqqnZfwn7ABQTyB2IwXViyPF3u2viiiAvNC398Tr7O/ATip4pH2ZYtrpsas8Exaoio
        9i/xvcEJno+Hoi0dCe9A3igsu49yc6Y4WHbUaj54PVlM3goCTjihspOazx8GfabPvUM43j
        jgib16ylh9nmjBRWuWtYJYruoz/8Bds=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-492-zFZmoeNEOm-qa0eVyk3b3A-1; Mon, 03 Oct 2022 11:34:52 -0400
X-MC-Unique: zFZmoeNEOm-qa0eVyk3b3A-1
Received: by mail-wm1-f69.google.com with SMTP id y15-20020a1c4b0f000000b003b47578405aso3001918wma.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 08:34:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=9qKy0mrwb1ZaeVcnoJdtpT0vU2IyZpITeq2cNcv3elU=;
        b=3UiYYtNZoL7GZthSKmaLgeHeDjRjygeeTcl2emN2zmUfiWDCY24xnJzkSQdPLTTvF1
         TTtN20rw9Ua/FIZoQ49xaPW0jhi39NEKMICQUTcxiAdmYwnrWVMVeULZ0QhxICn2blrw
         yZylKVBkhmnx0CFF/w3X3vKzED/8BcYFsRipIkHqO54NDE5dxLuwPU1BBbhf2YPoFKYW
         8q5ifTp4Bku0/Cll2kP/oF6FUBBUMH9ETA06xu/g6N2pXnodd8c0ZVpRLb3y6zg5XJNs
         2j9UkMFtWpXv5n/gx/fz3Z7fUp74CLe4nfDdFzuQYiboLvCG8yrqN2TLIxhaRFw1+BRR
         F67g==
X-Gm-Message-State: ACrzQf3ovnZQQZ5IjP4Kbm+FBVuPR5rsIDGCUC/+nOfM3ZKuMq4D4YDy
        NEKCmSHpWVNAn6evFaiwSeN7YdTYkJ7aJkkmOdgMCyQzPGHQF4Fesuc1V9vf3tLZGXLuobHcCUR
        ov9jTDYQisxT293f6faP7V5dh
X-Received: by 2002:a5d:588c:0:b0:22b:24d4:d896 with SMTP id n12-20020a5d588c000000b0022b24d4d896mr13440190wrf.611.1664811291126;
        Mon, 03 Oct 2022 08:34:51 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7dK79kXgKpUAVjxCPuM7ftmnrqJfkV/6uJjTLHWR/lVxoHiO15CtzuAB4IFYHSYe+goWsQ7g==
X-Received: by 2002:a5d:588c:0:b0:22b:24d4:d896 with SMTP id n12-20020a5d588c000000b0022b24d4d896mr13440171wrf.611.1664811290913;
        Mon, 03 Oct 2022 08:34:50 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
        by smtp.gmail.com with ESMTPSA id o9-20020a05600c510900b003a5c244fc13sm18343151wms.2.2022.10.03.08.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 08:34:50 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH bitmap-for-next 5/5] sched/core: Merge cpumask_andnot()+for_each_cpu() into for_each_cpu_andnot()
Date:   Mon,  3 Oct 2022 16:34:20 +0100
Message-Id: <20221003153420.285896-6-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221003153420.285896-1-vschneid@redhat.com>
References: <20221003153420.285896-1-vschneid@redhat.com>
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

This removes the second use of the sched_core_mask temporary mask.

Suggested-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/sched/core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ee28253c9ac0..b4c3112b0095 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -360,10 +360,7 @@ static void __sched_core_flip(bool enabled)
 	/*
 	 * Toggle the offline CPUs.
 	 */
-	cpumask_copy(&sched_core_mask, cpu_possible_mask);
-	cpumask_andnot(&sched_core_mask, &sched_core_mask, cpu_online_mask);
-
-	for_each_cpu(cpu, &sched_core_mask)
+	for_each_cpu_andnot(cpu, cpu_possible_mask, cpu_online_mask)
 		cpu_rq(cpu)->core_enabled = enabled;
 
 	cpus_read_unlock();
-- 
2.31.1

