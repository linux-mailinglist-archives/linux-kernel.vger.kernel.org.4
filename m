Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC645FDA0E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 15:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiJMNNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 09:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiJMNNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 09:13:12 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69355E52C6;
        Thu, 13 Oct 2022 06:13:11 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id l1-20020a17090a72c100b0020a6949a66aso1861846pjk.1;
        Thu, 13 Oct 2022 06:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oavwE0zT1xmVF6JaGtGzNklV5deJ2R7tec0q7FOmvI8=;
        b=Np1Q0516eUWQMOl3vL/Qm+cm795BaEMlb3P4O2w9T3+7hIqRIch3IJBhrLvc2JhIUJ
         ZUifNyfTYg1qGroojaKa9KRUGyN5ciA98Axo4jw9Bp4dUZLOdkPnunzzt532uQE5WwoX
         ci5Z75hwvPojUzegcAwrgOlQOWs3gz+tsmNfltKTQgDMIKTI1Z3q/BjdAm9/2lWHOznF
         aBMroJfgyia3F+c9SjTYDR+XLe0XTrS8guSDh+B1fNO8qynWeQryt5wPo6TTHJ8qjADz
         P1qRv/JTui0JG4fhCG6fEGqjzauBTFqfUsOwxE4Fsz/V0lQiKfwWzVfyNGRRmtw2o49F
         3fKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oavwE0zT1xmVF6JaGtGzNklV5deJ2R7tec0q7FOmvI8=;
        b=UX4SCl0lAa6gmn8tTW4JfgykIAjkgWbf92CI9eEik3sa6etviuhTyeaZCAteQcx0ec
         1wuukm8gjcwJx/e/ce+Lyft0DxaWZf0BNzD0EuxDtIpJsnVCrl+FdXzU9mUmuAmVeNo6
         +/vrW4NK2Yqedsov0sqFZVLF8Js8Q6EpELtiz8bVA9xpftpjTiU5GDRQBjhQ7PQy4OwZ
         2oLURg1bfNaedf/9hdwXq3asW5qOsqLnXjvhM8nEjxIQX2tNaOpHooxMPziijXiITNTI
         CItoRCAFD7hGKX9tgap4mGdisi0blp/HbFemtO6KiAIQ0l9mTUrZXU+6We7NxgZLq2cp
         EL5g==
X-Gm-Message-State: ACrzQf2QGbIBEyXATjGhz9/3AJkpkWdmOLmnfJR/ogeFNOeVoBaxaOt7
        /HBTxw5ML/KabnqWspstweck+fqM07C8Iw==
X-Google-Smtp-Source: AMsMyM4xHweexYqEmbBPKsxH06xdXiOQQX3/oWjiZQIfaUjYx0kM3tlQyUqyXT9cA95GzNBYhpHsxQ==
X-Received: by 2002:a17:902:ebca:b0:183:d123:e2a7 with SMTP id p10-20020a170902ebca00b00183d123e2a7mr13416566plg.105.1665666790933;
        Thu, 13 Oct 2022 06:13:10 -0700 (PDT)
Received: from localhost (ec2-3-6-129-254.ap-south-1.compute.amazonaws.com. [3.6.129.254])
        by smtp.gmail.com with ESMTPSA id n5-20020a634005000000b00460fbe0d75esm8264616pga.31.2022.10.13.06.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 06:13:10 -0700 (PDT)
From:   Manank Patel <pmanank200502@gmail.com>
To:     rafael@kernel.org
Cc:     lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manank Patel <pmanank200502@gmail.com>
Subject: Re: [PATCH] Fixes: 91cefefb6991 ("ACPI: acpi_pcc.c: fixed unintentional u32 overflow by redefining a constant")
Date:   Thu, 13 Oct 2022 18:33:13 +0530
Message-Id: <20221013130311.1433314-1-pmanank200502@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <CAJZ5v0h2fmf=DFY2g9+sdStsj+coPQPwbub8QnNuaK26_xv69g@mail.gmail.com>
References: <CAJZ5v0h2fmf=DFY2g9+sdStsj+coPQPwbub8QnNuaK26_xv69g@mail.gmail.com>
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

changed PCC_CMD_WAIT_RETRIES_NUM to 500ULL


Signed-off-by: Manank Patel <pmanank200502@gmail.com>
---
 drivers/acpi/acpi_pcc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_pcc.c b/drivers/acpi/acpi_pcc.c
index ee4ce5ba1fb2..3e252be047b8 100644
--- a/drivers/acpi/acpi_pcc.c
+++ b/drivers/acpi/acpi_pcc.c
@@ -27,7 +27,7 @@
  * Arbitrary retries in case the remote processor is slow to respond
  * to PCC commands
  */
-#define PCC_CMD_WAIT_RETRIES_NUM	500
+#define PCC_CMD_WAIT_RETRIES_NUM	500ULL
 
 struct pcc_data {
 	struct pcc_mbox_chan *pcc_chan;
-- 
2.38.0

