Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04186F653F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 08:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjEDGsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 02:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjEDGsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 02:48:01 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AA72728
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 23:47:59 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230504064757epoutp04e4d7f5bcb8b5b161502b89fe22cb6bc8~b3ejOcmAK1807918079epoutp04s
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 06:47:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230504064757epoutp04e4d7f5bcb8b5b161502b89fe22cb6bc8~b3ejOcmAK1807918079epoutp04s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683182877;
        bh=8a+D469i+vkHAxN6iDvWl8ngbgBCSjHZ3wFl2e3DQwM=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=VDww7eCQTHXKdK5dNAm1aIRzIbOc9IKIDaOOkCgrXw559jHo1fR4ISSTiaI5rNILS
         QWFJgZtFsfAWKfJBdE3BNuLOGtOw45wNUKUSC2OO3lgF8PxQEzil3kF98vqKnVxH6w
         iq8eIdMI2k2UPzhQf/N4snI2UiFtRckeO8pRev+w=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230504064757epcas2p1160f37b6d615008ef1312ff7d6ce79d3~b3ei5LuyD2860128601epcas2p11;
        Thu,  4 May 2023 06:47:57 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.88]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4QBksS5wgsz4x9Pq; Thu,  4 May
        2023 06:47:56 +0000 (GMT)
X-AuditID: b6c32a45-465ff70000020cc1-ce-6453551c9128
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        13.AA.03265.C1553546; Thu,  4 May 2023 15:47:56 +0900 (KST)
Mime-Version: 1.0
Subject: RE:(2) [PATCH 02/15] block: blk-integiry: add helper functions for
 bio_integrity_add_page
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
In-Reply-To: <20230503155501.GB31700@lst.de>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230504064656epcms2p79ffe075ea27710f311b8c1738ed10be0@epcms2p7>
Date:   Thu, 04 May 2023 15:46:56 +0900
X-CMS-MailID: 20230504064656epcms2p79ffe075ea27710f311b8c1738ed10be0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFKsWRmVeSWpSXmKPExsWy7bCmua5MaHCKwdo/Char7/azWbw8pGmx
        cvVRJou9t7QtLu+aw2ax/Pg/Jgc2j8tnSz1232xg8/j49BaLR9+WVYwenzfJBbBGZdtkpCam
        pBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAK1XUihLzCkFCgUk
        Fhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYF+gVJ+YWl+al6+WlllgZGhgYmQIVJmRnrPq9j7lg
        J1/FkndXmBoY3/F2MXJySAiYSOzuu8/axcjFISSwg1Gid+pMti5GDg5eAUGJvzuEQWqEBVIk
        /v89yQZiCwkoSZxbM4sRpERYwEDiVq85SJhNQE/i55IZYJ0iArISV1bUg0xkFnjCKLF55Xw2
        iFW8EjPan7JA2NIS25dvZQSxOQV0JA5tPcoKEdeQ+LGslxnCFpW4ufotO4z9/th8RghbRKL1
        3lmoGkGJBz93Q8UlJQ4d+gp2g4RAvsSGA4EQ4RqJt8sPQJXoS1zr2Ah2Aq+Ar8Tu9xvAbBYB
        VYm9Lz9DnekiMaFnLVicWUBbYtnC18wgI5kFNCXW79KHmK4sceQWVAWfRMfhv+wwDzZs/I2V
        vWPeEyaIVjWJRU1GExiVZyECeRaSVbMQVi1gZF7FKJZaUJybnlpsVGAIj9fk/NxNjOBEqOW6
        g3Hy2w96hxiZOBgPMUpwMCuJ8H4o9EsR4k1JrKxKLcqPLyrNSS0+xGgK9OREZinR5HxgKs4r
        iTc0sTQwMTMzNDcyNTBXEueVtj2ZLCSQnliSmp2aWpBaBNPHxMEp1cDkIs++84HJmXQTWeHt
        5yvSJlnmp27cEvZywz05tdSZ3ud+bJX2q5JcLHlhRsRS3bnxYvPqGbfp/Pm1Vkgzar9Y97Zv
        ktZ7/zhnyv36+8F6xbKnZp/k418bFEdo5W28pFa8OPeogt7xBRMam66bHdT8a/pew6fp9adr
        B1xai3fwcFcvfrSZ2S9D8qrSi65/V/JUuBzWvi+6dkOQza79SohEjOvZ66u3qWXNu9MY/LNx
        tpXPLQfOBOnP8btLk10lD6apBZjI7tHfLx9d9O7D/1CDA0sL7J+cklifO3GZ4NW/zw692lXJ
        Xefn+U+27y+Tzb5GbrG151s9JVbr2SUsiixd+eznrmN2p3Xi3F4uVDJUYinOSDTUYi4qTgQA
        /GS5Sg0EAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323
References: <20230503155501.GB31700@lst.de>
        <20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323@epcms2p4>
        <20230503100220epcms2p33e69fd7d5f04b305c621799792e8155f@epcms2p3>
        <CGME20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323@epcms2p7>
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

>s/blk-integiry/blk-integrity/ in the subject.
>
>> +static inline bool bip_full(struct bio_integrity_payload *bip, unsigned=
 int len)
>
>> +static bool bip_try_merge_hw_seg(struct request_queue *q,
>> + =C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
struct=20bio_integrity_payload=20*bip,=0D=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20struct=20page=20*page,=20un=
signed=20int=20len,=0D=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20unsigned=20int=20offset,=20bool=20*same_page)=
=0D=0A>=0D=0A>...=20but=20adding=20static=20functions=20without=20users=20w=
ill=20cause=20a=20compile=0D=0A>error=20anyway,=20so=20I'd=20suggest=20to=
=20just=20merge=20it=20into=20the=20patch=20adding=0D=0A>users.=0D=0A>=0D=
=0A>But=20I=20wonder=20if=20we=20really=20want=20to=20duplicate=20all=20thi=
s=20logic=20anyway.=0D=0A>If=20we=20passed=20a=20bio_vec=20array,=20the=20v=
ec=20count=20and=20an=20iter,=20we=20should=0D=0A>be=20able=20to=20just=20s=
hare=20the=20logic=20with=20the=20bio=20data=20payload.=0D=0A=0D=0AThank=20=
you,=20Christoph.=0D=0A=0D=0AI=20made=20a=20mistake=20while=20dividing=20th=
e=20patch.=20I=20will=20be=20careful.=0D=0AI=20will=20merge=20with=20the=20=
code=20that=20uses=20the=20function=20and=20put=20it=20on=20the=20next=20pa=
tch.=0D=0A=0D=0AAnd=20as=20you=20mentioned,=20it=20is=20duplicated=20with=
=20the=20configuration=20of=20bio's=20data=20payload.=0D=0AI=20will=20impro=
ve=20this=20by=20reflecting=20your=20proposal.=0D=0A=0D=0ABest=20regards,=
=0D=0AJinyoung.
