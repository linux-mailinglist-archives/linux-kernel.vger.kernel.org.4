Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874316E7747
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 12:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbjDSKRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 06:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbjDSKRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 06:17:15 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69C110E7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 03:17:11 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230419101709epoutp03f2e20638994d1ce40cb5b69e8a61c3ed~XTp7G7eAB3195331953epoutp03z
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 10:17:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230419101709epoutp03f2e20638994d1ce40cb5b69e8a61c3ed~XTp7G7eAB3195331953epoutp03z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681899429;
        bh=dQhGKltJ2sO/508sMCservXe8TeuLVHaSnnz1m3XEFE=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=dqNMZNtdZI0flPdXTRBeLffGxzPcSBTjQkwvoiGHAU9pql8Jc5jxUyKt8K1XRJU8x
         qm5Uriz13+mHjMeOZCRaegLVuWvUWko0okZF+q0eV0E1ce9AW+x5mloaMMibGkihD3
         seCEdupyMrwXyjMwIvMOCUP5PU7tvtArWSeCvFWk=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230419101708epcas2p229ce7509a335b6fc71a0f5181445bb18~XTp6Yyj3u2187921879epcas2p24;
        Wed, 19 Apr 2023 10:17:08 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.98]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Q1cCm27Jbz4x9QC; Wed, 19 Apr
        2023 10:17:08 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        DA.0D.09961.4AFBF346; Wed, 19 Apr 2023 19:17:08 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20230419101707epcas2p27cf3e356713b5dddc25ee35811de434f~XTp5cyewp2187921879epcas2p21;
        Wed, 19 Apr 2023 10:17:07 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230419101707epsmtrp2973794d3bc1ecd5bad3fa103b99d4f1b~XTp5b90dd0730507305epsmtrp2J;
        Wed, 19 Apr 2023 10:17:07 +0000 (GMT)
