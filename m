Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2ACC6FA128
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 09:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbjEHHgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 03:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEHHgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 03:36:04 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8752AE79
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 00:36:02 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6434e263962so3086235b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 00:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1683531362; x=1686123362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ygLFz5lp7rVG8bpNJQZRYXuv/EyC+2NG5vRieXJ/Ap8=;
        b=FyIHeGMOiWrw78c7PCs2FMcBOLTKivUYGJ2768dgYJR+8an+EDAR4x7uItpduIWTzU
         r3URbPVfohXVMN/WJm07/WX5k8IFehcJCsS7pXvIZKpfs/xQ39gsm01Jhv9tw1/V0rGX
         ktD8RFRlllYGE9GQgnJmJgZJpFt6ma9c+Rw/y69oL2NzbVvrjhVn3X29ZU3jRRyJFXD8
         GEQ2N1WATV+Fc4Zf0wQjLqUxv9/gdWBaqOS/7+btth/HpO9viXn4jEV2HkDh9HfvJq1V
         WksHGDX5O1eCgJ4+ApOTiwmmwdNtVecRSVtJdHBNOuInKRn1MEYMO6lUABHYknzvpdgy
         nxDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683531362; x=1686123362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ygLFz5lp7rVG8bpNJQZRYXuv/EyC+2NG5vRieXJ/Ap8=;
        b=CgTtgv8MZ07kwZMl8jN66QtDvUTjk8elMEXXEGqckRNUIG+lbV5LIOYuXcHD/9+OQ0
         98p3KAJGeVEo245KiCrZI2aKxC7sngN9fwGcABKw5J9Cny/sShbvoSo1DVmovXcFd7fT
         WPacf7iv9BJtsj4f8HuwJ4vzJ0LLkkoWsh1n+IVybZ58qiRELtg0apgq1vsFw8Tmi96+
         SqtfRNNC+54EEhButjz09PpokhihsK5wdR59nh+FraNwMKERWS0ypN5U4M18FaZRlqDp
         NqeunhCNTfKkbit+lXTOfSedNuLc8EDj5M57yHlu3rI0FsWhtUo5FiSEdeQHINHA1nW3
         y5Xg==
X-Gm-Message-State: AC+VfDwa6G5YU7dqCJSuzglFf3igdb0XaQNQ6tA1dd4qJMv8iKsUamsU
        HIIQHzT+Z/EFQBa4BjhffAAOYg==
X-Google-Smtp-Source: ACHHUZ7KhMkV6amOYcooRe8a2MSv80Mbw85ivjMJdfvDakq9Lpf5YmoCv6gQiClktKk2+7BRtmd6EA==
X-Received: by 2002:a05:6a20:7489:b0:f2:9378:814a with SMTP id p9-20020a056a20748900b000f29378814amr12094355pzd.49.1683531361867;
        Mon, 08 May 2023 00:36:01 -0700 (PDT)
Received: from ubuntu-hf2.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id y13-20020a655b0d000000b00502ecc282e2sm5377276pgq.5.2023.05.08.00.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 00:36:01 -0700 (PDT)
From:   Haifeng Xu <haifeng.xu@shopee.com>
To:     mhocko@suse.com
Cc:     shakeelb@google.com, hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH] mm, oom: do not check 0 mask in out_of_memory()
Date:   Mon,  8 May 2023 07:35:38 +0000
Message-Id: <20230508073538.1168-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 60e2793d440a ("mm, oom: do not trigger out_of_memory
from the #PF"), no user sets gfp_mask to 0. Remove the 0 mask check
and update the comments.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
---
 mm/oom_kill.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 044e1eed720e..612b5597d3af 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -1130,12 +1130,10 @@ bool out_of_memory(struct oom_control *oc)
 
 	/*
 	 * The OOM killer does not compensate for IO-less reclaim.
-	 * pagefault_out_of_memory lost its gfp context so we have to
-	 * make sure exclude 0 mask - all other users should have at least
-	 * ___GFP_DIRECT_RECLAIM to get here. But mem_cgroup_oom() has to
-	 * invoke the OOM killer even if it is a GFP_NOFS allocation.
+	 * But mem_cgroup_oom() has to invoke the OOM killer even
+	 * if it is a GFP_NOFS allocation.
 	 */
-	if (oc->gfp_mask && !(oc->gfp_mask & __GFP_FS) && !is_memcg_oom(oc))
+	if (!(oc->gfp_mask & __GFP_FS) && !is_memcg_oom(oc))
 		return true;
 
 	/*
-- 
2.25.1

