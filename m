Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C058663B67
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 09:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237898AbjAJIj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 03:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237825AbjAJIjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 03:39:21 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BBED65
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 00:39:19 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230110083916euoutp02e5e5e3c7af09b5bc8bf13ebcea8700f6~45dMFpuVv2586525865euoutp02c
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 08:39:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230110083916euoutp02e5e5e3c7af09b5bc8bf13ebcea8700f6~45dMFpuVv2586525865euoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1673339956;
        bh=flRUX4TXNKSuq6zxzZbc4RMO77h5oBaEM+JJT0NzPuQ=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=o7kkEarM1CznXX7RJ6r94lN+FiErcCw8U6N+KM0lFWdBb9PLN4u28xJJa62EMUqby
         fbhjf6VIc18HL+e60cAThZ/ttssss6V92lfjiIvRyuYDXIJqrA0rK9Sbdqvta2D49N
         5XTNT4mkIFPlD5U3etdvtQ0rxnU7vgZMCC1sP6CQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230110083915eucas1p2e373a528e893339a83cb5c74002c3856~45dLp5blg2209722097eucas1p2M;
        Tue, 10 Jan 2023 08:39:15 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 49.35.43884.3342DB36; Tue, 10
        Jan 2023 08:39:15 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230110083915eucas1p18a4b032bf44b21f8733d0280acbf8688~45dLNThQk0606106061eucas1p1C;
        Tue, 10 Jan 2023 08:39:15 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230110083915eusmtrp2096c2edc072337b430b2b22f8dc0805f~45dLMeU5A2380423804eusmtrp27;
        Tue, 10 Jan 2023 08:39:15 +0000 (GMT)
X-AuditID: cbfec7f5-25bff7000000ab6c-0b-63bd24331d39
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 31.EC.23420.2342DB36; Tue, 10
        Jan 2023 08:39:14 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230110083914eusmtip26c71070d1d01301789f4728eca911ea0~45dK-lUgV3238632386eusmtip2A;
        Tue, 10 Jan 2023 08:39:14 +0000 (GMT)
