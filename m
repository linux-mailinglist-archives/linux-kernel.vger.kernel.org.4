Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0CF6E07FC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 09:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjDMHov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 03:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjDMHoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 03:44:44 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F475FC6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 00:44:43 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230413074440euoutp024ad45522b1d9b3d51b08bac82936be11~VbtErF4C22907529075euoutp02G
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 07:44:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230413074440euoutp024ad45522b1d9b3d51b08bac82936be11~VbtErF4C22907529075euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681371880;
        bh=8dEyPEwXKxBUieX+Qihco0jNrXZiJPC2PsDaemkKwmI=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=Iu2BHwyU85OQ6xuKXR2/JSFEZUBYA1hB1L0sMfUwmcALzgjgWfQF4YpAmHAO6PfTt
         cGLASrZ2RE0rG8QApIfDHv0JZVQ3Rs/z2IGwubVWIYl8kmrlUgRUHFMfiIOdlJnJGg
         XDQgOLph69PTDxx2yfKLJwssM+DO4r6Aig69ACXU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230413074440eucas1p180d95f85f5407be3e0243f652227f566~VbtEcTUcg1707617076eucas1p1N;
        Thu, 13 Apr 2023 07:44:40 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 3C.FE.09503.8E2B7346; Thu, 13
        Apr 2023 08:44:40 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230413074439eucas1p25d23761c3300b53b160cc0120745a06b~VbtECdTUS1804818048eucas1p2U;
        Thu, 13 Apr 2023 07:44:39 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230413074439eusmtrp2afe266260441473188b84258d13b8ceb~VbtEBsrIZ1217012170eusmtrp2A;
        Thu, 13 Apr 2023 07:44:39 +0000 (GMT)
X-AuditID: cbfec7f2-e8fff7000000251f-12-6437b2e8c5b3
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 5A.6C.34412.7E2B7346; Thu, 13
        Apr 2023 08:44:39 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230413074439eusmtip264495d35b3c5abf2b24f9e7e2405ad92~VbtD400K_1422914229eusmtip2p;
        Thu, 13 Apr 2023 07:44:39 +0000 (GMT)
Received: from [192.168.8.209] (106.210.248.243) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Thu, 13 Apr 2023 08:44:38 +0100
Message-ID: <aed50785-3eaf-3e5c-d208-5e5ccbc51096@samsung.com>
Date:   Thu, 13 Apr 2023 09:44:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.9.0
Subject: Re: [PATCH v2] scripts/gdb: use mem instead of core_layout to get
 the module address
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     <jan.kiszka@siemens.com>, <kbingham@kernel.org>,
        <gost.dev@samsung.com>, <linux-kernel@vger.kernel.org>,
        <song@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>
