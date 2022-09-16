Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99B05BA7BF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 10:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbiIPIEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 04:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbiIPIDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 04:03:34 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC02A5717
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 01:03:28 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id z12so16386313wrp.9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 01:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=ShOnvvH2vqswW8cX/k2qHv7+hfeakBkSeirHaU9mNjk=;
        b=nWn4K98smKU8rTj/exgiA9q/eWysrRh4iSpKFUaWG0C4NyUTRbNMuLCc0Q3aLBwiYf
         i6OQbis1h7HJR4LJo24ROd3I3jm611tEFi1nnu5pqIBMxlQmSF+6DFVvWZNfPp8FrUHf
         Qlstp+9BNYfdrpHHYgHB+wNvPAogmce7QW7KuR5EXFaAROXdktPNfNBmaSyTG7BJmo2j
         eKMaWr0iYcuq1SQkkY8t0E6Qbw/+cDtfK9ji2zNXZ0fMvL6tb4HBweI3Y2Ks8FkgxjBe
         PHmHaG6n2d6m1nTXRJJRl1sPzoQpkUVO+Z635W8cVsoCCZq9E7wioJSZskGE75Lxcunz
         GSyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ShOnvvH2vqswW8cX/k2qHv7+hfeakBkSeirHaU9mNjk=;
        b=p7GYqv22+CTF8TNuPVPMEW1qdbcBlIAKOfwt+zWLFLlZdbAhNDq+/FH5POlXO/CjO9
         iqxxvvNehYAlhfHtjRJfbV7FUjRp8WwSfZ/reKC//I/WMiKkGxngbdumt9X62YhgfqxE
         7LqHRULJSJ9dQ4p9JRCjtQNo5IyEnOKUJ6I3rtQxHOz7e7oMxrEJ/QrVVI4mD82isIzy
         OwObjmx+V4tryNK0JtU74MWwxOw3wX2tpd9HtNVvJwpFC/E9qdxgEQDVBcMTsL5lZBer
         nQs9Vfl4vl995Rg/3sdGra7r+7V1Utvg+hup2RebY+cuwfBsjudQSE6V7OWBpwVuW609
         on4A==
X-Gm-Message-State: ACrzQf2rxm1JOz2fFlBZrTSacKnXKGjjntAX/g8uCg7w8UpqKVAl7a/F
        hsWWpKBZtXQftw5wFjpZYFJTpLL8JzNMzyVK
X-Google-Smtp-Source: AMsMyM5bZFrApBftBWKyAHJtdil0L36X58rCbV5yTP9e8DBlnEnRqZft4r2H2uxeBBPKi0jbeZNRzA==
X-Received: by 2002:adf:f8ca:0:b0:226:e456:1896 with SMTP id f10-20020adff8ca000000b00226e4561896mr2052765wrq.177.1663315406781;
        Fri, 16 Sep 2022 01:03:26 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:9ab:1164:827a:1548])
        by smtp.gmail.com with ESMTPSA id c9-20020adffb49000000b00228dbf15072sm4418116wrs.62.2022.09.16.01.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 01:03:25 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com
Cc:     qais.yousef@arm.com, chris.hyser@oracle.com,
        valentin.schneider@arm.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v4 7/8] sched/core: support latency priority with sched core
Date:   Fri, 16 Sep 2022 10:03:04 +0200
Message-Id: <20220916080305.29574-8-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220916080305.29574-1-vincent.guittot@linaro.org>
References: <20220916080305.29574-1-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Take into account wakeup_latency_gran() when ordering the cfs threads.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6cc4f2a9725d..7563fb16aba1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11444,6 +11444,10 @@ bool cfs_prio_less(struct task_struct *a, struct task_struct *b, bool in_fi)
 	delta = (s64)(sea->vruntime - seb->vruntime) +
 		(s64)(cfs_rqb->min_vruntime_fi - cfs_rqa->min_vruntime_fi);
 
+	/* Take into account latency prio */
+	delta -= wakeup_latency_gran(sea, seb);
+
+
 	return delta > 0;
 }
 #else
-- 
2.17.1

