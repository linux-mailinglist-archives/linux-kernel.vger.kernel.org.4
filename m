Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA106AA4D4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 23:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbjCCWyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 17:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbjCCWyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 17:54:13 -0500
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A091EBCE;
        Fri,  3 Mar 2023 14:53:47 -0800 (PST)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20230303215456usoutp02b1d76daff059bc405125efcb8882dfc9~JB2vrsktX1075310753usoutp02a;
        Fri,  3 Mar 2023 21:54:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20230303215456usoutp02b1d76daff059bc405125efcb8882dfc9~JB2vrsktX1075310753usoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677880496;
        bh=Z2Rn13uNaVD27nSdhdfylk8HLkTwqheQLBAhFsIbW38=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=nAn5zy/SLijvFphmGtdFroIk7cRyN2f1hCiC5lZCsfRYWR/Yb1ajEPG1OL6zcLJ7w
         UIiuxwGNKZ33ukPjvt+NEu7CoECrbpVf6QlzSiB2MM93YJRo07koW9NCop0qBBaHpr
         z8moBHGcm44KJTAm2dt+r2zFw0xyCqhZBzFi6zLU=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230303215456uscas1p2787369c71f175c90d21fadca2366386b~JB2veaNwM3104331043uscas1p2Y;
        Fri,  3 Mar 2023 21:54:56 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id F7.23.49129.FAC62046; Fri, 
        3 Mar 2023 16:54:55 -0500 (EST)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230303215455uscas1p26a9f8fd92c6cbe9e2f8be72190b373ef~JB2vAdn8j1866418664uscas1p2b;
        Fri,  3 Mar 2023 21:54:55 +0000 (GMT)
X-AuditID: cbfec36f-eddff7000001bfe9-ae-64026caf7114
Received: from SSI-EX4.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 10.D0.11378.FAC62046; Fri, 
        3 Mar 2023 16:54:55 -0500 (EST)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX4.ssi.samsung.com (105.128.2.229) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Fri, 3 Mar 2023 13:54:54 -0800
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Fri,
        3 Mar 2023 13:54:54 -0800
From:   Fan Ni <fan.ni@samsung.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     "alison.schofield@intel.com" <alison.schofield@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/hdm: Fix hdm decoder init by adding COMMIT field
 check
Thread-Topic: [PATCH] cxl/hdm: Fix hdm decoder init by adding COMMIT field
        check
