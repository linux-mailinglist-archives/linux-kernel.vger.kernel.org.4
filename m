Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786A0719EDB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 15:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbjFANv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 09:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233394AbjFANvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 09:51:46 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82ED919B
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 06:51:43 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-51492ae66a4so1352563a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 06:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685627502; x=1688219502;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vVJTPL6ZF8NSM8+tIg6PCSL4IQNlSnliH+EHXpj1AeI=;
        b=LfZwL0vJanrn5T/tPKzxBB9HGeVBD2tFqokk0cShsaOJs6RAKryt+yzcXH/OpoVibO
         JT06DWXd+ftmoLPXsD9V0gKlsZxXNeOylQ+6npzjPCxyhvXxJmnwZXC7d0i7WkdTWaXJ
         1o0jDjlmXV0mw/wlbFRYgfFOYyHPWrE7rAb7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685627502; x=1688219502;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vVJTPL6ZF8NSM8+tIg6PCSL4IQNlSnliH+EHXpj1AeI=;
        b=ljqnwGB54w8ZgkwHgFL6wTVeTQcwY6jaLZLNpZhNnBZbPJUtB9lJyWsY9LK5Vtb0I1
         /T3RzyNYKQ9+TVkGhtLiG/321K71kUR9eB2zrAZgBf9J2taNpVxZMaLtzARlmhT3JJxy
         SeGc1rRW+TUgiAJkgFGqqw8Ufp+BytyPuupRYbV0NadqnaYvh+MxrhbaeXsxi2XJloYG
         0zzHaWnSjGYNBN3UgIE15Ko28itWrmrq5OWuczaEHTuWopLZCyuOkCd+g/wAY0wpYfyG
         7+ZZzGKCuoEERVTHvd/fTHdVDDJhguIsX7a1ymxWAV0Pyj2NV1IooP2xbw4gX/FkQklK
         0bkA==
X-Gm-Message-State: AC+VfDyFebAPNSK7NkuOqHo1DgiHxPNXPt5TwG6cjGB18Rm8inI6KgNK
        d8AyGGwUOvs1Z12HbsEDBAh1Fw==
X-Google-Smtp-Source: ACHHUZ6zSD+zjod6ePN4avGcolX6I1MjbMb4h5ISXrs0XfBu4df95UYKMPkiSvAw/zA/66OobrP2Iw==
X-Received: by 2002:a17:907:3f97:b0:94f:6058:4983 with SMTP id hr23-20020a1709073f9700b0094f60584983mr8192612ejc.76.1685627502003;
        Thu, 01 Jun 2023 06:51:42 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:8745:5c87:abd8:3631])
        by smtp.gmail.com with ESMTPSA id f7-20020a170906494700b0095807ab4b57sm10795556ejt.178.2023.06.01.06.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 06:51:41 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ribalda@chromium.org>
Date:   Thu, 01 Jun 2023 15:51:19 +0200
Subject: [PATCH v2] xhci: Do not create endpoint debugfs while holding the
 bandwidth mutex
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230531-xhci-deadlock-v2-1-5f5cf8ff5285@chromium.org>
X-B4-Tracking: v=1; b=H4sIAFaieGQC/3WNwQ6CMBBEf4Xs2Zq2SFBP/ofh0JZCN0JLtkIwh
 H935e5t3iRvZoPsCX2Ge7EB+QUzpsigTwW4YGLvBbbMoKUuZVUqsQaHovWmHZJ7cdDGauVu0jp
 gx5rshSUTXWArzsPA5US+w/U4eTbMAfM70ef4XNSv/Te/KKFEVddXabuuUvrycIHSiPN4TtRDs
 +/7F1hojRnCAAAA
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Ricardo Ribalda Delgado <ribalda@chromium.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3114; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=kHas2cbddrKrdeEKJZphZ/TYxBnPicfD6owEY8RcqKA=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBkeKJlheKCvOSufBlOm/CAXom89gI67JO03eo3F
 NAlQpmwKE6JAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCZHiiZQAKCRDRN9E+zzrE
 iCYbD/9jhro1RvQjcAmFYKRMdFKXxm+fRYe7j56m4xpThqniiSk6izQhIGIgjSooxtmsi11fXSI
 W41V4jM61+0oeTAGsKnvD5TS5dXF/71nVzv57KbngZ+HJ5w/ZKrVKQr7Yf1347QtQQJV3cOcEZy
 II3a02j2knLU3E6z8BwvILe2L+Ip+x31wfDEkOfvsY8B1E4TgcBSPAF3v2xnnXP7UvcO7bzYCZb
 riSbrXdMIpedEAXQswGdvpo/Sf+WrzmLgsY34dH54JbjD8EMhWgNdZBtRlHN1G6ICc0X8NG76gV
 N0qPBeDb9KKuVq5FPMj/Q6fnu6XswCvcd8otIZDkqDkkjhEGTGQ/ctBWs0u/OKlz70XeBSfuykn
 QHF3Yie35u9m79WT9fvhr1GVZb1tL5SYAf4nie6waRKfenGLEGY/psqlO0CYvzZpxNURPuXbinB
 Tlh5Et6jgeM1OCr7gBs/YQSrt+ZCVjqOqcWfLDvvOeTVIzf69PqIKjsmmJ9FSfNTYgLMRU6M7H5
 kDw4Q/2L75uGxivy0z2fLKfdrZcQ+F7fp4G08gOA+pt7D6MNk24ywoYD1L9v0n+2iYGGgVPUcDL
 kGsoIz0lVel38YZhA+DhlavJjpdV5S+5CrUcB0i6Kr9mJfGXGH6zEA6rvpDna3fc9d+CR8YYeyz
 6NcnI7SGAuSL01Q==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xhci_debugfs_create_endpoint needs to take the mm->mmap_sem, which is
