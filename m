Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7634C60261E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 09:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiJRHsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 03:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbiJRHsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 03:48:00 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5C26293F;
        Tue, 18 Oct 2022 00:47:52 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id p14so13361265pfq.5;
        Tue, 18 Oct 2022 00:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oYQUCwExhw/Gpp42oncI15bChvHsTTJdPx7zzXszYxc=;
        b=diWqSdGPpWLcYc5wVUgUAWU9mbRgKb1oWTLPkZ7UJQjwU8hrNt3+4HIfmxzQvaY1hD
         tCucGt9idZ0ENMca2PeEJpvNpcPG3yiUk+tcW8/k8o+EKPLpscOaPt6jFyNYSItLmXbp
         IQwfieBmhuZqtRiS6zQdVWDpVv6EdxGz+zVXFrxKMj4Pg5kZ1ZbW4Jr7sGBZN1eYJyzl
         R5ZdF2kdzCfS7kjUzBxzwJVlPKr/bk982Yq9n4Hcp1J34DNssOzx3os3JLR2lMCTN/rt
         OdWvk4Z1zBuMu0vupb9iXXAHmyHtZQH6bbLtolfvOq4sUQTPw42Anzq1Rs/dbN2LYS3G
         khZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oYQUCwExhw/Gpp42oncI15bChvHsTTJdPx7zzXszYxc=;
        b=ewAVjZsUrsfv3aS9zYPa4SSkOam2GlrEyh2Wjg1rGZ3uiE+5CPvu37xy5G/RxgDnPq
         fe2aUEttXoI0c4hxBpKwAqR0zPpwdZLHwB8GC+LKgO+FUUp11jsuWeWJ+SWRqbtbr1Js
         QxZTiqd7CpUA3UQzNfEq+QJmQsqWzexQj/jHJGeA6rEhknNb6JUVCloclyBDkwT40JGR
         4rXM8sc2JCpEf1HFAl1yB0DkL2rS+R80VAHWkpeExURrOmTEtbFdNu22VcaB5LNahYjw
         uBAonZesNorBZZNjcGTCOzdgoXubpox82OtzgS4UxzN4JXyLU/X2QgM2XLC0ak25+y0X
         1RPw==
X-Gm-Message-State: ACrzQf0scJXFme8dBb1f1OsseqUrYSXdCBuNqf+cyd4Ru/obg1Mo+gR7
        MWRnzCA4S7smvDb6l3KzQz4=
X-Google-Smtp-Source: AMsMyM5BDR4fAvT0NYnaUxjcEr6J7D9WQ72shCxLOvZ0V9r0T7BuJ/uOXSqT08/mEcXRpW3kPvh6nA==
X-Received: by 2002:a63:8648:0:b0:461:722b:ffc8 with SMTP id x69-20020a638648000000b00461722bffc8mr1663147pgd.118.1666079271984;
        Tue, 18 Oct 2022 00:47:51 -0700 (PDT)
Received: from carlis-virtual-machine.localdomain ([156.236.96.164])
        by smtp.gmail.com with ESMTPSA id d4-20020a62f804000000b005628a30a500sm8492393pfh.41.2022.10.18.00.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 00:47:51 -0700 (PDT)
From:   Xuezhi Zhang <zhangxuezhi3@gmail.com>
To:     deller@gmx.de, zhangxuezhi1@coolpad.com,
        wsa+renesas@sang-engineering.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] video: fbdev: sm501fb: convert sysfs snprintf to sysfs_emit
Date:   Tue, 18 Oct 2022 15:47:45 +0800
Message-Id: <20221018074745.922062-1-zhangxuezhi3@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xuezhi Zhang <zhangxuezhi1@coolpad.com>

Follow the advice of the Documentation/filesystems/sysfs.rst
and show() should only use sysfs_emit() or sysfs_emit_at()
when formatting the value to be returned to user space.

Signed-off-by: Xuezhi Zhang <zhangxuezhi1@coolpad.com>
---
v2:change onvert to convert in subject.
---
 drivers/video/fbdev/sm501fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/sm501fb.c b/drivers/video/fbdev/sm501fb.c
index fce6cfbadfd6..f743bfbde2a6 100644
--- a/drivers/video/fbdev/sm501fb.c
+++ b/drivers/video/fbdev/sm501fb.c
@@ -1166,7 +1166,7 @@ static ssize_t sm501fb_crtsrc_show(struct device *dev,
 	ctrl = smc501_readl(info->regs + SM501_DC_CRT_CONTROL);
 	ctrl &= SM501_DC_CRT_CONTROL_SEL;
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", ctrl ? "crt" : "panel");
+	return sysfs_emit(buf, "%s\n", ctrl ? "crt" : "panel");
 }
 
 /* sm501fb_crtsrc_show
-- 
2.25.1

