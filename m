Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD335B6784
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 07:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiIMFxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 01:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiIMFx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 01:53:27 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7155721D;
        Mon, 12 Sep 2022 22:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663048406; x=1694584406;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=+JZVpiEH3ZzOMoXlViVhCfH/Xg08pfbGBxq3LHvA5Jc=;
  b=BOpUQhJa9K1f4flz4P6+hfN4LnT2CqNxGpWaolJAoLG6WxHD1sEYPXIv
   foMNKH4Apubd8+y7w8txmyEXhyX+Nak8z7GDZqgoOwebYIcmu+82g/EXa
   BDyvEB9B4vMg531Qp4vdmKmVayzONBsSGOLM8/5SiCYa22lvyroybfIcS
   15bPeKnNiriuJ6l2hcNbEtd3mxSJ6q9apgjVzDAsl+GJkPSh1aNoz8Y0u
   CKkDTtQj0YirPOs9fBVf47fR7aOXbwul+ikLdbavOH/49OnCTKosfPovW
   oED/P6NfS2pH0w0WO16Qbdx9PwO5utTfD2CL8g3CWkFmvS8s2ZYzvSbR9
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="361995452"
X-IronPort-AV: E=Sophos;i="5.93,311,1654585200"; 
   d="scan'208";a="361995452"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 22:53:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,311,1654585200"; 
   d="scan'208";a="646781583"
Received: from inlubt0246.iind.intel.com ([10.67.198.165])
  by orsmga008.jf.intel.com with ESMTP; 12 Sep 2022 22:53:23 -0700
From:   shruthi.sanil@intel.com
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@intel.com, srikanth.thokala@intel.com,
        mallikarjunappa.sangannavar@intel.com, shruthi.sanil@intel.com
Subject: [PATCH 2/2] usb: dwc3: pci: Add PCIe device ID for USB3 controller on CPU sub-system for Alder Lake P
Date:   Tue, 13 Sep 2022 11:23:16 +0530
Message-Id: <20220913055316.23050-3-shruthi.sanil@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220913055316.23050-1-shruthi.sanil@intel.com>
References: <20220913055316.23050-1-shruthi.sanil@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shruthi Sanil <shruthi.sanil@intel.com>

USB3 PCIe device ID's needs to be updated for the device to enumerate as
a USB3 device on the host for Alder Lake P.

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Shruthi Sanil <shruthi.sanil@intel.com>
---
 drivers/usb/dwc3/dwc3-pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index 7169d8865e17..fb14511b1e10 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -40,6 +40,7 @@
 #define PCI_DEVICE_ID_INTEL_TGPLP		0xa0ee
 #define PCI_DEVICE_ID_INTEL_TGPH		0x43ee
 #define PCI_DEVICE_ID_INTEL_JSP			0x4dee
+#define PCI_DEVICE_ID_INTEL_ADL			0x460e
 #define PCI_DEVICE_ID_INTEL_ADL_PCH		0x51ee
 #define PCI_DEVICE_ID_INTEL_ADLN		0x465e
 #define PCI_DEVICE_ID_INTEL_ADLN_PCH		0x54ee
@@ -445,6 +446,9 @@ static const struct pci_device_id dwc3_pci_id_table[] = {
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_JSP),
 	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
 
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_ADL),
+	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
+
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_ADL_PCH),
 	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
 
-- 
2.17.1

