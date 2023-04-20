Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC3A6E8BE3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 09:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234152AbjDTHzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 03:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234207AbjDTHyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 03:54:52 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A572D4C26
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 00:54:25 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230420075324epoutp018a4178cdd9a682b29d481959c40b942f~XlVsqUNnR1354913549epoutp01k
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 07:53:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230420075324epoutp018a4178cdd9a682b29d481959c40b942f~XlVsqUNnR1354913549epoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681977204;
        bh=u/he+tnT0S3DzCzQsDeYtXW936+iPDollN9ZkSpsd1k=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=gfqeQMAub17DjsgBSwgz+FojWX9dybSRDGqIDc2bNoUMFL7SA5wxCX5EhBy3+pf1q
         AH8tPsyzsEy+L+rsJjo0LGUd6sMtqsBEZX0SxU3C1OHO7S8ACjzD6V8RAb7BFVxcVz
         Hlxb7jQ8UNJh81rDVwFjb5NrDzsVGDS5JBo70HRI=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230420075323epcas2p44f3203170f313178323b59fe344ebcfa~XlVsDs5NN3125231252epcas2p4G;
        Thu, 20 Apr 2023 07:53:23 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.97]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Q28zR33Nbz4x9QG; Thu, 20 Apr
        2023 07:53:23 +0000 (GMT)
X-AuditID: b6c32a48-023fa700000025b2-15-6440ef7394db
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        C9.FD.09650.37FE0446; Thu, 20 Apr 2023 16:53:23 +0900 (KST)
Mime-Version: 1.0
Subject: RE:(2) [PATCH] f2fs: add async reset zone command support
Reply-To: daejun7.park@samsung.com
Sender: Daejun Park <daejun7.park@samsung.com>
From:   Daejun Park <daejun7.park@samsung.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>,
        Daejun Park <daejun7.park@samsung.com>
CC:     "chao@kernel.org" <chao@kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        Seokhwan Kim <sukka.kim@samsung.com>,
        beomsu kim <beomsu7.kim@samsung.com>,
        Yonggil Song <yonggil.song@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <ZEBO+qOLXbnYusw5@google.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230420075222epcms2p2a0a00e26b5c70d90950eed750822e5fc@epcms2p2>
Date:   Thu, 20 Apr 2023 16:52:22 +0900
X-CMS-MailID: 20230420075222epcms2p2a0a00e26b5c70d90950eed750822e5fc
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDJsWRmVeSWpSXmKPExsWy7bCmqW7xe4cUg/kvxCwuzPvIbHF66lkm
        iycH2hktXh7StFj1INziyfpZzBYL25awWFxa5G5xedccNosj68+yWCxermaxr+MBk8WqjrmM
        FlPPH2Fy4PNo2XeL3WPTqk42j90LPjN5LO6bzOrRt2UVo8fnTXIBbFHZNhmpiSmpRQqpecn5
        KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlApyoplCXmlAKFAhKLi5X07WyK
        8ktLUhUy8otLbJVSC1JyCswL9IoTc4tL89L18lJLrAwNDIxMgQoTsjN6pn1hKrj3iLHiw5Lt
        rA2Mm+8wdjFyckgImEi0X9zE3sXIxSEksINR4ujXmyxdjBwcvAKCEn93CIPUCAs4SXQtvsMK
        YgsJKEmsvziLHSKuJ3Hr4RqwOWwCOhLTT9wHi4sI+Ei86FzLDDKTWWA/i8Ts18tYIZbxSsxo
        f8oCYUtLbF++FayZU0BLYsuG+UwQcQ2JH8t6mSFsUYmbq9+yw9jvj82HOlpEovXeWagaQYkH
        P3dDxSUlbs/dBFWfL/H/ynIou0Zi24F5ULa+xLWOjWA38Ar4Siyb9gasl0VAVeLq2UtQt7lI
        LN8+FeweZgFtiWULXzODwoRZQFNi/S59EFNCQFniyC0WiAo+iY7Df9lhPmzY+Bsre8e8J1Af
        qkms+7meaQKj8ixEQM9CsmsWwq4FjMyrGMVSC4pz01OLjQpM4LGbnJ+7iRGcbLU8djDOfvtB
        7xAjEwfjIUYJDmYlEd4zrlYpQrwpiZVVqUX58UWlOanFhxhNgb6cyCwlmpwPTPd5JfGGJpYG
        JmZmhuZGpgbmSuK8HzuUU4QE0hNLUrNTUwtSi2D6mDg4pRqY8iy+uax7y9SsfZDzQPyrTqcz
        PDWL/ZctdIkWmWDCHr42jcFUvaxP8Ppb9QMqr9Mf9UWbG0iKb9P/ffqhicHFrgLn096reg79
        +smb01T1M4u/dEoIg3yVYG7js/P88e//mQdYhxipv+G4JLeTf2nTNiEtvkk/m1S0axt3+yb4
        vbrW8LI5tPjBtZsa+Sstv07d1O3zwmaZ2uUIW+OmqPR071oHL5sImU+GPIHpu//rKTxv2FeX
        cj/HivPFfet1q40/xH2fM2Mue2FU3IXvewQ2bV7cGTs31bT92+UsltBVs62fyb72X+geL/9i
        P9P01bWbDY52fXrK8GtWiqbUdoXXFUzuP1n75yVW7J+W/FqJpTgj0VCLuag4EQCpXhFcPwQA
        AA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230414025921epcms2p5736ebf6a215201e0c2a2c1a3f73ee06a
