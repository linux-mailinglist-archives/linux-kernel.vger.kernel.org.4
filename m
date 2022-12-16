Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D9564E749
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 07:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiLPGYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 01:24:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiLPGYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 01:24:21 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465C8654EE
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 22:24:20 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id n4so1392814plp.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 22:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qLdFx4IEMIz4fpOByy1JRPc88cJrOsJuUsf8EyXMfy4=;
        b=yHzWqjVxhBAsk4leESW3vkoIfFAWaxNEsPpLGKJTuj2izQ/DO+W1lE9Ngt9PfVmuoJ
         4th80NidWQLkEd0Qm03k5t670UPuPICuq8G5/unmDfYciuCzT3jcuE5LuFtEZQZ85ap7
         nSfHB7WZ5GcQGJrYrzzNUTs3F31qkYvJ/3LUAbKcHqY/xz+1hT9RREQKzvYJhL55LcZq
         gj/6uL6UH3migA2WeCIClnuS2rK0URQJhxDInsG4t+dCqjg0vkR6Rwo2v6VJR509HrNl
         nGTel4V6Jb5JRrf6yDaP1y1/WTPHrZtY2smyFz1LpuJpjwLGW4VD6Yco80n7dEcvJqA6
         ygxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qLdFx4IEMIz4fpOByy1JRPc88cJrOsJuUsf8EyXMfy4=;
        b=taAzjs4007NElIwa/DP84FLfwIffm2ItTQoCYKHjPLaKUOFUGVZad7IzOIrhdFq28T
         FmAH2SDhiIDQrd90cJTcTP69a86eLhHr+3M7+7XIY1BYeBPARF149bdaqCWNut7TJk9X
         a7MsYuIRv1UKL807ufLrt3pNYMKn9Ejo/g6QK4ARkkhneObWGeOLzI5j+Yi6e6+X13Ey
         StKKu1m+RPEQe3wnwtzPCOy/k1THundjJIZtfaS8sPbzzezsT96HkQfFA9NtwoGe2EW1
         knXMmoTdExZckveiM3J+P/D2OwZ8/7DunRzKVkEj3zYmjdWTd2BX9zHn58vxoQqW2R0t
         UrbQ==
X-Gm-Message-State: ANoB5pnwacr7nxAKQJkCXG8rdiBe/kV+nCZQpB3wU++YxfHJZvDQ2Lxr
        9XJl0J1ACX2TVwUzqqRWP6iBJA==
X-Google-Smtp-Source: AA0mqf7+4AGc1jAILc97fkUd/1aJMg/hcpeFxmKqPK09XjHIlQHADdQBpZIK0FBI/GbyE/nxukRNZA==
X-Received: by 2002:a05:6a21:9213:b0:a4:8725:fdcd with SMTP id tl19-20020a056a21921300b000a48725fdcdmr39584939pzb.15.1671171859834;
        Thu, 15 Dec 2022 22:24:19 -0800 (PST)
Received: from C02G87K0MD6R.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id s5-20020a656445000000b0046feca0883fsm681819pgv.64.2022.12.15.22.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 22:24:19 -0800 (PST)
From:   Hao Jia <jiahao.os@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net
Cc:     linux-kernel@vger.kernel.org, Hao Jia <jiahao.os@bytedance.com>
Subject: [PATCH v3 0/2] Clean up the process of scanning the CPU for some functions
Date:   Fri, 16 Dec 2022 14:24:04 +0800
Message-Id: <20221216062406.7812-1-jiahao.os@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two patches clean up the process of scanning the CPU.

Patch 1 stops checking for a new idle core in time
if an idle core has already been found.

Patch 2 tries to minimize false attempts by adjusting the order
of scanning CPU.

v3->v2:
    - Add "Acked-by: Mel Gorman <mgorman@techsingularity.net>" and
      "Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>"
      for patch2

v1->v2:
    - Simplified patch1 code and add
      "Acked-by: Mel Gorman <mgorman@techsingularity.net>" for patch1
    - Modify commit description to make it more clear

[v1] https://lore.kernel.org/all/20221021061558.34767-1-jiahao.os@bytedance.com
[v2] https://lore.kernel.org/all/20221026064300.78869-1-jiahao.os@bytedance.com

Hao Jia (2):
  sched/numa: Stop an exhastive search if an idle core is found
  sched/core: Adjusting the order of scanning CPU

 kernel/sched/core.c | 2 +-
 kernel/sched/fair.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.37.0

