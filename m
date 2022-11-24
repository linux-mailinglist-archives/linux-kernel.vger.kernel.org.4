Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0670637E9E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 18:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiKXRw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 12:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiKXRvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 12:51:55 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B94315B4D8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 09:51:52 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id i12so3530452wrb.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 09:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PryoH4Na1cIsfvTRA0L1CZLJGcy9N2macRHvAEBFkbA=;
        b=Zi1EzsgG2QlG4e8EUVrheaYLdBT6/+Tllun/yqv2JZmVgXyfnVeEmfmXDka2Wk866a
         /Lp2izyg3ZbM2Nc2NiHylfQ/8ezsHALBtihO3Zzw/WqHTje5uQFE0Eakzh6DVKzJJ36A
         N7CjtP5/N5C7eKYJW/GShrP9nMvSkc75eEBS0xsD0cCjfVKQ5Ketg8vbHy1KnE1TnM3y
         sB4eTxdmxoeyFzCkSl66ptKIThBoJ8IleUazay2ZTIc08wCzs30zsfhDrgSIj3fcO7Iv
         vdjkB9sxSB7i6rh878UFQhT8smdaaGyrGGH62yYZoVj4jfA+VZoJeHiySCiKhYCIcNp0
         Hbjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PryoH4Na1cIsfvTRA0L1CZLJGcy9N2macRHvAEBFkbA=;
        b=qt7sttEye179aN8SfQhtYXeKfN/0hWpzb54DTyUQmUyCQDNqn0UVEMynxEEq5+AGkr
         yGSilpJYQc9A8TBUWf8XlHWFdGgpFW/d7RMIPFTFZQE5++1wS6zy+9rgrb1knkGpxdGr
         6YXnpsy62y3RqagmNPapEnYHj21yTj+YeHvpowW+LB02wbVnYN8o5V34VFoXYZpwO1SU
         mfHqKIFEOPr219QEFRYEFMe6CgPMlZY1rSHSbE2LR9kQYahS5WuvvmKZcvr5xV33UXfh
         KoIjwVb3gmEYe6kJZvDkxiw2FyKggSmgFkHqJfYMBGqqY3hiq8x2VaXV6VB+nnknpj36
         7KfQ==
X-Gm-Message-State: ANoB5pk2OU6Al+M0F4kQ4J9I/6KPPNG7kwJkGztppYQkdbARzTWaaicw
        9Wt9hM3LggELu3V8j7c6rTW9uA==
X-Google-Smtp-Source: AA0mqf697EyavO58iiKvgzz7RcdFYMhwktje2cCID4YcWhiBqmK45iM6nDR5j2sA+kflPTP9+Sbqyw==
X-Received: by 2002:a05:6000:18c1:b0:236:5d8c:97fd with SMTP id w1-20020a05600018c100b002365d8c97fdmr21309432wrq.473.1669312310625;
        Thu, 24 Nov 2022 09:51:50 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id bi8-20020a05600c3d8800b003c701c12a17sm6394192wmb.12.2022.11.24.09.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 09:51:50 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 10/11] misc: fastrpc: Add mmap request assigning for static PD pool
Date:   Thu, 24 Nov 2022 17:51:24 +0000
Message-Id: <20221124175125.418702-11-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221124175125.418702-1-srinivas.kandagatla@linaro.org>
References: <20221124175125.418702-1-srinivas.kandagatla@linaro.org>
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
index 3cf76a240b7a..d3147e4313cc 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1845,8 +1845,9 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 	if (copy_from_user(&req, argp, sizeof(req)))
 		return -EFAULT;
 
-	if (req.flags != ADSP_MMAP_ADD_PAGES) {
+	if (req.flags != ADSP_MMAP_ADD_PAGES && req.flags != ADSP_MMAP_REMOTE_HEAP_ADDR) {
 		dev_err(dev, "flag not supported 0x%x\n", req.flags);
+
 		return -EINVAL;
 	}
 
@@ -1892,6 +1893,22 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
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

