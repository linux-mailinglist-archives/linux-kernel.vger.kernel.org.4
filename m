Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48106473D4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 17:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiLHQDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 11:03:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiLHQDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 11:03:39 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 217F99E471;
        Thu,  8 Dec 2022 08:03:38 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6294D6E;
        Thu,  8 Dec 2022 08:03:44 -0800 (PST)
Received: from e123648.arm.com (unknown [10.57.9.192])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0FD743F73D;
        Thu,  8 Dec 2022 08:03:34 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org
Cc:     lukasz.luba@arm.com, viresh.kumar@linaro.org,
        dietmar.eggemann@arm.com, vincent.guittot@linaro.org,
        saravanak@google.com, wusamuel@google.com,
        isaacmanjarres@google.com, kernel-team@android.com,
        juri.lelli@redhat.com, peterz@infradead.org, mingo@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de
Subject: [PATCH v3 0/1] cpufreq: schedutil: Optimize operations in hot path frequency switch
Date:   Thu,  8 Dec 2022 16:02:55 +0000
Message-Id: <20221208160256.859-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This v3 is an attempt to optimize some of not needed operations in the frequency
change code path for the shared freq. domain. There was different approach
which was too aggressive and failed due to working on a stale CPU capacity
information.

changes:
v3:
- follow Vincent recommendation to drop the sg_policy::max, I have instead
  tried to reduce the lookup and cache pressure, but use local var passing
  to functions when needed
- unfortunately I couldn't use Viresh's ACKs for the v2 patches, since the code
  has changed heavily
- updated the patch header with description of the code flow and the issue, since I
  thought this optimization reason should be better explained, so people can refer
  to it, since the former approach was reverted
v2:
- split the patch into two (Viresh)
v1:
- simple approach which fetches CPU capacity every time it's needed,
  not relaying on the setup value, which was causing issues.

Regards,
Lukasz

Lukasz Luba (1):
  cpufreq: schedutil: Optimize operations with single CPU capacity
    lookup

 kernel/sched/cpufreq_schedutil.c | 43 +++++++++++++++++---------------
 1 file changed, 23 insertions(+), 20 deletions(-)

-- 
2.17.1

