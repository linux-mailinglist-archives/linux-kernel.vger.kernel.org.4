Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADDEE6E040D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 04:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjDMCTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 22:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjDMCTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 22:19:43 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157B2123
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 19:19:40 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230413021932epoutp046a4a630d2da4be0101715dcbb4342313~VXRMnGPjD1992619926epoutp04a
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 02:19:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230413021932epoutp046a4a630d2da4be0101715dcbb4342313~VXRMnGPjD1992619926epoutp04a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681352372;
        bh=pWNzOCN0MtvrHBC32swpTu3eTZfE/OpUSdp520IVzoU=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=JzoDWKU42rGG4DAT/V7hdHyEXiMczKJR1nI3/ZCtnFfa/KNcC5ozS24VhzHc0QNU0
         B8zSRSOJcP7B9NU1Adbyg1RBFfrTvZyaM6ylb9LijC+ZTDBHFyoIN+OGNPVqKehZyE
         0yRxLd3Q7xGFqjObOmVt4PY2J6KMHTZI75xNs5es=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230413021932epcas2p1947091c70f4aa9c40e6f5ba29800dcfa~VXRMNCAEd2902829028epcas2p1M;
        Thu, 13 Apr 2023 02:19:32 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.100]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4PxjvR4lb9z4x9QF; Thu, 13 Apr
        2023 02:19:31 +0000 (GMT)
X-AuditID: b6c32a47-ca5fd700000026d2-2c-643766b3de64
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        B4.30.09938.3B667346; Thu, 13 Apr 2023 11:19:31 +0900 (KST)
Mime-Version: 1.0
Subject: RE:(2) (2) [PATCH 2/2] nvme-pci: fix metadata mapping length
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung CHOI <j-young.choi@samsung.com>
From:   Jinyoung CHOI <j-young.choi@samsung.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chaitanyak@nvidia.com" <chaitanyak@nvidia.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <yq13554bm4l.fsf@ca-mkp.ca.oracle.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230413021931epcms2p3bfbfbcd26e2732138bd66e3d9943d45c@epcms2p3>
Date:   Thu, 13 Apr 2023 11:19:31 +0900
X-CMS-MailID: 20230413021931epcms2p3bfbfbcd26e2732138bd66e3d9943d45c
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPJsWRmVeSWpSXmKPExsWy7bCmqe7mNPMUgzk3VS3+7znGZvH+4GNW
        i5eHNC1Wrj7KZDHp0DVGi8u75rBZzF/2lN1i+fF/TBbrXr9nceD0mNj8jt3j/L2NLB6bVnWy
        eWxeUu+x+2YDm0dv8zs2j49Pb7F49G1ZxejxeZNcAGdUtk1GamJKapFCal5yfkpmXrqtkndw
        vHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0IlKCmWJOaVAoYDE4mIlfTubovzSklSFjPzi
        Elul1IKUnALzAr3ixNzi0rx0vbzUEitDAwMjU6DChOyMpXMWMxX0cVTMn3mOuYHxGXsXIyeH
        hICJxMajh1i6GLk4hAR2MEp0r3oHlODg4BUQlPi7QxikRljAVeLlyW0sILaQgJLEuTWzGEFK
        hAUMJG71moOE2QT0JH4umcEGYosImEpM/rSVDWQks8BxJon5u5YwQ+zilZjR/pQFwpaW2L58
        KyOIzSlgLHHi+QpWiLiGxI9lvVD1ohI3V79lh7HfH5vPCGGLSLTeOwtVIyjx4OduqLikxKFD
        X9lAbpMQyJfYcCAQIlwj8Xb5AagSfYlrHRvBTuAV8JXYMbcRbC2LgKpE16JPUKe5SDyYtRzs
        F2YBbYllC18zg4xkFtCUWL9LH2K6ssSRWywQFXwSHYf/ssM82LDxN1b2jnlPmCBa1SQWNRlN
        YFSehQjlWUhWzUJYtYCReRWjWGpBcW56arFRgTE8YpPzczcxglOqlvsOxhlvP+gdYmTiYDzE
        KMHBrCTC+8PFNEWINyWxsiq1KD++qDQntfgQoynQkxOZpUST84FJPa8k3tDE0sDEzMzQ3MjU
        wFxJnFfa9mSykEB6YklqdmpqQWoRTB8TB6dUA9Nsh4wXl29pfim8p/g/xrnROK76bMHr1fmz
        SgMid+Y8m7d+hcVGxQU+H07sm8KRL643+eOT0q7ieSkXdJ9cdrCfODNL8/+uEmsxhwKBnLwT
        s3Lc/12ZbXSJZcP0Rxk5Lvr5N36Fc6+tvD7z87bUG2d+n5loW/pCStLjbG1/odHv6Rya04y/
        cYZtKYhexL2x6iFTtsekjkdr97zY8qlsla3Jw5PLjzzdmBDgffjjJaZVlmlGHrvuqyofeunS
        sHZRyk65LplQ/1fnnPcdTZqwXu7jl0Xnfq/77eAUEKvfqr9zUdsK34tBys5a9YJi0lwv39kt
        fXJm/wMJDsvFZlsr07WTSkwEG/WYXwqZrij486tJiaU4I9FQi7moOBEAEZ0qLDIEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230412052443epcms2p836b669a12c4e81368bec2cd340656f73
References: <yq13554bm4l.fsf@ca-mkp.ca.oracle.com>
        <20230412065736.GB20550@lst.de>
        <20230412052443epcms2p836b669a12c4e81368bec2cd340656f73@epcms2p8>
        <20230412071230epcms2p145d53bfc8e40eede25f282b80247218c@epcms2p1>
        <CGME20230412052443epcms2p836b669a12c4e81368bec2cd340656f73@epcms2p3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Jinyoung,
>=20
>> I think the problem is bio_integrity_add_page(). =C2=A0If=20it=20is=20mo=
dified,=0D=0A>>=20sg=20functions=20for=20blk-integrity=20should=20also=20be=
=20modified.=0D=0A>=0D=0A>=20The=20bio=20integrity=20scatterlist=20handling=
=20predates=20NVMe=20and=20wasn't=20written=0D=0A>=20with=20the=20single=20=
segment=20use=20case=20in=20mind.=20For=20SCSI=20we=20required=20the=0D=0A>=
=20hardware=20to=20support=20an=20integrity=20segment=20per=20data=20segmen=
t.=0D=0A>=20=0D=0A>=20--=20=0D=0A>=20Martin=20K.=20Petersen=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0Oracle=20Linux=20Engineering=0D=0A=0D=0AHi=20Martin.=
=0D=0AWhen=20merging=20is=20performed=20in=20bio_integrity_add_page(),=0D=
=0AI=20think=20SG=20functions=20for=20integrity=20will=20be=20able=20to=20b=
e=20modified=20more=20=0D=0Aconcisely.=20It=20was=20just=20the=20reason.=20=
:)=0D=0AIf=20you=20are=20okay,=0D=0Acan=20I=20try=20to=20modify=20it=20to=
=20solve=20the=20problem=20with=20add_page?=0D=0A=0D=0ABest=20Regards,=0D=
=0AJinyoung.
