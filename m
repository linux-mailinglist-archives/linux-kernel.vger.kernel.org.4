Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432436FEB28
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 07:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236989AbjEKFZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 01:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237081AbjEKFZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 01:25:34 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D8E5FCA
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 22:25:21 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230511052519epoutp033041bd0dfb7046c049ec3710a71de062~d-3ZH1BaD2285222852epoutp03B
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 05:25:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230511052519epoutp033041bd0dfb7046c049ec3710a71de062~d-3ZH1BaD2285222852epoutp03B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683782719;
        bh=fLVK7KBZ32XSildPIaB5COvYPr0XZ5nBEhc/QDNwkYo=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=dwoUC3r1j7JyMIhpP0GiLHbYSZ+Zl3edb0pDL6OK63y3oUNR08oizcaiW4eSVQUQe
         mb2k3LvUsf5/opcT1bjzFvZEkoj6MToaaggsYU0R0+FbcYoqKgaFSftS4nhZquXbf5
         +rJMnxRZD00+3Ww8wX83kWwEZH8r6+PstOyd9XTs=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230511052518epcas2p3a06654af90be8b634d6979028111fd74~d-3YwwLdg0223902239epcas2p3h;
        Thu, 11 May 2023 05:25:18 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.70]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4QH0ht1Pt8z4x9Q1; Thu, 11 May
        2023 05:25:18 +0000 (GMT)
X-AuditID: b6c32a45-6d1fd70000020cc1-42-645c7c3e3f44
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        9A.0F.03265.E3C7C546; Thu, 11 May 2023 14:25:18 +0900 (KST)
Mime-Version: 1.0
Subject: RE:(2) [PATCH v6] f2fs: add async reset zone command support
Reply-To: daejun7.park@samsung.com
Sender: Daejun Park <daejun7.park@samsung.com>
From:   Daejun Park <daejun7.park@samsung.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>,
        Daejun Park <daejun7.park@samsung.com>
CC:     "chao@kernel.org" <chao@kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        Seokhwan Kim <sukka.kim@samsung.com>,
        Yonggil Song <yonggil.song@samsung.com>,
        beomsu kim <beomsu7.kim@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <ZFqWr3sSYMsHtHAC@google.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230511052416epcms2p617838faa71a203da6978c89ffd216e91@epcms2p6>
Date:   Thu, 11 May 2023 14:24:16 +0900
X-CMS-MailID: 20230511052416epcms2p617838faa71a203da6978c89ffd216e91
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDJsWRmVeSWpSXmKPExsWy7bCmma5dTUyKwcmbLBYX5n1ktjg99SyT
        xctDmharHoRbPFk/i9ni0iJ3i8u75rBZHFl/lsVi8XI1i30dD5gsVnXMZbSYev4IkwOPR8u+
        W+wem1Z1snnsXvCZyaNvyypGj8+b5AJYo7JtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1
        DS0tzJUU8hJzU22VXHwCdN0yc4BuU1IoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQU
        mBfoFSfmFpfmpevlpZZYGRoYGJkCFSZkZ6z9WlzwawdjxYtXj9kbGCdsYexi5OSQEDCROPDl
        J2sXIxeHkMAORokLnb+BEhwcvAKCEn93CIPUCAu4SvydepoJxBYSUJJYf3EWO0RcT+LWwzVg
        c9gEdCSmn7gPFhcR8JF40bmWGWQms8BDZoneCbtYIJbxSsxofwplS0tsX74VrJlTQEtizqFH
        7BBxDYkfy3qZIWxRiZur37LD2O+PzYc6WkSi9d5ZqBpBiQc/d0PFJSVuz90EVZ8v8f/Kcii7
        RmLbgXlQtr7EtY6NYDfwCvhKbFrfDTaHRUBV4smHFawQNS4Se/sngD3MLKAtsWzha2ZQmDAL
        aEqs36UPYkoIKEscucUCUcEn0XH4LzvMhw0bf2Nl75j3hAnCVpNY93M90wRG5VmIgJ6FZNcs
        hF0LGJlXMYqlFhTnpqcWGxUYwiM3OT93EyM4mWq57mCc/PaD3iFGJg7GQ4wSHMxKIrxvl0Sn
        CPGmJFZWpRblxxeV5qQWH2I0BfpyIrOUaHI+MJ3nlcQbmlgamJiZGZobmRqYK4nzStueTBYS
        SE8sSc1OTS1ILYLpY+LglGpgCpKwWF91kiFX8cg6m1RRvYc7Gzw8AhxVdcvmnJy6ZgOnY/gU
        4bXayT4Kf6L/R8iXNe7uOiNm4Xhq8Z64o137JvoIn3us1crRkG22947kSrVo4/ezphkcLnro
        HrIw/Z1c81ePGOPFtzYnzJHrnOkUVRa5NSL/8pSIvWZci1gbY9eYML8O99Sp28+9VFR06f5b
        C5bzS106kPoghXHVLpbrRlu1mT50OodY2IT2FuvaBkxUde+YuvdHYA37V3f5t+lfP6z/Wm55
        nUkvO2ZfSYamhZdu1BrzycpirVnxP0/r9n40cJirvsm4KL2CYYt8cfX2X4Fn/5x7XiHW/6sy
        RN35tXUJw+VCrayDd7g62JVYijMSDbWYi4oTATX0jkAvBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230508081042epcms2p8a637deae7de1829f54614e09d5fde5e5
