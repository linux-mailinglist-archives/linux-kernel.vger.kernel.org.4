Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D890A5BA8F3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 11:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbiIPJFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 05:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbiIPJFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 05:05:31 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27C042AF5;
        Fri, 16 Sep 2022 02:05:24 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso25060908pjk.0;
        Fri, 16 Sep 2022 02:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=5wYXv6h7BUTAj8YeKCpjQqh7oaJRQeKblQeCSUvyikQ=;
        b=EUN/NHGt3Mccz0AbBsC8hxf3inBxme2QlOnQ2P5bILE13SiFOf7meRU9cq7UrKq4Rj
         fM9olyHd+rRUHQ6/QCu+7pJ/tBfVHD7Vtqv4XD9Vj9K8VtKBvwCResRAGq3jFimObsAG
         dtLZj9QE/aqX6ZC0Rfpzv+dkRCuIhGwP6PnNHn6CLUIXvt5QnggSbiybUz9RymVGIW6A
         eKA0Cg/NA1CoBnuQ76+bk4eX7EzVLJpFIEc9QC6J3wjJALqAogoVxeG7hwgsxMQ4vQvS
         LYtLJ53a0m/d43Xvtt9yG1rDFQ7BiIcDzBYkOudqCB5ed9WhqD/eE0jfTiFbmgPfV7jK
         hbIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=5wYXv6h7BUTAj8YeKCpjQqh7oaJRQeKblQeCSUvyikQ=;
        b=gBRK88KnRN3U7yZx2r+zRKq04voUVEWNWa3IM1MCradnizaA+vVsJ1X0/sFHsXb26C
         ARZK3un3pLyljnLKOu7EplI1Zju/24mmbWi+IaH5oUdRHyiYzemKgMej5FSmAuXKnLps
         IJK1pf+CTCYlL1tX5c6UqGoED36XByT1dn+hr/1OT9advU2+3H+deXuXzbjjbceeI0Ni
         cTsOm/ewJgLWfgkfYAmC621lrQd1Qfika4C6isSlk0685iTjkzgnmexPPrAuANZBDT3Y
         CuIcbQ2xRr3Cnkh3663LGx9YORGH1PDAj3GRtjE6hJ8aWePP+yts7OWejpuZ6GBmZ5DO
         Wvww==
X-Gm-Message-State: ACrzQf3H5a9+ttDpkWO+97xWkdafMp7xynrJbcAkUKk8xNA9n5x92SAM
        jae+HSuQvTEACSfqFIH3I7tC03g7WiX+DoHI
X-Google-Smtp-Source: AMsMyM6H/2aV0B3INZdMtVh48Aif6NHYNzGOygq2RMU/EOjuxSDOrCdbaTm4AZ+GDJFwOOaNrrOiyQ==
X-Received: by 2002:a17:902:d589:b0:174:63e0:5a5c with SMTP id k9-20020a170902d58900b0017463e05a5cmr3787591plh.5.1663319124386;
        Fri, 16 Sep 2022 02:05:24 -0700 (PDT)
Received: from xm06403pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id c3-20020a170903234300b001780a528540sm14536580plh.93.2022.09.16.02.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 02:05:23 -0700 (PDT)
From:   Wenchao Chen <wenchao.chen666@gmail.com>
To:     ulf.hansson@linaro.org
Cc:     baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        megoo.tang@gmail.com, lzx.stg@gmail.com
Subject: [PATCH] mmc: host: Fix data stomping during mmc recovery
Date:   Fri, 16 Sep 2022 17:05:06 +0800
Message-Id: <20220916090506.10662-1-wenchao.chen666@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenchao Chen <wenchao.chen@unisoc.com>

The block device uses multiple queues to access emmc. There will be up to 3
requests in the hsq of the host. The current code will check whether there
is a request doing recovery before entering the queue, but it will not check
whether there is a request when the lock is issued. The request is in recovery
mode. If there is a request in recovery, then a read and write request is
initiated at this time, and the conflict between the request and the recovery
request will cause the data to be trampled.

Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
---
 drivers/mmc/host/mmc_hsq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mmc_hsq.c b/drivers/mmc/host/mmc_hsq.c
index a5e05ed0fda3..9d35453e7371 100644
--- a/drivers/mmc/host/mmc_hsq.c
+++ b/drivers/mmc/host/mmc_hsq.c
@@ -34,7 +34,7 @@ static void mmc_hsq_pump_requests(struct mmc_hsq *hsq)
 	spin_lock_irqsave(&hsq->lock, flags);
 
 	/* Make sure we are not already running a request now */
-	if (hsq->mrq) {
+	if (hsq->mrq || hsq->recovery_halt) {
 		spin_unlock_irqrestore(&hsq->lock, flags);
 		return;
 	}
-- 
2.17.1

