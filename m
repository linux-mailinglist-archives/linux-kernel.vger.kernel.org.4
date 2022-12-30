Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADEB86595F1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 08:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbiL3HwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 02:52:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234521AbiL3HwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 02:52:09 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AA6101CE;
        Thu, 29 Dec 2022 23:52:08 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id o31-20020a17090a0a2200b00223fedffb30so21034152pjo.3;
        Thu, 29 Dec 2022 23:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bYkG7XmHEUX3Q6jfNoL8pr6lK3zbhE2hamwqRVWCYyw=;
        b=IyWmyo2MUe2Izt39NVeE/WfcVMlNrh5kCMqkufn4AOZXfqYMv1E7M3yOwUGC5IMhrU
         Rz6yDye7AfDRFmQgVrmdeInx2yqninzXIgG7sZSbmjrBC0M3UJCKvXnpFWJGqJS0WVGz
         9yozX4eR84pgd0uD440sekf4ISpbgbp+JWfuYiaMA/R476Md1EwPV0UrZirb3kdjVMg7
         85Vsj2MI7SRzLhGmegSd5zPfonXMiEzLFZrd9eG2tbDZb2yjxt2mZIFOix/C2mRYF+iL
         oVP0bVIgV7ryDXujHtdEPERWk5JqetcInX/0HouxOdhl6inDzrZxdoUjoBkkRDmCqPuk
         X6Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bYkG7XmHEUX3Q6jfNoL8pr6lK3zbhE2hamwqRVWCYyw=;
        b=LmKqeTVliRGOulU8LccCJxIyc9YMNzNSbQUKzRB/DG2jhxANd9UEpNwH3f63vPPGqN
         +meXtkY5l5WY0GVpp49qvzy3rJsVuIJFNHXCiQQCn+KaRCpZhNlKB+OTdRnzOD0Hgj7q
         vVCovifE+Gk5Cpe3YQ3DGCgdw0IN6ONTIQ+sFEjznfpXWXY7oCZ4iSC+2UtDvVze561x
         iihk9GVcxTov2cjYUb+WVFxLyLpdvWj3JTJumCj6BjVNQfSbHmrVEaPdxWRIdX5reBwO
         BcxjmkYBDV7o1ZkjYO8Tu5CVOXP3hvtzam9m8ODDW/us1pGH1/jnDEYOMQMMC6TpVrRQ
         3UIQ==
X-Gm-Message-State: AFqh2kqB9AWn3Se1xkvSo1YW5i2zjQ/afLsVC0/zfr/ktbv9WmBIRj9C
        tyrfFcYJoyMrakfqTKn4r5w=
X-Google-Smtp-Source: AMrXdXtyr7dzaWIVoWAF7dAnKR4PxF0uAsVacGcterIeC7KNys2V6aNkiyP7qR0JA+vhlLuFCvHmqw==
X-Received: by 2002:a17:90a:ce02:b0:223:a473:fd77 with SMTP id f2-20020a17090ace0200b00223a473fd77mr33237365pju.2.1672386727799;
        Thu, 29 Dec 2022 23:52:07 -0800 (PST)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id ch24-20020a17090af41800b00219cf5c3829sm12380934pjb.57.2022.12.29.23.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 23:52:07 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] powercap/dtpm_cpu: Fix refcount leak in __dtpm_cpu_setup
Date:   Fri, 30 Dec 2022 11:51:59 +0400
Message-Id: <20221230075159.1482626-1-linmq006@gmail.com>
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

The policy return by cpufreq_cpu_get() should be released with
cpufreq_cpu_put() to balance the reference counter.
Add missing cpufreq_cpu_put() to fix this.

Fixes: 0e8f68d7f048 ("powercap/drivers/dtpm: Add CPU energy model based support")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/powercap/dtpm_cpu.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index 2ff7717530bf..3083c6b45c90 100644
--- a/drivers/powercap/dtpm_cpu.c
+++ b/drivers/powercap/dtpm_cpu.c
@@ -195,12 +195,16 @@ static int __dtpm_cpu_setup(int cpu, struct dtpm *parent)
 		return 0;
 
 	pd = em_cpu_get(cpu);
-	if (!pd || em_is_artificial(pd))
-		return -EINVAL;
+	if (!pd || em_is_artificial(pd)) {
+		ret = -EINVAL;
+		goto out_put_policy;
+	}
 
 	dtpm_cpu = kzalloc(sizeof(*dtpm_cpu), GFP_KERNEL);
-	if (!dtpm_cpu)
-		return -ENOMEM;
+	if (!dtpm_cpu) {
+		ret = -ENOMEM;
+		goto out_put_policy;
+	}
 
 	dtpm_init(&dtpm_cpu->dtpm, &dtpm_ops);
 	dtpm_cpu->cpu = cpu;
@@ -220,6 +224,8 @@ static int __dtpm_cpu_setup(int cpu, struct dtpm *parent)
 	if (ret)
 		goto out_dtpm_unregister;
 
+	cpufreq_cpu_put(policy);
+
 	return 0;
 
 out_dtpm_unregister:
@@ -230,7 +236,8 @@ static int __dtpm_cpu_setup(int cpu, struct dtpm *parent)
 	for_each_cpu(cpu, policy->related_cpus)
 		per_cpu(dtpm_per_cpu, cpu) = NULL;
 	kfree(dtpm_cpu);
-
+out_put_policy:
+	cpufreq_cpu_put(policy);
 	return ret;
 }
 
-- 
2.25.1

