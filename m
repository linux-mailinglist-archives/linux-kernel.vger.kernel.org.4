Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE74765F319
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 18:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235096AbjAERr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 12:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234237AbjAERrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 12:47:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6684C734;
        Thu,  5 Jan 2023 09:47:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 42CA7B81B83;
        Thu,  5 Jan 2023 17:47:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C73C433D2;
        Thu,  5 Jan 2023 17:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672940868;
        bh=QalbsF+xuCr6irdBvTcOAewjg1oMUswJseJlMj7wYME=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lyeCJldLLFWMeZtHKleORXR5QoNua/yZwxbz6Uhu1CsN92Ixe4BHD43KvlpA/JLZ4
         hHhzu8vQzRC36BE1VthrhVJkYfIz4AEmKH3ak9spnkRlhpmMYEifrnEDwwv6Qc02C/
         Ogf0SCvqK1XzDfNns+FWO5go+jC4dI3tXW2NGkmGRfOx0R5aC/RVo3fJcDlS7u1uFF
         LJ4loZWHKelDNE2d4cvWpPVazesgWO497s0uFlfBGGEMdXZUrKg+BwdpNb0gPnNIMA
         jDpu1r7yN/6VgE2womlzzst2S4MvLpY8PAD2vCwnvJ1BVVZcsc71DfO5FjQGr0fUqf
         8PCI64sMPy8mw==
Date:   Thu, 5 Jan 2023 11:47:53 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Adam Radford <aradford@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: 3w-sas: Replace 1-element arrays with flexible
 array members
Message-ID: <Y7cNSXnO8yBY5OP8@work>
References: <20230105004757.never.017-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105004757.never.017-kees@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 04:48:01PM -0800, Kees Cook wrote:
> One-element arrays (and multi-element arrays being treated as
> dynamically sized) are deprecated[1] and are being replaced with
> flexible array members in support of the ongoing efforts to tighten the
> FORTIFY_SOURCE routines on memcpy(), correctly instrument array indexing
> with UBSAN_BOUNDS, and to globally enable -fstrict-flex-arrays=3.
> 
> Replace one-element arrays with flexible-array member in TW_Ioctl_Buf_Apache
> and TW_Param_Apache, adjusting the explicit sizing calculations at the
> same time.
> 
> This results in no differences in binary output.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays
> 
> Cc: Adam Radford <aradford@gmail.com>
> Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: linux-scsi@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

This is great. :) It's quite similar to this other commit:

	44c5027bb5c8 ("scsi: 3w-9xxx: Use flexible array members to avoid struct padding")

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
--
Gustavo

