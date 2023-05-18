Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B52707BBE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 10:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjERISW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 04:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjERIST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 04:18:19 -0400
Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3776E49
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 01:18:15 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id zYpup3mV8cjUozYpupl7Aa; Thu, 18 May 2023 10:18:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1684397893;
        bh=T4joMoRqF0rssfg793XkwK9lf4GR80yAVh0bfaxIbJ4=;
        h=From:To:Cc:Subject:Date;
        b=rqE/hZYJLqj2cF3pYy/AJGKuEPC6eHZakRG7ZprvxJq4R96dTge2zZ5yZmJCr9TkI
         9D6PK77vw8sobGrE5A7+DqZ+VNVoXbkn1qr3s+WHIh+QBYdsHs0azN0eiUS8i7DhZF
         5mZhC6nTgLgUBkN3PkyHCpW00F2Ag279PQYur7koLu+Eeu2ru7tBKBG3Zv4HJy9hA2
         ywE43p8y1l3Jyo+N1iv20hujQ+SmcwQRE0FzQUhrqhoZx8F6B8OFpjbFDMufWsVe+X
         Kfhdo0P1C4eCQ5cylMeb2RZ635naSrdUhNP6Usmp7txu04fqX79c2qY9NJ+cKPG1E4
         FZicBXYH7ehfg==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 18 May 2023 10:18:13 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Neil Leeder <nleeder@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] perf: qcom_l2_pmu: Make l2_cache_pmu_probe_cluster() more robust
Date:   Thu, 18 May 2023 10:18:08 +0200
Message-Id: <6a0f5bdb6b7b2ed4ef194fc49693e902ad5b95ea.1684397879.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an error occurs after calling list_add(), the &l2cache_pmu->clusters
list will reference some memory that will be freed when the managed
resources will be released.

Move the list_add() at the end of the function when everything is in fine.

This is harmless because if l2_cache_pmu_probe_cluster() fails, then
l2_cache_pmu_probe() will fail as well and 'l2cache_pmu' will be released
as well.
But it looks cleaner and could silence static checker warning.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This is not a fix, because there is no issue.
But in case of interest:
Fixes: 21bdbb7102ed ("perf: add qcom l2 cache perf events driver")
---
 drivers/perf/qcom_l2_pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/qcom_l2_pmu.c b/drivers/perf/qcom_l2_pmu.c
index aaca6db7d8f6..3f9a98c17a89 100644
--- a/drivers/perf/qcom_l2_pmu.c
+++ b/drivers/perf/qcom_l2_pmu.c
@@ -857,7 +857,6 @@ static int l2_cache_pmu_probe_cluster(struct device *dev, void *data)
 		return -ENOMEM;
 
 	INIT_LIST_HEAD(&cluster->next);
-	list_add(&cluster->next, &l2cache_pmu->clusters);
 	cluster->cluster_id = fw_cluster_id;
 
 	irq = platform_get_irq(sdev, 0);
@@ -883,6 +882,7 @@ static int l2_cache_pmu_probe_cluster(struct device *dev, void *data)
 
 	spin_lock_init(&cluster->pmu_lock);
 
+	list_add(&cluster->next, &l2cache_pmu->clusters);
 	l2cache_pmu->num_pmus++;
 
 	return 0;
-- 
2.34.1

