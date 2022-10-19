Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75695603C5C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 10:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbiJSIqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 04:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbiJSIoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 04:44:24 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1097C7E80D;
        Wed, 19 Oct 2022 01:43:22 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=guanjun@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VSa04gl_1666168845;
Received: from localhost(mailfrom:guanjun@linux.alibaba.com fp:SMTPD_---0VSa04gl_1666168845)
          by smtp.aliyun-inc.com;
          Wed, 19 Oct 2022 16:40:46 +0800
From:   'Guanjun' <guanjun@linux.alibaba.com>
To:     schspa@gmail.com, rafael@kernel.org, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        guanjun@linux.alibaba.com, zelin.deng@linux.alibaba.com
Subject: [PATCH 0/1] cpufreq: Fix show()/store() issue for hotplugging
Date:   Wed, 19 Oct 2022 16:40:44 +0800
Message-Id: <1666168845-67690-1-git-send-email-guanjun@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zelin Deng <zelin.deng@linux.alibaba.com>

Hello maintainers,

After I brought one CPU (64) offline, I got failure when I used lscpu:
lscpu: cannot read /sys/devices/system/cpu/cpu64/cpufreq/cpuinfo_max_freq: Device or resource busy

I found in commit d4627a287e251, policy_is_inactive() check was added to
avoid the case in which policy initialization failed. However it didn't
consider the situation in which policy has been created successfully but
is not inactive: CPU is hotplugging offline.

This patch just add an addtional check whether CPU is online or not to
fix the issue.

Zelin Deng (1):
  cpufreq: Fix show()/store() issue for hotplugging offline CPU

 drivers/cpufreq/cpufreq.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

-- 
2.32.0.GIT

