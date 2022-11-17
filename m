Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC85862D86C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 11:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233651AbiKQKvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 05:51:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233502AbiKQKvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 05:51:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028CF183B5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 02:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668682230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x6n9un+DF1STb0f8Wt45FFfORAUWPZZjfWdP+jBOFAw=;
        b=IGz8/5Yx70KGnfHXmFSM3h2LAPA9ScSjg9V6BfDkK2CDmGiPRmEb4BDfAAgwehcLYmdil9
        VkyJ9Tgil6ARowkDEddwAxTk8CpM67+1sHa9QldpgPue11TAiIlHw6lARG+yY0C/1iuNXI
        ku4oY1VC/ok8KrhjHZNg1HOCsLSUPP4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-126-n7e_mWaINmyK4_nliwCNWQ-1; Thu, 17 Nov 2022 05:50:28 -0500
X-MC-Unique: n7e_mWaINmyK4_nliwCNWQ-1
Received: by mail-qt1-f200.google.com with SMTP id ff5-20020a05622a4d8500b003a526107477so1297427qtb.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 02:50:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x6n9un+DF1STb0f8Wt45FFfORAUWPZZjfWdP+jBOFAw=;
        b=3nnTUhFHHkhPR8K3GP7j66KKbya1G1eTPnjK8YR8Kteh+709+skWuG6lIc11Wb8DXA
         rtVRSO9Tpdp+GEio6SfMSwloL4PM9H1w4W3acqrz8LWpsrBWhhk+WKhJQEz2zbqTMBr7
         3pUh4y/sJUrtH/++Q+PyFgmdDFev4odlGUnU/Apst6nGbm5VT4YDkbCFe9Q3hhrocnQ4
         b+OsFzN2w0rrAPmP7LJJg1+5YLn42as5bK3X/mxH3xFyQhSY9/O7QfF2hhhmA7HQj8fp
         AIbGW3shCjbK5uL4+S8bqj1m6s5GFDcxuayxB31zPUYrZEeaZxzuaiDFsUlepXq3cM/P
         Jktg==
X-Gm-Message-State: ANoB5pmhfIu+l5awG3W5W3vLcJrOlx18mT7JzcN0D9MMX1yxTZcVSeE4
        +yXC5uyOpFRoOEJEP+p0bzKr0N6oB1ZJKJK6u0GwNG1yMc5HYNynVrMjT1D7ysvYEGvGT16cYNU
        Qs85QetFWybcnCI6vmrqiiE3M
X-Received: by 2002:ac8:741a:0:b0:3a5:2932:3a77 with SMTP id p26-20020ac8741a000000b003a529323a77mr1561853qtq.591.1668682228224;
        Thu, 17 Nov 2022 02:50:28 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7q5r/FX9thYRsL+y5bwss1yFZk9BsIvNayz/qC38oOghK204AtAl8ETLODAyxsuBJu8fXOWQ==
X-Received: by 2002:ac8:741a:0:b0:3a5:2932:3a77 with SMTP id p26-20020ac8741a000000b003a529323a77mr1561843qtq.591.1668682228025;
        Thu, 17 Nov 2022 02:50:28 -0800 (PST)
Received: from x1.redhat.com (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id i15-20020a05620a248f00b006fa9d101775sm236022qkn.33.2022.11.17.02.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 02:50:27 -0800 (PST)
From:   Brian Masney <bmasney@redhat.com>
To:     andersson@kernel.org
Cc:     agross@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: [PATCH 1/2] scsi: ufs: ufs-qcom: add basic interconnect support
Date:   Thu, 17 Nov 2022 05:49:56 -0500
Message-Id: <20221117104957.254648-2-bmasney@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117104957.254648-1-bmasney@redhat.com>
References: <20221117104957.254648-1-bmasney@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The firmware on the Qualcomm platforms expects the interconnect votes to
be present. Let's add very basic support where the maximum throughput is
requested to match what's done in a few other drivers.

This will not break boot on systems where the interconnects and
interconnect-names properties are not specified in device tree for UFS
since the interconnect framework will silently return.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/ufs/host/ufs-qcom.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 8ad1415e10b6..55bf8dd88985 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -7,6 +7,7 @@
 #include <linux/time.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/interconnect.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -936,6 +937,22 @@ static const struct reset_control_ops ufs_qcom_reset_ops = {
 	.deassert = ufs_qcom_reset_deassert,
 };
 
+static int ufs_qcom_icc_init(struct device *dev, char *pathname)
+{
+	struct icc_path *path;
+	int ret;
+
+	path = devm_of_icc_get(dev, pathname);
+	if (IS_ERR(path))
+		return dev_err_probe(dev, PTR_ERR(path), "failed to acquire interconnect path\n");
+
+	ret = icc_set_bw(path, 0, UINT_MAX);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to set bandwidth request\n");
+
+	return 0;
+}
+
 /**
  * ufs_qcom_init - bind phy with controller
  * @hba: host controller instance
@@ -991,6 +1008,14 @@ static int ufs_qcom_init(struct ufs_hba *hba)
 			err = dev_err_probe(dev, PTR_ERR(host->generic_phy), "Failed to get PHY\n");
 			goto out_variant_clear;
 		}
+
+		err = ufs_qcom_icc_init(dev, "ufs-ddr");
+		if (err)
+			goto out_variant_clear;
+
+		err = ufs_qcom_icc_init(dev, "cpu-ufs");
+		if (err)
+			goto out_variant_clear;
 	}
 
 	host->device_reset = devm_gpiod_get_optional(dev, "reset",
-- 
2.38.1

