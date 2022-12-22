Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DED06542B2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 15:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235711AbiLVOQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 09:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbiLVOPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 09:15:30 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66F52EF90
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 06:13:02 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id n4so2147298plp.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 06:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9vMWr+QReiCFTMChXS+VaiIVai5hcXHpa8PnZ2xGs0=;
        b=CdISaZLIaDAiejs3ebXWfckHizcdGNVuYMECOILk4yH8xwZVwxG4rqfNknKiQ9bMxv
         K6t7qbFpxglLraOezwuKyzjqE8CILTiYQ8fqC9spqWBaWJemqGlFl9HcxUr/IKp4GiVs
         lmvYjvo5Xsua2Dr3Hikt0B9Qgo+BR+9rdhHGiGch3nEldEUjjhkJEPBqpNEJNmNBWlR7
         afSp0RPecbEl4ZEjX8yxe7ItSy8y0659l6Vht++AZTi1zjiu/7I/OJvwdg/hfknwmO05
         fKeR62Njz+K0Ku39QJtMu4hAR3KOVexrkaHShOcxUgXcwsBT/pNtnOm1BuGm8aBWvH1H
         26Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+9vMWr+QReiCFTMChXS+VaiIVai5hcXHpa8PnZ2xGs0=;
        b=sdllJi0937JMmkmsdJZdTZoy4T40iciyXPicesAPxR7IIKa9KIeRW6KFX0x/uQ/i2p
         KJZJeUkiCPX740ZnDz8xid8N1HXD2kGu0SCOvSoC51QOovavIcKMMQWQ/0NTgTBY3noQ
         XX4yZbmbfHoCIjtVVz33UKv8/oVRg6dah77Z27aBbrasfctFdRgTL2IobUK2q302qqm/
         J2VG3spnlDLe4n82jCia2odsTMwE347+iBy4TWaai4UVBTZfLEH1JSo7YW4Wd2RVo+sS
         XJ6t3FP0oZbBitIIs7qTk5hOJIUyzN2GBT3rYWgPBCJD3jtVb3HCBCsT+2e6CJM23CqF
         FlUQ==
X-Gm-Message-State: AFqh2kp7vfwFr3g+1eLvfR9q8Cfis2cgrLQlF5bpbQuajoP4S0XfXCwe
        ahE5zDTBIgMols5laveS+C6YyxtXEva77C8=
X-Google-Smtp-Source: AMrXdXsteySjBHCQNu+U2EA0Z9ki5BDJhCG3tehQDYHTLHrsEX/9rNG3ICW7RmKBQP2Yjf+3ELN7ag==
X-Received: by 2002:a17:90b:3712:b0:223:ceed:ef6f with SMTP id mg18-20020a17090b371200b00223ceedef6fmr6803083pjb.10.1671718382131;
        Thu, 22 Dec 2022 06:13:02 -0800 (PST)
Received: from localhost.localdomain ([117.217.177.177])
        by smtp.gmail.com with ESMTPSA id f8-20020a655908000000b0047829d1b8eesm832031pgu.31.2022.12.22.06.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 06:13:01 -0800 (PST)
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
Subject: [PATCH v5 23/23] MAINTAINERS: Add myself as the maintainer for Qcom UFS drivers
Date:   Thu, 22 Dec 2022 19:40:01 +0530
Message-Id: <20221222141001.54849-24-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221222141001.54849-1-manivannan.sadhasivam@linaro.org>
References: <20221222141001.54849-1-manivannan.sadhasivam@linaro.org>
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

Acked-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7729a30b9609..7638c749a63f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21411,6 +21411,14 @@ L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
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

