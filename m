Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3866DCB6E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 21:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjDJTPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 15:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDJTOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 15:14:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0846A1980
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 12:14:48 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681154086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VACFH6nP2OHBr9zz8HSVitcsLS/GkoJrTXejyQVrgsE=;
        b=WroTXvyFge1YF3sP6p3ZH7e08JdEOZfXRVFqISXoJly9QdtLzLcsQZqBSq2qx1J3iWipO8
        2J3awYVKfU15ZxBGafaGknGurEozpLNdTH4VQPCs1oQxtWRctAmdXMhsWcZFjzEq1r7GBK
        Vb/SU/33FjK+4mI0L8zcFj2lo0kj8rmWfIZZUmru4LPJcAMq4xC9f80IsetEnkjjSVqo4l
        YDy3W24SfO/N/92SY45fGwxeGhofl1rExW2NxVrmkI7Wcd05K/cOULHe2NTnkghFJP6sR3
        ynD2NI2kbmqeV2hBl3UImU75+vgMlrl9TSg8CbIzW/0+9lr6zM3bOTeocC6sjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681154086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VACFH6nP2OHBr9zz8HSVitcsLS/GkoJrTXejyQVrgsE=;
        b=yhYXLIXPOmSF9iXJGKYWMgdshLRtqbh1CbGNM2u7U1Y9zbVgI/BuY/Z5mL9+AgPc2UoDRc
        RBzJ9S0mv0LDOrBQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Laight <David.Laight@aculab.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH] PCI/MSI: Remove over-zealous hardware size check in
 pci_msix_validate_entries()
In-Reply-To: <878rf3tm48.ffs@tglx>
References: <caca6879210940428e0aa2a1496907ab@AcuMS.aculab.com>
 <CAHk-=whd4w2wu13O9b5VRKE1b3MoUk89Q_WzhELyqXGAKmfqmQ@mail.gmail.com>
 <dd933c50df674dd69f6e630a53cfee77@AcuMS.aculab.com>
 <CAHk-=whA+n+9_AzzPaoxMDgh9YHvif+LC0ZhFuUg-qED=oynHQ@mail.gmail.com>
 <878rf3tm48.ffs@tglx>
Date:   Mon, 10 Apr 2023 21:14:45 +0200
Message-ID: <87v8i3sg62.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pci_msix_validate_entries() validates the entries array which is handed in
by the caller for a MSI-X interrupt allocation. Aside of consistency
failures it also detects a failure when the size of the MSI-X hardware table
in the device is smaller than the size of the entries array.

That's wrong for the case of range allocations where the caller provides
the minimum and the maximum number of vectors to allocate, when the
hardware size is greater or equal to the mininum, but smaller than the
maximum.

Remove the hardware size check completely from that function and just
ensure that the entires array up to the maximum size is consistent.

The limitation and range checking versus the hardware size happens
independently of that afterwards anyway because the entries array is
optional.

Fixes: 4644d22eb673 ("PCI/MSI: Validate MSI-X contiguous restriction early")
Reported-by: David Laight <David.Laight@aculab.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---

David, can you please confirm that this fixes your issue?

---
 drivers/pci/msi/msi.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -750,8 +750,7 @@ static int msix_capability_init(struct p
 	return ret;
 }
 
-static bool pci_msix_validate_entries(struct pci_dev *dev, struct msix_entry *entries,
-				      int nvec, int hwsize)
+static bool pci_msix_validate_entries(struct pci_dev *dev, struct msix_entry *entries, int nvev)
 {
 	bool nogap;
 	int i, j;
@@ -762,10 +761,6 @@ static bool pci_msix_validate_entries(st
 	nogap = pci_msi_domain_supports(dev, MSI_FLAG_MSIX_CONTIGUOUS, DENY_LEGACY);
 
 	for (i = 0; i < nvec; i++) {
-		/* Entry within hardware limit? */
-		if (entries[i].entry >= hwsize)
-			return false;
-
 		/* Check for duplicate entries */
 		for (j = i + 1; j < nvec; j++) {
 			if (entries[i].entry == entries[j].entry)
@@ -805,7 +800,7 @@ int __pci_enable_msix_range(struct pci_d
 	if (hwsize < 0)
 		return hwsize;
 
-	if (!pci_msix_validate_entries(dev, entries, nvec, hwsize))
+	if (!pci_msix_validate_entries(dev, entries, nvec))
 		return -EINVAL;
 
 	if (hwsize < nvec) {
