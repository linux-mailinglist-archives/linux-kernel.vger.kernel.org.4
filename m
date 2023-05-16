Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807E5704F31
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 15:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233601AbjEPNYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 09:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbjEPNYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 09:24:30 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B160261AA
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 06:24:17 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230516132414epoutp0290ee5f901d12a120ad2c507bd3a59bd8~fon_XROCt0691806918epoutp02P
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 13:24:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230516132414epoutp0290ee5f901d12a120ad2c507bd3a59bd8~fon_XROCt0691806918epoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684243454;
        bh=cg4C7x99d6gMeddzSh0dDTiOK7SmEUwxAYZsbOtNGmc=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=RHduGJ+mox1uwvkL9CrWTwdjQY64J+OI+raGGaQy72CRRpH3JriElZYia6c1jwp9F
         9GaQB7xwDbxZZFrvZUNIDHUOxobum8hoo1gdK+NuhwiZs5GnJ0VneDKXfQXK23tUQa
         vyA9Gvbug2YRGMkMPXIu1CgTzFBi96BnyqXjbMSc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230516132413epcas2p15f78b10667e670c1546ca1dd981b3745~fon91tdyG0107401074epcas2p1h;
        Tue, 16 May 2023 13:24:13 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.100]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4QLH5935Ddz4x9Px; Tue, 16 May
        2023 13:24:13 +0000 (GMT)
X-AuditID: b6c32a48-475ff70000005998-c3-646383fdb5d3
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        E4.7C.22936.DF383646; Tue, 16 May 2023 22:24:13 +0900 (KST)
Mime-Version: 1.0
Subject: RE:(2) [PATCH v2 05/14] block: blk-merge: fix to add the number of
 integrity segments to the request twice
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung CHOI <j-young.choi@samsung.com>
From:   Jinyoung CHOI <j-young.choi@samsung.com>
To:     "hch@lst.de" <hch@lst.de>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "kch@nvidia.com" <kch@nvidia.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230512135136.GD32242@lst.de>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230516132412epcms2p2549c58f92db9919002c7e05ed044bcc8@epcms2p2>
Date:   Tue, 16 May 2023 22:24:12 +0900
X-CMS-MailID: 20230516132412epcms2p2549c58f92db9919002c7e05ed044bcc8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMJsWRmVeSWpSXmKPExsWy7bCmqe7f5uQUg6+nxSxW3+1ns3h5SNNi
        5eqjTBaLbmxjsvjbdY/JYtKha4wWT6/OYrLYe0vb4vKuOWwWy4//Y7JY9/o9i8XvH3PYHHg8
        zt/byOKxeYWWx+WzpR6bVnWyeUxYdIDRY/fNBjaP3uZ3bB4fn95i8ejbsorR4/MmOY/2A91M
        AdxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QJcr
        KZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgrMC/SKE3OLS/PS9fJSS6wMDQyMTIEK
        E7IzZlxvZSw4L1GxpWEtewPjCfEuRk4OCQETiakLvrF2MXJxCAnsYJSY+KOJpYuRg4NXQFDi
        7w5hkBphgVKJm5M+soPYQgJKEufWzGIEKREWMJC41WsOEmYT0JP4uWQGG0hYREBW4sqKepAw
        s8AnZon/7wwgNvFKzGh/ygJhS0tsX74VbAqngI7Ehz4fiLCGxI9lvcwQtqjEzdVv2WHs98fm
        M0LYIhKt985C1QhKPPi5GyouKXHo0FewCyQE8iU2HAiECNdIvF1+AKpEX+Jax0awC3gFfCVO
        rXnCBmKzCKhK/Lu5HGqVi8TCvy8YIa7Xlli28DUzyEhmAU2J9bv0IaYrSxy5xQJRwSfRcfgv
        O8x/DRt/Y2XvmPeECaJVTWJRk9EERuVZiCCehWTVLIRVCxiZVzGKpRYU56anFhsVmMBjNTk/
        dxMjOPVqeexgnP32g94hRiYOxkOMEhzMSiK87TPjU4R4UxIrq1KL8uOLSnNSiw8xmgI9OZFZ
        SjQ5H5j880riDU0sDUzMzAzNjUwNzJXEeT92KKcICaQnlqRmp6YWpBbB9DFxcEo1MPXJuW9z
        lwqabuCRYypkeOvGIxXPr9VmvTJ3ClI+VU689mPCubMZpyLaOmvDpYtKqj0uFgVeW1lnvmdv
        afiBUOPF2XcON3xUD13/4J5RfQWf4sK0r4k91UZ57LfOA5NQpbiltFHzqh/5lzNXv/klkVMm
        LqQ1j69yS86bjUY6bVmb9uwuLGeuurzYhv2e46mK65N1PNMeplgZ9F/caxZYMlPL4qvEOsey
        0jD3pDVGEp5rlVYf+lfFsiRwVbTXptj8RwXpWqdq3yq+fpy+8UCM1v/Y0ik3Ltx51/p6x6ug
        /u03nJmUCw7dFDkV8er+NjFfhx1q+Qel79itOdwdu9S/adnayP+TzE4V5gY7bhVVYinOSDTU
        Yi4qTgQAsFJUy0YEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684
