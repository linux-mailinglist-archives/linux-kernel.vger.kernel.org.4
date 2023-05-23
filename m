Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7023C70DEDF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 16:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237319AbjEWOMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 10:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237229AbjEWOM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 10:12:27 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473601BB
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 07:12:07 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-64d5b4c3ffeso2166892b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 07:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684851127; x=1687443127;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t+G/28MNCXuidnG5AulwelJkxMgzzIsBpPPnC7MtAJ0=;
        b=VcmTmmhLHRf5xTFBu/ax9SQtxd4sBBDUmL1wGFSR6wYdpRNmAKr/nSwS7AMN5Xlruw
         +vgu79pnc7vta1MuLSlLL4S7ZLAIpvHqr/P1+BhFKJU/CBV8vrL4wG9mZDuGwBNf3dn6
         qCNg32U62qRcBu90k/7pDMVuNeFkNg6P4mRMGXVVjRiPkoroAnOB6m6tdQ7NIaRNwv26
         I9yUhLSyr1vRVVZBGIA9w2Iw9herzhcp0JfX4R5UgdTrl6BhGxtLoMsyQ2vsPbvjqfzE
         gytwgqhCL3ptEkHmcCliNUWGUf2FQj9MOnuewcdMOiqWf7O6VMoYOv93XesnWaGr1XDN
         MgTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684851127; x=1687443127;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t+G/28MNCXuidnG5AulwelJkxMgzzIsBpPPnC7MtAJ0=;
        b=FjO6Wk3J8JCFW0pW7va4mYulOpaRxD7L2ewmMB0s9vhduG361wl+2LIFgcLEyDru3z
         PUU68I6tku69QEfkk5YZ4zkGqWKc0wKx3WhghONmBSCi5tM6JYzJBPCpsDd2G1qZeCuA
         9FX3yEsIEnQlOMQC4GQtJHrOtXqKN2L/42g7prA5qpeOdQZU/+pYAbfIVVHrH+z3/MGK
         LBqTUfWdFXNAYN/UhZo9h+mwX7UNk25xSesUnxc7ftDP8e9wg+eCiwv+yy3iUye11U9f
         X+6Cj924qzpEmuLLGarI/WVkyW2yVSbE2Ysi1La3CaW3lgSI0QXK9Qylbr/R78G128mO
         uS1Q==
X-Gm-Message-State: AC+VfDxcC/1ndC5yfqHY2TQLgyX3H64SpqJsqkuzREgP3N3QbZUNDbU9
        vLWKcplWcDi+HTlIfkX4YgU=
X-Google-Smtp-Source: ACHHUZ7w+nf+YbXCQCU34MK1nHjwpTi58817bhgGqJWuUU35TebfIrueX4xz2cALi1VfqSV+Ciz12A==
X-Received: by 2002:a17:902:e842:b0:1ac:63ac:109d with SMTP id t2-20020a170902e84200b001ac63ac109dmr19122118plg.15.1684851126669;
        Tue, 23 May 2023 07:12:06 -0700 (PDT)
Received: from localhost.localdomain ([124.126.151.211])
        by smtp.gmail.com with ESMTPSA id jl1-20020a170903134100b00194caf3e975sm6789013plb.208.2023.05.23.07.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 07:12:06 -0700 (PDT)
From:   Zqiang <qiang.zhang1211@gmail.com>
To:     tj@kernel.org, jiangshanlai@gmail.com, naresh.kamboju@linaro.org,
        qiang.zhang1211@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] workqueue: Disable check CPU-hogging work when set wq_cpu_intensive_thresh_us=0
Date:   Tue, 23 May 2023 22:09:42 +0800
Message-Id: <20230523140942.18679-2-qiang.zhang1211@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230523140942.18679-1-qiang.zhang1211@gmail.com>
References: <20230523140942.18679-1-qiang.zhang1211@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit disable check CPU-hogging work in wq_worker_tick(), when set
the 'workqueue.cpu_intensive_thresh_us=0' in bootparams.

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
---
 kernel/workqueue.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index e548b2eda12a..ccbc9f2dafa6 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1145,6 +1145,7 @@ void wq_worker_tick(struct task_struct *task)
 	 * CPU_INTENSIVE to avoid stalling other concurrency-managed work items.
 	 */
 	if ((worker->flags & WORKER_NOT_RUNNING) || worker->sleeping ||
+						!wq_cpu_intensive_thresh_us ||
 	    worker->task->se.sum_exec_runtime - worker->current_at <
 	    wq_cpu_intensive_thresh_us * NSEC_PER_USEC)
 		return;
-- 
2.17.1