Thread-Index: AQHZS8WnqoF9q+YY/UCqLavADTGrLa7qFEkAgAAP1IA=
Date:   Fri, 3 Mar 2023 21:54:54 +0000
Message-ID: <20230303215446.GA1479551@bgt-140510-bm03>
In-Reply-To: <64025f6219d2d_71138294e5@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5B416EA2175CB14DA0B54F96157C17DB@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMKsWRmVeSWpSXmKPExsWy7djXc7rrc5hSDFY02ljcfXyBzaJ58mJG
        i+lTLzBarL65htFi/9PnLBarFl5jszg/6xSLxeVdc9gsbk04xuTA6dFy5C2rx+I9L5k8Nq3q
        ZPOYOrve4/MmuQDWKC6blNSczLLUIn27BK6M25fXMRccca2Y8GoVYwPjfssuRk4OCQETiSeb
        J7GA2EICKxklXrzy7WLkArJbmSS2vH/GDlP07tM6FojEWkaJtzfmQDkfGSWaj29kh3CWMkrs
        +b6WDaSFTUBRYl/XdjBbREBbYuKcg8wgRcwCT5glbu++A9TOwSEsECjx8nQNRE2QxK5Td1kg
        bCuJC+8OMIHYLAIqEue3rGQEsXkFzCSutT5iBWnlFPCUuDilCiTMKCAm8f3UGrByZgFxiVtP
        5jNBXC0osWj2HmYIW0zi366HbBC2osT97y/ZIep1JBbs/sQGYdtJvGk6zgpha0ssW/iaGWKt
        oMTJmU9YIHolJQ6uuAH2vITACw6JFWuvQi1wkdhx7QnUAmmJq9enMoPcKSGQLLHqIxdEOEdi
        /pItUHOsJRb+Wc80gVFlFpKzZyE5aRaSk2YhOWkWkpMWMLKuYhQvLS7OTU8tNspLLdcrTswt
        Ls1L10vOz93ECExXp/8dzt/BeP3WR71DjEwcjIcYJTiYlUR4qxsYUoR4UxIrq1KL8uOLSnNS
        iw8xSnOwKInzGtqeTBYSSE8sSc1OTS1ILYLJMnFwSjUwsSoxKG58fPiwQUzmHbOXa64wnYpQ
        EGl3nM6WqLHz5t/iDrsDEdLyfrmvdZz1RT3KIk7trWx7w51y8O2G+cHmTgwGExbsrDWJYzcN
        2b2Eca7ovcAe0YDTokYLPHPP2G+fYbQ7+6jjNObH7i/FoiPCFSxPHj8kMq/GzHpJ/YI/Cqt/
        BS4/pXPb5MWZvndHbF0uy84JeX3HuHy261RD0bnRpdtYHdLM9I53+cYnpTIJfTiQsnBev8Ut
        xc5oXyYzg6tbFmQ3Kkg6Hvud9ti19KiK/sOEy7Z3LBZJfix53nyMZf3Jo2dna90QPd06b9sh
        z+aLXBKaoe/jjgXWl27dFTxn6fKT+tPWJrXF7uTt9axWYinOSDTUYi4qTgQAPAj/xcYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsWS2cA0SXd9DlOKwdbjkhZ3H19gs2ievJjR
        YvrUC4wWq2+uYbTY//Q5i8WqhdfYLM7POsVicXnXHDaLWxOOMTlwerQcecvqsXjPSyaPTas6
        2Tymzq73+LxJLoA1issmJTUnsyy1SN8ugSvj9uV1zAVHXCsmvFrF2MC437KLkZNDQsBE4t2n
        dSxdjFwcQgKrGSVmfNjNBOF8ZJS41vgNylnKKNF19yELSAubgKLEvq7tbCC2iIC2xMQ5B5lB
        ipgFnjBL3N59B6iIg0NYIFDi5ekaiJogibuvFkPVW0lceHeACcRmEVCROL9lJSOIzStgJnGt
        9REriC0kcIZR4u4bL5AxnAKeEhenVIGEGQXEJL6fWgPWyiwgLnHryXwmiA8EJJbsOc8MYYtK
        vHz8jxXCVpS4//0lO0S9jsSC3Z/YIGw7iTdNx1khbG2JZQtfM0OcIChxcuYTFoheSYmDK26w
        TGCUmIVk3Swko2YhGTULyahZSEYtYGRdxSheWlycm15RbJiXWq5XnJhbXJqXrpecn7uJERjt
        p/8djtzBePTWR71DjEwcjIcYJTiYlUR4qxsYUoR4UxIrq1KL8uOLSnNSiw8xSnOwKInzCrlO
        jBcSSE8sSc1OTS1ILYLJMnFwSjUw7XBbJVax+k+a0BRza0eFTJ3933gzLr4KD2+3n+i466op
        Q+lnb735n21Z3zJGtSUtXCn8e5eN4nebukVHVrdnhpl6bk35mf2el0Px3KPI//LWDm/LBE9L
        TX7Awir56PKZhgamrBjHFItlb3jPlG5mOj4r5ZHX0//cLXmTPMOf20euYuud5qL0fP+m8sAv
        t7Mlf1tumPHn9baLWScXSlVWLjxl+F9595r5bxdXXTJVdnqc3Jl8f3ZaxNc/+y5/sHN4uUGu
        pnvxp7vz7ms/X7s/anmydZzfrLVTjT3viRpsrDuyzHkf/96fvxze1Qt7SNRPb40LzmsoF51y
        PN9F7l9iiP+nTYY36q4rLBEUcAkKVmIpzkg01GIuKk4EAHgBCbxlAwAA
