Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4314E6EA1E7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 04:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbjDUCvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 22:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233699AbjDUCvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 22:51:06 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCD86EB9;
        Thu, 20 Apr 2023 19:51:01 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-247122e9845so1180197a91.0;
        Thu, 20 Apr 2023 19:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682045460; x=1684637460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67LgqNT8XF4vwy6yP32eHkU2I1u0Y3vukwyzktySQbU=;
        b=ZiAbVoUZ8IJAvox8IcFlDfaPh+VjoBXLmk6VAgIov93QLpk2pLax3y6rXcov36Ldwu
         vpOMojneq8Km6ua5QR8wSfoPVEPpscDPScZeepJ7zfN+3badZWA3SHeJXMjD2pwdkhGb
         vPeMUQ7KlKoxz1V2kEeNA2ueeYAYmySfRamPHAPEckyonnguEcP0WtfyngHomfQ4alcJ
         1PYEaUKSL9FghM7WlQernDRjNWvawyRwvBLatXB/MZENORCKFR+W2Zp7opGS1hMYGR1H
         Xj4v9NlzxiP+br94U+xXJp6izZ/+DT1OvWx7LelKejYjbPDhd3qUUJipzuxJ03KHGBV+
         pUsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682045460; x=1684637460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=67LgqNT8XF4vwy6yP32eHkU2I1u0Y3vukwyzktySQbU=;
        b=cj6ug0K2Lj0LvW3pZooOj8/iE/SHIVL+3D4EKcEjcwc2OFR0+jUpTSr+UoCzbeHPSE
         Dk3Z1IjIqeYoy8TLjaXs2lrj47vtid2NcwxocdbToeiuFVXVQUcfj0qNT/jq+wo7qhdB
         LIFWTRLgvoF40umkhVHhbL1o38UNQrxUPWUNwpGkkglPUEwwoxqfsusGcgPicJ68tiEA
         wKoeyVsLwez0UOjeFcEgwUusK9R9M3QlZstjLTv9N7VPKx0yji1arfVi8VSG2Wox9lqS
         hV5V94F/iJC8jb0jLsETWcYRDJBS8vcOjFyyTcAgNM+3ox/AT65Gd7uXMN33DXQbsgL5
         TbSg==
X-Gm-Message-State: AAQBX9cREaDSwj1V+Afk1hvHmFEzmUILZvfo+QDaFjDJCfQeu9jBcWwi
        LnyOfHEfO7sthaoJbDZ+5OI=
X-Google-Smtp-Source: AKy350ZYr+N8r41JuwzmIMgGzxWuOG+gKGnToOJFJc5nn8AIZ3wgdSVHFaVF8j1iwe2ohapy4B4hgw==
X-Received: by 2002:a17:90a:d14f:b0:24b:6349:4f87 with SMTP id t15-20020a17090ad14f00b0024b63494f87mr1686085pjw.6.1682045460086;
        Thu, 20 Apr 2023 19:51:00 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id d4-20020a170902b70400b001a681d123a0sm1717302pls.297.2023.04.20.19.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 19:50:59 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Tejun Heo <tj@kernel.org>, Ming Qian <ming.qian@nxp.com>,
        Shijie Qin <shijie.qin@nxp.com>,
        Zhou Peng <eagle.zhou@nxp.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: [PATCH 05/22] media: amphion: Use alloc_ordered_workqueue() to create ordered workqueues
Date:   Thu, 20 Apr 2023 16:50:29 -1000
Message-Id: <20230421025046.4008499-6-tj@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230421025046.4008499-1-tj@kernel.org>
References: <20230421025046.4008499-1-tj@kernel.org>
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
index f9ec1753f7c8..57d56c680c07 100644
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
2.40.0

