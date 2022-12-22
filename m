Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B016541D0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 14:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235438AbiLVNWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 08:22:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235418AbiLVNW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 08:22:27 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69282EF90
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 05:20:33 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20221222132019euoutp02bd1f5035ddf6e29191f1e4aac81d11f4~zICKAP1Z30132001320euoutp02C
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 13:20:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20221222132019euoutp02bd1f5035ddf6e29191f1e4aac81d11f4~zICKAP1Z30132001320euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1671715219;
        bh=pG1ibTo4oQRJXGreb+pAMAGSlhe0dRM4G6+QAiuRdOQ=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=YLqd+BCTsSxQ3AqKYhWAkedSU6ttF36jluDxHAxqX9AfN249Faby7yhurBCtpUFkC
         fkhb+JCeAcm4bO3NaJFKI9AVTQDo1Af8vqxzPV92sClvcFY1iBHMcnp6aAsA1cRwPD
         V+Z+th1jgTVZqCQ/OEZIXQYGjGLTdcKk/5KG5fY0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20221222132018eucas1p2bf3c7f06d8e71900ff26fd8837e534a3~zICJrE6_g0663806638eucas1p21;
        Thu, 22 Dec 2022 13:20:18 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 57.BC.43884.29954A36; Thu, 22
        Dec 2022 13:20:18 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20221222132018eucas1p2e8e5d79a0e8869ddf7148a7d07fb149e~zICJGP4zO1902619026eucas1p2m;
        Thu, 22 Dec 2022 13:20:18 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221222132018eusmtrp1b72df63d68961e1a800d2f1692ec6084~zICJFgW_32832028320eusmtrp1I;
        Thu, 22 Dec 2022 13:20:18 +0000 (GMT)
X-AuditID: cbfec7f5-271ff7000000ab6c-29-63a459926396
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 87.54.23420.29954A36; Thu, 22
        Dec 2022 13:20:18 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221222132017eusmtip1b926e83ecd93027e7b642c3daa51e2f6~zICIUN95r0324103241eusmtip1r;
        Thu, 22 Dec 2022 13:20:17 +0000 (GMT)
Message-ID: <3751c425-aefa-a3b4-62f4-53d7e369bc1e@samsung.com>
Date:   Thu, 22 Dec 2022 14:20:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [PATCH 1/2] iommu/exynos: Abstract getting the fault info
Content-Language: en-US
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Janghyuck Kim <janghyuck.kim@samsung.com>,
        Cho KyongHo <pullip.cho@samsung.com>,
        Daniel Mentz <danielmentz@google.com>,
        David Virag <virag.david003@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <CAPLW+4mPeX-cQR_oLKh+zPwEXuwfQtk2t2USP77C6Y9UmgYq_w@mail.gmail.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMKsWRmVeSWpSXmKPExsWy7djPc7qTIpckG9x9b2AxoaOVyeLXFwuL
        zXOKLTpnb2C32Pt6K7vFpsfXWC0u75rDZjHj/D4mi3+9BxktDn54wmrxvA/IPXX3M7vF8feP
        GS1a7pg68Hk8OTiPyWPNvDWMHjtn3WX3WLCp1GPTqk42jzvX9rB5bF5S7/Fi80xGj74tqxg9
        Pm+SC+CK4rJJSc3JLEst0rdL4Mo4t9a9YKVsxa+lt5gbGK+JdzFyckgImEgsnHOdtYuRi0NI
        YAWjxK2vlxghnC+MEmvvvGMCqRIS+MwoseyJAEzHsqufoDqWM0rc710P5XwE6rj4jxWkilfA
        TmJv52sWEJtFQFXiztWJjBBxQYmTM5+AxUUFUiRWvV3GDGILC7hJbD87BSzOLCAucevJfLDN
        IgJ6EutmvmKHiH9glljwSAnEZhMwlOh628UGYnMKBEq87p7KBFEjL7H97RxmiEvXc0psaPeA
        sF0kLjXeZoKwhSVeHd/CDmHLSJye3MMC8oCEQDujxILf95kgnAmMEg3PbzFCVFlL3Dn3C2gb
        B9AGTYn1u/Qhwo4S36btAwtLCPBJ3HgrCHEDn8SkbdOZIcK8Eh1tQhDVahKzjq+DW3vwwiXm
        CYxKs5BCZRaS72ch+WYWwt4FjCyrGMVTS4tz01OLjfNSy/WKE3OLS/PS9ZLzczcxAtPd6X/H
        v+5gXPHqo94hRiYOxkOMEhzMSiK8Wx4vThbiTUmsrEotyo8vKs1JLT7EKM3BoiTOO2Pr/GQh
        gfTEktTs1NSC1CKYLBMHp1QDk9B5gzPu7CIfZzX/+fRiRch18/Azj7m1Yh4ucm+fvM3y0tcN
        998vjVd7Y2WkvZA3pbTkUt7n6NLY/22i5nndHKvEki9/P5NjpxtV0L1gw4vNat85bnzUbPWb
        YGN4da3w+pJ/WQJvUzrdHdjltwlFaZxawfnf7O7pm88T3YO87aOuNvW1+3G5d2iHV2ef0X1t
        8N5RQ23VY46FVQuU1F1KHvN/m37qRy13766KXefeOR04uuv0z6szn/EVCGZOLWp1WLySaY5z
        eKZgX2Tio0Or3t0/FHhU6SBzSe3pz0LPslduiMr/0T3lH0PnteeTTltXntytd0zzv+AFsaij
        G3uvXv9/Vzi0tTXl58V283jZQiWW4oxEQy3mouJEAOpN6iXmAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOIsWRmVeSWpSXmKPExsVy+t/xu7qTIpckG/xZwWYxoaOVyeLXFwuL
        zXOKLTpnb2C32Pt6K7vFpsfXWC0u75rDZjHj/D4mi3+9BxktDn54wmrxvA/IPXX3M7vF8feP
        GS1a7pg68Hk8OTiPyWPNvDWMHjtn3WX3WLCp1GPTqk42jzvX9rB5bF5S7/Fi80xGj74tqxg9
        Pm+SC+CK0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL
        0Ms4t9a9YKVsxa+lt5gbGK+JdzFyckgImEgsu/qJFcQWEljKKHHqsT1EXEbi5LQGVghbWOLP
        tS62LkYuoJr3jBI/F39hA0nwCthJ7O18zQJiswioSty5OpERIi4ocXLmE7C4qECKxMvLLWC2
        sICbxPazU8BsZgFxiVtP5jOB2CICehLrZr5iB1nALPCJWaLh8Q6obT3MErNebwfrYBMwlOh6
        2wW2mVMgUOJ191QmiElmEl1buxghbHmJ7W/nME9gFJqF5JBZSBbOQtIyC0nLAkaWVYwiqaXF
        uem5xYZ6xYm5xaV56XrJ+bmbGIExvu3Yz807GOe9+qh3iJGJg/EQowQHs5II75bHi5OFeFMS
        K6tSi/Lji0pzUosPMZoCQ2Mis5Rocj4wyeSVxBuaGZgamphZGphamhkrifN6FnQkCgmkJ5ak
        ZqemFqQWwfQxcXBKNTAdTbvsvv2nzpz75aZahk0Kqs+XLlo0WZxtCvP1M/9zXpx5EhHZyLjy
        0fyzijEcB7hPMP5oY1U7OXvuopsfRHqyef9+F/dcKj1zkdn04yu0N12I+94oej+7aNOaQzyL
        Z8d6nXcsYGUW3LP42ladswVFPyZE1B0/pePetSgsO0bj8WulK+aTpNWLbiXqXLJ0UMo5enz3
        dMl4eyuTF+mrjhr+b9naeP/ArHgRv+eH6h23XJtyVWShzIfswikBfLPWPuP+unDp7jDua0Kr
        5/zdMTm1QPH0pwf7M6dOZl3ieLzkoaBP4toVxtJnHZcd+d7V9GPV5emWkWYnP716GW0wWel6
        5vI9ucWJrPOS2X1v+13/x6XEUpyRaKjFXFScCAB2Z492egMAAA==
