Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACEB67B8C0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 18:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236028AbjAYRke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 12:40:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235330AbjAYRkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 12:40:31 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7726532E44;
        Wed, 25 Jan 2023 09:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=In-Reply-To:Content-Type:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description; bh=L0W/ElxkwKW4ucK0Y8HMhZnAbZjnuN6zwjLdv7pdAe0=; b=WV1IO
        +XS2O3NbO6O/IJ+YF87kfBAmlxYnDihChz1noWeNHPuQ/mZ8IVj9xirEYdyi86odIMGg0jdhC1q9I
        p9wHSdOaa0PTd7zNq2Ge/HHcLKOYFpcLcDCFF1+ghqhzptj+zLlU5JtNAiEF1kLBj6VsN5ZsMyf6/
        HFM6Amfi5Hyfu45bIBTM98CG9w6IUelnzzWXWmz90WJ8SZOI586O1WrW+7TJfLTfeulhvcBCSjqRg
        lvFKMAyZNB52DtIAvwxQXckfg3ktOSpl/gcXm5XAlTS0Vwu3DJTFNPP4PB48QDmwLTHcxLghWpy1F
        9Z6O+6IiukC0DELVhm1FTXzwtR+8A==;
Received: from dougal.metanate.com ([192.168.88.1] helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <john@metanate.com>)
        id 1pKjkv-0004ra-9S;
        Wed, 25 Jan 2023 17:40:17 +0000
Date:   Wed, 25 Jan 2023 17:40:16 +0000
From:   John Keeping <john@metanate.com>
To:     Prashanth K <quic_prashk@quicinc.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Hofman <pavel.hofman@ivitera.com>,
        Joe Perches <joe@perches.com>, Julian Scheel <julian@jusst.de>,
        Colin Ian King <colin.i.king@gmail.com>,
        Pratham Pratap <quic_ppratap@quicinc.com>,
        Jack Pham <quic_jackp@quicinc.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] usb: gadget: f_uac2: Fix incorrect increment of
 bNumEndpoints
Message-ID: <Y9FpgKYmRR415dz9@donbot>
References: <1674631645-28888-1-git-send-email-quic_prashk@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1674631645-28888-1-git-send-email-quic_prashk@quicinc.com>
X-Authenticated: YES
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 12:57:25PM +0530, Prashanth K wrote:
> From: Pratham Pratap <quic_ppratap@quicinc.com>
> 
> Currently connect/disconnect of USB cable calls afunc_bind and
> eventually increments the bNumEndpoints. Performing multiple
> plugin/plugout will increment bNumEndpoints incorrectly, and on
> the next plug-in it leads to invalid configuration of descriptor
> and hence enumeration fails.
> 
> Fix this by resetting the value of bNumEndpoints to 1 on every
> afunc_bind call.
> 
> Fixes: 40c73b30546e ("usb: gadget: f_uac2: add adaptive sync support for capture")
> Signed-off-by: Pratham Pratap <quic_ppratap@quicinc.com>
> Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
> ---
> v3: Added Fixes tag.

Reviewed-by: John Keeping <john@metanate.com>

Is there a similar problem for std_ac_if_desc.bNumEndpoints ?  That
looks like it should be zero when no controls are enabled.

>  drivers/usb/gadget/function/f_uac2.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/gadget/function/f_uac2.c b/drivers/usb/gadget/function/f_uac2.c
> index 08726e4..0219cd7 100644
> --- a/drivers/usb/gadget/function/f_uac2.c
> +++ b/drivers/usb/gadget/function/f_uac2.c
> @@ -1142,6 +1142,7 @@ afunc_bind(struct usb_configuration *cfg, struct usb_function *fn)
>  		}
>  		std_as_out_if0_desc.bInterfaceNumber = ret;
>  		std_as_out_if1_desc.bInterfaceNumber = ret;
> +		std_as_out_if1_desc.bNumEndpoints = 1;
>  		uac2->as_out_intf = ret;
>  		uac2->as_out_alt = 0;
>  
> -- 
> 2.7.4
> 
