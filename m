Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051B564B43F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 12:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbiLMLdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 06:33:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234860AbiLMLdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 06:33:05 -0500
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CDD167F3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 03:33:02 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20221213113300euoutp01f0bcc1aceee2a6e25af5ac768a7c73a1~wVw5L5VLt3119231192euoutp01h
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 11:33:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20221213113300euoutp01f0bcc1aceee2a6e25af5ac768a7c73a1~wVw5L5VLt3119231192euoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1670931180;
        bh=GWlKbT51HpBnFtB9eCRCm5UsJLYbwGnOyZSuSyWXyvM=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=lykxvOOWrPLcoQWKnCUpxzd8v63GXoViLw1kWm923K3eiW4QskfN+7A/tIntPJQhf
         Unx8rVwXWeLDtw0Nm6Z84Z5obACUsZpI6RzUaGcgA9taQqkhh/eFW1gsKrcGJu22TK
         YDS952CdY7cxZyIp40HoG7xpkxrWLsurd2TASYJo=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20221213113300eucas1p17d6efbbc2bf2ab5d4468a96368a2cefe~wVw4xrkuC3106731067eucas1p1t;
        Tue, 13 Dec 2022 11:33:00 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 59.43.09549.CE268936; Tue, 13
        Dec 2022 11:33:00 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20221213113259eucas1p1c224898772bc5e59de90c1aa65a34de0~wVw4Uxwi00626006260eucas1p1y;
        Tue, 13 Dec 2022 11:32:59 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221213113259eusmtrp291348dac2ff05b31a5224d1aa6f304b1~wVw4T0FQ03275132751eusmtrp27;
        Tue, 13 Dec 2022 11:32:59 +0000 (GMT)
X-AuditID: cbfec7f5-f5dff7000000254d-69-639862ec7628
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 7E.0A.09026.BE268936; Tue, 13
        Dec 2022 11:32:59 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20221213113258eusmtip2cc0370484eb751b7e520ae3161b23a98~wVw3ZMnhV0156401564eusmtip2h;
        Tue, 13 Dec 2022 11:32:58 +0000 (GMT)
Message-ID: <dd329b51-f11a-2af6-9549-c8a014fd5a71@samsung.com>
Date:   Tue, 13 Dec 2022 12:32:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH v2] regulator: core: Use different devices for resource
 allocation and DT lookup
Content-Language: en-US
To:     cy_huang <u0084500@gmail.com>, broonie@kernel.org
Cc:     djrscally@gmail.com, hdegoede@redhat.com, markgross@kernel.org,
        lgirdwood@gmail.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, yangyingliang@huawei.com,
        gene_chen@richtek.com, chiaen_wu@richtek.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        ChiYuan Huang <cy_huang@richtek.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <1670311341-32664-1-git-send-email-u0084500@gmail.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDKsWRmVeSWpSXmKPExsWy7djPc7pvkmYkGxxaz27x8+U0RoupD5+w
        Waw9qW/xZU8/q8W2w+9YLZ70nGO1eHN8OpPFtysdTBabHl9jtbi8aw6bRde1J6wWB6ZOY7aY
        93ctq8XqPS+YLSatu8dkseXTNSYHAY+n/VvZPXbOusvu0XLkLavHplWdbB6bl9R7vN93lc1j
        xqcpbB4H9xl6fN4kF8AZxWWTkpqTWZZapG+XwJXxcp5QwSKxiq9fH7A0MP4U6GLk5JAQMJFY
        8+caexcjF4eQwApGifVvnzJBOF8YJQ4vmMoG4XxmlPi0cCsjTMvsZf8ZIRLLGSXufJrLCuF8
        ZJTYs3QPM0gVr4CdxPzdrUA2BweLgKrE9qN8EGFBiZMzn7CA2KICKRIHdp5lArGFBdIknu1v
        ZQOxmQXEJW49mQ8WFxEwlTh98y7YScwCc5klHqyfDtbMJmAo0fW2C6yBU8BZYt6EjYwQzfIS
        29/OYQZpkBDYzinxahfENgkBF4llx35A2cISr45vYYewZST+75zPBNHQziix4Pd9KGcCo0TD
        81tQT1tL3Dn3iw3kHWYBTYn1u/Qhwo4SR98fAwtLCPBJ3HgrCHEEn8SkbdOZIcK8Eh1tQhDV
        ahKzjq+DW3vwwiXmCYxKs5DCZRaS/2cheWcWwt4FjCyrGMVTS4tz01OLjfNSy/WKE3OLS/PS
        9ZLzczcxAhPg6X/Hv+5gXPHqo94hRiYOxkOMEhzMSiK8qhrTkoV4UxIrq1KL8uOLSnNSiw8x
        SnOwKInzrpjSkSwkkJ5YkpqdmlqQWgSTZeLglGpgmqdxIeBVxN2FWdYim95YHFX9cuTuhRNH
        5rx0SJqx1PhPzzOdKJ3Al1Me7rdbIcT+PPrEDqv1k1XEnB2usn/nkNPNkf1V6d9uYL8/xrlg
        ue33pEVPrk+Je5agYc/te9vxZuSkmx923dwWtjF2Z9ZzoflFm//O5Vtd4LrmnMfe/V2qwUvS
        Uu5d1OxMPiZwVXax8HU/UWH5/p3xp75rXv/AJsZmsy6dd4pa/9Ia28D6ypIPn3X7TjyQZZNj
        6/ziUVAZ9KaNz1QlK2uXZCHb4vqgvYIP+8uc+d8m7Q68u7mxqis89nZT24Zbiv8FL2ov2Zw9
        923LvpC3VzanO9YIqLA+tP6Xx72ALbeOd+VD+bzZSizFGYmGWsxFxYkAvoecwu8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsVy+t/xe7qvk2YkGzybpmrx8+U0RoupD5+w
        Waw9qW/xZU8/q8W2w+9YLZ70nGO1eHN8OpPFtysdTBabHl9jtbi8aw6bRde1J6wWB6ZOY7aY
        93ctq8XqPS+YLSatu8dkseXTNSYHAY+n/VvZPXbOusvu0XLkLavHplWdbB6bl9R7vN93lc1j
        xqcpbB4H9xl6fN4kF8AZpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eT
        kpqTWZZapG+XoJfxcp5QwSKxiq9fH7A0MP4U6GLk5JAQMJGYvew/YxcjF4eQwFJGiYnb77JB
        JGQkTk5rYIWwhSX+XOtigyh6zyix5t4sJpAEr4CdxPzdrcxdjBwcLAKqEtuP8kGEBSVOznzC
        AmKLCqRItPf8AysXFkiTeLa/FWw+s4C4xK0n88HiIgKmEqdv3mUCmc8sMJdZ4uSp44wgCSEB
        J4mNO1+DNbAJGEp0ve0CszkFnCXmTdjICDHITKJraxeULS+x/e0c5gmMQrOQ3DELyb5ZSFpm
        IWlZwMiyilEktbQ4Nz232EivODG3uDQvXS85P3cTIzDetx37uWUH48pXH/UOMTJxMB5ilOBg
        VhLhVdWYlizEm5JYWZValB9fVJqTWnyI0RQYFhOZpUST84EJJ68k3tDMwNTQxMzSwNTSzFhJ
        nNezoCNRSCA9sSQ1OzW1ILUIpo+Jg1OqgalrkYz7s4vGqb8ke/Ykn+C94Dhjr6/Ejqs5osUa
        IQYXtuQERWr+VZds3DL/skGOU3dp1JPlW8/kLgs7/qph4qsm3cT760Pl5TKPZbX/nM6q8Pe0
        3LlVbm7OrvnJT7cXV4ZvDE5m+RdWk598Z7GG0eHLz21WxC64fiOgsWZ22/p8U6kTn+2jM176
        OInr7710t6+ZK0tR8Uyr2M5qqQ9qijeEsgs32Hgtzn+mkLBIJG/Sa9OZKnc2a3ldej+tNmbX
        0TOMB3XMG+9tZTHLN878ff3mrzPxhXd1bhjYHj+fdrNgSWhDj3Vp/a3zqkFVnEYs5uW+B2Pf
        PFvFVtI5T9dQTvPjC3Nht8Nn/7+JfZKlpsRSnJFoqMVcVJwIAPjy5aGAAwAA
