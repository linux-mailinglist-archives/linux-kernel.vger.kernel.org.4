Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAFC96FBCB3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 03:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbjEIBvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 21:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbjEIBuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 21:50:54 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB43AD0E;
        Mon,  8 May 2023 18:50:44 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1aafa03f541so51937305ad.0;
        Mon, 08 May 2023 18:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683597043; x=1686189043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NrqNc+2n+X33D/fyVH+5OCxvofzF9jLKnUEj7w+cHec=;
        b=qTyTEfIWrUl9clnLrbs+ALzV4ZhzxV2eoI+Kuj2xBGhIyJVv0N3NVspv9peRBOHID1
         sPkT+dUsRKrBL8q+TKygynxiD3IlS0YGAOBz9jbme2oVJmrHo2yX8wKEVovFxi2mbUs1
         W1f3bGszis45Hl34x16mfSstXnM+F5hYajB0Es9XjcBl7GezD8hH6OtU8lXC7ZfsV7YA
         2mFqfp3eQXVWdIGW049QdLTN4oSAzkXW/VD1LLM3R9+jfT+9kWH800fo7mv0VFmRDCA3
         UuThLAjMEfwOxJjQol6FL2YKoUUsoTWU3mcZmhsGwqo1zqvatM1efVr/wx419Z5hOMom
         bT1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683597043; x=1686189043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NrqNc+2n+X33D/fyVH+5OCxvofzF9jLKnUEj7w+cHec=;
        b=XFC+oOKBrNS7AMwdBrqepBVUoyRcjgD5dEFuv+Qdz4trGSBPWpgi8mTingmoGuMjKf
         6UGtUt/1qcd/fNXWMOJs8kZgkA5rf+4a/IP9vBRSDokeifaPvYLJVdydR3/MVLNKACmW
         cCcMukwPDK3+cT8Ug4jiMteP1mL6yU1qtmVFj6e+6h12KrV9JeWD7U8cjxe5GufrZpQ4
         EydtDy7VfXG/IbZMC3feh9RMEoPlLw1onXsqmi2CGulBWl+vKzTI3ICZpsZA2tYN0KZ3
         k7rG021yqDYyCmf++8jlgfExjCfxSDeLajZ+uBx+qNXm/7k9atxYa6hYCM/FSPF0Tn8q
         OqFg==
X-Gm-Message-State: AC+VfDz3cratzc3W5h0IyT3QVMXskbb6MsiPFwkABjxEASEsGX7TypJP
        LCfgD1j1JhiCAh5QhEKOrv4=
X-Google-Smtp-Source: ACHHUZ42FE//i0L4Sin9FHyiLrlzv+HHMIgvNF2bWG8qG5oOI+1HoQR2s8x4fTKQKdTgTqSRlejXAQ==
X-Received: by 2002:a17:903:2289:b0:1a6:84be:a08f with SMTP id b9-20020a170903228900b001a684bea08fmr14901133plh.64.1683597043293;
        Mon, 08 May 2023 18:50:43 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902d50400b001a9af8ddb64sm123818plg.298.2023.05.08.18.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 18:50:42 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Tejun Heo <tj@kernel.org>, Ming Qian <ming.qian@nxp.com>,
        Shijie Qin <shijie.qin@nxp.com>,
        Zhou Peng <eagle.zhou@nxp.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: [PATCH 04/13] media: amphion: Use alloc_ordered_workqueue() to create ordered workqueues
Date:   Mon,  8 May 2023 15:50:23 -1000
Message-Id: <20230509015032.3768622-5-tj@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509015032.3768622-1-tj@kernel.org>
References: <20230509015032.3768622-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BACKGROUND
==========

When multiple work items are queued to a workqueue, their execution order
doesn't match the queueing order. They may get executed in any order and
simultaneously. When fully serialized execution - one by one in the queueing
order - is needed, an ordered workqueue should be used which can be created
with alloc_ordered_workqueue().

