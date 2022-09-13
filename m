Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533F45B6A68
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 11:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbiIMJMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 05:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbiIMJMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 05:12:34 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC855A800
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 02:12:32 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id w2so868055pfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 02:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=d7BK1Sg/tQCQogt0rSecDlpjX+Yo/gtbxqyxdutICMQ=;
        b=F5EDu9R9IR0UvjFC7OdCUSJ/Po9JehilOSlp9+qm7VVdD2J1hV+psz6iqpAEFlT+Di
         iD30oZ7chQAvufHgLDNkrlCALvHSS9mx8LGhOPJwLjL+zVPwGaU1UvVtnavr5pfALoP1
         KdU3CPHKbbNmehmOHD9iHUFmJtmk902qR164d3RXk2cqJlMnKHvXpdstz7uai0FfWTMO
         POou7hnMoIaF2tAgIzD17jkVHYzmBIfo0FyysmCPdcS1T98HqV/EkRJItxexF/L0hrp+
         S9o+RtrEmojFyEQZtNlKIcgFLW4FRAgn6BILbJfplteXGBe9u7aSsdDAVfJcJYQc5pD1
         JX2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=d7BK1Sg/tQCQogt0rSecDlpjX+Yo/gtbxqyxdutICMQ=;
        b=WyuoOwwnXG3ek6YMOZVzwdc+ty8Jh3QPoYLLTL0Cnx/vTj1BWAESM4+pUN4wqslIlg
         ReaHx7Uy5n6uhX7gfhFIUxWoBFzX9p1oKr2PM2GyRN8lK1CYIiDtAcitwhXiCezDiO34
         jk86yz9pvoHBSND4uJG3aa0NJEhLjMgSF+swJ34yXeuTq9lLteJ6LDrH+Mldy4qyPcLy
         gmMVjKQ5FIYsxF8CucRD5zwRokccb0mnBLt9lcRv2LDTazYvKyFZf6xoBML+ZUDkrjP/
         3LQEvHuG74BNIEU8roapZsxkxGpKKBJm0uAeHpxZPQdmCFATd/Og84ucUPW2kCuXQBVs
         oO7Q==
X-Gm-Message-State: ACgBeo33LZSFBhaK0a9dzQqCfBVO8mUPV/HcI9/pLVcXcwzbAjLKcdTZ
        Pq0uOZxfF1AuWbh2buljZQ==
X-Google-Smtp-Source: AA6agR7lkGJ1RnSR3/Tv86EzHnFrYiMd6dvnhbaaQpCNJSHgcCYv8ERsl4HSdAP0dChPa9EOLQ9v2A==
X-Received: by 2002:a05:6a00:1704:b0:53b:b450:a51d with SMTP id h4-20020a056a00170400b0053bb450a51dmr31817498pfc.79.1663060351722;
        Tue, 13 Sep 2022 02:12:31 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.3])
        by smtp.gmail.com with ESMTPSA id h10-20020a170902680a00b0015e8d4eb1d5sm7804661plk.31.2022.09.13.02.12.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Sep 2022 02:12:31 -0700 (PDT)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     sj@kernel.org, akpm@linux-foundation.org
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH 2/4] mm/damon/sysfs: simplify the variable 'pid' assignment operation
Date:   Tue, 13 Sep 2022 17:11:25 +0800
Message-Id: <1663060287-30201-3-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1663060287-30201-1-git-send-email-kaixuxia@tencent.com>
References: <1663060287-30201-1-git-send-email-kaixuxia@tencent.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kaixu Xia <kaixuxia@tencent.com>

We can initialize the variable 'pid' with '-1' in pid_show() to
simplify the variable assignment operation and make the code more
readable.

Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 mm/damon/sysfs.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index da01befae8bd..3606eec9b65d 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -2588,19 +2588,16 @@ static ssize_t pid_show(struct kobject *kobj,
 	struct damon_sysfs_kdamond *kdamond = container_of(kobj,
 			struct damon_sysfs_kdamond, kobj);
 	struct damon_ctx *ctx;
-	int pid;
+	int pid = -1;
 
 	if (!mutex_trylock(&damon_sysfs_lock))
 		return -EBUSY;
 	ctx = kdamond->damon_ctx;
-	if (!ctx) {
-		pid = -1;
+	if (!ctx)
 		goto out;
-	}
+
 	mutex_lock(&ctx->kdamond_lock);
-	if (!ctx->kdamond)
-		pid = -1;
-	else
+	if (ctx->kdamond)
 		pid = ctx->kdamond->pid;
 	mutex_unlock(&ctx->kdamond_lock);
 out:
-- 
2.27.0

