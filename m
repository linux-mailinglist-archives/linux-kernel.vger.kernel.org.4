Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178D26F5C08
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 18:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjECQaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 12:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjECQaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 12:30:19 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8746768D
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 09:30:06 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-24de2954bc5so3379325a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 09:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683131406; x=1685723406;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dN+c7N82AqaEGkqMTuZ0QlZ/AB20yNlAiJ4wXRNuemc=;
        b=B9XhIyP4wuPb7sTXlB7ROOFqJMWcFJkAV42K1gOm5rlALwMS/6uPbbIMgps6In2iV8
         0oWBF77nGrHtTtw0mziyRO2M8Uv3dTnPK0pt4tCPowSFQYhJB4F17HBg8iGOKNfUTF4A
         qqy52KJXU6eo8YmiF7Yv4qGdBdr1vdCvNgLwuqXFCGOBP/36SCVS5UijY0RsH4XU+z10
         PufouWv/j517g8affobMfljQMe3AnnKzNkVTh5MLDJ3wxx8qgHA2iTyF7hKZRect7Hie
         9bTEunIO6kN58+UzDnNZtM1vvbNgRKzAgkeXaOYOqm3mgzLeuY1oFcDLc0yF+Q+e7LiC
         qVfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683131406; x=1685723406;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dN+c7N82AqaEGkqMTuZ0QlZ/AB20yNlAiJ4wXRNuemc=;
        b=KDof/Nitz8NqO3TJkKWp+ICcUtnMTFTe0y1maHgPG9OIjp4VjRBFPFUDEnIl+d8bkc
         KLMug7SjZddt5H4qpH2JfbTH+wdihJgUVcyEtJEeZQhvR+r3F7+DwzWjpMX2HWOB28x6
         ihKUUSyJslnhR3/4njJvRUWE+YZcuYPNrTJEIEmBe5z85iqK25ss1Y7I/DAYgmoRf/Dw
         IaosFGLnwZi9reCD3463qAX6g8XP/mtEje63Gf5njFneRBmiWsFOhVYO6upfIIrEtfAn
         Brbjbsci+PP5hKD7IH8aU6CId1SOiEzVBLrKjOXu5+zxpMUgFTi0HHqmGEdkmiBa4oku
         wKYg==
X-Gm-Message-State: AC+VfDxodqG0+BHF8Yjeu1QOQPoRO1Um9qiuAV+4PMl3/hj2FPNINuBT
        51mNzYXRKFeK9Ze0pM+weeJDIVLWcIY5iP03
X-Google-Smtp-Source: ACHHUZ4eziCQdP7R+XAFDLZ3H7Rwqrg2KJun784oDj49Ybx2Pf+GBdWGdUNloiJ/mSiVZhquSUFQXw==
X-Received: by 2002:a17:90a:ebc5:b0:24e:2021:b410 with SMTP id cf5-20020a17090aebc500b0024e2021b410mr7026170pjb.14.1683131406080;
        Wed, 03 May 2023 09:30:06 -0700 (PDT)
Received: from MSI-FindNS.localdomain ([2a06:f901:c00a:2::2])
        by smtp.gmail.com with ESMTPSA id k1-20020a170902760100b001a1adbe215asm21836293pll.142.2023.05.03.09.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 09:30:05 -0700 (PDT)
From:   Yue Zhao <findns94@gmail.com>
To:     keescook@chromium.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, Yue Zhao <findns94@gmail.com>
Subject: [PATCH] lkdtm: replace ll_rw_block with submit_bh
Date:   Thu,  4 May 2023 00:29:44 +0800
Message-Id: <20230503162944.3969-1-findns94@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function ll_rw_block was removed in commit 79f597842069 ("fs/buffer:
remove ll_rw_block() helper"). There is no unified function to sumbit
read or write buffer in block layer for now. Consider similar sematics,
we can choose submit_bh() to replace ll_rw_block() as predefined crash
point. In submit_bh(), it also takes read or write flag as the first
argument and invoke submit_bio() to submit I/O request to block layer.

Fixes: 79f597842069 ("fs/buffer: remove ll_rw_block() helper")

Signed-off-by: Yue Zhao <findns94@gmail.com>
---
 Documentation/fault-injection/provoke-crashes.rst | 2 +-
 drivers/misc/lkdtm/core.c                         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/fault-injection/provoke-crashes.rst b/Documentation/fault-injection/provoke-crashes.rst
index 3abe84225613..1f087e502ca6 100644
--- a/Documentation/fault-injection/provoke-crashes.rst
+++ b/Documentation/fault-injection/provoke-crashes.rst
@@ -29,7 +29,7 @@ recur_count
 cpoint_name
 	Where in the kernel to trigger the action. It can be
 	one of INT_HARDWARE_ENTRY, INT_HW_IRQ_EN, INT_TASKLET_ENTRY,
-	FS_DEVRW, MEM_SWAPOUT, TIMERADD, SCSI_QUEUE_RQ, or DIRECT.
+	FS_SUBMIT_BH, MEM_SWAPOUT, TIMERADD, SCSI_QUEUE_RQ, or DIRECT.
 
 cpoint_type
 	Indicates the action to be taken on hitting the crash point.
diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
index b4712ff196b4..0772e4a4757e 100644
--- a/drivers/misc/lkdtm/core.c
+++ b/drivers/misc/lkdtm/core.c
@@ -79,7 +79,7 @@ static struct crashpoint crashpoints[] = {
 	CRASHPOINT("INT_HARDWARE_ENTRY", "do_IRQ"),
 	CRASHPOINT("INT_HW_IRQ_EN",	 "handle_irq_event"),
 	CRASHPOINT("INT_TASKLET_ENTRY",	 "tasklet_action"),
-	CRASHPOINT("FS_DEVRW",		 "ll_rw_block"),
+	CRASHPOINT("FS_SUBMIT_BH",		 "submit_bh"),
 	CRASHPOINT("MEM_SWAPOUT",	 "shrink_inactive_list"),
 	CRASHPOINT("TIMERADD",		 "hrtimer_start"),
 	CRASHPOINT("SCSI_QUEUE_RQ",	 "scsi_queue_rq"),
-- 
2.17.1

