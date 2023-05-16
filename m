Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEFB5704E2E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 14:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbjEPMye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 08:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232749AbjEPMyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 08:54:25 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843BD10CE
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 05:54:12 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230516125409epoutp01fd7db36dfd5d11cdb2ec89cafd5fb913~foNtS2ixo0521405214epoutp01h
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 12:54:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230516125409epoutp01fd7db36dfd5d11cdb2ec89cafd5fb913~foNtS2ixo0521405214epoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684241649;
        bh=6JRRr1+XPYnCycfuWh2BMBee/RDKqp/hKWRZyJw+S4Q=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=JwY8tKErI+wHr/A3AWkLuQdEIskeqZ6Lh2bq2AGOzYtPfLAc19ghfUTF0bIZ2zyTR
         6l5r2zqtnVXVLvh1PHLeoqFuchm0MVMtyVqIA/8HMco9HUE3WyQEqEH6VonWfbnZ62
         5bsrP2CgXroYdq/Xpyx7AsRxcZXuImPhqWU1/z6k=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230516125408epcas2p4405684b63b34acd3e7d7acf5cd39627e~foNsUoA2K0840908409epcas2p4F;
        Tue, 16 May 2023 12:54:08 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.100]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4QLGQS0xzbz4x9Q0; Tue, 16 May
        2023 12:54:08 +0000 (GMT)
X-AuditID: b6c32a46-8b7ff7000001438d-59-64637cf0299b
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        49.AA.17293.0FC73646; Tue, 16 May 2023 21:54:08 +0900 (KST)
Mime-Version: 1.0
Subject: RE:(2) [PATCH v2 02/14] block: bio-integrity: modify
 bio_integrity_add_page()
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
In-Reply-To: <20230512134323.GA32242@lst.de>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230516125407epcms2p82f3323c8b869b8517408adb451413e6c@epcms2p8>
Date:   Tue, 16 May 2023 21:54:07 +0900
X-CMS-MailID: 20230516125407epcms2p82f3323c8b869b8517408adb451413e6c
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIJsWRmVeSWpSXmKPExsWy7bCmue6HmuQUg9NvmS1W3+1ns3h5SNNi
        5eqjTBaLbmxjsvjbdY/JYtKha4wWT6/OYrLYe0vb4vKuOWwWy4//Y7JY9/o9i8XvH3PYHHg8
        zt/byOKxeYWWx+WzpR6bVnWyeUxYdIDRY/fNBjaP3uZ3bB4fn95i8ejbsorR4/MmOY/2A91M
        AdxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QJcr
        KZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgrMC/SKE3OLS/PS9fJSS6wMDQyMTIEK
        E7Izlt5Yx1ZwTrzixMWdjA2M58W6GDk5JARMJOas72XsYuTiEBLYwShxb0sDUxcjBwevgKDE
        3x3CIKawQITE951BIOVCAkoS59bMYoQIG0jc6jUHCbMJ6En8XDKDDSQsIiArcWVFPUiYWeAT
        s8T/dwYQi3glZrQ/ZYGwpSW2L98KNoVTQEdi6kJ7iLCGxI9lvcwQtqjEzdVv2WHs98fmM0LY
        IhKt985C1QhKPPi5GyouKXHo0FewCyQE8iU2HAiECNdIvF1+AKpEX+Jax0YWiO98Jea8jwAJ
        swioSiy6vQxqk4vEzL9HmSCO15ZYtvA1M0g5s4CmxPpd+hDDlSWO3GKBqOCT6Dj8lx3mvYaN
        v7Gyd8x7wgTRqiaxqMloAqPyLEQAz0KyahbCqgWMzKsYxVILinPTU4uNCozgcZqcn7uJEZx2
        tdx2ME55+0HvECMTB+MhRgkOZiUR3vaZ8SlCvCmJlVWpRfnxRaU5qcWHGE2BnpzILCWanA9M
        /Hkl8YYmlgYmZmaG5kamBuZK4rzStieThQTSE0tSs1NTC1KLYPqYODilGphuM2fvVPg5kyVZ
        ivuM17VEJccbp8yOvPe6YbEq0PpWA3ePQFhFh3rrIZ3Uz6LB7RvN+p0uvLl30mdzU98rrW1p
        kdcvHmeZeW5qMUvdtBcebt4RmTxfvSalPt/4Vqhj74xfd8/Vreqa0ZRlkL3w4TTN66tYRFyW
        fAkP3VYyP1N1Sd4f5oT8P/3Sls8X2h47Y+zzecX9QLHIXSraj1iMdD1/euew/mppT3Gc38N4
        /PaaJwZxEfX17UcSp73TfeY3SX2NUL+B2LYCXp5Uzpl/62YHF2y1s46dlFCpffDqaZZlP3e9
        m+DN2Mwjdi05Q0ei9eHE4NjXlX8fRstyvF/zKFjzc9iPzwddvqY232Kqs1NiKc5INNRiLipO
        BAAQqgdnRAQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684
