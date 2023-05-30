Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE983716756
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 17:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbjE3PnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 11:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjE3PnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 11:43:01 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F5FE8
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 08:42:58 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230530154255euoutp0255e0aae17554e1802ef9503fd3bf1560~j9jDNP1uU2029120291euoutp02e
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 15:42:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230530154255euoutp0255e0aae17554e1802ef9503fd3bf1560~j9jDNP1uU2029120291euoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1685461375;
        bh=D9MPo121aL3nelbzhH23xAd4Mz9EDrpVEVg/G1e/LMQ=;
        h=From:To:CC:Subject:Date:References:From;
        b=cJZ3hVfYfSwPIYTYK4Y2mCnPRcJrrfnslK6s6q/cmX1JUx+OhcunqEDJ1T7YU63vz
         b5PE6i7vH4E1Iq8kli+d4Hu9oQ3cEXEwMykig4M+AKsoWN1JGRshZH/DjS8h3wdvWT
         2lgALWOzInimbzb7ziVKJa77mdRdeU8XnWIXzxmw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230530154254eucas1p133f90b81c280e9e7ce3f0cf952804012~j9jCyYxPu3188231882eucas1p1B;
        Tue, 30 May 2023 15:42:54 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id F5.CC.42423.E7916746; Tue, 30
        May 2023 16:42:54 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230530154254eucas1p241e57af99e4d4ee0e1a677904c3db68c~j9jCWB2xe1135211352eucas1p2e;
        Tue, 30 May 2023 15:42:54 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230530154254eusmtrp17d93ad1d405acff837c26834be3e08c4~j9jCQ1hXQ0860208602eusmtrp1w;
        Tue, 30 May 2023 15:42:53 +0000 (GMT)
