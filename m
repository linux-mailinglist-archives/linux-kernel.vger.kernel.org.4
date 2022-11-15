Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3E0628E99
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 01:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbiKOAqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 19:46:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbiKOAp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 19:45:58 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C9417055
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 16:45:55 -0800 (PST)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221115004551epoutp02e965704c3db8bba995b04112fbf8fb42~nm33gCeQe1571015710epoutp02T
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 00:45:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221115004551epoutp02e965704c3db8bba995b04112fbf8fb42~nm33gCeQe1571015710epoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1668473151;
        bh=oj9e3eFsrbOoWOnn2DyErDzRa00Smme7Tym+p+M+iCY=;
        h=Subject:Reply-To:From:To:Date:References:From;
        b=Q7q4bwiytu4Wt9I29sfAYtC0C75xdYYC9n28YjOnUDxAGdahjFSbvg5eXozRwLH3e
         WKsP/4FN+lrbUHH2iWCGCqOMdEO607YA74a70MjV6CNcTrBiSyYZTLgSsAbuL+Fk/e
         A1n5oSFznQcqV8RicpcW7wdHs2DO4ZMWG893MuSY=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20221115004551epcas2p4a757945b4465e7bf0120fd2083bc55cd~nm33L7WMh0862508625epcas2p4F;
        Tue, 15 Nov 2022 00:45:51 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.92]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4NB6t66nQ5z4x9Pq; Tue, 15 Nov
        2022 00:45:50 +0000 (GMT)
X-AuditID: b6c32a48-64bff7000001494a-0d-6372e13eb9bc
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        F8.68.18762.E31E2736; Tue, 15 Nov 2022 09:45:50 +0900 (KST)
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
Message-ID: <20221115004550epcms2p7cf1a6312fd35de690ba52304390cbfee@epcms2p7>
Date:   Tue, 15 Nov 2022 09:45:50 +0900
X-CMS-MailID: 20221115004550epcms2p7cf1a6312fd35de690ba52304390cbfee
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBKsWRmVeSWpSXmKPExsWy7bCmma7dw6Jkg8+/TC1OTz3LZPFk/Sxm
        i0uL3C0u75rDZjH1/BEmB1aPTas62Tx2L/jM5NG3ZRWjx+dNcgEsUdk2GamJKalFCql5yfkp
        mXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUBrlRTKEnNKgUIBicXFSvp2NkX5
        pSWpChn5xSW2SqkFKTkF5gV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGfvnP2Yv+C9ZMf3Af/YG
        xpWSXYycHBICJhI7O26ydjFycQgJ7GCU2LZ3FWMXIwcHr4CgxN8dwiA1wgL+EjPOH2QBsYUE
        lCSuHehlgYjrS2xevIwdxGYT0JX4u2E5mC0i8IpR4sxqUYj5vBIz2p+yQNjSEtuXb2WEsDUk
        fizrZYawRSVurn7LDmO/PzYfqkZEovXeWagaQYkHP3dDxSUlFh06zwRh50v8XXGdDcKukdja
        0AYV15e41rGRBeIVX4knN4xAwiwCqhKH73yEWuUi8fPRIlYQm1lAW2LZwtfMIOXMApoS63fp
        g5gSAsoSR26xQFTwSXQc/ssO89SOeU+gFqlJbN60mRXClpG48LgN6kgPifsfbjFDAi1Q4vXM
        GewTGOVnIYJ2FpK9sxD2LmBkXsUollpQnJueWmxUYAKPzeT83E2M4CSn5bGDcfbbD3qHGJk4
        GA8xSnAwK4nwzpPJTxbiTUmsrEotyo8vKs1JLT7EaAr08URmKdHkfGCazSuJNzSxNDAxMzM0
        NzI1MFcS5+2aoZUsJJCeWJKanZpakFoE08fEwSnVwNR0REh5aZ/SrvOFmf/jU3R8r+4Ujq07
        s/igRJbmh/tsHFscJSat22UecLJFN0L4+CRdDZtnfPaLF/Wxa97P9Xqq8o6vfaVD+UqRN8fv
        sa9buLMnk/n67KybMyyLZxdJTLh9qmT2XQ4O56oVa9Nmru9McLp+t6PHQldp5ozvufXNp/wn
        Hry0Y3GNtVrklgT1VSciNnT75pn4BN619+7+53Y3tPpJ43z9BZk+B+/FtF++uTVgV6qDWsbv
        g865q25caJ7xfu/iu9aZrOt7TH1VDgr5LvTbITHvy5ujnS++FJh9+cUvHRu1+W+rB0djlKbn
        5MDLa2on8Jy4HWy4Y6bo61f30neKb+nmPFXsoFGzLVOJpTgj0VCLuag4EQDnaQc4+wMAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221102100756epcms2p23dfabe90c467313ce094c5c81a99c6d7
References: <CGME20221102100756epcms2p23dfabe90c467313ce094c5c81a99c6d7@epcms2p7>
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
=A0in=0D=0Alarge=C2=A0section.=0D=0A=0D=0ASigned-off-by:=C2=A0Yonggil=C2=A0=
Song=C2=A0<yonggil.song=40samsung.com>=0D=0A---=0D=0A=C2=A0fs/f2fs/gc.c=C2=
=A0=7C=C2=A05=C2=A0+++--=0D=0A=C2=A01=C2=A0file=C2=A0changed,=C2=A03=C2=A0i=
nsertions(+),=C2=A02=C2=A0deletions(-)=0D=0A=0D=0Adiff=C2=A0--git=C2=A0a/fs=
/f2fs/gc.c=C2=A0b/fs/f2fs/gc.c=0D=0Aindex=C2=A04546e01b2ee0..10677d53ef0e=
=C2=A0100644=0D=0A---=C2=A0a/fs/f2fs/gc.c=0D=0A+++=C2=A0b/fs/f2fs/gc.c=0D=
=0A=40=40=C2=A0-1744,8=C2=A0+1744,9=C2=A0=40=40=C2=A0static=C2=A0int=C2=A0d=
o_garbage_collect(struct=C2=A0f2fs_sb_info=C2=A0*sbi,=0D=0A=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0get_valid_blocks(sbi,=C2=A0segno,=C2=A0fal=
se)=C2=A0=3D=3D=C2=A00)=0D=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0seg_freed++;=0D=0A=C2=A0=0D=0A-=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0if=C2=A0(__is_large_section(sbi)=C2=A0&&=C2=A0segno=C2=A0+=C2=A01=
=C2=A0<=C2=A0end_segno)=0D=0A-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0sbi->next_victim_seg=5Bgc_type=5D=C2=A0=3D=C2=A0seg=
no=C2=A0+=C2=A01;=0D=0A+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if=C2=A0(__is_large_section(sb=
i))=0D=0A+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0sbi->next_victim_seg=5Bgc_type=5D=C2=A0=3D=0D=0A+=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0(segno=C2=A0+=C2=A01=C2=A0<=C2=A0end_segno)=C2=A0?=
=C2=A0segno=C2=A0+=C2=A01=C2=A0:=C2=A0NULL_SEGNO;=0D=0A=C2=A0skip:=0D=0A=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0f2fs_put_page(sum_page,=C2=A00);=0D=0A=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=7D=0D=0A--=C2=A0=0D=0A2.34.1
