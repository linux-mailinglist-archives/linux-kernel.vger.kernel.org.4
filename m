Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF387501D4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbjGLIjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbjGLIim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:38:42 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B81CA1998;
        Wed, 12 Jul 2023 01:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=iqmSU
        ZwzBw1hM5T9jJOZyxbxjgisyiiptjpGYA/61SM=; b=DlQ4LhKM1FT98BQwQJvww
        4jSnB2wL+d32M/MHYsISXivV5jvklDzN9hoRXsXvLysrJd/RGGdmF7btwC5YAXzO
        VKsi5V252l5W3UlVWSfTDLwY5IeB9tshY+hgMlyyqYB/LBZMkQ27pD7tDzsoW5mY
        VuEgVRiN4t9fJiFDMaWmxc=
Received: from jbd-ThinkPad-X1-Nano-Gen-2.web.setting (unknown [223.160.228.167])
        by zwqz-smtp-mta-g5-1 (Coremail) with SMTP id _____wBXbUZXZq5kZhRCAA--.6187S2;
        Wed, 12 Jul 2023 16:37:44 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     mani@kernel.org, loic.poulain@linaro.org
Cc:     fabio.porcedda@gmail.com, bhelgaas@google.com, song.fc@gmail.com,
        duke_xinanwen@163.com, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] bus: mhi: host: pci_generic: Add support for Dell DW5932e
Date:   Wed, 12 Jul 2023 16:37:41 +0800
Message-Id: <20230712083741.7615-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBXbUZXZq5kZhRCAA--.6187S2
X-Coremail-Antispam: 1Uf129KBjvJXoWrZw1xKry3KF18CFWxJF4xWFg_yoW8Jr4DpF
        4F934jyF4kJr4jyaykt3yDXas8Wan3Gry7KF4xK34Y9F4qyFWYgr92gry2gF15Ka9Yqa1a
        qFy8XFWjg3WqkF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUbXowUUUUU=
X-Originating-IP: [223.160.228.167]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbioxmqZGNfupXBtAAAsS
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DW5932e has 2 variants: eSIM(DW5932e-eSIM) and non-eSIM(DW5932e).
Both of them are designed based on Qualcomm SDX62 and it will
align with the Foxconn sdx65 settings.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 drivers/bus/mhi/host/pci_generic.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index 9ca0dc3a3bfe..07172789b197 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -625,6 +625,12 @@ static const struct pci_device_id mhi_pci_id_table[] = {
 	/* T99W510 (sdx24), variant 3 */
 	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0f2),
 		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx24_info },
+	/* DW5932e-eSIM (sdx62), With eSIM */
+	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0f5),
+		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx65_info },
+	/* DW5932e (sdx62), Non-eSIM*/
+	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0f9),
+		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx65_info },
 	/* MV31-W (Cinterion) */
 	{ PCI_DEVICE(PCI_VENDOR_ID_THALES, 0x00b3),
 		.driver_data = (kernel_ulong_t) &mhi_mv31_info },
-- 
2.25.1

