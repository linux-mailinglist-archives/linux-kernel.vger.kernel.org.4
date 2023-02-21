Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15BB669D903
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 03:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbjBUCwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 21:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233288AbjBUCws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 21:52:48 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0407124107;
        Mon, 20 Feb 2023 18:52:14 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id g12so1599884pfi.0;
        Mon, 20 Feb 2023 18:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TtGcBjSMD0TPpnUy4pzgFNIJ5eKnUntLrojcStRDYvY=;
        b=TISNllblHWF13weS2bgeSF1ImCiREcvaXpiF/CreaEjt0LoXeoVQI0oV+1LALsnTMv
         4wduhGF2Jo4vqYZbUPq97QLzuL6OLTPET8UzQiCzqdkuI1TK3LhExuFufxKFLSFxiR+N
         ThCXAgT68zYCVbKn1grxyUPK4rQBV5HvP+yhKP86Tj0Sjwb3hB0s/h+JaxOY2qyZ5MDc
         5vRdcIDFJLN4lnqakNRvCz4oRteJ0lsbuojFn7n/xCixggNN48+ux9uEuzAZfJePKv9U
         uHVhXZlGHvE/z8NhvJCad44OEvTsNRW6MDCYqHJazhZM9ZtbwCYMCW9zD+AbwG/QeKlq
         3xCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TtGcBjSMD0TPpnUy4pzgFNIJ5eKnUntLrojcStRDYvY=;
        b=2lvPIb56s43W34eEd3Tr4cpB8OOMX84oDd/OkMIA6CFyZFf2SNpYMXLnThrtRPS1m8
         OkDiog5sGpLDEnX9AeBtyd180eAQJ319tvSZreRftyyCgDX0yMI6LMZTsVF89XyFk+nj
         7UD8m65ZfFyZjGzMrbPEZgtCKKpqG5e8QK2RTRLmLtTs23+1ukaCQOf6BFR5zB0QOd+K
         sBX0rDJ7tnAnoMqh5dew7LV46V0S/7i3ObnEMsv3wx4MbrLWdfn0wkeoMeGCBbjVw/42
         xofUVa8T8NqgraOqyo5/4BP3TTufkv06qI3vmWwjXt51HSgt7AtonQkETfJiI82JVMTa
         JCsg==
X-Gm-Message-State: AO0yUKWk6ztN1cz061frK3wLJkqePeU+sietLwkc3kgadHGQL2vfI49q
        CXAo5jMWJpdvw5rDeC7orA8=
X-Google-Smtp-Source: AK7set8+e5eaqDbJ9WaXabjF/wktK7ZqA2lJP1Q1QeyCNfHcTThHtXLt0gc8UdQC0C9xGffblwQhrg==
X-Received: by 2002:a05:6a00:2ea8:b0:5a8:9858:750a with SMTP id fd40-20020a056a002ea800b005a89858750amr4423750pfb.13.1676947863789;
        Mon, 20 Feb 2023 18:51:03 -0800 (PST)
Received: from localhost.localdomain ([2407:cdc0:a091:5a10:3275:3446:a72b:eccd])
        by smtp.gmail.com with ESMTPSA id s4-20020a62e704000000b0059442ec49a2sm8603427pfh.146.2023.02.20.18.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 18:51:03 -0800 (PST)
From:   Stephen Zhang <starzhangzsd@gmail.com>
X-Google-Original-From: Stephen Zhang <zhangshida@kylinos.cn>
To:     jejb@linux.ibm.com, artin.petersen@oracle.com,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        beanhuo@micron.com, bvanassche@acm.org, avri.altman@wdc.com,
        yoshihiro.shimoda.uh@renesas.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, zhangshida@kylinos.cn,
        starzhangzsd@gmail.com, k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH v2] scsi: ufs: Guard the ufs_mtk_runtime_suspend and ufs_mtk_runtime_resume with CONFIG_PM
Date:   Tue, 21 Feb 2023 10:50:55 +0800
Message-Id: <20230221025055.1031342-1-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Shida Zhang <zhangshida@kylinos.cn>

In a configuration with CONFIG_SCSI_UFS_MEDIATEK set to 'm' and
CONFIG_PM set to 'n', errors occur at compile time:

====
../drivers/ufs/host/ufs-mediatek.c: In function ‘ufs_mtk_runtime_suspend’:
../drivers/ufs/host/ufs-mediatek.c:1621:8: error: implicit declaration of function ‘ufshcd_runtime_suspend’; did you mean ‘ufs_mtk_runtime_suspend’? [-Werror=implicit-function-declaration]
../drivers/ufs/host/ufs-mediatek.c: In function ‘ufs_mtk_runtime_resume’:
../drivers/ufs/host/ufs-mediatek.c:1636:9: error: implicit declaration of function ‘ufshcd_runtime_resume’; did you mean ‘ufs_mtk_runtime_resume’? [-Werror=implicit-function-declaration]
====

This patch fixes these by guarding these functions with CONFIG_PM.

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
Changes in v2:
  Guarding these functions with CONFIG_PM instead of selecting the config.

 drivers/ufs/host/ufs-mediatek.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ufs/host/ufs-mediatek.c b/drivers/ufs/host/ufs-mediatek.c
index 21d9b047539f..73e217260390 100644
--- a/drivers/ufs/host/ufs-mediatek.c
+++ b/drivers/ufs/host/ufs-mediatek.c
@@ -1613,6 +1613,7 @@ static int ufs_mtk_system_resume(struct device *dev)
 }
 #endif
 
+#ifdef CONFIG_PM
 static int ufs_mtk_runtime_suspend(struct device *dev)
 {
 	struct ufs_hba *hba = dev_get_drvdata(dev);
@@ -1635,6 +1636,7 @@ static int ufs_mtk_runtime_resume(struct device *dev)
 
 	return ufshcd_runtime_resume(dev);
 }
+#endif
 
 static const struct dev_pm_ops ufs_mtk_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(ufs_mtk_system_suspend,
-- 
2.27.0

