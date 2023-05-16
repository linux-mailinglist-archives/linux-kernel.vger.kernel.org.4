Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7FB705972
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 23:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjEPV1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 17:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjEPV1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 17:27:07 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEEF6A54
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 14:27:04 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230516212702euoutp0176e49d01e596556c9d934c432a67ea94~fvNgyNDiU2920529205euoutp01B
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 21:27:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230516212702euoutp0176e49d01e596556c9d934c432a67ea94~fvNgyNDiU2920529205euoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684272422;
        bh=AWnFPzdKQ3BmDA6aeSsFt7RWiz9U9+getE+2R81AueU=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=OuUaNOoesxxJSJukHoQCMhFRMIVPfBefG6JYEau0reBbr/qij3NYV+xuE4jeVLWln
         P5xFab7pIb+KqxL5upi2q3d/iCCBuAw8Yt13/I1OQXGSPvjxClLiT9MN5bmloJEnCp
         fyQipo1NyHaanCzhEq2iA3WbernQvPF/DK2vd9v0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230516212701eucas1p182e16c522a2e31461b9511b2390b8b3a~fvNf2Xpgy1496114961eucas1p1o;
        Tue, 16 May 2023 21:27:01 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 06.92.42423.525F3646; Tue, 16
        May 2023 22:27:01 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230516212700eucas1p1fbde1b6181c18d821e0796b6b6a4fa00~fvNepBxWa1501615016eucas1p1N;
        Tue, 16 May 2023 21:27:00 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230516212700eusmtrp109235a95d334cf742154f8b806fbb48e~fvNeoUmSE1235012350eusmtrp1W;
        Tue, 16 May 2023 21:27:00 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-5e-6463f52569d4
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id FE.7F.14344.325F3646; Tue, 16
        May 2023 22:26:59 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230516212659eusmtip1402a48b4d27c0ca2942f69a8219ae669~fvNdz47OG2253222532eusmtip1_;
        Tue, 16 May 2023 21:26:59 +0000 (GMT)
Message-ID: <2d234cd8-f883-800b-af97-116a949b64af@samsung.com>
Date:   Tue, 16 May 2023 23:26:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH v8 05/14] mfd: rk808: split into core and i2c
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Diederik de Haas <didi.debian@cknow.org>,
        Vincent Legoll <vincent.legoll@gmail.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20230504173618.142075-6-sebastian.reichel@collabora.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPKsWRmVeSWpSXmKPExsWy7djP87qqX5NTDCa1C1ksuXiV3aL93TJ2
        i6kPn7BZzD9yjtWi9dVzdov/j16zWmw+18Nq0ffiIbPFjraFLBbfrnQwWUz5s5zJ4vKuOWwW
        nx78Z7a4eMrVonXvEXaLf9c2sljcfe1ncXztMzYHIY/3N1rZPeatqfY48f8Ii8eOu0sYPXbO
        usvusWlVJ5vHnWt72Dw2L6n32H5tHrPH9Hk/mTw+b5IL4I7isklJzcksSy3St0vgyvj76Apr
        QRd/xYfjfA2MC7m7GDk5JARMJJ49n87SxcjFISSwglHiyccuNpCEkMAXRolrh5MgEp8ZJZp/
        tjPDdJz+ugKqYzmjxOVdd6Gcj4wS7RfesoBU8QrYSUzvvQNmswioShyfOxUqLihxcuYTMFtU
        IFVi1eaLYFOFBRwlLk3dyApiMwuIS9x6Mp8JZKiIwBVGie4lF9hBHGaBj8wSTc/fgh3IJmAo
        0fUW4lhOATeJs43LGSG65SW2v50Ddes1TonDjZIQtovEkaadrBC2sMSr41vYIWwZidOTe8Be
        kBBoZ5RY8Ps+E4QzgVGi4fktRogqa4k7534BbeMA2qApsX6XPkTYUWL6xEXsIGEJAT6JG28F
        IW7gk5i0bTozRJhXoqNNCKJaTWLW8XVwaw9euMQ8gVFpFlK4zELy/ywk38xC2LuAkWUVo3hq
        aXFuemqxYV5quV5xYm5xaV66XnJ+7iZGYJo8/e/4px2Mc1991DvEyMTBeIhRgoNZSYQ3sC85
        RYg3JbGyKrUoP76oNCe1+BCjNAeLkjivtu3JZCGB9MSS1OzU1ILUIpgsEwenVANTtoBkgi2f
        2i/Gn5sMtk7dx8RSb8u9g3vJu5qONc+1brrOStuWfbzGt8D3r327DvObvivvL05at+xHpgvj
        NFaPeT9cjz5a2a393bby46XLb27fUfw+yfCKasl7eRPDaR4XT0xKlDv6eqb0m8+bn150Wp68
        xVmrxrq7WOGP0gJZHw7FLHf3pnUS70KCPmXUvUnWsTXbZFq9aTavrf2h0G2TI6dtZIks+/rk
        7RfHNbkL/ZQNd7hbmE9h1H1XNF3Z0f7Wr8De8ObHPA8PM8sb/tq/rn2HHHv64ZdftjnsCL3V
        pbP7+R/5GytPxJuduOesZt92ISvBseyoy7t5D2weXZxnIcsfttLo5M5jirf2t6/3U2Ipzkg0
        1GIuKk4EAEWGzLQCBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmleLIzCtJLcpLzFFi42I5/e/4XV3lr8kpBtemWFssuXiV3aL93TJ2
        i6kPn7BZzD9yjtWi9dVzdov/j16zWmw+18Nq0ffiIbPFjraFLBbfrnQwWUz5s5zJ4vKuOWwW
        nx78Z7a4eMrVonXvEXaLf9c2sljcfe1ncXztMzYHIY/3N1rZPeatqfY48f8Ii8eOu0sYPXbO
        usvusWlVJ5vHnWt72Dw2L6n32H5tHrPH9Hk/mTw+b5IL4I7SsynKLy1JVcjILy6xVYo2tDDS
        M7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy/j76AprQRd/xYfjfA2MC7m7GDk5JARM
        JE5/XcHSxcjFISSwlFHi6axJbBAJGYmT0xpYIWxhiT/Xutggit4zSkz9fZwZJMErYCcxvfcO
        C4jNIqAqcXzuVBaIuKDEyZlPwGxRgVSJk0tvgNnCAo4Sl6ZuBBvKLCAucevJfCaQoSIC1xgl
        lsw4CbaBWeAzs8TcXXdYIdY1MkpM+vqFEaSFTcBQouttF9h9nAJuEmcblzNCjDKT6NraBWXL
        S2x/O4d5AqPQLCSXzEKycRaSlllIWhYwsqxiFEktLc5Nzy020itOzC0uzUvXS87P3cQITA3b
        jv3csoNx5auPeocYmTgYDzFKcDArifAG9iWnCPGmJFZWpRblxxeV5qQWH2I0BQbHRGYp0eR8
        YHLKK4k3NDMwNTQxszQwtTQzVhLn9SzoSBQSSE8sSc1OTS1ILYLpY+LglGpg8tgZ4sPybEaE
        gtOC0uzc2zMfbJt2zev3oaU1jH8PmgXIbAkz/21t+blpqSPfLROG6385F17PTfIw1BZy6/K3
        /PKG7ZFp3ObgmetFb7Dy62l/mnKA+z3XCelMM5logSeJYmX/ngsudBH75Xyr8EDuNmXrtyL8
        h43j2riynY/8l7hcVnGm9sjpL8zz9PTO3ewJ/G/tELmQ9brjJfPfNyxLKwSDua8bv/zd/O3q
        8/WvZU9oiofOL/CwruYXyb8exXZQrrz+GYv44d9bJrpXNU3/m6N763HC5E9Pl5a0iIr1t+46
        aPjL/1PcZs83Em6Ws5hfXObPeTbhbZvd7cRXzQ3PlHTsbudOWPRqk2nWR9f9SizFGYmGWsxF
        xYkAaplqb5YDAAA=