References: <ZFqWr3sSYMsHtHAC@google.com>
        <20230508081042epcms2p8a637deae7de1829f54614e09d5fde5e5@epcms2p8>
        <CGME20230508081042epcms2p8a637deae7de1829f54614e09d5fde5e5@epcms2p6>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Sender : Jaegeuk Kim=C2=A0<jaegeuk=40kernel.org>=0D=0A>=20Date=20:=202023=
-05-10=2003:53=20(GMT+9)=0D=0A>=20Title=20:=20Re:=20=5BPATCH=20v6=5D=20f2fs=
:=20add=20async=20reset=20zone=20command=20support=0D=0A>=20To=20:=20=EB=B0=
=95=EB=8C=80=EC=A4=80<daejun7.park=40samsung.com>=0D=0A>=20CC=20:=20chao=40=
kernel.org<chao=40kernel.org>,=20rostedt=40goodmis.org<rostedt=40goodmis.or=
g>,=20mhiramat=40kernel.org<mhiramat=40kernel.org>,=20linux-f2fs-devel=40li=
sts.sourceforge.net<linux-f2fs-devel=40lists.sourceforge.net>,=20linux-kern=
el=40vger.kernel.org<linux-kernel=40vger.kernel.org>,=20linux-trace-kernel=
=40vger.kernel.org<linux-trace-kernel=40vger.kernel.org>,=20=EA=B9=80=EC=84=
=9D=ED=99=98<sukka.kim=40samsung.com>,=20=EC=86=A1=EC=9A=A9=EA=B8=B8<yonggi=
l.song=40samsung.com>,=20=EA=B9=80=EB=B2=94=EC=88=98<beomsu7.kim=40samsung.=
com>=0D=0A>=20=C2=A0=0D=0A>=20On=2005/08,=20Daejun=20Park=20wrote:=0D=0A>=
=20>=20v5=20->=20v6=0D=0A>=20>=20Added=20trace_f2fs_iostat=20support=20for=
=20zone=20reset=20command.=0D=0A>=20>=20=0D=0A>=20>=20v4=20->=20v5=0D=0A>=
=20>=20Added=20f2fs=20iostat=20for=20zone=20reset=20command.=0D=0A>=20>=20=
=0D=0A>=20>=20v3=20->=20v4=0D=0A>=20>=20Fixed=20build=20error=20caused=20by=
=20unused=20function.=0D=0A>=20>=20=0D=0A>=20>=20v2=20->=20v3=0D=0A>=20>=20=
Modified=20arguments=20to=20be=20correct=20for=20ftrace=20parameter.=0D=0A>=
=20>=20Changed=20__submit_zone_reset_cmd=20to=20void=20return.=0D=0A>=20>=
=20Refactored=20the=20f2fs_wait_discard_bio=20function.=0D=0A>=20>=20Fixed=
=20code=20that=20was=20previously=20incorrectly=20merged.=0D=0A>=20>=20=0D=
=0A>=20>=20v1=20->=20v2=0D=0A>=20>=20Changed=20to=20apply=20the=20optional=
=20async=20reset=20write=20pointer=20by=20default.=0D=0A>=20=0D=0A>=20Don't=
=20add=20the=20history=20in=20the=20patch=20description.=0D=0A=0D=0AOK,=20I=
=20will=20do.=0D=0A=0D=0A>=20>=20=0D=0A>=20>=20This=20patch=20enables=20sub=
mit=20reset=20zone=20command=20asynchornously.=20It=20helps=0D=0A>=20>=20de=
crease=20average=20latency=20of=20write=20IOs=20in=20high=20utilization=20s=
cenario=20by=0D=0A>=20>=20faster=20checkpointing.=0D=0A>=20>=20=0D=0A>=20>=
=20Signed-off-by:=20Daejun=20Park=20<daejun7.park=40samsung.com>=0D=0A>=20>=
=20---=0D=0A>=20>=20=C2=A0fs/f2fs/f2fs.h=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=7C=20=C2=A01=20+=0D=0A>=20>=20=C2=A0fs/f2fs/=
iostat.c=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=7C=20=C2=A01=
=20+=0D=0A>=20>=20=C2=A0fs/f2fs/segment.c=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=7C=2084=20+++++++++++++++++++++++++++++++++++--=0D=0A>=20>=
=20=C2=A0include/trace/events/f2fs.h=20=7C=2024=20+++++++++--=0D=0A>=20>=20=
=C2=A04=20files=20changed,=20104=20insertions(+),=206=20deletions(-)=0D=0A>=
=20>=20=0D=0A>=20>=20diff=20--git=20a/fs/f2fs/f2fs.h=20b/fs/f2fs/f2fs.h=0D=
=0A>=20>=20index=20d211ee89c158..51b68a629814=20100644=0D=0A>=20>=20---=20a=
/fs/f2fs/f2fs.h=0D=0A>=20>=20+++=20b/fs/f2fs/f2fs.h=0D=0A>=20>=20=40=40=20-=
1175,6=20+1175,7=20=40=40=20enum=20iostat_type=20=7B=0D=0A>=20>=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0/*=20other=20*/=0D=0A>=20>=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0FS_DISCARD_IO,=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0/*=20discard=20*/=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0FS_FLUSH_IO,=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0/*=20flush=20*/=0D=0A>=20>=
=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0FS_ZONE_RESET_IO,=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0/*=20zone=20reset=20*=
/=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0NR_IO_TYPE,=0D=0A>=
=20>=20=C2=A0=7D;=0D=0A>=20>=20=C2=A0=0D=0A>=20>=20diff=20--git=20a/fs/f2fs=
/iostat.c=20b/fs/f2fs/iostat.c=0D=0A>=20>=20index=203d5bfb1ad585..f8703038e=
1d8=20100644=0D=0A>=20>=20---=20a/fs/f2fs/iostat.c=0D=0A>=20>=20+++=20b/fs/=
f2fs/iostat.c=0D=0A>=20>=20=40=40=20-80,6=20+80,7=20=40=40=20int=20__maybe_=
unused=20iostat_info_seq_show(struct=20seq_file=20*seq,=20void=20*offset)=
=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0seq_puts(seq,=20=22=
=5BOTHER=5D=5Cn=22);=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0IOSTAT_INFO_SHOW(=22fs=20discard=22,=20FS_DISCARD_IO);=0D=0A>=20>=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0IOSTAT_INFO_SHOW(=22fs=20flush=22,=
=20FS_FLUSH_IO);=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0IOSTAT_I=
NFO_SHOW(=22fs=20zone=20reset=22,=20FS_ZONE_RESET_IO);=0D=0A>=20>=20=C2=A0=
=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0return=200;=0D=0A>=
=20>=20=C2=A0=7D=0D=0A>=20>=20diff=20--git=20a/fs/f2fs/segment.c=20b/fs/f2f=
s/segment.c=0D=0A>=20>=20index=206db410f1bb8c..4802b05a795b=20100644=0D=0A>=
=20>=20---=20a/fs/f2fs/segment.c=0D=0A>=20>=20+++=20b/fs/f2fs/segment.c=0D=
=0A>=20>=20=40=40=20-1196,6=20+1196,45=20=40=40=20static=20void=20__init_di=
scard_policy(struct=20f2fs_sb_info=20*sbi,=0D=0A>=20>=20=C2=A0static=20void=
=20__update_discard_tree_range(struct=20f2fs_sb_info=20*sbi,=0D=0A>=20>=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
struct=20block_device=20*bdev,=20block_t=20lstart,=0D=0A>=20>=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0block_t=
=20start,=20block_t=20len);=0D=0A>=20>=20+=0D=0A>=20>=20+=23ifdef=20CONFIG_=
BLK_DEV_ZONED=0D=0A>=20>=20+static=20void=20__submit_zone_reset_cmd(struct=
=20f2fs_sb_info=20*sbi,=0D=0A>=20=0D=0A>=20Why=20can't=20we=20use=20__f2fs_=
issue_discard_zone()?=0D=0A=0D=0AIn=20my=20understanding,=20__f2fs_issue_di=
scard_zone=20is=20used=20to=20queue=20the=20zone=20reset=20command.=0D=0AWh=
ich=20point=20do=20you=20think=20is=20the=20issue?=0D=0A=0D=0A>=20=0D=0A>=
=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20struct=20discard_cmd=20*dc,=20blk_opf_t=20flag,=0D=0A>=20>=
=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20struct=20list_head=20*wait_list,=0D=0A>=20>=20+=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20unsigned=
=20int=20*issued)=0D=0A>=20>=20+=7B=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0struct=20discard_cmd_control=20*dcc=20=3D=20SM_I(sbi)->dcc_info=
;=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0struct=20block_device=
=20*bdev=20=3D=20dc->bdev;=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0struct=20bio=20*bio=20=3D=20bio_alloc(bdev,=200,=20REQ_OP_ZONE_RESET=20=
=7C=20flag,=20GFP_NOFS);=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
unsigned=20long=20flags;=0D=0A>=20>=20+=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0trace_f2fs_issue_reset_zone(bdev,=20dc->di.start);=0D=0A>=20=
>=20+=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0spin_lock_irqsave(&=
dc->lock,=20flags);=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0dc->s=
tate=20=3D=20D_SUBMIT;=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0dc=
->bio_ref++;=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0spin_unlock_=
irqrestore(&dc->lock,=20flags);=0D=0A>=20>=20+=0D=0A>=20>=20+=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0if=20(issued)=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0(*issued)++;=0D=0A>=20>=
=20+=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0atomic_inc(&dcc->que=
ued_discard);=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0dc->queued+=
+;=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0list_move_tail(&dc->li=
st,=20wait_list);=0D=0A>=20>=20+=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0/*=20sanity=20check=20on=20discard=20range=20*/=0D=0A>=20>=20+=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0__check_sit_bitmap(sbi,=20dc->di.lstart,=
=20dc->di.lstart=20+=20dc->di.len);=0D=0A>=20>=20+=0D=0A>=20>=20+=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0bio->bi_iter.bi_sector=20=3D=20SECTOR_FROM_BLOCK=
(dc->di.start);=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0bio->bi_p=
rivate=20=3D=20dc;=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0bio->b=
i_end_io=20=3D=20f2fs_submit_discard_endio;=0D=0A>=20>=20+=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0submit_bio(bio);=0D=0A>=20>=20+=0D=0A>=20>=20+=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0atomic_inc(&dcc->issued_discard);=0D=0A>=20>=
=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0f2fs_update_iostat(sbi,=20NULL,=20F=
S_ZONE_RESET_IO,=20dc->di.len=20*=20F2FS_BLKSIZE);=0D=0A>=20>=20+=7D=0D=0A>=
=20>=20+=23endif=0D=0A>=20>=20+=0D=0A>=20>=20=C2=A0/*=20this=20function=20i=
s=20copied=20from=20blkdev_issue_discard=20from=20block/blk-lib.c=20*/=0D=
=0A>=20>=20=C2=A0static=20int=20__submit_discard_cmd(struct=20f2fs_sb_info=
=20*sbi,=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0struct=20discard_policy=20*dpolicy,=0D=0A>=20>=20=
=40=40=20-1217,6=20+1256,13=20=40=40=20static=20int=20__submit_discard_cmd(=
struct=20f2fs_sb_info=20*sbi,=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0if=20(is_sbi_flag_set(sbi,=20SBI_NEED_FSCK))=0D=0A>=20>=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
return=200;=0D=0A>=20>=20=C2=A0=0D=0A>=20>=20+=23ifdef=20CONFIG_BLK_DEV_ZON=
ED=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(f2fs_sb_has_blkz=
oned(sbi)=20&&=20bdev_is_zoned(bdev))=20=7B=0D=0A>=20>=20+=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0__submit_zone_rese=
t_cmd(sbi,=20dc,=20flag,=20wait_list,=20issued);=0D=0A>=20>=20+=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0return=200;=0D=
=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=7D=0D=0A>=20>=20+=23endif=
=0D=0A>=20>=20+=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0trac=
e_f2fs_issue_discard(bdev,=20dc->di.start,=20dc->di.len);=0D=0A>=20>=20=C2=
=A0=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0lstart=20=3D=20d=
c->di.lstart;=0D=0A>=20>=20=40=40=20-1461,6=20+1507,19=20=40=40=20static=20=
void=20__update_discard_tree_range(struct=20f2fs_sb_info=20*sbi,=0D=0A>=20>=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=7D=0D=0A>=20>=20=C2=A0=7D=0D=
=0A>=20>=20=C2=A0=0D=0A>=20>=20+=23ifdef=20CONFIG_BLK_DEV_ZONED=0D=0A>=20>=
=20+static=20void=20__queue_zone_reset_cmd(struct=20f2fs_sb_info=20*sbi,=0D=
=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0struct=20block_device=20*bdev,=20block_t=20blkstart,=20block_t=20l=
blkstart,=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0block_t=20blklen)=0D=0A>=20>=20+=7B=0D=0A>=20>=20+=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0trace_f2fs_queue_reset_zone(bdev,=20blksta=
rt);=0D=0A>=20>=20+=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0mutex=
_lock(&SM_I(sbi)->dcc_info->cmd_lock);=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0__insert_discard_cmd(sbi,=20bdev,=20lblkstart,=20blkstart,=
=20blklen);=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0mutex_unlock(=
&SM_I(sbi)->dcc_info->cmd_lock);=0D=0A>=20>=20+=7D=0D=0A>=20>=20+=23endif=
=0D=0A>=20>=20+=0D=0A>=20>=20=C2=A0static=20void=20__queue_discard_cmd(stru=
ct=20f2fs_sb_info=20*sbi,=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0struct=20block_device=20*bdev,=20=
block_t=20blkstart,=20block_t=20blklen)=0D=0A>=20>=20=C2=A0=7B=0D=0A>=20>=
=20=40=40=20-1724,6=20+1783,19=20=40=40=20static=20void=20f2fs_wait_discard=
_bio(struct=20f2fs_sb_info=20*sbi,=20block_t=20blkaddr)=0D=0A>=20>=20=C2=A0=
=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0mutex_lock(&dcc->cm=
d_lock);=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0dc=20=3D=20=
__lookup_discard_cmd(sbi,=20blkaddr);=0D=0A>=20>=20+=23ifdef=20CONFIG_BLK_D=
EV_ZONED=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(dc=20&&=20=
f2fs_sb_has_blkzoned(sbi)=20&&=20bdev_is_zoned(dc->bdev))=20=7B=0D=0A>=20>=
=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0/*=20force=20submit=20zone=20reset=20*/=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(dc->state=20=3D=
=3D=20D_PREP)=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0__submit_zon=
e_reset_cmd(sbi,=20dc,=20REQ_SYNC,=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0&dcc->wait_list,=20NULL);=0D=0A>=
=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0dc->ref++;=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0mutex_unlock(&dcc->cmd_lock);=0D=0A>=20>=20+=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0/*=
=20wait=20zone=20reset=20*/=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0__wait_one_discard_bio(sbi,=20dc);=
=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0return;=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=7D=
=0D=0A>=20>=20+=23endif=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0if=20(dc)=20=7B=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(dc->state=20=3D=3D=20D_PREP)=
=20=7B=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0__punch_discard=
_cmd(sbi,=20dc,=20blkaddr);=0D=0A>=20>=20=40=40=20-1876,9=20+1948,15=20=40=
=40=20static=20int=20__f2fs_issue_discard_zone(struct=20f2fs_sb_info=20*sbi=
,=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20blkstart,=20blklen);=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0return=20-EIO;=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=7D=0D=0A>=20>=20-=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0trace_f2f=
s_issue_reset_zone(bdev,=20blkstart);=0D=0A>=20>=20-=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0return=20blkdev_zone_mgm=
t(bdev,=20REQ_OP_ZONE_RESET,=0D=0A>=20>=20-=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
sector,=20nr_sects,=20GFP_NOFS);=0D=0A>=20>=20+=0D=0A>=20>=20+=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(unlikely(=
is_sbi_flag_set(sbi,=20SBI_POR_DOING)))=20=7B=0D=0A>=20>=20+=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0trace_f2fs_issue_reset_zone(bdev,=20blkstart);=0D=0A>=20>=
=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0return=20blkdev_zone_mgmt(bdev,=20RE=
Q_OP_ZONE_RESET,=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0sector,=20nr_sects,=20GFP_NOFS);=0D=0A>=20>=20+=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=7D=0D=
=0A>=20>=20+=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0__queue_zone_reset_cmd(sbi,=20bdev,=20blkstart,=20l=
blkstart,=20blklen);=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0return=200;=0D=0A>=20>=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=7D=0D=0A>=20>=20=C2=A0=0D=0A>=20>=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0/*=20For=20conventional=20zones,=20use=20r=
egular=20discard=20if=20supported=20*/=0D=0A>=20>=20diff=20--git=20a/includ=
e/trace/events/f2fs.h=20b/include/trace/events/f2fs.h=0D=0A>=20>=20index=20=
99cbc5949e3c..793f82cc1515=20100644=0D=0A>=20>=20---=20a/include/trace/even=
ts/f2fs.h=0D=0A>=20>=20+++=20b/include/trace/events/f2fs.h=0D=0A>=20>=20=40=
=40=20-1512,7=20+1512,7=20=40=40=20DEFINE_EVENT(f2fs_discard,=20f2fs_remove=
_discard,=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0TP_ARGS(de=
v,=20blkstart,=20blklen)=0D=0A>=20>=20=C2=A0);=0D=0A>=20>=20=C2=A0=0D=0A>=
=20>=20-TRACE_EVENT(f2fs_issue_reset_zone,=0D=0A>=20>=20+DECLARE_EVENT_CLAS=
S(f2fs_reset_zone,=0D=0A>=20>=20=C2=A0=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0TP_PROTO(struct=20block_device=20*dev,=20block_t=20blk=
start),=0D=0A>=20>=20=C2=A0=0D=0A>=20>=20=40=40=20-1528,11=20+1528,25=20=40=
=40=20TRACE_EVENT(f2fs_issue_reset_zone,=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0__entry->blkstart=
=20=3D=20blkstart;=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0)=
,=0D=0A>=20>=20=C2=A0=0D=0A>=20>=20-=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0TP_=
printk(=22dev=20=3D=20(%d,%d),=20reset=20zone=20at=20block=20=3D=200x%llx=
=22,=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0TP_printk(=22dev=20=
=3D=20(%d,%d),=20zone=20at=20block=20=3D=200x%llx=22,=0D=0A>=20>=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0sho=
w_dev(__entry->dev),=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0(unsigned=20long=20long)__entry->blk=
start)=0D=0A>=20>=20=C2=A0);=0D=0A>=20>=20=C2=A0=0D=0A>=20>=20+DEFINE_EVENT=
(f2fs_reset_zone,=20f2fs_queue_reset_zone,=0D=0A>=20>=20+=0D=0A>=20>=20+=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0TP_PROTO(struct=20block_device=20*dev,=20b=
lock_t=20blkstart),=0D=0A>=20>=20+=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0TP_ARGS(dev,=20blkstart)=0D=0A>=20>=20+);=0D=0A>=20>=20+=0D=0A>=
=20>=20+DEFINE_EVENT(f2fs_reset_zone,=20f2fs_issue_reset_zone,=0D=0A>=20>=
=20+=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0TP_PROTO(struct=20bl=
ock_device=20*dev,=20block_t=20blkstart),=0D=0A>=20>=20+=0D=0A>=20>=20+=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0TP_ARGS(dev,=20blkstart)=0D=0A>=20>=20+);=
=0D=0A>=20>=20+=0D=0A>=20>=20=C2=A0TRACE_EVENT(f2fs_issue_flush,=0D=0A>=20>=
=20=C2=A0=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0TP_PROTO(s=
truct=20block_device=20*dev,=20unsigned=20int=20nobarrier,=0D=0A>=20>=20=40=
=40=20-1979,6=20+1993,7=20=40=40=20TRACE_EVENT(f2fs_iostat,=0D=0A>=20>=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0__field(unsigned=20long=20long,=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0fs_nr=
io)=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0__field(unsigned=20long=20long,=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0fs_mrio)=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0__field(unsigned=20long=20long,=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0fs_discard)=0D=0A>=20>=20+=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0__field(unsigne=
d=20long=20long,=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0fs_reset_zone)=0D=0A>=
=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0),=0D=0A>=20>=20=C2=A0=0D=
=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0TP_fast_assign(=0D=0A>=
=20>=20=40=40=20-2010,12=20+2025,14=20=40=40=20TRACE_EVENT(f2fs_iostat,=0D=
=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0__entry->fs_nrio=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=3D=20io=
stat=5BFS_NODE_READ_IO=5D;=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0__entry->fs_mrio=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=3D=20iostat=5BFS_META_READ_IO=5D;=0D=0A>=20>=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
__entry->fs_discard=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=3D=20iostat=5BFS_DI=
SCARD_IO=5D;=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0__entry->fs_reset_zone=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=3D=20iostat=5BFS_ZONE_RESET_IO=5D;=0D=0A>=20>=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0),=0D=0A>=20>=20=C2=A0=0D=0A>=20>=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0TP_printk(=22dev=20=3D=20(%d,%d),=20=22=0D=0A=
>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=22app=20=5Bwrite=3D%llu=20(direct=3D%llu,=20buffered=3D%llu),=
=20mapped=3D%llu,=20=22=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=22compr(buffered=3D%llu,=20mappe=
d=3D%llu)=5D,=20=22=0D=0A>=20>=20-=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=22fs=20=5Bdata=3D%llu,=20cdata=3D%llu,=20=
node=3D%llu,=20meta=3D%llu,=20discard=3D%llu=5D,=20=22=0D=0A>=20>=20+=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=22fs=20=
=5Bdata=3D%llu,=20cdata=3D%llu,=20node=3D%llu,=20meta=3D%llu,=20discard=3D%=
llu,=20=22=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=22reset_zone=3D%llu=5D,=20=22=0D=0A>=20>=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=22=
gc=20=5Bdata=3D%llu,=20node=3D%llu=5D,=20=22=0D=0A>=20>=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=22cp=20=5Bd=
ata=3D%llu,=20node=3D%llu,=20meta=3D%llu=5D,=20=22=0D=0A>=20>=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=22app=
=20=5Bread=3D%llu=20(direct=3D%llu,=20buffered=3D%llu),=20mapped=3D%llu=5D,=
=20=22=0D=0A>=20>=20=40=40=20-2026,6=20+2043,7=20=40=40=20TRACE_EVENT(f2fs_=
iostat,=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0__entry->app_bio,=20__entry->app_mio,=20__entry->ap=
p_bcdio,=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0__entry->app_mcdio,=20__entry->fs_dio,=20__entry=
->fs_cdio,=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0__entry->fs_nio,=20__entry->fs_mio,=20__entry->f=
s_discard,=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0__entry->fs_reset_zone,=0D=0A>=20>=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0__entry->=
fs_gc_dio,=20__entry->fs_gc_nio,=20__entry->fs_cp_dio,=0D=0A>=20>=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0__e=
ntry->fs_cp_nio,=20__entry->fs_cp_mio,=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0__entry->app_rio,=
=20__entry->app_drio,=20__entry->app_brio,=0D=0A>=20>=20--=20=0D=0A>=20>=20=
2.25.1
