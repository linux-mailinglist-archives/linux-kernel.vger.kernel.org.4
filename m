Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01AD6F62CE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 04:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjEDCJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 22:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjEDCJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 22:09:19 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B6B135
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 19:09:16 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230504020912epoutp026f651c79bbd4de995269518c63e11502~bzrKVebeJ2904229042epoutp020
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 02:09:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230504020912epoutp026f651c79bbd4de995269518c63e11502~bzrKVebeJ2904229042epoutp020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683166152;
        bh=ldq7GVI/B8Lcs7yFVEBDLCKixZga1LX/ZvWn2gAjL4w=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=fMkJx5uNWeKQMl9dVMs/lXlwBFeUz+nZioN6yVfERW0R7kZJrDuBzDLYteDX4PWXu
         dqtWbnOdgvAY/sxuPWZQl4PoY3c5vh9J9DkDo1pBHmRuhz9HNsK5T2PB5f6kCISiwB
         r9ov1wU0OVrcMEJtQpW8QoTvT+zZ6ghi19CQaR90=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230504020911epcas2p2cc8f03fc11f0d5ce5ba9dfab2165ea59~bzrKF6EyH0750707507epcas2p21;
        Thu,  4 May 2023 02:09:11 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.98]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4QBcgq2KlQz4x9Q3; Thu,  4 May
        2023 02:09:11 +0000 (GMT)
X-AuditID: b6c32a46-8b7ff7000001438d-6f-645313c7d2cb
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C9.14.17293.7C313546; Thu,  4 May 2023 11:09:11 +0900 (KST)
Mime-Version: 1.0
Subject: RE:(2) [PATCH v4] f2fs: add async reset zone command support
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
In-Reply-To: <6596335b-2448-20f7-30ea-42ba40f1af72@kernel.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230504020810epcms2p2511cc27f9824fee69563e2be99284f78@epcms2p2>
Date:   Thu, 04 May 2023 11:08:10 +0900
X-CMS-MailID: 20230504020810epcms2p2511cc27f9824fee69563e2be99284f78
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDJsWRmVeSWpSXmKPExsWy7bCmhe5x4eAUg8NTuCwuzPvIbHF66lkm
        i5eHNC1WPQi3eLJ+FrPFpUXuFpd3zWGzOLL+LIvF4uVqFvs6HjBZrOqYy2gx9fwRJgcej5Z9
        t9g9Nq3qZPPYveAzk0ffllWMHp83yQWwRmXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjq
        GlpamCsp5CXmptoqufgE6Lpl5gDdpqRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkp
        MC/QK07MLS7NS9fLSy2xMjQwMDIFKkzIzrh16Bxjwf0Oxor/R2+zNjB2tDJ2MXJySAiYSGz+
        9Z69i5GLQ0hgB6PEou4+ti5GDg5eAUGJvzuEQWqEBVwl/p1pZQexhQSUJNZfnMUOEdeTuPVw
        DdgcNgEdiekn7oPNERHYzCzxZNEDJpA5zAKVEp/POUDs4pWY0f6UBcKWlti+fCtYL6eAncTM
        uXvYIeIaEj+W9TJD2KISN1e/ZYex3x+bD3WziETrvbNQNYISD37uhopLStyeuwmqPl/i/5Xl
        UHaNxLYD86BsfYlrHRvBbuAV8JVoebIYLM4ioCox58EvqNtcJG7N28cEYjMLaEssW/iaGeIV
        TYn1u/RBTAkBZYkjt1ggKvgkOg7/ZYf5sGHjb6zsHfOeMEHYahLrfq5nmsCoPAsRzrOQ7JqF
        sGsBI/MqRrHUguLc9NRiowIjeOQm5+duYgQnUy23HYxT3n7QO8TIxMF4iFGCg1lJhPdDoV+K
        EG9KYmVValF+fFFpTmrxIUZToC8nMkuJJucD03leSbyhiaWBiZmZobmRqYG5kjivtO3JZCGB
        9MSS1OzU1ILUIpg+Jg5OqQamI6IqGx1+62ywD5hnuc79mV25wIRUOwbZ/d3qEjG/eVoPhAba
        HU2+6VI9RfzLq3zh+2eU/Kf+nq3xdpLBr/UPIi3dz2jsOWDH9JbVdNvv5+crmE/JnxBgFt9f
        uuHq5/3fZ8vZKZ26HfbwCPuFU9qv9r3729b96/m3/xZBq/zspj8u/vf7NNusYAnRziTxipmO
        FhrTc98oubrbmr5fJBCRnrT/6ccl+f3OWhsdY06ynt2lduPryTDltStUJt3fb/7ivc+dVJ/P
        S+6WSzk2NZnurFL5e3RjwNmDd/ZsX2g6SSdd6lyE3seHoSGnFNdp3Xp16fD3budw2/pSacaw
        /2kmJ+6Xngv+0XbtV0Hl3KpFE5VYijMSDbWYi4oTAeMt/uQvBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230502041628epcms2p7233a97389cebafb73fc525a47215e707
