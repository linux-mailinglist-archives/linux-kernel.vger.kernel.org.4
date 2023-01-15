Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58D266B07D
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 12:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjAOLC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 06:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjAOLCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 06:02:42 -0500
Received: from m12.mail.163.com (m12.mail.163.com [123.126.96.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A12BC15A;
        Sun, 15 Jan 2023 03:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=DK8Z1
        K298wuvVT3Xgrcx1/iJ/VthejW6eAHRqTKV+48=; b=EoU4ZmyWa7kOrIstSzoI1
        uOL9ZQtMMzFZOQ9F9NjqqnrPDDaltDv9vWeP8HVf2lyTt2s9lPPsr2l+t7lA6FTM
        3Fmv2YSfOg4VoFHpSYPVTwBEeH+ZpU2GZzBqIuTGzJW9s8QtE+LaqUpJy/QRppqK
        hp84IfnER3dsKMD+IjRpQc=
Received: from ubuntu20.04 (unknown [222.129.34.12])
        by smtp17 (Coremail) with SMTP id NdxpCgC3mSg13cNjmGgOAg--.47934S2;
        Sun, 15 Jan 2023 19:02:14 +0800 (CST)
From:   Vincent Wang <bhuwz@163.com>
To:     rafael@kernel.org, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vincent Wang <vincentwang3@lenovo.com>
Subject: [PATCH] cpufreq: Send CPUFREQ_CREATE_POLICY notification after the perf domain creation.
Date:   Sun, 15 Jan 2023 19:02:08 +0800
Message-Id: <20230115110208.12411-1-bhuwz@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NdxpCgC3mSg13cNjmGgOAg--.47934S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zr45CFW7WFyrGw1fJr1DJrb_yoW8Gr15pF
        W2grW8CryxtFZrJa1UAF48ua4Yq3Zruay8G34UGw1FyrnxCF1Sg3WUGF1YkFWfGr4kCrWa
        yr1Fqa47Ca18CF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jDvtAUUUUU=
X-Originating-IP: [222.129.34.12]
X-CM-SenderInfo: pekx46i6rwjhhfrp/xtbBRRb33GI0etetFAAAs6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Wang <vincentwang3@lenovo.com>

We found the following issue during kernel boot on android phone:

[    1.325272][    T1] cpu cpu0: EM: created perf domain
[    1.329317][    T1] cpu cpu4: EM: created perf domain
[    1.337597][   T76] pd_init: no EM found for CPU7
[    1.350849][    T1] cpu cpu7: EM: created perf domain

pd init for cluster2 is executed in a kworker thread and
is earlier than the perf domain creation for cluster2.

pd_init() is called from the cpufreq notification of
CPUFREQ_CREATE_POLICY in cpufreq_online(), which is earlier
than that cpufreq_driver->register_em() is called.

To avoid this issue, cpufreq notification should be sent after
the perf domain creation.

Signed-off-by: Vincent Wang <vincentwang3@lenovo.com>
---
 drivers/cpufreq/cpufreq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 7e56a42750ea..9e67df4fc334 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1506,6 +1506,9 @@ static int cpufreq_online(unsigned int cpu)
 		 */
 		if (cpufreq_driver->register_em)
 			cpufreq_driver->register_em(policy);
+
+		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
+				CPUFREQ_CREATE_POLICY, policy);
 	}
 
 	ret = cpufreq_init_policy(policy);
-- 
2.25.1

