Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA830740BB6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 10:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjF1IjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 04:39:04 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:27192 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235403AbjF1Igp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:36:45 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230628083644epoutp0418eea67be7550c9c0cb6dca8042b0317~sxcOeQshV1104711047epoutp04s
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 08:36:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230628083644epoutp0418eea67be7550c9c0cb6dca8042b0317~sxcOeQshV1104711047epoutp04s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1687941404;
        bh=KZJNLKdtjgoDbmPLLBh4ZMAxAfXH8SRMRxK6xTKUcho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EOkie86NDd4tN1srUavqdXOiEqnCBVRuYiy/RYZ6L6lbTc2AzZw/mQXb06vywyhOL
         /N9G2Z3+5XZNcyqp1GGerbLxb9xmedJJh9VrqpTVjg1tCqBUc1mL7484som9FS4wpB
         UeePw/gGSit4bAwrIuLZCg9n/1w8bMgw0OBpqvZ4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230628083643epcas5p19fec22088e3af806c1b6daccc1d77a36~sxcOBuMPi1461714617epcas5p1l;
        Wed, 28 Jun 2023 08:36:43 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4QrZgZ54nRz4x9QH; Wed, 28 Jun
        2023 08:36:42 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        82.BD.06099.911FB946; Wed, 28 Jun 2023 17:36:41 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230628083625epcas5p48b2728c6a160744ef628da9ecb49db25~sxb9JMtQI1211412114epcas5p4W;
        Wed, 28 Jun 2023 08:36:25 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230628083625epsmtrp1c4c53858ee4defb98904b483e92a3835~sxb9IQNxa3254732547epsmtrp10;
        Wed, 28 Jun 2023 08:36:25 +0000 (GMT)
