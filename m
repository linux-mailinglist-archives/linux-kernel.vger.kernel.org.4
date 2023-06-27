Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D7B73F693
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 10:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjF0INw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 04:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjF0INs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 04:13:48 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D419310FD
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 01:13:44 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230627081342euoutp026e16084c3ea5ee0b47aa7f427c46f89c~sde053Bx-2769527695euoutp02M
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 08:13:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230627081342euoutp026e16084c3ea5ee0b47aa7f427c46f89c~sde053Bx-2769527695euoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1687853622;
        bh=njysLWEP0e6FF3MtvXFCrxNi9ni9M9hIdPjIuY1RnZ0=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=lpZKCq7KOStTTfpIy7vJwCdqZgXx4EU30b6l83qQZJbi9hCOd6d39LHMr49KwnOe3
         Vs1XGgxeLnDSXWUIfHaZ8Vm+xmgdxNnl+mWSVJBkA5TgvRPt1s8XGld1JeIV/Bs3kz
         frj09L2OZNmUFpUHp7qCF5pgtvcVBVAIUbofkR4A=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230627081341eucas1p1f6aad210e064b7d03b6a6d01c22c6583~sde0p7bbx3249332493eucas1p1y;
        Tue, 27 Jun 2023 08:13:41 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id F2.CC.42423.53A9A946; Tue, 27
        Jun 2023 09:13:41 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230627081341eucas1p185627d4dacd7db98ddd624397d82bd01~sde0Sifr_2670026700eucas1p1_;
        Tue, 27 Jun 2023 08:13:41 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230627081341eusmtrp1061de97063c20e101557bd1caded7778~sde0R6OJR2558825588eusmtrp1J;
        Tue, 27 Jun 2023 08:13:41 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-4e-649a9a35f6fe
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 74.64.14344.53A9A946; Tue, 27
        Jun 2023 09:13:41 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230627081341eusmtip2b41b258f9d6bc89a7936d066c1a2b88a~sde0IfJX11115211152eusmtip28;
        Tue, 27 Jun 2023 08:13:41 +0000 (GMT)
Received: from localhost (106.110.32.140) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Tue, 27 Jun 2023 09:13:40 +0100
Date:   Tue, 27 Jun 2023 10:13:39 +0200
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     Damien Le Moal <dlemoal@kernel.org>
CC:     Min Li <min15.li@samsung.com>, <axboe@kernel.dk>,
        <willy@infradead.org>, <hch@lst.de>, <gregkh@linuxfoundation.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] block: add check that partition length needs to be
 aligned with block size
