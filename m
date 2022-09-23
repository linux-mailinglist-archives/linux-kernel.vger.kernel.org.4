Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0565E7167
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 03:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiIWBaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 21:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiIWB37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 21:29:59 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB453C144;
        Thu, 22 Sep 2022 18:29:58 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id x1so10431637plv.5;
        Thu, 22 Sep 2022 18:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=BIsSLdpidxx83exFCWBH/9sXWFQ6C6T0sUJqOwQ+WAM=;
        b=H64amwKiVWi1ibBYEVckNwt8RPPV2++7FhaWICVgrkFwMTuP0zDO1pGiZVIMrPgtpw
         awb9DX2sEf5eq/pqOblPEAx1pLwwaQb+9lS3e1eq9purgn/fv11Jzdoedv52H2133tsW
         mAsH3JcoUOt30CimhM7M9dGm4Q8FsGG8ak8gXxFcoSu72bTez0dWhj2bwNPkjiOyXnNc
         hxJZI2tBMj6yC72ggdn98foByJPW5TWYTToWEG9dCccPjrllQA4ktDz44jTS7neYro/o
         WGdW5FxZShAn7QB9tWu81+jf9mzzTKqGtM0jYbeciApPCm3iue8UVSmyCMroYUiTyNwf
         mddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=BIsSLdpidxx83exFCWBH/9sXWFQ6C6T0sUJqOwQ+WAM=;
        b=bh6mJfr8GgySfskqFhOrYab12M1XCoVSc26WN3px7Qizq2nF9z8/XqNp8s4ZpF/bWk
         Fjb+Nt91nratyLr1ZL2yyvfkzUf8Kk3WAH5pa7SGdKDAj+1Xc9c8guKlyAderECtGPFs
         5OpSIEgL17DDQ+JXbDFUHfVKcM5Fxk7kDSfemjCyentkLBklhzhIxThMYPw9I9TMqEwq
         Wqlnz49gF6wQ6oMpAtX7RxEovJxQKcEaVZB0O5ZoyVkjqVVZAihURc8AivbjcvhaM9FA
         zDfVOfkY14zrURl5h7VC2RrCqAaXJynHyoCx31VPMGH6a809Ho88SOGzxqvG44wjRkvb
         Bg6Q==
X-Gm-Message-State: ACrzQf01Dwm7yy5CY0ePWDb758du8vlBjR54TCKsXgFweexuts/0DNLt
        I5BKlOk358M3cMNs0UllIBE=
X-Google-Smtp-Source: AMsMyM5sQV32DSU4gTRnx+H/DnIhx/iC6CDKvN+XUwW7p3J8d2TvbUwBif8Sef367c6Y7ULxWKw3UA==
X-Received: by 2002:a17:903:4112:b0:178:29d8:6d56 with SMTP id r18-20020a170903411200b0017829d86d56mr6194493pld.143.1663896597816;
        Thu, 22 Sep 2022 18:29:57 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id i9-20020a17090332c900b00176b63535ccsm4760363plr.193.2022.09.22.18.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 18:29:57 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     herbert@gondor.apana.org.au
Cc:     bbrezillon@kernel.org, arno@natisbad.org, schalla@marvell.com,
        davem@davemloft.net, keescook@chromium.org, gustavoars@kernel.org,
        colin.i.king@gmail.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>
Subject: [PATCH linux-next] crypto: marvell/octeontx - use sysfs_emit() to instead of scnprintf()
Date:   Fri, 23 Sep 2022 01:29:52 +0000
Message-Id: <20220923012952.238269-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Replace the open-code with sysfs_emit() to simplify the code.

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/crypto/marvell/octeontx/otx_cptvf_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/marvell/octeontx/otx_cptvf_main.c b/drivers/crypto/marvell/octeontx/otx_cptvf_main.c
index 36d72e35ebeb..88a41d1ca5f6 100644
--- a/drivers/crypto/marvell/octeontx/otx_cptvf_main.c
+++ b/drivers/crypto/marvell/octeontx/otx_cptvf_main.c
@@ -661,7 +661,7 @@ static ssize_t vf_type_show(struct device *dev,
 		msg = "Invalid";
 	}
 
-	return scnprintf(buf, PAGE_SIZE, "%s\n", msg);
+	return sysfs_emit(buf, "%s\n", msg);
 }
 
 static ssize_t vf_engine_group_show(struct device *dev,
@@ -670,7 +670,7 @@ static ssize_t vf_engine_group_show(struct device *dev,
 {
 	struct otx_cptvf *cptvf = dev_get_drvdata(dev);
 
-	return scnprintf(buf, PAGE_SIZE, "%d\n", cptvf->vfgrp);
+	return sysfs_emit(buf, "%d\n", cptvf->vfgrp);
 }
 
 static ssize_t vf_engine_group_store(struct device *dev,
@@ -706,7 +706,7 @@ static ssize_t vf_coalesc_time_wait_show(struct device *dev,
 {
 	struct otx_cptvf *cptvf = dev_get_drvdata(dev);
 
-	return scnprintf(buf, PAGE_SIZE, "%d\n",
+	return sysfs_emit(buf, "%d\n",
 			 cptvf_read_vq_done_timewait(cptvf));
 }
 
@@ -716,7 +716,7 @@ static ssize_t vf_coalesc_num_wait_show(struct device *dev,
 {
 	struct otx_cptvf *cptvf = dev_get_drvdata(dev);
 
-	return scnprintf(buf, PAGE_SIZE, "%d\n",
+	return sysfs_emit(buf, "%d\n",
 			 cptvf_read_vq_done_numwait(cptvf));
 }
 
-- 
2.25.1
