Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70506FEF8F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 12:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237843AbjEKKAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 06:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237882AbjEKJ74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 05:59:56 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A022A6
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:59:56 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3064099f9b6so5420886f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683799195; x=1686391195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7gMr5NOPVmuNsZ2AgAQsBS1s/tGTLr7USPVZEmTtLAM=;
        b=P69Q7bzbfakRA/K9JgmDghQPAMnRpt0SCpQ7ZEumIPlKWL6gppMxmleXCq84NRDQec
         L2leVzR/3FWZLsOj6Tl6Lex+dPFazIfbltuPkNdELguYK9TjZf/WA3SwYldnKNuD33cY
         i6uyQL+VVn9SJjeCEw1kfc9ZC3MC3bElmvRDJRLebt/SEChGfGw+F+z5Xcf2FixWs+Xp
         Sg7ShRary7Rz+qfF4Bwfz3G5Fgox00N/+dYFL+zNdz36daMbcPuLYtYVi8wEXEoFrAq3
         tYrRDOVU9B+js8/ZnaxWh01dOtRU60ZLFi0ybj43WSF9n9IwXb3clh60dC0V+yh+OPsZ
         m9fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683799195; x=1686391195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7gMr5NOPVmuNsZ2AgAQsBS1s/tGTLr7USPVZEmTtLAM=;
        b=YO949Rpqq9BpgdL3+4fmc9lv2cWqith7l6sERRmA5HMpwIKVj1ptKc4ic0zDAmesn3
         U1G7M8+V/NUK4GQWPVkjSBS7HkfI27eg2j9ITKZal9OezGMmfA6dh1kSB6G4Z221VcIs
         38QHOBO4f5VmArxDH5/tir9wtn7bEuKNGEHSmQGGHtkchM8DUzV7mKAgeATZI/iodGox
         TDCqRFniK3SrgcbNp2KHekxcABwjc2JCIsfnGYnIsjP1MvlpLpwIKygWYEULz/BF7nQ6
         Jz59zai+FDRjAAXO6CRoZ1Q2RLC6EdTXn6HqotWOTKdm4UYz4IVLG59kOkkqgGIE9IvM
         spgw==
X-Gm-Message-State: AC+VfDwAcayjZsUEn0uNioi3sVdxBWXhOlq83cKUGAgMuG2WEDkMZbSU
        W9XubikD4yW8DIEWW+3sfAuIXA==
X-Google-Smtp-Source: ACHHUZ4pzscXK11l7u6GlPD+PahTw1+974nMATdOD8dNFVVaDttsw1qXyCihSWf8jbDdM1+W/oZSLg==
X-Received: by 2002:adf:d0c7:0:b0:306:372d:7891 with SMTP id z7-20020adfd0c7000000b00306372d7891mr14334874wrh.59.1683799195475;
        Thu, 11 May 2023 02:59:55 -0700 (PDT)
Received: from localhost.localdomain ([64.64.123.10])
        by smtp.gmail.com with ESMTPSA id k9-20020a05600c1c8900b003f4283f5c1bsm12122791wms.2.2023.05.11.02.59.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 11 May 2023 02:59:55 -0700 (PDT)
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        jean-philippe <jean-philippe@linaro.org>,
        Wangzhou <wangzhou1@hisilicon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        iommu@lists.linux.dev, acc@lists.linaro.org,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH v2 2/2] uacce: vma_close clears q->qfrs when freeing qfrs
Date:   Thu, 11 May 2023 17:59:21 +0800
Message-Id: <20230511095921.9331-3-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230511095921.9331-1-zhangfei.gao@linaro.org>
References: <20230511021553.44318-1-zhangfei.gao@linaro.org>
 <20230511095921.9331-1-zhangfei.gao@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vma_close frees qfrs but not clears q->qfrs, which still points
to the freed object, leading to subsequent mmap fail.
So vma_close clears q->qfrs as well.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/misc/uacce/uacce.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
index 338b59ef5493..930c252753a0 100644
--- a/drivers/misc/uacce/uacce.c
+++ b/drivers/misc/uacce/uacce.c
@@ -200,12 +200,15 @@ static int uacce_fops_release(struct inode *inode, struct file *filep)
 static void uacce_vma_close(struct vm_area_struct *vma)
 {
 	struct uacce_queue *q = vma->vm_private_data;
-	struct uacce_qfile_region *qfr = NULL;
 
-	if (vma->vm_pgoff < UACCE_MAX_REGION)
-		qfr = q->qfrs[vma->vm_pgoff];
+	if (vma->vm_pgoff < UACCE_MAX_REGION) {
+		struct uacce_qfile_region *qfr = q->qfrs[vma->vm_pgoff];
 
-	kfree(qfr);
+		mutex_lock(&q->mutex);
+		q->qfrs[vma->vm_pgoff] = NULL;
+		mutex_unlock(&q->mutex);
+		kfree(qfr);
+	}
 }
 
 static const struct vm_operations_struct uacce_vm_ops = {
-- 
2.39.2 (Apple Git-143)

