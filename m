Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0146B8118
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbjCMSsP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 13 Mar 2023 14:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbjCMSsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:48:06 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE5386178;
        Mon, 13 Mar 2023 11:47:43 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1pbn3b-001n3P-9h; Mon, 13 Mar 2023 19:38:03 +0100
Received: from p57bd9bc2.dip0.t-ipconnect.de ([87.189.155.194] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1pbn3b-001k6k-2d; Mon, 13 Mar 2023 19:38:03 +0100
Message-ID: <0343d84733bcda9a36bb7329165ae03f0d8ba759.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 16/36] sh: dma-sysfs: move to use bus_get_dev_root()
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Date:   Mon, 13 Mar 2023 19:38:02 +0100
In-Reply-To: <20230313182918.1312597-16-gregkh@linuxfoundation.org>
References: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
         <20230313182918.1312597-16-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.155.194
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-03-13 at 19:28 +0100, Greg Kroah-Hartman wrote:
> Direct access to the struct bus_type dev_root pointer is going away soon
> so replace that with a call to bus_get_dev_root() instead, which is what
> it is there for.
> 
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: linux-sh@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> Note, this is a patch that is a prepatory cleanup as part of a larger
> series of patches that is working on resolving some old driver core
> design mistakes.  It will build and apply cleanly on top of 6.3-rc2 on
> its own, but I'd prefer if I could take it through my driver-core tree
> so that the driver core changes can be taken through there for 6.4-rc1.
> 
>  arch/sh/drivers/dma/dma-sysfs.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/sh/drivers/dma/dma-sysfs.c b/arch/sh/drivers/dma/dma-sysfs.c
> index 8ef318150f84..431bc18f0a41 100644
> --- a/arch/sh/drivers/dma/dma-sysfs.c
> +++ b/arch/sh/drivers/dma/dma-sysfs.c
> @@ -45,13 +45,19 @@ static DEVICE_ATTR(devices, S_IRUGO, dma_show_devices, NULL);
>  
>  static int __init dma_subsys_init(void)
>  {
> +	struct device *dev_root;
>  	int ret;
>  
>  	ret = subsys_system_register(&dma_subsys, NULL);
>  	if (unlikely(ret))
>  		return ret;
>  
> -	return device_create_file(dma_subsys.dev_root, &dev_attr_devices);
> +	dev_root = bus_get_dev_root(&dma_subsys);
> +	if (dev_root) {
> +		ret = device_create_file(dev_root, &dev_attr_devices);
> +		put_device(dev_root);
> +	}
> +	return ret;
>  }
>  postcore_initcall(dma_subsys_init);
>  

Acked-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
