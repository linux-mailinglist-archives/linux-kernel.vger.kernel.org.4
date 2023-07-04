Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC8E746EC5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 12:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbjGDKeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 06:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbjGDKeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 06:34:36 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D540D186
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 03:34:33 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230704103432euoutp0122f75e3915ace782ffe602282a7e62db~uo6yt9VWv2040820408euoutp011
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 10:34:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230704103432euoutp0122f75e3915ace782ffe602282a7e62db~uo6yt9VWv2040820408euoutp011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1688466872;
        bh=xdpac/yu4QBQmg8p5eeTSJw/2E75DBI0Je2ljGSD878=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=e9cXfUYpszMBV50RW7NPpZLeFjkUBeo6gV7sFAMZSqkBM4HxQJVObcchbDsreoU7e
         mXPqVv/q7n+5/Xa7wggxz3dbfp1Bh+umy6nEd8DNPNN0ksaXr+awT7uv6/xXXSod23
         CgRibRSzvNSh/zdmbfUHEiuiFGmWDzf8lW7fjcmU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230704103432eucas1p1cf5eada5e8833b8b2c821c93c9424b6b~uo6yfbulV0438804388eucas1p1x;
        Tue,  4 Jul 2023 10:34:32 +0000 (GMT)
X-AuditID: cbfec7f2-a51ff7000002a5b7-a4-64a3f5b80155
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 2F.46.42423.8B5F3A46; Tue,  4
        Jul 2023 11:34:32 +0100 (BST)
Mime-Version: 1.0
Subject: RE: Re: [PATCH] trace: fix null pointer dereference in
 tracing_err_log_open()
Reply-To: m.stachyra@samsung.com
Sender: Mateusz Stachyra <m.stachyra@samsung.com>
From:   Mateusz Stachyra <m.stachyra@samsung.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230703121823.5d96c1cb@gandalf.local.home>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230704103431eucms1p179d8dd160decfb5d6c9cf0979daf46e1@eucms1p1>
Date:   Tue, 04 Jul 2023 12:34:31 +0200
X-CMS-MailID: 20230704103431eucms1p179d8dd160decfb5d6c9cf0979daf46e1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230703155237eucms1p4dfb6a19caa14c79eb6c823d127b39024
X-EPHeader: Mail
X-ConfirmMail: N,general
CMS-TYPE: 201P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsWy7djPc7o7vi5OMbiygNni8q45bBZH1p9l
        sVi8XM1iX8cDJgcWj5Z9t9g9Nq3qZPP4vEkugDmKyyYlNSezLLVI3y6BK+PQ8bcsBR/1K5bc
        D2xgPKXXxcjJISFgIjHz7ROWLkYuDiGBFYwSF9ZtZu1i5ODgFRCU+LtDGKRGWCBCYsasdSwg
        YSEBBYktz9UhwoYSE3asYgax2QT0JRYv3McIYosIaEi0LHgONpJZYC+jxOlvZ9khdvFKzGh/
        ygJhS0tsX74VrIFTwFLi3MWZTBBxUYmbq9+yw9jvj81nhLBFJFrvnWWGsAUlHvzcDRWXlLh9
        sw/Krpb4v2chlN3CKPFmjQWEbS7xc+5OsF5eAV+JxvdrwWwWAVWJ2c//Qe11kVi0+jZYnFlA
        W2LZwtfMIP8yC2hKrN+lD1HiKPFv3wFWCFtAYs2JOVDnSEhsbXnCCtHKJzFp23RmmHd3zHsC
        NV5F4siBy1BvSUmcfNXENoFRaRYioGchWTwLYfECRuZVjOKppcW56anFhnmp5XrFibnFpXnp
        esn5uZsYgani9L/jn3Ywzn31Ue8QIxMH4yFGCQ5mJRHe5ofzU4R4UxIrq1KL8uOLSnNSiw8x
        SnOwKInzatueTBYSSE8sSc1OTS1ILYLJMnFwSjUwRejsTLg6/9viKXzNMzelVi3901zZsODO
        18b7rfHuHpt6FLNnGatMNPlxkSU/LbxvT4Zyyf6ZsRcftrx6/LTr279dCmp35jMtrpV1klKL
        4OWbK5R60vlXc92ROeqbNr6z3VMcn7vrB9P98wcVygJ/RwXNeLPN9tFCTd37i69M7dlh5Cz8
        zKjHZ8eC1qwbv6Yy/A6MmLOd6eL1i7NPpXy2sJsvEDPJraXhmezTOVwuJ05v3z5Rdb6A5U/m
        v5ek5gk7fUu6Y7BIw7598fQ2Fkd981/dKdy+zdp2p/dNtc4sev7jxrSjN3z4Xv1fczuAx0tg
        3iKjRaefH2N882C9HmuzjH6d7eWA2xmXP3TFp7MbayqxFGckGmoxFxUnAgDsvmUThAMAAA==
