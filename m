Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A3E6F64C0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 08:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjEDGKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 02:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjEDGKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 02:10:47 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1BA1984
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 23:10:42 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230504061038epoutp01bfb2ab3a7931b312c3f9a42adf0961fb~b299sgSxD2464824648epoutp01T
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 06:10:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230504061038epoutp01bfb2ab3a7931b312c3f9a42adf0961fb~b299sgSxD2464824648epoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683180638;
        bh=QCvAmyCOO0yQekvWMKoMa/dRCsFci6z3u0mMgFz9QSE=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=P/unouWOkggE6I/4srB/L7vRXXG3wjhiPjefGyo5FytFoEl9huT5mfl9kPqH5o8ei
         X1TyhpOWMm9o/dLaNw3FOeOjnF6FGhpIbADF+Pq0ITTBZJfVrnu94RRGwWpRhZEyAI
         G96tG0O8O/RLSI7MDAtKa9BDpzGq/PPqDxzoi9UI=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230504061038epcas2p1ce1663023e6822612fbf2a20e83f0a41~b299fm-cH1736417364epcas2p1K;
        Thu,  4 May 2023 06:10:38 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.70]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4QBk2P60zpz4x9QB; Thu,  4 May
        2023 06:10:37 +0000 (GMT)
X-AuditID: b6c32a45-6d1fd70000020cc1-76-64534c5cd5b5
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        69.10.03265.C5C43546; Thu,  4 May 2023 15:10:36 +0900 (KST)
Mime-Version: 1.0
Subject: RE:(2) [PATCH 05/15] block: fix not to apply bip information in
 blk_rq_bio_prep()
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung CHOI <j-young.choi@samsung.com>
From:   Jinyoung CHOI <j-young.choi@samsung.com>
To:     "hch@lst.de" <hch@lst.de>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230503155745.GD31700@lst.de>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230504061036epcms2p105ced86705b4b0dc2cf62c6b0d7115a0@epcms2p1>
Date:   Thu, 04 May 2023 15:10:36 +0900
X-CMS-MailID: 20230504061036epcms2p105ced86705b4b0dc2cf62c6b0d7115a0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJKsWRmVeSWpSXmKPExsWy7bCmqW6sT3CKwZYYi9V3+9ksXh7StFi5
        +iiTxd5b2haXd81hs1h+/B+TA5vH5bOlHrtvNrB5fHx6i8Wjb8sqRo/Pm+QCWKOybTJSE1NS
        ixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOAtisplCXmlAKFAhKL
        i5X07WyK8ktLUhUy8otLbJVSC1JyCswL9IoTc4tL89L18lJLrAwNDIxMgQoTsjN+969nKrjK
        WtHU+Yy9gXEtaxcjJ4eEgIlEf+8qpi5GLg4hgR2MEhP2HWDrYuTg4BUQlPi7QxikRlggRuLR
        6QdMILaQgJLEuTWzGEFKhAUMJG71moOE2QT0JH4umQHWKSIgK3FlRT3IRGaBJ4wSm1fOZ4NY
        xSsxo/0pC4QtLbF9+VZGEJtTQEfi6c5dzBBxDYkfy3qhbFGJm6vfssPY74/NZ4SwRSRa752F
        qhGUePBzN1RcUuLQoa9gN0gI5EtsOBAIEa6ReLv8AFSJvsS1jo1gJ/AK+Er8+jUP7CsWAVWJ
        c8e+QkPEReL6rbVgcWYBbYllC18zg4xkFtCUWL9LH2K6ssSRWywQFXwSHYf/ssM82LDxN1b2
        jnlPmCBa1SQWNRlNYFSehQjkWUhWzUJYtYCReRWjWGpBcW56arFRgSE8XpPzczcxgtOglusO
        xslvP+gdYmTiYDzEKMHBrCTC+6HQL0WINyWxsiq1KD++qDQntfgQoynQkxOZpUST84GJOK8k
        3tDE0sDEzMzQ3MjUwFxJnFfa9mSykEB6YklqdmpqQWoRTB8TB6dUAxP/rNWsWn+NUi9Lp3w4
        f0J+/q6Lf6fv068//YQ5Yv7MbPPzNlsrpnz4Xr1qo4S6ywoOZTWjB1G7GQ5M5ctfNV86WPO5
        ZKQtn4L2wd8vBb4sSlqxr0Z49e0366uaIyMDbqYrZWgzHC94/Wzp/8sSJTJ/Jacv3pKxTuhc
        gthCxgjumtgZtpYJNgY/RBpimOwMjfaZ+17N3HY3rNa/97npNUW3uHcs0yfeEYl6xr8s7Nqk
        oKNSM36zXzjecE491Kex48iMOr4DousKDsWmvMn1vT5V3/5Qy0ROjW0SO8V3vTfIPVt9Y9sZ
        TY64s3GJJg9n8Fns2aea++q8doKUZ9z+X08WLz7mF3TdXcuZ4cdr+V1KLMUZiYZazEXFiQDl
        ZaYcDAQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323
References: <20230503155745.GD31700@lst.de>
        <20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323@epcms2p4>
        <20230503101048epcms2p61d61df1431955d9517c9939999ee3478@epcms2p6>
        <CGME20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323@epcms2p1>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> When a request is initialized through the bio, bio's integrity
>> information is not reflected in the request.
>
>Uuh. =C2=A0This=20looks=20like=20a=20pretty=20grave=20bug=20unless=20I'm=
=20missing=20something.=0D=0A>Can=20you:=0D=0A>=0D=0A>=20-=20submit=20this=
=20as=20a=20fix=20for=206.3=20and=20-stable?=0D=0A>=20-=20maybe=20find=20wh=
at=20broke=20this=20and=20add=20a=20fixes=20tag?=0D=0A=0D=0AThanks=20for=20=
your=20review.=0D=0A=0D=0AOK,=20I=20will=20check=20it=20and=20proceed.=0D=
=0A=0D=0AI=20didn't=20confirm=20that=20I=20turned=20off=20the=20config=20an=
d=20compiled=20it.=0D=0AI=20will=20check=20it=20and=20upload=20in=20the=20n=
ext=20patch.=20sorry.=0D=0A=0D=0ABest=20Regards,=0D=0AJinyoung.
