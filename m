Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F18F7099D3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 16:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjESOcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 10:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbjESOcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 10:32:06 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC4210C6
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 07:31:51 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-253570deb8dso1882521a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 07:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684506710; x=1687098710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ltCiTsDOD5ydUGLVe1beQMJS2WLXn803YOi09x8rHPs=;
        b=gQWUuVaDxxDTizHCkkO1/6gcVHEDp/mB5yqDC3TfWP7Fy3j5eOoKhO9nUnfQftuVUW
         glEciq+vVyZOr+muKVCJDD6rsrEjdL0T7IfXdTNgIJQdZDkrpkXIEkMXoC2dEUX4gscv
         M1p+6xA2fz3U3C7hBiGQawUHl3ZEz80VP1kF/48p+1gLzdujCycYixiFFoblrT/xvuqM
         0CHCS/fWvyQs+6GeCDlN+no4+5p3e2kVcwRgHZRXF1MTlmPvDa4Rwc8xUaxezckaFZCd
         zMLl77GFhg15MpgG0luVujSn7dtDGisw+dm1F3AWCraB4nS2WD7b4AK2YY6s2CAVQTIH
         vFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684506710; x=1687098710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ltCiTsDOD5ydUGLVe1beQMJS2WLXn803YOi09x8rHPs=;
        b=ATI10h9LwhJun5OTHyIMK2nXA8BdRxZiRqTKJXBg8rX5c4xd7Dd3nD7FrUSRgnbgkl
         DZddzkN5yOvUKmeHC4Jq4565vLhI1fKkGFVj4EwiwokBdJ4DfI8UjrMKLJXwioxyTSCE
         XmtnH/ga+ZoS4UpmWwvsHsBh3rSCqfTWO+LgJhGlKnN9figGq0NpHQRhiHIyG5CHu84e
         M8DdgOFhRmaSMMVu3W3sBBCST+SXSVrvZ084dvGSKBLK+qkapHOC1HaWm40Yt8oUc1m4
         3eVIGjk14clOOfzeP92LuNTXyK6lYGqavbitw3GM6/VD38YkT3ydYn5hk9vfETCG3i71
         jF4w==
X-Gm-Message-State: AC+VfDxTOwKJ1O9EYD9QxSDrAKDbveXOXuEHUdCVO/wBJ7sD6R5fK4EW
        kJ0sIHlJmtqmG6k+9U5beJa3
X-Google-Smtp-Source: ACHHUZ5rscIahl4LJxzlDvbUM/cGLaj3ogOdD7g/A6gKEmYQgOk3e2upIICIHVTylDQt8DIVbMFgfA==
X-Received: by 2002:a17:90a:64c4:b0:253:749d:205 with SMTP id i4-20020a17090a64c400b00253749d0205mr2020724pjm.35.1684506710307;
        Fri, 19 May 2023 07:31:50 -0700 (PDT)
Received: from localhost.localdomain ([117.202.184.13])
        by smtp.gmail.com with ESMTPSA id 30-20020a17090a09a100b00250d908a771sm1634845pjo.50.2023.05.19.07.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 07:31:49 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com
Cc:     robh@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, steev@kali.org,
        quic_srichara@quicinc.com, dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 5/8] PCI: qcom: Do not advertise hotplug capability for IP v2.3.2
Date:   Fri, 19 May 2023 20:01:14 +0530
Message-Id: <20230519143117.23875-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230519143117.23875-1-manivannan.sadhasivam@linaro.org>
References: <20230519143117.23875-1-manivannan.sadhasivam@linaro.org>
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

SoCs making use of Qcom PCIe controller IP v2.3.2 do not support hotplug
functionality. But the hotplug capability bit is set by default in the
hardware. This causes the kernel PCI core to register hotplug service for
the controller and send hotplug commands to it. But those commands will
timeout generating messages as below during boot and suspend/resume.

[    5.782159] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x03c0 (issued 2020 msec ago)
[    5.810161] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x03c0 (issued 2048 msec ago)
[    7.838162] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x07c0 (issued 2020 msec ago)
[    7.870159] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x07c0 (issued 2052 msec ago)

This not only spams the console output but also induces a delay of a
couple of seconds. To fix this issue, let's clear the HPC bit in
PCI_EXP_SLTCAP register as a part of the post init sequence to not
advertise the hotplug capability for the controller.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 64b6a8c6a99d..9c8dfd224e6e 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -616,6 +616,8 @@ static int qcom_pcie_post_init_2_3_2(struct qcom_pcie *pcie)
 	val |= EN;
 	writel(val, pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT_V2);
 
+	qcom_pcie_clear_hpc(pcie->pci);
+
 	return 0;
 }
 
-- 
2.25.1

