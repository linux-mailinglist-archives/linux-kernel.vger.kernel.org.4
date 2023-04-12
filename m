Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610516DEFEB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 10:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbjDLI4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 04:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbjDLI4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 04:56:24 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400D6A5D4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 01:56:04 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230412085559epoutp013f8349e3a79d799d3d0aa1189cef3f97~VJCDvK49k1837918379epoutp01w
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 08:55:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230412085559epoutp013f8349e3a79d799d3d0aa1189cef3f97~VJCDvK49k1837918379epoutp01w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681289759;
        bh=RCW0Dvtrpxls1F9oh27ti4C9yKdcPc4U2u6z/oFEy7c=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=emA+2/hL3VtLESee3LHM4NesRk49Fm3QmlhrSWOO190RfT8KB7b7/6MFIJ02XGL1w
         2LBTW7m5W1AjCDu0Uj4LxyCh+nZPryobEGVd5KHuaOc3ihZoyu34pRzAGbD3LgCDx0
         MKpMCpjQ8G3WD+IYxkhJ3NSeS/68/CKm7FS2UwGI=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230412085559epcas2p310efa742622025110c111fa2f8eaa34b~VJCDOzcZx3203432034epcas2p3d;
        Wed, 12 Apr 2023 08:55:59 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.98]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4PxGlL6VwRz4x9Pt; Wed, 12 Apr
        2023 08:55:58 +0000 (GMT)
X-AuditID: b6c32a48-5dcdca80000025b2-32-6436721ee6fa
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        82.03.09650.E1276346; Wed, 12 Apr 2023 17:55:58 +0900 (KST)
Mime-Version: 1.0
Subject: RE:(2) [PATCH 1/2] blk-integrity: add rq_integrity_payload_size
 helper
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung CHOI <j-young.choi@samsung.com>
From:   Jinyoung CHOI <j-young.choi@samsung.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <83fad2a2-5c31-b869-7e30-fb2182659518@nvidia.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230412085558epcms2p46c6ebb9ad18e90d6f21f5598d55c6785@epcms2p4>
Date:   Wed, 12 Apr 2023 17:55:58 +0900
X-CMS-MailID: 20230412085558epcms2p46c6ebb9ad18e90d6f21f5598d55c6785
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCJsWRmVeSWpSXmKPExsWy7bCmha5ckVmKwdwdRhb/9xxjs3h/8DGr
        xctDmhYrVx9lsph06BqjxeVdc9gs5i97ym6x7vV7FgcOj4nN79g9zt/byOKxaVUnm8fmJfUe
        u282sHn0Nr9j8+jbsorR4/MmuQCOqGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sL
        cyWFvMTcVFslF58AXbfMHKDDlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkF5gV6
        xYm5xaV56Xp5qSVWhgYGRqZAhQnZGTO7pjEX3OCq+LjmOnsD4xKuLkZODgkBE4mlV6+zdDFy
        cQgJ7GCU2HXvKFMXIwcHr4CgxN8dwiA1wgKBEhd/9bOD2EICShLn1sxiBCkRFjCQuNVrDhJm
        E9CT+LlkBhvIGBGBQ0wSz9ramSHm80rMaH/KAmFLS2xfvpURxOYUsJM4vfUnK0RcQ+LHsl6o
        elGJm6vfssPY74/NZ4SwRSRa752FqhGUePBzN1RcUuLQoa9sIPdICORLbDgQCBGukXi7/ABU
        ib7EtY6NYCfwCvhKbP11A+x8FgFViSurXSFKXCS2HF3DBmIzC2hLLFv4mhmkhFlAU2L9Ln2I
        4coSR26xQFTwSXQc/ssO81/Dxt9Y2TvmPWGCaFWTWNRkBBGWkfh6eD77BEalWYhAnoVk7SyE
        tQsYmVcxiqUWFOempxYbFZjA4zU5P3cTIzh5annsYJz99oPeIUYmDsZDjBIczEoivD9cTFOE
        eFMSK6tSi/Lji0pzUosPMZoC/TuRWUo0OR+YvvNK4g1NLA1MzMwMzY1MDcyVxHk/diinCAmk
        J5akZqemFqQWwfQxcXBKNTCd2anK/kXteFLRwlVGpx+mXPdfeKvN2zAkaMfX89+rLx1dLrH3
        Q0rtEc9n5Zz8vDJc1hXRF5ll2IpOXd87xdzrS2qY2hWBJJVJpznOyaY9r372I+DlgpaVUgE/
        ci0lt2RqtTfdX5B6QbRX7rIg51G7w5NXbaqV+vG8YPU/N6vq7wWZS6V6pU6vexcwTc9pAsuN
        z4nXOvnf/cw3OuRiyFlwx8uwWzyuZLHFL4dfvJLf17wQymn5zrvcZ5baY4slGsyPJsn532/q
        2fJ3iWJc9L7rcgkzv0c8LHiqumrXZ+dJaQ2B6faz+LY+kdp0qfnv8kOrdMK8gq90PhF021F4
        9EX3zJJt7/+u+fj3W/ByqeunlFiKMxINtZiLihMB/A3+HCcEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230412052133epcms2p4d52e78b4fc1bc6ac1cc9d399a0378fce
References: <83fad2a2-5c31-b869-7e30-fb2182659518@nvidia.com>
        <20230412052133epcms2p4d52e78b4fc1bc6ac1cc9d399a0378fce@epcms2p4>
        <91df2b07-02a2-d034-bd8b-a67c13ca085a@nvidia.com>
        <CGME20230412052133epcms2p4d52e78b4fc1bc6ac1cc9d399a0378fce@epcms2p4>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> +
>>> +static inline unsigned int rq_integrity_payload_size(struct request=20
>>> *rq)
>>> +=7B
>>> +=C2=A0=C2=A0=C2=A0=20if=20(WARN_ON_ONCE(queue_max_integrity_segments(r=
q->q)=20>=201))=0D=0A>>>=20+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20re=
turn=200;=0D=0A>>>=20+=C2=A0=C2=A0=C2=A0=20return=20rq->bio->bi_integrity->=
bip_iter.bi_size;=0D=0A>>>=20+=7D=0D=0A>>>=20=C2=A0=20=23else=20/*=20CONFIG=
_BLK_DEV_INTEGRITY=20*/=0D=0A>>>=20=C2=A0=20static=20inline=20int=20blk_rq_=
count_integrity_sg(struct=20request_queue=20*q,=0D=0A>>>=20=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20struct=20bio=
=20*b)=0D=0A>>=0D=0A>>=20from=20the=20comments=20that=20I=20got=20in=20the=
=20past,=20you=20should=20only=20be=20adding=0D=0A>>=20a=20helper=20in=20th=
e=20patch=20that=20is=20actually=20using=20it.=0D=0A>>=0D=0A>>=20-ck=0D=0A>=
>=0D=0A>>=0D=0A>=0D=0A>=20disregard=20my=20comment,=20I=20think=20this=20is=
=20correct=20looking=20at=20the=20next=20patch...=0D=0A>=0D=0A>=20-ck=0D=0A=
=0D=0AOK=20Thanks=20for=20your=20review=20:)=0D=0AI=20sent=20it=20to=20the=
=20wrong=20email=20address.=20(result=20from=20get_maintainer.pl)=0D=0AI=20=
will=20update=20your=20email=20address=20for=20cc.=0D=0A=0D=0AKind=20Regard=
s,=0D=0AJinyoung.