X-CMS-MailID: 20230303215455uscas1p26a9f8fd92c6cbe9e2f8be72190b373ef
CMS-TYPE: 301P
X-CMS-RootMailID: 20230228224029uscas1p1e2fb92a8a595f80fa2985b452899d785
References: <CGME20230228224029uscas1p1e2fb92a8a595f80fa2985b452899d785@uscas1p1.samsung.com>
        <20230228224014.1402545-1-fan.ni@samsung.com>
        <64025f6219d2d_71138294e5@dwillia2-xfh.jf.intel.com.notmuch>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2023 at 12:58:10PM -0800, Dan Williams wrote:

> Fan Ni wrote:
> > Add COMMIT field check aside with existing COMMITTED field check during
> > hdm decoder initialization to avoid a system crash during module remova=
l
> > after destroying a region which leaves the COMMIT field being reset whi=
le
> > the COMMITTED field still being set.
> >=20
> > In current kernel implementation, when destroying a region (cxl
> > destroy-region),the decoders associated to the region will be reset
> > as that in cxl_decoder_reset, where the COMMIT field will be reset.
> > However, resetting COMMIT field will not automatically reset the
> > COMMITTED field, causing a situation where COMMIT is reset (0) while
> > COMMITTED is set (1) after the region is destroyed. Later, when
> > init_hdm_decoder is called (during modprobe), current code only check
> > the COMMITTED to decide whether the decoder is enabled or not. Since
> > the COMMITTED will be 1 and the code treats the decoder as enabled,
> > which will cause unexpected behaviour.
> >=20
> > Before the fix, a system crash was observed when performing following
> > steps:
> > 1. modprobe -a cxl_acpi cxl_core cxl_pci cxl_port cxl_mem
> > 2. cxl create-region -m -d decoder0.0 -w 1 mem0 -s 256M
> > 3. cxl destroy-region region0 -f
> > 4. rmmod cxl_acpi cxl_pci cxl_port cxl_mem cxl_pmem cxl_core
> > 5. modprobe -a cxl_acpi cxl_core cxl_pci cxl_port cxl_mem (showing
> > "no CXL window for range 0x0:0xffffffffffffffff" error message)
> > 6. rmmod cxl_acpi cxl_pci cxl_port cxl_mem cxl_pmem cxl_core (kernel
> > crash at cxl_dpa_release due to dpa_res has been freed when destroying
> > the region).
>=20
> I think a separate fix for that crash is needed, can you send the
> backtrace? I.e. I worry that crash can be triggered by other means.
Hi Dan,
See backtrace below.

