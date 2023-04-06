Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8212C6D8E0A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 05:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235308AbjDFDqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 23:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235291AbjDFDqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 23:46:33 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C8D8A4D
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 20:46:28 -0700 (PDT)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230406034625epoutp015c3d3f425da8ebc0afe7fdfee08ae47b~TO8DepUo82076020760epoutp01g
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 03:46:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230406034625epoutp015c3d3f425da8ebc0afe7fdfee08ae47b~TO8DepUo82076020760epoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680752785;
        bh=F6TnWqpipLif1YaNPe5q/YfeK/PMuczMZeivqyAT7qg=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=S63a4TP0P3OvwygpAMCi7f3vFyRm0eCOGAvDPVYNSrBoUYojSCxooJiBnNpV8snzE
         C8BuROHxfayeTE689nf5ZCMBAU8YmsNkXVsEFwq+PkKZCzI4bof9mH4OU52jKKjEiq
         NAOBPEWkvJWJxc4/1iSYa6Drd1QbMUQSV7DzZv54=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20230406034624epcas1p431bbd58d390d872c94473b800d7ff1f0~TO8C9Lnqd2190321903epcas1p4P;
        Thu,  6 Apr 2023 03:46:24 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.36.222]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4PsS8w41Wsz4x9Py; Thu,  6 Apr
        2023 03:46:24 +0000 (GMT)
X-AuditID: b6c32a38-5fbfa70000029402-0e-642e40903842
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        38.EE.37890.0904E246; Thu,  6 Apr 2023 12:46:24 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH v2] dma-buf/heaps: system_heap: Avoid DoS by limiting
 single allocations to half of all memory
Reply-To: jaewon31.kim@samsung.com
Sender: =?UTF-8?B?6rmA7J6s7JuQ?= <jaewon31.kim@samsung.com>
From:   =?UTF-8?B?6rmA7J6s7JuQ?= <jaewon31.kim@samsung.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "jstultz@google.com" <jstultz@google.com>,
        "tjmercier@google.com" <tjmercier@google.com>,
        "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230405200923.9b0dca2165ef3335a0f6b112@linux-foundation.org>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230406034624epcms1p3c132d43833c9eee0bd3c470fe16cd7c3@epcms1p3>
Date:   Thu, 06 Apr 2023 12:46:24 +0900
X-CMS-MailID: 20230406034624epcms1p3c132d43833c9eee0bd3c470fe16cd7c3
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAJsWRmVeSWpSXmKPExsWy7bCmnu4EB70Ug2//ZC3mrF/DZrHw4V1m
        i9WbfC26N89ktOh9/4rJ4s+JjWwWl3fNYbO4t+Y/q8Xrb8uYLU7d/cxu8W79FzYHbo/Db94z
        e+z9toDFY+esu+weCzaVemxa1cnmsenTJHaPO9f2sHmcmPGbxaNvyypGj8+b5AK4orJtMlIT
        U1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4AuVlIoS8wpBQoF
        JBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBXoFSfmFpfmpevlpZZYGRoYGJkCFSZkZ7R/38hU
        MFG04tXCtAbGdwJdjBwcEgImEqenFnUxcnEICexglNjwdhYzSJxXQFDi7w5hEFNYoERi8m6F
        LkZOoBIlibM/rrCD2MIC1hL7F81gArHZBCwltt+cyAhiiwjoSqx6vosZZCSzwEFmiZPXJoMV
        SQjwSsxof8oCYUtLbF++FayBU8Bb4sXF2cwQcVGJm6vfssPY74/NZ4SwRSRa752FqhGUePBz
        NyPMnD/Hn7NB2MUSyzofQO2qkVhxbhVU3Fyi4e1KMJtXwFfiw8pOsBtYBFQlml5/Y4WocZGY
        +vYi2HxmAXmJ7W/ngIOBWUBTYv0ufYgSRYmdv+cyQpTwSbz72sMK89aOeU+g1qpJtDz7ChWX
        kfj77xmU7SHx6eReJkgwX2CW2LmljWUCo8IsREjPQrJ5FsLmBYzMqxjFUguKc9NTiw0LTOBR
        m5yfu4kRnHS1LHYwzn37Qe8QIxMH4yFGCQ5mJRFe1S6tFCHelMTKqtSi/Pii0pzU4kOMpkA/
        T2SWEk3OB6b9vJJ4QxNLAxMzIxMLY0tjMyVx3i9PtVOEBNITS1KzU1MLUotg+pg4OKUamOY7
        Wgl4dM35v5btKJdTYDtT5e8Mqxl7b+WazVmx5a/wXadrbkc3m6ZLzDX9V/hhG+ODx08/RoT6
        f2dSPnciomRGbky5ls+7d486Jy9l2SraeSnIbGrLhfsvZULOxU4q/WLCzNVb/ypBfW6NcI1b
        67sTyYqvd/suUl8+y0+jI/dUaqh70+v/bs/5mRZqx32xfvVJrvlUSpbP6y2qTNuNRaac/6/5
        61e6ubfLnKblNatns8odEWfc/Jv5WvXp/ijWB7KOy4UzTlxN/vQn6A3H3dpaoanVtlVatVcv
        2cuXu19v+GV1p6PsSSbH7L21L+bIVpy7aWdnY8Dx81zSnZjWKUlbyu1fK7SryqrXLLJgUmIp
        zkg01GIuKk4EAH+KRW5DBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230406000841epcas1p3630010a770682be0f1d540a448f3e00e
