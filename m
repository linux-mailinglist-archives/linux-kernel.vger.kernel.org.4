Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEBFC6024B1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 08:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiJRGoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 02:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiJRGoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 02:44:39 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6222B1A5;
        Mon, 17 Oct 2022 23:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1666075457;
        bh=63HZwXGejDLFqTyjSGQIERszUjqAubInWNkbhxQHRfw=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=dorsbPzY5+G3UbsKLlQ90/xJXEeNF+VxEYVaQbu6mS+CKoHHwr5Jmf2/kzrZlvGj6
         4iFK+UZ+7t6g15AsfLz1IZhqJ0irysgeDvAblo8rlmaenoXS75dvbkZzPM4eq1E7H+
         pAZn+1jouJBRJR0VFZ5jjgrICiYxdW/fMr4gCuys=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.165.172]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MGz1f-1oxedu34sd-00E3TI; Tue, 18
 Oct 2022 08:44:17 +0200
Message-ID: <b1a1e5b0-206c-6b3c-41f0-94de7b056f72@gmx.de>
Date:   Tue, 18 Oct 2022 08:44:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] video: fbdev: sm501fb: onvert sysfs snprintf to
 sysfs_emit
Content-Language: en-US
To:     Xuezhi Zhang <zhangxuezhi3@gmail.com>, zhangxuezhi1@coolpad.com,
        wsa+renesas@sang-engineering.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20221018062548.642910-1-zhangxuezhi3@gmail.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20221018062548.642910-1-zhangxuezhi3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:m0LUg5lPRQQEw6XOGHCdkytsWPN2mwF8nfxCnoi7lXPqe5vNeO0
 8HONJbY/nJaUWviqJy6UB65Ve3vgZB99WGxPyhFluZZ8ydSoH3bbpZaIWwMzF3UgRc32P2J
 sRUWmEzUdIakUVq6svprEX+E7zcCE9t+bpk48YuwIotineLHPHL4H6A8AhvzeD34RD3MwOd
 YnQj6j5aa/RGSOuvMCX6Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ROU90UQi0hY=:VK1PRXw00TKdNnI/PBgQvP
 V8bZOtcqB3npbx38QOlShFibE/ISpQ9/j7cceWW7073LPfeArVfKIh9QR7VbkpL5YRwFfgord
 5Ln18dk449YM8KWvoqOH8d1C/iTHJ0C7rAjYQ+pgxe00CVN7NknMM5zjHxoTApCrUg9ZteeGD
 GT3jqp8gK0N/t7EDO6PtuKNI7sY+q3cqfziQTOibNVc/JthRDJfRYoRcMKttwGnZAoo0E58kJ
 GEsqh3YSYM21vEeW1KzvjVhJJyCWQ6ar1z0n21jpkIT78tuie7C/5lztkDiCl35lkXkZ1aWZV
 CS60Y5r9Xzpzqry2iRzBDbmhgATxDhQpzqQqq6WqQCvR+U4IsEqxB5L/ZLdz8PTgfvaNAgK+N
 HqnwTgRtjrGNmWrHgnzy/IUdh8d4QqaZPnSPnOiUF35PNsbtI+qrC0VV0orshHNA+cfstTc/u
 4IqjGQlp6BovKiL4EwQl8pX5NbIIW9f/9D1WzOPtMhcuW1T6N+wOtpREsiGY7NKMf/w+fjmg8
 fNpmUQZ9+N2OC7EuCbi4hsekwUtaYOvjk3rxvZtwI8gOs+lGdJGeljPXW/mKfdqd3i1FbaRg+
 WBdasiEIzlNwLePqPLGpwoMrJRG5kq9vKownm+KhvgjlR9A3JHk8RyemQyQMW1Hw4vIDN1oce
 Wbo7MmqKRBCesoczHKV7EFnofDf3DJvkIJdWEgCKG037NdmYqpIfHH8Yx2C7ZEyA68dGdxiCZ
 1p8j549Fvb9v9NM/Uj+iHwtl/PDZbUa8VZAA9z8GPjDLw3Azk/dEtn9KKLaF6eH8HMs47DI29
 YGFo3ENkPszbE3/AMrIXeLNGrsq0oT2JjoF3iAnORL/NjNRjjIy3R1fR+naR8Fhult0amMGo5
 /v/8VN0rcbb5A7ZS9HoPT2Zffbx9k7ZGmLNSCh0NGNIXSqRH0cqawEDbM/fS6voBZ4SI0KuGC
 kifdH2PmWMfckuDInA4iOlK68PDkM+rJ9/RlDqJq8z77aWiYrhFJfyxm0+TPgU3GX3k6wKyPX
 bXmOPxWBkHifUPcbiK0JI1LYB0L1ZneGTTiJNvQB3TRXYVzzgsR+bgkHnf3NSe2Kcz75foDcO
 Xwn9JW9kif1e7vyFkHmpAm34+TYNcPPLpJf/4ko9oqIFs4ZI9AfgZidojsMkTM1wcXvA8TE/g
 rWxLsSLM2dzREsrv/hDOZyLD2STn2yqgSqfhqY33r4y/KM03Q+bExBTwbpFv0xCahr50cPF3v
 cYcHCQFMHAQZVaX3tBLPkPsYJFHzM2KtYjNe3y8zYblJ1b60nWIW9etTaofRL0xSDvfZGEfER
 XVI4qgn28iXWlyuSWKt6GVY5+oCqIiKDZvLJGucFzF8TOJR6vRSroqvbxcDzp4nsNWXHQETDg
 shpwI8cbZIhNUXeDsdZAZSxRx82bjhqBhxP9zpsyR9F7vPrHifBVl43S22z1IuMO6n7I+JIyh
 C1AofKqaV+8jyACEq/kYJfrUEjBsp2A9Bqv4mf0bkHsgsjG6j7oFPq9nNfxX+M65DILrQPiVE
 esiBCVrxM3Zsm04Z5zhm9ygkMt1ChCpz1gl9vb/mByDYN
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/22 08:25, Xuezhi Zhang wrote:
> From: Xuezhi Zhang <zhangxuezhi1@coolpad.com>
>
> Follow the advice of the Documentation/filesystems/sysfs.rst
> and show() should only use sysfs_emit() or sysfs_emit_at()
> when formatting the value to be returned to user space.
>
> Signed-off-by: Xuezhi Zhang <zhangxuezhi1@coolpad.com>

applied.
Thanks!
Helge

> ---
>   drivers/video/fbdev/sm501fb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/video/fbdev/sm501fb.c b/drivers/video/fbdev/sm501fb=
.c
> index fce6cfbadfd6..f743bfbde2a6 100644
> --- a/drivers/video/fbdev/sm501fb.c
> +++ b/drivers/video/fbdev/sm501fb.c
> @@ -1166,7 +1166,7 @@ static ssize_t sm501fb_crtsrc_show(struct device *=
dev,
>   	ctrl =3D smc501_readl(info->regs + SM501_DC_CRT_CONTROL);
>   	ctrl &=3D SM501_DC_CRT_CONTROL_SEL;
>
> -	return snprintf(buf, PAGE_SIZE, "%s\n", ctrl ? "crt" : "panel");
> +	return sysfs_emit(buf, "%s\n", ctrl ? "crt" : "panel");
>   }
>
>   /* sm501fb_crtsrc_show