[  130.299394] BUG: kernel NULL pointer dereference, address: 0000000000000=
008
[  130.299907] #PF: supervisor read access in kernel mode
[  130.299907] #PF: error_code(0x0000) - not-present page
[  130.299907] PGD 0 P4D 0=20
[  130.299907] Oops: 0000 [#1] PREEMPT SMP NOPTI
[  130.299907] CPU: 13 PID: 467 Comm: rmmod Not tainted 6.2.0-rc6-00024-g3e=
a761ec9dd5 #58
[  130.299907] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel=
-1.16.1-0-g3208b098f51a-prebuilt.qemu.org 04/01/2014
[  130.299907] RIP: 0010:__cxl_dpa_release+0x3c/0xb0 [cxl_core]
[  130.299907] Code: ff ff 48 8b 7d 40 4c 8b a8 d8 02 00 00 e8 5c a6 ff ff =
4c 8b a5 28 03 00 00 48 89 c3 48 8b 85 20 03 00 00 4d 8b ad 40 03 00 00 <48=
> 8b 50 08 4c 8b 30 49 81 c5 90 00 00 00 4c 89 ef 48 83 c2 01 4c
[  130.299907] RSP: 0018:ffffc9000075fae0 EFLAGS: 00000246
[  130.299907] RAX: 0000000000000000 RBX: ffff88810250cc00 RCX: 00000000000=
00000
[  130.299907] RDX: 0000000000000001 RSI: ffff8881008d25e8 RDI: ffff8881025=
0cc00
[  130.299907] RBP: ffff88810250d000 R08: 0000000000000001 R09: ffffffff818=
2b400
[  130.299907] R10: ffff888101fd7238 R11: ffff888201c1f406 R12: 00000000000=
00000
[  130.299907] R13: 0000000000000000 R14: ffff88810250ce90 R15: ffff8881025=
0ce8c
[  130.299907] FS:  00007f53b3884c40(0000) GS:ffff888277d40000(0000) knlGS:=
0000000000000000
[  130.299907] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  130.299907] CR2: 0000000000000008 CR3: 000000010285c000 CR4: 00000000000=
006e0
[  130.299907] Call Trace:
[  130.299907]  <TASK>
[  130.299907]  cxl_dpa_release+0x18/0x30 [cxl_core]
[  130.299907]  release_nodes+0x40/0x70
[  130.299907]  devres_release_all+0x86/0xc0
[  130.299907]  device_unbind_cleanup+0x9/0x70
[  130.299907]  device_release_driver_internal+0xe9/0x160
[  130.299907]  bus_remove_device+0xd3/0x140
[  130.299907]  device_del+0x186/0x3d0
[  130.299907]  ? _raw_spin_unlock_irqrestore+0x16/0x30
[  130.299907]  ? devres_remove+0xcb/0xf0
[  130.299907]  device_unregister+0xe/0x60
[  130.299907]  ? __pfx_devm_action_release+0x10/0x10
[  130.299907]  devres_release+0x22/0x50
[  130.299907]  devm_release_action+0x33/0x60
[  130.299907]  ? __pfx_unregister_port+0x10/0x10 [cxl_core]
[  130.299907]  delete_endpoint+0x7a/0x80 [cxl_core]
[  130.299907]  release_nodes+0x40/0x70
[  130.299907]  devres_release_all+0x86/0xc0
[  130.299907]  device_unbind_cleanup+0x9/0x70
[  130.299907]  device_release_driver_internal+0xe9/0x160
[  130.299907]  bus_remove_device+0xd3/0x140
[  130.299907]  device_del+0x186/0x3d0
[  130.299907]  cdev_device_del+0x10/0x30
[  130.299907]  cxl_memdev_unregister+0x36/0x40 [cxl_core]
[  130.299907]  release_nodes+0x40/0x70
[  130.299907]  devres_release_all+0x86/0xc0
[  130.299907]  device_unbind_cleanup+0x9/0x70
[  130.299907]  device_release_driver_internal+0xe9/0x160
[  130.299907]  driver_detach+0x3f/0x80
[  130.299907]  bus_remove_driver+0x50/0xd0
[  130.299907]  pci_unregister_driver+0x36/0x80
[  130.299907]  __x64_sys_delete_module+0x191/0x270
[  130.299907]  ? fpregs_assert_state_consistent+0x1d/0x50
[  130.299907]  ? exit_to_user_mode_prepare+0x36/0x120
[  130.299907]  do_syscall_64+0x3b/0x90
[  130.299907]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[  130.299907] RIP: 0033:0x7f53b3126c9b
[  130.299907] Code: 73 01 c3 48 8b 0d 95 21 0f 00 f7 d8 64 89 01 48 83 c8 =
ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 00 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 65 21 0f 00 f7 d8 64 89 01 48
[  130.299907] RSP: 002b:00007fff5a72c558 EFLAGS: 00000206 ORIG_RAX: 000000=
00000000b0
[  130.299907] RAX: ffffffffffffffda RBX: 000056037a16e790 RCX: 00007f53b31=
26c9b
[  130.299907] RDX: 000000000000000a RSI: 0000000000000800 RDI: 000056037a1=
6e7f8
[  130.299907] RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000000=
00000
[  130.299907] R10: 00007f53b31beac0 R11: 0000000000000206 R12: 00007fff5a7=
2c7b0
[  130.299907] R13: 000056037a16d2a0 R14: 00007fff5a72cdb7 R15: 000056037a1=
6e790
[  130.299907]  </TASK>
[  130.299907] Modules linked in: cxl_mem cxl_pmem cxl_port cxl_pci(-) cxl_=
acpi cxl_core dax_pmem nd_pmem nd_btt [last unloaded: cxl_core]
[  130.299907] CR2: 0000000000000008
[  130.357813] ---[ end trace 0000000000000000 ]---
[  130.358811] RIP: 0010:__cxl_dpa_release+0x3c/0xb0 [cxl_core]
[  130.360039] Code: ff ff 48 8b 7d 40 4c 8b a8 d8 02 00 00 e8 5c a6 ff ff =
4c 8b a5 28 03 00 00 48 89 c3 48 8b 85 20 03 00 00 4d 8b ad 40 03 00 00 <48=
> 8b 50 08 4c 8b 30 49 81 c5 90 00 00 00 4c 89 ef 48 83 c2 01 4c
[  130.363227] RSP: 0018:ffffc9000075fae0 EFLAGS: 00000246
[  130.364292] RAX: 0000000000000000 RBX: ffff88810250cc00 RCX: 00000000000=
00000
[  130.365400] RDX: 0000000000000001 RSI: ffff8881008d25e8 RDI: ffff8881025=
0cc00
[  130.366645] RBP: ffff88810250d000 R08: 0000000000000001 R09: ffffffff818=
2b400
[  130.368025] R10: ffff888101fd7238 R11: ffff888201c1f406 R12: 00000000000=
00000
[  130.369337] R13: 0000000000000000 R14: ffff88810250ce90 R15: ffff8881025=
0ce8c
[  130.370531] FS:  00007f53b3884c40(0000) GS:ffff888277d40000(0000) knlGS:=
0000000000000000
[  130.372515] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  130.373567] CR2: 0000000000000008 CR3: 000000010285c000 CR4: 00000000000=
006e0

