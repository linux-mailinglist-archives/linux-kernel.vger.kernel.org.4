Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05287618C92
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 00:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbiKCXJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 19:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbiKCXI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 19:08:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD1D248EA;
        Thu,  3 Nov 2022 16:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=clKkeoKrdbqYUCowN689hiIMqlAcNW5umpiu0Sqmz2c=; b=E1EfVe1a3THuchRWxlk/PQPY4L
        DjOuds0LKYgzZbJ7jBNpTzlupfw5xTi107KmdXmFEI4ipV90kN7tR9m5qu6XZy+RDq+twoHIYTJ5F
        3irq8BoqhEhTV35E0Qa0M3NA0OuqrcRf7FuFasX6IZBydyRuYPcBGAw/Qhsa1IHYNa6iAq+cGBUp7
        NJt4PFJppliDn2+RMmERJQxBDVIMLm+81DvhkyuzGG58QYiypON85116aenrk4JT9tWmCrmP5eAYy
        QRpqB17siwEZnvohzvbnMZMAFVffUtDte19vKcCodIZMH1o0R7FSLK+8YTMGMqQRW7A+tF308G58R
        knp5FIkw==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oqjJf-001wZi-20; Thu, 03 Nov 2022 23:08:07 +0000
Message-ID: <c5ae56d9-e07c-2ca7-6f42-640c330b5d78@infradead.org>
Date:   Thu, 3 Nov 2022 16:08:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] staging: rtl8192e: Fix divide fault when calculating
 beacon age
Content-Language: en-US
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
References: <20221103200507.14304-1-Larry.Finger@lwfinger.net>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20221103200507.14304-1-Larry.Finger@lwfinger.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/3/22 13:05, Larry Finger wrote:
> When the configuration parameter CONFIG_HZ is less that 100, the compiler
> generates an error as follows:
> 
> ../drivers/staging/rtl8192e/rtllib_wx.c: In function 'rtl819x_translate_scan':
> ../drivers/staging/rtl8192e/rtllib_wx.c:220:57: warning: division by zero [-Wdiv-by-zero]
>   220 |                       (jiffies - network->last_scanned) / (HZ / 100));
>       |                                                         ^
> In file included from ../include/linux/skbuff.h:45,
>                  from ../include/linux/if_ether.h:19,
>                  from ../include/linux/etherdevice.h:20,
>                  from ../drivers/staging/rtl8192e/rtllib_wx.c:18:
> ../drivers/staging/rtl8192e/rtllib_wx.c: In function 'rtllib_wx_get_scan':
> ../drivers/staging/rtl8192e/rtllib_wx.c:261:70: warning: division by zero [-Wdiv-by-zero]
>   261 |                                    (jiffies - network->last_scanned) /
>       |
> 
> In fact, is HZ is not a multiple of 100, the calculation will be wrong, but it
> will compile correctly.
> 
> The fix is to get rid of the (HZ / 100) portion. To decrease any round-off
> errors, the compiler is forced to perform the 100 * jiffies-difference before
> dividing by HX. This patch is only compile tested.

              HZ.

> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  drivers/staging/rtl8192e/rtllib_wx.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtllib_wx.c b/drivers/staging/rtl8192e/rtllib_wx.c
> index da2c41c9b92f..7013425102dd 100644
> --- a/drivers/staging/rtl8192e/rtllib_wx.c
> +++ b/drivers/staging/rtl8192e/rtllib_wx.c
> @@ -217,7 +217,7 @@ static inline char *rtl819x_translate_scan(struct rtllib_device *ieee,
>  	p = custom;
>  	p += scnprintf(p, MAX_CUSTOM_LEN - (p - custom),
>  		      " Last beacon: %lums ago",
> -		      (jiffies - network->last_scanned) / (HZ / 100));
> +		      (100 *(jiffies - network->last_scanned)) / HZ);

                      (100 * (jiffies ...

>  	iwe.u.data.length = p - custom;
>  	if (iwe.u.data.length)
>  		start = iwe_stream_add_point_rsl(info, start, stop,
> @@ -258,8 +258,8 @@ int rtllib_wx_get_scan(struct rtllib_device *ieee,
>  				   escape_essid(network->ssid,
>  						network->ssid_len),
>  				   network->bssid,
> -				   (jiffies - network->last_scanned) /
> -				   (HZ / 100));
> +				   (100 * (jiffies - network->last_scanned)) /
> +				   HZ);
>  	}
>  
>  	spin_unlock_irqrestore(&ieee->lock, flags);

-- 
~Randy
