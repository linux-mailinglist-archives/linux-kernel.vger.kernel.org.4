Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097A15BB072
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 17:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiIPPl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 11:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiIPPli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 11:41:38 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C37B07D9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 08:41:29 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id r18so50301540eja.11
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 08:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=3rWhpVU0FxYCOEFcDMaJ3/dzkVgGg4KH/F7dataNBvc=;
        b=WpeV0Sx4Da9Ad4X7fCVSIaKjmwghRQAGsYDw4LogGRg2EdktF9TPMCULNbLzZkw98M
         aP4HaqOQZ5+GzNQu4Y3aOgQP8w47XIPaMhPXPzmT3G7f8kKpTuH/y472OEnOr6KdjihZ
         0yPJbavjaDnPAdnxSR/xUZl+pTwMrXmOFNeQbvzvL8Qae3Mr54Rhiv8p6y3iCzzE52IJ
         0IfVvsx5KaRkaxLdrNCHjKupiwDL3IASqT+H0G2bfd6xLch/nQu04dYAiWlre3oIjMji
         butUoFjX70GkEDrVQmyF3GAecppcR0wXzByw9hgzZC2m7kCzd/WehjANL/RNIufBAbOr
         ktEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=3rWhpVU0FxYCOEFcDMaJ3/dzkVgGg4KH/F7dataNBvc=;
        b=K8ER4lT2O3ZTTrbdr2iIB/rns4NJ76PFxU5a7IvobVDxo5Y4KHQ17xEURvy++C10+c
         uZ6o9bHmxBpGchQfiwBgC8MOThC/epPNy2bKm12qgURvC7lqxvXaevioOWuTkSAU32tX
         YTtLXar1nDrBydrgoWCI7gcFJBTHDuSRCKI3zSj4Z7Qq2u7Wd+V8oqR7gYuLoixXleuY
         c+dzOms9GUyv2s/fleIndCR0j97/FViXSnTsl2H3uali23jbe5hl6M02dwzyhcyKw9na
         BoONjFQ5sWUS7v7I5Qpfy6mnmi6QUmf6mNlMxiJb17xm72KfWdvdgOEW3vw0krsLH0A0
         wmVw==
X-Gm-Message-State: ACrzQf0vLCnwxNYtToCMQAdQW9fdICYfvhv6cp+qcES8HDvnvP0CV5O6
        6BfUM4aOFPVVOpT5k7A8uRQQqw==
X-Google-Smtp-Source: AMsMyM5qELENsKyN4y9BUf9rbsxXWYMdsbLMVjZZlNvHHrgUdUHakR00cq8lmIvn8es9TIISjx8Qnw==
X-Received: by 2002:a17:907:2c77:b0:77c:59aa:c011 with SMTP id ib23-20020a1709072c7700b0077c59aac011mr4122782ejc.724.1663342887927;
        Fri, 16 Sep 2022 08:41:27 -0700 (PDT)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id e10-20020a1709062c0a00b0073d638a7a89sm10567707ejh.99.2022.09.16.08.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 08:41:26 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Ekansh Gupta <ekangupt@qti.qualcomm.com>,
        Bharath Kumar <bkumar@qti.qualcomm.com>,
        Himateja Reddy <hmreddy@quicinc.com>,
        Anirudh Raghavendra <araghave@quicinc.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 8/9] misc: fastrpc: Add mmap request assigning for static PD pool
Date:   Fri, 16 Sep 2022 18:41:01 +0300
Message-Id: <20220916154102.1768088-9-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220916154102.1768088-1-abel.vesa@linaro.org>
References: <20220916154102.1768088-1-abel.vesa@linaro.org>
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

If the mmap request is to add pages and thre are VMIDs associated with
that context, do a call to SCM to reassign that memory. Do not do this
for remote heap allocation, that is done on init create static process
only.

Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/misc/fastrpc.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 971d4fc697fa..b45f1285317a 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1841,8 +1841,9 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 	if (copy_from_user(&req, argp, sizeof(req)))
 		return -EFAULT;
 
-	if (req.flags != ADSP_MMAP_ADD_PAGES) {
+	if (req.flags != ADSP_MMAP_ADD_PAGES && req.flags != ADSP_MMAP_REMOTE_HEAP_ADDR) {
 		dev_err(dev, "flag not supported 0x%x\n", req.flags);
+
 		return -EINVAL;
 	}
 
@@ -1888,6 +1889,22 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
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
2.34.1