>=20
> >=20
> > The patch fixed the above issue, and is tested based on follow patch se=
ries:
> >=20
> > [PATCH 00/18] CXL RAM and the 'Soft Reserved' =3D> 'System RAM' default
> > Message-ID: 167601992097.1924368.18291887895351917895.stgit@dwillia2-xf=
h.jf.intel.com
> >=20
> > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> > ---
> >  drivers/cxl/core/hdm.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index 80eccae6ba9e..6cf854c949f0 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -695,6 +695,7 @@ static int init_hdm_decoder(struct cxl_port *port, =
struct cxl_decoder *cxld,
> >  	struct cxl_endpoint_decoder *cxled =3D NULL;
> >  	u64 size, base, skip, dpa_size;
> >  	bool committed;
> > +	bool should_commit;
> >  	u32 remainder;
> >  	int i, rc;
> >  	u32 ctrl;
> > @@ -710,10 +711,11 @@ static int init_hdm_decoder(struct cxl_port *port=
, struct cxl_decoder *cxld,
> >  	base =3D ioread64_hi_lo(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(which)=
);
> >  	size =3D ioread64_hi_lo(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(which)=
);
> >  	committed =3D !!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED);
> > +	should_commit =3D !!(ctrl & CXL_HDM_DECODER0_CTRL_COMMIT);
>=20
> This change looks like a good idea in general given the ambiguity of
> 'committed'. However just combine the two checks into the @committed
> variable with something like this:
>=20
> commit_mask =3D CXL_HDM_DECODER0_CTRL_COMMITTED|CXL_HDM_DECODER0_CTRL_COM=
MIT;
> committed =3D (ctrl & commit_mask) =3D=3D commit_mask;=
