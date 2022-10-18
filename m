Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D836B60245B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 08:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbiJRG0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 02:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiJRG0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 02:26:06 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A1DA7AAC;
        Mon, 17 Oct 2022 23:25:53 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id s196so11180999pgs.3;
        Mon, 17 Oct 2022 23:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MYvjR3g96YfEQ0ewsYWqZk7cyUEKObEBSCZcF/olNgQ=;
        b=DJLHQ5hfoAbDCUNbz0QZQvIogzuJKKKs24q4fILB7q7h0ZaMw970yKPRmeUtBvpUoD
         cSdviupKi4vP4ua+AyO6cNjaCX44UQW1s4PSAs4EK7VQkOB+DHADafwt+7JfULanDNgi
         nZbcNbmTATpmC7WgFetn4OMXYzflslEOgGaWnCTdKiY+SiUxAsOTDKkPdQdXfVNlk2Xr
         GbuVEF/YffIhOVmW7qKRsfiRovt/BoG+4mfTLqPAR0jAdyebNPEl6ThMtryCYXkb/G1f
         7gdXX3cL7chK301bGbHfEBlV/5dSWVQgaSXncF0AnjwO9VmTVFg5oBqfa3rcHMJF7n+c
         zyFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MYvjR3g96YfEQ0ewsYWqZk7cyUEKObEBSCZcF/olNgQ=;
        b=qZiLPVmoacGqc0/Dp/PmyIKOZ2+Z/0UrSxzB/r+5sT79tdp99lFSRQbe2Ms7YRXdnU
         OfDYmdPAfxd9Aov6BF92jX6CoZPyhnqoJDQ0Gt/vPm7lgBLLhye8PiL+faTnzsMqVfNZ
         9Q7wwdiWi2jb25+LKOFcAo1cLxirLUDG/R2wyXPb3juHa+FE5LazXE5pMTh81U9RMBwa
         r9Aqg5t2urQ4eJa+YvAmjH2IY1TLh0sZqhc2kL9XN4SexxnXbr047sTkmdgdpg7O/7y8
         HBA6g07wl4aSdIevce+rvjACeMDuBjmwGyVK9BAkadCCOPHePlIm/5HlRJ0/Yqj63ZO/
         mztw==
X-Gm-Message-State: ACrzQf0fbuIKoM1g/T9u8WpbaKtMxQ7k+jKXQjT/PfzkqUWWduKKkDkS
        YUtm951lIM5moLZhCjKR4rD/kUdcv4Q=
X-Google-Smtp-Source: AMsMyM6xmbI68eieYRNV6FtgudrgCp1W0ORZiMBBgIF1oHpeB5ilIrFBwQhCvnSq7hmKG/lq8lPf7w==
X-Received: by 2002:a05:6a00:807:b0:563:136f:a4fe with SMTP id m7-20020a056a00080700b00563136fa4femr1658881pfk.36.1666074352645;
        Mon, 17 Oct 2022 23:25:52 -0700 (PDT)
Received: from carlis-virtual-machine.localdomain ([156.236.96.164])
        by smtp.gmail.com with ESMTPSA id p1-20020a1709027ec100b00172973d3cd9sm7672413plb.55.2022.10.17.23.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 23:25:52 -0700 (PDT)
From:   Xuezhi Zhang <zhangxuezhi3@gmail.com>
To:     deller@gmx.de, zhangxuezhi1@coolpad.com,
        wsa+renesas@sang-engineering.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] video: fbdev: sm501fb: onvert sysfs snprintf to sysfs_emit
Date:   Tue, 18 Oct 2022 14:25:48 +0800
Message-Id: <20221018062548.642910-1-zhangxuezhi3@gmail.com>
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

