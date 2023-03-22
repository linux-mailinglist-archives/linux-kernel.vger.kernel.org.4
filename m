Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70DC6C45E2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 10:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjCVJNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 05:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjCVJNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 05:13:23 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063B04C3C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 02:13:23 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id z19so8258376plo.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 02:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=areca-com-tw.20210112.gappssmtp.com; s=20210112; t=1679476402;
        h=content-transfer-encoding:mime-version:date:to:from:subject
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5NbocV/CGU6vo/Jq423AoG+k28z3QYnZrMdtS3Ex8/4=;
        b=OkZiwJlN7EdOw0wCwLta+QvSYI38sAmKzXJ5O1VagUK/K3AfSI3/Ml3FapA8AyvHBS
         u3ObomU7CcTou5TYITedY0chuRE47MgzVLpCqDbgz+9Xf0rDBOsm6PrS1CjGgiFt3yE9
         5qxX4lSeLQg+rPONlEK/mLTWN5aAXfNKDb1W1pvO7EhbQ7VRcdC3kjsIIUPoUmTIcAuU
         soQF/YHFZKbY5j7gIyXVtdwBkxEjPZv+wZxNgJV60aEegHfd5LeNd4kYBOUrPo3EpOnu
         AfASMlr2EOYcEdh3LmpjxtIi27flJRX5oIkmCMAWVp3ImnmWWPP2gqU0+ETCJhXLMnpl
         +T6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679476402;
        h=content-transfer-encoding:mime-version:date:to:from:subject
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5NbocV/CGU6vo/Jq423AoG+k28z3QYnZrMdtS3Ex8/4=;
        b=CMZaFIZ5kKsmlIt/qh02jq+OOWgCRA1utv0VQ3pFePlV1LkV5iH+d4urcNOmXPLUZb
         osOAvJGkE7wzskVRUdPsY5bWnYHR90FT2j59f30v95D7YbnEHqh1ENKbJDor4ijGV9mH
         6siszSEdlx4zGD65CEoqGN23kSZoLvEBrutF1h6G2RCJiChVyIUnuK/38z9rtKOghAtR
         sK+yqRyMm9ymKsHEszE3Dpf1lo1YAjtjTVCMx9V/QquGHvLE+AnXn+r2SHkGdvDrMLUp
         33cdy7AcXz2CGP0MUL8/t0eR0ToA3cliJ5V/8wmVSR05euprexHzZpN8mkCRo8qf3Nyj
         3oeQ==
X-Gm-Message-State: AO0yUKWSYHobyvBQ913bKg9942AYLmZzvDC6yK9P42Ak+iQViPWGQIx/
        5KM+BvvU7S5ZfIYtlJyjfKhWBSYBzbCeVnwNvPJTHQ==
X-Google-Smtp-Source: AK7set909pBC/j4lWAqNDjTzNbAkvQ3Nf/ka8NPlkkT02+PZ5xKi2gOu85q8p6SGKuddKairK/wipA==
X-Received: by 2002:a17:90b:3149:b0:23f:dd27:169b with SMTP id ip9-20020a17090b314900b0023fdd27169bmr2881569pjb.2.1679476402512;
        Wed, 22 Mar 2023 02:13:22 -0700 (PDT)
Received: from centos78 (60-248-88-209.hinet-ip.hinet.net. [60.248.88.209])
        by smtp.googlemail.com with ESMTPSA id z3-20020a17090ad78300b0020b21019086sm983192pju.3.2023.03.22.02.13.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Mar 2023 02:13:22 -0700 (PDT)
Message-ID: <81c1f98819dfdfa18ae4d3b854b7733af9d34ea5.camel@areca.com.tw>
Subject: [PATCH 2/5] scsi: arcmsr: fixed ADAPTER_TYPE_B 64bits dma
 compatibility issue
From:   ching Huang <ching2048@areca.com.tw>
To:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 23 Mar 2023 01:13:20 +0800
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DATE_IN_FUTURE_06_12,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ching Huang <ching2048@areca.com.tw>

This patch fixed ADAPTER_TYPE_B 64bits dma compatibility issue
on some mother board.

Signed-off-by: ching Huang <ching2048@areca.com.tw>
---

diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c b/drivers/scsi/arcmsr/arcmsr_hba.c
index e8c12dd..d387a38 100644
--- a/drivers/scsi/arcmsr/arcmsr_hba.c
+++ b/drivers/scsi/arcmsr/arcmsr_hba.c
@@ -996,6 +996,8 @@ static int arcmsr_set_dma_mask(struct AdapterControlBlock *acb)
 		if (((acb->adapter_type == ACB_ADAPTER_TYPE_A) && !dma_mask_64) ||
 		    dma_set_mask(&pcidev->dev, DMA_BIT_MASK(64)))
 			goto	dma32;
+		if (acb->adapter_type <= ACB_ADAPTER_TYPE_B)
+			return 0;
 		if (dma_set_coherent_mask(&pcidev->dev, DMA_BIT_MASK(64)) ||
 		    dma_set_mask_and_coherent(&pcidev->dev, DMA_BIT_MASK(64))) {
 			printk("arcmsr: set DMA 64 mask failed\n");