X-AuditID: cbfec7f2-a51ff7000002a5b7-18-6476197e63d7
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 5B.ED.14344.D7916746; Tue, 30
        May 2023 16:42:53 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230530154253eusmtip13334881a5a0c7a3df7e8828dfe3195fe~j9jCAD65c0893008930eusmtip1s;
        Tue, 30 May 2023 15:42:53 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
        Server (TLS) id 15.0.1497.2; Tue, 30 May 2023 16:42:53 +0100
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
        ([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Tue, 30 May
        2023 16:42:53 +0100
From:   Daniel Gomez <da.gomez@samsung.com>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        "Christoph Hellwig" <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
CC:     Pankaj Raghav <p.raghav@samsung.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        Daniel Gomez <da.gomez@samsung.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] nvme: Increase block size variable size to 32-bit
Thread-Topic: [PATCH] nvme: Increase block size variable size to 32-bit
Thread-Index: AQHZkw1l1o9oL0yVTkSu68uk9vZQvw==
Date:   Tue, 30 May 2023 15:42:53 +0000
Message-ID: <20230530154231.8313-1-da.gomez@samsung.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [106.210.248.108]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+3aOZ8fF4nNKvq0bLbqotZIKTxejKw0qukoXiFzuYNGcsuOW
        RpRCWJlgmSkercyWOS0ru9kWRoYuLXNl5bKUNJem1ErtD1tqbsfC/37f+7zv8z68fDQhM/nI
        6QO6eFavU2sVlIS8X91fP/foBKNmvvXqVKakOZ1izCVVIiaj8h1iGix5FHOp0ClmHGeciCnt
        dpErxKr6ltukqqHOoCorPkWp7piOqazvkyhVb9mUzdRuyTINqz1gZPXzlkdK9nd86EBxLknC
        n+99Pkmon05FvjTghZBSbCVTkYSW4SIEra9tYo8gw30IPvGJgtCLwJSSKvo34XL/oQThGoKs
        upvU/y576x1KGH+BwNUZIghmBF+Gnnp9KRwEFTVlYo8QgE8gqHZ/9D4IPIjA3ZtGerr88SrI
        sn9FHg7A68DhfOYjsBJyat3eOolnwKf0i8OhaFqKGeBPSz1lhCdDX3IJ4WECB0JT+6WR3H5Q
        kPuIEHg8DFpaKYHnQF1jOxJ4Pty7WkEKPB2cRU1iwUcJjvOZlMAhUHi52+sjHfasyWn3Xg/w
        A1+wF7cQnjyA10CracTTH7psd8UCT4Ln59JG/KPBVMqTZ1AwPyoqP2odP2odP2pdPiKLUSBr
        4GKiWS5Uxx5ScuoYzqCLVkbFxpSh4Y/0fNDWU44udP1UViIRjSoR0IQiQBqu5jQyqUadeJjV
        x+7VG7QsV4km0qQiUBoSXhMlw9HqePYgy8ax+n+qiPaVJ4ki4xoe5U+PjDh5xLhRW/9qiZ2r
        GuJXdhxbI7XpiB/pYbb4BW2HruT/MnZapi6d2WxtoprTGm01tpRdPXEfwqEv63hYSIQm/Y3W
        WOTvaJv24ktsf9DnsT1bCujHFrOtNnHPenogw0wbnQkJ18tPMqG7Vq6Vm030acfiATKsd8ae
        zL2hBR2TmzSOG7lZmiuOoJ/JTNfEhziixeQ3a8Nso8W+aOsAfTZ/k+kJ0/35+JxE17ZxzAl5
        4RaJ5Hey3/12nwWrrcH7ds6+MdjQuH2Mb1UgX5HdWZW5uVbxbSgh5qWzfF1b6YaMCd1pOcvf
        zsrOPXf58IpfeTtwttUudxu2lt5yK0huvzo0mNBz6r+d6xSKtwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileLIzCtJLcpLzFFi42I5/e/4Xd1aybIUg8bTJhar7/azWaxcfZTJ
        YtKha4wWl3fNYbOYv+wpu8WNCU8ZLda9fs/iwO5x/t5GFo/LZ0s9Nq3qZPPYvKTeY/fNBjaP
        z5vkAtii9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S
        9DK2tr5hKXjIVXH6/yHWBsbXHF2MnBwSAiYS73//Yeti5OIQEljKKLFh3S9WiISMxMYvV6Fs
        YYk/17qgij4yShx5dYoVwjnDKPFw7i0WCGclo8TMqd+YQFrYBDQl9p3cxA6SEBFoZ5S4sWQ6
        WBWzwD9Gid+fe1hAqoQFnCSmXXjJCGKLCLhL3Hh6ghXC1pOYeeo3WJxFQFXiQf88oKkcHLwC
        FhKzunlBwowCshJfGlczg9jMAuISt57MZ4K4VUBiyZ7zzBC2qMTLx/+gftCROHv9CSOEbSCx
        dek+FghbWeLpilvsEHP0JG5MncIGYWtLLFv4GmwOr4CgxMmZT1gmMErOQrJuFpKWWUhaZiFp
        WcDIsopRJLW0ODc9t9hIrzgxt7g0L10vOT93EyMwUWw79nPLDsaVrz7qHWJk4mA8xCjBwawk
        wmubWJwixJuSWFmVWpQfX1Sak1p8iNEUGBQTmaVEk/OBqSqvJN7QzMDU0MTM0sDU0sxYSZzX
        s6AjUUggPbEkNTs1tSC1CKaPiYNTqoFJpDdztu9L73ON/1fdvzqx5O6kF7ss1sip+z40qHeT
        2b4kjE9t76/LgdlXVHfsmHZL98v1Jw+mu8zik1cQ/iRd8mlSnJ08c4ZY+lf7HeH6lxd9fdqh
        zN66PUjD4deMaysieGTNF2a8ZJNqLLM9s8z0VLnFlL43XC/eHPaZa3z1zQGJP19K0xo363gI
        ih040xA8UVuBMazz/D9Ved+rs60Zvl46u9AtSuh87bUvwmrrBV9nOrFazdp3plEs48hB++up
        v2367Pb/1FVbcuCn6iOVbwcMjj222WO928Eret9a6W8nT715eEbpcqaeWN2zpGcvjX9v1GBI
        SF+87FjnNdvu2tsH1pzhqr6knvjlJkvifiWW4oxEQy3mouJEAK5chmGdAwAA
X-CMS-MailID: 20230530154254eucas1p241e57af99e4d4ee0e1a677904c3db68c
X-Msg-Generator: CA
X-RootMTR: 20230530154254eucas1p241e57af99e4d4ee0e1a677904c3db68c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230530154254eucas1p241e57af99e4d4ee0e1a677904c3db68c
References: <CGME20230530154254eucas1p241e57af99e4d4ee0e1a677904c3db68c@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Increase block size variable size to 32-bit unsigned to be able to
support block devices larger than 32k (starting from 64 KiB).

Physical and logical block size already support unsigned 32-bit.

Signed-off-by: Daniel Gomez <da.gomez=40samsung.com>
---

While experimenting and doing code inspection for large block
devices, we found a limitation of a 32 KiB block size due to the bs
variable type. With that limitation and in combination with a large
block device, this results in a kernel BUG when the block layer
attempts to split a block size of 0 bytes.

Increasing the value to 32-bit unsigned, allows to support large block
devices starting from 64 KiB. In addition, this bs variable type
aligns with the queue_limits logical/physical_block_size types.


 drivers/nvme/host/core.c =7C 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 151b23400ada..b4bc48f2a011 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
=40=40 -1835,7 +1835,7 =40=40 static void nvme_update_disk_info(struct gend=
isk *disk,
 		struct nvme_ns *ns, struct nvme_id_ns *id)
 =7B
 	sector_t capacity =3D nvme_lba_to_sect(ns, le64_to_cpu(id->nsze));
-	unsigned short bs =3D 1 << ns->lba_shift;
+	u32 bs =3D 1 << ns->lba_shift;
 	u32 atomic_bs, phys_bs, io_opt =3D 0;

 	/*
--
2.40.1
