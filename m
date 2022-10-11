Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646735FAA8B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 04:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiJKCRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 22:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiJKCRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 22:17:01 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924867F255;
        Mon, 10 Oct 2022 19:17:00 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id w2so12316465pfb.0;
        Mon, 10 Oct 2022 19:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1/wC0Eu4EgrM8qtJEAF23x7NsVa9cSmWMf+ki3Mg8k=;
        b=jy+5aK91n/giLqv0SOzXLyieQ1E87FOO4CuFl3kpG5SCAKJthQ0uqecCaYhZV5OKgm
         skL2pG3I7Ai14IZ/tvnx9Tv6oVACAiq7pC/hckz0+zoD8YnXN5COKHkPHjTN5Q3spXNZ
         VGeXg7IGD21yq5zKzRXm9HVG0Y8eG9E05k4qbekLLg5YR/gIp+FZT3mdHrG6HkOlbuE8
         SGTP7KDdHJcq0y0ui3F/LeZyOxRGxVqzKbOOT/qahsIx8CurrA2Ppypvri2yNTS7rsvF
         9cX9Mhu9boboty+r2MbbE6pE0nlVA4S45IiXUOX1MCkxqhbJQHYBcguZdMcLBuzasTcB
         R1ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y1/wC0Eu4EgrM8qtJEAF23x7NsVa9cSmWMf+ki3Mg8k=;
        b=X4sbhsb/YTpdVcz9ZMqa9KxYjjFsVyBW/JFJr8BYgKwlgNY5/dEygaIXsL29waOl87
         3keBOYcfZwkzNe8pdTBehteDZCqMxj4tDtJw4N6COgWEUgDQtTGXIn9opt+SyhBdD5gF
         3nNp3RB3cCiP3/Kd1rx0KPJyk0uL+CJR+PVO1qNeVbLnpX90oga6+/eIm+vAgwFDeZZ1
         R188io6xVpVxexADkycFlFcStF3at16SG34cD5NKdZC8p6O23SoYTopN0+fS9w7QGvxA
         7OKQuuedBsrpzZlLoQaJ27m/xDuXmWEHtrNS0TVKRbp7XOLFSNgKbXx7IDH4jS0BA//U
         DvJw==
X-Gm-Message-State: ACrzQf2Ere90GMuYk/pjCGw9NFQHC14+8u3Yoq927KIIuNlmnYxwDVDx
        /lzCvyJ+aiXV7j1sD0AbVDU=
X-Google-Smtp-Source: AMsMyM5AZgrCii1enUmH0t9ar+88GsxqzNJbYBP6dmx13dARsU8a7vfIG1Yloc2Ew/AaHy6/zwJtVw==
X-Received: by 2002:a63:4383:0:b0:440:3e0d:b9ec with SMTP id q125-20020a634383000000b004403e0db9ecmr19970610pga.54.1665454619709;
        Mon, 10 Oct 2022 19:16:59 -0700 (PDT)
Received: from zeshkernups01.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id t10-20020a65408a000000b00451f4071151sm6820788pgp.65.2022.10.10.19.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 19:16:59 -0700 (PDT)
From:   Ten Gao <gaoyankaigeren@gmail.com>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Bean Huo <beanhuo@micron.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ufs: core: Disable auto h8 before ssu
Date:   Tue, 11 Oct 2022 10:16:53 +0800
Message-Id: <20221011021653.27277-1-gaoyankaigeren@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ten Gao <ten.gao@unisoc.com>

Ensure auto h8 will not hit dme h8,and there won't be two h8 in a row
after ssu.

Signed-off-by: Ten Gao <ten.gao@unisoc.com>
---
 drivers/ufs/core/ufshcd.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index a202d7d5240d..42f93648d796 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -4256,6 +4256,14 @@ void ufshcd_auto_hibern8_update(struct ufs_hba *hba, u32 ahit)
 }
 EXPORT_SYMBOL_GPL(ufshcd_auto_hibern8_update);
 
+void ufshcd_auto_hibern8_disable(struct ufs_hba *hba)
+{
+	if (!ufshcd_is_auto_hibern8_supported(hba))
+		return;
+
+	ufshcd_writel(hba, 0, REG_AUTO_HIBERNATE_IDLE_TIMER);
+}
+
 void ufshcd_auto_hibern8_enable(struct ufs_hba *hba)
 {
 	if (!ufshcd_is_auto_hibern8_supported(hba))
@@ -9036,6 +9044,8 @@ static int __ufshcd_wl_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 	if (ret)
 		goto enable_scaling;
 
+	ufshcd_auto_hibern8_disable(hba);
+
 	if (req_dev_pwr_mode != hba->curr_dev_pwr_mode) {
 		if (pm_op != UFS_RUNTIME_PM)
 			/* ensure that bkops is disabled */
-- 
2.17.1