X-AuditID: b6c32a4b-d308d700000017d3-15-649bf1191ac7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        13.50.34491.901FB946; Wed, 28 Jun 2023 17:36:25 +0900 (KST)
Received: from ubuntu.. (unknown [109.105.118.54]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230628083624epsmtip1cedd402dbe729584598554849fbf4e6b~sxb8EahpB2786627866epsmtip1K;
        Wed, 28 Jun 2023 08:36:24 +0000 (GMT)
From:   Min Li <min15.li@samsung.com>
To:     hch@lst.de
Cc:     axboe@kernel.dk, dlemoal@kernel.org, gregkh@linuxfoundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        min15.li@samsung.com, stable@kernel.org, willy@infradead.org
Subject: Re: [PATCH v3] block: add check that partition length needs to be
 aligned with block size
Date:   Wed, 28 Jun 2023 16:34:42 +0000
Message-Id: <20230628163442.2796-1-min15.li@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230628073214.GA25314@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOJsWRmVeSWpSXmKPExsWy7bCmlq7kx9kpBlf+GVisvtvPZvFgv71F
        8+L1bBZzX19isVi5+iiTxd5b2haXd81hs1i+qoPJ4uyED6wWn85fYLP4/WMOmwO3x+YVWh6X
        z5Z6bFrVyeaxf+4ado/dNxvYPPq2rGL0+LxJLoA9KtsmIzUxJbVIITUvOT8lMy/dVsk7ON45
        3tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB+hAJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmt
        UmpBSk6BSYFecWJucWleul5eaomVoYGBkSlQYUJ2xuL3B5gLJjFW7P+8nLmBsbCLkZNDQsBE
        YnfHPJYuRi4OIYHdjBK9L/pZIZxPjBL/361lh3C+MUpc7rnACNPy98BEqKq9jBJPny5khHCe
        M0q8X7qOqYuRg4NNQFli21IfEFNEgE/i1q1UkBJmgQOMEntfNoMNEhZIkXj8azYLiM0ioCqx
        /fVdVhCbV8BC4tDmNjaIZfIS+w+eZQaxOQV0JDrvbGeHqBGUODnzCVgvM1BN89bZzCALJAR6
        OSRu/f4D1ewisab9NtTVwhKvjm9hh7ClJF72t7GDHCchUCzx8kcYRLhGYve320wQtrXEtvUQ
        rzALaEqs36UPEZaVmHpqHRPEWj6J3t9PoMp5JXbMg7GVJP5eOAe1VUJi8f6HrBC2h8S7tRPB
        ThYSqJd4Nn8n+wRGhVlIvpmF5JtZCJsXMDKvYpRMLSjOTU8tNi0wzksth0dxcn7uJkZwitXy
        3sH46MEHvUOMTByMhxglOJiVRHhvv5mdIsSbklhZlVqUH19UmpNafIjRFBjcE5mlRJPzgUk+
        ryTe0MTSwMTMzMzE0tjMUEmc9+L13hQhgfTEktTs1NSC1CKYPiYOTqkGJm6dPmG9vyuCvDMi
        JnBO2Ohm3Md3e+ZxnyfL16mX/VyY3pq52WXCf/YjSdJu0nad7zbveHdJ6eSlFbyKHN/9b6ce
        lf/6KPjt7eMLTaO2tB/L6OXbPKWwYKfmsbr+g9VT9DS36QdsUjgkdvKFc7CLdWiw+e6/KktL
        bqntX1G67V68QLGCIv/RjY8WzjKZ+GfpHCnfk4oeTPwVQbftPsZXzHin/XvVwzVnXz46pHz3
        R+LiW5/y2jr/3f6aOzs8LNy6OSHu7uMLYcvn/rZLsG/M4uU5buxWZX/2MFPmtvOKs1dwezx1
        KJ0SGCbtXjVtyvdtO+X/WTPUSH290KGiE3oyYNOCiIYnVx+t8Dyw4dGChW5KLMUZiYZazEXF
        iQC7sLMcOgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHLMWRmVeSWpSXmKPExsWy7bCSnC7nx9kpBtNeqFusvtvPZvFgv71F
        8+L1bBZzX19isVi5+iiTxd5b2haXd81hs1i+qoPJ4uyED6wWn85fYLP4/WMOmwO3x+YVWh6X
        z5Z6bFrVyeaxf+4ado/dNxvYPPq2rGL0+LxJLoA9issmJTUnsyy1SN8ugStj8fsDzAWTGCv2
        f17O3MBY2MXIySEhYCLx98BE1i5GLg4hgd2MErdPTmKGSEhInJ/3iw3CFpZY+e85O4gtJPCU
        UWJGY1QXIwcHm4CyxLalPiCmiACfxK1bqSBjmAVOMUq0/zwPVi4skCTxddFcMJtFQFVi++u7
        rCA2r4CFxKHNbVDj5SX2HzwLtpZTQEei8852qFXaEtN+PWGGqBeUODnzCQuIzQxU37x1NvME
        RoFZSFKzkKQWMDKtYpRMLSjOTc8tNiwwzEst1ytOzC0uzUvXS87P3cQIjgItzR2M21d90DvE
        yMTBeIhRgoNZSYT39pvZKUK8KYmVValF+fFFpTmpxYcYpTlYlMR5xV/0pggJpCeWpGanphak
        FsFkmTg4pRqYlpl/zNJ9KWY29e4fCUOGmQ/Wt9tVPo2dIZTyk/mgpWtFQaJb0It+HvVOmzUs
        ax4vC72/T0u1S/eGusHeNrvWJr+LRqfUH937Gz9N4z3jtLzdfREc6VeMrj22+fYt9vDH3w0L
        ggO2LuI1vlz3SG7Z9H6bfUKrjhTHHe7fwZX5pe7Cn2cuoQdmX5czdzDY+LV3xSujHVtCSstO
        mLJdtvWprGU9sKQ5N4eZZ4JrxEnxD3/TXPz9Vf6cv3f5auJus0zpnXtsj3zPKpuktrHtWb7N
        vx4Z778KJpNm/J8c2n11trXkxN/mB5ZuFH5xnIF/i0vckyeRBZVhv2z5H5bt1NG8V31vHl9K
        WWRkvXJRnk6EEktxRqKhFnNRcSIAJoBTUPECAAA=
X-CMS-MailID: 20230628083625epcas5p48b2728c6a160744ef628da9ecb49db25
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230628083625epcas5p48b2728c6a160744ef628da9ecb49db25
References: <20230628073214.GA25314@lst.de>
        <CGME20230628083625epcas5p48b2728c6a160744ef628da9ecb49db25@epcas5p4.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I will modify the blksz to unsigned int.
For pre-existing start/length, is it ok to change them to sector_t?

Thanks for your reply

Min Li