References: <20230512134323.GA32242@lst.de>
        <20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684@epcms2p1>
        <20230510084854epcms2p756a3e1055399ead6bf539d3419c74c3e@epcms2p7>
        <CGME20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684@epcms2p8>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi Jinyoung,
>
>can you work a bit on the commit log and especially the subject line?
>
>I'd word this as something like:
>
>=22Subject: bio-integrity: create multi-page bvecs in bio_integrity_add_pa=
ge()
>
>Allow bio_integrity_add_page to create multi-page bvecs, just like
>the bio payloads. =C2=A0This=20simplifies=20adding=20larger=20payloads,=20=
and=20fixes=0D=0A>support=20for=20non-tiny=20workloads=20with=20nvme,=20whi=
ch=20stopped=20using=20scatterlist=0D=0A>for=20metadata=20a=20while=20ago=
=22=0D=0A>=0D=0A=0D=0AHi.=20Christoph.=20I=20checked=20late.=0D=0A=0D=0AOK.=
=20I=20will=20revise=20it=20like=20that.=0D=0A=0D=0A>It=20should=20probably=
=20also=20mentioned=20somewhere=20that=20you=20did=20an=20audit=20to=0D=0A>=
ensure=20all=20drivers=20and=20the=20core=20code=20is=20fine=20with=20these=
=20multi-page=0D=0A>segments.=20=C2=A0If=20it's=20not,=20this=20patch=20sho=
uld=20only=20be=20added=20after=20that=0D=0A>has=20been=20made=20the=20case=
.=0D=0A=0D=0ARegardless=20of=20a=20single-page=20or=20a=20multi-page=20conf=
iguration,=0D=0Ablock_rq_count_integrity_sg()=20and=20block_rq_map_integry_=
sg()=20check=0D=0Athe=20pages=20included=20in=20the=20bip=20to=20create=20a=
=20segment=20for=20sg.=0D=0ASo...=20there=20doesn't=20seem=20to=20be=20a=20=
problem=20yet.=0D=0A=0D=0AFirst,=20the=20nvme=20device=20that=20supports=20=
fips=20was=20tested=20using=20the=20above=0D=0Afunctions,=20and=20it=20was=
=20also=20checked=20with=20the=20dix=20of=20scsi_debug=20turned=20on.=0D=0A=
I=20am=20also=20trying=20to=20test=20the=20sas=20device=20that=20supports=
=20sed.=20It=20seems=20that=0D=0Aa=20problem=20occurs=20while=20going=20thr=
ough=20the=20laid=20controller=20(mpt3sas=20driver).=0D=0AIt=20works=20norm=
ally=20in=20DIF=20mode,=20but=20protection=20error=20occurs=20when=20DIX=20=
mode=0D=0Ais=20forcibly=20activated.=20Of=20course,=20the=20same=20is=20hap=
pening=20in=20the=20original=20code.=0D=0AI=20will=20check=20additionally=
=20and=20be=20careful=20not=20to=20cause=20any=20problems.=0D=0A=0D=0A>=0D=
=0A>I=20think=20the=20extra=20arguments=20struct=20is=20a=20bit=20overcompl=
iated,=20and=20mostly=0D=0A>due=20to=20me=20making=20the=20existing=20code=
=20to=20weird=20things=20in=20the=20low-level=0D=0A>helpers.=20=C2=A0With=
=20the=20=22rationalize=20the=20flow=20in=20bio_add_page=20and=20friends=22=
=0D=0A>series=20I=20just=20sent=20out,=20I=20think=20we=20can=20drop=20the=
=20previous=20patch=20and=0D=0A>simplify=20this=20one=20down=20to:=0D=0A=0D=
=0AI=20tried=20not=20to=20make=20a=20big=20change=20from=20the=20existing=
=20logic.=20So=20I=20added=0D=0Astruct=20unnecessarily.=20I=20thought=20it=
=20would=20be=20a=20problem=20if=20I=20added=20=0D=0Aconditions=20to=20the=
=20callers=20and=20made=20them=20call=20the=20common=20code.=0D=0AThank=20y=
ou=20for=20solving=20this=20part.=0D=0AIf=20your=20code=20merges,=20I=20wil=
l=20modify=20it=20accordingly=20and=20proceed.=0D=0A=0D=0ABest=20Regards,=
=0D=0AJinyoung.=0D=0A
