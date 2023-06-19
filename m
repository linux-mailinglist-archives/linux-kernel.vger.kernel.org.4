Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38B8735AC6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 17:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjFSPGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 11:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbjFSPFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 11:05:24 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBB610FE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 08:04:52 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-25ec175b86bso2339538a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 08:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687187092; x=1689779092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BAHgbKUGLDFGyzp+XWYZ2sseIunYBsYQIO/Xldf05CU=;
        b=XvdhBRHXtdzN60JPoHiXZGxe3Wk8p3gEVy+80P/yCIUnn5q/UjEz6wGlLUXO/Tcp/B
         p8G1lcxkxYlP5xBp89pAbZZsu5TTC+qOgOXZx0qANDXGrqsKG5jlWFQVYeQMgog4GiVg
         wdxkf03RP9va75x46RLsvNHYZv9BMqmZ8LQqPta7Z6Zq8i+eA+ZPRky6UY20MUYFYLkr
         AiJCUirnH8hMizZurVOfFD4mTj3SdBbkydnp+kTqBxXNiyFRO5NJsTl5mYeFNPA5V9gf
         rSIvT9+E06Kh8dESXnCMURATxRR6WFsSxEu8qtTmzg8ahZcvAundvWcd7CY1HHfnvrf3
         CsnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687187092; x=1689779092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BAHgbKUGLDFGyzp+XWYZ2sseIunYBsYQIO/Xldf05CU=;
        b=RfWv/FxiTx/uYCqM6TamMbcZlMIqYb2LabKtlDsgGeN/axFPZhv3hoOmRTaViCLCf+
         qgxomD7tDq9t9mr4+DA/swekWYzqC+nxn/nKTaCpbyy702kn2FM4UFhBJXxmZV6T+/nS
         Et2C8dLjJbYjRIdU8PmdHSu3sleCqJrZNdTRU+uyJ3+XdPzm5haNYIthhnQaU1FsUAq5
         U8xoSlwg4tcrKE3F2g00pjB1+zEUd9Gt5iKGn5D9hGimZ+UqvqdTK+M++aL1sF5ao9tF
         Vi4tpqwuIGC6owpzzlyfy3GRorOFAvUQO27LE3bTORNVGOXxfAhDdSD6fiXOEgxI6ky2
         w9rg==
X-Gm-Message-State: AC+VfDxMe3LN5gzUZEL30Lff95RDkMu+u6VDo5XAaCfD+4ICzbRDVo+R
        nlj2OCHgBlbucu2wq3D6MRKB
X-Google-Smtp-Source: ACHHUZ6mX5eL59bpG47z5VL6nwHLS8G/J72KGT7pv4yLTGgHpPgvjAqo6OiEFj63qn6HUCs8V7wiOA==
X-Received: by 2002:a17:90a:df95:b0:25b:e216:bc15 with SMTP id p21-20020a17090adf9500b0025be216bc15mr10269006pjv.23.1687187092079;
        Mon, 19 Jun 2023 08:04:52 -0700 (PDT)
Received: from localhost.localdomain ([117.217.183.37])
        by smtp.gmail.com with ESMTPSA id 10-20020a17090a19ca00b0025efaf7a0d3sm2765480pjj.14.2023.06.19.08.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 08:04:51 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com
Cc:     robh@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, steev@kali.org,
        quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 9/9] PCI: qcom: Do not advertise hotplug capability for IP v2.1.0
Date:   Mon, 19 Jun 2023 20:34:08 +0530
Message-Id: <20230619150408.8468-10-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230619150408.8468-1-manivannan.sadhasivam@linaro.org>
References: <20230619150408.8468-1-manivannan.sadhasivam@linaro.org>
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

SoCs making use of Qcom PCIe controller IP v2.1.0 do not support hotplug
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
index 612266fb849a..7a87a47eb7ed 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -438,6 +438,8 @@ static int qcom_pcie_post_init_2_1_0(struct qcom_pcie *pcie)
 	writel(CFG_BRIDGE_SB_INIT,
 	       pci->dbi_base + AXI_MSTR_RESP_COMP_CTRL1);
 
+	qcom_pcie_clear_hpc(pcie->pci);
+
 	return 0;
 }
 
-- 
2.25.1

