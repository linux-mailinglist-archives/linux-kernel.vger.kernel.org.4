Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3B365E209
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjAEAwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:52:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjAEAwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:52:23 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976822007
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 16:48:05 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id c2-20020a17090a020200b00226c762ed23so453184pjc.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 16:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qmx16UuQhO5rZu2O4slHfWVCdmlFd6cA9JuWyhm5rnA=;
        b=QWJVknkQ4DnD/ayIlD5UFOKldJWRzve9KTy5wyE6+Mp3ZKKSktyLlD2gDetG4fPgCT
         NC7DFI4iiSawaeo7pOJu3NUieI7dM0IUa4XP8KeJsYU0JqtqRW3VewKL4SklusEMI0nI
         YuAWzITODQhqY03mM90/8RPSh8kWFxIgj8z/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qmx16UuQhO5rZu2O4slHfWVCdmlFd6cA9JuWyhm5rnA=;
        b=G27fTRIWMEgQDh+46t4skRcxV7akam2reg7wRyjgv0/P/MYH0jryTvh4u0iaPuswIV
         koABnb/HoZ6fBjJCvHvYPVCMeyEgQkjKiQu62AHeIBCxqmLdoht6XLCnfdjxGS6hAMMh
         2ty5SL4QQNMKMxoJr+ew1p5Fdh4/OeoQ+QxMnxObWn2oYIsVdp1JxQ9IKoOX7Lk6bK1b
         UxvERXHWE3M66O4n8OGloAGctYUMRUhcC3IurliKtrMHWU9+SkGDa+T1fsDsc65UIAwR
         RuxwcwQL8Kj12mn6NzL1FRzTwIkgyLn0j7H6746BBHgV9hlO0KH6C9e99HUYFlgd+Brt
         GpKQ==
X-Gm-Message-State: AFqh2kqbmqeTp3pR1jxeRvmbe2q136G+nPPwEJ5hnMwhlUrcNClAk1E7
        qAqUY29LlXzMrwBRiog7+xY3Gw==
X-Google-Smtp-Source: AMrXdXupL+sr3HUkoy2bfjrW7IqsfGOud1IYdPVIlbzhbmE04NN1d5x29xV3kREuH7iPBzwDP4yOBw==
X-Received: by 2002:a17:903:3311:b0:189:6522:7cc0 with SMTP id jk17-20020a170903331100b0018965227cc0mr52406794plb.50.1672879685109;
        Wed, 04 Jan 2023 16:48:05 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a2-20020a170902ecc200b0017f64ab80e5sm24706484plh.179.2023.01.04.16.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 16:48:04 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Adam Radford <aradford@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] scsi: 3w-sas: Replace 1-element arrays with flexible array members
Date:   Wed,  4 Jan 2023 16:48:01 -0800
Message-Id: <20230105004757.never.017-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4853; h=from:subject:message-id; bh=fngDH2oJss4+sESGmI2fY1x2FAgrFeUQkGfTN9+iocQ=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjth5Bain+6puH3Sb3/JrYRy2oc/pRGmxm11AX/0Xw s2+izlqJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY7YeQQAKCRCJcvTf3G3AJlLPD/ 9l+/uUbl6Loft70IysZLVyMfYPnC8y2klp3eiLSnUsKn91TtjHZeowcGK4tk7km3fjHMLs1X2jdlMU HuKWnuIDSv9ElQq/uXaZTex55zFG7tc4PcKrylYLH0k+dhFto2PMsqrn3NeVGymysBHeo8J3rAZxbB qVS0Bg/8023frYnGayhasJYv5JKSQZoFi5Q2PErnInysyP8Ry4vZTqF8hm33zegRD16Qkc7ubi9AEE 8nbrxrtSagUm9iJmVnUkdmrKlGZzQp9TuNfWgYAKZEp64WrjWOaYWOgAQzE7QzotkwT+DzkdoJ4UND 6dG9H+hjXstjjA3MpP51T1Gds8f1cG3oAw6Q+kwLxDM4dYees+GPWQs71TxfscAtqKrNqke/6vDNDz /elJwgBuu+JWhf8XzW7sUsuh3iSKP2SA5TzCZbh21lONJpHHzMbVHmgauTMS3U2KMbAdkSJlxfRUGu l+ZywrFDWli5lWVbE+/iCW5zoPMVBvxBeuuoFRoX6Kb2yvGW+D390mZcSASCkvT8qcij4VYo2FhlKi s36wFv3yhnt9/Rhfp6Bp25WguyKISinr2gNIaJTjgCIU43m7u+NW5c10FjwLT1zHXrh1/2tKfIFmVI FNCu8BAP+AkVReKvwKXfnx0fbGsFmYF+5xwniFOjFP/9328k2m4m69VKhBuw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One-element arrays (and multi-element arrays being treated as
dynamically sized) are deprecated[1] and are being replaced with
flexible array members in support of the ongoing efforts to tighten the
FORTIFY_SOURCE routines on memcpy(), correctly instrument array indexing
with UBSAN_BOUNDS, and to globally enable -fstrict-flex-arrays=3.

Replace one-element arrays with flexible-array member in TW_Ioctl_Buf_Apache
and TW_Param_Apache, adjusting the explicit sizing calculations at the
same time.

This results in no differences in binary output.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays

Cc: Adam Radford <aradford@gmail.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/scsi/3w-sas.c | 12 ++++++------
 drivers/scsi/3w-sas.h |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/3w-sas.c b/drivers/scsi/3w-sas.c