References: <ZEBO+qOLXbnYusw5@google.com>
        <20230414025921epcms2p5736ebf6a215201e0c2a2c1a3f73ee06a@epcms2p5>
        <CGME20230414025921epcms2p5736ebf6a215201e0c2a2c1a3f73ee06a@epcms2p2>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeageuk,

Thanks for helpful review.

>=20
> On 04/14, Daejun Park wrote:
> > This patch enables submit reset zone command asynchornously. It helps
> > decrease average latency of write IOs in high utilization scenario by
> > faster checkpointing.
> >=20
> > Signed-off-by: Daejun Park <daejun7.park=40samsung.com>
> > ---
> > =C2=A0Documentation/filesystems/f2fs.rst=20=7C=20=C2=A04=20++=0D=0A>=20=
>=20=C2=A0fs/f2fs/f2fs.h=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=7C=20=C2=A01=20+=0D=0A>=20>=20=
=C2=A0fs/f2fs/segment.c=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=7C=2092=20+++++++++++++++++++++++++++++-=0D=
=0A>=20>=20=C2=A0fs/f2fs/super.c=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=7C=20=C2=A08=20+++=0D=0A>=
=20>=20=C2=A0include/trace/events/f2fs.h=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=7C=2018=20+++++-=0D=0A>=20>=20=C2=A05=20files=20changed,=20119=20insert=
ions(+),=204=20deletions(-)=0D=0A>=20>=20=0D=0A>=20>=20diff=20--git=20a/Doc=
umentation/filesystems/f2fs.rst=20b/Documentation/filesystems/f2fs.rst=0D=
=0A>=20>=20index=202055e72871fe..4cfabf831a79=20100644=0D=0A>=20>=20---=20a=
/Documentation/filesystems/f2fs.rst=0D=0A>=20>=20+++=20b/Documentation/file=
systems/f2fs.rst=0D=0A>=20>=20=40=40=20-342,6=20+342,10=20=40=40=20discard_=
unit=3D%s=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20Control=20discard=20unit,=20the=20argument=20can=20be=20=22block=
=22,=20=22segment=22=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20default,=20it=20is=20helpful=20for=20large=20sized=20SMR=20or=20ZNS=20de=
vices=20to=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20reduce=20=
memory=20cost=20by=20getting=20rid=20of=20fs=20metadata=20supports=20small=
=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20discard.=0D=0A>=20=
>=20+async_reset_zone=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20Enable=20the=20=
RESET=20WRITE=20POINTER=20command=20to=20be=20submitted=20asynchronously.=
=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20With=20this=20option,=20=
the=20RESET=20WRITE=20POINTER=20command=20can=20be=20processed=20by=0D=0A>=
=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20the=20discard=20thread=20like=
=20a=20discard=20command.=20It=20can=20reduce=20checkpoint=0D=0A>=20>=20+=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20latency=20by=20asynchronously=20checkin=
g=20for=20completion=20of=20the=20RESET=20WRITE=20POINTER=20command.=0D=0A>=
=20=0D=0A>=20Do=20we=20need=20to=20set=20this=20by=20default=20instead=20of=
=20mount=20option?=0D=0A=0D=0AI=20think=20it=20is=20good=20idea.=20I=20will=
=20make=20this=20feature=20by=20default.=0D=0A=0D=0A>=20=0D=0A>=20>=20=C2=
=A0memory=3D%s=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20Control=20memory=20mode.=20This=20supports=20=22normal=22=20=
and=20=22low=22=20modes.=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=22low=22=20mode=20is=20introduced=20to=20support=20low=20memory=20de=
vices.=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20Because=20of=
=20the=20nature=20of=20low=20memory=20devices,=20in=20this=20mode,=20f2fs=
=0D=0A>=20>=20diff=20--git=20a/fs/f2fs/f2fs.h=20b/fs/f2fs/f2fs.h=0D=0A>=20>=
=20index=204e2596dacbf1..021e55c5d1a8=20100644=0D=0A>=20>=20---=20a/fs/f2fs=
/f2fs.h=0D=0A>=20>=20+++=20b/fs/f2fs/f2fs.h=0D=0A>=20>=20=40=40=20-167,6=20=
+167,7=20=40=40=20struct=20f2fs_mount_info=20=7B=0D=0A>=20>=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20*=20be=20aligned=20to=20this=20unit:=20block,=0D=
=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20*=20segment=20or=20secti=
on=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20*/=0D=0A>=20>=20+=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0bool=20async_zone_reset;=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0/*=20async=20zone=20reset=20*/=0D=0A>=20>=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0struct=20fscrypt_dummy_policy=20d=
ummy_enc_policy;=20/*=20test=20dummy=20encryption=20*/=0D=0A>=20>=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0block_t=20unusable_cap_perc;=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0/*=20percentage=20for=20cap=20*/=0D=0A>=20>=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0block_t=20unusable_cap;=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0/*=20Amount=
=20of=20space=20allowed=20to=20be=0D=0A>=20>=20diff=20--git=20a/fs/f2fs/seg=
ment.c=20b/fs/f2fs/segment.c=0D=0A>=20>=20index=2045128694eefa..60cfe97c9db=
d=20100644=0D=0A>=20>=20---=20a/fs/f2fs/segment.c=0D=0A>=20>=20+++=20b/fs/f=
2fs/segment.c=0D=0A>=20>=20=40=40=20-1189,6=20+1189,46=20=40=40=20static=20=
void=20__init_discard_policy(struct=20f2fs_sb_info=20*sbi,=0D=0A>=20>=20=C2=
=A0static=20void=20__update_discard_tree_range(struct=20f2fs_sb_info=20*sbi=
,=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0struct=20block_device=20*bdev,=20block_t=20lstart,=0D=0A>=20=
>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0block_t=20start,=20block_t=20len);=0D=0A>=20>=20+=0D=0A>=20>=20+=23if=
def=20CONFIG_BLK_DEV_ZONED=0D=0A>=20>=20+static=20int=20__submit_zone_reset=
_cmd(struct=20f2fs_sb_info=20*sbi,=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20struct=20discard_c=
md=20*dc,=20blk_opf_t=20flag,=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20struct=20list_head=20*wa=
it_list,=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20unsigned=20int=20*issued)=0D=0A>=20>=20+=7B=
=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0struct=20discard_cmd_con=
trol=20*dcc=20=3D=20SM_I(sbi)->dcc_info;=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0struct=20block_device=20*bdev=20=3D=20dc->bdev;=0D=0A>=20=
>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0struct=20bio=20*bio=20=3D=20bio_al=
loc(bdev,=200,=20REQ_OP_ZONE_RESET=20=7C=20flag,=20GFP_NOFS);=0D=0A>=20>=20=
+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0unsigned=20long=20flags;=0D=0A>=20>=20=
+=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0trace_f2fs_issue_reset_=
zone(bdev,=20SECTOR_FROM_BLOCK(dc->di.start));=0D=0A>=20>=20+=0D=0A>=20>=20=
+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0spin_lock_irqsave(&dc->lock,=20flags);=
=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0dc->state=20=3D=20D_SUBM=
IT;=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0dc->bio_ref++;=0D=0A>=
=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0spin_unlock_irqrestore(&dc->loc=
k,=20flags);=0D=0A>=20>=20+=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0if=20(issued)=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0(*issued)++;=0D=0A>=20>=20+=0D=0A>=20>=20+=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0atomic_inc(&dcc->queued_discard);=0D=0A>=
=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0dc->queued++;=0D=0A>=20>=20+=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0list_move_tail(&dc->list,=20wait_list);=0D=
=0A>=20>=20+=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0/*=20sanity=
=20check=20on=20discard=20range=20*/=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0__check_sit_bitmap(sbi,=20dc->di.lstart,=20dc->di.lstart=20+=20=
dc->di.len);=0D=0A>=20>=20+=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0bio->bi_iter.bi_sector=20=3D=20SECTOR_FROM_BLOCK(dc->di.start);=0D=0A>=
=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0bio->bi_private=20=3D=20dc;=0D=
=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0bio->bi_end_io=20=3D=20f2fs=
_submit_discard_endio;=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0su=
bmit_bio(bio);=0D=0A>=20>=20+=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0atomic_inc(&dcc->issued_discard);=0D=0A>=20>=20+=0D=0A>=20>=20+=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0return=200;=0D=0A>=20>=20+=7D=0D=0A>=20>=20+=
=23endif=0D=0A>=20>=20+=0D=0A>=20>=20=C2=A0/*=20this=20function=20is=20copi=
ed=20from=20blkdev_issue_discard=20from=20block/blk-lib.c=20*/=0D=0A>=20>=
=20=C2=A0static=20int=20__submit_discard_cmd(struct=20f2fs_sb_info=20*sbi,=
=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0struct=20discard_policy=20*dpolicy,=0D=0A>=20>=20=40=40=20-1=
210,6=20+1250,11=20=40=40=20static=20int=20__submit_discard_cmd(struct=20f2=
fs_sb_info=20*sbi,=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0i=
f=20(is_sbi_flag_set(sbi,=20SBI_NEED_FSCK))=0D=0A>=20>=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0return=200;=0D=
=0A>=20>=20=C2=A0=0D=0A>=20>=20+=23ifdef=20CONFIG_BLK_DEV_ZONED=0D=0A>=20>=
=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(f2fs_sb_has_blkzoned(sbi)=20&=
&=20bdev_is_zoned(bdev))=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0return=20__submit_zone_reset_cmd(sbi,=
=20dc,=20flag,=20wait_list,=20issued);=0D=0A>=20>=20+=23endif=0D=0A>=20>=20=
+=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0trace_f2fs_issue_d=
iscard(bdev,=20dc->di.start,=20dc->di.len);=0D=0A>=20>=20=C2=A0=0D=0A>=20>=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0lstart=20=3D=20dc->di.lstart;=
=0D=0A>=20>=20=40=40=20-1454,21=20+1499,42=20=40=40=20static=20void=20__upd=
ate_discard_tree_range(struct=20f2fs_sb_info=20*sbi,=0D=0A>=20>=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=7D=0D=0A>=20>=20=C2=A0=7D=0D=0A>=20>=20=
=C2=A0=0D=0A>=20>=20+=23ifdef=20CONFIG_BLK_DEV_ZONED=0D=0A>=20>=20+static=
=20void=20__queue_zone_reset_cmd(struct=20f2fs_sb_info=20*sbi,=0D=0A>=20>=
=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0struct=20block_device=20*bdev,=20block_t=20blkstart,=20block_t=20blklen)=
=0D=0A>=20>=20+=7B=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0block_=
t=20lblkstart=20=3D=20blkstart;=0D=0A>=20>=20+=0D=0A>=20>=20+=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0if=20(f2fs_is_multi_device(sbi))=20=7B=0D=0A>=20>=
=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0int=20devi=20=3D=20f2fs_target_device_index(sbi,=20blkstart);=0D=0A>=20>=
=20+=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0blkstart=20-=3D=20FDEV(devi).start_blk;=0D=0A>=20>=20+=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=7D=0D=0A>=20>=20+=0D=0A>=20>=20+=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0trace_f2fs_queue_reset_zone(bdev,=20blkstart);=
=0D=0A>=20>=20+=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0mutex_loc=
k(&SM_I(sbi)->dcc_info->cmd_lock);=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0__insert_discard_cmd(sbi,=20bdev,=20lblkstart,=20blkstart,=20bl=
klen);=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0mutex_unlock(&SM_I=
(sbi)->dcc_info->cmd_lock);=0D=0A>=20>=20+=7D=0D=0A>=20>=20+=23endif=0D=0A>=
=20>=20+=0D=0A>=20>=20=C2=A0static=20void=20__queue_discard_cmd(struct=20f2=
fs_sb_info=20*sbi,=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0struct=20block_device=20*bdev,=20block_=
t=20blkstart,=20block_t=20blklen)=0D=0A>=20>=20=C2=A0=7B=0D=0A>=20>=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0block_t=20lblkstart=20=3D=20blkstart=
;=0D=0A>=20>=20=C2=A0=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0tra=
ce_f2fs_queue_discard(bdev,=20blkstart,=20blklen);=0D=0A>=20>=20+=0D=0A>=20=
>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(=21f2fs_bdev_support_di=
scard(bdev))=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0return;=0D=0A>=20>=20=C2=A0=0D=0A>=20>=20-=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0trace_f2fs_queue_discard(bdev,=20blkstart,=
=20blklen);=0D=0A>=20>=20-=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0if=20(f2fs_is_multi_device(sbi))=20=7B=0D=0A>=20>=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0int=20dev=
i=20=3D=20f2fs_target_device_index(sbi,=20blkstart);=0D=0A>=20>=20=C2=A0=0D=
=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0blkstart=20-=3D=20FDEV(devi).start_blk;=0D=0A>=20>=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=7D=0D=0A>=20>=20+=0D=0A>=20>=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0mutex_lock(&SM_I(sbi)->dcc_info->cmd_lo=
ck);=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0__update_discar=
d_tree_range(sbi,=20bdev,=20lblkstart,=20blkstart,=20blklen);=0D=0A>=20>=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0mutex_unlock(&SM_I(sbi)->dcc_info=
->cmd_lock);=0D=0A>=20>=20=40=40=20-1719,7=20+1785,22=20=40=40=20static=20v=
oid=20f2fs_wait_discard_bio(struct=20f2fs_sb_info=20*sbi,=20block_t=20blkad=
dr)=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0dc=20=3D=20__loo=
kup_discard_cmd(sbi,=20blkaddr);=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0if=20(dc)=20=7B=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(dc->state=20=3D=3D=20=
D_PREP)=20=7B=0D=0A>=20>=20+=23ifdef=20CONFIG_BLK_DEV_ZONED=0D=0A>=20>=20+=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(f2fs_sb_has_blkzoned(sbi)=20&&=0D=0A=
>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0bdev_is_zoned(d=
c->bdev))=20=7B=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0struct=20discard_policy=20dpolicy;=0D=0A>=20>=20+=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0/*=20f=
orce=20submit=20zone=20reset=20*/=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0__init_discard_policy(sbi,=20&dpo=
licy,=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0DPOLICY_FORCE,=201);=0D=0A>=20>=20+=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0__subm=
it_discard_cmd(sbi,=20&dpolicy,=20dc,=20NULL);=0D=0A>=20>=20+=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0dc->ref++;=0D=0A>=
=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0need_wait=20=3D=20true;=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=7D=20else=20=7B=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0__punch_discard_cmd(sbi,=20dc,=20blkaddr);=0D=0A=
>=20=0D=0A>=20Can=20be=20consolidated=20in=20both=20cases=20below.=0D=0A=0D=
=0AHow=20do=20you=20think=20this=20modification=20as=20below.=0D=0A=0D=0A=
=20=20=20=20=20=20=20=20if=20(dc)=20=7B=0D=0A=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20if=20(dc->state=20=3D=3D=20D_PREP)=20=7B=0D=0A=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20if=20(f2fs_s=
b_has_blkzoned(sbi)=20&&=0D=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20bdev_is_zoned(dc->bdev))=20=7B=0D=0A=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20struct=20discard_policy=20dpolicy;=0D=0A=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20/*=20force=20submit=20zone=20reset=20*/=0D=0A=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
__init_discard_policy(sbi,=20&dpolicy,=0D=0A=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20DPOLICY_FORCE,=201=
);=0D=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20__submit_discard_cmd(sbi,=20&dpolicy,=20dc,=
=20NULL);=0D=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20dc->ref++;=0D=0A=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
need_wait=20=3D=20true;=0D=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=7D=20else=20=7B=0D=0A=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20__p=
unch_discard_cmd(sbi,=20dc,=20blkaddr);=0D=0A=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7D=0D=0A=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=7D=20else=20=7B=0D=0A=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20dc->ref++;=0D=0A=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20need_wait=20=3D=
=20true;=0D=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7D=0D=0A=20=
=20=20=20=20=20=20=20=7D=0D=0A=0D=0A>=20=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=7D=0D=0A>=20>=20+=23else=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0__punch_discard_cmd(sbi,=20dc,=20blkaddr);=0D=0A>=20>=20+=
=23endif=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=7D=20else=20=7B=0D=0A>=20>=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0dc->ref++;=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0need_wait=20=3D=20true;=0D=0A>=20>=20=40=40=20-1869,6=20+1950,13=
=20=40=40=20static=20int=20__f2fs_issue_discard_zone(struct=20f2fs_sb_info=
=20*sbi,=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20blkstart,=20blklen);=0D=0A>=20>=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0return=20-EIO;=0D=0A>=20>=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=7D=0D=0A>=20>=
=20+=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0if=20(likely(=21is_sbi_flag_set(sbi,=20SBI_POR_DOING))=20=
&&=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20F2FS_OPTION(=
sbi).async_zone_reset)=20=7B=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0__queue_zone_reset_cmd(sbi,=20bdev,=20lblkstart,=20blklen);=0D=0A>=20>=
=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0return=200;=0D=0A>=20>=20+=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=7D=0D=0A>=
=20=0D=0A>=20Can=20make=20a=20sigle=20case=20above=20and=20below,=20if=20we=
=20set=20this=20by=20default.=0D=0A=0D=0AI=20can=20remove=20=22F2FS_OPTION(=
sbi).async_zone_reset=22,=20but=20I=20think=20the=20checking=0D=0A=20=22SBI=
_POR_DOING=22=20statement=20can=20not=20be=20removed.=20Because=20check_zon=
e_write_pointer()=0D=0A=20and=20fix_curseg_write_pointer()=20use=20this=20_=
_f2fs_issue_discard_zone()=20for=20sending=0D=0A=20reset=20write=20pointer=
=20command=20synchronously.=0D=0A=0D=0A>=20>=20+=0D=0A>=20>=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0trace_f2f=
s_issue_reset_zone(bdev,=20blkstart);=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0return=20blkdev_zone_=
mgmt(bdev,=20REQ_OP_ZONE_RESET,=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0sector,=20nr_sects,=20GFP_NOFS);=0D=0A>=20>=20diff=20--git=20a/fs/f2f=
s/super.c=20b/fs/f2fs/super.c=0D=0A>=20>=20index=207d0202f7b317..48198112cb=
bc=20100644=0D=0A>=20>=20---=20a/fs/f2fs/super.c=0D=0A>=20>=20+++=20b/fs/f2=
fs/super.c=0D=0A>=20>=20=40=40=20-162,6=20+162,7=20=40=40=20enum=20=7B=0D=
=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0Opt_gc_merge,=0D=0A>=
=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0Opt_nogc_merge,=0D=0A>=20>=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0Opt_discard_unit,=0D=0A>=20>=
=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0Opt_async_zone_reset,=0D=0A>=20>=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0Opt_memory_mode,=0D=0A>=20>=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0Opt_age_extent_cache,=0D=0A>=20>=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0Opt_err,=0D=0A>=20>=20=40=40=20-2=
41,6=20+242,7=20=40=40=20static=20match_table_t=20f2fs_tokens=20=3D=20=7B=
=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=7BOpt_gc_merge,=20=
=22gc_merge=22=7D,=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=7BOpt_nogc_merge,=20=22nogc_merge=22=7D,=0D=0A>=20>=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=7BOpt_discard_unit,=20=22discard_unit=3D%s=22=7D,=
=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=7BOpt_async_zone_reset,=
=20=22async_zone_reset=22=7D,=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=7BOpt_memory_mode,=20=22memory=3D%s=22=7D,=0D=0A>=20>=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=7BOpt_age_extent_cache,=20=22age_exten=
t_cache=22=7D,=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=7BOp=
t_err,=20NULL=7D,=0D=0A>=20>=20=40=40=20-1249,6=20+1251,9=20=40=40=20static=
=20int=20parse_options(struct=20super_block=20*sb,=20char=20*options,=20boo=
l=20is_remount)=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=7D=0D=
=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0kfree(name);=0D=0A>=20>=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0break;=0D=0A>=20>=20+=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0case=20Opt_asyn=
c_zone_reset:=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0F2FS_OPTION(=
sbi).async_zone_reset=20=3D=20true;=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0break;=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0case=20Opt_memory_mode:=0D=0A>=20>=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0name=20=3D=20match_strdup(&args=5B0=5D)=
;=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(=21name)=0D=0A>=
=20>=20=40=40=20-2047,6=20+2052,9=20=40=40=20static=20int=20f2fs_show_optio=
ns(struct=20seq_file=20*seq,=20struct=20dentry=20*root)=0D=0A>=20>=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(test_opt(sbi,=20ATGC))=0D=0A>=20>=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0seq_puts(seq,=20=22,atgc=22);=0D=0A>=20>=20=C2=A0=0D=0A>=20>=20+=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(F2FS_OPTION(sbi).async_zone_reset)=
=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0seq_puts(seq,=20=22,async_zone_reset=22);=0D=0A>=20>=20+=0D=0A>=
=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(F2FS_OPTION(sbi).mem=
ory_mode=20=3D=3D=20MEMORY_MODE_NORMAL)=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0seq_printf(seq,=20=
=22,memory=3D%s=22,=20=22normal=22);=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0else=20if=20(F2FS_OPTION(sbi).memory_mode=20=3D=3D=20MEMO=
RY_MODE_LOW)=0D=0A>=20>=20diff=20--git=20a/include/trace/events/f2fs.h=20b/=
include/trace/events/f2fs.h=0D=0A>=20>=20index=2099cbc5949e3c..ee1477de8324=
=20100644=0D=0A>=20>=20---=20a/include/trace/events/f2fs.h=0D=0A>=20>=20+++=
=20b/include/trace/events/f2fs.h=0D=0A>=20>=20=40=40=20-1512,7=20+1512,7=20=
=40=40=20DEFINE_EVENT(f2fs_discard,=20f2fs_remove_discard,=0D=0A>=20>=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0TP_ARGS(dev,=20blkstart,=20blklen)=
=0D=0A>=20>=20=C2=A0);=0D=0A>=20>=20=C2=A0=0D=0A>=20>=20-TRACE_EVENT(f2fs_i=
ssue_reset_zone,=0D=0A>=20>=20+DECLARE_EVENT_CLASS(f2fs_reset_zone,=0D=0A>=
=20>=20=C2=A0=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0TP_PRO=
TO(struct=20block_device=20*dev,=20block_t=20blkstart),=0D=0A>=20>=20=C2=A0=
=0D=0A>=20>=20=40=40=20-1528,11=20+1528,25=20=40=40=20TRACE_EVENT(f2fs_issu=
e_reset_zone,=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0__entry->blkstart=20=3D=20blkstart;=0D=0A>=20=
>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0),=0D=0A>=20>=20=C2=A0=0D=0A>=
=20>=20-=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0TP_printk(=22dev=20=3D=20(%d,%d=
),=20reset=20zone=20at=20block=20=3D=200x%llx=22,=0D=0A>=20>=20+=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0TP_printk(=22dev=20=3D=20(%d,%d),=20zone=20at=20=
block=20=3D=200x%llx=22,=0D=0A>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0show_dev(__entry->dev),=0D=0A>=20=
>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0(unsigned=20long=20long)__entry->blkstart)=0D=0A>=20>=20=C2=A0);=
=0D=0A>=20>=20=C2=A0=0D=0A>=20>=20+DEFINE_EVENT(f2fs_reset_zone,=20f2fs_que=
ue_reset_zone,=0D=0A>=20>=20+=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0TP_PROTO(struct=20block_device=20*dev,=20block_t=20blkstart),=0D=0A>=
=20>=20+=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0TP_ARGS(dev,=20b=
lkstart)=0D=0A>=20>=20+);=0D=0A>=20>=20+=0D=0A>=20>=20+DEFINE_EVENT(f2fs_re=
set_zone,=20f2fs_issue_reset_zone,=0D=0A>=20>=20+=0D=0A>=20>=20+=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0TP_PROTO(struct=20block_device=20*dev,=20block_t=
=20blkstart),=0D=0A>=20>=20+=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0TP_ARGS(dev,=20blkstart)=0D=0A>=20>=20+);=0D=0A>=20>=20+=0D=0A>=20>=
=20=C2=A0TRACE_EVENT(f2fs_issue_flush,=0D=0A>=20>=20=C2=A0=0D=0A>=20>=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0TP_PROTO(struct=20block_device=20*de=
v,=20unsigned=20int=20nobarrier,=0D=0A>=20>=20--=20=0D=0A>=20>=202.25.1=0D=
=0A>=20=0D=0A=0D=0AThanks,=0D=0ADaejun
