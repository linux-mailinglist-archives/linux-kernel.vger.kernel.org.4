Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5DFA740CDA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 11:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbjF1J1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 05:27:13 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:59482 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbjF1JV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 05:21:56 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230628092154epoutp02de357b4809b0db8e6354bbe262e786bc~syDqsexXX2258322583epoutp02b
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 09:21:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230628092154epoutp02de357b4809b0db8e6354bbe262e786bc~syDqsexXX2258322583epoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1687944114;
        bh=DFKREYP8QvhqCnLX8kZ+76N8U5RQgg0AMuLWLZkbtsA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XNxFUlCFhN4qnFQIQgfdH306b51wQ3QT7rRR/Adx9O/LiSqfks5AjrRoKSS6rl9ii
         5fpzqjPcA3eWER2Yzs6QlkfzN6BNEie9/gbQzxFgzNVbXqXfkm9MCMzP/eEYUC+YbZ
         Ope/APO+AI059mWgtBvjc6eTzf5ajaQXtLruMlgo=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230628092153epcas5p335202e3cc97de14979ff33d039b0081d~syDqBM0Wy1144611446epcas5p3x;
        Wed, 28 Jun 2023 09:21:53 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Qrbgh2HnSz4x9Py; Wed, 28 Jun
        2023 09:21:52 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        43.12.44250.0BBFB946; Wed, 28 Jun 2023 18:21:52 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230628090918epcas5p3a5463f0fc421e435a363192e40d3f649~sx4qtpKOz2835128351epcas5p3c;
        Wed, 28 Jun 2023 09:09:18 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230628090918epsmtrp1188161c6e054ab06fe1a1cd1ebb43ed9~sx4qs1Gs01903919039epsmtrp1W;
        Wed, 28 Jun 2023 09:09:18 +0000 (GMT)
