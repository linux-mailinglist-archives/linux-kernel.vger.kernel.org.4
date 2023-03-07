Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958096AF6A8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 21:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjCGUZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 15:25:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbjCGUZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 15:25:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F76A838D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 12:24:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F706614DF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 20:24:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7919C433D2;
        Tue,  7 Mar 2023 20:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678220680;
        bh=sLfm8UYUs/1eOM3F9JNSEG6q6gN2CiEXvnHjj2Ve6DY=;
        h=From:To:Cc:Subject:Date:From;
        b=vPT0G5T3LFOYsMnNBuPeZ9PFTR8kRvsC4SOE8sW5j6iza24W3pkD0qI/838BnPilu
         QLVcuACKPREaFT+kxNkS2VSk6/uFgq4WocAv4WFKV5eIpwulKg9WYHS7/N1Zw5+SVF
         xFK7DqPsKq9AOozjWi6HPxjFebmY2AcbMSASBZ59njMfcowX9cHtNO9rcROAsVyKIH
         i1UjdGJjGWRmrDp/Q3W7vmmS6NYnfvHpVp3NtsWUpi1vWIn+gFUFKIOHoZ9aWxWiVJ
         KoHs2NodOGPT90n584IlhhKMy0lCeIuygXpX1rRjxcJpf39XxUz2QBMMiNInCEWzIu
         rrHvf/17QRT5Q==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Frank Haverkamp <haver@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] misc: genwqe: Drop redundant pci_enable_pcie_error_reporting()
Date:   Tue,  7 Mar 2023 14:24:35 -0600
Message-Id: <20230307202435.880921-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

pci_enable_pcie_error_reporting() enables the device to send ERR_*
Messages.  Since f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is
native"), the PCI core does this for all devices during enumeration, so the
driver doesn't need to do it itself.

Remove the redundant pci_enable_pcie_error_reporting() call from the
driver.

Note that this only controls ERR_* Messages from the device.  An ERR_*
Message may cause the Root Port to generate an interrupt, depending on the
AER Root Error Command register managed by the AER service driver.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/misc/genwqe/card_base.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/misc/genwqe/card_base.c b/drivers/misc/genwqe/card_base.c
index 5b63d179b24e..4829bc2208d6 100644
--- a/drivers/misc/genwqe/card_base.c
+++ b/drivers/misc/genwqe/card_base.c
@@ -19,7 +19,6 @@
 #include <linux/types.h>
 #include <linux/pci.h>
 #include <linux/err.h>
-#include <linux/aer.h>
 #include <linux/string.h>
 #include <linux/sched.h>
 #include <linux/wait.h>
@@ -1099,7 +1098,6 @@ static int genwqe_pci_setup(struct genwqe_dev *cd)
 	}
 
 	pci_set_master(pci_dev);
-	pci_enable_pcie_error_reporting(pci_dev);
 
 	/* EEH recovery requires PCIe fundamental reset */
 	pci_dev->needs_freset = 1;
-- 
2.25.1

