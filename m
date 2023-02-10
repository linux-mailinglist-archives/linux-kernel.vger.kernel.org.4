Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4F6692B8F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 00:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjBJXnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 18:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjBJXnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 18:43:47 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF4081CFB
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 15:43:22 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id x188-20020a2531c5000000b00716de19d76bso6351947ybx.19
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 15:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pq9DLVAB41UZ1daqP8qVvrbiDLfr0Ia2Jjzuq86gY04=;
        b=KrZ7DNmZ42tI5fQi8ZYQ8u5FQYFpt1VhiL6mzYE9CHt0L714pWDmufaxMHurT+kdiE
         Svr4VMAXQeviO5JBD5BVjouyVXC+1GnXD/8oTkob0RdWsgP0T7oCiDzGIF107Cx/mG9E
         2VfyAZeiVJnKfLSiXhRPicXaHNSepmhhMa7zCu3LglKB2s/LC7ISPrbm3E0KXGIiaqCV
         QPrhtYXkn/tnL7mzdDcDIdGTKe61oNmtqwl+hCzbKpEbP6yo4YgRaVbz3j5u1bXN9jPX
         5MJC0Vl14rDR0nHCJw6YfM9Z4Wtj5CJ6SVUK6zvlk70vwOvMmGHTqnOGjtNNi+/WZAEg
         eghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pq9DLVAB41UZ1daqP8qVvrbiDLfr0Ia2Jjzuq86gY04=;
        b=vQOtEZldR3ianv/OAwPBLOCMGKAftPqDADdyy4Hyv7jW3N5RT0zSb+sNPtOdWxNNfp
         MxWYrNJMmTd+gHKDa1WanM5nOHYPUHD5IKY7MmoQVVqPfOLH8dqCRCzPNzUMz+Ktsmd6
         82GaDRXyKDHgG2kPjmT58jjvqvdmqnKPRee2F8BBj02RaGhgUAvBcyp3ZhuvhRdo/zxj
         4Ss7OP5eDHdsTDkIc+MMzRbKsglHygVXQwUlKizYEZS+di33MGK/6aMMbWqOiHQXhP/q
         gh//YDSccjAfDNxrnr5UFxYs7E3WFutfQmGPA56vuHny3SZ3UZaYQ52FKl+pxObeZHE0
         JL+Q==
X-Gm-Message-State: AO0yUKXsGfHvcau4+p8pElHPQdwP3CVLMMrBmw3W2exYFhZNp+/Nlwpz
        a8wG83u+BbgkdN1AaedWP7LdyofJ9g==
X-Google-Smtp-Source: AK7set+DKY/drm0mS9tbjkL+T1bR92BB3DTMNmSO/2PR/B1VzsIiQPtiJf7TIhkfwhi+oLoO+fkel1qGa4M=
X-Received: from yabinc3.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:1274])
 (user=yabinc job=sendgmr) by 2002:a25:8708:0:b0:8f4:2e76:d2b0 with SMTP id
 a8-20020a258708000000b008f42e76d2b0mr1ybl.6.1676072593951; Fri, 10 Feb 2023
 15:43:13 -0800 (PST)
Date:   Fri, 10 Feb 2023 23:43:11 +0000
In-Reply-To: <77bd4509-bd8b-3bcc-e94a-7593505e27c0@arm.com>
Mime-Version: 1.0
References: <77bd4509-bd8b-3bcc-e94a-7593505e27c0@arm.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230210234311.1661312-1-yabinc@google.com>
Subject: [PATCH] coresight: tmc-etr: Handle enable failure in tmc_read_unprepare_etr
From:   Yabin Cui <yabinc@google.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, James Clark <james.clark@arm.com>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yabin Cui <yabinc@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's similar to what we did in tmc_read_unprepare_etb.

Signed-off-by: Yabin Cui <yabinc@google.com>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 918d461fcf4a..b04f12079efd 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1763,6 +1763,7 @@ int tmc_read_unprepare_etr(struct tmc_drvdata *drvdata)
 {
 	unsigned long flags;
 	struct etr_buf *sysfs_buf = NULL;
+	int rc = 0;
 
 	/* config types are set a boot time and never change */
 	if (WARN_ON_ONCE(drvdata->config_type != TMC_CONFIG_TYPE_ETR))
@@ -1777,7 +1778,11 @@ int tmc_read_unprepare_etr(struct tmc_drvdata *drvdata)
 		 * buffer. Since the tracer is still enabled drvdata::buf can't
 		 * be NULL.
 		 */
-		__tmc_etr_enable_hw(drvdata);
+		rc = __tmc_etr_enable_hw(drvdata);
+		if (rc) {
+			spin_unlock_irqrestore(&drvdata->spinlock, flags);
+			return rc;
+		}
 	} else {
 		/*
 		 * The ETR is not tracing and the buffer was just read.
-- 
2.39.1.581.gbfd45094c4-goog