X-AuditID: b6c32a45-bb5ff700000026e9-ea-643fbfa45a1d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C5.C1.08279.3AFBF346; Wed, 19 Apr 2023 19:17:07 +0900 (KST)
Received: from KORCO118546 (unknown [10.229.38.108]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230419101707epsmtip1c15b45a04b7362be38c7eeb72bcfab50~XTp5JI0Zj3115531155epsmtip1k;
        Wed, 19 Apr 2023 10:17:07 +0000 (GMT)
From:   "hoyoung seo" <hy50.seo@samsung.com>
To:     "'Dmitry Vyukov'" <dvyukov@google.com>
Cc:     <andreyknvl@gmail.com>, <osalvador@suse.de>,
        <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <mhocko@suse.com>, <vbabka@suse.cz>,
        <edumazet@google.com>, <longman@redhat.com>, <surenb@google.com>,
        <elver@google.com>, <glider@google.com>
In-Reply-To: <CACT4Y+Z-HkzgJO2a-0ymq6sQo9X7T9sh6f6aNaeqe=X1LGqb5Q@mail.gmail.com>
Subject: RE: [PATCH v1] lib/stackdepot: limit nr_entries size
Date:   Wed, 19 Apr 2023 19:17:07 +0900
Message-ID: <07c701d972a8$187281d0$49578570$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQH2LeZzXRW4chUMzfx4TotEfcqQhgIpdeXmAbNDkLgBMv702QJf//SkAfRY7yiurdFYwA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCJsWRmVeSWpSXmKPExsWy7bCmqe6S/fYpBtu28lnMWb+GzeL7xOns
        FhMetrFbPD32iN2i7cx2Vov2j3uZLS7vmsNmcW/Nf1aL08dOsFjc73OwODOtyGLypQVsFrMb
        +xgdeD12zrrL7rFgU6nHpk+T2D1OzPjN4vF+31U2j/VbrrJ4nFlwhN1j8+lqj8+b5AI4o7Jt
        MlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4COVlIoS8wp
        BQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBfoFSfmFpfmpevlpZZYGRoYGJkCFSZkZ3TO
        e85a8HAGY8WNye2MDYyn6rsYOTkkBEwkTj/rYOxi5OIQEtjBKPGzezozhPOJUWLKm81QmW+M
        Ei8WfWWDaflw+zMTRGIvo8TKV0uhql4ySiya1ccIUsUmoCXR/3YLWIcIkH388lJ2EJtZYBaT
        xLKjmSA2p0CgxOlLc8HiwgK2EutuPGLpYuTgYBFQlXh9Ig8kzCtgKbH5xAVGCFtQ4uTMJywQ
        Y7Qlli18zQxxkILEz6fLWCFWhUmc7/vICFEjIjG7sw3sHQmBGxwSl7/sZYFocJH4tuw/I4Qt
        LPHq+BZ2CFtK4vO7vVBfZks07lkLFa+QmLt5MlS9scSsZ+2MIHcyC2hKrN+lD2JKCChLHLkF
        dRqfRMfhv+wQYV6JjjYhiEYliTNzb0OFJSQOzs6ZwKg0C8lfs5D8NQvJ/bMQVi1gZFnFKJZa
        UJybnlpsVGAIj+vk/NxNjODkrOW6g3Hy2w96hxiZOBgPMUpwMCuJ8J5xtUoR4k1JrKxKLcqP
        LyrNSS0+xGgKDOiJzFKiyfnA/JBXEm9oYmlgYmZmaG5kamCuJM4rbXsyWUggPbEkNTs1tSC1
        CKaPiYNTqoFJzbBjXaTZHdM9CT6c01LORD+ZqLPoUWl/1Gb1O1EClmEvL93zeGQ35eT7fPbX
        vS+erVhXs33KHycmhUCe796PRLoXmlSI/IxUEvaIsqkOjpl6UHT67Dmq79onx5hLtU0qKLhh
        4tAsn+4xgyXz2Gn7QwITfZzZpDdzCu9R1Gn3eRrEbWUhV3pyB3OUkLOfqMH8LOHVLJ2L/Jt3
        n/zGHpez4fJ3RU97GaWpRo+9r3e21md8zWdPF3E6IfFvqY290k4OJqPAzuemZeuSWAtffmn0
        XbjdlOtuueGfDdHf13Rt4Rauik3dWNA11bq94H6wqy/XFjVJuStiNZvePJ4noqVdwTZ9vvKM
        +89/tOfsUGIpzkg01GIuKk4EAMAfcExXBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsWy7bCSnO7i/fYpBkvX6VjMWb+GzeL7xOns
        FhMetrFbPD32iN2i7cx2Vov2j3uZLS7vmsNmcW/Nf1aL08dOsFjc73OwODOtyGLypQVsFrMb
        +xgdeD12zrrL7rFgU6nHpk+T2D1OzPjN4vF+31U2j/VbrrJ4nFlwhN1j8+lqj8+b5AI4o7hs
        UlJzMstSi/TtErgytk6IKfg8kbHi1LNrjA2MHyq6GDk5JARMJD7c/szUxcjFISSwm1Hic8NJ
        VoiEhMT/xU1MELawxP2WI6wQRc8ZJWZd+MQOkmAT0JLof7uFDcQWAbKPX17KDlLELLCCSeL3
        i2/sEB2dzBKLDh5jAaniFAiUOH1pLli3sICtxLobj4DiHBwsAqoSr0/kgYR5BSwlNp+4wAhh
        C0qcnPkErJVZQFui92ErI4y9bOFrZojrFCR+Pl3GCnFEmMT5vo9QNSISszvbmCcwCs9CMmoW
        klGzkIyahaRlASPLKkbJ1ILi3PTcYsMCw7zUcr3ixNzi0rx0veT83E2M4GjV0tzBuH3VB71D
        jEwcjIcYJTiYlUR43W3sUoR4UxIrq1KL8uOLSnNSiw8xSnOwKInzXug6GS8kkJ5YkpqdmlqQ
        WgSTZeLglGpgKnxlsi1gg8jK2HkrXGW+ODhULv0T9FD22a8dT499nBt2x0fR+LHYlAM+Kpun
        pIu/eM1T1HmiurtcjeH34jdCJ+5vef92zVzX+xpzhRRjolLv3zJpPVq5vOxrZbLNgv0PyoQV
        eWeYlbS9f7xs2tlj/+uu/cx/f2iiaMaNOjt+l8wZ/x4+DjqXF80o82a3RMWX2Is+CUZ2b8XU
        yhW/GD0Rcf4S5zTr1O2Es4kF8sK6J7ak3bdjjeO4uvfanqXG78JdmbRi+WXlAsr/WsT/+LSv
        g+PUrkedzzZFqrlX2tf0TmF6buQX/Xf96nmcMSzNDO+/Fq5SffrGhX/uq7aLBdK+W4pCJkxr
        uh2xwPSFjq6woBJLcUaioRZzUXEiAInkplVFAwAA
X-CMS-MailID: 20230419101707epcas2p27cf3e356713b5dddc25ee35811de434f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230417051556epcas2p25b57d681bfae498b30ff33f0a96033d6
References: <CGME20230417051556epcas2p25b57d681bfae498b30ff33f0a96033d6@epcas2p2.samsung.com>
        <20230417051637.103964-1-hy50.seo@samsung.com>
        <CACT4Y+YnbfUdh5G6cXX2goP2VFfCx=Mr=_ZXAyGyLTHV1EqXwA@mail.gmail.com>
        <058901d971ab$b6a5b640$23f122c0$@samsung.com>
        <CACT4Y+Z_Yki4TVP5W8EwZbFf+YvOdo9geeN0nUYep1QsgMwiLw@mail.gmail.com>
        <CACT4Y+Z-HkzgJO2a-0ymq6sQo9X7T9sh6f6aNaeqe=X1LGqb5Q@mail.gmail.com>
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

> -----Original Message-----
> From: Dmitry Vyukov <dvyukov=40google.com>
> Sent: Tuesday, April 18, 2023 3:54 PM
> To: hoyoung seo <hy50.seo=40samsung.com>
> Cc: andreyknvl=40gmail.com; osalvador=40suse.de; akpm=40linux-foundation.=
org;
> linux-kernel=40vger.kernel.org; linux-mm=40kvack.org; mhocko=40suse.com;
> vbabka=40suse.cz; edumazet=40google.com; longman=40redhat.com; surenb=40g=
oogle.com;
> elver=40google.com; glider=40google.com
> Subject: Re: =5BPATCH v1=5D lib/stackdepot: limit nr_entries size
>=20
> On Tue, 18 Apr 2023 at 08:10, Dmitry Vyukov <dvyukov=40google.com> wrote:
> >
> > On Tue, 18 Apr 2023 at 06:10, hoyoung seo <hy50.seo=40samsung.com> wrot=
e:
> > >
> > > > -----Original Message-----
> > > > From: Dmitry Vyukov <dvyukov=40google.com>
> > > > Sent: Monday, April 17, 2023 3:20 PM
> > > > To: SEO HOYOUNG <hy50.seo=40samsung.com>
> > > > Cc: andreyknvl=40gmail.com; osalvador=40suse.de;
> > > > akpm=40linux-foundation.org; linux-kernel=40vger.kernel.org;
> > > > linux-mm=40kvack.org; mhocko=40suse.com; vbabka=40suse.cz;
> > > > edumazet=40google.com; longman=40redhat.com; surenb=40google.com;
> > > > elver=40google.com; glider=40google.com
> > > > Subject: Re: =5BPATCH v1=5D lib/stackdepot: limit nr_entries size
> > > >
> > > > On Mon, 17 Apr 2023 at 07:16, SEO HOYOUNG <hy50.seo=40samsung.com>
> wrote:
> > > > >
> > > > > While using the MCQ feature of UFS, dump stack was detected very
> deeply.
> > > > > If this continues to happen, depot_alloc_stack() will continue
> > > > > to exceed STACK_ALLOC_SIZE and STACK_ALLOC_MAX_SLABS, eventually
> > > > > resulting in the warning =22Stack depot reached limit capacity=22=
.
> > > > >
> > > > > So want to limit the size of entries stored in it.
> > > > > 25 is a test value, and we found that in a normal case, the
> > > > > depth of the stack does not exceed 25.
> > > > >
> > > > > =5B 2479.383395=5DI=5B0:launcher-loader: 1719=5D Stack depot reac=
hed
> > > > > limit capacity =5B 2479.383538=5DI=5B0:launcher-loader: 1719=5D W=
ARNING:
> CPU: 0 PID:
> > > > > 1719 at lib/stackdepot.c:129 __stack_depot_save+0x464/0x46c =5B
> > > > > 2479.385693=5DI=5B0:launcher-loader: 1719=5D pstate: 624000c5 (nZ=
Cv
> > > > > daIF
> > > > > +PAN -UAO +TCO -DIT -SSBS BTYPE=3D--) =5B 2479.385724=5DI=5B0:lau=
ncher-
> loader:
> > > > > 1719=5D pc : __stack_depot_save+0x464/0x46c =5B
> > > > > 2479.385751=5DI=5B0:launcher-loader: 1719=5D lr :
> > > > > __stack_depot_save+0x460/0x46c =5B 2479.385774=5DI=5B0:launcher-l=
oader:
> > > > > 1719=5D sp : ffffffc0080073c0 =5B 2479.385793=5DI=5B0:launcher-lo=
ader:
> > > > > 1719=5D
> > > > > x29: ffffffc0080073e0 x28: ffffffd00b78a000 x27:
> > > > > 0000000000000000 =5B
> > > > > 2479.385839=5DI=5B0:launcher-loader: 1719=5D x26: 000000000004d1d=
d x25:
> > > > > ffffff891474f000 x24: 00000000ca64d1dd =5B
> > > > > 2479.385882=5DI=5B0:launcher-loader: 1719=5D x23: 000000000000020=
0 x22:
> > > > > 0000000000000220 x21: 0000000000000040 =5B
> > > > > 2479.385925=5DI=5B0:launcher-loader: 1719=5D x20: ffffffc00800744=
0 x19:
> > > > > 0000000000000000 x18: 0000000000000000 =5B
> > > > > 2479.385969=5DI=5B0:launcher-loader: 1719=5D x17: 206572656820747=
5 x16:
> > > > 000000000000005e x15: 2d2d2d2d2d2d2d20 =5B 2479.386013=5DI=5B0:laun=
cher-
> loader:
> > > > 1719=5D x14: 5d39313731203a72 x13: 00000000002f6b30 x12:
> > > > 00000000002f6af8 =5B 2479.386057=5DI=5B0:launcher-loader: 1719=5D x=
11:
> 00000000ffffffff x10:
> > > > ffffffb90aacf000 x9 : e8a74a6c16008800 =5B 2479.386101=5DI=5B0:laun=
cher-
> loader:
> > > > 1719=5D x8 : e8a74a6c16008800 x7 : 00000000002f6b30 x6 :
> > > > 00000000002f6af8 =5B 2479.386145=5DI=5B0:launcher-loader: 1719=5D x=
5 :
> ffffffc0080070c8 x4 :
> > > > ffffffd00b192380 x3 : ffffffd0092b313c =5B 2479.386189=5DI=5B0:laun=
cher-
> loader:
> > > > 1719=5D x2 : 0000000000000001 x1 : 0000000000000004 x0 :
> > > > 0000000000000022 =5B 2479.386231=5DI=5B0:launcher-loader: 1719=5D C=
all trace:
> > > > > =5B 2479.386248=5DI=5B0:launcher-loader: 1719=5D
> > > > > __stack_depot_save+0x464/0x46c =5B 2479.386273=5DI=5B0:launcher-l=
oader:
> > > > > 1719=5D  kasan_save_stack+0x58/0x70 =5B 2479.386303=5DI=5B0:launc=
her-
> loader:
> > > > > 1719=5D  save_stack_info+0x34/0x138 =5B 2479.386331=5DI=5B0:launc=
her-
> loader:
> > > > > 1719=5D  kasan_save_free_info+0x18/0x24 =5B
> > > > > 2479.386358=5DI=5B0:launcher-loader: 1719=5D
> > > > > ____kasan_slab_free+0x16c/0x170 =5B 2479.386385=5DI=5B0:launcher-=
loader:
> > > > > 1719=5D  __kasan_slab_free+0x10/0x20 =5B 2479.386410=5DI=5B0:laun=
cher-
> loader:
> > > > > 1719=5D  kmem_cache_free+0x238/0x53c =5B 2479.386435=5DI=5B0:laun=
cher-
> loader:
> > > > > 1719=5D  mempool_free_slab+0x1c/0x28 =5B 2479.386460=5DI=5B0:laun=
cher-
> loader:
> > > > > 1719=5D  mempool_free+0x7c/0x1a0 =5B 2479.386484=5DI=5B0:launcher=
-loader:
> > > > > 1719=5D  bvec_free+0x34/0x80 =5B 2479.386514=5DI=5B0:launcher-loa=
der:
> > > > > 1719=5D
> > > > > bio_free+0x60/0x98 =5B 2479.386540=5DI=5B0:launcher-loader: 1719=
=5D
> > > > > bio_put+0x50/0x21c =5B 2479.386567=5DI=5B0:launcher-loader: 1719=
=5D
> > > > > f2fs_write_end_io+0x4ac/0x4d0 =5B 2479.386594=5DI=5B0:launcher-lo=
ader:
> > > > > 1719=5D
> > > > > bio_endio+0x2dc/0x300 =5B 2479.386622=5DI=5B0:launcher-loader: 17=
19=5D
> > > > > __dm_io_complete+0x324/0x37c =5B 2479.386650=5DI=5B0:launcher-loa=
der:
> > > > > 1719=5D
> > > > > dm_io_dec_pending+0x60/0xa4 =5B 2479.386676=5DI=5B0:launcher-load=
er:
> > > > > 1719=5D
> > > > > clone_endio+0xf8/0x2f0 =5B 2479.386700=5DI=5B0:launcher-loader: 1=
719=5D
> > > > > bio_endio+0x2dc/0x300 =5B 2479.386727=5DI=5B0:launcher-loader: 17=
19=5D
> > > > > blk_update_request+0x258/0x63c =5B 2479.386754=5DI=5B0:launcher-l=
oader:
> > > > > 1719=5D  scsi_end_request+0x50/0x304 =5B 2479.386782=5DI=5B0:laun=
cher-
> loader:
> > > > > 1719=5D  scsi_io_completion+0x88/0x160 =5B
> > > > > 2479.386808=5DI=5B0:launcher-loader: 1719=5D
> > > > > scsi_finish_command+0x17c/0x194 =5B 2479.386833=5DI=5B0:launcher-=
loader:
> > > > > 1719=5D  scsi_complete+0xcc/0x158 =5B 2479.386859=5DI=5B0:launche=
r-loader:
> > > > > 1719=5D  blk_mq_complete_request+0x4c/0x5c =5B
> > > > > 2479.386885=5DI=5B0:launcher-loader: 1719=5D
> > > > > scsi_done_internal+0xf4/0x1e0 =5B 2479.386910=5DI=5B0:launcher-lo=
ader:
> > > > > 1719=5D  scsi_done+0x14/0x20 =5B
> > > > > 2479.386935=5DI=5B0:launcher-loader: 1719=5D
> > > > > ufshcd_compl_one_cqe+0x578/0x71c =5B 2479.386963=5DI=5B0:launcher=
-loader:
> > > > > 1719=5D  ufshcd_mcq_poll_cqe_nolock+0xc8/0x150
> > > > > =5B 2479.386991=5DI=5B0:launcher-loader: 1719=5D
> > > > > ufshcd_intr+0x868/0xc0c =5B
> > > > > 2479.387017=5DI=5B0:launcher-loader: 1719=5D
> > > > > __handle_irq_event_percpu+0xd0/0x348
> > > > > =5B 2479.387044=5DI=5B0:launcher-loader: 1719=5D
> > > > > handle_irq_event_percpu+0x24/0x74 =5B 2479.387068=5DI=5B0:launche=
r-
> loader:
> > > > > 1719=5D  handle_irq_event+0x74/0xe0 =5B 2479.387091=5DI=5B0:launc=
her-
> loader:
> > > > > 1719=5D  handle_fasteoi_irq+0x174/0x240 =5B
> > > > > 2479.387118=5DI=5B0:launcher-loader: 1719=5D
> > > > > handle_irq_desc+0x7c/0x2c0 =5B
> > > > > 2479.387147=5DI=5B0:launcher-loader: 1719=5D
> > > > > generic_handle_domain_irq+0x1c/0x28
> > > > > =5B 2479.387174=5DI=5B0:launcher-loader: 1719=5D
> > > > > gic_handle_irq+0x64/0x158 =5B
> > > > > 2479.387204=5DI=5B0:launcher-loader: 1719=5D
> > > > > call_on_irq_stack+0x2c/0x54 =5B
> > > > > 2479.387231=5DI=5B0:launcher-loader: 1719=5D
> > > > > do_interrupt_handler+0x70/0xa0 =5B
> > > > > 2479.387258=5DI=5B0:launcher-loader: 1719=5D  el1_interrupt+0x34/=
0x68
> > > > > =5B
> > > > > 2479.387283=5DI=5B0:launcher-loader: 1719=5D
> > > > > el1h_64_irq_handler+0x18/0x24 =5B 2479.387308=5DI=5B0:launcher-lo=
ader:
> > > > > 1719=5D  el1h_64_irq+0x68/0x6c =5B
> > > > > 2479.387332=5DI=5B0:launcher-loader: 1719=5D
> > > > > blk_attempt_bio_merge+0x8/0x170 =5B 2479.387356=5DI=5B0:launcher-=
loader:
> > > > > 1719=5D  blk_mq_attempt_bio_merge+0x78/0x98
> > > > > =5B 2479.387383=5DI=5B0:launcher-loader: 1719=5D
> > > > > blk_mq_submit_bio+0x324/0xa40 =5B 2479.387409=5DI=5B0:launcher-lo=
ader:
> > > > > 1719=5D
> > > > > __submit_bio+0x104/0x138 =5B 2479.387436=5DI=5B0:launcher-loader:
> > > > > 1719=5D
> > > > > submit_bio_noacct_nocheck+0x1d0/0x4a0
> > > > > =5B 2479.387462=5DI=5B0:launcher-loader: 1719=5D
> > > > > submit_bio_noacct+0x618/0x804 =5B 2479.387487=5DI=5B0:launcher-lo=
ader:
> > > > > 1719=5D
> > > > > submit_bio+0x164/0x180 =5B 2479.387511=5DI=5B0:launcher-loader: 1=
719=5D
> > > > > f2fs_submit_read_bio+0xe4/0x1c4 =5B 2479.387537=5DI=5B0:launcher-=
loader:
> > > > > 1719=5D  f2fs_mpage_readpages+0x888/0xa4c =5B
> > > > > 2479.387563=5DI=5B0:launcher-loader: 1719=5D
> > > > > f2fs_readahead+0xd4/0x19c =5B
> > > > > 2479.387587=5DI=5B0:launcher-loader: 1719=5D  read_pages+0xb0/0x4=
ac =5B
> > > > > 2479.387614=5DI=5B0:launcher-loader: 1719=5D
> > > > > page_cache_ra_unbounded+0x238/0x288
> > > > > =5B 2479.387642=5DI=5B0:launcher-loader: 1719=5D
> > > > > do_page_cache_ra+0x60/0x6c =5B
> > > > > 2479.387669=5DI=5B0:launcher-loader: 1719=5D
> > > > > page_cache_ra_order+0x318/0x364 =5B 2479.387695=5DI=5B0:launcher-=
loader:
> > > > > 1719=5D  ondemand_readahead+0x30c/0x3d8 =5B
> > > > > 2479.387722=5DI=5B0:launcher-loader: 1719=5D
> > > > > page_cache_sync_ra+0xb4/0xc8 =5B
> > > > > 2479.387749=5DI=5B0:launcher-loader: 1719=5D  filemap_read+0x268/=
0xd24
> > > > > =5B
> > > > > 2479.387777=5DI=5B0:launcher-loader: 1719=5D
> > > > > f2fs_file_read_iter+0x1a0/0x62c =5B 2479.387806=5DI=5B0:launcher-=
loader:
> > > > > 1719=5D  vfs_read+0x258/0x34c =5B 2479.387831=5DI=5B0:launcher-lo=
ader:
> > > > > 1719=5D
> > > > > ksys_pread64+0x8c/0xd0 =5B 2479.387857=5DI=5B0:launcher-loader: 1=
719=5D
> > > > > __arm64_sys_pread64+0x48/0x54 =5B 2479.387881=5DI=5B0:launcher-lo=
ader:
> > > > > 1719=5D
> > > > > invoke_syscall+0x58/0x158 =5B 2479.387909=5DI=5B0:launcher-loader=
:
> > > > > 1719=5D
> > > > > el0_svc_common+0xf0/0x134 =5B 2479.387935=5DI=5B0:launcher-loader=
:
> > > > > 1719=5D
> > > > > do_el0_svc+0x44/0x114 =5B 2479.387961=5DI=5B0:launcher-loader: 17=
19=5D
> > > > > el0_svc+0x2c/0x80 =5B 2479.387985=5DI=5B0:launcher-loader: 1719=
=5D
> > > > > el0t_64_sync_handler+0x48/0x114 =5B
> > > > > 2479.388010=5DI=5B0:launcher-loader: 1719=5D
> > > > el0t_64_sync+0x190/0x194 =5B 2479.388038=5DI=5B0:launcher-loader: 1=
719=5D
> > > > Kernel panic - not syncing: kernel: panic_on_warn set ...
> > > > >
> > > > > Signed-off-by: SEO HOYOUNG <hy50.seo=40samsung.com>
> > > > > ---
> > > > >  lib/stackdepot.c =7C 3 ++-
> > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/lib/stackdepot.c b/lib/stackdepot.c index
> > > > > 2f5aa851834e..f158729598a6 100644
> > > > > --- a/lib/stackdepot.c
> > > > > +++ b/lib/stackdepot.c
> > > > > =40=40 -43,6 +43,7 =40=40
> > > > >  =23define DEPOT_MAX_POOLS =5C
> > > > >         (((1LL << (DEPOT_POOL_INDEX_BITS)) < DEPOT_POOLS_CAP) ? =
=5C
> > > > >          (1LL << (DEPOT_POOL_INDEX_BITS)) : DEPOT_POOLS_CAP)
> > > > > +=23define DEPO_MAX_DEPTH 25
> > > > >
> > > > >  /* Compact structure that stores a reference to a stack. */
> > > > > union handle_parts =7B =40=40 -375,7 +376,7 =40=40 depot_stack_ha=
ndle_t
> > > > > __stack_depot_save(unsigned long *entries,
> > > > >          * filter_irq_stacks() to simplify all callers' use of st=
ack
> depot.
> > > > >          */
> > > > >         nr_entries =3D filter_irq_stacks(entries, nr_entries);
> > > > > -
> > > > > +       nr_entries =3D nr_entries > DEPO_MAX_DEPTH ? DEPO_MAX_DEP=
TH :
> > > > > + nr_entries;
> > > > >         if (unlikely(nr_entries =3D=3D 0) =7C=7C stack_depot_disa=
bled)
> > > > >                 goto fast_exit;
> > > >
> > > > Hi SEO,
> > > >
> > > > The stack overflow errors are related to total number of stacks
> > > > rather than size of a single stack.
> > > >
> > > > filter_irq_stacks() is somehow not working in your case. It's
> > > > supposed to strip stacks somewhere around el1_interrupt (on
> > > > interrupt entry), but it's failing to do it.
> > > > As a result you are getting an effectively infinite amount of
> > > > random stacks saved.
> > > >
> > > >  You need to debug why filter_irq_stacks() is failing in your case
> > > > and fix that instead.
> > >
> > > Hi Vyukov.
> > >
> > > Thanks your reply.
> > > As you say, the filter_irq_stacks()  doesn't seem to be work correctl=
y.
> > > I checked by print a symbol name, and it looks like the filter itself
> is wrong.
> > > __irqentry_text_start -> _stext+0x0/0x66c __irqentry_text_end ->
> > > _stext+0x0/0x66c
> > >
> > > __softirqentry_text_start -> _stext+0x0/0x66c
> > > __softirqentry_text_end -> __softirqentry_text_end+0x0/0x4 Do you
> > > have the symbol name you were originally expecting?
> > >
> > > The problem seems to be caused by not riding the call stack defined
> > > by __irqentry_text_start, __irqentry_text_end when h/w irq occurs in
> our driver.
> > > If you can tell us the call stack names defined by
> > > __irqentry_text_start, __irqentry_text_end, it will help us to solve
> the problem.
> >
> > These __irqentry_text_start/end markers should contain all irq entry
> functions.
> >
> > For example, for a random x86 kernel I see:
> >
> > =24 nm -ngS vmlinux =7C grep -C 3 irqentry_text
> > ffffffff8aaeffc0 00000000000008d9 T __do_softirq
> > ffffffff8aaeffc0 T __kprobes_text_end
> > ffffffff8aaeffc0 T __kprobes_text_start
> > ffffffff8aaeffc0 T __softirqentry_text_start
> > ffffffff8aaf0899 T __softirqentry_text_end
> > ffffffff8aaf08a0 0000000000000008 T __SCT__tp_func_initcall_level
> > ffffffff8aaf08a0 T __static_call_text_start
> > ffffffff8aaf08a8 0000000000000008 T __SCT__tp_func_initcall_start
> > --
> > ffffffff8ac0013f T entry_SYSRETQ_end
> > ffffffff8ac00140 0000000000000049 T xen_error_entry
> > ffffffff8ac00190 0000000000000cc0 T irq_entries_start
> > ffffffff8ac00190 T __irqentry_text_start
> > ffffffff8ac00e50 0000000000000140 T spurious_entries_start
> > ffffffff8ac00f90 000000000000001f T asm_exc_divide_error
> > ffffffff8ac00fb0 000000000000001f T asm_exc_overflow
> > --
> > ffffffff8ac01570 000000000000001f T
> > asm_sysvec_kvm_posted_intr_wakeup_ipi
> > ffffffff8ac01590 000000000000001f T
> > asm_sysvec_kvm_posted_intr_nested_ipi
> > ffffffff8ac015b0 000000000000001f T asm_sysvec_kvm_asyncpf_interrupt
> > ffffffff8ac015d0 T __irqentry_text_end
> > ffffffff8ac015d0 T swapgs_restore_regs_and_return_to_usermode
> > ffffffff8ac01624 T restore_regs_and_return_to_kernel
> > ffffffff8ac01646 T native_irq_return_iret
> >
> >
> > So the __softirqentry_text_start/end range includes only __do_softirq
> symbol.
> >
> > And __irqentry_text_start/end includes asm_exc_divide_error,
> > asm_exc_overflow, etc.
> >
> > This looks reasonable.
> >
> > Now for a random arm64 kernel I see this:
> >
> > =24 nm -nS vmlinux =7C grep -v =22=5C=24x=22 =7C grep -C 3 irqentry_tex=
t
> > ffff800008000008 t =24d.1
> > ffff800008010008 000000000000000c t __primary_entry_veneer
> > ffff800008020000 0000000000000158 t dw_apb_ictl_handle_irq
> > ffff800008020000 T __irqentry_text_start
> > ffff800008020000 T _stext
> > ffff80000802015c 0000000000000d2c T __do_softirq ffff80000802015c T
> > __irqentry_text_end ffff80000802015c T __softirqentry_text_start
> > ffff800008020ebc T __entry_text_start ffff800008020ebc T
> > __softirqentry_text_end
> > ffff800008021000 0000000000000800 T vectors
> > ffff800008021800 000000000000007c t __bad_stack ffff80000802187c
> > 0000000000000068 t el1t_64_sync
> >
> > So the __softirqentry_text_start/end range also includes only
> > __do_softirq symbol.
> >
> > And __irqentry_text_start/end includes only dw_apb_ictl_handle_irq.
> >
> > I don't know if it's correct for arm64 kernel or not (are there other
> > irq entry points?).
> >
> > If you have other entry points, I think you need to mark them with
> > __irq_entry macro, which should place them in the section:
> >
> > https://protect2.fireeye.com/v1/url?k=3De5293872-bab2017e-e528b33d-000b=
a
> > bff3563-94c53fd7694dcd3a&q=3D1&e=3D9b2ec3db-ced2-42c4-bb11-582c6c482a74=
&u=3D
> > https%3A%2F%2Felixir.bootlin.com%2Flinux%2Flatest%2Fsource%2Finclude%2
> > Flinux%2Finterrupt.h%23L829
> > https://protect2.fireeye.com/v1/url?k=3D89e07580-d67b4c8c-89e1fecf-000b=
a
> > bff3563-69146773540d4a4e&q=3D1&e=3D9b2ec3db-ced2-42c4-bb11-582c6c482a74=
&u=3D
> > https%3A%2F%2Felixir.bootlin.com%2Flinux%2Flatest%2FA%2Fident%2F__irq_
> > entry
>=20
> Found examples of proper cut points for irq/softirq for arm64 on syzbot:
>=20
> https://protect2.fireeye.com/v1/url?k=3D67579613-38ccaf1f-67561d5c-
> 000babff3563-eef46465f98ddbdb&q=3D1&e=3D9b2ec3db-ced2-42c4-bb11-
> 582c6c482a74&u=3Dhttps%3A%2F%2Fsyzkaller.appspot.com%2Ftext%3Ftag%3DCrash=
Rep
> ort%26x%3D131be6be880000
> Freed by task 2264:
>  kasan_save_stack+0x2c/0x60 mm/kasan/common.c:45
>  kasan_set_track+0x2c/0x40 mm/kasan/common.c:52
> kasan_save_free_info+0x38/0x5c mm/kasan/generic.c:511  ____kasan_slab_fre=
e
> mm/kasan/common.c:236 =5Binline=5D
>  ____kasan_slab_free+0x124/0x1f0 mm/kasan/common.c:200
>  __kasan_slab_free+0x18/0x24 mm/kasan/common.c:244  kasan_slab_free
> include/linux/kasan.h:177 =5Binline=5D  slab_free_hook mm/slub.c:1724 =5B=
inline=5D
> slab_free_freelist_hook+0x9c/0x1bc mm/slub.c:1750  slab_free
> mm/slub.c:3661 =5Binline=5D
>  __kmem_cache_free+0xa4/0x370 mm/slub.c:3674
>  kfree+0xdc/0x284 mm/slab_common.c:1007
>  rcu_free_wq+0x9c/0x10c kernel/workqueue.c:3531  rcu_do_batch
> kernel/rcu/tree.c:2250 =5Binline=5D
>  rcu_core+0x874/0x1b50 kernel/rcu/tree.c:2510  rcu_core_si+0x10/0x1c
> kernel/rcu/tree.c:2527  _stext+0x28c/0x107c
>=20
>=20
> https://protect2.fireeye.com/v1/url?k=3D8dc95e89-d2526785-8dc8d5c6-
> 000babff3563-c398fcc416434337&q=3D1&e=3D9b2ec3db-ced2-42c4-bb11-
> 582c6c482a74&u=3Dhttps%3A%2F%2Fsyzkaller.appspot.com%2Ftext%3Ftag%3DCrash=
Rep
> ort%26x%3D1147006cc80000
> Freed by task 21:
> ...
>  skb_release_all net/core/skbuff.c:916 =5Binline=5D  __kfree_skb
> net/core/skbuff.c:930 =5Binline=5D  consume_skb+0xa4/0x17c
> net/core/skbuff.c:1098
>  mac80211_hwsim_tx_frame+0x1cc/0x1f8
> drivers/net/wireless/mac80211_hwsim.c:2054
>  mac80211_hwsim_beacon_tx+0x4f0/0x8ec
> drivers/net/wireless/mac80211_hwsim.c:2116
>  __iterate_interfaces+0x204/0x460 net/mac80211/util.c:763
>  ieee80211_iterate_active_interfaces_atomic+0xb4/0x140
> net/mac80211/util.c:799
>  mac80211_hwsim_beacon+0xcc/0x1c8
> drivers/net/wireless/mac80211_hwsim.c:2142
>  __run_hrtimer kernel/time/hrtimer.c:1685 =5Binline=5D
>  __hrtimer_run_queues+0x580/0x10a8 kernel/time/hrtimer.c:1749
>  hrtimer_run_softirq+0x158/0x220 kernel/time/hrt

Hi Vyukov

Thank you for your help.
We have resolved the issue. It was caused by not setting=20
CONFIG_FUNCTION_TRACER, CONFIG_FUNCTION_GRAPH_TRACER.
So filter_irq_stacks() does not truncate the irqentry stack.
It looks like I have to set that CONFIG to required to enable KASAN.
How about making CONFIG_FUNCTION_TRACER and CONFIG_FUNCTION set to
default when enabling KASAN?

