Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1119633367
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 03:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbiKVChT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 21:37:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbiKVChI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 21:37:08 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE7EC6079
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 18:37:02 -0800 (PST)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221122023658epoutp02651da5e1a6477bef84b17347f98e5386~px539wmWK1011310113epoutp02Q
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 02:36:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221122023658epoutp02651da5e1a6477bef84b17347f98e5386~px539wmWK1011310113epoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1669084618;
        bh=9Eata4B+kgbb29SLg8P0D9QKqh1xrqopaU+U9QFKitM=;
        h=Subject:Reply-To:From:To:Date:References:From;
        b=vS/gr5p5K4IDK6wextLnWf6ijGagMDULnUjYZaCc6kqIOXN9fj3LQUCDaiW9eFJGa
         c4CYdaXbb2Bfyy4/IQ9WO2JA0exBE1VWOmh3c0gTQpdhR1xq7ieUykDe86YI7kuOss
         6Mp5R1PW1OnftGcvPGTJcqzwaVb8n8ofGkKp6wCw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20221122023657epcas2p40179ba2ae289fb1a9618df903de5280f~px53Yoydb2507025070epcas2p4u;
        Tue, 22 Nov 2022 02:36:57 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.92]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4NGT1515Dhz4x9Pv; Tue, 22 Nov
        2022 02:36:57 +0000 (GMT)
X-AuditID: b6c32a48-64bff7000001494a-fd-637c35c932f6
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        A2.AF.18762.9C53C736; Tue, 22 Nov 2022 11:36:57 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v1] f2fs: avoid victim selection from previous victim
 section
Reply-To: yonggil.song@samsung.com
Sender: Yonggil Song <yonggil.song@samsung.com>
From:   Yonggil Song <yonggil.song@samsung.com>
To:     "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "chao@kernel.org" <chao@kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20221122023656epcms2p4468d4feb97711516206e19890dad09ac@epcms2p4>
Date:   Tue, 22 Nov 2022 11:36:56 +0900
X-CMS-MailID: 20221122023656epcms2p4468d4feb97711516206e19890dad09ac
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGKsWRmVeSWpSXmKPExsWy7bCmhe5J05pkg2MLWCxOTz3LZPFk/Sxm
        i0uL3C0u75rDZjH1/BEmB1aPTas62Tx2L/jM5NG3ZRWjx+dNcgEsUdk2GamJKalFCql5yfkp
        mXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUBrlRTKEnNKgUIBicXFSvp2NkX5
        pSWpChn5xSW2SqkFKTkF5gV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGf0NPYwFD6QqLu1eyNjA
        2CbVxcjOISFgIrE1u4uRi0NIYAejxK1V+xi7GDk4eAUEJf7uEO5i5OQQFvCXmHH+IAuILSSg
        JHHtQC8LRFxfYvPiZewgNpuArsTfDcvBbBGBV4wSZ1aLgtgSArwSM9qfskDY0hLbl29lhLA1
        JH4s62WGsEUlbq5+yw5jvz82H6pGRKL13lmoGkGJBz93Q8UlJRYdOs8EYedL/F1xnQ3CrpHY
        2tAGFdeXuNaxEWwvr4CvxOWOLjCbRUBV4sCnq1A1LhJNVzrB9jILaEssW/iaGeR1ZgFNifW7
        9EFMCQFliSO3WCAq+CQ6Dv9lh/lqx7wnUFPUJDZv2swKYctIXHjcBnWlh8T9D7fAJgoJBEqs
        WsU+gVF+FiJoZyFZOwth7QJG5lWMYqkFxbnpqcVGBSbwuEzOz93ECE5wWh47GGe//aB3iJGJ
        g/EQowQHs5IIb31MdbIQb0piZVVqUX58UWlOavEhRlOghycyS4km5wNTbF5JvKGJpYGJmZmh
        uZGpgbmSOG/XDK1kIYH0xJLU7NTUgtQimD4mDk6pBia+wl9Hc6bvlMrXZfwhKbjEaZXqCsEo
        xerreTbOnjaKfQderFRblM//4F5ohlWe9WnLpJLgQ+vE1R5cm3vv7K6IIGH9oJ3x2+3ctYJ/
        mBXcSD15r9e5d4nY7pV3V7buj6rhq4wWW/n/qYWLWle755GshJeShecCEjZc1s3j6Q6ZdLWR
        e65jZfw6z6PZj//fCUld69GU0JTEJXx88rxjjLz1N/ZMXT9nmoTNjY4lb9l23PxRZHqg4d99
        9kkHOf7utO/fsPDP28SY3V/mTFq+UuJI987vEVO/fHI5N0/5g8O5xrYDuhnL9pwJdOK8eo9v
        8fX9zFkz112Ymers4pRlNbOzsmDLKoUnuxO+5699aPtDiaU4I9FQi7moOBEA8J3jIfkDAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221102100756epcms2p23dfabe90c467313ce094c5c81a99c6d7
