Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFBD72F46A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 08:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242736AbjFNGJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 02:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234205AbjFNGJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 02:09:03 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10906E55
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 23:09:01 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230614060858epoutp039fd340fa87c687f13f4920896badda83~ocZOBnB2-1281412814epoutp03m
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 06:08:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230614060858epoutp039fd340fa87c687f13f4920896badda83~ocZOBnB2-1281412814epoutp03m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1686722938;
        bh=Ams/WCEjAdJZZhA9Dn0/3apZO2D9Et1VjB/NoGAccik=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=JEA+az0rQTF763c935Bfj2kn2JuWmkniLqaYlyP1ORxofTkGu/BpF+EFN/BveLjP9
         48klM+aBuvHuckk2tOkuF8jBHfF5fXQh/99xcgOu7RcmB1YPe5OtmTliUN/JZTLc0H
         2XX6/ntn+8abEsjp0tIAdfnciopqs5i7WEBzsKh4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230614060858epcas2p416e7127c36b51ad767165207f5047542~ocZNTfPh01707717077epcas2p40;
        Wed, 14 Jun 2023 06:08:58 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.70]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Qgw3Y3j9tz4x9Q0; Wed, 14 Jun
        2023 06:08:57 +0000 (GMT)
X-AuditID: b6c32a48-c3ff87000000acbc-6c-6489597951a4
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        06.42.44220.97959846; Wed, 14 Jun 2023 15:08:57 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [f2fs-dev] [PATCH] f2fs: do not issue small discard commands
 during checkpoint
Reply-To: daejun7.park@samsung.com
Sender: Daejun Park <daejun7.park@samsung.com>
From:   Daejun Park <daejun7.park@samsung.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     Daejun Park <daejun7.park@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230613203947.2745943-1-jaegeuk@kernel.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230614060757epcms2p4e11a8f8bf2fa44eac99a5bb7f47f8dcd@epcms2p4>
Date:   Wed, 14 Jun 2023 15:07:57 +0900
X-CMS-MailID: 20230614060757epcms2p4e11a8f8bf2fa44eac99a5bb7f47f8dcd
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEKsWRmVeSWpSXmKPExsWy7bCmuW5lZGeKQetHCYuXhzQtVj0It3iy
        fhazxaVF7haXd81hc2D12LSqk81j94LPTB59W1YxenzeJBfAEpVtk5GamJJapJCal5yfkpmX
        bqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQO0VEmhLDGnFCgUkFhcrKRvZ1OUX1qS
        qpCRX1xiq5RakJJTYF6gV5yYW1yal66Xl1piZWhgYGQKVJiQnTG1ZzpTwRfuinu7t7M3MP7l
        6mLk5JAQMJE4crSFqYuRi0NIYAejxN/DX9m7GDk4eAUEJf7uEAYxhQViJRZOswEpFxJQklh/
        cRY7iC0soCdx6+EaRhCbTUBHYvqJ+2BxEYFdjBIX25NAbGYBLYlzW9cxQqzilZjR/pQFwpaW
        2L58K1icU8BK4kTvGlaIuIbEj2W9zBC2qMTN1W/ZYez3x+ZDzRGRaL13FqpGUOLBz91QcUmJ
        23M3QdXnS/y/shzKrpHYdmAelK0vca1jI9gNvAK+Esdv3gfrZRFQlXi98A3UHBeJD2eWM0Lc
        ry2xbOFrZlAwMAtoSqzfpQ9iSggoSxy5xQJRwSfRcfgvO8yHDRt/Y2XvmPeECcJWk1j3cz3T
        BEblWYhgnoVk1yyEXQsYmVcxiqUWFOempxYbFZjAYzY5P3cTIzjxaXnsYJz99oPeIUYmDsZD
        jBIczEoivE812lOEeFMSK6tSi/Lji0pzUosPMZoCfTmRWUo0OR+YevNK4g1NLA1MzMwMzY1M
        DcyVxHk/diinCAmkJ5akZqemFqQWwfQxcXBKNTBtSn6dYKIdMfWv8+Rl1cEzM4S5T6x587hB
        +8KfDzt29Myczd4b++TzIT7ZrbFWks8nl5ZyWG46L7CrUNqwVtp7bq2X40qLX9cXVq4p/xug
        9qROYs+OO1+PHHff9TPJ/OuTFLtkK5P/QnMFm6/KGLAxl055+3v1pukNld3TDc5MuX0iY2rd
        5i+WOfERWjMt1LZbfMtRf1IveFb544Epp9mKD54vdllxesYmp4rvhvJ+p8S3132b7sC5W0Xr
        xJxFbZbRH9K32tY/2qP9+0dH4qq2BL4Vr55Ipac4/Ao5sSzoyN9vK/UuRNi/NCoLO35DN/bJ
        X/arbFNK8hcfj08QP7mQWeK19PEj/n63SvhuTxN7r8RSnJFoqMVcVJwIAEbnOmQFBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230613204109epcas2p158ecc100d3fe2db1ab2b7ee8335d01e7
References: <20230613203947.2745943-1-jaegeuk@kernel.org>
        <CGME20230613204109epcas2p158ecc100d3fe2db1ab2b7ee8335d01e7@epcms2p4>
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

Hi Jaegeuk,

> If there're huge =23 of small discards, this will increase checkpoint lat=
ency
> insanely. Let's issue small discards only by trim.
>=20
> Signed-off-by: Jaegeuk Kim <jaegeuk=40kernel.org>
> ---
>  fs/f2fs/segment.c =7C 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 0c0c033c4bdd..ef46bb085385 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> =40=40 -2178,7 +2178,7 =40=40 void f2fs_clear_prefree_segments(struct f2f=
s_sb_info *sbi,
> =C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=7D=0D=0A>=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0mutex_unlock(&dirty_i->seglist_lock);=0D=0A>=20=20=
=0D=0A>=20-=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(=21f2fs_block_unit_dis=
card(sbi))=0D=0A>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(=21f2fs_bloc=
k_unit_discard(sbi)=20=7C=7C=20=21force)=0D=0A=0D=0AIf=20we=20don't=20handl=
e=20the=20discard=20entries=20here,=20dcc->entry_list=20will=20still=20have=
=20them,=0D=0Aso=20stale=20discard=20entries=20may=20be=20handled=20by=20tr=
im,=20causing=20incorrect=20discards=20to=20be=20issued.=0D=0ATherefore,=20=
I=20think=20this=20patch=20should=20also=20prevent=20the=20creation=20of=20=
discard=20entries=0D=0Ain=20add_discard_addrs(),=20unless=20it=20is=20a=20c=
heckpoint=20caused=20by=20trim.=0D=0AThis=20would=20further=20reduce=20the=
=20latency=20caused=20by=20the=20creation=20of=20a=20discard=20entry.=0D=0A=
=0D=0AThanks,=0D=0ADaejun=0D=0A
