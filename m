Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F527200D0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 13:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235545AbjFBLuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 07:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235463AbjFBLts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 07:49:48 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081BF10C8
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 04:49:17 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-96f7bf3cf9eso299960066b.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 04:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685706536; x=1688298536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1PIsP178Wnb1M5epQp5PS0aVEa7SerWOVU16+rPTld8=;
        b=bX54vfk4QiyIOjgJw96WITCRP//0S5DdbOQqlc5XByX+tAEA0Q3niUHKDrbpHgaKnX
         t4Ey+o8Iyucw9gdqVWfgGZVv+6CbsRvsrOX+Y5IlzmVssOmXmd/gWOzkkw9K423SpYMb
         3Xy1MVuzjhZVvcJMH9oWeszn0WtEjBdNO4bjmT1Y7dc5gRjQJmy9FMzCWxxge7tFdNNa
         jqUgh9yj18SrOtinjF+OuWr2EIxPAnCJLASsXzfsOUk6YwgiQXyCH1q/qFXmjRiMLXP/
         r0mQL4PcLZQa10fF0WiTuNoGVGDfYB7UPAUC7c54kjK4rf1YLDxwRAj0IgPj2fwJZoRx
         SU6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685706536; x=1688298536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1PIsP178Wnb1M5epQp5PS0aVEa7SerWOVU16+rPTld8=;
        b=fhV6l6TIfoA59iKdqC0lxL4an9ombFzaz+ZSmDtCG/U69E60cXMxbF8/0YIKimGbPV
         77DZN+dCXIM2fKmeRajoEAYIPKC9JFTbPvzwxcRb8Fx9csmFbu/VuuVJytqtuQeVd7D/
         fG4nUYrXt9pBeiKCXKmZEgSpRToUjgRyayxnohCyXXcbW+zILmNkUXvLIIhqMs0XJmcd
         in/PfDBErSMzQA7Eapg7NUrcRhGf2Wdr14re0giBq5nJseG8HAYpozfSBG15hoVPap+O
         kvJPhPqayDCZLuydRYYEvgP80n5mzSxjcfoIgtSkMUMiu+smTbjewz23wKrnzQhLcddr
         BjPA==
X-Gm-Message-State: AC+VfDzT2O65CXxtNekbQpGCeEDpShODJJNsK73q50JzG61hcKrIFsEu
        aFNZMEDm+MKe5+Ynq/HhWOzz
X-Google-Smtp-Source: ACHHUZ53ynAHXabcZM7EkPvDXz3Iy1IWTmpkAvx0BwE7Fn5WGDODOFNc0zh2UxA3JOD/U5gGBwYOAg==
X-Received: by 2002:a17:907:746:b0:96f:98f1:6512 with SMTP id xc6-20020a170907074600b0096f98f16512mr9044597ejb.41.1685706536610;
        Fri, 02 Jun 2023 04:48:56 -0700 (PDT)
Received: from localhost.localdomain ([117.217.186.79])
        by smtp.gmail.com with ESMTPSA id qu25-20020a170907111900b00974530bb44dsm658924ejb.183.2023.06.02.04.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 04:48:56 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dlemoal@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v6 9/9] MAINTAINERS: Add PCI MHI endpoint function driver under MHI bus
Date:   Fri,  2 Jun 2023 17:17:56 +0530
Message-Id: <20230602114756.36586-10-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230602114756.36586-1-manivannan.sadhasivam@linaro.org>
References: <20230602114756.36586-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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

