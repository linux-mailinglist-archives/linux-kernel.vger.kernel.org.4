Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF7C63C818
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 20:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236821AbiK2TUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 14:20:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236708AbiK2TTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 14:19:13 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44196D497
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 11:18:49 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id v1so23666819wrt.11
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 11:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RzRSNAeuuRIbYSG2NCX+zxh9fy/BT36DuUkabjfuID0=;
        b=hU3Am/gYUqjHudQtJDUju2vr8CfSilaXZ0ahIokjG7+Q5DSLcU7keHM5GCF1i6IMYc
         aRdkKHSQMu7J3z4UmednTXiANLws0JwnWQER2ZURGW8gxutbJ3ysqfaEss6kXYYyK1kR
         GI2viLb0OS2Hz+7f3F2b9v4yk7rVRyxW4Er2Mt2Jo6yGR6creD6ZJMmE8SnFeCWClqgb
         7TQuRSmGrKjXc+1aCIhdZmDnE1kf/Sbi3HONQZFBS3631zco1W41l9ZKQXQGmad9CvJJ
         RT1nw2mROQpvduPEfDDuXpbzZyhy7ggwDYyx8pjCMP0TwCbq1gV+mSSbYNMqpAw510UE
         2Vzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RzRSNAeuuRIbYSG2NCX+zxh9fy/BT36DuUkabjfuID0=;
        b=jRO/4Ro6eIMFNO7QW4GFlX2VsO1aqTGE1RQLuhp8Huhph+B7j3N94t+BGirtkl2Ocl
         bt0xFbhQb4h30cuVplFo0NYhMMuPhaCHVn0IKjZzVjduXno4mkJI6SGDCobivJ+1JsYG
         75JV3awbC9ZTcHXSa5ptFfnWXLQeQ1dpAKGcDEIWsph69kAKlKhlyE6/884HA7b+ROjz
         jBmRzXxTFS42lxOu+FzRkyrO7V/cBvrG0RLUDlgtd0QKAVeyR/cychukNz/K3ZnV9Xu7
         iz5ZyWCxsA1hEtYaTrfTcFJStPZrvBgSbEfnfRP1hkRx3da2ue7qsx+qdXpOlBziRcFt
         fQMg==
X-Gm-Message-State: ANoB5pkw/MbDvYxnUDkH5Lc0dfmgvPUlEILwOc4nfYOFlVTkql5KCKfB
        hpN2bf97+GqMR/mVnSXicU89cg==
X-Google-Smtp-Source: AA0mqf5GOXoBFjCLlY5+0Is+UlLG+A1meoLbFGOcxEdnSM+1uZX9/oLeUV+jvPSu1ni1OEITYSK6ng==
X-Received: by 2002:adf:d84c:0:b0:236:6f1a:955 with SMTP id k12-20020adfd84c000000b002366f1a0955mr34792422wrl.111.1669749528257;
        Tue, 29 Nov 2022 11:18:48 -0800 (PST)
Received: from localhost ([2a00:79e0:9d:4:5011:adcc:fddd:accf])
        by smtp.gmail.com with ESMTPSA id g6-20020adffc86000000b00241c4bd6c09sm14467328wrr.33.2022.11.29.11.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 11:18:47 -0800 (PST)
From:   Jann Horn <jannh@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andrei Vagin <avagin@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] time/namespace: Forbid timens page faults under kthread_use_mm()
Date:   Tue, 29 Nov 2022 20:18:39 +0100
Message-Id: <20221129191839.2471308-2-jannh@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
In-Reply-To: <20221129191839.2471308-1-jannh@google.com>
References: <20221129191839.2471308-1-jannh@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

find_timens_vvar_page() doesn't work when current's timens does not match
the timens associated with current->mm.
v6 of the series adding this code [1] had some complicated code to deal
with this case, but v7 [2] removed that.

Since the vvar region is designed to only be accessed by vDSO code, and
vDSO code can't run in kthread context, it should be fine to error out in
this case.

Backporting note: This commit depends on the preceding refactoring patch.

[1] https://lore.kernel.org/lkml/20190815163836.2927-24-dima@arista.com/
[2] https://lore.kernel.org/lkml/20191011012341.846266-24-dima@arista.com/

Fixes: ee3cda8e4606 ("arm64/vdso: Handle faults on timens page")
Fixes: 74205b3fc2ef ("powerpc/vdso: Add support for time namespaces")
Fixes: dffe11e280a4 ("riscv/vdso: Add support for time namespaces")
Fixes: eeab78b05d20 ("s390/vdso: implement generic vdso time namespace support")
Fixes: af34ebeb866f ("x86/vdso: Handle faults on timens page")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
 kernel/time/namespace.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index 761c0ada5142a..7315d0aeb1d21 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -194,6 +194,17 @@ static void timens_setup_vdso_data(struct vdso_data *vdata,
 
 struct page *find_timens_vvar_page(struct vm_area_struct *vma)
 {
+	/*
+	 * We can't handle faults where current's timens does not match the
+	 * timens associated with the mm_struct. This can happen if a page fault
+	 * occurs in a kthread that is using kthread_use_mm().
+	 */
+	if (current->flags & PF_KTHREAD) {
+		pr_warn("%s: kthread %s/%d tried to fault in timens page\n",
+			__func__, current->comm, current->pid);
+		return NULL;
+	}
+
 	if (likely(vma->vm_mm == current->mm))
 		return current->nsproxy->time_ns->vvar_page;
 
-- 
2.38.1.584.g0f3c55d4c2-goog

