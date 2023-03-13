Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE7F6B80E9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjCMSli convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 13 Mar 2023 14:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjCMSlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:41:32 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D842CA31;
        Mon, 13 Mar 2023 11:40:53 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1pbn4r-001niP-J4; Mon, 13 Mar 2023 19:39:21 +0100
Received: from p57bd9bc2.dip0.t-ipconnect.de ([87.189.155.194] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1pbn4r-001kJz-C0; Mon, 13 Mar 2023 19:39:21 +0100
Message-ID: <a23e10f1cf957d0e6096b3a7ca0b7298263c9757.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 17/36] sh: intc: move to use bus_get_dev_root()
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Date:   Mon, 13 Mar 2023 19:39:20 +0100
In-Reply-To: <20230313182918.1312597-17-gregkh@linuxfoundation.org>
References: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
         <20230313182918.1312597-17-gregkh@linuxfoundation.org>
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
>  drivers/sh/intc/userimask.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/sh/intc/userimask.c b/drivers/sh/intc/userimask.c
> index f9f043a3d90a..abe9091827cd 100644
> --- a/drivers/sh/intc/userimask.c
> +++ b/drivers/sh/intc/userimask.c
> @@ -61,10 +61,18 @@ static DEVICE_ATTR(userimask, S_IRUSR | S_IWUSR,
>  
>  static int __init userimask_sysdev_init(void)
>  {
> +	struct device *dev_root;
> +	int ret = 0;
> +
>  	if (unlikely(!uimask))
>  		return -ENXIO;
>  
> -	return device_create_file(intc_subsys.dev_root, &dev_attr_userimask);
> +	dev_root = bus_get_dev_root(&intc_subsys);
> +	if (dev_root) {
> +		ret = device_create_file(dev_root, &dev_attr_userimask);
> +		put_device(dev_root);
> +	}
> +	return ret;
>  }
>  late_initcall(userimask_sysdev_init);
>  

Acked-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
