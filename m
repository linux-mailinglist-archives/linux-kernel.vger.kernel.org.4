Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F8C6D4C80
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 17:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbjDCPuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 11:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbjDCPuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 11:50:06 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0242B30DA
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 08:49:40 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id c18so28427528ple.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 08:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680536973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBTkdifLldOoK702yw2O+8amhS0iBYV6kXphjAkmoec=;
        b=Eu12D/azwm9BEw00yO8Gb9FJ9uL2qVrwmMutPMrbv7DuZDl9NjDgUYZ0DVZLRYLDKg
         m745TZpOtf/5V4Ou7+3hByBlx/6v1f8FE0MYnaVRYFb/CcvswncKE3s1SU6ncWcuX6B+
         d9p2ejxbM0h/DQblZQb0Ql3WMkT+j1dvgKdQNScwPx7Ayhk71vh50mdcYnSWDoM9rAoa
         9EDmsWoMSV2fpAdOMNEy5HC3mkYougv4wFeYxqSKoQK8HkC1UOa5xXBaI7wYhz0ijDbc
         tAKKf6eLzx+OP7aa79jh2RtYdzuH7xcqWuUOJtybO47ILBKJEyfcq0VJx+/ZKh/EL+Ix
         Hq1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680536973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XBTkdifLldOoK702yw2O+8amhS0iBYV6kXphjAkmoec=;
        b=X5C4TRGknjz1pgFC/C0knb0R/agE+lTH3N/LX4trVDtajm6385KyGZJdQQdCNik+OX
         01OgvVTIlnvKgmT4tRnOAYkncqJw6yI7uLgk4/BP5u0Zi98hpgHvbI2uSERfAWNyj98E
         yYWG+0mubtFk9pCMWCzkGJ2+PmtvNgugtWhbqJSscRivSp2MuDeyocAnfvqIp1PncDLC
         wm2jr1trzhKXKAc41Cv78/fFIUAgtK0eByffHGXoOJ1tzmelfxIS03en/ikh4xUhwONG
         Gl9DLV9+3PChiGIRqyQaGG8WGPXutt+lSVayGHqgU7CbMopCdTlzORZ2ovrfisZxzl+D
         cReA==
X-Gm-Message-State: AAQBX9eD0TrvXNnidaw2VKuGknYxG7yOs/2XDzdF56Wb/gOyPvwVrXr2
        DnQuMWHFRQGOFARqvlrSrO7r
X-Google-Smtp-Source: AKy350baUUUq+3+L7relPUOphGHPyMY/3J7rewDMI/6skhaWoI4i1ofzSnS7cKu4FEhvRWssY2SNGQ==
X-Received: by 2002:a17:90b:4c0c:b0:233:d12f:f43a with SMTP id na12-20020a17090b4c0c00b00233d12ff43amr38613726pjb.1.1680536973170;
        Mon, 03 Apr 2023 08:49:33 -0700 (PDT)
Received: from localhost.localdomain ([27.111.75.109])
        by smtp.gmail.com with ESMTPSA id c10-20020a17090a020a00b0023af4eb597csm9621534pjc.52.2023.04.03.08.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 08:49:32 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_krichai@quicinc.com, johan+linaro@kernel.org, steev@kali.org,
        mka@chromium.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Dhruva Gole <d-gole@ti.com>
Subject: [PATCH v4 1/1] PCI: qcom: Add support for system suspend and resume
Date:   Mon,  3 Apr 2023 21:19:22 +0530
Message-Id: <20230403154922.20704-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230403154922.20704-1-manivannan.sadhasivam@linaro.org>
References: <20230403154922.20704-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During the system suspend, vote for minimal interconnect bandwidth (1KiB)
to keep the interconnect path active for config access and also turn OFF
the resources like clock and PHY if there are no active devices connected
to the controller. For the controllers with active devices, the resources
are kept ON as removing the resources will trigger access violation during
the late end of suspend cycle as kernel tries to access the config space of
PCIe devices to mask the MSIs.

Also, it is not desirable to put the link into L2/L3 state as that
implies VDD supply will be removed and the devices may go into powerdown
state. This will affect the lifetime of storage devices like NVMe.

And finally, during resume, turn ON the resources if the controller was
truly suspended (resources OFF) and update the interconnect bandwidth
based on PCIe Gen speed.

Suggested-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Acked-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 62 ++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index a232b04af048..98d25fcbf512 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -227,6 +227,7 @@ struct qcom_pcie {
 	struct gpio_desc *reset;
 	struct icc_path *icc_mem;
 	const struct qcom_pcie_cfg *cfg;
+	bool suspended;
 };
 
 #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
@@ -1820,6 +1821,62 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int qcom_pcie_suspend_noirq(struct device *dev)
+{
+	struct qcom_pcie *pcie = dev_get_drvdata(dev);
+	int ret;
+
+	/*
+	 * Set minimum bandwidth required to keep data path functional during
+	 * suspend
+	 */
+	ret = icc_set_bw(pcie->icc_mem, 0, kBps_to_icc(1));
+	if (ret) {
+		dev_err(dev, "Failed to set interconnect bandwidth: %d\n", ret);
+		return ret;
+	}
+
+	/*
+	 * Turn OFF the resources only for controllers without active PCIe
+	 * devices. For controllers with active devices, the resources are kept
+	 * ON and the link is expected to be in L0/L1 (sub)states.
+	 *
+	 * Turning OFF the resources for controllers with active PCIe devices
+	 * will trigger access violation during the end of the suspend cycle,
+	 * as kernel tries to access the PCIe devices config space for masking
+	 * MSIs.
+	 *
+	 * Also, it is not desirable to put the link into L2/L3 state as that
+	 * implies VDD supply will be removed and the devices may go into
+	 * powerdown state. This will affect the lifetime of the storage devices
+	 * like NVMe.
+	 */
+	if (!dw_pcie_link_up(pcie->pci)) {
+		qcom_pcie_host_deinit(&pcie->pci->pp);
+		pcie->suspended = true;
+	}
+
+	return 0;
+}
+
+static int qcom_pcie_resume_noirq(struct device *dev)
+{
+	struct qcom_pcie *pcie = dev_get_drvdata(dev);
+	int ret;
+
+	if (pcie->suspended) {
+		ret = qcom_pcie_host_init(&pcie->pci->pp);
+		if (ret)
+			return ret;
+
+		pcie->suspended = false;
+	}
+
+	qcom_pcie_icc_update(pcie);
+
+	return 0;
+}
+
 static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-apq8064", .data = &cfg_2_1_0 },
 	{ .compatible = "qcom,pcie-apq8084", .data = &cfg_1_0_0 },
@@ -1856,12 +1913,17 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x0302, qcom_fixup_class);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x1000, qcom_fixup_class);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x1001, qcom_fixup_class);
 
+static const struct dev_pm_ops qcom_pcie_pm_ops = {
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(qcom_pcie_suspend_noirq, qcom_pcie_resume_noirq)
+};
+
 static struct platform_driver qcom_pcie_driver = {
 	.probe = qcom_pcie_probe,
 	.driver = {
 		.name = "qcom-pcie",
 		.suppress_bind_attrs = true,
 		.of_match_table = qcom_pcie_match,
+		.pm = &qcom_pcie_pm_ops,
 	},
 };
 builtin_platform_driver(qcom_pcie_driver);
-- 
2.25.1