X-CMS-MailID: 20221213113259eucas1p1c224898772bc5e59de90c1aa65a34de0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20221213113259eucas1p1c224898772bc5e59de90c1aa65a34de0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221213113259eucas1p1c224898772bc5e59de90c1aa65a34de0
References: <1670311341-32664-1-git-send-email-u0084500@gmail.com>
        <CGME20221213113259eucas1p1c224898772bc5e59de90c1aa65a34de0@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

On 06.12.2022 08:22, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
>
> Following by the below discussion, there's the potential UAF issue
> between regulator and mfd.
> https://lore.kernel.org/all/20221128143601.1698148-1-yangyingliang@huawei.com/
>
> >From the analysis of Yingliang
>
> CPU A				|CPU B
> mt6370_probe()			|
>    devm_mfd_add_devices()	|
> 				|mt6370_regulator_probe()
> 				|  regulator_register()
> 				|    //allocate init_data and add it to devres
> 				|    regulator_of_get_init_data()
> i2c_unregister_device()		|
>    device_del()			|
>      devres_release_all()	|
>        // init_data is freed	|
>        release_nodes()		|
> 				|  // using init_data causes UAF
> 				|  regulator_register()
>
> It's common to use mfd core to create child device for the regulator.
> In order to do the DT lookup for init data, the child that registered
> the regulator would pass its parent as the parameter. And this causes
> init data resource allocated to its parent, not itself. The issue happen
> when parent device is going to release and regulator core is still doing
> some operation of init data constraint for the regulator of child device.
>
> To fix it, this patch expand 'regulator_register' API to use the
> different devices for init data allocation and DT lookup.
>
> Reported-by: Yang Yingliang <yangyingliang@huawei.com>
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>


This patch landed in linux-next 202212 as commit 8f3cbcd6b440 
("regulator: core: Use different devices for resource allocation and DT 
lookup"). Unfortunately it causes serious regression on my test systems. 
It looks that some supplies are not resolved correctly and then turned 
off as 'unused', even if they provide power to other core regulators in 
the system. I've observed this issue on Samsung Chromebook Peach-Pit and 
Peach-Pi (ARM 32bit Exynos based). The symptoms are somehow similar to 
the issue reported here some time ago:

https://lore.kernel.org/all/58b92e75-f373-dae7-7031-8abd465bb874@samsung.com/

I've post more information once I analyze this issue further.


> ---
> loop Yang Yingliang in cc list.
>
> Since v2
> - Fix typo 'int3742' to 'int3472' for kernel build test
>
> ---
>   drivers/platform/x86/intel/int3472/clk_and_regulator.c | 3 ++-
>   drivers/regulator/core.c                               | 8 ++++----
>   drivers/regulator/devres.c                             | 2 +-
>   drivers/regulator/of_regulator.c                       | 2 +-
>   drivers/regulator/stm32-vrefbuf.c                      | 2 +-
>   include/linux/regulator/driver.h                       | 3 ++-
>   6 files changed, 11 insertions(+), 9 deletions(-)
>
> ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

