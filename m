Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD87A6F2C26
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 04:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbjEAC5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 22:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbjEAC5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 22:57:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F2CE77
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 19:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682909813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=UdGohDyMlKgkesfVLSjlq0qOj7W1ktyJNgQgYIfYl7A=;
        b=KUy8asWcsfwpkFG4mM0IDn21nSR/qYUlcVTWf/JXbSnFiZcUvmo+1b2jJwdeuxxE7es/uL
        9Ik0Oa312yC2p8a3x5RKUlfj1bIj1KB3d8qfM3lgoiXeUdtXgnU4JTNMDu7OQwh8rv8wFy
        eK3KOvL21fTYJF0xg1sbI3yVtWQ9up8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-3nQbo9dNOXGWngNmoDflXA-1; Sun, 30 Apr 2023 22:56:51 -0400
X-MC-Unique: 3nQbo9dNOXGWngNmoDflXA-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-74e26504096so107299385a.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 19:56:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682909811; x=1685501811;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UdGohDyMlKgkesfVLSjlq0qOj7W1ktyJNgQgYIfYl7A=;
        b=A20N7DYAyKPaQ5vvoI3zZPvlr1mOKcsHhvNcD3R0oDQdUH3LDHsiuMaz79uB/OofM1
         MTyqwEtSGAawuiBg3LIhrolXfxkxEou8qFLTzGcrDV/1RwNZ4V2C2+fFAjeCbNgqrQ16
         iYE429m6tB0Ndh+vSMYuAFH1umxUvT05mz2wus+VFXpU/Ec5Q6HF3W/d1iNmQQTYXyJb
         GpAq9s9Ttiqd/xosu76xAzhadC+AaolV7b0rLS1lxnHyWrjF/bXl9zMT67diIdKLyWnP
         9blNutTQayPq5fas9u6Qnqw95wpoOYXKEeQSz3sBflevAsk4FAUf3VVpFFpQgC1KeMGc
         TOhQ==
X-Gm-Message-State: AC+VfDzQkVN2IDJrE6w+Xjv9jdpuVeKgK++/R0q48FSGU0O9Im9Uuwdv
        2TXl3GIxREdAX9AzO32u7O5o0HBZ0OBYW9u59W0t3+FudlzucvsA7SZKqaQm8vkt4Kc0hlFPK8l
        n4gKYATazHnsuhtHzbPifLljsvBN+xO0m
X-Received: by 2002:a05:6214:c82:b0:614:da60:f44a with SMTP id r2-20020a0562140c8200b00614da60f44amr16364857qvr.46.1682909811161;
        Sun, 30 Apr 2023 19:56:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7QhoMlr8G5cZty8Gpr8sgNP39UAjTz1wTVFmnRL6ez7vUBKvKJmjwZ90YpE8W9dnFZ4BwoFw==
X-Received: by 2002:a05:6214:c82:b0:614:da60:f44a with SMTP id r2-20020a0562140c8200b00614da60f44amr16364848qvr.46.1682909810937;
        Sun, 30 Apr 2023 19:56:50 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id b20-20020a05620a271400b0074357fa9e15sm8503995qkp.42.2023.04.30.19.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Apr 2023 19:56:50 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     peter.ujfalusi@gmail.com, vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] dmaengine: ti: k3-udma: define udma_pm_resume,suspend with CONFIG_PM_SLEEP
Date:   Sun, 30 Apr 2023 22:56:47 -0400
Message-Id: <20230501025647.2905317-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc reports
drivers/dma/ti/k3-udma.c:5552:12: error: ‘udma_pm_resume’
  defined but not used [-Werror=unused-function]
 5552 | static int udma_pm_resume(struct device *dev)
      |            ^~~~~~~~~~~~~~
drivers/dma/ti/k3-udma.c:5530:12: error: ‘udma_pm_suspend’
  defined but not used [-Werror=unused-function]
 5530 | static int udma_pm_suspend(struct device *dev)
      |            ^~~~~~~~~~~~~~~

These functions are used conditionally with CONFIG_PM_SLEEP,
so they should be likewise defined.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/dma/ti/k3-udma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index fc3a2a05ab7b..f189b0f2e423 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -5527,6 +5527,7 @@ static int udma_probe(struct platform_device *pdev)
 	return ret;
 }
 
+#ifdef CONFIG_PM_SLEEP
 static int udma_pm_suspend(struct device *dev)
 {
 	struct udma_dev *ud = dev_get_drvdata(dev);
@@ -5573,6 +5574,7 @@ static int udma_pm_resume(struct device *dev)
 
 	return 0;
 }
+#endif
 
 static const struct dev_pm_ops udma_pm_ops = {
 	SET_LATE_SYSTEM_SLEEP_PM_OPS(udma_pm_suspend, udma_pm_resume)
-- 
2.27.0

