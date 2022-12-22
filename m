Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A030B65445D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 16:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiLVPe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 10:34:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiLVPey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 10:34:54 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF07D15F14
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 07:34:51 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20221222153448euoutp021a9501ce76a632aa2960abd2f29ab076~zJ3kxFpJx1686416864euoutp02T
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 15:34:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20221222153448euoutp021a9501ce76a632aa2960abd2f29ab076~zJ3kxFpJx1686416864euoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1671723288;
        bh=XX+9SmKEg+cXS57bzc0fTtmKQ3zPVGFXFn0xXKarshI=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=rS3uQ9YxTeFoypKwpRMKEKMg3+MLO+53iD552gGcGpj8uXA6WdaXUJQsjcNeN9fWw
         esV2P0EnnH/t0T5MkAJbJvwfXb3B9Yuf1JpSb6vEH6OnUcv8ixcAMegWv0u3tBz/tU
         dtP0DBnHMtzZXLjOx7A7rh8c3DZ4DeKduVPeIEgQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20221222153447eucas1p22dc03e0831b223e2cd2bc027ebed746a~zJ3kgU-bj2381423814eucas1p2K;
        Thu, 22 Dec 2022 15:34:47 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 33.38.61936.71974A36; Thu, 22
        Dec 2022 15:34:47 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20221222153447eucas1p2c1148ca6e9d92d7a61327a81e19ca028~zJ3kJdBVW2393623936eucas1p2S;
        Thu, 22 Dec 2022 15:34:47 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221222153447eusmtrp26f85bad0c1c75fdd77436f026c4eea11~zJ3kIuYDL0886508865eusmtrp2e;
        Thu, 22 Dec 2022 15:34:47 +0000 (GMT)
X-AuditID: cbfec7f4-a2dff7000002f1f0-1d-63a479171c30
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D7.E6.23420.71974A36; Thu, 22
        Dec 2022 15:34:47 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20221222153446eusmtip2d4fa2ae06e15b46f74e2a127eeff84fc~zJ3jYn2X93267932679eusmtip2h;
        Thu, 22 Dec 2022 15:34:46 +0000 (GMT)