References: <20230512135136.GD32242@lst.de>
        <20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684@epcms2p1>
        <20230510085208epcms2p52a6dec8da80152ec2101f11ce2ea5321@epcms2p5>
        <CGME20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684@epcms2p2>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>The subject looks a bit odd, I think you're trying to say:
>
>=22do not add the number of integrity segments to the request twice=22
>
>based on the actual patch, is this correct?
>

Yes. I will fix it.

>> +static inline bool blk_integrity_bypass_check(struct request *req,
>> + =C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0struct=20bio=20=
*bio)=0D=0A>>=20+=7B=0D=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0return=
=20blk_integrity_rq(req)=20=3D=3D=200=20&&=20bio_integrity(bio)=20=3D=3D=20=
NULL;=0D=0A>>=20+=7D=0D=0A>=0D=0A>No=20need=20for=20the=20explicit=20compar=
isms,=20this=20could=20just=20be:=0D=0A>=0D=0A>=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0return=20=21blk_integrity_rq(req)=20&&=20=21bio_integrity(bio);=0D=
=0A>=0D=0A>and=20given=20that=20it=20just=20has=20two=20callers=20I'm=20not=
=20sure=20the=20helper=20is=0D=0A>all=20that=20useful=20to=20start=20with.=
=0D=0A=0D=0AThere=20are=20many=20conditional=20sentences=20like=20that,=20s=
o=20I=20left=20them=20for=20unity,=0D=0AIf=20it's=20okay=20to=20change,=20I=
'll=20do=20so.=0D=0A=0D=0A>>=20+static=20bool=20__blk_integrity_mergeable(s=
truct=20request_queue=20*q,=0D=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0struct=20reques=
t=20*req,=20struct=20bio=20*bio)=0D=0A>>=20+=7B=0D=0A>>=20+=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0if=20(blk_integrity_rq(req)=20=3D=3D=200=20=7C=7C=20bi=
o_integrity(bio)=20=3D=3D=20NULL)=0D=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0return=20false;=0D=0A>>=20+=0D=0A=
>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(bio_integrity(req->bio)->bi=
p_flags=20=21=3D=20bio_integrity(bio)->bip_flags)=0D=0A>>=20+=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0return=20false;=
=0D=0A>>=20+=0D=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0return=20true;=
=0D=0A>>=20+=7D=0D=0A>>=20+=0D=0A>>=20+bool=20blk_integrity_mergeable(struc=
t=20request_queue=20*q,=20struct=20request=20*req,=0D=0A>>=20+=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20struct=20bio=20*bio)=0D=0A>>=20+=
=7B=0D=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(blk_integrity_bypa=
ss_check(req,=20bio))=0D=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0return=20true;=0D=0A>>=20+=0D=0A>>=20+=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0return=20__blk_integrity_mergeable(q,=20req,=
=20bio);=0D=0A>>=20+=7D=0D=0A>=0D=0A>Similarly=20here,=20I'm=20not=20even=
=20sure=20we=20need=20all=20these=20helpers.=20=C2=A0I=20supect=0D=0A>the=
=20code=20would=20become=20more=20readable=20by=20dropping=20these=20helper=
s=20and=20just=0D=0A>making=20the=20checks=20explicitl=E1=BA=8F=0D=0A=0D=0A=
OK.=20I=20will=20drop=20this.=0D=0A=0D=0ABest=20Regards,=0D=0AJinyoung.