References: <6596335b-2448-20f7-30ea-42ba40f1af72@kernel.org>
        <20230502041628epcms2p7233a97389cebafb73fc525a47215e707@epcms2p7>
        <CGME20230502041628epcms2p7233a97389cebafb73fc525a47215e707@epcms2p2>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for reviewing the patch.

> --------- Original Message ---------
> Sender : Chao Yu=C2=A0<chao=40kernel.org>=0D=0A>=20Date=20:=202023-05-04=
=2010:43=20(GMT+9)=0D=0A>=20Title=20:=20Re:=20=5BPATCH=20v4=5D=20f2fs:=20ad=
d=20async=20reset=20zone=20command=20support=0D=0A>=20To=20:=20=EB=B0=95=EB=
=8C=80=EC=A4=80<daejun7.park=40samsung.com>,=20jaegeuk=40kernel.org<jaegeuk=
=40kernel.org>,=20rostedt=40goodmis.org<rostedt=40goodmis.org>,=20mhiramat=
=40kernel.org<mhiramat=40kernel.org>,=20linux-f2fs-devel=40lists.sourceforg=
e.net<linux-f2fs-devel=40lists.sourceforge.net>,=20linux-kernel=40vger.kern=
el.org<linux-kernel=40vger.kernel.org>,=20linux-trace-kernel=40vger.kernel.=
org<linux-trace-kernel=40vger.kernel.org>=0D=0A>=20CC=20:=20=EA=B9=80=EC=84=
=9D=ED=99=98<sukka.kim=40samsung.com>,=20=EC=86=A1=EC=9A=A9=EA=B8=B8<yonggi=
l.song=40samsung.com>,=20=EA=B9=80=EB=B2=94=EC=88=98<beomsu7.kim=40samsung.=
com>=0D=0A>=20=C2=A0=0D=0A>=20On=202023/5/2=2012:16,=20Daejun=20Park=20wrot=
e:=0D=0A>=20>=20Changelog:=0D=0A>=20>=20=0D=0A>=20>=20v3=20->=20v4=0D=0A>=
=20>=20Fixed=20build=20error=20caused=20by=20unused=20function.=0D=0A>=20>=
=20=0D=0A>=20>=20v2=20->=20v3=0D=0A>=20>=20Modified=20arguments=20to=20be=
=20correct=20for=20ftrace=20parameter.=0D=0A>=20>=20Changed=20__submit_zone=
_reset_cmd=20to=20void=20return.=0D=0A>=20>=20Refactored=20the=20f2fs_wait_=
discard_bio=20function.=0D=0A>=20>=20Fixed=20code=20that=20was=20previously=
=20incorrectly=20merged.=0D=0A>=20>=20=0D=0A>=20>=20v1=20->=20v2=0D=0A>=20>=
=20Changed=20to=20apply=20the=20optional=20async=20reset=20write=20pointer=
=20by=20default.=0D=0A>=20>=20=0D=0A>=20>=20This=20patch=20enables=20submit=
=20reset=20zone=20command=20asynchornously.=20It=20helps=0D=0A>=20>=20decre=
ase=20average=20latency=20of=20write=20IOs=20in=20high=20utilization=20scen=
ario=20by=0D=0A>=20>=20faster=20checkpointing.=0D=0A>=20>=20=0D=0A>=20>=20S=
igned-off-by:=20Daejun=20Park=20<daejun7.park=40samsung.com>=0D=0A>=20>=20-=
--=0D=0A>=20>=20=C2=A0=20fs/f2fs/segment.c=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=7C=2083=20+++++++++++++++++++++++++++++++++++--=0D=0A>=20>=
=20=C2=A0=20include/trace/events/f2fs.h=20=7C=2018=20+++++++-=0D=0A>=20>=20=
=C2=A0=202=20files=20changed,=2096=20insertions(+),=205=20deletions(-)=0D=
=0A>=20>=20=0D=0A>=20>=20diff=20--git=20a/fs/f2fs/segment.c=20b/fs/f2fs/seg=
ment.c=0D=0A>=20>=20index=206db410f1bb8c..ec7a8de71198=20100644=0D=0A>=20>=
=20---=20a/fs/f2fs/segment.c=0D=0A>=20>=20+++=20b/fs/f2fs/segment.c=0D=0A>=
=20>=20=40=40=20-1196,6=20+1196,44=20=40=40=20static=20void=20__init_discar=
d_policy(struct=20f2fs_sb_info=20*sbi,=0D=0A>=20>=20=C2=A0=20static=20void=
=20__update_discard_tree_range(struct=20f2fs_sb_info=20*sbi,=0D=0A>=20>=20=
=C2=A0=20=C2=A0=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0struct=20block_device=20*bdev,=20block_t=20lstart,=0D=0A>=20>=20=C2=
=A0=20=C2=A0=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0block_t=20start,=20block_t=20len);=0D=0A>=20>=20+=0D=0A>=20>=20+=23ifdef=
=20CONFIG_BLK_DEV_ZONED=0D=0A>=20>=20+static=20void=20__submit_zone_reset_c=
md(struct=20f2fs_sb_info=20*sbi,=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20struct=20discard_cmd=
=20*dc,=20blk_opf_t=20flag,=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20struct=20list_head=20*wait_=
list,=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20unsigned=20int=20*issued)=0D=0A>=20>=20+=7B=0D=
=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0struct=20discard_cmd_contro=
l=20*dcc=20=3D=20SM_I(sbi)->dcc_info;=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0struct=20block_device=20*bdev=20=3D=20dc->bdev;=0D=0A>=20>=
=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0struct=20bio=20*bio=20=3D=20bio_all=
oc(bdev,=200,=20REQ_OP_ZONE_RESET=20=7C=20flag,=20GFP_NOFS);=0D=0A>=20>=20+=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0unsigned=20long=20flags;=0D=0A>=20>=20+=
=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0trace_f2fs_issue_reset_z=
one(bdev,=20dc->di.start);=0D=0A>=20>=20+=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0spin_lock_irqsave(&dc->lock,=20flags);=0D=0A>=20>=20+=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0dc->state=20=3D=20D_SUBMIT;=0D=0A>=20>=20+=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0dc->bio_ref++;=0D=0A>=20>=20+=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0spin_unlock_irqrestore(&dc->lock,=20flags);=0D=
=0A>=20>=20+=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(issued=
)=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0(*issued)++;=0D=0A>=20>=20+=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0atomic_inc(&dcc->queued_discard);=0D=0A>=20>=20+=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0dc->queued++;=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0list_move_tail(&dc->list,=20wait_list);=0D=0A>=20>=20+=0D=
=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0/*=20sanity=20check=20on=20=
discard=20range=20*/=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0__ch=
eck_sit_bitmap(sbi,=20dc->di.lstart,=20dc->di.lstart=20+=20dc->di.len);=0D=
=0A>=20>=20+=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0bio->bi_iter=
.bi_sector=20=3D=20SECTOR_FROM_BLOCK(dc->di.start);=0D=0A>=20>=20+=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0bio->bi_private=20=3D=20dc;=0D=0A>=20>=20+=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0bio->bi_end_io=20=3D=20f2fs_submit_discard_en=
dio;=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0submit_bio(bio);=0D=
=0A>=20=0D=0A>=20How=20about=20accounting=20iostat=20info=20for=20zone=20re=
set=20command?=0D=0A>=20=0D=0A>=20f2fs_update_iostat(sbi,=20NULL,=20FS_ZONE=
_RESET_IO,=20len=20*=20F2FS_BLKSIZE);=0D=0A=0D=0ASure,=20I=20will=20do.=0D=
=0A=20=0D=0A>=20>=20+=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0ato=
mic_inc(&dcc->issued_discard);=0D=0A>=20>=20+=7D=0D=0A>=20>=20+=23endif=0D=
=0A>=20>=20+=0D=0A>=20>=20=C2=A0=20/*=20this=20function=20is=20copied=20fro=
m=20blkdev_issue_discard=20from=20block/blk-lib.c=20*/=0D=0A>=20>=20=C2=A0=
=20static=20int=20__submit_discard_cmd(struct=20f2fs_sb_info=20*sbi,=0D=0A>=
=20>=20=C2=A0=20=C2=A0=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0struct=20discard_policy=20*dpolicy,=0D=0A>=20>=20=40=40=20-1=
217,6=20+1255,13=20=40=40=20static=20int=20__submit_discard_cmd(struct=20f2=
fs_sb_info=20*sbi,=0D=0A>=20>=20=C2=A0=20=C2=A0=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0if=20(is_sbi_flag_set(sbi,=20SBI_NEED_FSCK))=0D=0A>=20>=20=C2=A0=20=
=C2=A0=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
return=200;=0D=0A>=20>=20=C2=A0=20=0D=0A>=20>=20+=23ifdef=20CONFIG_BLK_DEV_=
ZONED=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(f2fs_sb_has_b=
lkzoned(sbi)=20&&=20bdev_is_zoned(bdev))=20=7B=0D=0A>=20>=20+=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0__submit_zone_r=
eset_cmd(sbi,=20dc,=20flag,=20wait_list,=20issued);=0D=0A>=20>=20+=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0return=200;=
=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=7D=0D=0A>=20>=20+=23end=
if=0D=0A>=20>=20+=0D=0A>=20>=20=C2=A0=20=C2=A0=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0trace_f2fs_issue_discard(bdev,=20dc->di.start,=20dc->di.len);=0D=0A>=
=20>=20=C2=A0=20=0D=0A>=20>=20=C2=A0=20=C2=A0=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0lstart=20=3D=20dc->di.lstart;=0D=0A>=20>=20=40=40=20-1461,6=20+1506,19=
=20=40=40=20static=20void=20__update_discard_tree_range(struct=20f2fs_sb_in=
fo=20*sbi,=0D=0A>=20>=20=C2=A0=20=C2=A0=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=7D=
=0D=0A>=20>=20=C2=A0=20=7D=0D=0A>=20>=20=C2=A0=20=0D=0A>=20>=20+=23ifdef=20=
CONFIG_BLK_DEV_ZONED=0D=0A>=20>=20+static=20void=20__queue_zone_reset_cmd(s=
truct=20f2fs_sb_info=20*sbi,=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0struct=20block_device=20*bdev,=20=
block_t=20blkstart,=20block_t=20lblkstart,=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0block_t=20blklen)=0D=
=0A>=20>=20+=7B=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0trace_f2f=
s_queue_reset_zone(bdev,=20blkstart);=0D=0A>=20>=20+=0D=0A>=20>=20+=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0mutex_lock(&SM_I(sbi)->dcc_info->cmd_lock);=
=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0__insert_discard_cmd(sbi=
,=20bdev,=20lblkstart,=20blkstart,=20blklen);=0D=0A>=20>=20+=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0mutex_unlock(&SM_I(sbi)->dcc_info->cmd_lock);=0D=0A>=
=20>=20+=7D=0D=0A>=20>=20+=23endif=0D=0A>=20>=20+=0D=0A>=20>=20=C2=A0=20sta=
tic=20void=20__queue_discard_cmd(struct=20f2fs_sb_info=20*sbi,=0D=0A>=20>=
=20=C2=A0=20=C2=A0=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0struct=20block_device=20*bdev,=20block_t=20blkstart,=20block_t=
=20blklen)=0D=0A>=20>=20=C2=A0=20=7B=0D=0A>=20>=20=40=40=20-1724,6=20+1782,=
19=20=40=40=20static=20void=20f2fs_wait_discard_bio(struct=20f2fs_sb_info=
=20*sbi,=20block_t=20blkaddr)=0D=0A>=20>=20=C2=A0=20=0D=0A>=20>=20=C2=A0=20=
=C2=A0=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0mutex_lock(&dcc->cmd_lock);=0D=0A>=
=20>=20=C2=A0=20=C2=A0=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0dc=20=3D=20__lookup_=
discard_cmd(sbi,=20blkaddr);=0D=0A>=20>=20+=23ifdef=20CONFIG_BLK_DEV_ZONED=
=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(dc=20&&=20f2fs_sb_=
has_blkzoned(sbi)=20&&=20bdev_is_zoned(dc->bdev))=20=7B=0D=0A>=20>=20+=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0/*=20f=
orce=20submit=20zone=20reset=20*/=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(dc->state=20=3D=3D=20D_P=
REP)=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0__submit_zone_reset_c=
md(sbi,=20dc,=20REQ_SYNC,=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0&dcc->wait_list,=20NULL);=0D=0A>=20>=20+=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0dc-=
>ref++;=0D=0A>=20=0D=0A>=20IIUC,=20should=20be?=0D=0A>=20=0D=0A>=20else=0D=
=0A>=20=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0dc->ref++;=0D=0A>=20=0D=0A>=20Th=
anks,=0D=0A=0D=0AIn=20case=20of=20discard,=20we=20can=20delete=20a=20pendin=
g=20discard=20via=20__punch_discard_cmd().=0D=0AHowever,=20we=20cannot=20re=
move=20the=20pending=20zone=20reset=20command.=0D=0AAnd,=20we=20should=20al=
ways=20wait=20for=20the=20completion=20of=20the=20zone=20reset=20command,=
=20=0D=0Aso=20I=20increased=20the=20reference=20counter.=0D=0A=0D=0AThanks,=
=0D=0ADaejun=0D=0A=0D=0A=20=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0mutex_unlock(&dcc->cmd_lock);=0D=0A>=
=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0/*=20wait=20zone=20reset=20*/=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0__wait_one_discard_bio(sbi,=
=20dc);=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0return;=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=7D=0D=0A>=20>=20+=23endif=0D=0A>=20>=20=C2=A0=20=C2=A0=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0if=20(dc)=20=7B=0D=0A>=20>=20=C2=A0=20=C2=A0=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(dc->state=
=20=3D=3D=20D_PREP)=20=7B=0D=0A>=20>=20=C2=A0=20=C2=A0=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0__punch_discard_cmd(sbi,=20dc,=20blkaddr);=0D=0A>=20>=20=40=40=20-=
1876,9=20+1947,15=20=40=40=20static=20int=20__f2fs_issue_discard_zone(struc=
t=20f2fs_sb_info=20*sbi,=0D=0A>=20>=20=C2=A0=20=C2=A0=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20blkstart,=20blklen);=0D=0A>=
=20>=20=C2=A0=20=C2=A0=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0return=20-EIO;=0D=0A>=
=20>=20=C2=A0=20=C2=A0=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=7D=0D=0A>=20>=20-=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0trace_f2fs_issue_reset_zone(bdev,=20blksta=
rt);=0D=0A>=20>=20-=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0return=20blkdev_zone_mgmt(bdev,=20REQ_OP_ZONE_RESET,=0D=
=0A>=20>=20-=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0sector,=20nr_sects,=20GFP_NOFS);=
=0D=0A>=20>=20+=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0if=20(unlikely(is_sbi_flag_set(sbi,=20SBI_POR_DO=
ING)))=20=7B=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0trace_f2fs_issu=
e_reset_zone(bdev,=20blkstart);=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0return=20blkdev_zone_mgmt(bdev,=20REQ_OP_ZONE_RESET,=0D=0A>=20>=20+=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0sector,=
=20nr_sects,=20GFP_NOFS);=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=7D=0D=0A>=20>=20+=0D=0A>=20>=20+=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0__queu=
e_zone_reset_cmd(sbi,=20bdev,=20blkstart,=20lblkstart,=20blklen);=0D=0A>=20=
>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0return=200;=0D=0A>=20>=20=C2=A0=20=C2=A0=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=7D=0D=0A>=20>=20=C2=A0=20=0D=0A>=20>=20=C2=A0=20=C2=A0=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0/*=20For=20conventional=20zones,=20use=20regular=20discar=
d=20if=20supported=20*/=0D=0A>=20>=20diff=20--git=20a/include/trace/events/=
f2fs.h=20b/include/trace/events/f2fs.h=0D=0A>=20>=20index=2099cbc5949e3c..e=
e1477de8324=20100644=0D=0A>=20>=20---=20a/include/trace/events/f2fs.h=0D=0A=
>=20>=20+++=20b/include/trace/events/f2fs.h=0D=0A>=20>=20=40=40=20-1512,7=
=20+1512,7=20=40=40=20DEFINE_EVENT(f2fs_discard,=20f2fs_remove_discard,=0D=
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
device=20*dev,=20unsigned=20int=20nobarrier,=0D=0A>=20=0D=0A>=20=C2=A0=0D=
=0A>=20=C2=A0
