Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19AFE719C72
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 14:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbjFAMr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 08:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbjFAMrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 08:47:55 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F403123;
        Thu,  1 Jun 2023 05:47:54 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b0314f057cso3089595ad.1;
        Thu, 01 Jun 2023 05:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685623674; x=1688215674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7draYKi8O8bY9wpEzwPd85VAVlOaAQazTlzk61kz37k=;
        b=mfj8jc21WKJhT/qxElCYvsyZMZvrzYH0y2VRVsz1o2Ixfe2g6kojtfVHpKZVUe66q7
         p/oUzXPuloa/KBguAEz04854ms5IKBa89iYQMrXYv67jcn9lI7VKaLVQE5qeSgUJmy4t
         jb6T+HVBIF7dYl7OQkwYxpqcOsckJiQOOxgeOlXMwFFaruIaCIYtBca4OUPxf8+iDmsy
         3Cn69moMWkO4RTKQk4vkGfOJ/ncI8wKle1lWsT9eaRxcnYQTWkD3biPfp4R32OTu+Gou
         4YOJb0Ktmy4GiVFtuW52+xBOZOFnLr+RA7fLpCQ6hLgEJtdm4OfmrnBTNYLpaYGCW1vL
         yieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685623674; x=1688215674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7draYKi8O8bY9wpEzwPd85VAVlOaAQazTlzk61kz37k=;
        b=AAOEQlrv7RaDrGG+Y0O6aX05BDQDMgdaUNtIX2px2P7YnkG9HTy7Wn9yPCWMEMcFO7
         iePB6GxscsuWIZG4lJfs0bep8ldT6wQhv4ZtGwv8eG4qrOsZqd8vlVOM7pjPv+P3jpRy
         QQIJyVka9qLzlNq5KOgFxme7uRwfSRkunfOuVTPKisDLMe18PeaSTH2Vt9pIDZhP+h5m
         HkuITN/pLA3lG0ni5RnR7kF/O1QHCguD2Y7JRTlGu0BS7+rjcF0MB/JFCfLbWbA4b+Is
         6kZ6snOPrsqPEpNn6CsD1MEdZ6W+a2IkGNM7k0tofSUm+jSS5sIrWnx0qzzmUbccONhZ
         2v6A==
X-Gm-Message-State: AC+VfDy+szO9VBYeSZQx0JYN/XDdvhrHNhXM17BHAevLSDS2sxMYbzpm
        tBMflE1UK5Gwws78VGlNAwg=
X-Google-Smtp-Source: ACHHUZ5VNZ5sy+s5T7CqaFiqvnvVZxxEDK8LXR+reufT1NEMzZIh2ZpS7FVC6ZWsYJD1KUHyQ7eN0A==
X-Received: by 2002:a17:902:930b:b0:1af:d213:668c with SMTP id bc11-20020a170902930b00b001afd213668cmr5240056plb.12.1685623673691;
        Thu, 01 Jun 2023 05:47:53 -0700 (PDT)
Received: from localhost.localdomain ([43.224.245.242])
        by smtp.gmail.com with ESMTPSA id u9-20020a170902e80900b001ab0669d84csm3418213plg.26.2023.06.01.05.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 05:47:53 -0700 (PDT)
From:   Zhang Hui <masonzhang.xiaomi@gmail.com>
X-Google-Original-From: Zhang Hui <zhanghui31@xiaomi.com>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Can Guo <quic_cang@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        zhanghui <zhanghui31@xiaomi.com>, Bean Huo <beanhuo@micron.com>,
        peng.zhou@mediatek.com, yudongbin@xiaomi.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] scsi: ufs: core: Fix ufshcd_inc_sq_tail function bug
Date:   Thu,  1 Jun 2023 20:46:14 +0800
Message-Id: <20230601124613.1446-1-zhanghui31@xiaomi.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhanghui <zhanghui31@xiaomi.com>

When qdepth is not power of 2, not every bit of the mask is 1, so
sq_tail_slot some bits will be cleared unexpected.

Signed-off-by: zhanghui <zhanghui31@xiaomi.com>
---
 drivers/ufs/core/ufshcd-priv.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
index d53b93c21a0c..319fba31c1f5 100644
--- a/drivers/ufs/core/ufshcd-priv.h
+++ b/drivers/ufs/core/ufshcd-priv.h
@@ -366,10 +366,11 @@ static inline bool ufs_is_valid_unit_desc_lun(struct ufs_dev_info *dev_info, u8
 static inline void ufshcd_inc_sq_tail(struct ufs_hw_queue *q)
 	__must_hold(&q->sq_lock)
 {
-	u32 mask = q->max_entries - 1;
 	u32 val;
 
-	q->sq_tail_slot = (q->sq_tail_slot + 1) & mask;
+	q->sq_tail_slot++;
+	if (q->sq_tail_slot == q->max_entries)
+		q->sq_tail_slot = 0;
 	val = q->sq_tail_slot * sizeof(struct utp_transfer_req_desc);
 	writel(val, q->mcq_sq_tail);
 }
-- 
2.39.0

