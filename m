Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774F1613AF7
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 17:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbiJaQFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 12:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbiJaQFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 12:05:16 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D00E6F;
        Mon, 31 Oct 2022 09:05:15 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j15so16649074wrq.3;
        Mon, 31 Oct 2022 09:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PxS8XgY58rZ4VDhvxJU0b70ZtHBRLLVJ+uq74m8Gs1k=;
        b=hyack7EcpOyiPwyjHRIHKJLQhbUrLp0AJ0zvFdHUmhnIu1lDq9s3eCKQUGhvadB5BV
         ciIzp2nvSz1F5UvDxW2KxqpNLj5SqNJX8SQoQpElrXCY2N7SYjwdRFl79IsJ19ekfRjv
         /ZStuu/HNZExyVH6SclWWed1UgV/TbpIkE7i3zzXPV1aBhXwLEAqH5dJdOKp01kWmo8p
         WamDMK/VUGacozrIBpoOkQKbb+TRLiADcsxJdlCsCX1QygqwcjaCZJG+mjEoJpvcyVWR
         SUtyNdg2tM6VJOsFz1d4eylVu2dC1OTmnTxMY4tA6EVe6WC3zhcu+bGvf16V8CQH7NJk
         a9GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PxS8XgY58rZ4VDhvxJU0b70ZtHBRLLVJ+uq74m8Gs1k=;
        b=8NrzF1iqXem0jvKcXhOYAwmnjFP5YBzZLtGfMtVIdukqmVfU40uTqmjmJHqHhV0Tk/
         whPa8Aa82VDWn1OaCGiyxsEL7UCID0u/jDDKIqrr2vlD1YVsu37dXJY2r5v6zWnPNN/n
         3GYAvs6HKqb+N27wgX1wXWtOPffIi5hihdJhKyhVwn3WWNEiIvn/ozJo+FOzhWC4eCFg
         t7ag7VWiEtYrbXtQgN1BMJGXsHdwuEQRXdYHPT37D52PpERoeXQIimrt6mLNpPBRYfvw
         8BHA/NB48EaGKBvk5LukuVl5Xso/5oRAmeOVxIxLuRLmq41ooe/FQDwxsrQxqJBY7OaA
         euLg==
X-Gm-Message-State: ACrzQf1aQSiSq0DKJ6mDPainxDcmDfx8mnPM3kPgFnv8DMeIWXgW/RmG
        8jky0x90YQ0A/SSyeOAXBYU=
X-Google-Smtp-Source: AMsMyM64PHIVLvhZ0ao1bjSFCKEssEVa+yDVwEWtssjXxawjpYqunUVt2os8vbzvf+uoeZuASHGAeQ==
X-Received: by 2002:adf:e288:0:b0:236:bf57:c2c6 with SMTP id v8-20020adfe288000000b00236bf57c2c6mr5719911wri.192.1667232313963;
        Mon, 31 Oct 2022 09:05:13 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id f7-20020adff987000000b0022e6178bd84sm7478829wrr.8.2022.10.31.09.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 09:05:13 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Khalid Aziz <khalid@gonehiking.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: BusLogic: remove variable adapter_count
Date:   Mon, 31 Oct 2022 16:05:12 +0000
Message-Id: <20221031160512.872153-1-colin.i.king@gmail.com>
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

Variable adapter_count is just being incremented and it's never used
anywhere else. The variable and the increment are redundant so
remove it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/scsi/BusLogic.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/BusLogic.c b/drivers/scsi/BusLogic.c
index f2abffce2659..f7b7ffda1161 100644
--- a/drivers/scsi/BusLogic.c
+++ b/drivers/scsi/BusLogic.c
@@ -2198,7 +2198,7 @@ static int blogic_slaveconfig(struct scsi_device *dev)
 
 static int __init blogic_init(void)
 {
-	int adapter_count = 0, drvr_optindex = 0, probeindex;
+	int drvr_optindex = 0, probeindex;
 	struct blogic_adapter *adapter;
 	int ret = 0;
 
@@ -2368,10 +2368,8 @@ static int __init blogic_init(void)
 					list_del(&myadapter->host_list);
 					scsi_host_put(host);
 					ret = -ENODEV;
-				} else {
+				} else
 					scsi_scan_host(host);
-					adapter_count++;
-				}
 			}
 		} else {
 			/*
-- 
2.37.3

