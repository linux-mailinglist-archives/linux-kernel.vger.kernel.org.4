Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4EF56BD0E8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 14:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjCPNew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 09:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjCPNeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 09:34:50 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BE97C3F2;
        Thu, 16 Mar 2023 06:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1678973683; i=deller@gmx.de;
        bh=dw+iQ9rvbmABYoF8/RwO4zPaytP0u+W8BAyDnWXpy1k=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Q2b/FtZ4mX1JXBx8y442QEyA2bBCKyd5kx1RxudwesxblfO4VQSThZ3Omfl7vrmtH
         zqLmuSlH/b2AJHKA93Aqk14PPFCwHtLiDByp7BNsN4w02dwQ2Yi0o0033ve5dxTxY7
         RLswatRo0yEumduLLP/kJSH/7ZnsOv3m2KwZp+FPeUwRU/1vsIs/UWtaFVhby5+z/b
         Wivt9kFuIFc1K0d3Yhd7xx6yF9L8PwOzcDLTT3E0tY08CG/ohX9g5F6b0VUeiSR9GG
         +HuQjusIiDVwX46IocWmPfJ+wZbUbKqUtO/+1/bpGOWN+oTBdUX7t+8Hb7YdY3ixRl
         AXbmr/2nlij+Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.149.95]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2O2W-1pfXqP0ggw-003rqR; Thu, 16
 Mar 2023 14:34:43 +0100
Message-ID: <78ea59ba-72ab-db50-4d66-b1ad84ed8548@gmx.de>
Date:   Thu, 16 Mar 2023 14:34:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] fbdev: nvidia: Fix potential divide by zero
Content-Language: en-US
To:     Wei Chen <harperchen1110@gmail.com>, adaplas@gmail.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230315071831.3833948-1-harperchen1110@gmail.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20230315071831.3833948-1-harperchen1110@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fNcJl7Z4HC0lzHljP7pqiCwEqkxUbZX9jGfP/jXuGbZOznQr4wP
 FCYe1fz3OyoZkdYeKa47XD/CvxIV6sltPRf9R9krQJEffpSt6hM7kWBzit9up59T+Qy6jmN
 Fi4tFOYgxI5OunqqnT81g0r2p/BDQ2NkD2YEXEC4nEI/ML04TkKwLArJLR0J9jE26+7k+Mt
 mW+3QVTBJY+a3/SEHyjwA==
UI-OutboundReport: notjunk:1;M01:P0:13xPqJdiFKY=;w7KyePPl+2LLpb5kyifOh3wr6eA
 NRSZVIvZ0pHrmjRyp2MDB/vkUmB+uqpaS/pCGZiobLgwenlQ29z16esekj2kqUCdgB2+nOS7L
 55SgUu574/c7fS0BV0jhM37Bu37H7iXOekPBgVgpoOGOl+8Qhh3IBcbNyXld8CJayZ7xy+UPv
 tSIdYW+WU1u3zWi7rpEoQJaNBtjDijE34kZkh9ZWn5ixHCRS4VQdtP/xCKVFROemqfVM6BuO8
 GHHE76J37/eBuQE8wS3kVZikrYbd2iUk4leXpgkQ3ja+SpkRZ/ACO+HMG96XFOPNHwiCCQD+S
 lJRStEfNFQnXO1h1wPQSIj2Jtl8UskBzhkIow5pNwxIzvNEKy8hsUFurZpLLp/J+7l8z0NGHH
 zosxulVsWbhUtqqa3pa0RB1YOMxmQMeZEhg9OtP1Pn6q32kxGmRR1oHRlmEZuDAWg25qoYCdG
 LQaGpPSyExdYVAVYJQHXFuGyMKpkTD6Zjzjf6onsKo1DCt/F62EXBbn063U7OJO6F0ai4hy/Q
 pGmlJyQ810KNYzFvkjU1PQUKGC5OTTI55KE1leWaTC3K7OVsBZg/0HaOSVljqPtQpkDJ89rON
 zSHkPUXrPdCSyU6/7Kt9MIgC0K1rSzFgaC2s7FXmNuZxlu9Edyr8gDhc3uM2z7JA1nFyNeV7u
 dAqDFwBs+fEU1h3w7WJlTFK18ZmoGBgLn5d2EocIwO8cc7Nlh9bI+0f5Van5anghPyi/lUqOq
 0KdnitRRf7XYQtPm2PMhbcz3ooY5K6d49GGju9c8cozCdA+/u1tGcU2SHZwQGSnNpAdBCHDT1
 Ygigfl3kQ+paaR/iIyhsbYqLJYnhQFJlfLXTTr736QZVnrApmcJMlZZ9mw8GB2SqlLlALnO3e
 RSV78Qtb6TVKnDFB4s1hPY9OCsR/dIiLBdbuEEm1GJZQSXejwAuS97iffkd7x/G0L4YN/wj2M
 vSyTZg==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/23 08:18, Wei Chen wrote:
> variable var->pixclock can be set by user. In case it
> equals to zero, divide by zero would occur in nvidiafb_set_par.
>
> Similar crashes have happened in other fbdev drivers. There
> is no check and modification on var->pixclock along the call
> chain to nvidia_check_var and nvidiafb_set_par. We believe it
> could also be triggered in driver nvidia from user site.
>
> Signed-off-by: Wei Chen <harperchen1110@gmail.com>

applied all four patches.

Thanks!
Helge

> ---
>   drivers/video/fbdev/nvidia/nvidia.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/video/fbdev/nvidia/nvidia.c b/drivers/video/fbdev/n=
vidia/nvidia.c
> index e60a276b4855..ea4ba3dfb96b 100644
> --- a/drivers/video/fbdev/nvidia/nvidia.c
> +++ b/drivers/video/fbdev/nvidia/nvidia.c
> @@ -764,6 +764,8 @@ static int nvidiafb_check_var(struct fb_var_screenin=
fo *var,
>   	int pitch, err =3D 0;
>
>   	NVTRACE_ENTER();
> +	if (!var->pixclock)
> +		return -EINVAL;
>
>   	var->transp.offset =3D 0;
>   	var->transp.length =3D 0;

