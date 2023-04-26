Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732496EEEC6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 09:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239743AbjDZHDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 03:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239729AbjDZHCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 03:02:47 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5FF3AAD
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 00:02:08 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230426070203epoutp016c63360873c95e28f69fea001b49dd3a~ZagkmVlcG0723407234epoutp017
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 07:02:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230426070203epoutp016c63360873c95e28f69fea001b49dd3a~ZagkmVlcG0723407234epoutp017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1682492523;
        bh=fIKyftIc4mUwSJY/35yCx7Hx+7CYW8/CvaQJnUCzxMU=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=gsyigh9616lT0EznuLNMYhaltxTHJqG5ON+wp9tnVj16ov+JB7ognCug5wzhx+MF2
         lbo5Bc26+y3bIGlpoHrZQFZnG32d3Kst6UkjcqxYX96QmRcqop4iHwDX6o+60xCF1b
         HtxIv7e9LcwKCZaDWbCCyZrsggkMjPhXGkEv0HCQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230426070202epcas2p46d3164c5057df817b4b8e993f59c6f17~ZagjzYf2h2807828078epcas2p4k;
        Wed, 26 Apr 2023 07:02:02 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.69]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Q5qYP6Fxnz4x9Q7; Wed, 26 Apr
        2023 07:02:01 +0000 (GMT)
X-AuditID: b6c32a48-475ff70000005998-4f-6448cc697d3b
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        54.58.22936.96CC8446; Wed, 26 Apr 2023 16:02:01 +0900 (KST)
Mime-Version: 1.0
Subject: RE:(2) [PATCH v2] f2fs: add async reset zone command support
Reply-To: daejun7.park@samsung.com
Sender: Daejun Park <daejun7.park@samsung.com>
From:   Daejun Park <daejun7.park@samsung.com>
To:     Chao Yu <chao@kernel.org>, Daejun Park <daejun7.park@samsung.com>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>
CC:     Seokhwan Kim <sukka.kim@samsung.com>,
        Yonggil Song <yonggil.song@samsung.com>,
        beomsu kim <beomsu7.kim@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <e5a26c5c-65f6-0c96-0915-cf751f53b7fc@kernel.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230426070101epcms2p7dd8faf06f26216c6e99b1aa0e1dbcbbf@epcms2p7>
