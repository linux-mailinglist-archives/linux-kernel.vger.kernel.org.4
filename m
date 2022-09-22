Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919F55E6B86
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 21:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbiIVTIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 15:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232278AbiIVTIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 15:08:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507A4FCA70;
        Thu, 22 Sep 2022 12:08:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF34663792;
        Thu, 22 Sep 2022 19:08:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 996B5C433D7;
        Thu, 22 Sep 2022 19:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663873730;
        bh=RvoDarC6U/fJABhMRerQJHoq4Ys6450eyjNtBdNlByk=;
        h=Date:From:To:Cc:Subject:From;
        b=Qp8tGMn8EsST1hu+HRRx8YpEJqMvJSGxm2n68qULxO7b0Au25DDkHLpqI7P3v/zQa
         en7biq6cVEUKGmy9aaxgqbOU0N36ML/sg/CeHFzOoViBhyXKitDTyhvfmaSOIvypcX
         9sAsUjBqkSGKfGpPfp5KJe0HUJhtoOE3OBhKMwyYU8Zd9bCovV21SWb77cUZZzKKrC
         z2OKXi/rOFf31CkXUm85AMwvhvXZX2DU3Y3EEyBae507rAAbQeW0BlDWGPOuJLK25A
         xAkUKlQzyjvwGlcBfw6IB35jewCqv41ykEAK8u74QHQgrMTDeG07hxWvHwgpWIGm2V
         qNwLCBbKjJPHA==
Date:   Thu, 22 Sep 2022 14:08:44 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Adam Radford <aradford@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] scsi: 3w-xxxx: Replace one-element array with
 flexible-array member
Message-ID: <YyyyvB30jnjRaw/F@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One-element arrays are deprecated, and we are replacing them with flexible
array members instead. So, replace one-element array with flexible-array
member in struct TAG_TW_New_Ioctl and refactor the rest of the code,
accordingly.

Notice that, in multiple places, the subtraction of 1 from
sizeof(TW_New_Ioctl) is removed, as this operation is now implicit
after the flex-array transformation.

Link: https://github.com/KSPP/linux/issues/79
Link: https://github.com/KSPP/linux/issues/206
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/scsi/3w-xxxx.c | 14 +++++++-------
 drivers/scsi/3w-xxxx.h |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/3w-xxxx.c b/drivers/scsi/3w-xxxx.c
index a853c5497af6..ffdecb12d654 100644
--- a/drivers/scsi/3w-xxxx.c
+++ b/drivers/scsi/3w-xxxx.c
@@ -912,7 +912,7 @@ static long tw_chrdev_ioctl(struct file *file, unsigned int cmd, unsigned long a
 	data_buffer_length_adjusted = (data_buffer_length + 511) & ~511;
 
 	/* Now allocate ioctl buf memory */
-	cpu_addr = dma_alloc_coherent(&tw_dev->tw_pci_dev->dev, data_buffer_length_adjusted+sizeof(TW_New_Ioctl) - 1, &dma_handle, GFP_KERNEL);
+	cpu_addr = dma_alloc_coherent(&tw_dev->tw_pci_dev->dev, data_buffer_length_adjusted + sizeof(TW_New_Ioctl), &dma_handle, GFP_KERNEL);
 	if (cpu_addr == NULL) {
 		retval = -ENOMEM;
 		goto out;
@@ -921,7 +921,7 @@ static long tw_chrdev_ioctl(struct file *file, unsigned int cmd, unsigned long a
 	tw_ioctl = (TW_New_Ioctl *)cpu_addr;
 
 	/* Now copy down the entire ioctl */
-	if (copy_from_user(tw_ioctl, argp, data_buffer_length + sizeof(TW_New_Ioctl) - 1))
+	if (copy_from_user(tw_ioctl, argp, data_buffer_length + sizeof(TW_New_Ioctl)))
 		goto out2;
 
 	passthru = (TW_Passthru *)&tw_ioctl->firmware_command;
@@ -966,15 +966,15 @@ static long tw_chrdev_ioctl(struct file *file, unsigned int cmd, unsigned long a
 			/* Load the sg list */
 			switch (TW_SGL_OUT(tw_ioctl->firmware_command.opcode__sgloffset)) {
 			case 2:
-				tw_ioctl->firmware_command.byte8.param.sgl[0].address = dma_handle + sizeof(TW_New_Ioctl) - 1;
+				tw_ioctl->firmware_command.byte8.param.sgl[0].address = dma_handle + sizeof(TW_New_Ioctl);
 				tw_ioctl->firmware_command.byte8.param.sgl[0].length = data_buffer_length_adjusted;
 				break;
 			case 3:
-				tw_ioctl->firmware_command.byte8.io.sgl[0].address = dma_handle + sizeof(TW_New_Ioctl) - 1;
+				tw_ioctl->firmware_command.byte8.io.sgl[0].address = dma_handle + sizeof(TW_New_Ioctl);
 				tw_ioctl->firmware_command.byte8.io.sgl[0].length = data_buffer_length_adjusted;
 				break;
 			case 5:
-				passthru->sg_list[0].address = dma_handle + sizeof(TW_New_Ioctl) - 1;
+				passthru->sg_list[0].address = dma_handle + sizeof(TW_New_Ioctl);
 				passthru->sg_list[0].length = data_buffer_length_adjusted;
 				break;
 			}
@@ -1017,12 +1017,12 @@ static long tw_chrdev_ioctl(struct file *file, unsigned int cmd, unsigned long a
 	}
 
 	/* Now copy the response to userspace */
-	if (copy_to_user(argp, tw_ioctl, sizeof(TW_New_Ioctl) + data_buffer_length - 1))
+	if (copy_to_user(argp, tw_ioctl, sizeof(TW_New_Ioctl) + data_buffer_length))
 		goto out2;
 	retval = 0;
 out2:
 	/* Now free ioctl buf memory */
-	dma_free_coherent(&tw_dev->tw_pci_dev->dev, data_buffer_length_adjusted+sizeof(TW_New_Ioctl) - 1, cpu_addr, dma_handle);
+	dma_free_coherent(&tw_dev->tw_pci_dev->dev, data_buffer_length_adjusted + sizeof(TW_New_Ioctl), cpu_addr, dma_handle);
 out:
 	mutex_unlock(&tw_dev->ioctl_lock);
 	mutex_unlock(&tw_mutex);
diff --git a/drivers/scsi/3w-xxxx.h b/drivers/scsi/3w-xxxx.h
index e8f3f081b7d8..120a087bdf3c 100644
--- a/drivers/scsi/3w-xxxx.h
+++ b/drivers/scsi/3w-xxxx.h
@@ -348,7 +348,7 @@ typedef struct TAG_TW_New_Ioctl {
 	unsigned int data_buffer_length;
 	unsigned char padding [508];
 	TW_Command firmware_command;
-	char data_buffer[1];
+	char data_buffer[];
 } TW_New_Ioctl;
 
 /* GetParam descriptor */
-- 
2.34.1

