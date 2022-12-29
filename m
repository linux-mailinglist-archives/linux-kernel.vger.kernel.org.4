Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521336589E9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 08:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbiL2HZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 02:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiL2HZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 02:25:44 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AAD72BB;
        Wed, 28 Dec 2022 23:25:43 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id m4so18205739pls.4;
        Wed, 28 Dec 2022 23:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XMmjpNuQhfnjEBg0iRS3fgyiOsvlVGYZtXowsGaPpY4=;
        b=XlJp8yXFhT4hyvoX3Uk/oVEkgPHpakO9wCFNHG7R0VHAyFMOK0J1Q2LuhOdzSiSfKB
         gvwpJfIHFJ+N43entFnS6WXbYcGG5XYdV+8DCVQvaEDBs6Qu6d1PKtWZxtzjMx0sitV9
         hHqdNA2vhCqTJ6O9pfRjp3Rr+sBf+mjU8pvEmvqRq0taocaHms2P+sywRMj9jHhfBAsh
         X9mTxQc6X6KTe5fv2WsnB+IUl3+EhHmeJ82UiHg6WRxfkb7NvuVUzTzSk7XadnPp0R8o
         sTVVfXMI+XI/1CAzVJO+0oesbfqiNOlQNEDKp4yAhDHf2o7Ls6Dfyn/GWNGuV89Cagjn
         eaFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XMmjpNuQhfnjEBg0iRS3fgyiOsvlVGYZtXowsGaPpY4=;
        b=BeSCSo59uSDydeohBi482jUinFyxMgjTHmbaIdRn53yzEjkfN2JMIhvJzYL//MEpQT
         RzlGByD2gLcDOJeK3oub+NP6MqsKYcbPalubLtPrEZhFGYDuDCIdKRwYY7C1DXokgOPF
         rGnsjIjYB7JG1HDyisjoR2my2e+An14koygp6ousAgImUEbLbZp3k5Cmdm/rJtYIN1UF
         zQzO5TEeO1Jfun1O0ZcZ0713I0yLU8KKgmkeag/s41dIJKlhovTT1+1cOUGnraxDYNZ5
         Z7S1nRSp1hLP3xZwWBvfJUHv/0LD2QiRAECUiBzURht5DuP/DVT1ZdEw11vsjwq+aaHF
         Ttyw==
X-Gm-Message-State: AFqh2kpPa3eeScKf4u6JjkXwToDm8clU0Tp4wG3syE7prDAolysK6pC5
        yHE07ieKiGgF9XQOauPV2Hc=
X-Google-Smtp-Source: AMrXdXt/i8/rj5UqycTrZ4qAD/p59uTsapxNXRjspv7Z9q3mQYPSUvZfJLReN84nvT8zGo24YgARHw==
X-Received: by 2002:a17:90a:c24a:b0:225:f3e6:424e with SMTP id d10-20020a17090ac24a00b00225f3e6424emr13350914pjx.17.1672298743124;
        Wed, 28 Dec 2022 23:25:43 -0800 (PST)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id f62-20020a17090a28c400b00225c9afdba4sm9052116pjd.38.2022.12.28.23.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 23:25:42 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Sanket Goswami <Sanket.Goswami@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] platform/x86/amd: Fix refcount leak in amd_pmc_probe
Date:   Thu, 29 Dec 2022 11:25:33 +0400
Message-Id: <20221229072534.1381432-1-linmq006@gmail.com>
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

pci_get_domain_bus_and_slot() takes reference, the caller should release
the reference by calling pci_dev_put() after use. Call pci_dev_put() in
the error path to fix this.

Fixes: 3d7d407dfb05 ("platform/x86: amd-pmc: Add support for AMD Spill to DRAM STB feature")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/platform/x86/amd/pmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/amd/pmc.c b/drivers/platform/x86/amd/pmc.c
index 439d282aafd1..8d924986381b 100644
--- a/drivers/platform/x86/amd/pmc.c
+++ b/drivers/platform/x86/amd/pmc.c
@@ -932,7 +932,7 @@ static int amd_pmc_probe(struct platform_device *pdev)
 	if (enable_stb && (dev->cpu_id == AMD_CPU_ID_YC || dev->cpu_id == AMD_CPU_ID_CB)) {
 		err = amd_pmc_s2d_init(dev);
 		if (err)
-			return err;
+			goto err_pci_dev_put;
 	}
 
 	platform_set_drvdata(pdev, dev);
-- 
2.25.1