index 3ebe66151dcb..f41c93454f0c 100644
--- a/drivers/scsi/3w-sas.c
+++ b/drivers/scsi/3w-sas.c
@@ -690,7 +690,7 @@ static void twl_load_sgl(TW_Device_Extension *tw_dev, TW_Command_Full *full_comm
 		newcommand->request_id__lunl =
 			cpu_to_le16(TW_REQ_LUN_IN(TW_LUN_OUT(newcommand->request_id__lunl), request_id));
 		if (length) {
-			newcommand->sg_list[0].address = TW_CPU_TO_SGL(dma_handle + sizeof(TW_Ioctl_Buf_Apache) - 1);
+			newcommand->sg_list[0].address = TW_CPU_TO_SGL(dma_handle + sizeof(TW_Ioctl_Buf_Apache));
 			newcommand->sg_list[0].length = TW_CPU_TO_SGL(length);
 		}
 		newcommand->sgl_entries__lunh =
@@ -702,7 +702,7 @@ static void twl_load_sgl(TW_Device_Extension *tw_dev, TW_Command_Full *full_comm
 		if (TW_SGL_OUT(oldcommand->opcode__sgloffset)) {
 			/* Load the sg list */
 			sgl = (TW_SG_Entry_ISO *)((u32 *)oldcommand+oldcommand->size - (sizeof(TW_SG_Entry_ISO)/4) + pae + (sizeof(dma_addr_t) > 4 ? 1 : 0));
-			sgl->address = TW_CPU_TO_SGL(dma_handle + sizeof(TW_Ioctl_Buf_Apache) - 1);
+			sgl->address = TW_CPU_TO_SGL(dma_handle + sizeof(TW_Ioctl_Buf_Apache));
 			sgl->length = TW_CPU_TO_SGL(length);
 			oldcommand->size += pae;
 			oldcommand->size += sizeof(dma_addr_t) > 4 ? 1 : 0;
@@ -748,7 +748,7 @@ static long twl_chrdev_ioctl(struct file *file, unsigned int cmd, unsigned long
 	data_buffer_length_adjusted = (driver_command.buffer_length + 511) & ~511;
 
 	/* Now allocate ioctl buf memory */
-	cpu_addr = dma_alloc_coherent(&tw_dev->tw_pci_dev->dev, data_buffer_length_adjusted+sizeof(TW_Ioctl_Buf_Apache) - 1, &dma_handle, GFP_KERNEL);
+	cpu_addr = dma_alloc_coherent(&tw_dev->tw_pci_dev->dev, data_buffer_length_adjusted + sizeof(TW_Ioctl_Buf_Apache), &dma_handle, GFP_KERNEL);
 	if (!cpu_addr) {
 		retval = -ENOMEM;
 		goto out2;
@@ -757,7 +757,7 @@ static long twl_chrdev_ioctl(struct file *file, unsigned int cmd, unsigned long
 	tw_ioctl = (TW_Ioctl_Buf_Apache *)cpu_addr;
 
 	/* Now copy down the entire ioctl */
-	if (copy_from_user(tw_ioctl, argp, driver_command.buffer_length + sizeof(TW_Ioctl_Buf_Apache) - 1))
+	if (copy_from_user(tw_ioctl, argp, driver_command.buffer_length + sizeof(TW_Ioctl_Buf_Apache)))
 		goto out3;
 
 	/* See which ioctl we are doing */
@@ -815,11 +815,11 @@ static long twl_chrdev_ioctl(struct file *file, unsigned int cmd, unsigned long
 	}
 
 	/* Now copy the entire response to userspace */
-	if (copy_to_user(argp, tw_ioctl, sizeof(TW_Ioctl_Buf_Apache) + driver_command.buffer_length - 1) == 0)
+	if (copy_to_user(argp, tw_ioctl, sizeof(TW_Ioctl_Buf_Apache) + driver_command.buffer_length) == 0)
 		retval = 0;
 out3:
 	/* Now free ioctl buf memory */
-	dma_free_coherent(&tw_dev->tw_pci_dev->dev, data_buffer_length_adjusted+sizeof(TW_Ioctl_Buf_Apache) - 1, cpu_addr, dma_handle);
+	dma_free_coherent(&tw_dev->tw_pci_dev->dev, data_buffer_length_adjusted + sizeof(TW_Ioctl_Buf_Apache), cpu_addr, dma_handle);
 out2:
 	mutex_unlock(&tw_dev->ioctl_lock);
 out:
diff --git a/drivers/scsi/3w-sas.h b/drivers/scsi/3w-sas.h
index b0508039a280..096dec29e2ac 100644
--- a/drivers/scsi/3w-sas.h
+++ b/drivers/scsi/3w-sas.h
@@ -335,7 +335,7 @@ typedef struct TAG_TW_Ioctl_Apache {
 	TW_Ioctl_Driver_Command driver_command;
 	char padding[488];
 	TW_Command_Full firmware_command;
-	char data_buffer[1];
+	char data_buffer[];
 } TW_Ioctl_Buf_Apache;
 
 /* GetParam descriptor */
@@ -344,7 +344,7 @@ typedef struct {
 	unsigned short	parameter_id;
 	unsigned short	parameter_size_bytes;
 	unsigned short  actual_parameter_size_bytes;
-	unsigned char	data[1];
+	unsigned char	data[];
 } TW_Param_Apache;
 
 /* Compatibility information structure */
-- 
2.34.1

