Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E066F62826D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 15:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236286AbiKNOX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 09:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiKNOXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:23:54 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7664021276
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 06:23:53 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B547620047;
        Mon, 14 Nov 2022 14:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1668435831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=sAfl5fuNeiYw163kQkU47PxfF3Zja2zKggUEdCCcBhk=;
        b=gp8JXiltXKb1uWqjC2t5qQtcG7+F9MBrH/xUbap/0IPmp81Z94Iz2J/dS88U0CRcqLhWQV
        wTEvQEfHqi/kDIGYEh8ZGKJV6Es/bCBCLhtpO9FonmMEi/N9et6tYlBl/oV3YJbbAQPHDW
        xXQhut/guvd1A7piXFT6qk4zMoX7oLM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8528113A92;
        Mon, 14 Nov 2022 14:23:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OwIAH3dPcmMtagAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 14 Nov 2022 14:23:51 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org
Subject: [PATCH] xen/platform-pci: use define instead of literal number
Date:   Mon, 14 Nov 2022 15:23:48 +0100
Message-Id: <20221114142348.1499-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of "0x01" use the HVM_PARAM_CALLBACK_TYPE_PCI_INTX define from
the interface header in get_callback_via().

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/xen/platform-pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/xen/platform-pci.c b/drivers/xen/platform-pci.c
index 18f0ed8b1f93..24a3de1b7b03 100644
--- a/drivers/xen/platform-pci.c
+++ b/drivers/xen/platform-pci.c
@@ -54,7 +54,8 @@ static uint64_t get_callback_via(struct pci_dev *pdev)
 	pin = pdev->pin;
 
 	/* We don't know the GSI. Specify the PCI INTx line instead. */
-	return ((uint64_t)0x01 << HVM_CALLBACK_VIA_TYPE_SHIFT) | /* PCI INTx identifier */
+	return ((uint64_t)HVM_PARAM_CALLBACK_TYPE_PCI_INTX <<
+			  HVM_CALLBACK_VIA_TYPE_SHIFT) |
 		((uint64_t)pci_domain_nr(pdev->bus) << 32) |
 		((uint64_t)pdev->bus->number << 16) |
 		((uint64_t)(pdev->devfn & 0xff) << 8) |
-- 
2.35.3

