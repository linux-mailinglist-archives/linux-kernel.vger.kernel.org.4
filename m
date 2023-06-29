Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182BD741FFE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 07:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbjF2FoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 01:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjF2FoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 01:44:15 -0400
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BAF1FFA
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 22:44:13 -0700 (PDT)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id 11B21A86A6;
        Thu, 29 Jun 2023 07:44:08 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1688017448; bh=xborO1tvc0dRlfOjqwkAahe+gIZdli89mzQdaRUY4+k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zzA1cdGy/BGa6y89Fb2F6tVA9FyQRiR8PiFVAKF+6Bkaj9PlU8hfbCMY5lag5cQhq
         DThqOsVWFqdALnjYG9M7oZJddKgCHMEnyaIxF6gjTdiARYBMUqcTv6t8+dXTBgqqGd
         XB9hgux865KF/nk6LSqMvA2KEEOu+pscMKKmK/4OuyJfqgb1UfeU1WCp8/c88FyVB5
         FDtfcQgYTh1tHTnr8B54ZbehNWHo8821acpMNQa3sik07IoAhB8UVkOFUvreLALdnE
         gEPATXGEaGqoWl2nK6DC43m1R4uiYbEBPEd3prk4QZw36G2DfLxq86vitOosUBS/Cq
         02fxVaIIRaeXw==
Date:   Thu, 29 Jun 2023 07:44:03 +0200
From:   Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Petr Tesarik <petrtesarik@huaweicloud.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v1 0/2] swiotlb: Fix a couple of bugs in sizing areas
Message-ID: <20230629074403.7f8ed9d6@meshulam.tesarici.cz>
In-Reply-To: <20230629051238.GB16654@lst.de>
References: <cover.1687784289.git.petr.tesarik.ext@huawei.com>
        <20230626160725.5164ca74@meshulam.tesarici.cz>
        <20230629051238.GB16654@lst.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2023 07:12:38 +0200
Christoph Hellwig <hch@lst.de> wrote:

> On Mon, Jun 26, 2023 at 04:07:25PM +0200, Petr Tesa=C5=99=C3=ADk wrote:
> > As an aside (and not directly related to the bugfixes themselves), I
> > wonder why the area size cannot be always equal to IO_TLB_SEGSIZE. Of
> > course, we would (usually) end up with more areas, but that should be
> > a good thing, shouldn't it? The area structure is quite small, so it
> > cannot be because of memory consumption concerns. The overhead of
> > taking an uncontended spinlock should also be negligible. =20
>=20
> What would be the benefit of this?

For me, as a newcomer to this code, the existence of areas _and_
segments was confusing, especially since segments are not represented by
a data structure. It took me more than one day to realize that slots
are grouped into segments for allocation, but changes to the slot
metadata are protected by area spinlocks. In my case, a segment crossed
an area boundary, so the area spinlock protected only half of the
allocated slots.

I could also ask differently: What is the benefit of grouping slots
into segments, and then again grouping segments into areas?

Petr T