Received: from [192.168.8.107] (106.210.248.241) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Tue, 10 Jan 2023 08:39:13 +0000
Message-ID: <01349d02-123d-3c49-bd92-8b8b3c645e1c@samsung.com>
Date:   Tue, 10 Jan 2023 09:39:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.4.2
Subject: Re: [PATCH 5/7] dm-zoned: ensure only power of 2 zone sizes are
 allowed
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
CC:     <axboe@kernel.dk>, <kernel@pankajraghav.com>,
        <linux-kernel@vger.kernel.org>, <hare@suse.de>,
        <bvanassche@acm.org>, <snitzer@kernel.org>, <dm-devel@redhat.com>,
        <damien.lemoal@opensource.wdc.com>,
        <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
        <gost.dev@samsung.com>, Luis Chamberlain <mcgrof@kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <20230110065623.GD10289@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.241]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGKsWRmVeSWpSXmKPExsWy7djP87rGKnuTDda8k7NYfbefzWLah5/M
        Fr/Pnme22PtuNqvFnkWTmCxWrj7KZPG36x6TxZmXn1ks9t7Stri8aw6bxfxlT9ktbkx4ymhx
        4pa0A6/H5SveHpfPlnpsWtXJ5rF5Sb3H7psNbB47W++zepxd6ejxft9VoPDpao/Pm+Q82g90
        MwVwR3HZpKTmZJalFunbJXBl/N91nLmgk7li/7br7A2MG5m6GDk5JARMJOb/ns3excjFISSw
        glFi/+/1UM4XRomLH5azQjifGSVanoCUQbQ0H+thhkgsZ5S4uvgSO1zVs5lXoTK7GSVWfloL
        1sIrYCfx/tkeVhCbRUBVYtaJRawQcUGJkzOfsIDYogJREk0XfoLZwgJBEk9fv2IDsZkFxCVu
        PZkPdq2IgJLE01dnGUEWMAs0Mkt8+HEfyOHgYBPQkmjsBNvFKaAjce/2L1aIXk2J1u2/2SFs
        eYntb+cwQ7ygLLH4wjVGCLtWYu2xM2AfSAhc45Q4sPosG0TCReLOm5VQRcISr45vgfpfRuL/
        zvnQ4KuWeHrjNzNEcwujRP/O9WwgB0kIWEv0ncmBqHGUWLN4FQtEmE/ixltBiHv4JCZtm848
        gVF1FlJQzELy8iwkL8xC8sICRpZVjOKppcW56anFxnmp5XrFibnFpXnpesn5uZsYgUnv9L/j
        X3cwrnj1Ue8QIxMH4yFGCQ5mJRHelZx7koV4UxIrq1KL8uOLSnNSiw8xSnOwKInzztg6P1lI
        ID2xJDU7NbUgtQgmy8TBKdXAlL704LdApc9rp2S8U7VgFmRwfZnUv/O3q03/g7K4HraKoEu/
        OlgLPfOlAh8z1GlF/V2QUhZxyj/DWPdMyFFPCZtpYYa/9aX7r5R+sszcbLGt2PhhW/XsDaZ7
        jgfaVr5/MmMym5nJseCviYtlV+xgX+XaVVsdZZl4qvuZ++fElfliDBwPt60v0M7+YXdxzpKj
        Ut6CnB1vHy51C1RflcdQHvR7jkluyfdFJnITbzjdXRB2yze+neP3ytDp348G2XnWv2RY8H5a
        kpL8zYiMif/KoqMOz6uQaH9w1ND63n6BKZ4H+0Q3pWt+yL7LzJRn/HJTnNZZZ2bD0Kr/d5IX
        OEy2C2B0OiZtyfhBRNtzRbISS3FGoqEWc1FxIgAjtb2z6QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkleLIzCtJLcpLzFFi42I5/e/4PV0jlb3JBhuf2VisvtvPZjHtw09m
        i99nzzNb7H03m9Viz6JJTBYrVx9lsvjbdY/J4szLzywWe29pW1zeNYfNYv6yp+wWNyY8ZbQ4
        cUvagdfj8hVvj8tnSz02repk89i8pN5j980GNo+drfdZPc6udPR4v+8qUPh0tcfnTXIe7Qe6
        mQK4o/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQy
        /u86zlzQyVyxf9t19gbGjUxdjJwcEgImEs3Hepi7GLk4hASWMkpMufUNKiEj8enKR3YIW1ji
        z7UuNhBbSOAjo8TShUIQDbsZJS7eucYIkuAVsJN4/2wPK4jNIqAqMevEIlaIuKDEyZlPWEBs
        UYEoiZvnH4ItEBYIknj6+hXYUGYBcYlbT+aDxUUElCSevjrLCLKAWaCRWeLDj/uMEJvvMkq8
        3azZxcjBwSagJdHYCXYcp4COxL3bv1gh5mhKtG7/zQ5hy0tsfzuHGeIBZYnFFyDulBColXh1
        fzfjBEbRWUjOm4XkjFlIRs1CMmoBI8sqRpHU0uLc9NxiQ73ixNzi0rx0veT83E2MwDSx7djP
        zTsY5736qHeIkYmD8RCjBAezkgjvSs49yUK8KYmVValF+fFFpTmpxYcYTYFhNJFZSjQ5H5io
        8kriDc0MTA1NzCwNTC3NjJXEeT0LOhKFBNITS1KzU1MLUotg+pg4OKUamFY9nvJ2UUf15svC
        pv7K74QrP7xbbxrAInmnwyY76Kf9xhPVaaz8D9UtvJ1mMTzzNGCzCJi7raxlW/t9uePHd/3Y
        8rD32WG9RMMO/0PRvVvsj/HIrRcXceOZcfjh+RW9zoFTP29Z9DPlyprlizbM+Tev58P6mR3r
        EgrUToZ3TP3nybVyyUez7VsCT8Z6TVPks5G8EWIt7Gi8N/7uBZlq8b6N/dqHU2oj/4ea9mX5
        f19+aNYclnSlzL2PVyX4zH5zn7Hw5Mdd+yKezTTu33xz1VTj1ZoFqxeaJQic2ajMG3Vt4p1u
        I8FEdc6FZi7C/cnped5fDxw9Jd+19cKOJfzyc0+KajLcYfSY4GWg84b1fLASS3FGoqEWc1Fx
        IgD1OIivnAMAAA==
X-CMS-MailID: 20230110083915eucas1p18a4b032bf44b21f8733d0280acbf8688
X-Msg-Generator: CA
X-RootMTR: 20230106083322eucas1p2414f1f7f121fbbd7a0e5e1b1b622f5c0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230106083322eucas1p2414f1f7f121fbbd7a0e5e1b1b622f5c0
References: <20230106083317.93938-1-p.raghav@samsung.com>
        <CGME20230106083322eucas1p2414f1f7f121fbbd7a0e5e1b1b622f5c0@eucas1p2.samsung.com>
        <20230106083317.93938-6-p.raghav@samsung.com>
        <20230110065623.GD10289@lst.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-10 07:56, Christoph Hellwig wrote:
> Given that we don't even support the non pow of 2 zones in the block
> layer I don't see why this is needed.  But either way it doesn't really
> seem to fit into this series.

You are right. It is just an extra stop gap, but it is not needed as block
layer does not support pow of 2 anyway! I will remove this patch in the
next version.