Message-ID: <5757a45f-0685-a82b-edd6-ae5c98781ad3@samsung.com>
Date:   Thu, 22 Dec 2022 16:34:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [PATCH 1/2] iommu/exynos: Abstract getting the fault info
Content-Language: en-US
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Janghyuck Kim <janghyuck.kim@samsung.com>,
        Cho KyongHo <pullip.cho@samsung.com>,
        Daniel Mentz <danielmentz@google.com>,
        David Virag <virag.david003@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <CAPLW+4=-cqQPmQi57_ARn1C6LqK+LffrFEgLqi6Lwb=YJ7sRSw@mail.gmail.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKKsWRmVeSWpSXmKPExsWy7djPc7rilUuSDdbPMrCY0NHKZPHri4XF
        5jnFFp2zN7Bb7H29ld1i0+NrrBaXd81hs5hxfh+Txb/eg4wWBz88YbV43gfknrr7md3i+PvH
        jBYtd0wd+DyeHJzH5LFm3hpGj52z7rJ7LNhU6rFpVSebx51re9g8Ni+p93ixeSajR9+WVYwe
        nzfJBXBFcdmkpOZklqUW6dslcGU8vDWVqWA2W0X3PLUGxvcsXYycHBICJhJzn/cwdzFycQgJ
        rGCU+DX9NBOE84VRYuac34wQzmdGiR/rn7LDtByY0c8OkVjOKLG3ey8LhPORUeJM+xVGkCpe
        ATuJvtnfmEBsFgFVidfL97JCxAUlTs58ArZcVCBFYtXbZcwgtrCAm8T2s1PA4swC4hK3nswH
        6uXgEBEIkPj0iRtkPrPAOWaJm7cPg81kEzCU6HrbxQZicwoEShx6soEZoldeYvvbOWAPSQgs
        55RY9vUfK8TZLhInuy9BvSAs8er4FihbRuL/zvlMEA3tjBILft+HciYwSjQ8v8UIUWUtcefc
        LzaQk5gFNCXW79KHCDtKfJu2DywsIcAnceOtIMQRfBKTtk1nhgjzSnS0CUFUq0nMOr4Obu3B
        C5eYJzAqzUIKlllI3p+F5J1ZCHsXMLKsYhRPLS3OTU8tNspLLdcrTswtLs1L10vOz93ECEx5
        p/8d/7KDcfmrj3qHGJk4GA8xSnAwK4nwbnm8OFmINyWxsiq1KD++qDQntfgQozQHi5I474yt
        85OFBNITS1KzU1MLUotgskwcnFINTJP+KMU0n1qq07D5p/GX9dbxpWbvnuecOcXqHlKar8p/
        7Gi3bdOi0Mm2SipPTp4vuOdzeT33/KooF95rcXlmoic1rLZ8vLn1uZa5WcCGjLrNiW1lz3YE
        uXfunmTune//ZMXsKyZzdMLEpCSF/k8PO9jRWXtnifuWJMaF9UcXPtG4kH1QU6DaZSHHxqwF
        4tvadVsEHbYJ3CxZ4PpsaaWRe9zuHT/M/LQvZl/fxlSomP/GaeuOq7P+7lF9et+MsT7n4JtS
        fQWjCJNXH51mb9erP3uUceXNvWyNywNWa+Rurfj86OIOP53W3RYnWP49D567N66Eudonc8f8
        pbP0M15n+bDe26AhlbBSTN3riFvVbiWW4oxEQy3mouJEAFLzrSLoAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsVy+t/xe7rilUuSDVYuEbeY0NHKZPHri4XF
        5jnFFp2zN7Bb7H29ld1i0+NrrBaXd81hs5hxfh+Txb/eg4wWBz88YbV43gfknrr7md3i+PvH
        jBYtd0wd+DyeHJzH5LFm3hpGj52z7rJ7LNhU6rFpVSebx51re9g8Ni+p93ixeSajR9+WVYwe
        nzfJBXBF6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl
        6GU8vDWVqWA2W0X3PLUGxvcsXYycHBICJhIHZvSzdzFycQgJLGWU+HhpBTNEQkbi5LQGVghb
        WOLPtS42iKL3jBI/5y8DS/AK2En0zf7GBGKzCKhKvF6+FyouKHFy5hOwDaICKRIvL7eA2cIC
        bhLbz04Bs5kFxCVuPZkP1isi4CdxeNkUsCuYBS4wS7T27WaE2NbBInFv6xqwk9gEDCW63oKc
        wcnBKRAocejJBmaISWYSXVu7GCFseYntb+cwT2AUmoXkkFlIFs5C0jILScsCRpZVjCKppcW5
        6bnFhnrFibnFpXnpesn5uZsYgVG+7djPzTsY5736qHeIkYmD8RCjBAezkgjvlseLk4V4UxIr
        q1KL8uOLSnNSiw8xmgJDYyKzlGhyPjDN5JXEG5oZmBqamFkamFqaGSuJ83oWdCQKCaQnlqRm
        p6YWpBbB9DFxcEo1MDG/Dj0mNUuOW7liVfs1x5vTqu7MXcF8aZOmnFz5ZdnztxTXnfO/dFDp
        l/BRfuGNhwx8/Oq64gq0dFZknWyakXww+tSF96esf7IaJZ4VKu25GXr4evlzgTkssozcK34E
        HFpxoZd72orQfNHuiyuWu0x1eizPXx+l3RX7u0rNzH2ztvQuLl3xLqdl1i+Dzl9Pv3PTtnTP
        YuEDT9PFV7lcOffGc+rX7zf3/n/AZ2f5RvtC3GUZO56vF5dbrVtYdP66tm+Hlk2VtKe0TJy+
        6wZ9zvuPddMPuZWrnZVh4Wi9//HrjAxpZ+aGv0GCAdyHN7+uunaveOtyzncfWrs8o99Kff+h
        ktablfhv9VqH+q/r2ZRYijMSDbWYi4oTAQCoPz97AwAA
X-CMS-MailID: 20221222153447eucas1p2c1148ca6e9d92d7a61327a81e19ca028
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220726200747eucas1p226a18ed7760741ddaed94483ba1f9228
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220726200747eucas1p226a18ed7760741ddaed94483ba1f9228
References: <20220726200739.30017-1-semen.protsenko@linaro.org>
        <CGME20220726200747eucas1p226a18ed7760741ddaed94483ba1f9228@eucas1p2.samsung.com>
        <20220726200739.30017-2-semen.protsenko@linaro.org>
        <7e9e509a-0ef7-087d-e379-14fb58e3e14f@samsung.com>
        <CAPLW+4n-Lf6je61rxdJ9nJnX9h9F8F-y+qikG7eFF0avQpMV9Q@mail.gmail.com>
        <CAPLW+4mPeX-cQR_oLKh+zPwEXuwfQtk2t2USP77C6Y9UmgYq_w@mail.gmail.com>
        <3751c425-aefa-a3b4-62f4-53d7e369bc1e@samsung.com>
        <CAPLW+4=-cqQPmQi57_ARn1C6LqK+LffrFEgLqi6Lwb=YJ7sRSw@mail.gmail.com>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.12.2022 16:23, Sam Protsenko wrote:
> On Thu, 22 Dec 2022 at 07:20, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> [snip]
>
>>> So, what do you think about this?
>> Okay, go ahead with your approach. If I find a better way, I will rework
>> it then. I would just like to have the code for fault handling for hw
>> v1, v5 and v7 similar as much as possible.
>>
> Thanks, Marek!
>
> Joerg, can you please apply this series? Please let me know if I need
> to rebase it first, but I guess there shouldn't be any issues, the
> SysMMU driver doesn't seem to get updated often.

Just to makes things a bit more formal - feel free to add:

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

