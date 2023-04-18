Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B866E57FA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 06:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjDREKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 00:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjDREKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 00:10:40 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D360F3C3B
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 21:10:36 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230418041032epoutp0414da4be4e7af170d235ef413c06d5939~W7AilcFNt2244622446epoutp04M
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 04:10:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230418041032epoutp0414da4be4e7af170d235ef413c06d5939~W7AilcFNt2244622446epoutp04M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681791032;
        bh=XxJHvZFaZ8zDw813xV8ZNhFKIjfzNSvmYFa8ULUCEBY=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=MYcI/QAzp5Vc1ZckYfjnKM6qwqjV5u/YFHOM+Kz3MA2Gf6BsnXrr7AGrCV1JrZOhf
         cUhYSWJaltIOWKrH0DLFMMQDXtPDlNWZreb1xs7h49W78SX+T2JglPT/bArgGi0mx8
         U8AV1KuOiWj9dkD3AIE/H7Z4FrGwH2I/5abH40Y8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230418041031epcas2p47da68cfe0bd36ed40919ea95492b30e3~W7AhktusH3118331183epcas2p4E;
        Tue, 18 Apr 2023 04:10:31 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.91]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Q0r7B6zjzz4x9Q8; Tue, 18 Apr
        2023 04:10:30 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        2F.C6.09650.6381E346; Tue, 18 Apr 2023 13:10:30 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20230418041030epcas2p48a500ba3269d13987f4bfde1c71d020b~W7AgeCVHN3116631166epcas2p4Q;
        Tue, 18 Apr 2023 04:10:30 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230418041030epsmtrp21cfb519e9184806ecec2b57b7a2aa213~W7AgdIcN20786207862epsmtrp2I;
        Tue, 18 Apr 2023 04:10:30 +0000 (GMT)
