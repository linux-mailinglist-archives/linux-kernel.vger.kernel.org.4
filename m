Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01BCD633C42
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 13:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbiKVMSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 07:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbiKVMSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 07:18:18 -0500
Received: from smtp65.iad3b.emailsrvr.com (smtp65.iad3b.emailsrvr.com [146.20.161.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA444AF08
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 04:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1669119493;
        bh=/bHcV3q6ab13X+W7DfnSMXsXfRWiQ1Kg1aBJ9B4LJuM=;
        h=Date:Subject:To:From:From;
        b=SDOuKnd6rGqpu9VmMfaIpMyXR+wVJHB6yi2KqNMMIWGGZdE3S3GXKGdg4GJ8IBV8t
         6qg2tFPZfq6WpeSbxG9XwRV+KUFtxmrL2y+7xrlhhDlXqjpYqb4jn4PnB8TJfQLhRr
         d23mEqzpwtI7tF6KeuE9ivjadDZzDr01lDjzs1A4=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp9.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id BA7F7200AC;
        Tue, 22 Nov 2022 07:18:12 -0500 (EST)
Message-ID: <94fee07a-0ac4-fba7-23cb-0a9da42e25d0@mev.co.uk>
Date:   Tue, 22 Nov 2022 12:18:12 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] comedi: drivers: pcl730: Fix potential memory leak in
 pcl730_attach()
Content-Language: en-GB
To:     Shang XiaoJing <shangxiaojing@huawei.com>,
        hsweeten@visionengravers.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
References: <20221122120428.25069-1-shangxiaojing@huawei.com>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <20221122120428.25069-1-shangxiaojing@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: feb35fc1-cd6e-464e-a8b1-8c7877bce722-1-1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/2022 12:04, Shang XiaoJing wrote:
> pcl730_attach() calls comedi_request_region() and won't release the
> resource allocated by alloc_resource() when pcl730_attach() failed latter.
> Add release_region() to prevent memory leak.
> 
> Fixes: 6f9aa29b47f6 ("staging: comedi: pcl730: use comedi_request_region()")
> Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
> ---
>   drivers/comedi/drivers/pcl730.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/comedi/drivers/pcl730.c b/drivers/comedi/drivers/pcl730.c
> index d2733cd5383d..c463de8a14e1 100644
> --- a/drivers/comedi/drivers/pcl730.c
> +++ b/drivers/comedi/drivers/pcl730.c
> @@ -274,8 +274,14 @@ static int pcl730_attach(struct comedi_device *dev,
>   		return ret;
>   
>   	ret = comedi_alloc_subdevices(dev, board->n_subdevs);
> -	if (ret)
> +	if (ret) {
> +		if (dev->iobase && dev->iolen) {
> +			release_region(dev->iobase, dev->iolen);
> +			dev->iobase = 0;
> +			dev->iolen = 0;
> +		}
>   		return ret;
> +	}
>   
>   	subdev = 0;
>   

This is not needed.  If the 'attach' handler pcl730_attach() returns an 
error, the 'detach' handler comedi_legacy_detach() will be called to 
clean up the allocated resources.  All the comedi drivers work that way. 
(A lot of them have an 'auto_attach' handler instead of an 'attach' 
handler, but the error handling is basically the same.)

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-

