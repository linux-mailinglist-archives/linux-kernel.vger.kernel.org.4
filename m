Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF8E6D4E5C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 18:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbjDCQuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 12:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbjDCQuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 12:50:01 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5EEE4
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 09:49:59 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230403164956epoutp0195c49888ec0694216cb0409e56b0fcc5~SesSrRdaF2775727757epoutp01p
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 16:49:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230403164956epoutp0195c49888ec0694216cb0409e56b0fcc5~SesSrRdaF2775727757epoutp01p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680540596;
        bh=4vl4MneEdX/I/cATp5aqPnhcg1IjYaveQ7Hh5V32xLY=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=s2MK158LH4aGvXXiEpRZQh4wmh5VIS8dOYoSnxIGNzDl3zH4m6OqLLQE6nH0mjdiG
         q9Mp04n/75Qu+mmR2/dv+e3MrqKa+5HbzCilWiMccjtRYJ5h8x06VYXP8sBeqrXBC2
         18uZ+uVgSk5xemsJjT4RW4rxV3fUPG+afU4iu2/o=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230403164955epcas5p195f1750d7cd4bfb53d694e573d1f1154~SesSN2lva2280422804epcas5p1X;
        Mon,  3 Apr 2023 16:49:55 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4PqxhL32snz4x9Pt; Mon,  3 Apr
        2023 16:49:54 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        58.80.55678.2B30B246; Tue,  4 Apr 2023 01:49:54 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230403164954epcas5p479e24f0be726ba8ae0b4439d5c9aec04~SesQ0kobc1090310903epcas5p4d;
        Mon,  3 Apr 2023 16:49:54 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230403164954epsmtrp140b039c58fcf608a0c59c4322aeaaa0e~SesQz3mWj0733307333epsmtrp1F;
        Mon,  3 Apr 2023 16:49:54 +0000 (GMT)
X-AuditID: b6c32a4a-909fc7000000d97e-6f-642b03b2e5b1
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FB.03.18071.1B30B246; Tue,  4 Apr 2023 01:49:53 +0900 (KST)
Received: from alimakhtar04 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230403164951epsmtip11f29f0837703acfdf7a3090bdfe5a4cc~SesOSXQk72305723057epsmtip1-;
        Mon,  3 Apr 2023 16:49:50 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>
Cc:     "'Vincent Whitchurch'" <vincent.whitchurch@axis.com>,
        "'kernel test robot'" <lkp@intel.com>,
        "'Dan Carpenter'" <error27@gmail.com>
In-Reply-To: <20230403094017.9556-1-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH] clocksource/drivers/exynos_mct: explicitly return 0 for
 shared timer
