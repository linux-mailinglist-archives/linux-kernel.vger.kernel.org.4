Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BECCA5FC41E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 13:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiJLLJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 07:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiJLLJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 07:09:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3003A99E6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 04:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665572955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=QA+9IDqgn+blor4+o5DMdo6TwcAPu5Eh2nDXrpBAQL8=;
        b=h99nPDJB/Zbv7WqMln8tPUNsgnJBin7GvqO60vIWHA16mr0OD+S4g7PFeiJEjSqlyJUCt+
        FQ/vcvVukRT/h2jpPlPsZtg+qrRjWho/bzg2t9v/N4uvlGsSMgzH7wZqv6sZh/jBMdQNlY
        NlCrFcrUEYFLsF4jX6jdCmzVd6up5ho=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-554-vL5uOPMqOo2_L4QQ_513iA-1; Wed, 12 Oct 2022 07:07:45 -0400
X-MC-Unique: vL5uOPMqOo2_L4QQ_513iA-1
Received: by mail-wm1-f72.google.com with SMTP id 189-20020a1c02c6000000b003c6d73209b0so471519wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 04:07:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QA+9IDqgn+blor4+o5DMdo6TwcAPu5Eh2nDXrpBAQL8=;
        b=pX3gEmflO8vVWpJU4dp5dW/eVtrOJg1Ssnc6606EQt1qy41YRENV+bJ6wEw6ngI1tt
         C8TmmdGPxYsC9MZyAW7y9gvhL5Dks5drMkE2cEJx0ouMCw4RE+t0p2RibyyVUPEVHQvT
         KmfRWPmR5l3w9MMcBx5VaX6AbAzI6JhcjXNULsIEO9TmiHxZjO+VmU1oFl5in+k1IYFp
         i3VkBPA7D6KI2tSQ+AJWPaPCkQabuRX5TEG5HkAOo3MYVxEuvObzw9Llw5GAPcpDZFbL
         yhHeQIk2GqtBG9iJ7NXYNSL+2qXLxojMBaUKIuruEPtJDacfHlj0c5JKsldAS7XlDOo7
         UBeA==
X-Gm-Message-State: ACrzQf2Q9Q60lRq7JHogDSDonR7EwvClaQFkHFWstE4HP45GEiSucbHH
        7jzzuX115s2j+8tCUYo3TwjeW8491MmChfAbZYuN47N+BdkHeIhfV1P+BoFvrvPKjkMsd0fL18w
        jzfR6dlV5HRPAe0W8YJYbZ4IO3kw5DCMdWHJaxfmB39ZGEyGc70i32zivWrRASghLxrAKPg==
X-Received: by 2002:a05:600c:3c82:b0:3b5:60a6:c80f with SMTP id bg2-20020a05600c3c8200b003b560a6c80fmr2385200wmb.199.1665572863567;
        Wed, 12 Oct 2022 04:07:43 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5inPNWHSWc1gs5TIXEf5jKgbpH2XPgEMLAGLpADyEG2gIXgIpphiXXjIRCrRcs0fdg6iZ/yQ==
X-Received: by 2002:a05:600c:3c82:b0:3b5:60a6:c80f with SMTP id bg2-20020a05600c3c8200b003b560a6c80fmr2385177wmb.199.1665572863169;
        Wed, 12 Oct 2022 04:07:43 -0700 (PDT)
Received: from redhat.com ([2.54.162.123])
        by smtp.gmail.com with ESMTPSA id a1-20020a05600c348100b003a5f4fccd4asm1469436wmq.35.2022.10.12.04.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 04:07:42 -0700 (PDT)
Date:   Wed, 12 Oct 2022 07:07:40 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Angus Chen <angus.chen@jaguarmicro.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH] virtio_pci: read interrupt pin directly
Message-ID: <20221012110736.285161-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 71491c54eafa ("virtio_pci: don't try to use intxif pin is zero")
breaks virtio_pci on powerpc, when running as a qemu guest.

vp_find_vqs() bails out because pci_dev->pin == 0.

But pci_dev->irq is populated correctly, so vp_find_vqs_intx() would
succeed if we called it - which is what the code used to do.

This seems to happen because pci_dev->pin is not populated in
pci_assign_irq().

Which is absolutely a bug in the relevant PCI code, but it
may also affect other platforms that use of_irq_parse_and_map_pci().

Work around the issue in virtio for now, and let's try to fix
all affected pci systems and then we can revert this.

Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Fixes: 71491c54eafa ("virtio_pci: don't try to use intxif pin is zero")
Cc: "Angus Chen" <angus.chen@jaguarmicro.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_pci_common.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 4df77eeb4d16..6155ea4e7e4b 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -400,6 +400,7 @@ int vp_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 		struct irq_affinity *desc)
 {
 	int err;
+	u8 pin = 0;
 
 	/* Try MSI-X with one vector per queue. */
 	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, true, ctx, desc);
@@ -409,8 +410,13 @@ int vp_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, false, ctx, desc);
 	if (!err)
 		return 0;
-	/* Is there an interrupt pin? If not give up. */
-	if (!(to_vp_device(vdev)->pci_dev->pin))
+	/*
+	 * Is there an interrupt pin? If not give up.
+	 * NB: It would seem to be better to use pci_dev->pin - unfortunately
+	 * not all platforms populate it.
+	 */
+	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
+	if (!pin)
 		return err;
 	/* Finally fall back to regular interrupts. */
 	return vp_find_vqs_intx(vdev, nvqs, vqs, callbacks, names, ctx);
-- 
MST

