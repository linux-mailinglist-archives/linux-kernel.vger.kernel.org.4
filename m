Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E476AF81D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 22:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjCGV5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 16:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjCGV5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 16:57:10 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83AFAD02F;
        Tue,  7 Mar 2023 13:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678226228; x=1709762228;
  h=from:to:cc:subject:date:message-id:mime-version:reply-to:
   content-transfer-encoding;
  bh=8vgY/QVBJu+X9HRFZSvBWKypnSnfRJHbl/eOU7wG2o4=;
  b=SgSDl/8dCMoCFnDaMC14DGdjo5SGSgtd+eK55VAdU4UN7VJvr8mUDqy7
   ttXQoCvybknpF2JXQUvHEHSL5QHvQoF84fM6RC2Gr+CCL+n7ocBMkkwWJ
   qi4pUGct+GwyWcKV66DhV80evm+uHKg688r0AhdbDNqxnDMkIO2mzC8DU
   luol4ridf32lOWvCVRAQ9wJlo7B8IdjT6b4G4WtVWhuYT7AZeyYcXaYRu
   x3w9q1qRUzd+wk0Iahkm5Q4iky0BxAoNrjqjfY8qDzqg5Tp0M2BAfxBzY
   mJBOxla+ZHMjXUhr57KFV6BZHa+80P8Xdz1GqnVrqTwrxDkS0dQNdS3ih
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="400810562"
X-IronPort-AV: E=Sophos;i="5.98,242,1673942400"; 
   d="scan'208";a="400810562"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 13:57:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="786853606"
X-IronPort-AV: E=Sophos;i="5.98,242,1673942400"; 
   d="scan'208";a="786853606"
Received: from kmdehmer-mobl1.amr.corp.intel.com (HELO lenb-mobl1.amr.corp.intel.com) ([10.212.14.112])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 13:57:06 -0800
From:   Len Brown <len.brown@intel.com>
To:     rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] hci_qca: do not interfere with system suspend
Date:   Tue,  7 Mar 2023 15:56:06 -0600
Message-Id: <7687c4239424f2a49c6c596d19eea8dd7ebe8a30.1678226070.git.len.brown@intel.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When hci_qca returns an error to its pm_ops.suspend routine,
the PM subsystem will terminate the system wide suspend.

It is extremely unlikely that there will ever be a justification
for hci_qca, no matter what its internal malfunction, should
cause system-wide suspend to terminate.

Doing so, could result in the scenario where a laptop lid is closed,
suspend termnates, the user places the running laptop into a breifcase,
not expecting it to be overheating or draining its battery...

This is not a theoretical issue.
The 6.3-rc1 currently fails this way on the Dell XPS-13-9310:

Bluetooth: hci0: SSR or FW download time out
hci_uart_qca serial0-0: PM: dpm_run_callback(): acpi_subsys_suspend+0x0/0x70 returns -110
hci_uart_qca serial0-0: PM: failed to suspend: error -110
PM: suspend of devices aborted after 3218.724 msecs
PM: start suspend of devices aborted after 3246.859 msecs
PM: Some devices failed to suspend, or early wake event detected
PM: resume of devices complete after 84.988 msecs

Signed-off-by: Len Brown <len.brown@intel.com>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/bluetooth/hci_qca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 3df8c3606e93..1795cc527b88 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2309,7 +2309,7 @@ static int __maybe_unused qca_suspend(struct device *dev)
 error:
 	clear_bit(QCA_SUSPENDING, &qca->flags);
 
-	return ret;
+	return 0;
 }
 
 static int __maybe_unused qca_resume(struct device *dev)
-- 
2.37.2

