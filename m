Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA23C6CB9B7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 10:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjC1Ip4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 04:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjC1Ipx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 04:45:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547B84C05
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 01:45:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E5E36219CB;
        Tue, 28 Mar 2023 08:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679993150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=yXUBjKrqwM53T7UrMckHmjpZFpuDk2TlKdZU+l+grfw=;
        b=fJXUKWANRW8UbMDWIBWa1Ugqequ8HMpEy8gvoVbpd6zkULAMbQGG4p9jGgHdqu6qTdxLhc
        46qW60UcAgbI86aHUuh8Utl7D1GVZkBPPdOIqW5XcHq1NFUqRVZGRbgoBwPsx68xwhMFHV
        KFpMEV+ONinzbFqgbDt2HwSgfcmEXwg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B38E31390D;
        Tue, 28 Mar 2023 08:45:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RdNgKj6pImThLgAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 28 Mar 2023 08:45:50 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org, Dan Carpenter <error27@gmail.com>
Subject: [PATCH] xen/pciback: don't call pcistub_device_put() under lock
Date:   Tue, 28 Mar 2023 10:45:49 +0200
Message-Id: <20230328084549.20695-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pcistub_device_put() shouldn't be called under spinlock, as it can
sleep.

For this reason pcistub_device_get_pci_dev() needs to be modified:
instead of always calling pcistub_device_get() just do the call of
pcistub_device_get() only if it is really needed. This removes the
need to call pcistub_device_put().

Reported-by: Dan Carpenter <error27@gmail.com>
Link: https://lore.kernel.org/lkml/Y+JUIl64UDmdkboh@kadam/
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/xen/xen-pciback/pci_stub.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/xen/xen-pciback/pci_stub.c b/drivers/xen/xen-pciback/pci_stub.c
index bba527620507..e34b623e4b41 100644
--- a/drivers/xen/xen-pciback/pci_stub.c
+++ b/drivers/xen/xen-pciback/pci_stub.c
@@ -194,8 +194,6 @@ static struct pci_dev *pcistub_device_get_pci_dev(struct xen_pcibk_device *pdev,
 	struct pci_dev *pci_dev = NULL;
 	unsigned long flags;
 
-	pcistub_device_get(psdev);
-
 	spin_lock_irqsave(&psdev->lock, flags);
 	if (!psdev->pdev) {
 		psdev->pdev = pdev;
@@ -203,8 +201,8 @@ static struct pci_dev *pcistub_device_get_pci_dev(struct xen_pcibk_device *pdev,
 	}
 	spin_unlock_irqrestore(&psdev->lock, flags);
 
-	if (!pci_dev)
-		pcistub_device_put(psdev);
+	if (pci_dev)
+		pcistub_device_get(psdev);
 
 	return pci_dev;
 }
-- 
2.35.3

