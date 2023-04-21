Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83A16EA209
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 04:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233916AbjDUCwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 22:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233750AbjDUCvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 22:51:53 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF417D84;
        Thu, 20 Apr 2023 19:51:30 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-63b60366047so1513112b3a.1;
        Thu, 20 Apr 2023 19:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682045489; x=1684637489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8AHaFd45rL0q5b4AB3LAX24oOzN6BIEVC1RaqbCPXVU=;
        b=kilWJuIJweTRgBTwgFCwGu9lFsKgCOqZCxPqrZnLjD1QVK+XFkDNp2XuD+d81qgDhP
         GbCxA77d9pzcU4CDGX2f32KQ2wxlODcfSZQqzWPbjPQG/XVb4BMk+OoPVaeu8yBqD/nZ
         tKxdqKZuZ2+JLyTixbOJLEL/V8Oj72FHGk5nMRvlLUjbDuVxhI2GoJtMhWmtLjxTfRc2
         7iVSR6lx3r2gH32/oKvSkD9XTXegBICwHtrtzLq3MXu+QT52PIgVSCJZbgy1V/tPKUl6
         bt9GvindBpEKhbuYIGtwTF74485YSuFrlxtVVXfCIX+lc6JqiCeks/82b8HKH9024NzJ
         qY1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682045489; x=1684637489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8AHaFd45rL0q5b4AB3LAX24oOzN6BIEVC1RaqbCPXVU=;
        b=Z/FoNZ7umK6QzhQo7OrgReDm1S1hOT4gys1wB3jdgO6Wsrv2xTWHsutWThUdnEbwST
         4Au30H0tr5WZqi6jBoRdGibax5mcOLFabrOlcLsGwm/ys6w0UcRYOMEYWY851eLAPUOe
         93oEhGvX+13xuQkZiQ4ABCC8OLzB44Ss7ZMY7O8rFkmDoVw3UAw1ykvX4CMM9WSG12b9
         h0j2xVaCx4ZLb2Qrzh49wciGY69KMOLxDnfMtkpOytn81EMC8piPLvGEeXvwce/ZxNEM
         1uGmii5haV84EHpuAVVYgDvmY08vP51Powc6Uc1QsuaXvTBcMWGWETa6i1idyfk2xXA4
         /Jjg==
X-Gm-Message-State: AAQBX9cCacuF0ByUtkyTUR4eLncD1V96yY6DnWIqGrnyA2jHqRq4O8Gn
        X2lTCuT1w6H4KB7AMAHXLUUZm6Tmohg=
X-Google-Smtp-Source: AKy350br98lwPtK/oCaUCu1Sr/3XVVJszaE3p5fpyg1vr9SLs10BhdO9PcPxNFfj1oMvq0YlikENeA==
X-Received: by 2002:a05:6a00:1582:b0:63d:3ddb:5f3f with SMTP id u2-20020a056a00158200b0063d3ddb5f3fmr4982153pfk.0.1682045489387;
        Thu, 20 Apr 2023 19:51:29 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id z21-20020a62d115000000b0063d24fcc2b7sm1908694pfg.1.2023.04.20.19.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 19:51:29 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Tejun Heo <tj@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: [PATCH 21/22] media: coda: Use alloc_ordered_workqueue() to create ordered workqueues
Date:   Thu, 20 Apr 2023 16:50:45 -1000
Message-Id: <20230421025046.4008499-22-tj@kernel.org>
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
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org
---
 drivers/media/platform/chips-media/coda-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/chips-media/coda-common.c b/drivers/media/platform/chips-media/coda-common.c
index af71eea04dbd..c8ecfe760028 100644
--- a/drivers/media/platform/chips-media/coda-common.c
+++ b/drivers/media/platform/chips-media/coda-common.c
@@ -3268,7 +3268,7 @@ static int coda_probe(struct platform_device *pdev)
 						       &dev->iram.blob);
 	}
 
-	dev->workqueue = alloc_workqueue("coda", WQ_UNBOUND | WQ_MEM_RECLAIM, 1);
+	dev->workqueue = alloc_ordered_workqueue("coda", WQ_MEM_RECLAIM);
 	if (!dev->workqueue) {
 		dev_err(&pdev->dev, "unable to alloc workqueue\n");
 		ret = -ENOMEM;
-- 
2.40.0