Date:   Wed, 26 Apr 2023 16:01:01 +0900
X-CMS-MailID: 20230426070101epcms2p7dd8faf06f26216c6e99b1aa0e1dbcbbf
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFJsWRmVeSWpSXmKPExsWy7bCmqW7mGY8Ug+v/9SwuzPvIbHF66lkm
        i5eHNC1WPQi3eLJ+FrPFpUXuFpd3zWGzOLL+LIvF4uVqFvs6HjBZrOqYy2gx9fwRJgcej5Z9
        t9g9Nq3qZPPYveAzk0ffllWMHp83yQWwRmXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjq
        GlpamCsp5CXmptoqufgE6Lpl5gDdpqRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkp
        MC/QK07MLS7NS9fLSy2xMjQwMDIFKkzIzpg2rZ+tYMFcxorvj0MbGPfMYOxi5OSQEDCRePFp
        PWsXIxeHkMAORonzvxYzdTFycPAKCEr83SEMYgoLuEosnaIMUi4koCSx/uIsdhBbWEBP4tbD
        NWBj2AR0JKafuM8OMkZEYDOzxJNFD8DGMAtUSnw+5wCxildiRvtTFghbWmL78q1gvZwCdhIT
        Jr9mhYhrSPxY1ssMYYtK3Fz9lh3Gfn9sPtTJIhKt985C1QhKPPi5GyouKXF77iao+nyJ/1eW
        Q9k1EtsOzIOy9SWudWwEu4FXwFdiTkM32F4WAVWJ9Sf/Qt3gIrFlK4TNLKAtsWzha2aIVzQl
        1u/SBzElBJQljtxigajgk+g4/Jcd5sOGjb+xsnfMe8IEYatJrPu5nmkCo/IsRDDPQrJrFsKu
        BYzMqxjFUguKc9NTi40KTOBRm5yfu4kRnEi1PHYwzn77Qe8QIxMH4yFGCQ5mJRFe3kr3FCHe
        lMTKqtSi/Pii0pzU4kOMpkBfTmSWEk3OB6byvJJ4QxNLAxMzM0NzI1MDcyVx3o8dyilCAumJ
        JanZqakFqUUwfUwcnFINTMdEgm3/HWg+Hpzvw11yx8dunukLM64lldN8yvr0EpYqV82+JhR/
        NLyz97X0nfmNLwpVTjKyK1rYnitNZ2SwYVtguoZjS8niqxJzJ87iutziGyhnp3m85/fJ0EXs
        lyZbHjpdfSUtIORy3fGPEwoiPmlPjCueeG/fsVhhvyQ7xykJM5Ni/WLDF+zZpLxty453O/en
        c9X5fOW5mfx/wbWHb+fqbL6+dKeDbrn877Nniqb8rt2jy3lzn/Bvk9SNh+X9C4Ln3osOK3Ro
        ztlUGhv2Sax+59R/Xa77fdi+bHBuyDDpXGX7P2NH8cs5/16xMp4KlWEL/PtV4rGVI6eujOjx
        aVLOqfuSp9k/yTSe7L3yiBJLcUaioRZzUXEiALkLPy0tBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230425081018epcms2p8fefa94810f0b341d2cbd70ba587e9e8c
References: <e5a26c5c-65f6-0c96-0915-cf751f53b7fc@kernel.org>
        <20230425081018epcms2p8fefa94810f0b341d2cbd70ba587e9e8c@epcms2p8>
        <CGME20230425081018epcms2p8fefa94810f0b341d2cbd70ba587e9e8c@epcms2p7>
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

Thank you for your review. I have responded in the comments below.

