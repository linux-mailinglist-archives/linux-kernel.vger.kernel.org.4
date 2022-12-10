Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3644648F9F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 17:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiLJQGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 11:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiLJQGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 11:06:09 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8398E186F7;
        Sat, 10 Dec 2022 08:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1670688347; bh=UAb7ldzD3tHL8gu70PvIFz+mnBkn1chzH5limOUuYsw=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=WC2+qGRnwHZeYHj5Lb3TMBeX6YsRFoGp7XIIcgj0vs7SLPLznN9XD7OfcCU2205xN
         Y09Dmv0KPPsz7T1O13liVhUY8naXDHusFEd/jd81W9EuwqysBrb830Yqfc2Md2mNow
         NRXfcX0AFA3kfrHYfY6yzpFgnKOdLi8rp+h72uMiNGVVWrRbjF6GzaYAfYnx8zSMTt
         IPh3KGoWEIA16briH6q+H+HCzvXfm/a+e342AA7vu/1T6M+NWJQyKav7bpUaEuK0q5
         9SySa5jbhsTnnso/KxY79u/NOfWzDZfGl9XAd25YNhwJono3Ulto6i67OYG/zcrWoZ
         BtEHIwjwELNYg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([92.116.157.120]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MZCbB-1pQMZO2pyj-00VC2f; Sat, 10
 Dec 2022 17:05:47 +0100
Message-ID: <cb19a577-0778-1d85-2c74-b92166038288@gmx.de>
Date:   Sat, 10 Dec 2022 17:05:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 1/2] video: fbdev: uvesafb: Fixes an error handling
 path in uvesafb_probe()
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Michal Januszewski <spock@gentoo.org>,
        Antonino Daplas <adaplas@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <0eba6acb70fa1270d8cf798afd11ce342aa7e8e1.1670671944.git.christophe.jaillet@wanadoo.fr>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <0eba6acb70fa1270d8cf798afd11ce342aa7e8e1.1670671944.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1o0OJtIJZku0ozeLcuTXLOKqT55qfyBM1PV7jFRQE5NXzjsCr3Z
 L3vzE56cLZM7CtCF9CgQ1mcJMrrGwXTViEpUllTnt86x86KwI1IhpNdnZTZgZHWy4P4z1Cf
 DslrD3dCaPmQxZ7c4Us1R95WSrJ3ehA3Ro2K4V97OnWr4l/7YTagm74HEUnEePm+7aodL68
 kfepUdky5+wCDez/wqPaQ==
UI-OutboundReport: notjunk:1;M01:P0:Dfdv0cAgnqM=;ceBKxw3nJHiyNW0GOq19wXaz+T+
 IEX2ydSfMEW3GfAXqh8rrZZSeU/+OqdKpweZbUty3Pg+aWNDoF3pYikaqVDPhy1PBFQa+UJ5q
 z8MzgFaFETf+PhjUwSJfhdEGzkpmyqmNVgK7D0yy99Us9r9RJrvnneliDx7MvwZdnuR/bnU9/
 eOipAs4AKF6AAiz1nrDNnpVPtnsjc6+AE/iXKxuRJBgNzy4E0+/qf5X17y5XRU2ZrZVgvfRt0
 WME9inKV5g4kgTs2Td0w+xlfDmyNGQrQFOpZI1ksoDqwbp2SKJYgLFtn18bkciJ0bNLsU91mF
 QBdryFjI+iu5s6XJdl9G4YA8W821cf2L25gtiYJSr1URGKBDEIC9mZkdENvS0jJD4NKk1KA8j
 DAmiFxyulAYnmkkPHD9S5Z7cj5+hRddJ2fX0tCtNq1aflOFpKKcAAFPOX3auENDOSHZaDgtNE
 h5fLhEtuASOp69Zy5vVlDPvBaUmkPTiEm643vusw+OK+lFD+mmkvJ7xQkqR7kFHshlMOW7oBa
 Snyi7XG5oXG3hD1bTbhvUEAHf00teKhXyqkAlrra1C1Q8OEb8evyhF1ahnLsQYgP2kWU2YKiY
 8lcIN+Aw3WLmzXl6qbd3M+TaqWtfKmF6+gba/hTd4DWLqKEXewqkzOb48cbdcuYpHIZL7uBRF
 NJfbCTzWuYLNCJG+2HVx4a9Sa+IYWm4lvNvs4e1gcBX5oYQU70WZhn0rBqL3ll/ZpkO8T8txJ
 7RwAw/+A1N35QV7ubhY1k5yiidFZxBGZk+YsdpGrdoXJ5nd3j9MSS9F/DqzB5VhNvwQxiyXr0
 4w7fWdNTgfDc/mxhcU/B+UfNcbY25lctAXHWl9NCtOhqIilrqXQcULhn8RogjKI8D6HIl7m0c
 L7neJHT2FR30rL9h57rbM8tbl3eLaECMFWIJvGZC51bsS1IDt2BnsGEACw5WQDyPatZ0Ri+j+
 Fb4lnuEdg+kOzLOq6dPrT7zaZHE=
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/22 12:35, Christophe JAILLET wrote:
> If an error occurs after a successful uvesafb_init_mtrr() call, it must =
be
> undone by a corresponding arch_phys_wc_del() call, as already done in th=
e
> remove function.
>
> This has been added in the remove function in commit 63e28a7a5ffc
> ("uvesafb: Clean up MTRR code")
>
> Fixes: 8bdb3a2d7df4 ("uvesafb: the driver core")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Both patches applied.
Thanks!
Helge


> ---
> Unsure about the Fixes tag, maybe it is 63e28a7a5ffc
>
> Change in v2:
>    - add arch_phys_wc_del() at the right place in the error handling pat=
h
>
> v1 (a long time ago!):
> https://lore.kernel.org/all/dd2a4806d3a570ab84947806f38a494454fd0245.162=
2994310.git.christophe.jaillet@wanadoo.fr/
> ---
>   drivers/video/fbdev/uvesafb.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/video/fbdev/uvesafb.c b/drivers/video/fbdev/uvesafb=
.c
> index 00d789b6c0fa..0e3cabbec4b4 100644
> --- a/drivers/video/fbdev/uvesafb.c
> +++ b/drivers/video/fbdev/uvesafb.c
> @@ -1758,6 +1758,7 @@ static int uvesafb_probe(struct platform_device *d=
ev)
>   out_unmap:
>   	iounmap(info->screen_base);
>   out_mem:
> +	arch_phys_wc_del(par->mtrr_handle);
>   	release_mem_region(info->fix.smem_start, info->fix.smem_len);
>   out_reg:
>   	release_region(0x3c0, 32);

