Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62A05BADFD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 15:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbiIPNUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 09:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbiIPNUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 09:20:24 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAA4DEDF
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 06:20:13 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220916132011euoutp020e3b34dbd440285d65d2d9684ffdbc6e~VWdW0hIay2954829548euoutp029
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 13:20:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220916132011euoutp020e3b34dbd440285d65d2d9684ffdbc6e~VWdW0hIay2954829548euoutp029
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1663334411;
        bh=WkFSIox/+u3CVQwr0PZml4B9CMIqKSekifLZMllTt4U=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=fa+X8MPQnLpr5qKUibjzg97MRmIErp0bkzJfwlixGFdtg3/P4N39RPMU0kXAI1+1O
         gFH64VnF6Po11r5bW/cFgHhBYsW75q4fWDflHaH1LUBT3Aht+44tNwG6SYjMZYGwwl
         v/jinToxWknfmqF20qe0T6eQhc0xmzhMymKzGJ+c=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220916132011eucas1p2ce14ff026bcfb2c77aa2fbce3528c3ca~VWdWqHp9A2966929669eucas1p2Q;
        Fri, 16 Sep 2022 13:20:11 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id EA.93.19378.B0874236; Fri, 16
        Sep 2022 14:20:11 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220916132011eucas1p1360b9cc02cc108556fe80fab8d89567d~VWdWXOADn1418514185eucas1p1X;
        Fri, 16 Sep 2022 13:20:11 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220916132011eusmtrp113fa532ae744f1b7211f720d022899b8~VWdWWg7aq2272422724eusmtrp1R;
        Fri, 16 Sep 2022 13:20:11 +0000 (GMT)
X-AuditID: cbfec7f5-a4dff70000014bb2-e2-6324780b65d1
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 9A.FD.07473.B0874236; Fri, 16
        Sep 2022 14:20:11 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220916132010eusmtip1c7ce24bc9eb9b6b5c8986566f78b50d1~VWdWAVZe71394813948eusmtip1h;
        Fri, 16 Sep 2022 13:20:10 +0000 (GMT)
