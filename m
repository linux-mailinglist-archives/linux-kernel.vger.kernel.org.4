Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0047474E94B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 10:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjGKInR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 04:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjGKInO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 04:43:14 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C879AD
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 01:43:13 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230711084311epoutp03ba6904239f86f2dd4c2393e4a11e4295~ww6kQbW9U0195701957epoutp03G
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 08:43:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230711084311epoutp03ba6904239f86f2dd4c2393e4a11e4295~ww6kQbW9U0195701957epoutp03G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1689064991;
        bh=/fo5+GPfSG58Ft64sKkgPC9cdBMfwnfIvD5VK2E1I+E=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=hMaz91PY1oTKd33fD/TmAVRffTkjWE6DOw1LwuiNbQeR60QnW0usTdrcr7Kg7uvyf
         uvxohSfPufeUlCVgZo9aHW7VQVwNR00LLHzbKHyz7JDMqMk++28TVHY+JtI8fM82Ef
         GnYX42V+xl+NDvJc3FxNyOXspSua++ewtc7nxTmg=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230711084310epcas2p4af0e5b0e002805c13b46f17428b55d53~ww6j07nTW2825128251epcas2p4t;
        Tue, 11 Jul 2023 08:43:10 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.89]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4R0ZC16sB8z4x9QB; Tue, 11 Jul
        2023 08:43:09 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        56.23.55279.D161DA46; Tue, 11 Jul 2023 17:43:09 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20230711084309epcas2p1073b2e64f19ef1452c08455c56d249c0~ww6imu7ll1882518825epcas2p1a;
        Tue, 11 Jul 2023 08:43:09 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230711084309epsmtrp12fa05f4a130540fef089dd1ce14fe771~ww6il0ghY1777917779epsmtrp1K;
        Tue, 11 Jul 2023 08:43:09 +0000 (GMT)
