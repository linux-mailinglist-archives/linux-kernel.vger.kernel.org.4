Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B646F75FB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 22:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbjEDUDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 16:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbjEDUCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 16:02:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29619EEE;
        Thu,  4 May 2023 12:51:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0106C63821;
        Thu,  4 May 2023 19:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D97D0C433D2;
        Thu,  4 May 2023 19:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683229820;
        bh=Ri0G/P2daiMRam2SiD7BzsYVmsaC1vTt6LiLO+wDKF0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hk0fWzR68Xbj7ZOFZu0TD7+axhTbbMvAcH0rlerG07V85G0ML6vUTroMEUfHvXsJs
         gFEGVRnJr3kJ+q5tHzMpIVFi9zvzf4FVCnaeb0MOvfM1DW0VScnGs3RRM8sh8D/ewd
         dJt+c9EfR8iHJf0e2QxY4i66vy2cgBJObycOR9Wf19gXfSbN9z7oihBK+amzz3iFNo
         GZw7dDzYx2f/5jU5CM8M4Wn9lVXNrLPi7iCeUPD2snoe+Tmp+FCNZxLDIbxcMH60yc
         hthMipNn0adCjsRR33JaanqTDSCbMuiLyMXYKtqGNoSV4XKKSq7znlo1Nnj2HGcUQM
         VaJT6cBZmgYDw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Daniel Gabay <daniel.gabay@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>, kvalo@kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mukesh.sisodiya@intel.com,
        yaara.baruch@intel.com, golan.ben.ami@intel.com,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 17/24] wifi: iwlwifi: pcie: fix possible NULL pointer dereference
Date:   Thu,  4 May 2023 15:49:30 -0400
Message-Id: <20230504194937.3808414-17-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504194937.3808414-1-sashal@kernel.org>
References: <20230504194937.3808414-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Gabay <daniel.gabay@intel.com>

[ Upstream commit b655b9a9f8467684cfa8906713d33b71ea8c8f54 ]

It is possible that iwl_pci_probe() will fail and free the trans,
then afterwards iwl_pci_remove() will be called and crash by trying
to access trans which is already freed, fix it.

iwlwifi 0000:01:00.0: Detected crf-id 0xa5a5a5a2, cnv-id 0xa5a5a5a2
		      wfpm id 0xa5a5a5a2
iwlwifi 0000:01:00.0: Can't find a correct rfid for crf id 0x5a2
...
BUG: kernel NULL pointer dereference, address: 0000000000000028
...
RIP: 0010:iwl_pci_remove+0x12/0x30 [iwlwifi]
pci_device_remove+0x3e/0xb0
device_release_driver_internal+0x103/0x1f0
driver_detach+0x4c/0x90
bus_remove_driver+0x5c/0xd0
driver_unregister+0x31/0x50
pci_unregister_driver+0x40/0x90
iwl_pci_unregister_driver+0x15/0x20 [iwlwifi]
__exit_compat+0x9/0x98 [iwlwifi]
__x64_sys_delete_module+0x147/0x260

Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230413213309.082f6e21341b.I0db21d7fa9a828d571ca886713bd0b5d0b6e1e5c@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 4e43efd5d1ea1..dc0a507213ca6 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1214,6 +1214,9 @@ static void iwl_pci_remove(struct pci_dev *pdev)
 {
 	struct iwl_trans *trans = pci_get_drvdata(pdev);
 
+	if (!trans)
+		return;
+
 	iwl_drv_stop(trans->drv);
 
 	iwl_trans_pcie_free(trans);
-- 
2.39.2

