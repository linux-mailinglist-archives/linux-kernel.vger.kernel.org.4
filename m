Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089E569934C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 12:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjBPLij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 06:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjBPLif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 06:38:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF882E817;
        Thu, 16 Feb 2023 03:38:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87E6361F9F;
        Thu, 16 Feb 2023 11:38:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90770C433D2;
        Thu, 16 Feb 2023 11:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676547507;
        bh=IgLvEAnt3Q5xYx31yPgFRCpM7tgpgukDaRM4GqCEOSg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=03GjF6qGTU6OMxSKdYqn3nHUKTwuhWvDH34WiFHrGL972s2sqRZYlnqKCjNouJAF+
         Yijl3T+PKcpJklfeJ8hB3R6hQHd57cqGq5Jh5bN725Q/tfS8oR3AWKJLZ0aPZDnA1o
         3dmBsOPSlU6vgGRhRLTve5npSoF1mKeDMG1jCFXY=
Date:   Thu, 16 Feb 2023 12:38:25 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     David Sands <david.sands@biamp.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        david.sands3@gmail.com
Subject: Re: [RFC] usb: gadget: f_fs: add capability for dfu run-time
 descriptor
Message-ID: <Y+4Vsca6gYHuePez@kroah.com>
References: <20230215010558.1114445-1-david.sands@biamp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230215010558.1114445-1-david.sands@biamp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 11:05:58AM +1000, David Sands wrote:
> Add the ability for FunctionFS driver to be able to create DFU Run-Time
> descriptors.
> 
> Signed-off-by: David Sands <david.sands@biamp.com>
> ---
>  drivers/usb/gadget/function/f_fs.c  | 12 ++++++++++--
>  include/uapi/linux/usb/ch9.h        |  4 ++++
>  include/uapi/linux/usb/functionfs.h | 10 ++++++++++
>  3 files changed, 24 insertions(+), 2 deletions(-)

Ah, DFU, bad memories (hint, my name is on that spec...)

Why is this a RFC?  What needs to be done on this to make it "real"?


> 
> diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
> index 73dc10a77cde..ac77ded9e6ad 100644
> --- a/drivers/usb/gadget/function/f_fs.c
> +++ b/drivers/usb/gadget/function/f_fs.c
> @@ -2049,7 +2049,7 @@ typedef int (*ffs_os_desc_callback)(enum ffs_os_desc_type entity,
>  
>  static int __must_check ffs_do_single_desc(char *data, unsigned len,
>  					   ffs_entity_callback entity,
> -					   void *priv, int *current_class)
> +					   void *priv, int *current_class, int *current_subclass)
>  {
>  	struct usb_descriptor_header *_ds = (void *)data;
>  	u8 length;
> @@ -2108,6 +2108,7 @@ static int __must_check ffs_do_single_desc(char *data, unsigned len,
>  		if (ds->iInterface)
>  			__entity(STRING, ds->iInterface);
>  		*current_class = ds->bInterfaceClass;
> +		*current_subclass = ds->bInterfaceSubClass;
>  	}
>  		break;
>  
> @@ -2132,6 +2133,12 @@ static int __must_check ffs_do_single_desc(char *data, unsigned len,
>  			if (length != sizeof(struct ccid_descriptor))
>  				goto inv_length;
>  			break;
> +		} else if (*current_class == USB_CLASS_APP_SPEC &&
> +				*current_subclass == USB_SUBCLASS_DFU) {
> +			pr_vdebug("dfu functional descriptor\n");
> +			if (length != sizeof(struct usb_dfu_functional_descriptor))
> +				goto inv_length;
> +			break;
>  		} else {
>  			pr_vdebug("unknown descriptor: %d for class %d\n",
>  			      _ds->bDescriptorType, *current_class);
> @@ -2194,6 +2201,7 @@ static int __must_check ffs_do_descs(unsigned count, char *data, unsigned len,
>  	const unsigned _len = len;
>  	unsigned long num = 0;
>  	int current_class = -1;
> +	int current_subclass = -1;
>  
>  	ENTER();
>  
> @@ -2215,7 +2223,7 @@ static int __must_check ffs_do_descs(unsigned count, char *data, unsigned len,
>  			return _len - len;
>  
>  		ret = ffs_do_single_desc(data, len, entity, priv,
> -			&current_class);
> +			&current_class, &current_subclass);
>  		if (ret < 0) {
>  			pr_debug("%s returns %d\n", __func__, ret);
>  			return ret;
> diff --git a/include/uapi/linux/usb/ch9.h b/include/uapi/linux/usb/ch9.h
> index 31fcfa084e63..4683b3b508c7 100644
> --- a/include/uapi/linux/usb/ch9.h
> +++ b/include/uapi/linux/usb/ch9.h
> @@ -266,6 +266,9 @@ struct usb_ctrlrequest {
>  /* From the USB 3.1 spec */
>  #define	USB_DT_SSP_ISOC_ENDPOINT_COMP	0x31
>  
> +/* From USB Device Firmware Upgrade Specification, Revision 1.1 */
> +#define USB_DT_DFU_FUNCTIONAL		0x21
> +
>  /* Conventional codes for class-specific descriptors.  The convention is
>   * defined in the USB "Common Class" Spec (3.11).  Individual class specs
>   * are authoritative for their usage, not the "common class" writeup.
> @@ -335,6 +338,7 @@ struct usb_device_descriptor {
>  #define USB_CLASS_VENDOR_SPEC		0xff
>  
>  #define USB_SUBCLASS_VENDOR_SPEC	0xff
> +#define USB_SUBCLASS_DFU		0x01
>  
>  /*-------------------------------------------------------------------------*/
>  
> diff --git a/include/uapi/linux/usb/functionfs.h b/include/uapi/linux/usb/functionfs.h
> index d77ee6b65328..3d15b193b260 100644
> --- a/include/uapi/linux/usb/functionfs.h
> +++ b/include/uapi/linux/usb/functionfs.h
> @@ -37,6 +37,16 @@ struct usb_endpoint_descriptor_no_audio {
>  	__u8  bInterval;
>  } __attribute__((packed));
>  
> +/* DFU Functional descriptor */
> +struct usb_dfu_functional_descriptor {
> +	__u8  bLength;
> +	__u8  bDescriptorType;
> +	__u8  bmAttributes;

Did you forget bEndpointAddress?

I can't remember if that is needed or not, but without it, it's an odd
layout of this structure.

thanks,

greg k-h
