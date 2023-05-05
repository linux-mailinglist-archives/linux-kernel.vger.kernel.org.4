Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727376F85A5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 17:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbjEEP0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 11:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232955AbjEEP0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 11:26:24 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 14C9E1A107;
        Fri,  5 May 2023 08:25:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 292E51FB;
        Fri,  5 May 2023 08:26:02 -0700 (PDT)
Received: from e130256.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E80D13F5A1;
        Fri,  5 May 2023 08:25:16 -0700 (PDT)
From:   Hongyan Xia <hongyan.xia2@arm.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Hongyan Xia <hongyan.xia2@arm.com>,
        Qais Yousef <qyousef@layalina.io>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sched/documentation: elaborate on uclamp limitations
Date:   Fri,  5 May 2023 16:24:39 +0100
Message-Id: <20230505152440.142265-1-hongyan.xia2@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The story in 5.2 about util_avg abruptly jumping from 300 when
Fmax/Fmin == 3 to 1024 when Fmax/Fmin == 4 hides some details about how
clock_pelt works behind the scenes. Explicitly mention it to make it
easier for readers to follow.

Signed-off-by: Hongyan Xia <hongyan.xia2@arm.com>
Cc: Qais Yousef <qyousef@layalina.io>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
---
 Documentation/scheduler/sched-util-clamp.rst | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/scheduler/sched-util-clamp.rst b/Documentation/scheduler/sched-util-clamp.rst
index 74d5b7c6431d..524df07bceba 100644
--- a/Documentation/scheduler/sched-util-clamp.rst
+++ b/Documentation/scheduler/sched-util-clamp.rst
@@ -669,6 +669,19 @@ but not proportional to Fmax/Fmin.
 
         p0->util_avg = 300 + small_error
 
+The reason why util_avg is around 300 even though it runs for 900 at Fmin is:
+Although running at Fmin reduces the rate of rq_clock_pelt() to 1/3 thus
+accumulates util_sum at 1/3 of the rate at Fmax, the clock period
+(rq_clock_pelt() now minus previous rq_clock_pelt()) in:
+
+::
+
+        util_sum / clock period = util_avg
+
+does not shrink to 1/3, since rq->clock_pelt is periodically synchronized with
+rq->clock_task as long as there's idle time. As a result, we get util_avg of
+about 300, not 900.
+
 Now if the ratio of Fmax/Fmin is 4, the maximum value becomes:
 
 ::
@@ -682,6 +695,10 @@ this happens, then the _actual_ util_avg will become:
 
         p0->util_avg = 1024
 
+This is because rq->clock_pelt is no longer synchronized with the task clock.
+The clock period therefore is proportionally shrunk by the same ratio of
+(Fmax/Fmin), giving us a maximal util_avg of 1024.
+
 If task p1 wakes up on this CPU, which have:
 
 ::
-- 
2.34.1

