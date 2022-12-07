Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F7D645760
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 11:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbiLGKRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 05:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbiLGKR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 05:17:26 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DAF0A45EDF;
        Wed,  7 Dec 2022 02:17:21 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D4AB23A;
        Wed,  7 Dec 2022 02:17:28 -0800 (PST)
Received: from e123648.arm.com (unknown [10.57.7.234])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id ADD3F3F73B;
        Wed,  7 Dec 2022 02:17:18 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org
Cc:     lukasz.luba@arm.com, viresh.kumar@linaro.org,
        dietmar.eggemann@arm.com, vincent.guittot@linaro.org,
        saravanak@google.com, wusamuel@google.com,
        isaacmanjarres@google.com, kernel-team@android.com,
        juri.lelli@redhat.com, peterz@infradead.org, mingo@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de
Subject: [PATCH v2 0/2] cpufreq: schedutil: Optimize operations in hot path frequency switch
Date:   Wed,  7 Dec 2022 10:17:03 +0000
Message-Id: <20221207101705.9460-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This v2 is an attempt to optimize some not needed operations in the frequency
change code path for the shared freq. domain. There was different approach
which was too aggressive and failed do to working on a state CPU capacity
information.

changes:
v2:
- split the patch into two (Viresh)
v1:
- simple approach which fetches CPU capacity every time it's needed,
  not relaying on the setup value, which was causing issues.

Regards,
Lukasz

Lukasz Luba (2):
  cpufreq: schedutil: Introduce single max CPU capacity for freqency
    domain
  cpufreq: schedutil: Optimize operations with single max CPU capacity

 kernel/sched/cpufreq_schedutil.c | 35 +++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 14 deletions(-)

-- 
2.17.1