X-CMS-RootMailID: 20230703155237eucms1p4dfb6a19caa14c79eb6c823d127b39024
References: <20230703121823.5d96c1cb@gandalf.local.home>
        <20230703155237eucms1p4dfb6a19caa14c79eb6c823d127b39024@eucms1p4>
        <CGME20230703155237eucms1p4dfb6a19caa14c79eb6c823d127b39024@eucms1p1>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> >From d6ef949d29b884dd77fe5e628dc71318de08868c Mon Sep 17 00:00:00 2001=
=C2=A0=20=0D=0A>>=20From:=20Mateusz=20Stachyra=20<m.stachyra=40samsung.com>=
=0D=0A>>=20Date:=20Mon,=203=20Jul=202023=2017:48:40=20+0200=0D=0A>>=20Subje=
ct:=20=5BPATCH=5D=20trace:=20fix=20null=20pointer=20dereference=20in=20trac=
ing_err_log_open()=0D=0A>>=20=0D=0A>>=20Fix=20an=20issue=20in=20function=20=
'tracing_err_log_open'.=0D=0A>>=20The=20function=20doesn't=20call=20'seq_op=
en'=20if=20file=20is=20opened=20only=20with=0D=0A>>=20write=20permissions,=
=20which=20results=20in=20'file->private_data'=20being=20left=20at=20null.=
=0D=0A>>=20If=20we=20then=20use=20'lseek'=20on=20that=20opened=20file,=20's=
eq_lseek'=20dereferences=0D=0A>>=20'file->private_data'=20in=20'mutex_lock(=
&m->lock)',=20resulting=20in=20a=20Kernel=20panic.=0D=0A>>=20Writing=20to=
=20this=20node=20requires=20root=20privilages,=20therefore=20this=20bug=0D=
=0A>>=20has=20very=20little=20security=20impact.=0D=0A>>=20=0D=0A>>=20Trace=
fs=20node:=20/sys/kernel/tracing/error_log=0D=0A>>=20=0D=0A>=0D=0A>Nice=20c=
atch,=20but=20I=20recommend=20a=20different=20solution.=0D=0A>=0D=0A>=0D=0A=
>>=20Example=20Kernel=20panic:=0D=0A>>=20=0D=0A>>=20Unable=20to=20handle=20=
kernel=20NULL=20pointer=20dereference=20at=20virtual=20address=200000000000=
000038=0D=0A>>=20Call=20trace:=0D=0A>>=C2=A0=20mutex_lock+0x30/0x110=0D=0A>=
>=C2=A0=20seq_lseek+0x34/0xb8=0D=0A>>=C2=A0=20__arm64_sys_lseek+0x6c/0xb8=
=0D=0A>>=C2=A0=20invoke_syscall+0x58/0x13c=0D=0A>>=C2=A0=20el0_svc_common+0=
xc4/0x10c=0D=0A>>=C2=A0=20do_el0_svc+0x24/0x98=0D=0A>>=C2=A0=20el0_svc+0x24=
/0x88=0D=0A>>=C2=A0=20el0t_64_sync_handler+0x84/0xe4=0D=0A>>=C2=A0=20el0t_6=
4_sync+0x1b4/0x1b8=0D=0A>>=20Code:=20d503201f=20aa0803e0=20aa1f03e1=20aa010=
3e9=20(c8e97d02)=0D=0A>>=20---=5B=20end=20trace=20561d1b49c12cf8a5=20=5D---=
=0D=0A>>=20Kernel=20panic=20-=20not=20syncing:=20Oops:=20Fatal=20exception=
=0D=0A>>=20=0D=0A>>=20Signed-off-by:=20Mateusz=20Stachyra=20<m.stachyra=40s=
amsung.com>=0D=0A>>=20---=0D=0A>>=C2=A0=20kernel/trace/trace.c=20=7C=2010=
=20+++++++++-=0D=0A>>=C2=A0=201=20file=20changed,=209=20insertions(+),=201=
=20deletion(-)=0D=0A>>=20=0D=0A>>=20diff=20--git=20a/kernel/trace/trace.c=
=20b/kernel/trace/trace.c=0D=0A>>=20index=205d2c5678b..bfa8e2d01=20100644=
=0D=0A>>=20---=20a/kernel/trace/trace.c=0D=0A>>=20+++=20b/kernel/trace/trac=
e.c=0D=0A>>=20=40=40=20-8097,8=20+8097,16=20=40=40=20static=20int=20tracing=
_err_log_open(struct=20inode=20*inode,=20struct=20file=20*file)=0D=0A>>=C2=
=A0=20=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0return=20ret;=0D=0A>>=C2=A0=20=0D=0A>>=C2=A0=20=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0/*=20If=20this=20file=20was=20opened=20for=20write,=20then=20er=
ase=20contents=20*/=0D=0A>>=20-=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20((f=
ile->f_mode=20&=20FMODE_WRITE)=20&&=20(file->f_flags=20&=20O_TRUNC))=0D=0A>=
>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20((file->f_mode=20&=20FMODE_WR=
ITE)=20&&=20(file->f_flags=20&=20O_TRUNC))=20=7B=0D=0A>>=C2=A0=20=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0clear_tracin=
g_err_log(tr);=0D=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0ret=20=3D=20seq_open(file,=20&tracing_err_log_seq_o=
ps);=0D=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0if=20(=21ret)=20=7B=0D=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0struct=20seq_file=20*m=20=3D=20file->private_data;=0D=0A>>=20+=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0m->private=20=3D=20tr;=0D=0A>>=20+=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=7D=20else=20=
=7B=0D=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0trace_array_put(tr);=0D=0A>=
>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=7D=0D=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=7D=0D=0A>>=C2=A0=20=
=0D=0A>>=C2=A0=20=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(file->f_mode=20&=
=20FMODE_READ)=20=7B=0D=0A>>=C2=A0=20=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0ret=20=3D=20seq_open(file,=20&tracing_e=
rr_log_seq_ops);=0D=0A>>=20=0D=0A>>=20base-commit:=201ef6663a587ba3e57dc506=
5a477db1c64481eedd=0D=0A>=0D=0A>I=20believe=20this=20can=20be=20better=20fi=
xed=20by:=0D=0A>=0D=0A>diff=20--git=20a/kernel/trace/trace.c=20b/kernel/tra=
ce/trace.c=0D=0A>index=2064a4dde073ef..999b7c73e324=20100644=0D=0A>---=20a/=
kernel/trace/trace.c=0D=0A>+++=20b/kernel/trace/trace.c=0D=0A>=40=40=20-813=
5,7=20+8135,7=20=40=40=20static=20const=20struct=20file_operations=20tracin=
g_err_log_fops=20=3D=20=7B=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
.open=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=20=3D=20tracing_err_log_=
open,=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0.write=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=3D=20tracing_err_=
log_write,=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0.read=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=20=3D=20seq_read,=0D=0A>-=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0.llseek=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=20=3D=
=20seq_lseek,=0D=0A>+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0.llseek=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=3D=20tracin=
g_lseek,=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0.release=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=3D=20tracing_err_log_release,=0D=0A>=20=7D;=0D=
=0A>=0D=0A>as=20that=20tracing_lseek()=20is=20for=20this=20exact=20scenario=
.=0D=0A>=0D=0A>Care=20to=20send=20a=20v2?=0D=0A>=0D=0A>Thanks,=0D=0A>=0D=0A=
>--=20Steve=0D=0A=0D=0AThanks=20for=20reply=20and=20for=20the=20suggestion.=
=0D=0AI've=20submitted=20v2=20at:=0D=0Ahttps://lore.kernel.org/all/20230704=
102706eucms1p30d7ecdcc287f46ad67679fc8491b2e0f=40eucms1p3/=0D=0A=0D=0A--=20=
Mateusz
