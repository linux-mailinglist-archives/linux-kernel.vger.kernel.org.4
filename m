Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBFC860AF7E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 17:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbiJXPvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 11:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbiJXPvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 11:51:12 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509FE8768F;
        Mon, 24 Oct 2022 07:45:22 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id l32so6730453wms.2;
        Mon, 24 Oct 2022 07:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aRj1cqu6ZDGIi0GvzZmHfr4LAYPZfxkfNSfRcqY4dyA=;
        b=NHcjGBQp4SKHvwjl+StT6XdDtmgvDaf23lrNvgs4/Cn8kibjjcgons46bofssI5bg4
         x7sOB1WLbd3o0NjfwMBtCYpcl/hI5sN6jcnbygYLyY4nZeFKxt3NxFweiGXKUXvnr1QR
         FmPNn2XpFYKJeHOEQXVAZ3BRqh4XFT2uj8wVsagBC+LWXhp36OaEHB65n2BUSy2iIf1T
         hNyyJ4vwX1dW3B5s6wCpTLxfN9oVWOFAKJQM7cedbgX45oZAgU1PV5CKh2zOp/JbXTLn
         YlpbSPvfA+k1z/qm2zNxIbLPwqfpimplvFzS5aFy7CC8xD9e22k/sqviP086EXl2i2e8
         DjiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aRj1cqu6ZDGIi0GvzZmHfr4LAYPZfxkfNSfRcqY4dyA=;
        b=h+MWchCLzz52wuRY8/+qaYVwYPtliixEuvzQFbqMiQTrRlJkKP195FflvVCxTXj01W
         SffZW+tvDXb861VDtA4/6ztoX1AGpPT4kje3FF5qMwNhCNJht7dS9s0AsBDhSu+7mTeB
         ZFDyL5DIlzij9TpqkF1cpCswcx+siQIVPKJjhl1lUATtDaFG2YNTIGqaaazCEgqZi4fV
         HOSKC96wpIxTQ/otxOVV+xV/bG1/ubNpuDjMaZVDPzlXdj+8bKrsMNaf34y8lDZUhIyh
         fHeT5tmPbzKiXLXx0dxHPfRx8yuxLQRiogBTko88f0KkPV8761qHFf27u0bRl0x/5okt
         giNQ==
X-Gm-Message-State: ACrzQf02RfQ3GFPlHeNM/xtw9/0wf4jgylo8l3yk/1lCVfYz/Px4W2OI
        0nOeGh8TTw88ccQuFgSmKBkOIoXUtB8trDHb
X-Google-Smtp-Source: AMsMyM4zk5qjWz0R3AOZmyDJE7Bfs+4pAoZbge5x5b0BeN2Sw6aLUcBPETtPkUGrv2z5FRJ2WzeX1Q==
X-Received: by 2002:a05:600c:35c4:b0:3c7:1831:6d8f with SMTP id r4-20020a05600c35c400b003c718316d8fmr12816588wmq.48.1666618982676;
        Mon, 24 Oct 2022 06:43:02 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id j18-20020adff552000000b002365730eae8sm8912690wrp.55.2022.10.24.06.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 06:43:02 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iommu: remove variable cnt
Date:   Mon, 24 Oct 2022 14:43:01 +0100
Message-Id: <20221024134301.2158939-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable cnt is just being incremented and it's never used
anywhere else. The variable and the increment are redundant so
remove it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/iommu/amd/iommu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index d3b39d0416fa..3847f3bdc568 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -767,7 +767,7 @@ EXPORT_SYMBOL(amd_iommu_register_ga_log_notifier);
 
 static void iommu_poll_ga_log(struct amd_iommu *iommu)
 {
-	u32 head, tail, cnt = 0;
+	u32 head, tail;
 
 	if (iommu->ga_log == NULL)
 		return;
@@ -780,7 +780,6 @@ static void iommu_poll_ga_log(struct amd_iommu *iommu)
 		u64 log_entry;
 
 		raw = (u64 *)(iommu->ga_log + head);
-		cnt++;
 
 		/* Avoid memcpy function-call overhead */
 		log_entry = *raw;
-- 
2.37.3

