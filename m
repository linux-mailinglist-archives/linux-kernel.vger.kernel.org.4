Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F401460107A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 15:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbiJQNtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 09:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiJQNtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 09:49:06 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE9E5F9BD
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 06:49:02 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20221017134857euoutp01ae78a8949b8b141ad73a7eddd4238f41~e32UUkzBN2846528465euoutp01s
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 13:48:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20221017134857euoutp01ae78a8949b8b141ad73a7eddd4238f41~e32UUkzBN2846528465euoutp01s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1666014537;
        bh=1EbOIh3VRPIcp6I0IzAFx4YxCbdHwGU6CMVd3ePZ8QI=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=nsDpB1C3inbtn/+xBSMenk13Z/RRhiS6ORDqtUFNLAZS87UCnOsJCfNdhdbOkXJBN
         C8WanEmd0l6drAJ8rr8kyr7trq9kuXV8GlyR/a4wvtQwOyh74EM3QkhTIEocNOJpw/
         UVsunpGFEbgXIt6dt7+RK8GmoINMaPiBSQicaAUk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20221017134857eucas1p23883fbac8658a6dd56e452003ce125ef~e32T-3qap0593905939eucas1p21;
        Mon, 17 Oct 2022 13:48:57 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id B3.6E.19378.84D5D436; Mon, 17
        Oct 2022 14:48:56 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20221017134856eucas1p12f978192d409c5ada476591d26e90b02~e32TblpSq2786327863eucas1p1W;
        Mon, 17 Oct 2022 13:48:56 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221017134856eusmtrp177310ba06f98bee9d28eb87d594d7daa~e32Ta2ESZ2870328703eusmtrp1T;
        Mon, 17 Oct 2022 13:48:56 +0000 (GMT)
X-AuditID: cbfec7f5-a35ff70000014bb2-b6-634d5d48a43b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 57.D0.07473.84D5D436; Mon, 17
        Oct 2022 14:48:56 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221017134855eusmtip15dcae25ed74f636cc534e4cf1dcc34d9~e32S19qZk1305613056eusmtip1h;
        Mon, 17 Oct 2022 13:48:55 +0000 (GMT)