Content-Language: en-US
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <ZDdSd8iB2n6r/ccB@bombadil.infradead.org>
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.243]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42LZduznOd0Xm8xTDOZt5LX49e4Iu8W9mzeZ
        LU51b2ayuLxrDpvFjQlPGS2OL//L5sDmsXPWXXaPTas62Ty2n5zE5PF5k1wASxSXTUpqTmZZ
        apG+XQJXxuWZ25gKtvJUHPr7gb2BcTlXFyMnh4SAicT1m1sZuxi5OIQEVjBK3Hj5lwnC+cIo
        sXD9N1YI5zOjxOyN15m7GNnBWpY6QISXM0r8bHnECjIJrKZrZxxEYjejxLxrDWAJXgE7iSPH
        WhhBbBYBVYlTMzcyQsQFJU7OfMICYosKREn03d4EVM/BISwQL/H1WwRIWERAQ2LfhF6wg5gF
        VjNK/OlYDzaTWUBc4taT+Uwg9WwCWhKNnewgYU4BM4l71z8zQZTIS2x/O4cZpERCQFmi/YAC
        xMO1Eqe23AIbKSHwhUNiw9yJ7BA1LhJTdiRD1AhLvDq+hR3ClpH4v3M+E4RdLfH0xm9miN4W
        Ron+nevZIHqtJfrO5ICYzAKaEut36UOUO0rs6z/AAlHBJ3HjrSDEYXwSk7ZNZ57AqDoLKRhm
        IXlrFpL7ZyEMXcDIsopRPLW0ODc9tdgwL7Vcrzgxt7g0L10vOT93EyMwzZz+d/zTDsa5rz7q
        HWJk4mA8xCjBwawkwvvDxTRFiDclsbIqtSg/vqg0J7X4EKM0B4uSOK+27clkIYH0xJLU7NTU
        gtQimCwTB6dUA1OT/H495u4aD8mCN7b/WURSZF61rBaWltPOEnz8S++3csg0zVKH65r3Y4P/
        r1nrorUsijNTKKT0YADT5YI3Ygynjc6Ui7ns9z/O/Gxx+rLcMzwmD5fduGL67cLt75k+Xhcz
        z3BWdG7e7scitMmtlMeX8+4NecUjnqcLlv+z+Je15tbz4D9ilaW5KcvftP5u3lPw1oIh1/uF
        LMP56OQYheKGWGd/p+rPd8V/Fvpe7pDTydCOexvb+VBtoXjg90w5SeNJYdNOfDE9m7Cs2eX+
        cqHZy70/nj5SNe/b7tIIRtcfTpV7Z29YVRJwMfl6qMf3u706V8X3y+jwX1/2fXtzzX7BKXfz
        62a6tHvVtVuXK7EUZyQaajEXFScCAHPY4e2iAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRmVeSWpSXmKPExsVy+t/xe7rPN5mnGPydZWjx690Rdot7N28y
        W5zq3sxkcXnXHDaLGxOeMlocX/6XzYHNY+esu+wem1Z1snlsPzmJyePzJrkAlig9m6L80pJU
        hYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jMsztzEVbOWpOPT3
        A3sD43KuLkZ2DgkBE4mlDl2MXBxCAksZJRo+fmbsYuQECstIbPxylRXCFpb4c62LDaLoI6PE
        z+OrmSGc3YwSF19MYgOp4hWwkzhyrAWsm0VAVeLUzI2MEHFBiZMzn7CA2KICURKfD7Swg9jC
        AvESO+5PAdsgIqAhsW9CLxPIUGaB1YwSfzrWs8Jt+NjVwwRSxSwgLnHryXwgm4ODTUBLorET
        bBCngJnEveufoUo0JVq3/2aHsOUltr+dwwxSLiGgLNF+QAHim1qJz3+fMU5gFJ2F5LxZSBbM
        QjJpFpJJCxhZVjGKpJYW56bnFhvpFSfmFpfmpesl5+duYgTG6bZjP7fsYFz56qPeIUYmDsZD
        jBIczEoivD9cTFOEeFMSK6tSi/Lji0pzUosPMZoCw2gis5Rocj4wUeSVxBuaGZgamphZGpha
        mhkrifN6FnQkCgmkJ5akZqemFqQWwfQxcXBKNTD1NJ7hZ29f/UXaMTWP81hvTqvu1XlPz8+T
        85X8Ghv5VW9G/MZwpmwucdVDzfp9/Rbujkeif+0zZnT4U/Lszc6oOdeEpxS5tv/dqfvY/5x6
        dshpVsNFDy3CepVqbJ8f4lGqEJE+et9twVKr03IMDwzCMrUXVm96/XqV7ry8dUf6vkptmXJg
        Z+592UcR0yvmlN95qHwsy+azSetTXfVH5ktO7NTYqGSuMyF6jsH9xm+rFbVKGdatY+5Z7p5+
        eo1SxokQ5fjJf9h/Zszz543qvKAa4Fs/c94f46VzP86O3bPr1519+48/u1YozZ36dlGR+IWS
        N9mmUzdOvNAtln3L/1aGessGT8tvvX8uxOmtUz6kxFKckWioxVxUnAgAkan+KFwDAAA=
X-CMS-MailID: 20230413074439eucas1p25d23761c3300b53b160cc0120745a06b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230412203420eucas1p2efd38df12efde2ca05c6b3a26f5a753b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230412203420eucas1p2efd38df12efde2ca05c6b3a26f5a753b
References: <CGME20230412203420eucas1p2efd38df12efde2ca05c6b3a26f5a753b@eucas1p2.samsung.com>
        <20230412202516.1027149-1-p.raghav@samsung.com>
        <ZDdSd8iB2n6r/ccB@bombadil.infradead.org>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-13 02:53, Luis Chamberlain wrote:
> On Wed, Apr 12, 2023 at 10:25:18PM +0200, Pankaj Raghav wrote:
>> commit ac3b43283923 ("module: replace module_layout with module_memory")
>> changed the struct module data structure from module_layout to
>> module_memory. The core_layout member which is used while loading
>> modules are not available anymore leading to the following error while
>> running gdb:
>>
>> (gdb) lx-symbols
>> loading vmlinux
>> Python Exception <class 'gdb.error'>: There is no member named core_layout.
>> Error occurred in Python: There is no member named core_layout.
>>
>> Replace core_layout with its new counterpart mem[MOD_TEXT].
>>
>> Fixes: ac3b43283923 ("module: replace module_layout with module_memory")
>> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
>> ---
>>  scripts/gdb/linux/constants.py.in | 3 +++
>>  scripts/gdb/linux/modules.py      | 4 ++--
>>  scripts/gdb/linux/symbols.py      | 4 ++--
>>  3 files changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/scripts/gdb/linux/constants.py.in b/scripts/gdb/linux/constants.py.in
>> index 36fd2b145853..471300ba176c 100644
>> --- a/scripts/gdb/linux/constants.py.in
>> +++ b/scripts/gdb/linux/constants.py.in
>> @@ -62,6 +62,9 @@ LX_GDBPARSED(hrtimer_resolution)
>>  LX_GDBPARSED(IRQD_LEVEL)
>>  LX_GDBPARSED(IRQ_HIDDEN)
>>  
>> +/* linux/module.h */
>> +LX_GDBPARSED(MOD_TEXT)
> 
> Should we just fill in the rest of the other sections too while at it?
> 

I don't see them used in the scripts. Maybe we can add them when needed?

>   Luis
