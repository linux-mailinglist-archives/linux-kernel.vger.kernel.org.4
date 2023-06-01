Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92EC771A206
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 17:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234926AbjFAPGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 11:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233678AbjFAPEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 11:04:42 -0400
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429B8198E
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 08:03:32 -0700 (PDT)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1b010338d82so4439465ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 08:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685631689; x=1688223689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GvBjA4f+x+l+Skjyvt+2SPWzkMrr8PFd+q36DPYPr/I=;
        b=bzJ4jU0WClHtjcePctYLLq8ptSRv1RNXiiFih+6jn8u6dAn0GwxEzEoTjfe8hYywDP
         MT9F04ejf8olI6bDjNZSpQIf1sajyAIBDxy3cgUWzb9ONtdA8bmFlP4WWD3CDovKJ5Dx
         AhBadsTI5LF6NxThu992XqO7lFo3WI7stz/+b+8xSkhTfVIJ9hx8GLXzRNsKcYXiP2Y2
         xu130Bag9YCqv1SpfiJxFcOEItltZxCDr/NCXosuobZJosQh8EhaS7Rqbcz92LB+uf0u
         /HsAB1oLqi8ObKn1V4bUgVYp2O3Zy8LFLOtvzDLTP2ogKy756oU7uTwkI6seXvTffIOo
         pCHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685631689; x=1688223689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GvBjA4f+x+l+Skjyvt+2SPWzkMrr8PFd+q36DPYPr/I=;
        b=j1FEwi8ADd76I+3lTKJa+50GeATxGZrkP9N0AMN8stXk+XXcnW7E/qqKPEiMqw44QT
         YzRuBiiHaP0J577jeIkmZmoibOkQXORSM51nqWnMlx59qBx3jvRF9OQSHsqDjDl/eaH6
         3QxAaswx4W8Xb9NVEvz7gYrBmj57CudIPvfO/lccRmOjAnK+VDgHOFh6/quISPKT6K7S
         CRsc23lRQuxXak69EvdFs73WZiPtq6KJcZUg6K/18u8Q66+eEjOQRWtMMDWlCiVIMUD4
         Oh+Q6VO9Uy7x7jxJa6cMizCgDNI4oFUUNXjISovaGDQUG89cM+fixKywI39c3hUFybQQ
         8Imw==
X-Gm-Message-State: AC+VfDx4ecMhS9p7giBh7+NtlhvpHFrgB7Uo6yByVwrcLZbP7Xbc2yxK
        ig52tYA0IPIYz9IL76N/m3eT
X-Google-Smtp-Source: ACHHUZ6MTf2zs1nPSgalZc/iisRLp3EZNGNRCGEUNzi0Xt0DrPoxh8pKEnqC5CDMe9snGvbMyFQCvg==
X-Received: by 2002:a17:902:6b05:b0:1b0:5e0f:16a5 with SMTP id o5-20020a1709026b0500b001b05e0f16a5mr4913488plk.11.1685631689682;
        Thu, 01 Jun 2023 08:01:29 -0700 (PDT)
Received: from localhost.localdomain ([117.217.186.123])
        by smtp.gmail.com with ESMTPSA id q7-20020a170902dac700b001b0499bee11sm3595480plx.240.2023.06.01.08.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 08:01:29 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [RESEND PATCH v5 3/9] PCI: endpoint: Warn and return if EPC is started/stopped multiple times
Date:   Thu,  1 Jun 2023 20:30:57 +0530
Message-Id: <20230601150103.12755-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230601150103.12755-1-manivannan.sadhasivam@linaro.org>
References: <20230601150103.12755-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the EPC is started or stopped multiple times from configfs, just emit
a once time warning and return. There is no need to call the EPC start/stop
functions in those cases.

Reviewed-by: Kishon Vijay Abraham I <kishon@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/pci-ep-cfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index 4b8ac0ac84d5..62c8e09c59f4 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -178,6 +178,9 @@ static ssize_t pci_epc_start_store(struct config_item *item, const char *page,
 	if (kstrtobool(page, &start) < 0)
 		return -EINVAL;
 
+	if (WARN_ON_ONCE(start == epc_group->start))
+		return 0;
+
 	if (!start) {
 		pci_epc_stop(epc);
 		epc_group->start = 0;
-- 
2.25.1

