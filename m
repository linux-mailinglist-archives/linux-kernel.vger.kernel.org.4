Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7FFA63845C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 08:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiKYHPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 02:15:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiKYHO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 02:14:58 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6579C2B18B
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 23:14:55 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id b12so5454230wrn.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 23:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FKqf7AY9wkyxhDSY9O3AODzo3T9piYoH8GAXCkClnd4=;
        b=wyK+Wl1lgONksXAtKv9qrNKj6OtPWQsfHlpHB5BwJF43Ll2e8FQXDq+5x9Q133caiH
         umgCojPy6YCGyouqBizuFHVfaeZ6zbMgBggkAQqrcGxR4K6yiQk0LeUYgTUcuXq+cOng
         MRr+ozNZ7qndXeUlWRdSAYIMx5ncHusszhTUrquAw4Fq8ZsoWSFh8wSLWJViZMRp9C9b
         mEI6nEEhjVGzhJgi6N6JcAt6Pin1PLOh4oEV0r/RA3i5XvmYlXdw0sM6WcznyY4/3E08
         00+Qdxc9G0fq1YQu1pSb5TUh4NMviaE3rDNLImRbqGunHN3751iPlVC2VjM+n0N4UViv
         xXkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FKqf7AY9wkyxhDSY9O3AODzo3T9piYoH8GAXCkClnd4=;
        b=5bRR3d4ahLqZpS9xbkPU36POyPcSo4MSfWvMp3XQLV/ulk90yBp+mve7YSdn7CNeAg
         A6+HnrdngqGO06/1Og0TteqVKT/RNFaqkLxFYJmc+jFlJlTPYrZIqfD+5PqpTTsHLmIq
         HtNSnkiMmufnkVMYZ/e/rjNPJ9e0sflguwCGu1SBFlGm1R1kgTKBFXjBVnGFQYTAX3FJ
         AO29zjNzzHAeyKtrK93A2uO6sxrPzkUb8b9k+PXdyK4KkOm0vvC4Hl5pj8OVmD2GL1SY
         uhNAiPDuArI9YNu6jceULkb62Mqb3yKzJvD1KjCIz+nUKzCBx+4lDz6rF7k2KRO0DTRK
         mlsg==
X-Gm-Message-State: ANoB5pkxJVBN1nDo1jfFo670C8U0e3T6foCCZXg+1z3ajCWyJwEht3iY
        QabaNVg3mPDETi9Eq/7BJRSmeQ==
X-Google-Smtp-Source: AA0mqf6I0OUj2or9XRFSPLW7sRvnY85Ezb3MObFSc28hgbraqc9RXwcOcry7CxqrF6LtLKA5fCw9vQ==
X-Received: by 2002:adf:e303:0:b0:22e:3c66:bda1 with SMTP id b3-20020adfe303000000b0022e3c66bda1mr13648490wrj.139.1669360493967;
        Thu, 24 Nov 2022 23:14:53 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id c2-20020a05600c0a4200b003cfd4cf0761sm9108444wmq.1.2022.11.24.23.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 23:14:53 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 09/10] misc: fastrpc: Add mmap request assigning for static PD pool
Date:   Fri, 25 Nov 2022 07:14:04 +0000
Message-Id: <20221125071405.148786-10-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221125071405.148786-1-srinivas.kandagatla@linaro.org>
References: <20221125071405.148786-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abel Vesa <abel.vesa@linaro.org>

If the mmap request is to add pages and thre are VMIDs associated with
that context, do a call to SCM to reassign that memory. Do not do this
for remote heap allocation, that is done on init create static process
only.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 2dc9946c3d23..4b05cbd6083d 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1842,8 +1842,9 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 	if (copy_from_user(&req, argp, sizeof(req)))
 		return -EFAULT;
 
-	if (req.flags != ADSP_MMAP_ADD_PAGES) {
+	if (req.flags != ADSP_MMAP_ADD_PAGES && req.flags != ADSP_MMAP_REMOTE_HEAP_ADDR) {
 		dev_err(dev, "flag not supported 0x%x\n", req.flags);
+
 		return -EINVAL;
 	}
 
@@ -1889,6 +1890,22 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 	/* let the client know the address to use */
 	req.vaddrout = rsp_msg.vaddr;
 
+	/* Add memory to static PD pool, protection thru hypervisor */
+	if (req.flags != ADSP_MMAP_REMOTE_HEAP_ADDR && fl->cctx->vmcount) {
+		struct qcom_scm_vmperm perm;
+		int err = 0;
+
+		perm.vmid = QCOM_SCM_VMID_HLOS;
+		perm.perm = QCOM_SCM_PERM_RWX;
+		err = qcom_scm_assign_mem(buf->phys, buf->size,
+			&(fl->cctx->vmperms[0].vmid), &perm, 1);
+		if (err) {
+			dev_err(fl->sctx->dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d",
+					buf->phys, buf->size, err);
+			goto err_assign;
+		}
+	}
+
 	spin_lock(&fl->lock);
 	list_add_tail(&buf->node, &fl->mmaps);
 	spin_unlock(&fl->lock);
-- 
2.25.1