Message-ID: <1155a694-b821-d41a-da54-8a9656d90e50@samsung.com>
Date:   Mon, 17 Oct 2022 15:48:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.3.3
Subject: Re: [PATCH] thermal/drivers/exynos: Fix NULL pointer dereference
 when getting the critical temp
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "open list:SAMSUNG THERMAL DRIVER" <linux-pm@vger.kernel.org>,
        "open list:SAMSUNG THERMAL DRIVER" 
        <linux-samsung-soc@vger.kernel.org>,
        "moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20221003132943.1383065-1-daniel.lezcano@linaro.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNKsWRmVeSWpSXmKPExsWy7djP87oesb7JBkf/mFs8mLeNzeLw/AqL
        71uuM1nM+yxrsff1VnaLTY+vsVpc3jWHzeJz7xFGixnn9zFZzP0yldniycM+Ngduj52z7rJ7
        LN7zkslj06pONo871/aweWxeUu/Rt2UVo8fnTXIB7FFcNimpOZllqUX6dglcGW1TGhgL9nJX
        PH47j7mBcSNnFyMnh4SAicT6e3fZuhi5OIQEVjBKPFz7lQXC+cIo8aH9LROE85lRYv6vX8ww
        LQ1fzkAlljNKTLs4gRHC+cgoMenjRiaQKl4BO4nr796C2SwCqhKHFuxlg4gLSpyc+YQFxBYV
        SJG4ee4DWI2wQJbE4U1fwGxmAXGJW0/mg9kiAo4SX/4uYgdZwCzwh1li6qvZYAk2AUOJrrdd
        YEM5gYr+fNnJAtEsL7H97RxmkAYJgXZOic1bF7BD3O0ise3CckYIW1ji1fEtUHEZidOTe1ig
        GhglFvy+zwThTGCUaHh+C6rDWuLOuV9A6ziAVmhKrN+lDxF2lLj84ioTSFhCgE/ixltBiCP4
        JCZtm84MEeaV6GgTgqhWk5h1fB3c2oMXLjFPYFSahRQus5D8PwvJO7MQ9i5gZFnFKJ5aWpyb
        nlpsnJdarlecmFtcmpeul5yfu4kRmL5O/zv+dQfjilcf9Q4xMnEwHmKU4GBWEuF1++KTLMSb
        klhZlVqUH19UmpNafIhRmoNFSZyXbYZWspBAemJJanZqakFqEUyWiYNTqoEpvXxy6d9gW83j
        ynYXV5S8VGTnVmFYFWwtpiSusfJt9hTetTecSp/z/XiXd80g+9jnLXXOV2e+UVnOOe3dmVl+
        Ue2F3u5v9u9Sb/qwIf7r1vMawr02MzucZBrLit7+VH+cJXolVE5WUPvMTtfUx/e2+6q6+gjP
        tirW8VtzmTe3Y8a9ojA54ScRRo8Ke3ca/5t/celP3ZPR85OOLwj6tUBr9TztPyklqX7TFTXt
        lrmfy9PLmqdtV/eLZ9154X2nIiemtR94d8XlnZShTNtmbfOAxrQCvX+LTqiLbNCyNf574eCt
        t7/m87r4pBSoaUtOzvN/8so4x2pnZ/HyObPW71rJojB76cJ/G//abctiyVyvxFKckWioxVxU
        nAgAE8vblM4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsVy+t/xu7oesb7JBnOXiVs8mLeNzeLw/AqL
        71uuM1nM+yxrsff1VnaLTY+vsVpc3jWHzeJz7xFGixnn9zFZzP0yldniycM+Ngduj52z7rJ7
        LN7zkslj06pONo871/aweWxeUu/Rt2UVo8fnTXIB7FF6NkX5pSWpChn5xSW2StGGFkZ6hpYW
        ekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GW1TGhgL9nJXPH47j7mBcSNnFyMnh4SAiUTD
        lzNMXYxcHEICSxklNj9azAaRkJE4Oa2BFcIWlvhzrYsNoug9o8TK0xvAErwCdhLX371lArFZ
        BFQlDi3YywYRF5Q4OfMJC4gtKpAisXr1XjBbWCBL4sfEy2C9zALiEreezAfrFRFwlPjydxE7
        yAJmgX/MEvtbvjNCbDvJKNHWupMRpIpNwFCi620X2AZOoI4/X3ayQEwyk+ja2sUIYctLbH87
        h3kCo9AsJIfMQrJwFpKWWUhaFjCyrGIUSS0tzk3PLTbUK07MLS7NS9dLzs/dxAiM123Hfm7e
        wTjv1Ue9Q4xMHIyHGCU4mJVEeN2++CQL8aYkVlalFuXHF5XmpBYfYjQFhsZEZinR5Hxgwsgr
        iTc0MzA1NDGzNDC1NDNWEuf1LOhIFBJITyxJzU5NLUgtgulj4uCUamASCdUtaD4kcnveyc9/
        7k0q/S7O0LhS81Xtrs3R/KJJ0+ROsxr53kw1v/HmhVRIUuXPj2cbdnI8zRAMyVDK0vxj8yOx
        yqaEo3WGT/bxJrVEj3vF/VIBXXWvo/yPPVuZcVphTnryM6Pdnz5s+pgv7LKlNuT+z4ru1tag
        matYok9KXGzNdSi2rlcVv3xb+8eBmxvqmS++eDTv+6SjW7bbPJ36dmp83xyX+mUZUra/bJyy
        3/6/u8PmrGDSRK0i7jdh0180SbzN2nhw6l8RtzifR1GvAjR2nHU02vP8W1vD5abtDFYqT+fX
        zHm9R7hZXHC2gZTF44sJS0oEHXLnbG+s11h2LWb2pmPi1TcFPB1O5b1TYinOSDTUYi4qTgQA
        rC+WC2ADAAA=
X-CMS-MailID: 20221017134856eucas1p12f978192d409c5ada476591d26e90b02
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20221003133014eucas1p1fe47bf216e05f96e946c7dcc5fc7eea9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221003133014eucas1p1fe47bf216e05f96e946c7dcc5fc7eea9
References: <4e4d873b-4a40-334a-34e7-defb0fcc4e6b@samsung.com>
        <CGME20221003133014eucas1p1fe47bf216e05f96e946c7dcc5fc7eea9@eucas1p1.samsung.com>
        <20221003132943.1383065-1-daniel.lezcano@linaro.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 03.10.2022 15:29, Daniel Lezcano wrote:
> The driver is assuming the get_critical temperature exists as it is
> inherited by the thermal of ops. But this one has been removed in
> favor of the generic one.
>
> Use the generic thermal_zone_get_crit_temp() function instead
>
> Fixes: 13bea86623b ("thermal/of: Remove of_thermal_get_crit_temp(")
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

This patch has been dropped from -next, is there are reason for that?


> ---
>   drivers/thermal/samsung/exynos_tmu.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index 5a1ffe2f3134..37465af59262 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -264,9 +264,8 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
>   	unsigned int status;
>   	int ret = 0, temp;
>   
> -	if (data->soc != SOC_ARCH_EXYNOS5433) /* FIXME */
> -		ret = tzd->ops->get_crit_temp(tzd, &temp);
> -	if (ret) {
> +	ret = thermal_zone_get_crit_temp(tzd, &temp);
> +	if (ret && data->soc != SOC_ARCH_EXYNOS5433) { /* FIXME */
>   		dev_err(&pdev->dev,
>   			"No CRITICAL trip point defined in device tree!\n");
>   		goto out;

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

