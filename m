Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F476E4825
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 14:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjDQMqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 08:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjDQMqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 08:46:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EB66A6E;
        Mon, 17 Apr 2023 05:46:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9711461550;
        Mon, 17 Apr 2023 12:46:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B0FC4339B;
        Mon, 17 Apr 2023 12:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681735560;
        bh=ZK7gdGI97kf9YziJ6MKCKuo2cZzY1SvkDzDNqqhDpPQ=;
        h=From:To:Cc:Subject:Date:From;
        b=Pis2xvPN/QULQ+v5VfQGiBwN8d4mdKJs8c/6SwZY4Sq65RmpSLctEFAvPRNSyTbwc
         6vp+k3ovWbsUDcx47746h+DhZi20p/zkLJ1Tbk/EGamJgrgfqUw9AQHhY4Rl6Au1bj
         xRHbCpCOigff0WPDvtZWU6I9pcEyedvlKMk5MDCg33CntKlXruLHtmeC9tYlBMSbE9
         2ZISbxnqsXlrv0KfMDs+6HQf8YMP5zkxVAkRXQAxBRcxMOGpUgUibnV7tiwSwxbRK0
         4aHPcQkaOTKCo9tdjr4q7dd5ybIbmq3juftWYCeux9j3jzgnYkfONB70HN/pSZn6g9
         EJFNWnvHzkE3w==
From:   broonie@kernel.org
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Ron Lee <ron.lee@intel.com>, Ron Lee <ron.lee.intel@gmail.com>
Subject: linux-next: manual merge of the pci tree with the origin tree
Date:   Mon, 17 Apr 2023 13:45:52 +0100
Message-Id: <20230417124553.765602-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the pci tree got a conflict in:

  arch/x86/pci/fixup.c

between commit:

  f195fc1e9715b ("x86/PCI: Add quirk for AMD XHCI controller that loses MSI-X state in D3hot")

from the origin tree and commit:

  606012dddebbc ("PCI: Fix up L1SS capability for Intel Apollo Lake Root Port")

from the pci tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc arch/x86/pci/fixup.c
index bf5161dcf89e7,c6c46605812b4..0000000000000
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@@ -826,22 -825,61 +826,81 @@@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_A
  
  #endif
  
 +#ifdef CONFIG_AMD_NB
 +
 +#define AMD_15B8_RCC_DEV2_EPF0_STRAP2                                  0x10136008
 +#define AMD_15B8_RCC_DEV2_EPF0_STRAP2_NO_SOFT_RESET_DEV2_F0_MASK       0x00000080L
 +
 +static void quirk_clear_strap_no_soft_reset_dev2_f0(struct pci_dev *dev)
 +{
 +	u32 data;
 +
 +	if (!amd_smn_read(0, AMD_15B8_RCC_DEV2_EPF0_STRAP2, &data)) {
 +		data &= ~AMD_15B8_RCC_DEV2_EPF0_STRAP2_NO_SOFT_RESET_DEV2_F0_MASK;
 +		if (amd_smn_write(0, AMD_15B8_RCC_DEV2_EPF0_STRAP2, data))
 +			pci_err(dev, "Failed to write data 0x%x\n", data);
 +	} else {
 +		pci_err(dev, "Failed to read data\n");
 +	}
 +}
 +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x15b8, quirk_clear_strap_no_soft_reset_dev2_f0);
 +#endif
++
+ /*
+  * When returning from D3cold to D0, firmware on some Google Coral and Reef
+  * family Chromebooks with Intel Apollo Lake SoC clobbers the headers of
+  * both the L1 PM Substates capability and the previous capability for the
+  * "Celeron N3350/Pentium N4200/Atom E3900 Series PCI Express Port B #1".
+  *
+  * Save those values at enumeration-time and restore them at resume.
+  */
+ 
+ static u16 prev_cap, l1ss_cap;
+ static u32 prev_header, l1ss_header;
+ 
+ static void chromeos_save_apl_pci_l1ss_capability(struct pci_dev *dev)
+ {
+ 	int pos = PCI_CFG_SPACE_SIZE, prev = 0;
+ 	u32 header, pheader = 0;
+ 
+ 	while (pos) {
+ 		pci_read_config_dword(dev, pos, &header);
+ 		if (PCI_EXT_CAP_ID(header) == PCI_EXT_CAP_ID_L1SS) {
+ 			prev_cap = prev;
+ 			prev_header = pheader;
+ 			l1ss_cap = pos;
+ 			l1ss_header = header;
+ 			return;
+ 		}
+ 
+ 		prev = pos;
+ 		pheader = header;
+ 		pos = PCI_EXT_CAP_NEXT(header);
+ 	}
+ }
+ 
+ static void chromeos_fixup_apl_pci_l1ss_capability(struct pci_dev *dev)
+ {
+ 	u32 header;
+ 
+ 	if (!prev_cap || !prev_header || !l1ss_cap || !l1ss_header)
+ 		return;
+ 
+ 	/* Fixup the header of L1SS Capability if missing */
+ 	pci_read_config_dword(dev, l1ss_cap, &header);
+ 	if (header != l1ss_header) {
+ 		pci_write_config_dword(dev, l1ss_cap, l1ss_header);
+ 		pci_info(dev, "restore L1SS Capability header (was %#010x now %#010x)\n",
+ 			 header, l1ss_header);
+ 	}
+ 
+ 	/* Fixup the link to L1SS Capability if missing */
+ 	pci_read_config_dword(dev, prev_cap, &header);
+ 	if (header != prev_header) {
+ 		pci_write_config_dword(dev, prev_cap, prev_header);
+ 		pci_info(dev, "restore previous Capability header (was %#010x now %#010x)\n",
+ 			 header, prev_header);
+ 	}
+ }
+ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x5ad6, chromeos_save_apl_pci_l1ss_capability);
+ DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL, 0x5ad6, chromeos_fixup_apl_pci_l1ss_capability);
