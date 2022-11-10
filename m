Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14495623BA1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 07:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbiKJGLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 01:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiKJGL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 01:11:29 -0500
Received: from out199-1.us.a.mail.aliyun.com (out199-1.us.a.mail.aliyun.com [47.90.199.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7185275FC
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 22:11:27 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VURd1rh_1668060673;
Received: from localhost.localdomain(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VURd1rh_1668060673)
          by smtp.aliyun-inc.com;
          Thu, 10 Nov 2022 14:11:24 +0800
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: [PATCH] virtio_pci: use PAGE_SIZE for pci vring align
Date:   Thu, 10 Nov 2022 14:11:11 +0800
Message-Id: <20221110061111.383076-1-xianting.tian@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the comments of VIRTIO_PCI_VRING_ALIGN shows, we should use
PAGE_SZIE not the hard code 4096.

Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
---
 include/uapi/linux/virtio_pci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
index f703afc7ad31..ed5f678c682b 100644
--- a/include/uapi/linux/virtio_pci.h
+++ b/include/uapi/linux/virtio_pci.h
@@ -90,7 +90,7 @@
 
 /* The alignment to use between consumer and producer parts of vring.
  * x86 pagesize again. */
-#define VIRTIO_PCI_VRING_ALIGN		4096
+#define VIRTIO_PCI_VRING_ALIGN		PAGE_SIZE
 
 #endif /* VIRTIO_PCI_NO_LEGACY */
 
-- 
2.17.1

