Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4FC67E1EB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 11:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjA0Kkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 05:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjA0Kkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 05:40:37 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512379EE2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:40:24 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id m15so3122912wms.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nTkajujz2PbWOlDLokzlXiyxOl9BSGAFgie62+J1Eyo=;
        b=s+W5+n62jwib/xTTJBkNb7ee9T+KKMqFWtG3GXq+NtAnt+YYBi917eRTRIFwvM3vf9
         44UgBD5tabXE6aj7lFEyAXedD4cqV8i+KDJtIS+9Uf3gv0YZlDYl5csLnGY7AwTHH+9q
         /4WvmwO3fzuXfqBr6Bp+l3/fqVMOniQE/s3YrBF23q/2bvYhvQDv7+5LSaFn7SPZDkeu
         otekpHHl6F92kyeyL6K38rrBuscggPJfZQi72MQG83ncBRVUBz1gmUx5Dr7fx3mtyEZR
         rozoRfzgFu1lzLf7ZAJsVE8ANaexRJM4jvJwLbK3ixI15dpUYL2FdmhE6icmZUf3FFTU
         6FsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nTkajujz2PbWOlDLokzlXiyxOl9BSGAFgie62+J1Eyo=;
        b=kCnwV1I47u1E73fSKXVp5mdlz8y9dtfFCb48zGXDkYaJm65EMRhWMlJd1/wlHx7+6c
         zAryzn3nRMs4QrnmPngejYsbzHSLayWj/zMnfGPsTKnFxglWFqKrYcHUZwZyO0mhlwlT
         wFksLqv5zBbWy3F32zcGrg5YP+kPixw3ZowKQDG3J9JvmBenLi8RS7LSIHo4hXt2k+d6
         80wkvZXWrne61UBorl5ZahbKBIz5RwLQBFaGGnWXijyIEu7FOV4PoKJ/aeCvgcaQXqKW
         bfKS0cysLr6qkUP7DiEIOReb3jZT1sJ+L2Fe8J174ZPziAJISJ+txiOhMJCihD3aT3sy
         t5rw==
X-Gm-Message-State: AFqh2kqAaiBYvxfGjvFvbvmsnsY9AXH87I0qqWKGpCrgeN5F7Q7UzyWx
        9Asgj0ctfai3DOhra/cS8FtXLbAjUUqw2kdo
X-Google-Smtp-Source: AMrXdXv2uX+g92Qeopbr15XptCvYgcTmav6tLAuhuLtOiXhi9z2GXTk8Wy0JmTm/815r6cJctVUNTQ==
X-Received: by 2002:a05:600c:3d14:b0:3da:f793:fff6 with SMTP id bh20-20020a05600c3d1400b003daf793fff6mr38791890wmb.16.1674816022840;
        Fri, 27 Jan 2023 02:40:22 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id q9-20020a1ce909000000b003dc34edacf8sm1619787wmc.31.2023.01.27.02.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 02:40:22 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>, stable@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 01/10] nvmem: brcm_nvram: Add check for kzalloc
Date:   Fri, 27 Jan 2023 10:40:06 +0000
Message-Id: <20230127104015.23839-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230127104015.23839-1-srinivas.kandagatla@linaro.org>
References: <20230127104015.23839-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiasheng Jiang <jiasheng@iscas.ac.cn>

Add the check for the return value of kzalloc in order to avoid
NULL pointer dereference.

Cc: stable@vger.kernel.org
Fixes: 6e977eaa8280 ("nvmem: brcm_nvram: parse NVRAM content into NVMEM cells")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/brcm_nvram.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvmem/brcm_nvram.c b/drivers/nvmem/brcm_nvram.c
index 34130449f2d2..39aa27942f28 100644
--- a/drivers/nvmem/brcm_nvram.c
+++ b/drivers/nvmem/brcm_nvram.c
@@ -98,6 +98,9 @@ static int brcm_nvram_parse(struct brcm_nvram *priv)
 	len = le32_to_cpu(header.len);
 
 	data = kzalloc(len, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
 	memcpy_fromio(data, priv->base, len);
 	data[len - 1] = '\0';
 
-- 
2.25.1

