Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F536D1BD8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjCaJSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjCaJSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:18:34 -0400
X-Greylist: delayed 3301 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 31 Mar 2023 02:18:11 PDT
Received: from 7of9.schinagl.nl (7of9.connected.by.freedominter.net [185.238.129.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385974691;
        Fri, 31 Mar 2023 02:18:11 -0700 (PDT)
Received: from [10.2.12.76] (unknown [10.2.12.76])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by 7of9.schinagl.nl (Postfix) with ESMTPSA id A09A318BAEF4;
        Fri, 31 Mar 2023 10:12:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schinagl.nl; s=7of9;
        t=1680250351; bh=QpypCl+gi6eZXlgEKjMDUcBtOKgQfLWBPF+SVmhU6bk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=pwdUJlOI5KDI5b+KwS+9DhH57kCHmeLCeNWwFgMpC0WbyagUPfZ2FeEiBQ5UezgFb
         EsW+Uk7H5mQySSxxq5ywmWaY0Se4RXaNuZZUlAoIcxeTkX3dw5s7mr3j8fhvPUGdYL
         FDxXaTWq7KeajyRW18eO7N+2Df/HcFf071GbU/u8=
Message-ID: <3a348abc-d1f3-364f-88de-a0012fbc0fde@schinagl.nl>
Date:   Fri, 31 Mar 2023 10:12:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v1 1/2] iopoll: Introduce ioreadXX_poll_timeout() macros
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
References: <20230330141413.25569-1-andriy.shevchenko@linux.intel.com>
Content-Language: nl, en-US
From:   Olliver Schinagl <oliver@schinagl.nl>
In-Reply-To: <20230330141413.25569-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Andy,

On 30-03-2023 16:14, Andy Shevchenko wrote:
> From: Olliver Schinagl <oliver@schinagl.nl>
>
> There are users in the Linux kernel that would benefit from using
> ioreadXX_poll_timeout() macros, such as ioread32_poll_timeout().
> Introduce those macros.
>
> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> Co-developed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   include/linux/iopoll.h | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
>
> diff --git a/include/linux/iopoll.h b/include/linux/iopoll.h
> index 2c8860e406bd..30ba609175a7 100644
> --- a/include/linux/iopoll.h
> +++ b/include/linux/iopoll.h
> @@ -140,6 +140,7 @@
>   #define readx_poll_timeout_atomic(op, addr, val, cond, delay_us, timeout_us) \
>   	read_poll_timeout_atomic(op, val, cond, delay_us, timeout_us, false, addr)
>   
> +/* readX() */
>   #define readb_poll_timeout(addr, val, cond, delay_us, timeout_us) \
>   	readx_poll_timeout(readb, addr, val, cond, delay_us, timeout_us)
>   
> <snip>
>   #endif /* _LINUX_IOPOLL_H */
Thanks for re-posting this? (I don't recall If I actually posted the 
first time around).

But I actually have a small addendum for this series, as it will break 
`drivers/net/wwan/t7xx/t7xx_dpmaif.c` due to a redefinition (yeah I know).

So I have:
https://gitlab.com/olliver/linux/-/commit/c9e591f2dabb2dbaeceebee61fa70b70fdbffc2a
https://gitlab.com/olliver/linux/-/commit/41e0f8c08a1c55940813a240215910336ad7bec2
https://gitlab.com/olliver/linux/-/commit/f36562f09b0185d403415864ef7218b46a742cdc
https://gitlab.com/olliver/linux/-/commit/66237fd97bc42d272602b01dc0cca541c619b2be

Which actually replaces silly calls like readx_poll_timeout(ioread32, ... .

Do you want me to (re-?)post this as a series? I can put your 
thunderbolt (and your changes here) and post as one big series (or you 
can do the same obviously).

Olliver

