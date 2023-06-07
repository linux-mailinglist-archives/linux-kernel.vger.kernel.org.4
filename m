Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E943E7267FE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 20:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbjFGSKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 14:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjFGSKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 14:10:14 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5E395
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 11:10:13 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-542c54455e7so2541824a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 11:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686161413; x=1688753413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qV89SGlXzzybQ68Kw8PJEO9/Nh725SOfx0EhcbhN+uM=;
        b=MlIQ2lv7KlNWK5bTcU/eBzyeeSymLF/3Fmuubmagj4IwYvTEJ6U7Hcc2GGiWZs7vHP
         ziB2X20BURh/p018DaAbGDrvSsbQq7DZaVoHJ8caM1XZwY09/3YE90u2l/kEzxrtrDRJ
         DsxjZn9Ya4mUGMkv4nFzEfJfEXSp6IbUrCIy9BLoaaVnT2WtZKrak9X8tMi60LRmWOyu
         aPRGrNCKIJrKDl9kjnZztONoM53cJ7yNLJfrBC21KPl3o0bbNn9zm9RzZeQZVnU/ZSpR
         E2FPA/bxTLuhIKmSRf3Y7+lkVGdlwTErOA2lp3cxL7m3W3ja05GC7W8f5XlvCdaiAlbr
         Gdhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686161413; x=1688753413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qV89SGlXzzybQ68Kw8PJEO9/Nh725SOfx0EhcbhN+uM=;
        b=aISCt7wk4L/lCWIzX0GzhaF0o9g+Bw4uf1UoRSt1t+5DEcvR69HCB5iljJ9z+mSf+i
         Z+kSoaNbSp8yw1n1sbUGlSJbvG69fLSruwWYeNc3rVwO/kVngdiy0hPMxbOab5wwAvPF
         18l3UmYws3q2h1s2lq/lsM0bAuNFHai0Ucwk4IgmRbOyHUcXsxKkYUz1XGWN+wU64NtP
         /IqeDD9wfZ5B9hEDKa11gMbSRiBFlUjlY5hYARkeM2waAR19NwZUC1IpgM31Qwe2RSP0
         f7BAMd/bBuTVGLfQX01e/dDuA+k0PNtwYcS3Epw4JjwcEvPlO7447CK4JzA3d7qk9vGf
         7Cdg==
X-Gm-Message-State: AC+VfDw1SqNaYv4osc5BX3nadEDk3mR/iYWvkYZ2HO4CNe6TAjlqfiC+
        WnlY0tBdvwhO4Jh9KiT5d7s=
X-Google-Smtp-Source: ACHHUZ4dNWuBZx8yG1Fojwq+zZrRDyVXt2jaoWh3tFYU54a1r4437PQWroeeP6lUyVAVfpwOkyzNqA==
X-Received: by 2002:a17:90b:190f:b0:246:85ec:d816 with SMTP id mp15-20020a17090b190f00b0024685ecd816mr2333613pjb.3.1686161412765;
        Wed, 07 Jun 2023 11:10:12 -0700 (PDT)
Received: from VAN-928222-PC0.fortinet-us.com ([173.214.130.2])
        by smtp.gmail.com with ESMTPSA id cm14-20020a17090afa0e00b00256799877ffsm1623918pjb.47.2023.06.07.11.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 11:10:11 -0700 (PDT)
From:   Qingjie Xing <xqjcool@gmail.com>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, brauner@kernel.org,
        linux-kernel@vger.kernel.org, xqjcool@gmail.com
Subject: [PATCH] sched/debug,sched/core: Reset hung task detector while processing sysrq-t
Date:   Wed,  7 Jun 2023 11:09:58 -0700
Message-Id: <20230607180958.4112039-1-xqjcool@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On devices with multiple CPUs and multiple processes, outputting lengthy
sysrq-t content on a slow serial port can consume a significant amount
of time. We need to reset the hung task detector to avoid false hung task
alerts.

Signed-off-by: Qingjie Xing <xqjcool@gmail.com>
---
 kernel/sched/core.c  | 1 +
 kernel/sched/debug.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a68d1276bab0..5773283b752c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9176,6 +9176,7 @@ void show_state_filter(unsigned int state_filter)
 		 */
 		touch_nmi_watchdog();
 		touch_all_softlockup_watchdogs();
+		reset_hung_task_detector();
 		if (state_filter_match(state_filter, p))
 			sched_show_task(p);
 	}
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 0b2340a79b65..43065808b425 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -904,6 +904,7 @@ void sysrq_sched_debug_show(void)
 		 */
 		touch_nmi_watchdog();
 		touch_all_softlockup_watchdogs();
+		reset_hung_task_detector();
 		print_cpu(NULL, cpu);
 	}
 }
-- 
2.40.1

