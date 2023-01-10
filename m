Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09F2663C48
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 10:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237727AbjAJJIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 04:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbjAJJHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 04:07:44 -0500
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D0B1928E
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 01:07:43 -0800 (PST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230110090742euoutp01115c7866297ed1fb589e0f3b4707787d~452BMiaRD2097520975euoutp01I
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 09:07:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230110090742euoutp01115c7866297ed1fb589e0f3b4707787d~452BMiaRD2097520975euoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1673341662;
        bh=o+giZ6ZsTJM1PUdxZPeAGar6MHU0r4gqFQa9vJ7qTAU=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=je26LrxsfdhuDVNTkpPCJVWZvJjwX+r7ajOW2KYWqvwIGAR4Boo1ZH9vkr8Gmzf5d
         /hXy/4AZ1C399tvNWxh3TBF9FwxrPATr15F9QQpM8uWB8QSAONHgQpAQAgEizfGe9a
         78ihi0RcDPBiqxJrVclRq6FiDpCE0lno422fZZag=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230110090741eucas1p268f7edd43ca3cc1add67c5d5414783c7~452A21kvo1958119581eucas1p2u;
        Tue, 10 Jan 2023 09:07:41 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 87.2B.56180.DDA2DB36; Tue, 10
        Jan 2023 09:07:41 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230110090741eucas1p1229ff3d8b068f9c57600dd66b17a8fee~452AgWK6E3000830008eucas1p1f;
        Tue, 10 Jan 2023 09:07:41 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230110090741eusmtrp25716c7022b1f247716cfe020d353d9d6~452AfequV0846108461eusmtrp2F;
        Tue, 10 Jan 2023 09:07:41 +0000 (GMT)
X-AuditID: cbfec7f2-ab5ff7000000db74-a3-63bd2adde7cf
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 07.B7.52424.DDA2DB36; Tue, 10
        Jan 2023 09:07:41 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230110090741eusmtip2bd7da5505bd54e69f59038dae194b4f0~452ASt--q1643616436eusmtip2P;
        Tue, 10 Jan 2023 09:07:41 +0000 (GMT)
Received: from [192.168.8.107] (106.210.248.241) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Tue, 10 Jan 2023 09:07:40 +0000
Message-ID: <35293c0c-2d72-c4ee-2296-079d56df7d5b@samsung.com>
Date:   Tue, 10 Jan 2023 10:07:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.4.2
Subject: Re: [PATCH 7/7] dm: call dm_zone_endio after the target endio
 callback for zoned devices
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
CC:     <axboe@kernel.dk>, <kernel@pankajraghav.com>,
        <linux-kernel@vger.kernel.org>, <hare@suse.de>,
        <bvanassche@acm.org>, <snitzer@kernel.org>, <dm-devel@redhat.com>,
        <damien.lemoal@opensource.wdc.com>,
        <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
        <gost.dev@samsung.com>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <20230110065822.GF10289@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.241]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKKsWRmVeSWpSXmKPExsWy7djPc7p3tfYmG3xYbmGx+m4/m8W0Dz+Z
        LX6fPc9ssffdbFaLPYsmMVmsXH2UyeLMy88sFntvaVtc3jWHzWL+sqfsFiduSTtwe1y+4u1x
        +Wypx6ZVnWwem5fUe+y+2cDmsbP1PqvH2ZWOHu/3XQUKn672+LxJLoArissmJTUnsyy1SN8u
        gStj4ZpbbAWLOCv2N1xia2Dcxt7FyMkhIWAiMXdhO3MXIxeHkMAKRomvHQ1QzhdGiQ+HZjBB
        OJ8ZJXq+/GGFaTn+7jgrRGI5o0TLm242uKpFe9rBBgsJ7GaUOL+0FMTmFbCTuPFxIguIzSKg
        KtGx4zQTRFxQ4uTMJ2BxUYEoiaYLP8FsYYFkiR1XdoPVMAuIS9x6Mh/MFhFQknj66iwjRHwF
        k8T8/bpdjBwcbAJaEo2dYGs5BXQkuk8sZIEo0ZRo3f6bHcKWl9j+dg4zxAPKEosvXGOEsGsl
        1h47ww5yv4TAZk6JE7862CASLhJrDt2FahCWeHV8CzTAZCT+74S4R0KgWuLpjd/MEM0tjBL9
        O9ezgRwkIWAt0XcmB6LGUWL/+RuMEGE+iRtvBSHu4ZOYtG068wRG1VlIITELycezkLwwC8kL
        CxhZVjGKp5YW56anFhvmpZbrFSfmFpfmpesl5+duYgSmtNP/jn/awTj31Ue9Q4xMHIyHGCU4
        mJVEeFdy7kkW4k1JrKxKLcqPLyrNSS0+xCjNwaIkzjtj6/xkIYH0xJLU7NTUgtQimCwTB6dU
        A5PaqoWyPz+ZHr3FZnpZ00bQKvrDpU2/7M4srVYpkfVg8tcKUG3I93+6bN6+rbY3aq/y/Oiq
        L9vReHGm/1K5W+9ZP9p+9El3ZlvywWlh9d/l+6YLqdtmTtBfF3x+mYfqF75Tx0StrKfKNvE9
        cd5dEJeWkOytm+seqXTCe7LsjAZhltIFu1qW9pbvqZ76YNm0m8LXjt7IESpzfF9ifallq7WQ
        iHjY//0rbSMXL5lx+yz/jte2r9JZtdZwqQluOlUS/9Qq3N9w3s1PsgZui4reLc45Xr6vQvhq
        L/PftVXaz2YVz487nn1M6UBhbsR+yd65aamf1N+KGcTL2vUw3PYwiEh6dPZqUsD0rJM8Pa9y
        XZRYijMSDbWYi4oTAcZw7AfYAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNIsWRmVeSWpSXmKPExsVy+t/xe7p3tfYmG9y/JGex+m4/m8W0Dz+Z
        LX6fPc9ssffdbFaLPYsmMVmsXH2UyeLMy88sFntvaVtc3jWHzWL+sqfsFiduSTtwe1y+4u1x
        +Wypx6ZVnWwem5fUe+y+2cDmsbP1PqvH2ZWOHu/3XQUKn672+LxJLoArSs+mKL+0JFUhI7+4
        xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS9j4ZpbbAWLOCv2N1xia2Dc
        xt7FyMkhIWAicfzdcdYuRi4OIYGljBJ3F81mhUjISHy68hGqSFjiz7UuNoiij4wSG1sbmCGc
        3YwSl67uYgKp4hWwk7jxcSILiM0ioCrRseM0VFxQ4uTMJ2BxUYEoiZvnH4LFhQWSJXZc2Q1m
        MwuIS9x6Mh/MFhFQknj66iwjRHwFk8T8/boQy+4ySnxYvBMowcHBJqAl0dgJdh2ngI5E94mF
        LBD1mhKt23+zQ9jyEtvfzmGG+EBZYvGFa4wQdq3Eq/u7GScwis5Cct4sJGfMQjJqFpJRCxhZ
        VjGKpJYW56bnFhvpFSfmFpfmpesl5+duYgSmgm3Hfm7Zwbjy1Ue9Q4xMHIyHGCU4mJVEeFdy
        7kkW4k1JrKxKLcqPLyrNSS0+xGgKDKOJzFKiyfnAZJRXEm9oZmBqaGJmaWBqaWasJM7rWdCR
        KCSQnliSmp2aWpBaBNPHxMEp1cC0KqGz/pqQHYOEe8ptb8WVn2uOfdn1bUPhVfYXty8duedr
        95Nt51atRwVxC/d8L5UzKXhodCFxzZW39w99TDc3mBOc0XXl9V/92d4q6yQtRE40sk7Y7yfm
        tmDDkXcSu1d6N/I/f7jIXovNT9/yQGNr3Ia3XxoWBDKunRrud+IYh/4Hlnq/8t8yb37wF8oU
        RaiopjC++nLySoPokoc93bOFkqad7eU79GRlXHpDHbPxtcdr97C7HQ25v/l781ZxP7nNis90
        LwusdU11dP/Icknrwu20DQs0HPs6rRY/9/Zb+vOr3rvLX8zCfL1PNz5yfqr1UX0W5781T47/
        XrM+4XOxhOA9/9lvzvQdEtDqTzP9rMRSnJFoqMVcVJwIAHkoaTWOAwAA
