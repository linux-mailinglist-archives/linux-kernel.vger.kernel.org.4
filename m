Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7FC669DEFD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 12:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234187AbjBULij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 06:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234173AbjBULih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 06:38:37 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5313C20;
        Tue, 21 Feb 2023 03:38:18 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d7so2400286pfu.4;
        Tue, 21 Feb 2023 03:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lT7KU5u76ZaOabr9iIs8mD/MfFalpxr1uqwCWT7GsWE=;
        b=DtOruHx3pwisbupRIpkcPOrfCZ0HJk0zQFJami8KqDQdWt6QGmW32vbL8zks+tgH+j
         rIH7qXFbdb9xKCvxTRj59+GcZE34yBDEKTr5oUNyUNGOC7mcQ5npCjrKWi9h94AFKboq
         i/Ki9bRUvScPtdDUh7RO92kkywdGWtTn+UtuwKXFgf0Nl4Sdiax9dopyp0woXR0a9lqQ
         P5T4Pk827cmfgFwRVcuBLkaZSHjaE0DuQo79KhwDWag7UZtIaaj6N6xsW0Df8ionCT2O
         aS/TY/UHRHvI5qp1Y7ljznLiR3b/kp3G+7b4CWHenVQ8ou0cQz/OeV1QvFaeQc8xP4NS
         S8Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lT7KU5u76ZaOabr9iIs8mD/MfFalpxr1uqwCWT7GsWE=;
        b=kUXN+OdM/Obp/OP1XtntGkAluk8lxxFOtheyXhVffVabuRNi4zprD2e0/XVWKBitQW
         vz1mfzNSZwHhn96WExK9tv+3RZCLtD4WmC9l1OLrFXmaTUw65hiMWjV36P3gIr01vrFZ
         bVKMmx2sScVhop7iLATTbIKiHVAR4pCK2JZc3OXPmmOgvzDMR4HAXf8XJkwXGFLhtBWM
         CRq/0/ATRdhDeu9IOEpCBmu8UQrsVd8r5HeD8e+dnn956rVU1YhuUdxr0joc+dVfqeI2
         chZey/MEBs0kpdUNcAtHCYwlcD/AVMR1hQvwfNwICn0P04MTHvAr0xvKecJYU8htn+6I
         Xamg==
X-Gm-Message-State: AO0yUKVMHh53n4hnE0SIEl8absoYxgKy0buLwumjTDnEUq6KbP0euPJe
        1Ij9lIaMdmD4BwgO7eKXQTk=
X-Google-Smtp-Source: AK7set8p7ToYqsJam5Lf7cxvXqufRwjHDrXEX/ApOQ9jClAkopI136jo6KH9h7VVVtIbZIFjrozQjw==
X-Received: by 2002:a62:5290:0:b0:596:15de:ea1e with SMTP id g138-20020a625290000000b0059615deea1emr4845938pfb.9.1676979497577;
        Tue, 21 Feb 2023 03:38:17 -0800 (PST)
Received: from localhost.localdomain ([2407:cdc0:ace7:f724:6709:5adc:1970:16fc])
        by smtp.gmail.com with ESMTPSA id p14-20020a62ab0e000000b005825b8e0540sm9357758pff.204.2023.02.21.03.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 03:38:17 -0800 (PST)
From:   Stephen Zhang <starzhangzsd@gmail.com>
X-Google-Original-From: Stephen Zhang <zhangshida@kylinos.cn>
To:     stanley.chu@mediatek.com, martin.petersen@oracle.com,
        jejb@linux.ibm.com, artin.petersen@oracle.com,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        beanhuo@micron.com, bvanassche@acm.org, avri.altman@wdc.com,
        yoshihiro.shimoda.uh@renesas.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, zhangshida@kylinos.cn,
        starzhangzsd@gmail.com, k2ci <kernel-bot@kylinos.cn>,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH v3] scsi: ufs: mediatek: Guard runtime PM functions
Date:   Tue, 21 Feb 2023 19:38:08 +0800
Message-Id: <20230221113808.1050790-1-zhangshida@kylinos.cn>
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

Fix these errors by guarding the runtime PM functions with CONFIG_PM.

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
---
Changes in v3
  Reword the subject and the commit message.
Changes in v2:
  Guard these functions with CONFIG_PM instead of selecting it.

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
2.25.1