Message-ID: <1041bfe5-6515-feea-36d6-47f8f28938b6@samsung.com>
Date:   Fri, 16 Sep 2022 15:20:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH] gpiolib: fix OOB access in quirk callbacks
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20220916110118.446132-1-michael@walle.cc>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sf0yMcRjf933fe+/tOHu7cE+YuMpo9ItxG6Msds2UX9shLW/nXaI7dm9x
        bJGW2E12QnhFCUUsoR2KplMXUlq/VFisI2XHSKWrme7eov8+z+f5fL6f53n2pXDZRdE0Kl6X
        yOp1TIKClBBm6+DrBRMMPppAa+psZekHM6l8lvcFKc8MF2DK+znDSNlYmk0q7TXF4hBSdbXl
        rUj1iH8vVr1reUyqeu/NVD19kkauE22VLNvBJsTvY/UBy7dLdtZ/u4XtfTLDYH1bhqWgi3Ij
        cqOAXgQVjR24EUkoGX0DwfOMfEwofiG4+nGQFIpeBC9fNxJjlt6uytFGAYL0krujlh8ILK02
        sVMlpZdD5mery0HQvnC7tp8QeHd4ccHmwlNoDfBWK3JiD3oFdN60uLw4LYd2W47r0cn0NQR2
        Y9FoYxlUHnsvcmKSDgKj3Ug6sRu9BO6/aSIFjRc8sGe7NgK6iYIy/iguzB0GjtpykYA9oKe6
        RCzgGVBz+gQhGI4hyB3qwITChCClqx0JqqXwrs4xEkGNRMyDO6UBAh0Kjkv5hJMGehK02t2F
        ISZBpvkcLtBSOJ4uE9RzgK8u+hdbUd+Am5CCH3cXftz+/Lh1+P+5uYgoRHI2idPGsdxCHbvf
        n2O0XJIuzl+zR3sPjfyfmj/VfQ/RjZ4f/haEUciCgMIVk6W+4T4amXQHc+Agq98To09KYDkL
        mk4RCrlUE1/MyOg4JpHdzbJ7Wf1YF6PcpqVg67elXifa2mZ9stY9ZIoG0vuaN/tzqbt/xXye
        uMKT1EUVRhgsi2P7XyS3qMIenzR5n83otpdgVbZTxWe/8/SmVxVewX43M4ZjO6tMu3KmHl9/
        ZKV2teR29FqW+01WhPhVTex+lZGVl970zedWdKH75cH9qd1L50TjZgjzmhdrb+he82zhxqac
        iOAhz6wNDW1B7abz0ulRB8uvXys45Nt8JdQzKtCX9zns6Z14JCVP7ZiQn/xhbjm0DDAhqnUf
        N3QRenS3y1waOv9keI+60WwJ6NxWr51Vll+lNmCm8I5VkqGnWyI3OyLVEZKvoZkDhuYYcTus
        rfxZk5Vmkw+pjYFrFAS3kwnyw/Uc8xfPDYsnrgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNIsWRmVeSWpSXmKPExsVy+t/xu7rcFSrJBntn8VrserCNzeLwoheM
        FlP+LGey2Dz/D6PF5V1z2Czent7A7sDmsfjabVaPnbPusnvcubaHzePzJjmPA3tb2AJYo/Rs
        ivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQyLrxbzVSw
        V6bi2O3dTA2Ms8W7GDk5JARMJD4/P8LWxcjFISSwlFFiwvrJLBAJGYmT0xpYIWxhiT/XuqCK
        3jNK3D19jREkwStgJzHp2TGwBhYBVYk1Z7+xQMQFJU7OfAJmiwokSyxpuA82SFjAXuLxykPs
        IDazgLjErSfzmUBsEYEljBJ92wIh4jYSR9rvgtULCZhJrOz7CFbDJmAo0fUW5AhODk4Bc4nN
        16+wQdSbSXRt7WKEsOUltr+dwzyBUWgWkjNmIVk3C0nLLCQtCxhZVjGKpJYW56bnFhvqFSfm
        Fpfmpesl5+duYgTG2rZjPzfvYJz36qPeIUYmDsZDjBIczEoivKqeKslCvCmJlVWpRfnxRaU5
        qcWHGE2BYTGRWUo0OR8Y7Xkl8YZmBqaGJmaWBqaWZsZK4ryeBR2JQgLpiSWp2ampBalFMH1M
        HJxSDUwbpi7Ty1V0DMwUNOJ5mxvisf2elO/TSJOf4U5Vh15U/ri9W3571yIxRt0LP2avdFa5
        XDrneeTU2zMW9Yi8t9GzPPRu89UGzuPzNSXMV32duuyp+V7Ft1d+WdoJOJvdN3vSPnXazOmT
        mdZ1P+ZUmLXCS8eTmWnDpFtV29Wq681PVZ2Rfp3ZFd97++vhifd1f05a1O1UuPTOmSOy0fq3
        Vr1c6sQ35b+HaG8vo7SJ+sOlTjwqq9IL9ib/cXksrXkg6d+Kj0JNx8Pa/oQ11Zo/uNBcycP6
        Y9Vb7U91C+/wXOGfH+R2z6NTfOP1KN3Str5PcxlmRd0PumAerH78wNQwAcuUO+LCu/jn3JoS
        0KAs9jdciaU4I9FQi7moOBEAxIz6kz4DAAA=
X-CMS-MailID: 20220916132011eucas1p1360b9cc02cc108556fe80fab8d89567d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220916132011eucas1p1360b9cc02cc108556fe80fab8d89567d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220916132011eucas1p1360b9cc02cc108556fe80fab8d89567d
References: <20220916110118.446132-1-michael@walle.cc>
        <CGME20220916132011eucas1p1360b9cc02cc108556fe80fab8d89567d@eucas1p1.samsung.com>
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.09.2022 13:01, Michael Walle wrote:
> Commit a2b5e207cade ("gpiolib: rework quirk handling in of_find_gpio()")
> introduced an array of quirk functions which get iterated over. But a
> sentinal value is missing. Add it.
>
> Fixes: a2b5e207cade ("gpiolib: rework quirk handling in of_find_gpio()")
> Signed-off-by: Michael Walle <michael@walle.cc>

