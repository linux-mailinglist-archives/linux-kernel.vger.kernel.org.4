Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F50A6F1B61
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 17:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346378AbjD1PWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 11:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346358AbjD1PWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 11:22:15 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7D5559F
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 08:22:05 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-63b7b54642cso106506b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 08:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1682695324; x=1685287324;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E/dZSqOQ8xKsHjj0RW9/HAxmmL3kEAjfoEclPmIfeD4=;
        b=MhRrFAJGxtQ17F8KaKtDs1zQLGGbwFbLblYgD63yL8hZm7JOPfAkJyNK5sUh2C5u55
         vsjUwj3Vtc3CHRAKXo8+y6VLV3KUmEBx2vyGrHSXTGtkeLIX974eMZ4zJw7oIx3/lw7M
         Sfxu2z4JgoyFDW2sRMQhXdkGODTL+0EXRXEtPliK0iFBKYLd7Wsf9y6dWDuyQfnL0tu0
         bu27KG/U8M9JEMeIpZmgxcRXuXQhyaP1c2b1w6aoIYCrfiz1cZxQle6Z/i4H6jfMfN6a
         vsAlOqlyQDTgsnaq3Bk9Dam4CLddfOdnroJzZf0oBjbIQX3nzFYkAbhPlBGnlTJQo5sh
         ygFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682695324; x=1685287324;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E/dZSqOQ8xKsHjj0RW9/HAxmmL3kEAjfoEclPmIfeD4=;
        b=CPe/dCckooGXc/Q7HNJrM/IufAcUvmXBUQ127hbdk7eaaPRZ8leMnzHM/qyQnog4Bv
         pnrWDopCDP/Vq55HsrABpc8tclnhqtwRbXv+FL4DbM7u16NlJoWXHJK/QX4ewVr1dCMF
         BbHqyN7ToMhERAfhQJkVzhYLA42qaORmVqGGWNJgnozsnLLqUw90bAyNxhn3EeSK7sXl
         wQ5epBVesjcIsmhXq7Ee2SYHVn86JlV+aDTmpOZVUPZPjUExZRroAbLLjM+udn5352dx
         f3ehhk1DyVfhsHrbmpznxD3AllLS7SaBLgbzHlI47ZY7O3ooVHKMOAN5E9mgMNJm4a8H
         XZCQ==
X-Gm-Message-State: AC+VfDzzCZ4fh/v7l6Rjc/Vm2A2OckiDJtF5gOTeRgSrNg7cIohIgPQY
        0TtfP1zmvECFSmLKNqC4TlmIsA==
X-Google-Smtp-Source: ACHHUZ6vvPIyv/g8B5tecu9r7NgX/Jpujj6sBadbgOknEsVGEL71WM3NRbfptKFrNrtPGiKod+BZYQ==
X-Received: by 2002:a05:6a20:3ca6:b0:ef:a31b:af90 with SMTP id b38-20020a056a203ca600b000efa31baf90mr7027045pzj.28.1682695324579;
        Fri, 28 Apr 2023 08:22:04 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id y9-20020a63e249000000b0051b36aee4f6sm13346594pgj.83.2023.04.28.08.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 08:22:04 -0700 (PDT)
Subject: [PATCH 1/2] media: nxp: imx8-isi: Fix unusued function warnings
Date:   Fri, 28 Apr 2023 08:21:55 -0700
Message-Id: <20230428152156.22840-2-palmer@rivosinc.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230428152156.22840-1-palmer@rivosinc.com>
References: <20230428152156.22840-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     laurent.pinchart@ideasonboard.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@rivosinc.com, Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     mchehab@kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@rivosinc.com>

I just stumbled into these when trying to test against Linus' master.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
index 238521622b75..01a24ee8b5a1 100644
--- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
+++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
@@ -311,7 +311,7 @@ static const struct mxc_isi_plat_data mxc_imx8mp_data = {
  * Power management
  */
 
-static int mxc_isi_pm_suspend(struct device *dev)
+static int __maybe_unused mxc_isi_pm_suspend(struct device *dev)
 {
 	struct mxc_isi_dev *isi = dev_get_drvdata(dev);
 	unsigned int i;
@@ -325,7 +325,7 @@ static int mxc_isi_pm_suspend(struct device *dev)
 	return pm_runtime_force_suspend(dev);
 }
 
-static int mxc_isi_pm_resume(struct device *dev)
+static int __maybe_unused mxc_isi_pm_resume(struct device *dev)
 {
 	struct mxc_isi_dev *isi = dev_get_drvdata(dev);
 	unsigned int i;
-- 
2.40.0

