Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746907004F4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 12:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240407AbjELKL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 06:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240382AbjELKLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 06:11:45 -0400
X-Greylist: delayed 1080 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 12 May 2023 03:11:15 PDT
Received: from m126.mail.126.com (m126.mail.126.com [220.181.12.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 00C758A7F
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 03:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=drjOJ
        bwh5sf32KtIIWZtrKWoSs9PXWg/V8+XkmqGqRc=; b=bJVPB44O42qSlopt9UMEG
        9gl8vDPwNEQhM+V5fOH5sGnsAPuT8gdc726KgMj4H03OF3RpOeQHW+r+gRGjrvAO
        SHl0mJwSiLnJJtKlLwabsVQ5IA3NL6O9UYn/Rf4yZfduQ2X9UgGM+LyZwEq5tWQ6
        3EvgOCccLXu7e12o33koYU=
Received: from fedora.. (unknown [123.52.27.102])
        by zwqz-smtp-mta-g5-1 (Coremail) with SMTP id _____wCHjgbDC15kU7ClAg--.37485S2;
        Fri, 12 May 2023 17:49:56 +0800 (CST)
From:   zhaomzhao@126.com
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Zhao Mengmeng <zhaomengmeng@kylinos.cn>
Subject: [PATCH v1] sched/numa: init numa_scan_period with sysctl_numa_balancing_scan_period_min
Date:   Fri, 12 May 2023 05:49:46 -0400
Message-Id: <20230512094946.2639893-1-zhaomzhao@126.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCHjgbDC15kU7ClAg--.37485S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFWxtr1fur47Kw4xCryxGrg_yoWDCwb_u3
        4kZr13tr4Iqrn0q3s3Gw43WFy5KFsFqa93C3WxG3y3trnYqa4kJFZ5AFWrJrnxJF4UGFs0
        yF1DXFyjqrsxZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8DfHUUUUUU==
X-Originating-IP: [123.52.27.102]
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/1tbi6Ahtd2IxmSeRWwAAsd
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>

As the name suggests, sysctl_numa_balancing_scan_delay is a "delay"
mainly used by numa_next_scan, it has nothing to do with scan period. So
init numa_scan_period with sysctl_numa_balancing_scan_period_min.

Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 373ff5f55884..9b7d4f3a3d50 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3149,7 +3149,7 @@ void init_numa_balancing(unsigned long clone_flags, struct task_struct *p)
 	}
 	p->node_stamp			= 0;
 	p->numa_scan_seq		= mm ? mm->numa_scan_seq : 0;
-	p->numa_scan_period		= sysctl_numa_balancing_scan_delay;
+	p->numa_scan_period		= sysctl_numa_balancing_scan_period_min;
 	p->numa_migrate_retry		= 0;
 	/* Protect against double add, see task_tick_numa and task_numa_work */
 	p->numa_work.next		= &p->numa_work;
-- 
2.38.1

