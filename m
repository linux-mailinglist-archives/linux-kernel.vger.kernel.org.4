Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E9671A1D2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 17:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbjFAPE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 11:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233663AbjFAPED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 11:04:03 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3A6E5E
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 08:02:59 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b011cffe7fso4311685ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 08:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685631709; x=1688223709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1PIsP178Wnb1M5epQp5PS0aVEa7SerWOVU16+rPTld8=;
        b=NRtkOFoXrRqIAsQYHfizsKkfazkBZu/PmGKjM9DDmcpy6pDBO4lAI0EUIjl/wkhpUv
         QhiG9mO6+xJzFpZ4b6tEAjbap+PTqHi4LH0UZtcC/7eST824IFL/86/t1e37TkIpv49+
         iGrS2vkiXgPwunRDN/pQ6LkjzQx92ZsPWIBvFV3+TnlMJ0mKqmd6OazysEP5R0fz+o2j
         x0vnmxuz+lUJWhuuT+f1+ceuGP/L/kY1i4QpOBZbXoB1rDJeWfM1idWDZu/CdjLV/J4e
         O3662gLSy/cJc+u0fONZyYCqdmTCAXyXI6EbYwoH0PwLK/BavYCt4PcUxalj5zGZOZY9
         5hKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685631709; x=1688223709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1PIsP178Wnb1M5epQp5PS0aVEa7SerWOVU16+rPTld8=;
        b=fUSjIRQ+6wa9m/7DKKzGLpRemFSnArB/gv/HNx/jzIgmOZc4Otwp9lnZefP8uo54Oq
         D2SM2enmdFJET3rYBuh3yaLidDxl3SMv8bEQqAhxzYpgiKXzGsVZQm0Y/MGtUExoXr/4
         QiRbl1R9c9whcTxDaxD/PjEdgTIIK+iBCF/K+GlTR0GVJoY9YrNwOkjch1Mv48p1jIIR
         /O5Fp6M2gDQ/l3sleyHSIINS35g1XGOAWVSvNjtFSSDWBXYpLnCersDHmXt/LhGVyBG5
         vmmAxnyIUeKIz9WbGAwKbM2dcFDDQ9Y63pLOdvz4PktfDn3b7nOSYCqTCaV4ya8UDm6G
         Z2lQ==
X-Gm-Message-State: AC+VfDxjO52guGw7LmAvB9g+tX4mcNvJg2WycRn5sicoddh4A7NWwNiT
        PW+IypGZncOy3XvFEFe0pUJ5
X-Google-Smtp-Source: ACHHUZ6LTVKej0JlOCpsp2OJdU36a1KbVLMBingCLZXRt7cRscTDm+zFbmmDBMUWZBZEB4ZQ96A46A==
X-Received: by 2002:a17:903:187:b0:1a6:83fa:b370 with SMTP id z7-20020a170903018700b001a683fab370mr7308307plg.2.1685631709505;
        Thu, 01 Jun 2023 08:01:49 -0700 (PDT)
Received: from localhost.localdomain ([117.217.186.123])
        by smtp.gmail.com with ESMTPSA id q7-20020a170902dac700b001b0499bee11sm3595480plx.240.2023.06.01.08.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 08:01:49 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [RESEND PATCH v5 9/9] MAINTAINERS: Add PCI MHI endpoint function driver under MHI bus
Date:   Thu,  1 Jun 2023 20:31:03 +0530
Message-Id: <20230601150103.12755-10-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230601150103.12755-1-manivannan.sadhasivam@linaro.org>
References: <20230601150103.12755-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PCI endpoint driver for MHI bus under the MHI bus entry in MAINTAINERS
file.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 07625a47cf08..a4ac2d567334 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13630,6 +13630,7 @@ F:	Documentation/ABI/stable/sysfs-bus-mhi
 F:	Documentation/mhi/
 F:	drivers/bus/mhi/
 F:	drivers/net/mhi_*
+F:	drivers/pci/endpoint/functions/pci-epf-mhi.c
 F:	include/linux/mhi.h
 
 MICROBLAZE ARCHITECTURE
-- 
2.25.1