References: <CGME20221102100756epcms2p23dfabe90c467313ce094c5c81a99c6d7@epcms2p4>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When=C2=A0f2fs=C2=A0chooses=C2=A0GC=C2=A0victim=C2=A0in=C2=A0large=C2=A0sec=
tion=C2=A0&=C2=A0LFS=C2=A0mode,=0D=0Anext_victim_seg=5Bgc_type=5D=C2=A0is=
=C2=A0referenced=C2=A0first.=C2=A0After=C2=A0segment=C2=A0is=C2=A0freed,=0D=
=0Anext_victim_seg=5Bgc_type=5D=C2=A0has=C2=A0the=C2=A0next=C2=A0segment=C2=
=A0number.=0D=0AHowever,=C2=A0next_victim_seg=5Bgc_type=5D=C2=A0still=C2=A0=
has=C2=A0the=C2=A0last=C2=A0segment=C2=A0number=0D=0Aeven=C2=A0after=C2=A0t=
he=C2=A0last=C2=A0segment=C2=A0of=C2=A0section=C2=A0is=C2=A0freed.=C2=A0In=
=C2=A0this=C2=A0case,=C2=A0when=C2=A0f2fs=0D=0Achooses=C2=A0a=C2=A0victim=
=C2=A0for=C2=A0the=C2=A0next=C2=A0GC=C2=A0round,=C2=A0the=C2=A0last=C2=A0se=
gment=C2=A0of=C2=A0previous=C2=A0victim=0D=0Asection=C2=A0is=C2=A0chosen=C2=
=A0as=C2=A0a=C2=A0victim.=0D=0A=0D=0AInitialize=C2=A0next_victim_seg=5Bgc_t=
ype=5D=C2=A0to=C2=A0NULL_SEGNO=C2=A0for=C2=A0the=C2=A0last=C2=A0segment=C2=
=A0in=0D=0Alarge=C2=A0section.=0D=0A=0D=0AFixes:=20e3080b0120a1=20(=22f2fs:=
=20support=20subsectional=20garbage=20collection=22)=0D=0ASigned-off-by:=C2=
=A0Yonggil=C2=A0Song=C2=A0<yonggil.song=40samsung.com>=0D=0A---=0D=0A=C2=A0=
fs/f2fs/gc.c=C2=A0=7C=C2=A05=C2=A0+++--=0D=0A=C2=A01=C2=A0file=C2=A0changed=
,=C2=A03=C2=A0insertions(+),=C2=A02=C2=A0deletions(-)=0D=0A=0D=0Adiff=C2=A0=
--git=C2=A0a/fs/f2fs/gc.c=C2=A0b/fs/f2fs/gc.c=0D=0Aindex=C2=A04546e01b2ee0.=
.10677d53ef0e=C2=A0100644=0D=0A---=C2=A0a/fs/f2fs/gc.c=0D=0A+++=C2=A0b/fs/f=
2fs/gc.c=0D=0A=40=40=C2=A0-1744,8=C2=A0+1744,9=C2=A0=40=40=C2=A0static=C2=
=A0int=C2=A0do_garbage_collect(struct=C2=A0f2fs_sb_info=C2=A0*sbi,=0D=0A=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0get_valid_blocks(sbi,=C2=A0seg=
no,=C2=A0false)=C2=A0=3D=3D=C2=A00)=0D=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0seg_freed++;=0D=0A=C2=A0=0D=0A-=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if=C2=A0(__is_large_section(sbi)=C2=A0&&=C2=A0segno=C2=
=A0+=C2=A01=C2=A0<=C2=A0end_segno)=0D=0A-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sbi->next_victim_seg=5Bgc_type=5D=C2=A0=
=3D=C2=A0segno=C2=A0+=C2=A01;=0D=0A+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if=C2=A0(__is_larg=
e_section(sbi))=0D=0A+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0sbi->next_victim_seg=5Bgc_type=5D=C2=A0=3D=0D=0A+=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(segno=C2=A0+=C2=A01=C2=A0<=C2=A0end_se=
gno)=C2=A0?=C2=A0segno=C2=A0+=C2=A01=C2=A0:=C2=A0NULL_SEGNO;=0D=0A=C2=A0ski=
p:=0D=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0f2fs_put_page(sum_page,=C2=A00);=0D=0A=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=7D=0D=0A--=C2=A0=0D=
=0A2.34.1
