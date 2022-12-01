Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728CC63F6CB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 18:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbiLARtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 12:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiLARsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 12:48:32 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BB4BD43F
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 09:46:15 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id r18so2260785pgr.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 09:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=43OqRHaaIujJi6ZlQt/N8badSJ3sWGrShf1wADibj34=;
        b=NmPY8iCDxI+NhdKK5uUYYLt8/z3vqea6wkBFcmL3hDLIQ2o87rg+rRhj+mkuN/E1z1
         gLdcQ0VjJJrZwx2+tj6eWlyids+OqliSDb82dhXf+V9km/G2FgMPVSxJF0tPUx9HtApI
         0zHIeHNft62jZOjXQ0tID5RteBnF++m1Ry72uLtWQ/re8HR0wBS67ohbK3Vjmn8K9bKD
         VI+c0Ws0++zPjmSHNsSL5U8DDR7ztW4XttZKgFQ8nQAszbwyYEwbAuOFbBx6aeopiexo
         ibofa9Gkr8xq5YUroQb67IM68EFua/fbX7SFpy51N6hiMrqvwLJPklmfywd93kQbm4Q8
         t4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=43OqRHaaIujJi6ZlQt/N8badSJ3sWGrShf1wADibj34=;
        b=m/7ur7ncA+RO/7mTg31Ks5CfnTaFxqoCOdpjkwhAWJlrDainhHyhh3p6uV3jtc8WMt
         Sh6KFRNqox+7bvqC05sFH1IZScXgyc0AtANSvDBN8F3sHuh5ugMLi/KfAn2QshvRMGsc
         5nzkcpuUmCFMAP7r/I0DVElq9FXHscLpWMCuC2N4M8hnlIIbmUo1p7GCEZv6U2JdKZf1
         26M/Hsg7c6I+69gmcGr+59rFr6U8ObzlF1/CSSDhAGij1//+I+J2UO+FIwapgpJAP8nE
         a6LYWDxE2UzzQXA6xyagRdggZZ2eD2BXFZLMMgO5bBnjFmNi4cu2pVHPkkOQmEpfNIzF
         lNZQ==
X-Gm-Message-State: ANoB5pkJg07tMNthEQ4KkDy3FlJG3mrd2RcmXAvczNc11L+1VNjswIdy
        t1NqCI0oS56FMq5C6dgZYIe2
X-Google-Smtp-Source: AA0mqf64D09WmHdfFGHHBXjzBUhd1iZ31q9mHzfnHXrDTrmY1nFgAImzsVcgggCYrYBrM0bUZjm06A==
X-Received: by 2002:a62:3006:0:b0:554:7525:7acf with SMTP id w6-20020a623006000000b0055475257acfmr48105047pfw.44.1669916775237;
        Thu, 01 Dec 2022 09:46:15 -0800 (PST)
Received: from localhost.localdomain ([220.158.159.39])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902780400b0016d9b101413sm3898743pll.200.2022.12.01.09.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 09:46:14 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, vkoul@kernel.org
Cc:     quic_cang@quicinc.com, quic_asutoshd@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org,
        dmitry.baryshkov@linaro.org, ahalaney@redhat.com,
        abel.vesa@linaro.org, alim.akhtar@samsung.com, avri.altman@wdc.com,
        bvanassche@acm.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 23/23] MAINTAINERS: Add myself as the maintainer for Qcom UFS drivers
Date:   Thu,  1 Dec 2022 23:13:28 +0530
Message-Id: <20221201174328.870152-24-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221201174328.870152-1-manivannan.sadhasivam@linaro.org>
References: <20221201174328.870152-1-manivannan.sadhasivam@linaro.org>
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

Qcom UFS drivers are left un-maintained till now. I'd like to step up to
maintain the drivers and the binding.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3583c5f6889d..3c8214f4a3cf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21379,6 +21379,14 @@ L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	drivers/ufs/host/ufs-mediatek*
 
+UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER QUALCOMM HOOKS
+M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+L:	linux-arm-msm@vger.kernel.org
+L:	linux-scsi@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
+F:	drivers/ufs/host/ufs-qcom*
+
 UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER RENESAS HOOKS
 M:	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
 L:	linux-renesas-soc@vger.kernel.org
-- 
2.25.1