References: <20230405200923.9b0dca2165ef3335a0f6b112@linux-foundation.org>
        <20230405185650.239f9721f066aa480e83d543@linux-foundation.org>
        <20230405172524.e25b62e1c548a95564b1d324@linux-foundation.org>
        <20230406000854.25764-1-jaewon31.kim@samsung.com>
        <20230406014419epcms1p3f285b6e3fdbb1457db1bcbaab9e863be@epcms1p3>
        <20230406021712epcms1p216f274040d25d18380668ffbfa809c48@epcms1p2>
        <CGME20230406000841epcas1p3630010a770682be0f1d540a448f3e00e@epcms1p3>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Thu, 06 Apr 2023 11:17:12 +0900 Jaewon Kim <jaewon31.kim@samsung.com> wrote:
>
>> >> +       if (len / PAGE_SIZE > totalram_pages())
>> >> +               return ERR_PTR(-ENOMEM);
>> >
>> >We're catering for a buggy caller here, aren't we?  Are such large
>> >requests ever reasonable?
>> >
>> >How about we decide what's the largest reasonable size and do a
>> >WARN_ON(larger-than-that), so the buggy caller gets fixed?
>> 
>> Yes we're considering a buggy caller. I thought even totalram_pages() / 2 in
>> the old ion system is also unreasonable. To avoid the /2, I changed it to
>> totalram_pages() though.
>> 
>> Because userspace can request that size repeately, I think WARN_ON() may be
>> called to too often, so that it would fill the kernel log buffer.
>
>Oh geeze.  I trust that userspace needs elevated privileges of some form?
>

I'm sorry I don't know the whole Android dma-buf allocation process. AFAIK
Android apps do not allocate itself, they request dma-buf memory to the
Android system process named of Allocator. Then the Allocator seems to have
privileges to use the dma-buf heap. So normal Android apps do NOT need the
privileges.

>If so, then spamming dmesg isn't an issue - root can do much worse than
>that.
>
>> Even we think WARN_ON_ONCE rather than WARN_ON, the buggy point is not kernel
>> layer. Unlike page fault mechanism, this dma-buf system heap gets the size from 
>> userspace, and it is allowing unlimited size. I think we can't fix the buggy
>> user space with the kernel warning log. So I think warning is not enough,
>> and we need a safeguard in kernel layer.
>
>I really dislike that ram/2 thing - it's so arbitrary, hence is surely
>wrong for all cases.  Is there something more thoughtful we can do?
>
>I mean, top priority here is to inform userspace that it's buggy so
>that it gets fixed (assuming this requires elevated privileges).  And
>userspace which requests (totalram_pages()/2 - 1) bytes is still buggy,
>but we did nothing to get the bug fixed.

That ram/2 seems to be arbitrary, but I thought just ram, not ram/2, is 
reasonble as a safeguard in kernel side even after the userspace process or
common library check the abnormal size.

I thought the userspace context would get -ENOMEM either in ram case or in
__GFP_RETRY_MAYFAIL case. And -ENOMEM is enough to inform. The usespace
may not fully recognize that it is buggy though.

I'm not sure that all the userspace context use the Android libdmabufheap
library and there is no other route directly using kernel dma-buf heap
ioctl. Anyway do you think size checking code should be added to the
libdmabufheap rather than kernel side?