X-CMS-MailID: 20230110090741eucas1p1229ff3d8b068f9c57600dd66b17a8fee
X-Msg-Generator: CA
X-RootMTR: 20230106083323eucas1p2f0f6d5d5c1c3713be35b841157ae463e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230106083323eucas1p2f0f6d5d5c1c3713be35b841157ae463e
References: <20230106083317.93938-1-p.raghav@samsung.com>
        <CGME20230106083323eucas1p2f0f6d5d5c1c3713be35b841157ae463e@eucas1p2.samsung.com>
        <20230106083317.93938-8-p.raghav@samsung.com>
        <20230110065822.GF10289@lst.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-10 07:58, Christoph Hellwig wrote:
> On Fri, Jan 06, 2023 at 09:33:17AM +0100, Pankaj Raghav wrote:
>> dm_zone_endio() updates the bi_sector of orig bio for zoned devices that
>> uses either native append or append emulation, and it is called before the
>> endio of the target. But target endio can still update the clone bio
>> after dm_zone_endio is called, thereby, the orig bio does not contain
>> the updated information anymore.
>>
>> Currently, this is not a problem as the targets that support zoned devices
>> such as dm-zoned, dm-linear, and dm-crypt do not have an endio function,
>> and even if they do (such as dm-flakey), they don't modify the
>> bio->bi_iter.bi_sector of the cloned bio that is used to update the
>> orig_bio's bi_sector in dm_zone_endio function.
>>
>> Call dm_zone_endio for zoned devices after calling the target's endio
>> function.
> 
> This looks sensible, but I fail to see why we need this or how it fits
> into the earlier block layer part of the series.
>


I just extracted the cleanup from my old series. Do you think it is better
to send it as a separate patch instead of adding it along in this series?

