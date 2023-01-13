Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9560F6699DA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 15:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbjAMOPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 09:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242056AbjAMONx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 09:13:53 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD6E6A0F6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 06:12:49 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id h16so21184469wrz.12
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 06:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6TGebPqxsiNn0n5diQ98jmCY4ZYb1DFPf0O/f9N2dY=;
        b=kyoXFhhH4LSSWG6wMnAiaJ07jZSSGb0HZosWr9qzMojEznxN8iqtffNopToVMH/hUL
         HSaY1Cobj6yL8RFFk3xyrySF23tDrhRt8LAziuIYTh00/5o47whlA/ZFBFM9ylDKTxFb
         9EFinVeA81cLatWd6SqRGbpWGmlkmVG8EZed4HEvr+AN0C2rW8x4chbzfrnIS54JyJ6I
         Qbm/O6OMzFBNLWTO+oMb7JJhCWtZCEJCnmTlUCFxMNkAiUK2rwHwiU60qPQhW6lbzFyp
         +lDDdKUk9x57PDc9PGqF9Kmc9FzBaQJdyWVIrUZK4jp/KaNKJubP3jBIDRjMvoCUz+D4
         rAyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V6TGebPqxsiNn0n5diQ98jmCY4ZYb1DFPf0O/f9N2dY=;
        b=k82yvB5Xxw/6RTpk12h6EeC4qlcphnng6mLF896j1r9rDA/bPtvD4iKcePwz4ThK4z
         6q8mvTJCCgecbzULzNVFMrigrsNzRADSSmBKJthhCK+yDgngJR4rGo4jw0J04NNTxsAp
         lWjeyCuBpH/KfX/dJh8bM55dguBD36HlXl9SA+0lwRACKVFT0wm3fYnSAAhMQl5eoJhs
         RPn1KnmLPcYZrh40Bn0oo9YZEZTKjYSd0EfHu5d9Dk27v2O9oeW+KcfBuu45qqhfBGuH
         M+9SmhGar71lgospG2886DRpH4VyhYMl913B9DjPDRWbP/a2Pb5cYLaIgXIclh2H5P9d
         7ugA==
X-Gm-Message-State: AFqh2krh/cHksp7Q7dIf05Qoy0Zfnb4Qq2Px0rnvLXrEFQlt4+dMZ+Vh
        WIgAvGKgcCXcRG0h1t7y6l/w/Q==
X-Google-Smtp-Source: AMrXdXtwqotZ1lPmONqBdvc8S+tasAFspxeuEERqj2CJCrSy7i2iX3ieCrQLetXyp400jA63Dj0qdg==
X-Received: by 2002:a5d:4692:0:b0:2bb:e94c:fcbf with SMTP id u18-20020a5d4692000000b002bbe94cfcbfmr13297857wrq.52.1673619168889;
        Fri, 13 Jan 2023 06:12:48 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:1563:65bf:c344:661e])
        by smtp.gmail.com with ESMTPSA id f7-20020a5d6647000000b002bbeb700c38sm13869919wrw.91.2023.01.13.06.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 06:12:48 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        cgroups@vger.kernel.org
Cc:     qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v10 7/9] sched/core: Support latency priority with sched core
Date:   Fri, 13 Jan 2023 15:12:32 +0100
Message-Id: <20230113141234.260128-8-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230113141234.260128-1-vincent.guittot@linaro.org>
References: <20230113141234.260128-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Take into account wakeup_latency_gran() when ordering the cfs threads.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/fair.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 80ad27ddb4a1..a4bfa03d096c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11971,6 +11971,9 @@ bool cfs_prio_less(const struct task_struct *a, const struct task_struct *b,
 	delta = (s64)(sea->vruntime - seb->vruntime) +
 		(s64)(cfs_rqb->min_vruntime_fi - cfs_rqa->min_vruntime_fi);
 
+	/* Take into account latency prio */
+	delta -= wakeup_latency_gran(sea, seb);
+
 	return delta > 0;
 }
 #else
-- 
2.34.1

