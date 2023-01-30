Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD8C6807EE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 09:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235986AbjA3IzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 03:55:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235950AbjA3IzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 03:55:19 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F36325E02
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 00:55:14 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4P527h2Djcz6FK2X;
        Mon, 30 Jan 2023 16:55:12 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
        by mse-fl2.zte.com.cn with SMTP id 30U8t1hB099803;
        Mon, 30 Jan 2023 16:55:01 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Mon, 30 Jan 2023 16:55:03 +0800 (CST)
Date:   Mon, 30 Jan 2023 16:55:03 +0800 (CST)
X-Zmail-TransId: 2af963d785e7fffffffff2d81aec
X-Mailer: Zmail v1.0
Message-ID: <202301301655039458241@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <jgg@ziepe.ca>
Cc:     <rostedt@goodmis.org>, <akrowiak@linux.ibm.com>,
        <alex.williamson@redhat.com>, <alex.gaynor@gmail.com>,
        <ojeda@kernel.org>, <mhiramat@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBzYW1wbGVzOiBmaXggdGhlIGNvbXBpbGUgZXJyb3IgYWJvdXQgU0FNUExFX1ZGSU9fTURFVl8gc2VyaWVz?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 30U8t1hB099803
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 63D785F0.000 by FangMail milter!
X-FangMail-Envelope: 1675068912/4P527h2Djcz6FK2X/63D785F0.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63D785F0.000/4P527h2Djcz6FK2X
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

When CONFIG_VFIO = m, SAMPLE_VFIO_MDEV_MTTY, SAMPLE_VFIO_MDEV_MTTY and
SAMPLE_VFIO_MDEV_MBOCHS can be selected as:
CONFIG_SAMPLE_VFIO_MDEV_MTTY = y;
CONFIG_SAMPLE_VFIO_MDEV_MTTY = y;
CONFIG_SAMPLE_VFIO_MDEV_MBOCHS = y;

That will cause compile error such as:

ld: samples/vfio-mdev/mdpy.o: in function 'mdpy_remove':
samples/vfio-mdev/mdpy.c:294: undefined reference to
'vfio_unregister_group_dev'

ld: samples/vfio-mdev/mtty.o: in function 'mtty_remove':
samples/vfio-mdev/mtty.c:793: undefined reference to
'vfio_unregister_group_dev'

ld: samples/vfio-mdev/mbochs.o: in function 'mbochs_remove':
samples/vfio-mdev/mbochs.c:603: undefined reference to
'vfio_unregister_group_dev'

Add dependency make SAMPLE_VFIO_MDEV_MTTY, SAMPLE_VFIO_MDEV_MTTY and
SAMPLE_VFIO_MDEV_MBOCHS not allowed to set as y when
CONFIG_VFIO = m.

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 samples/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/samples/Kconfig b/samples/Kconfig
index 56b191d128d8..44a09dfa8a0b 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -185,6 +185,7 @@ config SAMPLE_UHID

 config SAMPLE_VFIO_MDEV_MTTY
 	tristate "Build VFIO mtty example mediated device sample code"
+	depends on VFIO
 	select VFIO_MDEV
 	help
 	  Build a virtual tty sample driver for use as a VFIO
@@ -192,6 +193,7 @@ config SAMPLE_VFIO_MDEV_MTTY

 config SAMPLE_VFIO_MDEV_MDPY
 	tristate "Build VFIO mdpy example mediated device sample code"
+	depends on VFIO
 	select VFIO_MDEV
 	help
 	  Build a virtual display sample driver for use as a VFIO
@@ -209,6 +211,7 @@ config SAMPLE_VFIO_MDEV_MDPY_FB

 config SAMPLE_VFIO_MDEV_MBOCHS
 	tristate "Build VFIO mdpy example mediated device sample code"
+	depends on VFIO
 	select VFIO_MDEV
 	select DMA_SHARED_BUFFER
 	help
-- 
2.25.1
