Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B783870E063
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 17:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237519AbjEWP0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 11:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237159AbjEWPZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 11:25:58 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4353911A
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 08:25:57 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f607766059so20666415e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 08:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684855556; x=1687447556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vtHjf8tmYI3ZWMqguRcZxgtgzPgY3GUowQhdG2xj7pc=;
        b=xQe/ktWmD4JMJfhbtklfWDTSH3FXKwlO852JBt3S2tI18wgy9kKp+1J/bUORTGyvlH
         QprBFnmOmeSHPEZyqgcwvssdRlT9Q5DeEQ/SNLSxDhnHsF2iefOgsqPjz1jSALv1TqdY
         h5rOL/XEdBc8iTD94MpdkxFaznCINNuCQg0Zp9awHz78ey37y/bjGaOv+KwnMfNIYRzA
         FoJP0RP/q+Qa3wgF3A+dsAeT2XF+cmf2ye3R0aipSLGhMW6RgYNd6Hem0c5j6QAOMyrY
         IGx7UvA8gCBmnsVH8XAnMkz7G55JPgZ/a2sWjRB/n2AwQei66NwkTh3vtAFQLXilv69x
         RhOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684855556; x=1687447556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vtHjf8tmYI3ZWMqguRcZxgtgzPgY3GUowQhdG2xj7pc=;
        b=Vp3q223sMC6pLUeVzQgMFxkWkaIt9837XxlEsqCBCsJSUaf9sK+lKxL6dw1vxVFRCI
         fJNEq35/rwPI+LqJ0I80D4hhz5uq6Zc4xeUJ7mNL6Y0zrK7VWIceCbUjw6x6vAELugW3
         +ScFeFJD6PTgrjWE+/Ga5JmA3tg9m0TkiXsyJchjXfGU6z7fgcroErzu32ap1MJoO8wi
         lTOcd4Mf4b76MkxqVlY4tUpkmUlYSVlOyy6HzbhEhLxlA0F/9BenF9BqoLVTbTJ3tbTc
         YwDguK4iITTWq+BOD0bxsWJntDSdFnuYC/TZOVyliDiGGWEuRx+h7DoGlACOxxoDt4le
         jlLg==
X-Gm-Message-State: AC+VfDxJ5tFohNk4HY+2qO/lwNhWx/FDGgPOAm+FyrOWKkqgj3FIY8Uf
        GFxCf37SbyiFGdnTK1bZNg6ZEQ==
X-Google-Smtp-Source: ACHHUZ7NCtr8fX9hfddf+2j9HCSyJWIO72S7AbSE4xmQr6TmnmpVblATYGEaXzCyxm7F7vUHw09a+w==
X-Received: by 2002:adf:fa0b:0:b0:309:4a0f:facc with SMTP id m11-20020adffa0b000000b003094a0ffaccmr11390498wrr.40.1684855555777;
        Tue, 23 May 2023 08:25:55 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id f20-20020a7bc8d4000000b003f6038faa19sm8303887wml.19.2023.05.23.08.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 08:25:55 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Ekansh Gupta <quic_ekangupt@quicinc.com>,
        stable <stable@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/4] misc: fastrpc: Pass proper scm arguments for secure map request
Date:   Tue, 23 May 2023 16:25:47 +0100
Message-Id: <20230523152550.438363-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230523152550.438363-1-srinivas.kandagatla@linaro.org>
References: <20230523152550.438363-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ekansh Gupta <quic_ekangupt@quicinc.com>

If a map request is made with securemap attribute, the memory
ownership needs to be reassigned to new VMID to allow access
from protection domain. Currently only DSP VMID is passed to
the reassign call which is incorrect as only a combination of
HLOS and DSP VMID is allowed for memory ownership reassignment
and passing only DSP VMID will cause assign call failure.

Also pass proper restoring permissions to HLOS as the source
permission will now carry both HLOS and DSP VMID permission.

Change is also made to get valid physical address from
scatter/gather for this allocation request.

Fixes: e90d91190619 ("misc: fastrpc: Add support to secure memory map")
Cc: stable <stable@kernel.org>
Tested-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index f48466960f1b..32a5415624bf 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -316,12 +316,14 @@ static void fastrpc_free_map(struct kref *ref)
 	if (map->table) {
 		if (map->attr & FASTRPC_ATTR_SECUREMAP) {
 			struct qcom_scm_vmperm perm;
+			int vmid = map->fl->cctx->vmperms[0].vmid;
+			u64 src_perms = BIT(QCOM_SCM_VMID_HLOS) | BIT(vmid);
 			int err = 0;
 
 			perm.vmid = QCOM_SCM_VMID_HLOS;
 			perm.perm = QCOM_SCM_PERM_RWX;
 			err = qcom_scm_assign_mem(map->phys, map->size,
-				&map->fl->cctx->perms, &perm, 1);
+				&src_perms, &perm, 1);
 			if (err) {
 				dev_err(map->fl->sctx->dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d",
 						map->phys, map->size, err);
@@ -787,8 +789,12 @@ static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
 		goto map_err;
 	}
 
-	map->phys = sg_dma_address(map->table->sgl);
-	map->phys += ((u64)fl->sctx->sid << 32);
+	if (attr & FASTRPC_ATTR_SECUREMAP) {
+		map->phys = sg_phys(map->table->sgl);
+	} else {
+		map->phys = sg_dma_address(map->table->sgl);
+		map->phys += ((u64)fl->sctx->sid << 32);
+	}
 	map->size = len;
 	map->va = sg_virt(map->table->sgl);
 	map->len = len;
@@ -798,9 +804,15 @@ static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
 		 * If subsystem VMIDs are defined in DTSI, then do
 		 * hyp_assign from HLOS to those VM(s)
 		 */
+		u64 src_perms = BIT(QCOM_SCM_VMID_HLOS);
+		struct qcom_scm_vmperm dst_perms[2] = {0};
+
+		dst_perms[0].vmid = QCOM_SCM_VMID_HLOS;
+		dst_perms[0].perm = QCOM_SCM_PERM_RW;
+		dst_perms[1].vmid = fl->cctx->vmperms[0].vmid;
+		dst_perms[1].perm = QCOM_SCM_PERM_RWX;
 		map->attr = attr;
-		err = qcom_scm_assign_mem(map->phys, (u64)map->size, &fl->cctx->perms,
-				fl->cctx->vmperms, fl->cctx->vmcount);
+		err = qcom_scm_assign_mem(map->phys, (u64)map->size, &src_perms, dst_perms, 2);
 		if (err) {
 			dev_err(sess->dev, "Failed to assign memory with phys 0x%llx size 0x%llx err %d",
 					map->phys, map->size, err);
-- 
2.25.1

