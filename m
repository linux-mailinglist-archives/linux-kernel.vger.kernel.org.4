Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B388D6D73CA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 07:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236837AbjDEFch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 01:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjDEFcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 01:32:35 -0400
X-Greylist: delayed 3095 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 04 Apr 2023 22:32:16 PDT
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FAD4687;
        Tue,  4 Apr 2023 22:32:16 -0700 (PDT)
Received: from meshulam.tesarici.cz (unknown [213.235.133.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id 97B1514614C;
        Wed,  5 Apr 2023 07:32:09 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1680672732; bh=M7BqF4q1DGKNEjYZ3lzk2n7CurEhUj9DafNcr+qFq18=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NvyFunD+VqtpwwF571UYeVEGFU/zlckk9s0iV1zYL8sBqPoIE5nOwswAAqtBzVAlL
         VDVRZ+3mV+KSEogELpMd2gxgHePoqy1n341w8v0CHcVBPJBdy7/tNSPtbfyf5fHeWA
         9zHRwxXekZKGOjQw3Zs0B5Gf0gUl+Bc0124JYVgtppxyjB/xdzbSKn3sAv5s6hbpBm
         Jls4nHMj3ElZfGUzfuPzG/8USS10TBueBH9EXMSh3cj16VWHpxd3AJfXGwhgJI+Qn8
         NK4JqxVsM1uJArs71Ao4LZ3zPpeIbp6ImEeJLmuFd4DGUqtM8g4E7JUMIQ/N89EZAa
         kTK8/TQXAa4IA==
Date:   Wed, 5 Apr 2023 07:32:06 +0200
From:   Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     Dexuan-Linux Cui <dexuan.linux@gmail.com>,
        Petr Tesarik <petrtesarik@huaweicloud.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jianxiong Gao <jxgao@google.com>,
        David Stevens <stevensd@chromium.org>,
        Joerg Roedel <jroedel@suse.de>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] swiotlb: Fix slot alignment checks
Message-ID: <20230405072801.05bb94ef@meshulam.tesarici.cz>
In-Reply-To: <SA1PR21MB1335C5F774195F2C3431BF93BF909@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <cover.1679382779.git.petr.tesarik.ext@huawei.com>
        <c90887e4d75344abe219cc5e12f7c6dab980cfce.1679382779.git.petr.tesarik.ext@huawei.com>
        <CAA42JLa1y9jJ7BgQvXeUYQh-K2mDNHd2BYZ4iZUz33r5zY7oAQ@mail.gmail.com>
        <CO1PR21MB13320305E02BA121623213DABF939@CO1PR21MB1332.namprd21.prod.outlook.com>
        <20230405064019.6258ebb3@meshulam.tesarici.cz>
        <SA1PR21MB1335C5F774195F2C3431BF93BF909@SA1PR21MB1335.namprd21.prod.outlook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=3.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Apr 2023 05:11:42 +0000
Dexuan Cui <decui@microsoft.com> wrote:

> > From: Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz>
> > Sent: Tuesday, April 4, 2023 9:40 PM =20
> > > > ...
> > > > Hi Petr, this patch has gone into the mainline:
> > > > 0eee5ae10256 ("swiotlb: fix slot alignment checks")
> > > >
> > > > Somehow it breaks Linux VMs on Hyper-V: a regular VM with
> > > > swiotlb=3Dforce or a confidential VM (which uses swiotlb) fails to =
boot.
> > > > If I revert this patch, everythidiff --git a/kernel/dma/swiotlb.c b=
/kernel/dma/swiotlb.c
index 5b919ef832b6..8d87cb69769b 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -639,8 +639,8 @@ static int swiotlb_do_find_slots(struct device *dev, in=
t area_index,
 	 * allocations.
 	 */
 	if (alloc_size >=3D PAGE_SIZE)
-		iotlb_align_mask &=3D PAGE_MASK;
-	iotlb_align_mask &=3D alloc_align_mask;
+		iotlb_align_mask |=3D ~PAGE_MASK;
+	iotlb_align_mask |=3D alloc_align_mask;
=20
 	/*
 	 * For mappings with an alignment requirement don't bother looping to
ng works fine. =20
> > >
> > > The log is pasted below. Looks like the SCSI driver hv_storvsc fails =
to
> > > detect the disk capacity: =20
> >=20
> > The first thing I can imagine is that there are in fact no (free) slots
> > in the SWIOTLB which match the alignment constraints, so the map
> > operation fails. However, this would result in a "swiotlb buffer is
> > full" message in the log, and I can see no such message in the log
> > excerpt you have posted.
> >=20
> > Please, can you check if there are any "swiotlb" messages preceding the
> > first error message?
> >=20
> > Petr T =20
>=20
> There is no "swiotlb buffer is full" error.
>=20
> The hv_storvsc driver (drivers/scsi/storvsc_drv.c) calls scsi_dma_map(),
> which doesn't return -ENOMEM when the failure happens.

I see...

Argh, you're right. This is a braino. The alignment mask is in fact an
INVERTED mask, i.e. it masks off bits that are not relevant for the
alignment. The more strict alignment needed the more bits must be set,
so the individual alignment constraints must be combined with an OR
instead of an AND.

Can you apply the following change and check if it fixes the issue?

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 5b919ef832b6..8d87cb69769b 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -639,8 +639,8 @@ static int swiotlb_do_find_slots(struct device *dev, in=
t area_index,
 	 * allocations.
 	 */
 	if (alloc_size >=3D PAGE_SIZE)
-		iotlb_align_mask &=3D PAGE_MASK;
-	iotlb_align_mask &=3D alloc_align_mask;
+		iotlb_align_mask |=3D ~PAGE_MASK;
+	iotlb_align_mask |=3D alloc_align_mask;
=20
 	/*
 	 * For mappings with an alignment requirement don't bother looping to


Petr T
