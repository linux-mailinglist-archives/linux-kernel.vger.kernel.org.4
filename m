Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45FDE745B1D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 13:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjGCLbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 07:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjGCLbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 07:31:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E82B3;
        Mon,  3 Jul 2023 04:31:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 669F760EC2;
        Mon,  3 Jul 2023 11:31:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD31CC433C7;
        Mon,  3 Jul 2023 11:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688383879;
        bh=4dMz6AICQADVRRk6AU4c36ys4TXGNzy34CAOZWE5z1o=;
        h=From:To:Cc:Subject:Date:From;
        b=JGYuRaq5gZfzOX8EqTv+gxLLWUN2XdBFw6I4bM65b02eU9FLNa05+EkPbuIM/w/0L
         KKTu7s2hACooo45t5NDtM88Rdku73L7/D/1UNqwCFiT456JhYx2FO6FLHa2zAdQXk4
         kBYM+1lb9c7KI7X8CAO+I/L6fuxTwIv5D8kBj4byiLVWnJR/Y+9kCcCt/CZSdG19TK
         6u0MLr5Qpf3fIrA27gXgGb+rRYtyqDcI2T4SQ7j6UslQf0KizBMVMnA9OEbppJPDLf
         SHVBr8s4T3LmNTyYyYLytU73cOIVLW9itW3Pxduydln2eOH0/4tsmDNlAFniXdwStT
         DMbLYPeHBgZ9g==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Chris Lu <chris.lu@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Jing Cai <jing.cai@mediatek.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Manish Mandlik <mmandlik@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Brian Gix <brian.gix@intel.com>, Pauli Virtanen <pav@iki.fi>,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: coredump: fix building with coredump disabled
Date:   Mon,  3 Jul 2023 13:30:48 +0200
Message-Id: <20230703113112.380663-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
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

From: Arnd Bergmann <arnd@arndb.de>

The btmtk driver uses an IS_ENABLED() check to conditionally compile
the coredump support, but this fails to build because the hdev->dump
member is in an #ifdef:

drivers/bluetooth/btmtk.c: In function 'btmtk_process_coredump':
drivers/bluetooth/btmtk.c:386:30: error: 'struct hci_dev' has no member named 'dump'
  386 |   schedule_delayed_work(&hdev->dump.dump_timeout,
      |                              ^~

The struct member doesn't really make a huge difference in the total size,
so just remove the #ifdef around it to avoid adding similar checks
around each user.

Fixes: 872f8c253cb9e ("Bluetooth: btusb: mediatek: add MediaTek devcoredump support")
Fixes: 9695ef876fd12 ("Bluetooth: Add support for hci devcoredump")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/net/bluetooth/hci_core.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index c0ca3f869c923..491ab83ccafc9 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -593,9 +593,7 @@ struct hci_dev {
 	const char		*fw_info;
 	struct dentry		*debugfs;
 
-#ifdef CONFIG_DEV_COREDUMP
 	struct hci_devcoredump	dump;
-#endif
 
 	struct device		dev;
 
-- 
2.39.2