X-AuditID: b6c32a4a-ec1fd7000000acda-51-649bfbb08f4e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        44.92.34491.EB8FB946; Wed, 28 Jun 2023 18:09:18 +0900 (KST)
Received: from ubuntu.. (unknown [109.105.118.54]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230628090917epsmtip1b4c769df6ba3c694345f8eba2e8568b2~sx4pgKZPP2088620886epsmtip1E;
        Wed, 28 Jun 2023 09:09:17 +0000 (GMT)
From:   Min Li <min15.li@samsung.com>
To:     hch@lst.de
Cc:     axboe@kernel.dk, dlemoal@kernel.org, gregkh@linuxfoundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        min15.li@samsung.com, stable@kernel.org, willy@infradead.org
Subject: Re: [PATCH v3] block: add check that partition length needs to be
 aligned with block size
Date:   Wed, 28 Jun 2023 17:07:34 +0000
Message-Id: <20230628170734.2960-1-min15.li@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230628083839.GA26606@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGJsWRmVeSWpSXmKPExsWy7bCmhu6G37NTDL7sE7BYfbefzeLBfnuL
        5sXr2Szmvr7EYrFy9VEmi723tC0u75rDZrF8VQeTxdkJH1gtPp2/wGbx+8ccNgduj80rtDwu
        ny312LSqk81j/9w17B67bzawefRtWcXo8XmTXAB7VLZNRmpiSmqRQmpecn5KZl66rZJ3cLxz
        vKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtCBSgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJb
        pdSClJwCkwK94sTc4tK8dL281BIrQwMDI1OgwoTsjJsvljEXfGequL70KVMD4wKmLkZODgkB
        E4mbhxuZuxi5OIQEdjNKLDy7khXC+cQo8envKiYI5xujxJz9Z9hgWvbdvw+V2Mso8XHtGaj+
        54wSF5/PBHI4ONgElCW2LfUBMUUE+CRu3UoFKWEWOMAosfdlMyPIIGGBFInHv2azgNgsAqoS
        Bx7OAbuJV8BCYtmT+VDL5CX2HzzLDGJzCuhIrPhzFqpGUOLkzCdgvcxANc1bZ4PdICEwkUPi
        wrL1rCCLJQRcJF4sz4SYIyzx6vgWdghbSuJlfxs7REmxxMsfYRDhGond325Dg8VaYtv6dUwg
        JcwCmhLrd+lDhGUlpp5axwSxlU+i9/cTqHJeiR3zYGwlib8XzjFC2BISi/c/hDrGQ+J0ZzRI
        WEigXuLJgi9sExgVZiH5ZRaSX2YhLF7AyLyKUTK1oDg3PbXYtMAoL7UcHsPJ+bmbGMEJVstr
        B+PDBx/0DjEycTAeYpTgYFYS4b39ZnaKEG9KYmVValF+fFFpTmrxIUZTYGBPZJYSTc4Hpvi8
        knhDE0sDEzMzMxNLYzNDJXHeZVd6U4QE0hNLUrNTUwtSi2D6mDg4pRqYLJ6Ea3pziOqJ3/qw
        ltn2nVfSlPnBTh+nxVyR4lt9yrlFn/VX4PKH1ut73mlfjrzmoJq1QZfxh4bE15f5N3MWyEU3
        ZRhWpssyJ8VoWy5d17GwpmSayVwlv0Kbp1be5UqHDsxJiP0nxORWndf9bYpAXFNhoKScq2kh
        P7+Tz8mu/zp3nLo/iZzbImxgJDOtt2vFhdY9R7be+fTyZnr4und7zTYeiVW+wfU3KDKz5cKR
        Xutny3oj58TtWpJnWDWnLnnX1ceRZTPEWRKaf+kui9P17dzHzP1uRSHLHGHNIpspE96vcpiR
        e1DKr7nrvj3brx1uU3iUbh7QjePes97tQsDku4ffW7y8N9HO9Z3mBQ4lluKMREMt5qLiRACU
        /qJ/OQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPLMWRmVeSWpSXmKPExsWy7bCSnO6+H7NTDJYe0rBYfbefzeLBfnuL
        5sXr2Szmvr7EYrFy9VEmi723tC0u75rDZrF8VQeTxdkJH1gtPp2/wGbx+8ccNgduj80rtDwu
        ny312LSqk81j/9w17B67bzawefRtWcXo8XmTXAB7FJdNSmpOZllqkb5dAlfGzRfLmAu+M1Vc
        X/qUqYFxAVMXIyeHhICJxL7794FsLg4hgd2MEhe+PWKESEhInJ/3iw3CFpZY+e85O4gtJPCU
        UeLQFosuRg4ONgFliW1LfUBMEQE+iVu3UkHGMAucYpRo/3kerFxYIEni66K5YDaLgKrEgYdz
        wPbyClhILHsyH2q8vMT+g2eZQWxOAR2JFX/OMkGs0pb4+eg8K0S9oMTJmU9YQGxmoPrmrbOZ
        JzAKzEKSmoUktYCRaRWjZGpBcW56brFhgWFearlecWJucWleul5yfu4mRnAcaGnuYNy+6oPe
        IUYmDsZDjBIczEoivLffzE4R4k1JrKxKLcqPLyrNSS0+xCjNwaIkziv+ojdFSCA9sSQ1OzW1
        ILUIJsvEwSnVwOSWy7d07sP2y7nLOP69VmVvtf3tu0GliEUnqfjxv8Yn7lfMX4v+04g5/Oeb
        /5rGe3N///va9EVbd5IVV3XzkbOPj81wOrBn4xzhf2WW3uUd9ZFhxasYYn1LkxamXPdeuej4
        qgM3bi163Xl+7p8JyldrjDb6fHbL1ag5+vXyIbvMkKBj215Hyhcf+Lh9Spbw9685N27Mlefe
        2SQ7ty/zRO7q4u/3D6zdlxa6TmU6v7b/26gPhWGCP++691VGKi731014JC6986Faubl0Udaf
        uVcyy2rN58+517HF6PXxHZE5SdefiH9puGWUWG73Pjn1AINLZ/CVFZET/pacXl0qrFElyVfF
        6P7EQMdw/e4lORuVWIozEg21mIuKEwEpiPY38gIAAA==
X-CMS-MailID: 20230628090918epcas5p3a5463f0fc421e435a363192e40d3f649
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230628090918epcas5p3a5463f0fc421e435a363192e40d3f649
References: <20230628083839.GA26606@lst.de>
        <CGME20230628090918epcas5p3a5463f0fc421e435a363192e40d3f649@epcas5p3.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2023 at 04:48:36PM +0000, Christoph Hellwig  wrote: 
> They are long long in the UAPI, which is weird but has been that way
> for a long time.  So I think we need checks for negative values
> before they are shifted and converted to a sector_t.

Do you mean that we need to check if p.start and p.length are negative?

Thanks for your reply

Min li
