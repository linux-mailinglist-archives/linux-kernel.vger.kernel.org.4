Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D2267C34E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 04:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236367AbjAZDQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 22:16:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236359AbjAZDQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 22:16:24 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A1B65EEA;
        Wed, 25 Jan 2023 19:15:49 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30Q2tBUR030435;
        Thu, 26 Jan 2023 03:14:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=urZbrvlW56jM3NnnnRu12cktuIJHGAwqR4fhPFfPs1k=;
 b=m4/evpnuewbvLg5/OxSHVgaYvOb74AxWJqPSFjnw6KRqAvA/ztOj/ZolC03viuo5swXm
 j6FcsQciXtwMx7LIGea5lbacHQrw8gp6K1nygpzr8bKNZov3oijnyY8eAN+su29m4/Lz
 A6/OCNLXSZgBpeAHc/qr+xCmZwt7o5/vvRCYHf4H8StiEjY1SwG7axSgFpKH1wa/9LTg
 vTHFfudfPGDGQG9rkETKymEv57+iPnqq66iiNq+Y2Hb2P3sjNqFd26viFFhbtNgxgaCE
 Nx23r/tNy0v9u3xgSCyuxFDI6+dFYNFvQMmmvA0q6m+nMGRGa+Xtyvvf7+NLfIY9MqKS iQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nb2nssqvu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 03:14:40 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30Q3Ecpx007834
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 03:14:39 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 25 Jan 2023 19:14:38 -0800
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <lgirdwood@gmail.com>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
        <Thinh.Nguyen@synopsys.com>, <broonie@kernel.org>,
        <bgoswami@quicinc.com>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <agross@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <quic_jackp@quicinc.com>,
        <quic_plai@quicinc.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [RFC PATCH v2 01/22] xhci: fix event ring segment table related masks and variables in header
Date:   Wed, 25 Jan 2023 19:14:03 -0800
Message-ID: <20230126031424.14582-2-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230126031424.14582-1-quic_wcheng@quicinc.com>
References: <20230126031424.14582-1-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Y6vvkQInwFXW-z4RFK3bYsLbLfALUWWl
X-Proofpoint-GUID: Y6vvkQInwFXW-z4RFK3bYsLbLfALUWWl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_14,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxlogscore=999
 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301260028
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathias Nyman <mathias.nyman@linux.intel.com>

xHC controller can supports up to 1024 interrupters.
To fit these change the max_interrupters varable from u8 to u16.

Add a separate mask for the reserve and preserve bits [5:0] in the erst
base register and use it instead of the ERST_PRT_MASK.
ERSR_PTR_MASK [3:0] is intended for masking bits in the
event ring dequeue pointer register.

Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci-mem.c | 4 ++--
 drivers/usb/host/xhci.h     | 5 ++++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 81ca2bc1f0be..679befa97c7a 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -2529,8 +2529,8 @@ int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags)
 			"// Set ERST base address for ir_set 0 = 0x%llx",
 			(unsigned long long)xhci->erst.erst_dma_addr);
 	val_64 = xhci_read_64(xhci, &xhci->ir_set->erst_base);
-	val_64 &= ERST_PTR_MASK;
-	val_64 |= (xhci->erst.erst_dma_addr & (u64) ~ERST_PTR_MASK);
+	val_64 &= ERST_BASE_RSVDP;
+	val_64 |= (xhci->erst.erst_dma_addr & (u64) ~ERST_BASE_RSVDP);
 	xhci_write_64(xhci, val_64, &xhci->ir_set->erst_base);
 
 	/* Set the event ring dequeue address */
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index c9f06c5e4e9d..e1362e0c50e1 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -513,6 +513,9 @@ struct xhci_intr_reg {
 /* Preserve bits 16:31 of erst_size */
 #define	ERST_SIZE_MASK		(0xffff << 16)
 
+/* erst_base bitmasks */
+#define ERST_BASE_RSVDP		(0x3f)
+
 /* erst_dequeue bitmasks */
 /* Dequeue ERST Segment Index (DESI) - Segment number (or alias)
  * where the current dequeue pointer lies.  This is an optional HW hint.
@@ -1773,7 +1776,7 @@ struct xhci_hcd {
 	u8		sbrn;
 	u16		hci_version;
 	u8		max_slots;
-	u8		max_interrupters;
+	u16		max_interrupters;
 	u8		max_ports;
 	u8		isoc_threshold;
 	/* imod_interval in ns (I * 250ns) */
