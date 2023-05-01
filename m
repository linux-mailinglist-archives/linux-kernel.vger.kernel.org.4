Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858606F2C56
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 04:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbjEAC7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 22:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbjEAC7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 22:59:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CD010F5;
        Sun, 30 Apr 2023 19:58:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0A9460E93;
        Mon,  1 May 2023 02:58:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F626C4339B;
        Mon,  1 May 2023 02:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682909907;
        bh=byWCWSLw3MQQeHKSMnTSsapdwq8cJxSTwv7+8NmzPX0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UgwpRNDvzm3n0FQ5zMuIVlLl3qDAAGkR7HpIAKHBaKlF5J51J9KEaQtnrFWOBn1fn
         StfZ+vepMYiOEj9PmVNXa1LvpQCkJdQFmDh9h9AjO/2cJSH6Qir4sWr0PZ35LMqA8z
         sDuZ3H/5nftrGAfgT3u8usMNx83wiKDUDw6Q9hqqmVl9vJk3JMvtHSi3Iee7jHLiEK
         uH2Uecd6g+vf9A9wV3P43JpvutTOubFSqYLm3h73gU3itvbe9tMVSg9u7AMX8+/+Ea
         mn1cHStPDATvZrp0Cpy1f9xCA57jjH1ai+u2G9eIQNWfCtOuSD5t/x0sd7K7jq/YMg
         HRV5t9kBsRE8w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Karol Wachowski <karol.wachowski@linux.intel.com>,
        Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, ogabbay@kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.3 26/44] accel/ivpu: Remove D3hot delay for Meteorlake
Date:   Sun, 30 Apr 2023 22:56:14 -0400
Message-Id: <20230501025632.3253067-26-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501025632.3253067-1-sashal@kernel.org>
References: <20230501025632.3253067-1-sashal@kernel.org>
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

From: Karol Wachowski <karol.wachowski@linux.intel.com>

[ Upstream commit cb949ce504e829193234e26cb3042bb448465d52 ]

VPU on MTL has hardware optimizations and does not require 10ms
D0 - D3hot transition delay imposed by PCI specification (PCIe
r6.0, sec 5.9.) .

The delay removal is traditionally done by adding PCI ID to
quirk_remove_d3hot_delay() in drivers/pci/quirks.c . But since
we do not need that optimization before driver probe and we
can better specify in the ivpu driver on what (future) hardware
use the optimization, we do not use quirk_remove_d3hot_delay()
for that.

Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230403121545.2995279-1-stanislaw.gruszka@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/ivpu/ivpu_drv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
index 6a320a73e3ccf..8396db2b52030 100644
--- a/drivers/accel/ivpu/ivpu_drv.c
+++ b/drivers/accel/ivpu/ivpu_drv.c
@@ -437,6 +437,10 @@ static int ivpu_pci_init(struct ivpu_device *vdev)
 	/* Clear any pending errors */
 	pcie_capability_clear_word(pdev, PCI_EXP_DEVSTA, 0x3f);
 
+	/* VPU MTL does not require PCI spec 10m D3hot delay */
+	if (ivpu_is_mtl(vdev))
+		pdev->d3hot_delay = 0;
+
 	ret = pcim_enable_device(pdev);
 	if (ret) {
 		ivpu_err(vdev, "Failed to enable PCI device: %d\n", ret);
-- 
2.39.2