However, alloc_ordered_workqueue() was a later addition. Before it, an
ordered workqueue could be obtained by creating an UNBOUND workqueue with
@max_active==1. This originally was an implementation side-effect which was
broken by 4c16bd327c74 ("workqueue: restore WQ_UNBOUND/max_active==1 to be
ordered"). Because there were users that depended on the ordered execution,
5c0338c68706 ("workqueue: restore WQ_UNBOUND/max_active==1 to be ordered")
made workqueue allocation path to implicitly promote UNBOUND workqueues w/
@max_active==1 to ordered workqueues.

While this has worked okay, overloading the UNBOUND allocation interface
this way creates other issues. It's difficult to tell whether a given
workqueue actually needs to be ordered and users that legitimately want a
min concurrency level wq unexpectedly gets an ordered one instead. With
planned UNBOUND workqueue updates to improve execution locality and more
prevalence of chiplet designs which can benefit from such improvements, this
isn't a state we wanna be in forever.

This patch series audits all callsites that create an UNBOUND workqueue w/
@max_active==1 and converts them to alloc_ordered_workqueue() as necessary.

WHAT TO LOOK FOR
================

The conversions are from

  alloc_workqueue(WQ_UNBOUND | flags, 1, args..)

to

  alloc_ordered_workqueue(flags, args...)

which don't cause any functional changes. If you know that fully ordered
execution is not ncessary, please let me know. I'll drop the conversion and
instead add a comment noting the fact to reduce confusion while conversion
is in progress.

If you aren't fully sure, it's completely fine to let the conversion
through. The behavior will stay exactly the same and we can always
reconsider later.

As there are follow-up workqueue core changes, I'd really appreciate if the
patch can be routed through the workqueue tree w/ your acks. Thanks.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Ming Qian <ming.qian@nxp.com>
Cc: Shijie Qin <shijie.qin@nxp.com>
Cc: Zhou Peng <eagle.zhou@nxp.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org
---
 drivers/media/platform/amphion/vpu_core.c | 2 +-
 drivers/media/platform/amphion/vpu_v4l2.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/amphion/vpu_core.c b/drivers/media/platform/amphion/vpu_core.c
index de23627a119a..43d85a54268b 100644
--- a/drivers/media/platform/amphion/vpu_core.c
+++ b/drivers/media/platform/amphion/vpu_core.c
@@ -254,7 +254,7 @@ static int vpu_core_register(struct device *dev, struct vpu_core *core)
 	if (vpu_core_is_exist(vpu, core))
 		return 0;
 
-	core->workqueue = alloc_workqueue("vpu", WQ_UNBOUND | WQ_MEM_RECLAIM, 1);
+	core->workqueue = alloc_ordered_workqueue("vpu", WQ_MEM_RECLAIM);
 	if (!core->workqueue) {
 		dev_err(core->dev, "fail to alloc workqueue\n");
 		return -ENOMEM;
diff --git a/drivers/media/platform/amphion/vpu_v4l2.c b/drivers/media/platform/amphion/vpu_v4l2.c
index 6773b885597c..a48edb445eea 100644
--- a/drivers/media/platform/amphion/vpu_v4l2.c
+++ b/drivers/media/platform/amphion/vpu_v4l2.c
@@ -740,7 +740,7 @@ int vpu_v4l2_open(struct file *file, struct vpu_inst *inst)
 	inst->fh.ctrl_handler = &inst->ctrl_handler;
 	file->private_data = &inst->fh;
 	inst->state = VPU_CODEC_STATE_DEINIT;
-	inst->workqueue = alloc_workqueue("vpu_inst", WQ_UNBOUND | WQ_MEM_RECLAIM, 1);
+	inst->workqueue = alloc_ordered_workqueue("vpu_inst", WQ_MEM_RECLAIM);
 	if (inst->workqueue) {
 		INIT_WORK(&inst->msg_work, vpu_inst_run_work);
 		ret = kfifo_init(&inst->msg_fifo,
-- 
2.40.1

