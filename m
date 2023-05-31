Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB1071832D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 15:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236973AbjEaNsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 09:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236937AbjEaNry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 09:47:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C9A1987;
        Wed, 31 May 2023 06:44:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC65E61476;
        Wed, 31 May 2023 13:44:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DA71C433EF;
        Wed, 31 May 2023 13:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685540653;
        bh=/JOOxuMTlDCRlc++y4DfjkT+ifoXix3oLh6NG6iiCjg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cD/t5nJqD59evdK0BOgVNUpM9nE9KArUlbMPeWGjOs07iDU5UCzl45oWHn3wKXhsZ
         uaCCjvr3ANs+mSyd7v+CbkolLAfIh/rCX0HUpnSwDgWqWIXWIYfw25Z0aNEiSwKJao
         GCLLI7/SzTo6S3qJI8uHsdoCckagO7VAcc63YzWdDGcbP5CBqDMSYsEGfXixRdPew0
         poAcOnxRdgaisLXGI6gb6XfhL/V4CQxf6jd4KM368wxgkmbEzRkJg4qHinyUZslvhB
         WNPDneG8c8jVBaaIX4rQCCC6S+eYrqN6b5Yntq8PFJo6kDlWWbMwqsvBfu6kC5JJfd
         6Wz66Xh49T1zA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tatsuki Sugiura <sugi@nemui.org>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Sasha Levin <sashal@kernel.org>, sagi@grimberg.me,
        linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 24/24] NVMe: Add MAXIO 1602 to bogus nid list.
Date:   Wed, 31 May 2023 09:43:20 -0400
Message-Id: <20230531134320.3384102-24-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531134320.3384102-1-sashal@kernel.org>
References: <20230531134320.3384102-1-sashal@kernel.org>
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

From: Tatsuki Sugiura <sugi@nemui.org>

[ Upstream commit a3a9d63dcd15535e7fdf4c7c1b32bfaed762973a ]

HIKSEMI FUTURE M.2 SSD uses the same dummy nguid and eui64.
I confirmed it with my two devices.

This patch marks the controller as NVME_QUIRK_BOGUS_NID.

---------------------------------------------------------
sugi@tempest:~% sudo nvme id-ctrl /dev/nvme0
NVME Identify Controller:
vid       : 0x1e4b
ssvid     : 0x1e4b
sn        : 30096022612
mn        : HS-SSD-FUTURE 2048G
fr        : SN10542
rab       : 0
ieee      : 000000
cmic      : 0
mdts      : 7
cntlid    : 0
ver       : 0x10400
rtd3r     : 0x7a120
rtd3e     : 0x1e8480
oaes      : 0x200
ctratt    : 0x2
rrls      : 0
cntrltype : 1
fguid     : 00000000-0000-0000-0000-000000000000
<snip...>
---------------------------------------------------------

---------------------------------------------------------
sugi@tempest:~% sudo nvme id-ns /dev/nvme0n1
NVME Identify Namespace 1:
<snip...>
nguid   : 00000000000000000000000000000000
eui64   : 0000000000000002
lbaf  0 : ms:0   lbads:9  rp:0 (in use)
---------------------------------------------------------

Signed-off-by: Tatsuki Sugiura <sugi@nemui.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c3acef6c32917..3b59c897fdcfa 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3388,6 +3388,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1e4B, 0x1202),   /* MAXIO MAP1202 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x1e4B, 0x1602),   /* MAXIO MAP1602 */
+		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1cc1, 0x5350),   /* ADATA XPG GAMMIX S50 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1e49, 0x0021),   /* ZHITAI TiPro5000 NVMe SSD */
-- 
2.39.2