Message-ID: <20230627081339.fv76swi3srqdfpra@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8ea3bdfb-f2d9-ee5e-f623-02b2b134490d@kernel.org>
X-Originating-IP: [106.110.32.140]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRmVeSWpSXmKPExsWy7djP87qms2alGDT/0rNYfbefzeLBfnuL
        5sXr2SxWrj7KZLH3lrbF5V1z2Cx+/5jD5sDusXmFlsfls6Uem1Z1snnsn7uG3WP3zQY2j8+b
        5ALYorhsUlJzMstSi/TtErgy3i58wFKwhLNi8p03zA2MK9i7GDk5JARMJK59n8TSxcjFISSw
        glHi0IbdjBDOF0aJB8dboZzPjBJtN3awwLTMn/ERqmU5UGLvJTa4qncbt7BDOFsYJSa//cME
        0sIioCrxas0ToAQHB5uAlkRjJ9hyEQF1iamT94CtYBbYxSix7sYOsISwQIpEW8NBsHW8AuYS
        c+6vZ4KwBSVOznwCFmcW0JFYsPsTG8hMZgFpieX/OEBMTgE7ic89yRCHKkk0bD4DdXStxKkt
        t5hAVkkIvOCQOHShARoALhJ7Vk2BsoUlXh3fAmXLSJye3APVXC3x9MZvZojmFkaJ/p3rwfZK
        CFhL9J3JgahxlDh3dAo7RJhP4sZbQYgr+SQmbZvODBHmlehoE4KoVpNYfe8NywRG5VlI/pqF
        5K9ZCH8tYGRexSieWlqcm55abJiXWq5XnJhbXJqXrpecn7uJEZhsTv87/mkH49xXH/UOMTJx
        MB5ilOBgVhLhFfsxPUWINyWxsiq1KD++qDQntfgQozQHi5I4r7btyWQhgfTEktTs1NSC1CKY
        LBMHp1QDk5j9xOX/T+r0F9x7lJRyOStuv9T7VS1v5m7Y/iP0xqr/Te+k8zz1Zc2Nd7/Z+Oi+
        jG66rPDbeSvkPQvkzebHXNgbKjTzlbqe7Yu2p1kWyUJdxpF3BdcdcGWXfnTowCH1KykXHkvl
        P7arU8vRZl+64OXjtaIHRX8XGWl9aL7J53zq20aJvLfBx74/Mgk6mPuitvH3UbGnZoa5uhf7
        52/z1VmUvKCt96n16fA5Ms9atyTUOfc3yLeIW19QX8J9+UThxFvrbKeaPrrwW9lggrJTv7Hu
        7WfeC60rnt0JNjr6V1lWNfJe6Mz2B6IvKq946oc58U7VeatY3iZQs4tZqX2z4cHupJ3TKt2f
        m521OTWfV4mlOCPRUIu5qDgRAKMqYjGlAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsVy+t/xe7qms2alGGz7LGax+m4/m8WD/fYW
        zYvXs1msXH2UyWLvLW2Ly7vmsFn8/jGHzYHdY/MKLY/LZ0s9Nq3qZPPYP3cNu8fumw1sHp83
        yQWwRenZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehl
        vF34gKVgCWfF5DtvmBsYV7B3MXJySAiYSMyf8ZGli5GLQ0hgKaPExIs3WSESMhIbv1yFsoUl
        /lzrYoMo+sgoMen3aShnC6PEkz/XGEGqWARUJV6teQI0loODTUBLorETbIOIgLrE1Ml7GEHq
        mQV2MUqsu7EDLCEskCLR1nCQBcTmFTCXmHN/PRPE0AOMEitn3GWHSAhKnJz5BKyIWUBHYsHu
        T2wgC5gFpCWW/+MAMTkF7CQ+9yRDHKok0bD5DAuEXSvx+e8zxgmMwrOQDJqFZNAshEELGJlX
        MYqklhbnpucWG+kVJ+YWl+al6yXn525iBEbdtmM/t+xgXPnqo94hRiYOxkOMEhzMSiK8Yj+m
        pwjxpiRWVqUW5ccXleakFh9iNAWGxERmKdHkfGDc55XEG5oZmBqamFkamFqaGSuJ83oWdCQK
        CaQnlqRmp6YWpBbB9DFxcEo1MHGU/q2QWnD2RoD3euZ7pl9sokyuOa3b+aP9556eoOnngsU1
        NxZsvP9dcvmPsLqdJtXBkzKYNJMmd0w0CfxtNzt33u5NYe1X6g0WSiw8uocvtb6I79hW2cNb
        Tb94sDb+qTL9frk8Ym184oXLyjxCQkfvvreu+nNCqcnndsOJWYaKNYt3/2FPmuZnELVjwdNN
        dR93OF6+EXdHXfWd6xpB3TcXd99ROLTzuE2brdXlnkDzy2vsH3nHa7q8ZY6/kf/y2Qql8rCv
        7iLPGfzlLqxtmjMjRuD6t+RLb3k6Z4k7rGVOeLAy7cmhUgnHmDW8Z9jvNZyNv/BwcXDXh9Y3
        HvNt7mwLktsel7dVa6b8OwaBKdpKLMUZiYZazEXFiQDfySdtQwMAAA==
X-CMS-MailID: 20230627081341eucas1p185627d4dacd7db98ddd624397d82bd01
X-Msg-Generator: CA
X-RootMTR: 20230627031105epcas5p3010432ebd447ad865c3ddd986b3ffee0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230627031105epcas5p3010432ebd447ad865c3ddd986b3ffee0
References: <CGME20230627031105epcas5p3010432ebd447ad865c3ddd986b3ffee0@epcas5p3.samsung.com>
        <20230627110918.7608-1-min15.li@samsung.com>
        <8ea3bdfb-f2d9-ee5e-f623-02b2b134490d@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 01:39:26PM +0900, Damien Le Moal wrote:
> > diff --git a/block/ioctl.c b/block/ioctl.c
> > index 3be11941fb2d..c40b382dd58f 100644
> > --- a/block/ioctl.c
> > +++ b/block/ioctl.c
> > @@ -33,14 +33,18 @@ static int blkpg_do_ioctl(struct block_device *bdev,
> >  	if (op == BLKPG_DEL_PARTITION)
> >  		return bdev_del_partition(disk, p.pno);
> >  
> > +	/* check if partition is aligned to blocksize */
> > +	if (p.start & (bdev_logical_block_size(bdev) - 1))
> > +		return -EINVAL;
> > +	/* check if length is aligned to blocksize */
> > +	if (p.length & (bdev_logical_block_size(bdev) - 1))
> > +		return -EINVAL;
> 
> 	long long blksz_mask = bdev_logical_block_size(bdev) - 1;
> 
> 	/* Check that the partition is aligned to the block size */
> 	if ((p.start & blksz_mask) || (p.length & blksz_mask))
> 		return -EINVAL;

A Minor nit on top of your comment:

 	unsigned int blksz = bdev_logical_block_size(bdev);
 
 	/* Check that the partition is aligned to the block size */
 	if (!IS_ALIGNED(p.start, blksz) || !IS_ALIGNED(p.length, blksz))
 		return -EINVAL;

> 
> would be cleaner and avoid the rather redundant comments.
> 