X-CMS-MailID: 20230516212700eucas1p1fbde1b6181c18d821e0796b6b6a4fa00
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230516212700eucas1p1fbde1b6181c18d821e0796b6b6a4fa00
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230516212700eucas1p1fbde1b6181c18d821e0796b6b6a4fa00
References: <20230504173618.142075-1-sebastian.reichel@collabora.com>
        <20230504173618.142075-6-sebastian.reichel@collabora.com>
        <CGME20230516212700eucas1p1fbde1b6181c18d821e0796b6b6a4fa00@eucas1p1.samsung.com>
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 04.05.2023 19:36, Sebastian Reichel wrote:
> Split rk808 into a core and an i2c part in preparation for
> SPI support.
>
> Acked-for-MFD-by: Lee Jones <lee@kernel.org>
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com> # for RTC
> Tested-by: Diederik de Haas <didi.debian@cknow.org> # Rock64, Quartz64 Model A + B
> Tested-by: Vincent Legoll <vincent.legoll@gmail.com> # Pine64 QuartzPro64
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

This patch landed in today's linux-next as commit c20e8c5b1203 ("mfd: 
rk808: Split into core and i2c"). Unfortunately some boards (for example 
Hardkernel's Odroid-M1) stopped to boot after this change. This is 
caused by the lack of updating the related defconfigs. Could you please 
add a patch that updates the MFD_RK808 entries to MFD_RK8XX_I2C in the 
following files:

$ git grep MFD_RK808
arch/arm/configs/multi_v7_defconfig:CONFIG_MFD_RK808=y
arch/arm64/configs/defconfig:CONFIG_MFD_RK808=y


> ---
>   drivers/clk/Kconfig                   |   2 +-
>   drivers/input/misc/Kconfig            |   2 +-
>   drivers/mfd/Kconfig                   |   7 +-
>   drivers/mfd/Makefile                  |   3 +-
>   drivers/mfd/{rk808.c => rk8xx-core.c} | 209 +++++---------------------
>   drivers/mfd/rk8xx-i2c.c               | 200 ++++++++++++++++++++++++
>   drivers/pinctrl/Kconfig               |   2 +-
>   drivers/power/supply/Kconfig          |   2 +-
>   drivers/regulator/Kconfig             |   2 +-
>   drivers/rtc/Kconfig                   |   2 +-
>   include/linux/mfd/rk808.h             |   6 +
>   sound/soc/codecs/Kconfig              |   2 +-
>   12 files changed, 256 insertions(+), 183 deletions(-)
>   rename drivers/mfd/{rk808.c => rk8xx-core.c} (76%)
>   create mode 100644 drivers/mfd/rk8xx-i2c.c
>
> ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