X-CMS-MailID: 20221222132018eucas1p2e8e5d79a0e8869ddf7148a7d07fb149e
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
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.12.2022 22:32, Sam Protsenko wrote:
> Hi Marek,
>
> On Mon, 24 Oct 2022 at 09:43, Sam Protsenko <semen.protsenko@linaro.org> wrote:
>> Hi Marek,
>>
>> On Fri, 12 Aug 2022 at 14:25, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>>> Hi Sam,
>> [snip]
>>
>>>> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
>>> I'm not very happy with converting the sysmmu_fault_info arrays into the
>>> decoding functions. If I got the code right, adding v7 is still possible
>>> with the current approach. The main advantage of the array-based
>>> approach is readability and keeping all the information together in a
>>> single place.
>>>
>>> I agree for the items listed above as 'minor functional changes',
>>> though. Those sysmmu_fault_info arrays might be a part of sysmmu hw
>>> variant to avoid decoding hw version for each fault.
>>>
>>> I'm not sure that the linear scan is so problematic with regards to the
>>> performance. You really don't want your drivers to trigger IOMMU fault
>>> so often during normal operation. It is just a way to get some debugging
>>> information or handle some exception.
>>>
>>> You mentioned that the transaction type is read from the separate
>>> register in case of v7, but your code (here and in second patch) still
>>> relies on the reported interrupt bits.
>>>
>>> Could you try to rework all your changes in a such way, that the
>>> sysmmu_fault_info arrays are still used? V7 is really very similar to
>>> the v5 already supported by the current driver.
>>>
>> That's actually how I implemented this patch on my first attempt.
>> Really didn't like it, because a half of existing sysmmu_fault_info
>> structure doesn't make sense for v7, and some functionality of v7 has
>> to be implemented separately from that structure. I'd argue that
>> previous abstraction is just broken, and doesn't work for all SysMMU
>> versions anymore. It's easy to see how much difference between v5 and
>> v7, just by looking at corresponding get_fault_info() functions I
>> implemented. For example, the transaction type is probed from
>> different registers using different version, etc. There is also the
>> need to handle new VM/non-VM registers on v7. Also there is some extra
>> functionality that will be added later, like multiple translation
>> domains support, which is also quite different from how things done
>> for v5.
>>
>> I'd show more specifics to demonstrate my statements above, but alas I
>> already deleted my initial implementation (which was exactly what you
>> suggest). This callback-style HAL seems to be a perfect choice, and I
>> spent several days just experimenting with different approaches and
>> seeing all pros and cons. And from my point of view, this way is the
>> best for providing actual solid abstraction, which doesn't require
>> adding any workarounds on top of that. I understand that my patch
>> changes the very conception of how IRQ is handled in this driver, but
>> I'm still convinced it's a proper way to do that for all v1/v5/v7,
>> especially w.r.t. further v7 additions, to keep the abstraction solid.
>> Not that I'm lazy and don't want to rework things :) But in this
>> particular case I'd go with unchanged patches.
>>
>> Do you think it's reasonable to take this series as is? I can try and
>> collect more particular code snippets to demonstrate my point, if you
>> like.
>>
>> Thanks!
> So, what do you think about this?

Okay, go ahead with your approach. If I find a better way, I will rework 
it then. I would just like to have the code for fault handling for hw 
v1, v5 and v7 similar as much as possible.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

