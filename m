Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F38F6B3BD9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 11:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjCJKSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 05:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjCJKSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 05:18:00 -0500
Received: from m12.mail.163.com (m12.mail.163.com [123.126.96.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8BBB19ECA;
        Fri, 10 Mar 2023 02:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ovFLq
        x1Bf6i8X0C5fFEA/SoD0OZdlMeBnF2sAwARGF0=; b=mNG8jiFxY1caMezlLiFF0
        ZLt2nqH+hwf4lHRxS8nvi+94dQdbJXLvWJh/e+1AaT7nc3L4l0Kco2cY5uLWLhWy
        SYLaT1+7OucUlzPDk0yWloHeQJMHy3RXSQCSHNTn8157sqmGi80Z0mKKOklxvpzm
        H08jT0/CXcSIrvM+KOOx3k=
Received: from jbd-ThinkPad-X1-Nano-Gen-1.. (unknown [223.104.68.74])
        by smtp16 (Coremail) with SMTP id MNxpCgCnkUfmAwtkDRU7HA--.61346S2;
        Fri, 10 Mar 2023 18:18:16 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     mani@kernel.org, loic.poulain@linaro.org, fabio.porcedda@gmail.com
Cc:     mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] bus: mhi: host: pci_generic: Revert "Add a secondary AT port to Telit FN990"
Date:   Fri, 10 Mar 2023 18:17:15 +0800
Message-Id: <20230310101715.69209-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: MNxpCgCnkUfmAwtkDRU7HA--.61346S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xry8Ww1fGF4kKrWfWryUKFg_yoWktrg_Ca
        n2grn7G3yxXr98Zr4Iq3WkZrWjya45X3WDA3WxtrnYq3srt3srWrs0qFZYvrna9a9xCrZr
        Cw45XrW7Ar12kjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRRPl15UUUUU==
X-Originating-IP: [223.104.68.74]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbivxQuZFWB32rMRgAAsK
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 2d5253a096c6057bbf7caa5520856dcdf7eca8bb.
There are 2 commits with commit message "Add a secondary AT
port to Telit FN990". But the last one 2d5253a096 was added
on Foxconn devices. Actually the second AT port of Foxconn
devices doesn't work in PCIe mode. And the commit message
mismatch with the changes. So we need to remove it.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 drivers/bus/mhi/host/pci_generic.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index 6e13c43a84d1..91d02f84ba21 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -343,8 +343,6 @@ static const struct mhi_channel_config mhi_foxconn_sdx55_channels[] = {
 	MHI_CHANNEL_CONFIG_DL(13, "MBIM", 32, 0),
 	MHI_CHANNEL_CONFIG_UL(32, "DUN", 32, 0),
 	MHI_CHANNEL_CONFIG_DL(33, "DUN", 32, 0),
-	MHI_CHANNEL_CONFIG_UL(92, "DUN2", 32, 1),
-	MHI_CHANNEL_CONFIG_DL(93, "DUN2", 32, 1),
 	MHI_CHANNEL_CONFIG_HW_UL(100, "IP_HW0_MBIM", 128, 2),
 	MHI_CHANNEL_CONFIG_HW_DL(101, "IP_HW0_MBIM", 128, 3),
 };
-- 
2.34.1