X-AuditID: b6c32a43-2f3ff7000001d7ef-7b-64ad161d0ac7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F5.79.30535.D161DA46; Tue, 11 Jul 2023 17:43:09 +0900 (KST)
Received: from KORCO082417 (unknown [75.12.40.192]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230711084309epsmtip182e2372e0e727cb95d224865deaab978~ww6iZg_4I1142811428epsmtip1J;
        Tue, 11 Jul 2023 08:43:09 +0000 (GMT)
From:   "Chanho Park" <chanho61.park@samsung.com>
To:     "'Jaewon Kim'" <jaewon02.kim@samsung.com>,
        "'Andi Shyti'" <andi.shyti@kernel.org>,
        "'Mark Brown'" <broonie@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Alim Akhtar'" <alim.akhtar@samsung.com>
Cc:     <linux-spi@vger.kernel.org>, <linux-samsung-soc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <20230711082020.138165-1-jaewon02.kim@samsung.com>
Subject: RE: [PATCH] spi: s3c64xx: clear loopback bit after loopback test
Date:   Tue, 11 Jul 2023 17:43:08 +0900
Message-ID: <000001d9b3d3$b81deaa0$2859bfe0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKEB9fWRKMuuBMGwH0DXsDDFTgnuwG1Aiv/rlHuGMA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHJsWRmVeSWpSXmKPExsWy7bCmqa6s2NoUg5YvhhYP5m1js7j/tYPR
        YurDJ2wWOxqOsFrsfb2V3WLT42usFpd3zWGzmHF+H5NF48eb7A6cHptWdbJ53Lm2h81j85J6
        j74tqxg9Pm+SC2CNyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy
        8QnQdcvMAbpHSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgXqBXnJhbXJqXrpeX
        WmJlaGBgZApUmJCdsft9F3PBZ96Kh//4Gxivc3cxcnJICJhInJn8mKmLkYtDSGAHo8T9jm4o
        5xOjxJ6+NVDON0aJHa1LGGFadh56ywyR2Msosf3jf6iqF4wS/YfesoFUsQnoS7zs2MYKkhAR
        eMoo8XPqV7AWZoE+RollXxvAqjgF7CVW7foDZgsLeEpcW9bP3sXIwcEioCox/04GiMkrYClx
        d0EwSAWvgKDEyZlPWEBsZgF5ie1v5zBDXKQg8fPpMlYQW0TASmLDE5AfQGpEJGZ3toGtlRBY
        ySGx/s5TFpCZEgIuEvtuc0H0Cku8Or6FHcKWknjZ38YOUVIusWNZEkRrC6NEc9seqF32Ej9u
        TmEFqWEW0JRYv0sfolxZ4sgtqMv4JDoO/4WawivR0SYE0agucWD7dBYIW1aie85n1gmMSrOQ
        /DULyV+zkNw/C2HXAkaWVYxiqQXFuempyUYFhvCoTs7P3cQITqhazjsYr8z/p3eIkYmD8RCj
        BAezkghvwcFVKUK8KYmVValF+fFFpTmpxYcYTYHhPJFZSjQ5H5jS80riDU0sDUzMzAzNjUwN
        zJXEee+1zk0REkhPLEnNTk0tSC2C6WPi4JRqYLLubcx+6MZcu/8cx8Etf99cY21aIfD0S0WR
        7e/rB556Ks6ZeeFVR94DCQ6f3rdaAmdtequ40ut7nU6/fiS3/ZlUtLbAjBevv3F+6TgVp3Rw
        OuO1yOOGHc3Wz8LK6nK+sStGHPyQP6UsULDH8VW6mzybh4Pd69/3ZH6/vKahebpQev2WfXPT
        tZsf6H0SvDAvo3vd2qOT4rL45//wWf3x67+PE6vNhf9M1378NVdkFZeJWdfc+Bmn080+797y
        fwJj781WYaep//Jie5OLpcKK7J9P5hOW9exZbO61PXHxAuZLnUfkX0/mrj9uFLpvsdDdHvsr
        R1c0flS3c+e/+bGY50Lay9lnLBflcR8JN82MalJiKc5INNRiLipOBACo1rELMQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmkeLIzCtJLcpLzFFi42LZdlhJTldWbG2Kwdd9ghYP5m1js7j/tYPR
        YurDJ2wWOxqOsFrsfb2V3WLT42usFpd3zWGzmHF+H5NF48eb7A6cHptWdbJ53Lm2h81j85J6
        j74tqxg9Pm+SC2CN4rJJSc3JLEst0rdL4MrY/b6LueAzb8XDf/wNjNe5uxg5OSQETCR2HnrL
        3MXIxSEksJtRouPyHmaIhKzEs3c72CFsYYn7LUdYIYqeMUq0PD4LlmAT0Jd42bENLCEi8JxR
        YvKr8+wgDrPAJEaJc4sfM4FUCQlMYJS4taoaxOYUsJdYtesPG4gtLOApcW1ZP1ADBweLgKrE
        /DsZICavgKXE3QXBIBW8AoISJ2c+YQGxmQW0JZ7efAply0tsfzsH6lAFiZ9Pl7GC2CICVhIb
        nnQzQdSISMzubGOewCg8C8moWUhGzUIyahaSlgWMLKsYJVMLinPTc4sNC4zyUsv1ihNzi0vz
        0vWS83M3MYLjS0trB+OeVR/0DjEycTAeYpTgYFYS4S04uCpFiDclsbIqtSg/vqg0J7X4EKM0
        B4uSOO+3170pQgLpiSWp2ampBalFMFkmDk6pBqbWHRu+NxRmanQeS2SZPXdK9LaMWaybavak
        NqxU3d0/Mc0pXe1/y9NItbd9cyY+36lsJP3tZHxfxb/XF+ema59Zktg3a/EzTR9jr8nKicUC
        VxX1GqRSAv4FHIrd6h64bN+jnbKGzWW7DpaxvdA6ar6D+8Zp7gORrToVJj3L54RLRdrvtA18
        +clCa4+lZehKb3VT2RK+RRuu39DMDq3dc+B6t8z76kv5F+5mfqmy+11eaM4299aR8wUGTR1X
        ks45s5kn6b/98Sb56rSrD3xD1i2f6PzzkaP1CQHzhxVTn39feiVy6nfjNN9r7EfKA8P5H8Q8
        O+/7auG7s66v9Y/8EykIDW4WMFmQ6hA1h6XprqgSS3FGoqEWc1FxIgDIe2GRHgMAAA==
X-CMS-MailID: 20230711084309epcas2p1073b2e64f19ef1452c08455c56d249c0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230711082508epcas2p3088d488035e7e2910bf087d640e9c268
References: <CGME20230711082508epcas2p3088d488035e7e2910bf087d640e9c268@epcas2p3.samsung.com>
        <20230711082020.138165-1-jaewon02.kim@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jaewon,

> -----Original Message-----
> From: Jaewon Kim <jaewon02.kim@samsung.com>
> Sent: Tuesday, July 11, 2023 5:20 PM
> To: Andi Shyti <andi.shyti@kernel.org>; Mark Brown <broonie@kernel.org>;
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>; Alim Akhtar
> <alim.akhtar@samsung.com>
> Cc: linux-spi@vger.kernel.org; linux-samsung-soc@vger.kernel.org; linux-
> arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Chanho Park
> <chanho61.park@samsung.com>; Jaewon Kim <jaewon02.kim@samsung.com>
> Subject: [PATCH] spi: s3c64xx: clear loopback bit after loopback test
> 
> When SPI loopback transfer is performed, S3C64XX_SPI_MODE_SELF_LOOPBACK
> bit still remained. It works as loopback even if the next transfer is not
> spi loopback mode.
> If not SPI_LOOP, needs to clear S3C64XX_SPI_MODE_SELF_LOOPBACK bit.
> 

In order for this patch to be sent to the stable tree, below tag is required.
Fixes: ffb7bcd3b27e ("spi: s3c64xx: support loopback mode")

Otherwise, looks good to me.
Reviewed-by: Chanho Park <chanho61.park@samsung.com>

Best Regards,
Chanho Park

> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
> ---
>  drivers/spi/spi-s3c64xx.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c index
> fd55697144cc..b6c2659a66ca 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -684,6 +684,8 @@ static int s3c64xx_spi_config(struct
> s3c64xx_spi_driver_data *sdd)
> 
>  	if ((sdd->cur_mode & SPI_LOOP) && sdd->port_conf->has_loopback)
>  		val |= S3C64XX_SPI_MODE_SELF_LOOPBACK;
> +	else
> +		val &= ~S3C64XX_SPI_MODE_SELF_LOOPBACK;
> 
>  	writel(val, regs + S3C64XX_SPI_MODE_CFG);
> 
> --
> 2.17.1