This fixes the boot issue on all my test machines I've observed with 
linux next-20220916. Thanks!

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
> FWIW here is the kernel oops backtrace:
> [    4.108706] Internal error: SP/PC alignment exception: 8a000000 [#1] SMP
> [    4.115470] Modules linked in:
> [    4.118549] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.0.0-rc5-next-20220916-00091-g6cae0fcbd5e7 #1821
> [    4.128033] Hardware name: Kontron KBox A-230-LS (DT)
> [    4.133127] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    4.140154] pc : 0x61722d6f697067
> [    4.143495] lr : of_find_gpio+0x138/0x174
> [    4.147546] sp : ffff80000a24b680
> [    4.150884] x29: ffff80000a24b680 x28: 0000000000000000 x27: ffff80000996044c
> [    4.158090] x26: 0000000000000001 x25: ffff80000970f588 x24: ffff800009297968
> [    4.165295] x23: ffff80000a24b770 x22: 0000000000000000 x21: ffff0020009a7010
> [    4.172500] x20: ffff8000097752f8 x19: fffffffffffffffe x18: 0000000000000000
> [    4.179703] x17: ffff8000085fb9d0 x16: ffff8000085fb264 x15: ffff8000085f96ac
> [    4.186907] x14: 0000000000000000 x13: ffff80000884b3e8 x12: ffff80000884ab04
> [    4.194111] x11: ffff80000884aa54 x10: 0000000000025080 x9 : ffff8000085fce78
> [    4.201316] x8 : 0101010101010101 x7 : ffff800009750268 x6 : 051f521459491b57
> [    4.208520] x5 : 571b495914521f05 x4 : 6e61722d6f697067 x3 : ffff80000a24b6d4
> [    4.215724] x2 : 0000000000000000 x1 : ffff8000097752f8 x0 : ffff00207f7e4b20
> [    4.222928] Call trace:
> [    4.225389]  0x61722d6f697067
> [    4.228377]  gpiod_get_index+0x12c/0x440
> [    4.232334]  devm_gpiod_get_index+0x34/0xf0
> [    4.236553]  devm_gpiod_get_optional+0x20/0x40
> [    4.241036]  uart_get_rs485_mode+0x104/0x180
> [    4.245345]  serial8250_register_8250_port+0x198/0x484
> [    4.250532]  of_platform_serial_probe+0x358/0x640
> [    4.255279]  platform_probe+0x70/0xe0
> [    4.258973]  really_probe+0xc4/0x2e4
> [    4.262577]  __driver_probe_device+0x80/0xec
> [    4.266882]  driver_probe_device+0x44/0x150
> [    4.271100]  __driver_attach+0x88/0x1a0
> [    4.274967]  bus_for_each_dev+0x78/0xdc
> [    4.278833]  driver_attach+0x2c/0x40
> [    4.282437]  bus_add_driver+0x15c/0x210
> [    4.286303]  driver_register+0x80/0x13c
> [    4.290170]  __platform_driver_register+0x30/0x3c
> [    4.294915]  of_platform_serial_driver_init+0x24/0x30
> [    4.300013]  do_one_initcall+0x4c/0x240
> [    4.303882]  kernel_init_freeable+0x29c/0x30c
> [    4.308276]  kernel_init+0x2c/0x140
> [    4.311793]  ret_from_fork+0x10/0x20
> [    4.315401] Code: bad PC value
>
>   drivers/gpio/gpiolib-of.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
> index 95be5f0d2623..0e4e1291604d 100644
> --- a/drivers/gpio/gpiolib-of.c
> +++ b/drivers/gpio/gpiolib-of.c
> @@ -498,6 +498,7 @@ static const of_find_gpio_quirk of_find_gpio_quirks[] = {
>   	of_find_regulator_gpio,
>   	of_find_arizona_gpio,
>   	of_find_usb_gpio,
> +	NULL
>   };
>   
>   struct gpio_desc *of_find_gpio(struct device *dev, const char *con_id,

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