> ---
>  drivers/scsi/3w-sas.c | 12 ++++++------
>  drivers/scsi/3w-sas.h |  4 ++--
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/scsi/3w-sas.c b/drivers/scsi/3w-sas.c
> index 3ebe66151dcb..f41c93454f0c 100644
> --- a/drivers/scsi/3w-sas.c
> +++ b/drivers/scsi/3w-sas.c
> @@ -690,7 +690,7 @@ static void twl_load_sgl(TW_Device_Extension *tw_dev, TW_Command_Full *full_comm
>  		newcommand->request_id__lunl =
>  			cpu_to_le16(TW_REQ_LUN_IN(TW_LUN_OUT(newcommand->request_id__lunl), request_id));
>  		if (length) {
> -			newcommand->sg_list[0].address = TW_CPU_TO_SGL(dma_handle + sizeof(TW_Ioctl_Buf_Apache) - 1);
> +			newcommand->sg_list[0].address = TW_CPU_TO_SGL(dma_handle + sizeof(TW_Ioctl_Buf_Apache));
>  			newcommand->sg_list[0].length = TW_CPU_TO_SGL(length);
>  		}
>  		newcommand->sgl_entries__lunh =
> @@ -702,7 +702,7 @@ static void twl_load_sgl(TW_Device_Extension *tw_dev, TW_Command_Full *full_comm
>  		if (TW_SGL_OUT(oldcommand->opcode__sgloffset)) {
>  			/* Load the sg list */
>  			sgl = (TW_SG_Entry_ISO *)((u32 *)oldcommand+oldcommand->size - (sizeof(TW_SG_Entry_ISO)/4) + pae + (sizeof(dma_addr_t) > 4 ? 1 : 0));
> -			sgl->address = TW_CPU_TO_SGL(dma_handle + sizeof(TW_Ioctl_Buf_Apache) - 1);
> +			sgl->address = TW_CPU_TO_SGL(dma_handle + sizeof(TW_Ioctl_Buf_Apache));
>  			sgl->length = TW_CPU_TO_SGL(length);
>  			oldcommand->size += pae;
>  			oldcommand->size += sizeof(dma_addr_t) > 4 ? 1 : 0;
> @@ -748,7 +748,7 @@ static long twl_chrdev_ioctl(struct file *file, unsigned int cmd, unsigned long
>  	data_buffer_length_adjusted = (driver_command.buffer_length + 511) & ~511;
>  
>  	/* Now allocate ioctl buf memory */
> -	cpu_addr = dma_alloc_coherent(&tw_dev->tw_pci_dev->dev, data_buffer_length_adjusted+sizeof(TW_Ioctl_Buf_Apache) - 1, &dma_handle, GFP_KERNEL);
> +	cpu_addr = dma_alloc_coherent(&tw_dev->tw_pci_dev->dev, data_buffer_length_adjusted + sizeof(TW_Ioctl_Buf_Apache), &dma_handle, GFP_KERNEL);
>  	if (!cpu_addr) {
>  		retval = -ENOMEM;
>  		goto out2;
> @@ -757,7 +757,7 @@ static long twl_chrdev_ioctl(struct file *file, unsigned int cmd, unsigned long
>  	tw_ioctl = (TW_Ioctl_Buf_Apache *)cpu_addr;
>  
>  	/* Now copy down the entire ioctl */
> -	if (copy_from_user(tw_ioctl, argp, driver_command.buffer_length + sizeof(TW_Ioctl_Buf_Apache) - 1))
> +	if (copy_from_user(tw_ioctl, argp, driver_command.buffer_length + sizeof(TW_Ioctl_Buf_Apache)))
>  		goto out3;
>  
>  	/* See which ioctl we are doing */
> @@ -815,11 +815,11 @@ static long twl_chrdev_ioctl(struct file *file, unsigned int cmd, unsigned long
>  	}
>  
>  	/* Now copy the entire response to userspace */
> -	if (copy_to_user(argp, tw_ioctl, sizeof(TW_Ioctl_Buf_Apache) + driver_command.buffer_length - 1) == 0)
> +	if (copy_to_user(argp, tw_ioctl, sizeof(TW_Ioctl_Buf_Apache) + driver_command.buffer_length) == 0)
>  		retval = 0;
>  out3:
>  	/* Now free ioctl buf memory */
> -	dma_free_coherent(&tw_dev->tw_pci_dev->dev, data_buffer_length_adjusted+sizeof(TW_Ioctl_Buf_Apache) - 1, cpu_addr, dma_handle);
> +	dma_free_coherent(&tw_dev->tw_pci_dev->dev, data_buffer_length_adjusted + sizeof(TW_Ioctl_Buf_Apache), cpu_addr, dma_handle);
>  out2:
>  	mutex_unlock(&tw_dev->ioctl_lock);
>  out:
> diff --git a/drivers/scsi/3w-sas.h b/drivers/scsi/3w-sas.h
> index b0508039a280..096dec29e2ac 100644
> --- a/drivers/scsi/3w-sas.h
> +++ b/drivers/scsi/3w-sas.h
> @@ -335,7 +335,7 @@ typedef struct TAG_TW_Ioctl_Apache {
>  	TW_Ioctl_Driver_Command driver_command;
>  	char padding[488];
>  	TW_Command_Full firmware_command;
> -	char data_buffer[1];
> +	char data_buffer[];
>  } TW_Ioctl_Buf_Apache;
>  
>  /* GetParam descriptor */
> @@ -344,7 +344,7 @@ typedef struct {
>  	unsigned short	parameter_id;
>  	unsigned short	parameter_size_bytes;
>  	unsigned short  actual_parameter_size_bytes;
> -	unsigned char	data[1];
> +	unsigned char	data[];
>  } TW_Param_Apache;
>  
>  /* Compatibility information structure */
> -- 
> 2.34.1
> 
