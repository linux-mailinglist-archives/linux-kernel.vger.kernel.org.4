Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66FD2706DC0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 18:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjEQQOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 12:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjEQQOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 12:14:34 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C151BD3;
        Wed, 17 May 2023 09:14:33 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-24e5d5782edso1051939a91.0;
        Wed, 17 May 2023 09:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684340073; x=1686932073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gL6goea49SYl8SIiZ155r2n78LG9CV6q33QUPhCt4qI=;
        b=hgZBPmMcIAI1NGuMwnD/+FNPi5gvsqdFnVtrxKKwrxZEaar1D86rcxYAMcO4/eEOsy
         rwJ+thADvD8hakoSuZ9vgyrrs+R2oPlCG7ieKm8zohFHLcHjcRbaVBeow3HLeKE7shev
         RkvMvnSVkiNe9w60uSAMGW4TwdkSL1q9f3xRvOLIcuMPhyzRFW40WOid2Fsh4bIcFoMD
         FREnAJT4JjE9MV32JlZcD8XE+pFvQBSm5uC5JqUtCvLLmLi3iNqhTiqyfw9nbgxsWkqG
         rx3O4MNThnt4X3u1j9wybrv4afj1rw9CIgI3q6gmD9Fuxmwnv32grHn2cYl72l6mrCcm
         dUgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684340073; x=1686932073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gL6goea49SYl8SIiZ155r2n78LG9CV6q33QUPhCt4qI=;
        b=BCVGVKwDIKss7tpOtJZpfyEJv+pJ6zBFrwBa2Npf/zkrUeODDvMzSn/QNk9KP22GP2
         leltGCbr67bjWGeFQkfEo8H7fqOU1r3bR3dJfc4vV+4OIu2pyWswEH+DkrMVnhTll8/P
         nks+Vxs6qcmAxVclJcZTZk23wxv4gAZd2tfYpZju1KkWrCCWQ43IndXpvoQtNB+0JsaF
         QuTZZtzpHOHy0n033+jPhWdDcZbIIH8KlbDQoA0wLQ1XfuF4TTTs7zK33EZ9QKDuJ7KZ
         +zj73Se9mcpiKfEYSrRQ1peolASD0I8ZJhsXtxW3hD89K96ojDvNnU9wjwga69BF8prU
         I9hA==
X-Gm-Message-State: AC+VfDwcGE+hOnJgQtZGnKQ6r031S0Acpt6o3WVUa1Lo51pF3x98Gr31
        WLvmN3keYn6NsBLgAWrH5JM=
X-Google-Smtp-Source: ACHHUZ4ieRwHTjDYMHB5vEin43PrJSaoymqyYu7Kt3ixC25Rb0hbAN+cdyTmf0OdBA7vrm0sq9jgww==
X-Received: by 2002:a17:90a:43e4:b0:253:3481:84cf with SMTP id r91-20020a17090a43e400b00253348184cfmr257452pjg.10.1684340072755;
        Wed, 17 May 2023 09:14:32 -0700 (PDT)
Received: from Osmten.. ([103.84.150.101])
        by smtp.gmail.com with ESMTPSA id v1-20020a17090a634100b0024e3bce323asm1759916pjs.26.2023.05.17.09.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 09:14:32 -0700 (PDT)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        petlozup@nvidia.com, stefank@nvidia.com, sushilkumars@nvidia.com,
        christophe.jaillet@wanadoo.fr, viresh.kumar@linaro.org,
        dmitry.osipenko@collabora.com
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Osama Muhammad <osmtendev@gmail.com>
Subject: [PATCH] soc/pmc.c: Fix error checking for debugfs_create_dir
Date:   Wed, 17 May 2023 21:13:56 +0500
Message-Id: <20230517161356.11416-1-osmtendev@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the error checking in pmc.c in
debugfs_create_dir. The correct way to check if an error occurred
is 'IS_ERR' inline function.

Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
---
 drivers/soc/tegra/pmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 5d17799524c9..ac468e4a225c 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -1194,7 +1194,7 @@ static int tegra_powergate_debugfs_init(void)
 {
 	pmc->debugfs = debugfs_create_file("powergate", S_IRUGO, NULL, NULL,
 					   &powergate_fops);
-	if (!pmc->debugfs)
+	if (IS_ERR(pmc->debugfs))
 		return -ENOMEM;
 
 	return 0;
-- 
2.34.1

