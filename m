Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6D170E064
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 17:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237533AbjEWP0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 11:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbjEWPZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 11:25:59 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F417FA
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 08:25:58 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f60e730bf2so5165055e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 08:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684855557; x=1687447557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S0Ip027E/uKlYL3/noihqKDGdX3mNY2iO9EhIPN4jks=;
        b=MTZUoJekmmO4noN8ATFda3iRXovin8to6p3Z9xIfX8xIipAop7l4jT1inC03lLOF/z
         5OBMj2WDtmpjOZzzgiqvp1BsF3oZWauzcSu1o8bk+aZ+FbYVxpogGjbJaxtVL90G9I4t
         DuTBgEoBSi4nJd0G73ho/AG6xE3uYqvktewMmyDqHCTh7VlBuvu5MeawVHkKxckXEFeK
         t4l0/YKmVxw/WOe95Fxt6hcBmaePgFc1v/kkShTxARCHhtKLQ7FHPccbiZv+IRotNPEY
         /E9CILBQyhmRlMtI4K9QDK/DS12DizRxRnmUuaidIsHsOTXS8JvRq7aOBcUjYwX91e/l
         egTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684855557; x=1687447557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S0Ip027E/uKlYL3/noihqKDGdX3mNY2iO9EhIPN4jks=;
        b=AnbH0A/sAs2gepFdBnbcSM5inEHUCR4X/s/ChTpF3XroG5dpukNmfMN1qZFDnAk8ld
         dbY4m4STFILCL6D9wrSoLjtVrk3LFXD11dpIlCy57w8WbpTjUjIEXF6DqGJeTxStfbaa
         gA7e9dRH4VJ0SfwgidAWItSMPsL70JmWGh4lkGmvwdsO5gNUCIeeae8wo7A4fkMG7knH
         Ctkw/X4+d4yZbDH0ibtTMtyQcOoElM6e9yJoBZarqDswBrZHdRK3NvIIwvpksMTDA2Zg
         Mw9apPFdN4UJwTlrzdoxQGYcAU+OPuk1rfj1qxPDoLjsviQHbVlUIT3Vw4iOxMsD2HzS
         HL5A==
X-Gm-Message-State: AC+VfDwHITHgogjuu52XlQPnrT1lVshNHQe9UqnS6uPI97A1BSnm1StZ
        uuadeAzsSkMfsf/aMu7y6LjZHQ==
X-Google-Smtp-Source: ACHHUZ4z20W7o9ZbD19+vNTqjTd3iCLlXOJ/a0XYgQC5p7lWsjftWe2I+a5AYO2VQJzs8U8SW2SPeA==
X-Received: by 2002:a1c:f217:0:b0:3f4:2c71:b9ad with SMTP id s23-20020a1cf217000000b003f42c71b9admr10655188wmc.30.1684855557091;
        Tue, 23 May 2023 08:25:57 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id f20-20020a7bc8d4000000b003f6038faa19sm8303887wml.19.2023.05.23.08.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 08:25:56 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Ekansh Gupta <quic_ekangupt@quicinc.com>,
        stable <stable@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/4] misc: fastrpc: Reassign memory ownership only for remote heap
Date:   Tue, 23 May 2023 16:25:48 +0100
Message-Id: <20230523152550.438363-3-srinivas.kandagatla@linaro.org>
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

The userspace map request for remote heap allocates CMA memory.
The ownership of this memory needs to be reassigned to proper
owners to allow access from the protection domain running on
DSP. This reassigning of ownership is not correct if done for
any other supported flags.

When any other flag is requested from userspace, fastrpc is
trying to reassign the ownership of memory and this reassignment
is getting skipped for remote heap request which is incorrect.
Add proper flag check to reassign the memory only if remote heap
is requested.

Fixes: 532ad70c6d44 ("misc: fastrpc: Add mmap request assigning for static PD pool")
Cc: stable <stable@kernel.org>
Tested-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 32a5415624bf..a654dc416480 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1904,7 +1904,7 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 	req.vaddrout = rsp_msg.vaddr;
 
 	/* Add memory to static PD pool, protection thru hypervisor */
-	if (req.flags != ADSP_MMAP_REMOTE_HEAP_ADDR && fl->cctx->vmcount) {
+	if (req.flags == ADSP_MMAP_REMOTE_HEAP_ADDR && fl->cctx->vmcount) {
 		struct qcom_scm_vmperm perm;
 
 		perm.vmid = QCOM_SCM_VMID_HLOS;
-- 
2.25.1