Date:   Mon, 3 Apr 2023 22:19:48 +0530
Message-ID: <039c01d9664c$5070aed0$f1520c70$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLFTgOcK4F+54gjrrz1BLD8nfdf7gIYFz+/rTE62hA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFJsWRmVeSWpSXmKPExsWy7bCmlu4mZu0Ug1UnRCzmfZa1eLTMz2Lv
        663sFpseX2O1uLxrDpvFjPP7mCxeNT9is9i8aSqzxflt/g6cHtfXBXjsnHWX3WPxnpdMHneu
        7WHzeHfuHLvH5iX1Hp83yQWwR2XbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp
        5CXmptoqufgE6Lpl5gBdpaRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMCnQK07M
        LS7NS9fLSy2xMjQwMDIFKkzIzuhu2MJecE6gouHJbdYGxme8XYycHBICJhJd53ezdzFycQgJ
        7GaUOHHuO5TziVHiwNdFzBDON0aJdzPeM8G0TPh6lwkisZdRovlHDyOE85JRYsL5vWBVbAK6
        EjsWt7GBJEQEOpkktjd+A6tiFuhglLhx+z8jSBWngLPEocsrWEFsYYFoiZ7Xv8C6WQRUJD5u
        nQZWwytgKdHQ95MFwhaUODnzCZjNLCAvsf3tHGaImxQkfj5dBjZHRMBKYntrByNEjbjEy6NH
        wD6SEFjLIdH65x8jRIOLxL7dv1khbGGJV8e3sEPYUhIv+9uAbA4g20Ni0R8piHCGxNvl66Fa
        7SUOXJnDAlLCLKApsX6XPsQqPone30+YIDp5JTrahCCqVSWa311lgbClJSZ2d7PCDO+8nTKB
        UXEWkr9mIflrFpL7ZyHsWsDIsopRMrWgODc9tdi0wCgvtRwe4cn5uZsYwYlWy2sH48MHH/QO
        MTJxMB5ilOBgVhLhVe3SShHiTUmsrEotyo8vKs1JLT7EaAoM7InMUqLJ+cBUn1cSb2hiaWBi
        ZmZmYmlsZqgkzqtuezJZSCA9sSQ1OzW1ILUIpo+Jg1OqgSlCwcz57/Zgo/KwjNupp9n/eBmW
        9h/v28jy4txUNudjuo57fCRmXvkhdXDmPLXNq5PV9uqb5f+25/kTOs88dtnUS7termXdxyc8
        y2uvptyyylcsbsz/rq7j0urT3La08dklv017Qyu3JSuqLtocJKGtt5lfP9w6M/pTitAXYeEC
        pd7c4wHrH55m05eOO2v+ac3DRG7VrfP55Ks1aqfe8rznuObl1lNzhTfdTM069Fc77EVsa+30
        +wLHu29KrOQ5OW2X07KOShHRuMWXgg9+WLF//a3zNdd28YcXTd+3xHPrMjnGqN4jJ74oyuWz
        C6WtY7A+uF9zXcq311+TowOPaMhfLv5dtML8+ptXpzTPiT9WYinOSDTUYi4qTgQAIlTXVT0E
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsWy7bCSnO5GZu0UgyfTLC3mfZa1eLTMz2Lv
        663sFpseX2O1uLxrDpvFjPP7mCxeNT9is9i8aSqzxflt/g6cHtfXBXjsnHWX3WPxnpdMHneu
        7WHzeHfuHLvH5iX1Hp83yQWwR3HZpKTmZJalFunbJXBldDdsYS84J1DR8OQ2awPjM94uRk4O
        CQETiQlf7zJ1MXJxCAnsZpR41n2GBSIhLXF94wR2CFtYYuW/52C2kMBzRoll5yNBbDYBXYkd
        i9vYQJpFBHqZJFYvuAbmMAt0MUqcvtfDCDF2ClDH6pesIC2cAs4Shy6vALOFBSIlds09yghi
        swioSHzcOg3M5hWwlGjo+8kCYQtKnJz5BMjmAJqqJ9G2EayEWUBeYvvbOcwQ1ylI/Hy6DGyk
        iICVxPbWDqgacYmXR4+wT2AUnoVk0iyESbOQTJqFpGMBI8sqRsnUguLc9NxiwwLDvNRyveLE
        3OLSvHS95PzcTYzgaNPS3MG4fdUHvUOMTByMhxglOJiVRHhVu7RShHhTEiurUovy44tKc1KL
        DzFKc7AoifNe6DoZLySQnliSmp2aWpBaBJNl4uCUamBqvSrrmsG4f/fUrt/2/jk6AZJb/HW2
        Lom8XLNv+uSAVx3yU1NOW4kd2fKj2mPL/SlpWkW95ocnX3rnv+zIn2/7jeVX77VX3NL3VDRl
        eYsgexsTX5yhwm4eu8snRZ4t+KI/PauZJ8nOrcvCb5fj1WONn9xep7otvlbweas1w4mW4x/Z
        FymVOTPeMzh5cc7qNSu9NPavrIz91MBycfZiC4bsaXzsQv+ai1o+31B31Lis7FnWqfeg/sWV
        xo4a/qzH2dM0hN461e6cuyziYv7VqY92RnQZaro41UWdfuI9XbYn8OBC7bQPPHpa3e94n96V
        Wc1ufjxuzrPv5mKqgf2x1X9+c9vo3HyxQ8biLV/fhpVKLMUZiYZazEXFiQAm5kN7JQMAAA==
X-CMS-MailID: 20230403164954epcas5p479e24f0be726ba8ae0b4439d5c9aec04
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230403094023epcas5p3cb0690c9984ce4d80ede8483a312be4d
References: <CGME20230403094023epcas5p3cb0690c9984ce4d80ede8483a312be4d@epcas5p3.samsung.com>
        <20230403094017.9556-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzysztof

> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: Monday, April 3, 2023 3:10 PM
> To: Daniel Lezcano <daniel.lezcano@linaro.org>; Thomas Gleixner
> <tglx@linutronix.de>; Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org>;
> Alim Akhtar <alim.akhtar@samsung.com>; linux-kernel@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.org
> Cc: Vincent Whitchurch <vincent.whitchurch@axis.com>; kernel test robot
> <lkp@intel.com>; Dan Carpenter <error27@gmail.com>
> Subject: [PATCH] clocksource/drivers/exynos_mct: explicitly return 0 for
> shared timer
> 
> For a shared timers, the mct_init_dt() should not initialize the clock
even with
> global comparator.  This is not an error, thus the function should simply
> return 0, not 'ret'.
> 
> This also fixes smatch warning:
> 
>   drivers/clocksource/exynos_mct.c:635 mct_init_dt() warn: missing error
> code? 'ret'
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Link: https://lore.kernel.org/r/202304021446.46XVKag0-lkp@intel.com/
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

>  drivers/clocksource/exynos_mct.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/exynos_mct.c
> b/drivers/clocksource/exynos_mct.c
> index bfd60093ee1c..ef8cb1b71be4 100644
> --- a/drivers/clocksource/exynos_mct.c
> +++ b/drivers/clocksource/exynos_mct.c
> @@ -677,17 +677,17 @@ static int __init mct_init_dt(struct device_node
> *np, unsigned int int_type)
>  	if (ret)
>  		return ret;
> 
>  	/*
>  	 * When the FRC is shared with a main processor, this secondary
>  	 * processor cannot use the global comparator.
>  	 */
>  	if (frc_shared)
> -		return ret;
> +		return 0;
> 
>  	return exynos4_clockevent_init();
>  }
> 
> 
>  static int __init mct_init_spi(struct device_node *np)  {
>  	return mct_init_dt(np, MCT_INT_SPI);
> --
> 2.34.1


