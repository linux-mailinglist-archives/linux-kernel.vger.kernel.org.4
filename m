Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4AF6580AD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 17:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234674AbiL1QT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 11:19:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234445AbiL1QSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 11:18:47 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA17519C3A
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 08:17:31 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id fy4so16670204pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 08:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SbuT81cTqrWb06I08YNk/QYGpUnIYQwfiUqfqhuTPAs=;
        b=JwkluDZyi7Hbk8sR9WvMw++RLfzCX9DprsV3tjkhS2dzv1yi7hfwIIdDLn2zDn+WMU
         zXSx2D7xPxtwGEPFtzUYkN7s+Z2rUHQGfnEckae/t0WEY9i9Cens7510/Q4frn+bq0Y4
         R4qgF86gnbPdO0DZQD0FODtGrIwqZzwXERjL3YpRvaLQEMHDtYBGMWkEigYpLp3Pqf7M
         Ffap7EyGYsRbUb08/5RNkuPLE8UKKZN/qnC66e00Hrtx+ElVMdBQaWfukcJqMczec70i
         S45NoYIx8YZCIx6JUzPTBO9Sa1PjT5kB9FOnLI2LTd8HSUkWv5wQAgmy3yxVZZDN28z6
         3+yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SbuT81cTqrWb06I08YNk/QYGpUnIYQwfiUqfqhuTPAs=;
        b=vTfXkS1Gt2mdoIg2EmrwxCuBsBCPJwY+kZazcTAbyoM1euAbWXUZ000ZRgbkYBbvY2
         uvEFYDJfS8IjSQLc6g+Epvu47qzHpxVwZUblpD+ppQGftlONKIMNvodW/010Om+yMX7A
         ttBtfHEADeK9/UGSxWUWrOd7/uVpuP+wJXUEbpLtG5sr+2TwSUMf8VWyl4fOj6/Untu2
         v/I/VMPqnfCflU/kW+o+egf46Pwdzskbea/POijm1Q5hgzoXh/4hmgELh+oz9xnGJlW5
         FJqiUioxrVQOqqGUlyOEVaj+9HYkx0fqmEvRE2WITqykmq7aORUEaHUL04udUgDZxdcg
         +QgA==
X-Gm-Message-State: AFqh2kolr6GQIg0YB0wN0l8j8mLG6RjXics/GnLBvSZvLA2O8gds/VDr
        R8F+oso26kHWPRoQJ0jLr7Jh
X-Google-Smtp-Source: AMrXdXtGHOufEjAivRbcDgryAR6ZPswcvzR2crozMrc0bWmqfHtGbGBTW/roNQvygYIcdxVZ6G728g==
X-Received: by 2002:a17:902:be16:b0:188:f0eb:ce10 with SMTP id r22-20020a170902be1600b00188f0ebce10mr30387826pls.65.1672244251263;
        Wed, 28 Dec 2022 08:17:31 -0800 (PST)
Received: from localhost.localdomain ([117.217.178.100])
        by smtp.gmail.com with ESMTPSA id s3-20020a170902c64300b00186abb95bfdsm11256798pls.25.2022.12.28.08.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 08:17:29 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 4/6] bus: mhi: ep: Fix the debug message for MHI_PKT_TYPE_RESET_CHAN_CMD cmd
Date:   Wed, 28 Dec 2022 21:47:02 +0530
Message-Id: <20221228161704.255268-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221228161704.255268-1-manivannan.sadhasivam@linaro.org>
References: <20221228161704.255268-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The debug log incorrectly mentions that STOP command is received instead of
RESET command. Fix that.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/ep/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index 7d68b00bdbcf..0bce6610ebf1 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -226,7 +226,7 @@ static int mhi_ep_process_cmd_ring(struct mhi_ep_ring *ring, struct mhi_ring_ele
 		mutex_unlock(&mhi_chan->lock);
 		break;
 	case MHI_PKT_TYPE_RESET_CHAN_CMD:
-		dev_dbg(dev, "Received STOP command for channel (%u)\n", ch_id);
+		dev_dbg(dev, "Received RESET command for channel (%u)\n", ch_id);
 		if (!ch_ring->started) {
 			dev_err(dev, "Channel (%u) not opened\n", ch_id);
 			return -ENODEV;
-- 
2.25.1