not serialized with the hcd->bandwidth_mutex across the codebase.

Without this patch a deadlock has been observed with the uvc driver at
the functions v4l2_mmap() and usb_set_interface().

Cc: Stephen Boyd <swboyd@chromium.org>
Fixes: 167657a1bb5f ("xhci: don't create endpoint debugfs entry before ring buffer is set.")
Signed-off-by: Ricardo Ribalda Delgado <ribalda@chromium.org>
---
Even though I do not have a proper reproducer for this, I do not see
this deadlock happening after fuzzing locally my kernel.

I am not used to this subsystem, so please take a careful look at
this patch :).

Thanks!
---
Changes in v2:
- Fix Stepeh email. Thanks Greg!
- Update cover to note that with this patch the deadlock does not
  happen.
- Link to v1: https://lore.kernel.org/r/20230531-xhci-deadlock-v1-1-57780bff5124@chromium.org
---
 drivers/usb/host/xhci-debugfs.c | 4 ++++
 drivers/usb/host/xhci.c         | 4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-debugfs.c b/drivers/usb/host/xhci-debugfs.c
index 99baa60ef50f..2acce2af2ca9 100644
--- a/drivers/usb/host/xhci-debugfs.c
+++ b/drivers/usb/host/xhci-debugfs.c
@@ -238,6 +238,10 @@ static int xhci_ring_open(struct inode *inode, struct file *file)
 	int			i;
 	struct xhci_file_map	*f_map;
 	const char		*file_name = file_dentry(file)->d_iname;
+	struct xhci_ring	*ring = *(struct xhci_ring **)inode->i_private;
+
+	if (!ring)
+		return -EAGAIN;
 
 	for (i = 0; i < ARRAY_SIZE(ring_files); i++) {
 		f_map = &ring_files[i];
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 78790dc13c5f..2715900b2540 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1930,6 +1930,8 @@ int xhci_add_endpoint(struct usb_hcd *hcd, struct usb_device *udev,
 	ep_ctx = xhci_get_ep_ctx(xhci, virt_dev->in_ctx, ep_index);
 	trace_xhci_add_endpoint(ep_ctx);
 
+	xhci_debugfs_create_endpoint(xhci, virt_dev, ep_index);
+
 	xhci_dbg(xhci, "add ep 0x%x, slot id %d, new drop flags = %#x, new add flags = %#x\n",
 			(unsigned int) ep->desc.bEndpointAddress,
 			udev->slot_id,
@@ -2963,7 +2965,6 @@ int xhci_check_bandwidth(struct usb_hcd *hcd, struct usb_device *udev)
 		xhci_check_bw_drop_ep_streams(xhci, virt_dev, i);
 		virt_dev->eps[i].ring = virt_dev->eps[i].new_ring;
 		virt_dev->eps[i].new_ring = NULL;
-		xhci_debugfs_create_endpoint(xhci, virt_dev, i);
 	}
 command_cleanup:
 	kfree(command->completion);
@@ -2989,7 +2990,6 @@ void xhci_reset_bandwidth(struct usb_hcd *hcd, struct usb_device *udev)
 	/* Free any rings allocated for added endpoints */
 	for (i = 0; i < 31; i++) {
 		if (virt_dev->eps[i].new_ring) {
-			xhci_debugfs_remove_endpoint(xhci, virt_dev, i);
 			xhci_ring_free(xhci, virt_dev->eps[i].new_ring);
 			virt_dev->eps[i].new_ring = NULL;
 		}

---
base-commit: 48b1320a674e1ff5de2fad8606bee38f724594dc
change-id: 20230531-xhci-deadlock-de2ab21c90bc

Best regards,
-- 
Ricardo Ribalda Delgado <ribalda@chromium.org>