X-AuditID: b6c32a48-dc7ff700000025b2-77-643e1836106e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EE.13.08279.6381E346; Tue, 18 Apr 2023 13:10:30 +0900 (KST)
Received: from KORCO118546 (unknown [10.229.38.108]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230418041030epsmtip2c448f1c077457140f97eb54215764127~W7AgSN_qX2266422664epsmtip2Y;
        Tue, 18 Apr 2023 04:10:30 +0000 (GMT)
From:   "hoyoung seo" <hy50.seo@samsung.com>
To:     "'Dmitry Vyukov'" <dvyukov@google.com>
Cc:     <andreyknvl@gmail.com>, <osalvador@suse.de>,
        <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <mhocko@suse.com>, <vbabka@suse.cz>,
        <edumazet@google.com>, <longman@redhat.com>, <surenb@google.com>,
        <elver@google.com>, <glider@google.com>
In-Reply-To: <CACT4Y+YnbfUdh5G6cXX2goP2VFfCx=Mr=_ZXAyGyLTHV1EqXwA@mail.gmail.com>
Subject: RE: [PATCH v1] lib/stackdepot: limit nr_entries size
Date:   Tue, 18 Apr 2023 13:10:30 +0900
Message-ID: <058901d971ab$b6a5b640$23f122c0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQH2LeZzXRW4chUMzfx4TotEfcqQhgIpdeXmAbNDkLiu1/1c8A==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMJsWRmVeSWpSXmKPExsWy7bCmua6ZhF2KwZZL5hZz1q9hs/g+cTq7
        xYSHbewWT489YrdoO7Od1aL9415mi8u75rBZ3Fvzn9Xi9LETLBb3+xwszkwrsph8aQGbxezG
        PkYHXo+ds+6yeyzYVOqx6dMkdo8TM36zeLzfd5XNY/2WqyweZxYcYffYfLra4/MmuQDOqGyb
        jNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKCjlRTKEnNK
        gUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkF5gV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGTc3
        3Gct2B5RMfuDbQNjv08XIyeHhICJxLRPq1m6GLk4hAR2MEq8+nmAGcL5xChx6kAjO4TzjVHi
        6Jc5bDAtvYtns0Ek9jJKLJ2+Fqr/JaNEy/cOVpAqNgEtif63W8A6RIDs45eXsoPYzAKzmCSW
        Hc0EsTkFAiU+TH/CAmILC9hKrLvxCMxmEVCV2HpxPpjNK2ApcXjyRCYIW1Di5EyIemYBbYll
        C18zQ1ykIPHz6TJWiF1OEg1PdjBC1IhIzO5sA/tHQuACh8T3/78ZIRpcJGZ83ADVLCzx6vgW
        dghbSuLzu71Qb2ZLNO5ZCxWvkJi7eTJUr7HErGftQDYH0AJNifW79EFMCQFliSO3oE7jk+g4
        /JcdIswr0dEmBNGoJHFm7m2osITEwdk5ExiVZiH5axaSv2YhuX8WwqoFjCyrGMVSC4pz01OL
        jQpM4FGdnJ+7iRGcmrU8djDOfvtB7xAjEwfjIUYJDmYlEd4zrlYpQrwpiZVVqUX58UWlOanF
        hxhNgSE9kVlKNDkfmB3ySuINTSwNTMzMDM2NTA3MlcR5P3YopwgJpCeWpGanphakFsH0MXFw
        SjUwba9Xez7NcPoRg542w48Hsiam/pIUXcKyI9/mbmeqIGP4FJeuq7xXb2yRfZ76+peYFduE
        d09O96huV/bxKok/++vQLl+mNo9zO5lOVXGcm7fxapoup07TRC6JZM41P7z6bW+0rZv4uexz
        bJnY0g/rry95vsF9he2X/Yn8Z0M5zD1rn7dlPlo0Iy/w2Q5Tvjd7tk9eu+bAHHH19F3lb+Ye
        /GjCI2gpkjOnidPtjaVEjZDshdbNbpPkfjPffbr25/S7Reqlslcibotdyf6drH7uhnVp5dIL
        LM++hMpmG6hlrtwg8Lj/6ePdf34wnZ36xKNuScKTab+jd31hcNptr9tk+ntyU5WtBYvCdqkt
        zG+Wf1BiKc5INNRiLipOBAB+CqwgVgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsWy7bCSvK6ZhF2KwYMzEhZz1q9hs/g+cTq7
        xYSHbewWT489YrdoO7Od1aL9415mi8u75rBZ3Fvzn9Xi9LETLBb3+xwszkwrsph8aQGbxezG
        PkYHXo+ds+6yeyzYVOqx6dMkdo8TM36zeLzfd5XNY/2WqyweZxYcYffYfLra4/MmuQDOKC6b
        lNSczLLUIn27BK6M1/smMxd8Caw4vuAMcwPjP9cuRk4OCQETid7Fs9m6GLk4hAR2M0p8fdjB
        DJGQkPi/uIkJwhaWuN9yhBWi6DmjxPM/R1lBEmwCWhL9b7ewgdgiQPbxy0vZQYqYBVYwSfx+
        8Y0douMio8SEjUvBqjgFAiU+TH/CAmILC9hKrLvxCMxmEVCV2HpxPpjNK2ApcXjyRCYIW1Di
        5EyIemYBbYneh62MMPayha+hTlWQ+Pl0GSvEFU4SDU92QNWISMzubGOewCg8C8moWUhGzUIy
        ahaSlgWMLKsYJVMLinPTc4sNCwzzUsv1ihNzi0vz0vWS83M3MYLjVUtzB+P2VR/0DjEycTAe
        YpTgYFYS4T3japUixJuSWFmVWpQfX1Sak1p8iFGag0VJnPdC18l4IYH0xJLU7NTUgtQimCwT
        B6dUA1OYTv/GNyW2Hp9FzkWrubHNNrcuCT6d0W6/nMduJh9TUO58rTnPzx492zz75jJ/1pBg
        0ZzMj27X1AqKdviw6EfsuBmpx+Wk18W3fKdmtv0R9fwvHXKqfIvq5aN/P87X5xPXvsGax/72
        wVqp1xLZE367WGgruv5/ubGkNWOKiOCElCffuWrqGFgjjqtkFE28fq8lrrFSY812////dkQw
        nPzB/H7rJbNpfCuWSRiYp29gq5NvCzn7onJ3WenvQ5N9q9KePs+e/UM66kx+xNPkf2py015w
        1/fP1Zpi2BCy9qH9p9WTHhSu1TC3YLHcmxZw//lG2VSPb3EBn/vYi+Q7LxvVrtj+kXXiwbmH
        7U5WK7EUZyQaajEXFScCAIVzQSNGAwAA
X-CMS-MailID: 20230418041030epcas2p48a500ba3269d13987f4bfde1c71d020b
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
> Sent: Monday, April 17, 2023 3:20 PM
> To: SEO HOYOUNG <hy50.seo=40samsung.com>
> Cc: andreyknvl=40gmail.com; osalvador=40suse.de; akpm=40linux-foundation.=
org;
> linux-kernel=40vger.kernel.org; linux-mm=40kvack.org; mhocko=40suse.com;
> vbabka=40suse.cz; edumazet=40google.com; longman=40redhat.com; surenb=40g=
oogle.com;
> elver=40google.com; glider=40google.com
> Subject: Re: =5BPATCH v1=5D lib/stackdepot: limit nr_entries size
>=20
> On Mon, 17 Apr 2023 at 07:16, SEO HOYOUNG <hy50.seo=40samsung.com> wrote:
> >
> > While using the MCQ feature of UFS, dump stack was detected very deeply=
.
> > If this continues to happen, depot_alloc_stack() will continue to
> > exceed STACK_ALLOC_SIZE and STACK_ALLOC_MAX_SLABS, eventually
> > resulting in the warning =22Stack depot reached limit capacity=22.
> >
> > So want to limit the size of entries stored in it.
> > 25 is a test value, and we found that in a normal case, the depth of
> > the stack does not exceed 25.
> >
> > =5B 2479.383395=5DI=5B0:launcher-loader: 1719=5D Stack depot reached li=
mit
> > capacity =5B 2479.383538=5DI=5B0:launcher-loader: 1719=5D WARNING: CPU:=
 0 PID:
> > 1719 at lib/stackdepot.c:129 __stack_depot_save+0x464/0x46c =5B
> > 2479.385693=5DI=5B0:launcher-loader: 1719=5D pstate: 624000c5 (nZCv daI=
F
> > +PAN -UAO +TCO -DIT -SSBS BTYPE=3D--) =5B 2479.385724=5DI=5B0:launcher-=
loader:
> > 1719=5D pc : __stack_depot_save+0x464/0x46c =5B
> > 2479.385751=5DI=5B0:launcher-loader: 1719=5D lr :
> > __stack_depot_save+0x460/0x46c =5B 2479.385774=5DI=5B0:launcher-loader:
> > 1719=5D sp : ffffffc0080073c0 =5B 2479.385793=5DI=5B0:launcher-loader: =
1719=5D
> > x29: ffffffc0080073e0 x28: ffffffd00b78a000 x27: 0000000000000000 =5B
> > 2479.385839=5DI=5B0:launcher-loader: 1719=5D x26: 000000000004d1dd x25:
> > ffffff891474f000 x24: 00000000ca64d1dd =5B
> > 2479.385882=5DI=5B0:launcher-loader: 1719=5D x23: 0000000000000200 x22:
> > 0000000000000220 x21: 0000000000000040 =5B
> > 2479.385925=5DI=5B0:launcher-loader: 1719=5D x20: ffffffc008007440 x19:
> > 0000000000000000 x18: 0000000000000000 =5B
> > 2479.385969=5DI=5B0:launcher-loader: 1719=5D x17: 2065726568207475 x16:
> 000000000000005e x15: 2d2d2d2d2d2d2d20 =5B 2479.386013=5DI=5B0:launcher-l=
oader:
> 1719=5D x14: 5d39313731203a72 x13: 00000000002f6b30 x12: 00000000002f6af8
> =5B 2479.386057=5DI=5B0:launcher-loader: 1719=5D x11: 00000000ffffffff x1=
0:
> ffffffb90aacf000 x9 : e8a74a6c16008800 =5B 2479.386101=5DI=5B0:launcher-l=
oader:
> 1719=5D x8 : e8a74a6c16008800 x7 : 00000000002f6b30 x6 : 00000000002f6af8
> =5B 2479.386145=5DI=5B0:launcher-loader: 1719=5D x5 : ffffffc0080070c8 x4=
 :
> ffffffd00b192380 x3 : ffffffd0092b313c =5B 2479.386189=5DI=5B0:launcher-l=
oader:
> 1719=5D x2 : 0000000000000001 x1 : 0000000000000004 x0 : 0000000000000022
> =5B 2479.386231=5DI=5B0:launcher-loader: 1719=5D Call trace:
> > =5B 2479.386248=5DI=5B0:launcher-loader: 1719=5D
> > __stack_depot_save+0x464/0x46c =5B 2479.386273=5DI=5B0:launcher-loader:
> > 1719=5D  kasan_save_stack+0x58/0x70 =5B 2479.386303=5DI=5B0:launcher-lo=
ader:
> > 1719=5D  save_stack_info+0x34/0x138 =5B 2479.386331=5DI=5B0:launcher-lo=
ader:
> > 1719=5D  kasan_save_free_info+0x18/0x24 =5B
> > 2479.386358=5DI=5B0:launcher-loader: 1719=5D
> > ____kasan_slab_free+0x16c/0x170 =5B 2479.386385=5DI=5B0:launcher-loader=
:
> > 1719=5D  __kasan_slab_free+0x10/0x20 =5B 2479.386410=5DI=5B0:launcher-l=
oader:
> > 1719=5D  kmem_cache_free+0x238/0x53c =5B 2479.386435=5DI=5B0:launcher-l=
oader:
> > 1719=5D  mempool_free_slab+0x1c/0x28 =5B 2479.386460=5DI=5B0:launcher-l=
oader:
> > 1719=5D  mempool_free+0x7c/0x1a0 =5B 2479.386484=5DI=5B0:launcher-loade=
r:
> > 1719=5D  bvec_free+0x34/0x80 =5B 2479.386514=5DI=5B0:launcher-loader: 1=
719=5D
> > bio_free+0x60/0x98 =5B 2479.386540=5DI=5B0:launcher-loader: 1719=5D
> > bio_put+0x50/0x21c =5B 2479.386567=5DI=5B0:launcher-loader: 1719=5D
> > f2fs_write_end_io+0x4ac/0x4d0 =5B 2479.386594=5DI=5B0:launcher-loader: =
1719=5D
> > bio_endio+0x2dc/0x300 =5B 2479.386622=5DI=5B0:launcher-loader: 1719=5D
> > __dm_io_complete+0x324/0x37c =5B 2479.386650=5DI=5B0:launcher-loader: 1=
719=5D
> > dm_io_dec_pending+0x60/0xa4 =5B 2479.386676=5DI=5B0:launcher-loader: 17=
19=5D
> > clone_endio+0xf8/0x2f0 =5B 2479.386700=5DI=5B0:launcher-loader: 1719=5D
> > bio_endio+0x2dc/0x300 =5B 2479.386727=5DI=5B0:launcher-loader: 1719=5D
> > blk_update_request+0x258/0x63c =5B 2479.386754=5DI=5B0:launcher-loader:
> > 1719=5D  scsi_end_request+0x50/0x304 =5B 2479.386782=5DI=5B0:launcher-l=
oader:
> > 1719=5D  scsi_io_completion+0x88/0x160 =5B
> > 2479.386808=5DI=5B0:launcher-loader: 1719=5D
> > scsi_finish_command+0x17c/0x194 =5B 2479.386833=5DI=5B0:launcher-loader=
:
> > 1719=5D  scsi_complete+0xcc/0x158 =5B 2479.386859=5DI=5B0:launcher-load=
er:
> > 1719=5D  blk_mq_complete_request+0x4c/0x5c =5B
> > 2479.386885=5DI=5B0:launcher-loader: 1719=5D  scsi_done_internal+0xf4/0=
x1e0
> > =5B 2479.386910=5DI=5B0:launcher-loader: 1719=5D  scsi_done+0x14/0x20 =
=5B
> > 2479.386935=5DI=5B0:launcher-loader: 1719=5D
> > ufshcd_compl_one_cqe+0x578/0x71c =5B 2479.386963=5DI=5B0:launcher-loade=
r:
> > 1719=5D  ufshcd_mcq_poll_cqe_nolock+0xc8/0x150
> > =5B 2479.386991=5DI=5B0:launcher-loader: 1719=5D  ufshcd_intr+0x868/0xc=
0c =5B
> > 2479.387017=5DI=5B0:launcher-loader: 1719=5D
> > __handle_irq_event_percpu+0xd0/0x348
> > =5B 2479.387044=5DI=5B0:launcher-loader: 1719=5D
> > handle_irq_event_percpu+0x24/0x74 =5B 2479.387068=5DI=5B0:launcher-load=
er:
> > 1719=5D  handle_irq_event+0x74/0xe0 =5B 2479.387091=5DI=5B0:launcher-lo=
ader:
> > 1719=5D  handle_fasteoi_irq+0x174/0x240 =5B
> > 2479.387118=5DI=5B0:launcher-loader: 1719=5D  handle_irq_desc+0x7c/0x2c=
0 =5B
> > 2479.387147=5DI=5B0:launcher-loader: 1719=5D
> > generic_handle_domain_irq+0x1c/0x28
> > =5B 2479.387174=5DI=5B0:launcher-loader: 1719=5D  gic_handle_irq+0x64/0=
x158 =5B
> > 2479.387204=5DI=5B0:launcher-loader: 1719=5D  call_on_irq_stack+0x2c/0x=
54 =5B
> > 2479.387231=5DI=5B0:launcher-loader: 1719=5D  do_interrupt_handler+0x70=
/0xa0
> > =5B 2479.387258=5DI=5B0:launcher-loader: 1719=5D  el1_interrupt+0x34/0x=
68 =5B
> > 2479.387283=5DI=5B0:launcher-loader: 1719=5D  el1h_64_irq_handler+0x18/=
0x24
> > =5B 2479.387308=5DI=5B0:launcher-loader: 1719=5D  el1h_64_irq+0x68/0x6c=
 =5B
> > 2479.387332=5DI=5B0:launcher-loader: 1719=5D
> > blk_attempt_bio_merge+0x8/0x170 =5B 2479.387356=5DI=5B0:launcher-loader=
:
> > 1719=5D  blk_mq_attempt_bio_merge+0x78/0x98
> > =5B 2479.387383=5DI=5B0:launcher-loader: 1719=5D
> > blk_mq_submit_bio+0x324/0xa40 =5B 2479.387409=5DI=5B0:launcher-loader: =
1719=5D
> > __submit_bio+0x104/0x138 =5B 2479.387436=5DI=5B0:launcher-loader: 1719=
=5D
> > submit_bio_noacct_nocheck+0x1d0/0x4a0
> > =5B 2479.387462=5DI=5B0:launcher-loader: 1719=5D
> > submit_bio_noacct+0x618/0x804 =5B 2479.387487=5DI=5B0:launcher-loader: =
1719=5D
> > submit_bio+0x164/0x180 =5B 2479.387511=5DI=5B0:launcher-loader: 1719=5D
> > f2fs_submit_read_bio+0xe4/0x1c4 =5B 2479.387537=5DI=5B0:launcher-loader=
:
> > 1719=5D  f2fs_mpage_readpages+0x888/0xa4c =5B
> > 2479.387563=5DI=5B0:launcher-loader: 1719=5D  f2fs_readahead+0xd4/0x19c=
 =5B
> > 2479.387587=5DI=5B0:launcher-loader: 1719=5D  read_pages+0xb0/0x4ac =5B
> > 2479.387614=5DI=5B0:launcher-loader: 1719=5D
> > page_cache_ra_unbounded+0x238/0x288
> > =5B 2479.387642=5DI=5B0:launcher-loader: 1719=5D  do_page_cache_ra+0x60=
/0x6c =5B
> > 2479.387669=5DI=5B0:launcher-loader: 1719=5D
> > page_cache_ra_order+0x318/0x364 =5B 2479.387695=5DI=5B0:launcher-loader=
:
> > 1719=5D  ondemand_readahead+0x30c/0x3d8 =5B
> > 2479.387722=5DI=5B0:launcher-loader: 1719=5D  page_cache_sync_ra+0xb4/0=
xc8 =5B
> > 2479.387749=5DI=5B0:launcher-loader: 1719=5D  filemap_read+0x268/0xd24 =
=5B
> > 2479.387777=5DI=5B0:launcher-loader: 1719=5D
> > f2fs_file_read_iter+0x1a0/0x62c =5B 2479.387806=5DI=5B0:launcher-loader=
:
> > 1719=5D  vfs_read+0x258/0x34c =5B 2479.387831=5DI=5B0:launcher-loader: =
1719=5D
> > ksys_pread64+0x8c/0xd0 =5B 2479.387857=5DI=5B0:launcher-loader: 1719=5D
> > __arm64_sys_pread64+0x48/0x54 =5B 2479.387881=5DI=5B0:launcher-loader: =
1719=5D
> > invoke_syscall+0x58/0x158 =5B 2479.387909=5DI=5B0:launcher-loader: 1719=
=5D
> > el0_svc_common+0xf0/0x134 =5B 2479.387935=5DI=5B0:launcher-loader: 1719=
=5D
> > do_el0_svc+0x44/0x114 =5B 2479.387961=5DI=5B0:launcher-loader: 1719=5D
> > el0_svc+0x2c/0x80 =5B 2479.387985=5DI=5B0:launcher-loader: 1719=5D
> > el0t_64_sync_handler+0x48/0x114 =5B 2479.388010=5DI=5B0:launcher-loader=
: 1719=5D
> el0t_64_sync+0x190/0x194 =5B 2479.388038=5DI=5B0:launcher-loader: 1719=5D=
 Kernel
> panic - not syncing: kernel: panic_on_warn set ...
> >
> > Signed-off-by: SEO HOYOUNG <hy50.seo=40samsung.com>
> > ---
> >  lib/stackdepot.c =7C 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/stackdepot.c b/lib/stackdepot.c index
> > 2f5aa851834e..f158729598a6 100644
> > --- a/lib/stackdepot.c
> > +++ b/lib/stackdepot.c
> > =40=40 -43,6 +43,7 =40=40
> >  =23define DEPOT_MAX_POOLS =5C
> >         (((1LL << (DEPOT_POOL_INDEX_BITS)) < DEPOT_POOLS_CAP) ? =5C
> >          (1LL << (DEPOT_POOL_INDEX_BITS)) : DEPOT_POOLS_CAP)
> > +=23define DEPO_MAX_DEPTH 25
> >
> >  /* Compact structure that stores a reference to a stack. */  union
> > handle_parts =7B =40=40 -375,7 +376,7 =40=40 depot_stack_handle_t
> > __stack_depot_save(unsigned long *entries,
> >          * filter_irq_stacks() to simplify all callers' use of stack de=
pot.
> >          */
> >         nr_entries =3D filter_irq_stacks(entries, nr_entries);
> > -
> > +       nr_entries =3D nr_entries > DEPO_MAX_DEPTH ? DEPO_MAX_DEPTH :
> > + nr_entries;
> >         if (unlikely(nr_entries =3D=3D 0) =7C=7C stack_depot_disabled)
> >                 goto fast_exit;
>=20
> Hi SEO,
>=20
> The stack overflow errors are related to total number of stacks rather
> than size of a single stack.
>=20
> filter_irq_stacks() is somehow not working in your case. It's supposed to
> strip stacks somewhere around el1_interrupt (on interrupt entry), but it'=
s
> failing to do it.
> As a result you are getting an effectively infinite amount of random
> stacks saved.
>=20
>  You need to debug why filter_irq_stacks() is failing in your case and fi=
x
> that instead.

Hi Vyukov.

Thanks your reply.
As you say, the filter_irq_stacks()  doesn't seem to be work correctly.
I checked by print a symbol name, and it looks like the filter itself is wr=
ong.
__irqentry_text_start -> _stext+0x0/0x66c
__irqentry_text_end -> _stext+0x0/0x66c

__softirqentry_text_start -> _stext+0x0/0x66c
__softirqentry_text_end -> __softirqentry_text_end+0x0/0x4
Do you have the symbol name you were originally expecting?

The problem seems to be caused by not riding the call stack defined=20
by __irqentry_text_start, __irqentry_text_end when h/w irq occurs in our dr=
iver.
If you can tell us the call stack names defined by __irqentry_text_start, _=
_irqentry_text_end,=20
it will help us to solve the problem.

Thanks

