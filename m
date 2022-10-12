Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE175FCE2A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 00:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbiJLWJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 18:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbiJLWJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 18:09:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB1A272D
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 15:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665612438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=+UHVZ0OKpbw8jecQvx7/f32wxsaBtJja/aKylAWrChs=;
        b=UvlzHPARCHvGClQFcvConZdnUUIPrJkbu/DCR201+ZbbBYrf2NPHgAxaHHAoxSksMD4uRD
        SlZqLK2jov0McEqn869wr+OcwXyzooE+njeJuw4CyRWoII01nfpr1hqa+aLnD2kSJNOAyV
        o//txZib/Wx7MIClvIF8ZKqooLuM7cs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-313-FGFMeAr4MFCpr55Hmd6WpA-1; Wed, 12 Oct 2022 18:04:07 -0400
X-MC-Unique: FGFMeAr4MFCpr55Hmd6WpA-1
Received: by mail-wm1-f70.google.com with SMTP id k22-20020a05600c0b5600b003c6cf5c5592so89108wmr.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 15:04:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+UHVZ0OKpbw8jecQvx7/f32wxsaBtJja/aKylAWrChs=;
        b=WBsfK100W4i9QIA6/h3Q/CQ/SRkdvmTx0pHwme2YeIDHPJrMSAMXt7m5A+lWJVNDy3
         HBVce69+Kx6jj8GQA7CB7SXhp8o9fb/S/rhbdr+X7xikV1rxEcpNYeD/ZuaMRpaL9o5X
         mMtxwBfFVm2x5ba1V5Y2iRWHmk6QAkH1fDBfRo71yP9kZP3FVhsR/ExxPryKB3KY0eAY
         xhFVxR14g6p/YS9pnVMQTHWX5FeD6WRfR3o6gtvUI1wpMZfNJ3SLTW6rO2vQsIkWrLzB
         EAcVoOR2nvnu7OofH5x/CuEJKo15VhtzPo7lBPi8iyTIL8Bhw+S108I5fO+VckG7+//w
         JUqw==
X-Gm-Message-State: ACrzQf1pzilS9dDWiuYSWhobta3GuuG8DLyef8Is67M3g3u6Z58hxXiS
        p9dkiz51R8RPa+PTCitARdFWCvq04dOryn7J45Xe+xEKx2sVb1rAuv5KDsMXUG/6y4C+SZxF5Xf
        fp4yeQIqgj+1JZjNR/VirTOmEiPvTpFp305FtR1HehKC65GxGinufuVFl0qbVP7W2E1qdEQ==
X-Received: by 2002:a7b:c404:0:b0:3b4:faca:cf50 with SMTP id k4-20020a7bc404000000b003b4facacf50mr4103272wmi.67.1665612246228;
        Wed, 12 Oct 2022 15:04:06 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4MfahqjXwEkSDDOMNB17Cw+s5zIwA1SUMh4iBqCWkVIvhAH97bnjQIK7k88X1UxN6qaBAVEg==
X-Received: by 2002:a7b:c404:0:b0:3b4:faca:cf50 with SMTP id k4-20020a7bc404000000b003b4facacf50mr4103254wmi.67.1665612245909;
        Wed, 12 Oct 2022 15:04:05 -0700 (PDT)
Received: from redhat.com ([2.54.162.123])
        by smtp.gmail.com with ESMTPSA id l27-20020a056000023b00b0022a403954c3sm609517wrz.42.2022.10.12.15.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 15:04:05 -0700 (PDT)
Date:   Wed, 12 Oct 2022 18:04:03 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Angus Chen <angus.chen@jaguarmicro.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH] virtio_pci: use irq to detect interrupt support
Message-ID: <20221012220312.308522-1-mst@redhat.com>
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

However Linus said:
	The correct way to check for "no irq" doesn't use NO_IRQ at all, it just does
		if (dev->irq) ...
so let's just check irq and be done with it.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Fixes: 71491c54eafa ("virtio_pci: don't try to use intxif pin is zero")
Cc: "Angus Chen" <angus.chen@jaguarmicro.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Build tested only - very late here. Angus any chance you could
help test this? Thanks!

 drivers/virtio/virtio_pci_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 4df77eeb4d16..a6c86f916dbd 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -409,8 +409,8 @@ int vp_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, false, ctx, desc);
 	if (!err)
 		return 0;
-	/* Is there an interrupt pin? If not give up. */
-	if (!(to_vp_device(vdev)->pci_dev->pin))
+	/* Is there an interrupt? If not give up. */
+	if (!(to_vp_device(vdev)->pci_dev->irq))
 		return err;
 	/* Finally fall back to regular interrupts. */
 	return vp_find_vqs_intx(vdev, nvqs, vqs, callbacks, names, ctx);
-- 
MST