> On 2023/4/25 16:10, Daejun Park wrote:
> > Changelog:
> >=20
> > v1 -> v2
> > Changed to apply the optional async reset write pointer by default.
> >=20
> >=20
> > This patch enables submit reset zone command asynchornously. It helps
> > decrease average latency of write IOs in high utilization scenario by
> > faster checkpointing.
> >=20
> > Signed-off-by: Daejun Park <daejun7.park=40samsung.com>
> > ---
> > =C2=A0=20fs/f2fs/segment.c=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=7C=2095=20++++++++++++++++++++++++++++++++++---=0D=0A>=20>=20=C2=A0=20i=
nclude/trace/events/f2fs.h=20=7C=2018=20++++++-=0D=0A>=20>=20=C2=A0=202=20f=
iles=20changed,=20105=20insertions(+),=208=20deletions(-)=0D=0A>=20>=20=0D=
=0A>=20>=20diff=20--git=20a/fs/f2fs/segment.c=20b/fs/f2fs/segment.c=0D=0A>=
=20>=20index=2082430f80c5da..27074a6eaf20=20100644=0D=0A>=20>=20---=20a/fs/=
f2fs/segment.c=0D=0A>=20>=20+++=20b/fs/f2fs/segment.c=0D=0A>=20>=20=40=40=
=20-1195,6=20+1195,46=20=40=40=20static=20void=20__init_discard_policy(stru=
ct=20f2fs_sb_info=20*sbi,=0D=0A>=20>=20=C2=A0=20static=20void=20__update_di=
scard_tree_range(struct=20f2fs_sb_info=20*sbi,=0D=0A>=20>=20=C2=A0=20=C2=A0=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0struct=20=
block_device=20*bdev,=20block_t=20lstart,=0D=0A>=20>=20=C2=A0=20=C2=A0=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0block_t=20st=
art,=20block_t=20len);=0D=0A>=20>=20+=0D=0A>=20>=20+=23ifdef=20CONFIG_BLK_D=
EV_ZONED=0D=0A>=20>=20+static=20int=20__submit_zone_reset_cmd(struct=20f2fs=
_sb_info=20*sbi,=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20struct=20discard_cmd=20*dc,=20blk_op=
f_t=20flag,=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20struct=20list_head=20*wait_list,=0D=0A>=20=
>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20unsigned=20int=20*issued)=0D=0A>=20>=20+=7B=0D=0A>=20>=20+=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0struct=20discard_cmd_control=20*dcc=20=3D=
=20SM_I(sbi)->dcc_info;=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0s=
truct=20block_device=20*bdev=20=3D=20dc->bdev;=0D=0A>=20>=20+=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0struct=20bio=20*bio=20=3D=20bio_alloc(bdev,=200,=20=
REQ_OP_ZONE_RESET=20=7C=20flag,=20GFP_NOFS);=0D=0A>=20>=20+=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0unsigned=20long=20flags;=0D=0A>=20>=20+=0D=0A>=20>=20+=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0trace_f2fs_issue_reset_zone(bdev,=20SEC=
TOR_FROM_BLOCK(dc->di.start));=0D=0A>=20=0D=0A>=20trace_f2fs_issue_reset_zo=
ne(bdev,=20dc->di.start);=20?=0D=0A=0D=0AI=20will=20change=20it.=20=0D=0A=
=0D=0A>=20=0D=0A>=20>=20+=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0spin_lock_irqsave(&dc->lock,=20flags);=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0dc->state=20=3D=20D_SUBMIT;=0D=0A>=20>=20+=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0dc->bio_ref++;=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0spin_unlock_irqrestore(&dc->lock,=20flags);=0D=0A>=20>=20+=0D=
=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(issued)=0D=0A>=20>=20=
+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0(*=
issued)++;=0D=0A>=20>=20+=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0atomic_inc(&dcc->queued_discard);=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0dc->queued++;=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0list_move_tail(&dc->list,=20wait_list);=0D=0A>=20>=20+=0D=0A>=20>=20+=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0/*=20sanity=20check=20on=20discard=20range=
=20*/=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0__check_sit_bitmap(=
sbi,=20dc->di.lstart,=20dc->di.lstart=20+=20dc->di.len);=0D=0A>=20>=20+=0D=
=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0bio->bi_iter.bi_sector=20=
=3D=20SECTOR_FROM_BLOCK(dc->di.start);=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0bio->bi_private=20=3D=20dc;=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0bio->bi_end_io=20=3D=20f2fs_submit_discard_endio;=0D=0A>=
=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0submit_bio(bio);=0D=0A>=20>=20+=
=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0atomic_inc(&dcc->issued_=
discard);=0D=0A>=20>=20+=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
return=200;=0D=0A>=20=0D=0A>=20Unneeded=20return=20value?=0D=0A=0D=0AI=20wi=
ll=20change=20return=20type=20of=20this=20function=20as=20void.=0D=0A=0D=0A=
>=20>=20+=7D=0D=0A>=20>=20+=23endif=0D=0A>=20>=20+=0D=0A>=20>=20=C2=A0=20/*=
=20this=20function=20is=20copied=20from=20blkdev_issue_discard=20from=20blo=
ck/blk-lib.c=20*/=0D=0A>=20>=20=C2=A0=20static=20int=20__submit_discard_cmd=
(struct=20f2fs_sb_info=20*sbi,=0D=0A>=20>=20=C2=A0=20=C2=A0=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0struct=20discard_policy=
=20*dpolicy,=0D=0A>=20>=20=40=40=20-1216,6=20+1256,11=20=40=40=20static=20i=
nt=20__submit_discard_cmd(struct=20f2fs_sb_info=20*sbi,=0D=0A>=20>=20=C2=A0=
=20=C2=A0=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(is_sbi_flag_set(sbi,=20SBI_=
NEED_FSCK))=0D=0A>=20>=20=C2=A0=20=C2=A0=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0return=200;=0D=0A>=20>=20=C2=A0=20=0D=
=0A>=20>=20+=23ifdef=20CONFIG_BLK_DEV_ZONED=0D=0A>=20>=20+=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0if=20(f2fs_sb_has_blkzoned(sbi)=20&&=20bdev_is_zoned(b=
dev))=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0return=20__submit_zone_reset_cmd(sbi,=20dc,=20flag,=20wai=
t_list,=20issued);=0D=0A>=20>=20+=23endif=0D=0A>=20>=20+=0D=0A>=20>=20=C2=
=A0=20=C2=A0=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0trace_f2fs_issue_discard(bdev,=
=20dc->di.start,=20dc->di.len);=0D=0A>=20>=20=C2=A0=20=0D=0A>=20>=20=C2=A0=
=20=C2=A0=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0lstart=20=3D=20dc->di.lstart;=0D=
=0A>=20>=20=40=40=20-1460,21=20+1505,42=20=40=40=20static=20void=20__update=
_discard_tree_range(struct=20f2fs_sb_info=20*sbi,=0D=0A>=20>=20=C2=A0=20=C2=
=A0=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=7D=0D=0A>=20>=20=C2=A0=20=7D=0D=0A>=20=
>=20=C2=A0=20=0D=0A>=20>=20+=23ifdef=20CONFIG_BLK_DEV_ZONED=0D=0A>=20>=20+s=
tatic=20void=20__queue_zone_reset_cmd(struct=20f2fs_sb_info=20*sbi,=0D=0A>=
=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0struct=20block_device=20*bdev,=20block_t=20blkstart,=20block_t=20blkl=
en)=0D=0A>=20=0D=0A>=20block_t=20lblkstart,=0D=0A>=20=0D=0A>=20>=20+=7B=0D=
=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0block_t=20lblkstart=20=3D=
=20blkstart;=0D=0A>=20=0D=0A>=20block_t=20blkstart=20=3D=20lblkstart;=0D=0A=
=0D=0AI=20refactored=20this=20function=20as=20follows.=0D=0A=0D=0Astatic=20=
void=20__queue_zone_reset_cmd(struct=20f2fs_sb_info=20*sbi,=0D=0A=09=09stru=
ct=20block_device=20*bdev,=20block_t=20blkstart,=20block_t=20lblkstart,=0D=
=0A=09=09block_t=20blklen)=0D=0A=7B=0D=0A=09trace_f2fs_queue_reset_zone(bde=
v,=20blkstart);=0D=0A=0D=0A=09mutex_lock(&SM_I(sbi)->dcc_info->cmd_lock);=
=0D=0A=09__insert_discard_cmd(sbi,=20bdev,=20lblkstart,=20blkstart,=20blkle=
n);=0D=0A=09mutex_unlock(&SM_I(sbi)->dcc_info->cmd_lock);=0D=0A=7D=0D=0A=0D=
=0A>=20=0D=0A>=20>=20+=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=
=20(f2fs_is_multi_device(sbi))=20=7B=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0int=20devi=20=3D=20f2fs_tar=
get_device_index(sbi,=20blkstart);=0D=0A>=20>=20+=0D=0A>=20>=20+=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0blkstart=20-=
=3D=20FDEV(devi).start_blk;=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=7D=0D=0A>=20>=20+=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0tra=
ce_f2fs_queue_reset_zone(bdev,=20blkstart);=0D=0A>=20>=20+=0D=0A>=20>=20+=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0mutex_lock(&SM_I(sbi)->dcc_info->cmd_lo=
ck);=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0__insert_discard_cmd=
(sbi,=20bdev,=20lblkstart,=20blkstart,=20blklen);=0D=0A>=20>=20+=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0mutex_unlock(&SM_I(sbi)->dcc_info->cmd_lock);=0D=
=0A>=20>=20+=7D=0D=0A>=20>=20+=23endif=0D=0A>=20>=20+=0D=0A>=20>=20=C2=A0=
=20static=20void=20__queue_discard_cmd(struct=20f2fs_sb_info=20*sbi,=0D=0A>=
=20>=20=C2=A0=20=C2=A0=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0struct=20block_device=20*bdev,=20block_t=20blkstart,=20bl=
ock_t=20blklen)=0D=0A>=20>=20=C2=A0=20=7B=0D=0A>=20>=20=C2=A0=20=C2=A0=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0block_t=20lblkstart=20=3D=20blkstart;=0D=0A>=
=20>=20=C2=A0=20=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0trace_f2=
fs_queue_discard(bdev,=20blkstart,=20blklen);=0D=0A>=20=0D=0A>=20If=20devic=
e=20doesn't=20support=20discard,=20it's=20better=20not=20show=20above=20tra=
cepoint?=0D=0A=0D=0AThis=20issue=20was=20caused=20by=20a=20mistake=20during=
=20the=20merge=20process.=20I=20have=20fixed=20it.=0D=0A=0D=0A>=20>=20+=0D=
=0A>=20>=20=C2=A0=20=C2=A0=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(=21f2fs_bd=
ev_support_discard(bdev))=0D=0A>=20>=20=C2=A0=20=C2=A0=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0return;=0D=0A>=20>=20=C2=A0=
=20=0D=0A>=20>=20-=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0trace_f2fs_queue_disc=
ard(bdev,=20blkstart,=20blklen);=0D=0A>=20>=20-=0D=0A>=20>=20=C2=A0=20=C2=
=A0=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(f2fs_is_multi_device(sbi))=20=7B=
=0D=0A>=20>=20=C2=A0=20=C2=A0=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0int=20devi=20=3D=20f2fs_target_device_index(sbi,=20=
blkstart);=0D=0A>=20>=20=C2=A0=20=0D=0A>=20>=20=C2=A0=20=C2=A0=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0blkstart=20-=3D=20=
FDEV(devi).start_blk;=0D=0A>=20>=20=C2=A0=20=C2=A0=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=7D=0D=0A>=20>=20+=0D=0A>=20>=20=C2=A0=20=C2=A0=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0mutex_lock(&SM_I(sbi)->dcc_info->cmd_lock);=0D=0A>=20>=20=C2=
=A0=20=C2=A0=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0__update_discard_tree_range(sb=
i,=20bdev,=20lblkstart,=20blkstart,=20blklen);=0D=0A>=20>=20=C2=A0=20=C2=A0=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0mutex_unlock(&SM_I(sbi)->dcc_info->cmd_loc=
k);=0D=0A>=20>=20=40=40=20-1725,7=20+1791,18=20=40=40=20static=20void=20f2f=
s_wait_discard_bio(struct=20f2fs_sb_info=20*sbi,=20block_t=20blkaddr)=0D=0A=
>=20>=20=C2=A0=20=C2=A0=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0dc=20=3D=20__lookup=
_discard_cmd(sbi,=20blkaddr);=0D=0A>=20>=20=C2=A0=20=C2=A0=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0if=20(dc)=20=7B=0D=0A>=20>=20=C2=A0=20=C2=A0=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(dc->state=20=
=3D=3D=20D_PREP)=20=7B=0D=0A>=20>=20-=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0__p=
unch_discard_cmd(sbi,=20dc,=20blkaddr);=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0if=20(f2fs_sb_has_blkzoned(sbi)=20&&=0D=0A>=20>=20+=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0bdev_is_zoned(dc->bdev))=20=7B=0D=0A=
>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0struct=20discard_policy=20dpolicy;=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0/*=20force=20submit=20zone=
=20reset=20*/=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0__init_discard_policy(sbi,=20&dpolicy,=0D=0A>=20>=
=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0DPOLICY_FORCE,=201);=0D=0A>=20>=20+=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0__submit_discard_cmd(=
sbi,=20&dpolicy,=20dc,=20NULL);=0D=0A>=20=0D=0A>=20Can=20we=20call=20__subm=
it_zone_reset_cmd()=20directly?=0D=0A=0D=0ASure.=20I=20refactored=20as=20fo=
llows.=0D=0A=0D=0A=09if=20(dc)=20=7B=0D=0A=09=09if=20(f2fs_sb_has_blkzoned(=
sbi)=20&&=20bdev_is_zoned(dc->bdev))=20=7B=0D=0A=09=09=09if=20(dc->state=20=
=3D=3D=20D_PREP)=0D=0A=09=09=09=09__submit_zone_reset_cmd(sbi,=20dc,=20REQ_=
SYNC,=0D=0A=09=09=09=09=09=09=09&dcc->wait_list,=20NULL);=0D=0A=09=09=09dc-=
>ref++;=0D=0A=09=09=09need_wait=20=3D=20true;=0D=0A=09=09=7D=20else=20=7B=
=0D=0A=09=09=09if=20(dc->state=20=3D=3D=20D_PREP)=20=7B=0D=0A=09=09=09=09__=
punch_discard_cmd(sbi,=20dc,=20blkaddr);=0D=0A=09=09=09=7D=20else=20=7B=0D=
=0A=09=09=09=09dc->ref++;=0D=0A=09=09=09=09need_wait=20=3D=20true;=0D=0A=09=
=09=09=7D=0D=0A=09=09=7D=0D=0A=09=7D=0D=0A=0D=0AThanks,=0D=0A=0D=0A>=20=0D=
=0A>=20Thanks,=0D=0A>=20=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0dc->ref++;=0D=0A>=20>=20+=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0need_wait=20=3D=20tru=
e;=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=7D=20else=20=7B=0D=0A>=
=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0__punch_discard_cmd(sbi,=20dc,=20blkaddr);=0D=0A>=20>=20+=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=7D=0D=0A>=20>=20=C2=A0=20=C2=A0=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=7D=20else=20=7B=0D=0A>=20>=20=
=C2=A0=20=C2=A0=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0dc->ref++;=0D=0A>=20>=20=C2=A0=
=20=C2=A0=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0need_wait=20=3D=20true;=0D=0A>=20>=
=20=40=40=20-1875,9=20+1952,15=20=40=40=20static=20int=20__f2fs_issue_disca=
rd_zone(struct=20f2fs_sb_info=20*sbi,=0D=0A>=20>=20=C2=A0=20=C2=A0=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20blkstart,=20blk=
len);=0D=0A>=20>=20=C2=A0=20=C2=A0=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0return=20=
-EIO;=0D=0A>=20>=20=C2=A0=20=C2=A0=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=7D=0D=0A>=20>=20-=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0trace_f2fs_issue_reset_zone(bd=
ev,=20blkstart);=0D=0A>=20>=20-=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0return=20blkdev_zone_mgmt(bdev,=20REQ_OP_ZONE=
_RESET,=0D=0A>=20>=20-=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0sector,=20nr_sects,=
=20GFP_NOFS);=0D=0A>=20>=20+=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(unlikely(=21is_sbi_flag_set=
(sbi,=20SBI_POR_DOING)))=20=7B=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0trace_f2fs_issue_reset_zone(bdev,=20blkstart);=0D=0A>=20>=20+=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0return=20blkdev_zone_mgmt(bdev,=20REQ_OP_ZONE_RESET=
,=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0sector,=20nr_sects,=20GFP_NOFS);=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=7D=0D=0A>=20>=20+=0D=
=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0__queue_zone_reset_cmd(sbi,=20bdev,=20lblkstart,=20blklen);=0D=0A>=
=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0return=200;=0D=0A>=20>=20=C2=A0=20=C2=A0=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=7D=0D=0A>=20>=20=C2=A0=20=0D=0A>=20>=20=C2=A0=20=C2=A0=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0/*=20For=20conventional=20zones,=20use=20regular=20dis=
card=20if=20supported=20*/=0D=0A>=20>=20diff=20--git=20a/include/trace/even=
ts/f2fs.h=20b/include/trace/events/f2fs.h=0D=0A>=20>=20index=2099cbc5949e3c=
..ee1477de8324=20100644=0D=0A>=20>=20---=20a/include/trace/events/f2fs.h=0D=
=0A>=20>=20+++=20b/include/trace/events/f2fs.h=0D=0A>=20>=20=40=40=20-1512,=
7=20+1512,7=20=40=40=20DEFINE_EVENT(f2fs_discard,=20f2fs_remove_discard,=0D=
=0A>=20>=20=C2=A0=20=C2=A0=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0TP_ARGS(dev,=20b=
lkstart,=20blklen)=0D=0A>=20>=20=C2=A0=20);=0D=0A>=20>=20=C2=A0=20=0D=0A>=
=20>=20-TRACE_EVENT(f2fs_issue_reset_zone,=0D=0A>=20>=20+DECLARE_EVENT_CLAS=
S(f2fs_reset_zone,=0D=0A>=20>=20=C2=A0=20=0D=0A>=20>=20=C2=A0=20=C2=A0=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0TP_PROTO(struct=20block_device=20*dev,=20bloc=
k_t=20blkstart),=0D=0A>=20>=20=C2=A0=20=0D=0A>=20>=20=40=40=20-1528,11=20+1=
528,25=20=40=40=20TRACE_EVENT(f2fs_issue_reset_zone,=0D=0A>=20>=20=C2=A0=20=
=C2=A0=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
__entry->blkstart=20=3D=20blkstart;=0D=0A>=20>=20=C2=A0=20=C2=A0=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0),=0D=0A>=20>=20=C2=A0=20=0D=0A>=20>=20-=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0TP_printk(=22dev=20=3D=20(%d,%d),=20reset=20zone=
=20at=20block=20=3D=200x%llx=22,=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0TP_printk(=22dev=20=3D=20(%d,%d),=20zone=20at=20block=20=3D=200x%l=
lx=22,=0D=0A>=20>=20=C2=A0=20=C2=A0=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0show_dev(__entry->dev),=0D=0A>=20>=20=C2=A0=
=20=C2=A0=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0(unsigned=20long=20long)__entry->blkstart)=0D=0A>=20>=20=C2=A0=20);=0D=
=0A>=20>=20=C2=A0=20=0D=0A>=20>=20+DEFINE_EVENT(f2fs_reset_zone,=20f2fs_que=
ue_reset_zone,=0D=0A>=20>=20+=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0TP_PROTO(struct=20block_device=20*dev,=20block_t=20blkstart),=0D=0A>=
=20>=20+=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0TP_ARGS(dev,=20b=
lkstart)=0D=0A>=20>=20+);=0D=0A>=20>=20+=0D=0A>=20>=20+DEFINE_EVENT(f2fs_re=
set_zone,=20f2fs_issue_reset_zone,=0D=0A>=20>=20+=0D=0A>=20>=20+=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0TP_PROTO(struct=20block_device=20*dev,=20block_t=
=20blkstart),=0D=0A>=20>=20+=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0TP_ARGS(dev,=20blkstart)=0D=0A>=20>=20+);=0D=0A>=20>=20+=0D=0A>=20>=
=20=C2=A0=20TRACE_EVENT(f2fs_issue_flush,=0D=0A>=20>=20=C2=A0=20=0D=0A>=20>=
=20=C2=A0=20=C2=A0=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0TP_PROTO(struct=20block_=
device=20*dev,=20unsigned=20int=20nobarrier,
