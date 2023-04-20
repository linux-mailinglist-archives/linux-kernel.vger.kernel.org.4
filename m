Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B826E8C75
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 10:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234355AbjDTIOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 04:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234358AbjDTIOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 04:14:04 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB436359D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 01:13:55 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id l31-20020a05600c1d1f00b003f1718d89b2so2674163wms.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 01:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681978434; x=1684570434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5r/u4BLyA+TkKxbgEa0Nh6lx6vF8gZ05AKnHgjn7q0c=;
        b=huuImGBjgWXJ16g1iU2/TFT3gYDaXdQZPK168kYgwswuas8+RsfwrHgCbOpoLNvc3U
         EhN4tP4/C5MJgwxfNR7Uyku1E0SfE2b+L9hK7jva4I2WOnEJEEqALH2Ntbayu12pdHmi
         X8IAQ7yCdNqy5c9TfHoZvelPWu9+uKyWbkQhAeMt5oMa0bPtx1r7zt1nc3eyAUNA4N/3
         /l6afMsbYMcrD3i3nJAJP684ciAuRvTE4UsownPpw2SCSaYu1QudXXuxVNfMOUX0EvSG
         uEWt7Z83DFlExMCoTe7vH+4eT6GS15BtKpzO6Oycc6XjgWdHy3BLNNAit2bD25a4SI3B
         lToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681978434; x=1684570434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5r/u4BLyA+TkKxbgEa0Nh6lx6vF8gZ05AKnHgjn7q0c=;
        b=HFo0ov472MPS5htiN3ylqtA4hg+u4y5ZSJqyv7tMGsvL1bWoqe+RT7DzEQJjMMS91A
         n6v6NosGFN28Py+gbTwP1Yv2F42HCwy0B4xIFYf4rum5OuPqvAm5oCj6Q0iVd020f0RV
         oFG80rzrhY7lM6635qtplOSNXOS8RE2GULBzx6+i9MeiLLMLC/Gp2+lijywjiJNNikcf
         qk+8JIVmlPA8pdZX8J1iWGmkiyW0T9U2v++UDUN887+iT4rb0gOwwUSJKNPnxv168gnC
         aLhFlDM/PuOjS/AAuVV7n00Kg9gcKwhbgsBY2Cl22MWyLYphaOPMbpMJNewyHbEtoUKO
         RWgw==
X-Gm-Message-State: AAQBX9eSA/IHsghuJw1YzJxcD5IwWTBIKStxTa1ikWgyS6iWXxrmLskm
        yM5YctKKrGBzCIXS889fJ9nyHtF6qQ9pwx721DY=
X-Google-Smtp-Source: AKy350bY5ALOG7fBQ562Q0YtPy9gegb2h3M/pLLKmdyxQxniDs84D2dAzj8R3iGjOIwdEI+QNEoOHg==
X-Received: by 2002:a05:600c:210:b0:3f1:731e:cdb1 with SMTP id 16-20020a05600c021000b003f1731ecdb1mr590090wmi.6.1681978433906;
        Thu, 20 Apr 2023 01:13:53 -0700 (PDT)
Received: from lmecxl1178.lme.st.com ([2a04:cec0:1192:45a3:5e7a:a040:b243:429e])
        by smtp.gmail.com with ESMTPSA id v11-20020a5d43cb000000b002ff77b033b1sm1292035wrr.33.2023.04.20.01.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 01:13:53 -0700 (PDT)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        op-tee@lists.trustedfirmware.org,
        Etienne Carriere <etienne.carriere@linaro.org>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>
Subject: [PATCH] optee: fix uninited async notif value
Date:   Thu, 20 Apr 2023 09:49:23 +0200
Message-Id: <20230420074923.2281303-1-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.25.1
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

Fixes an uninitialized variable in irq_handler() that could lead to
unpredictable behavior in case OP-TEE fails to handle SMC function ID
OPTEE_SMC_GET_ASYNC_NOTIF_VALUE. This change ensures that in that case
get_async_notif_value() properly reports there are no notification
event.

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/r/202304200755.OoiuclDZ-lkp@intel.com/
Reported-by: Dan Carpenter <error27@gmail.com>
Link: https://lore.kernel.org/all/d9b7f69b-c737-4cb3-8e74-79fe00c934f9@kili.mountain/
Fixes: 6749e69c4dad ("optee: add asynchronous notifications")
Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
---
 drivers/tee/optee/smc_abi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index de7ac9a46354..6d3705770755 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -1001,8 +1001,10 @@ static u32 get_async_notif_value(optee_invoke_fn *invoke_fn, bool *value_valid,
 
 	invoke_fn(OPTEE_SMC_GET_ASYNC_NOTIF_VALUE, 0, 0, 0, 0, 0, 0, 0, &res);
 
-	if (res.a0)
+	if (res.a0) {
+		*value_valid = false;
 		return 0;
+	}
 	*value_valid = (res.a2 & OPTEE_SMC_ASYNC_NOTIF_VALUE_VALID);
 	*value_pending = (res.a2 & OPTEE_SMC_ASYNC_NOTIF_VALUE_PENDING);
 	return res.a1;
-- 
2.25.1

