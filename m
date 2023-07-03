Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB79745D0E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 15:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjGCNXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 09:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjGCNXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 09:23:49 -0400
Received: from bee.tesarici.cz (bee.tesarici.cz [IPv6:2a03:3b40:fe:2d4::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F70E6C;
        Mon,  3 Jul 2023 06:23:42 -0700 (PDT)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id 7BEB3ACFEE;
        Mon,  3 Jul 2023 15:23:39 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1688390619; bh=CcakWLV2/CnUPYuB5QwvAIuhCgWmDptbC9yZXabw76o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tk7eVobtoFgFKeR+n58SGbPeSIh81DkvxJNdLR0b0vnvGZ/L1WcU0di3AcQtPDS60
         sZmQHro9woNZpitfi5qUpYWhOOL5X9myAiFLccIvA/8ZI8LC0tDs3RkxmfuYH865ku
         2DOTudWgdX/x1eqpCZSz8HqSQuUnWgsMETZhXIeOTFXa0FS8A0Cm22fpwWsg6HZI3c
         64dqlSoxzQLp5GvPbVRCtbd9ao+4pki1zA5L3pKl7asEX6vw6groIy4Q3MRa+Hp10y
         C5YdrzbcZmR2vErfa6Y3LH3rRms0cwq+sOMwtS02FmiK6JzseAHtV0YvBftR/msYaB
         qQOnN2QDp24Ug==
Date:   Mon, 3 Jul 2023 15:23:36 +0200
From:   Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To:     Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "open list:SUPERH" <linux-sh@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: arch/superh: Suspicious coherent DMA allocations for CEU video
 buffers
Message-ID: <20230703152336.43c5d129@meshulam.tesarici.cz>
In-Reply-To: <6hbvbciyyx7wcuwzhgaczqearmu2mu3h2u447mljbp24emtjaz@ciel5ezmehfq>
References: <20230629151124.34e72817@meshulam.tesarici.cz>
        <6hbvbciyyx7wcuwzhgaczqearmu2mu3h2u447mljbp24emtjaz@ciel5ezmehfq>
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

Hi Jacopo,

On Mon, 3 Jul 2023 00:32:54 +0200
Jacopo Mondi <jacopo.mondi@ideasonboard.com> wrote:

> Hi Petr,
>=20
> On Thu, Jun 29, 2023 at 03:11:24PM +0200, Petr Tesa=C5=99=C3=ADk wrote:
> > Hi Jacopo,
> >
> > I've just noticed a few calls to dma_declare_coherent_memory() which
> > look suspicious to me, all authored by you:
> >
> > - arch/sh/boards/mach-ap325rxa/setup.c
> > - arch/sh/boards/mach-ecovec24/setup.c
> > - arch/sh/boards/mach-kfr2r09/setup.c
> > - arch/sh/boards/mach-migor/setup.c
> > - arch/sh/boards/mach-se/7724/setup.c
> >
> > In these files, the last argument to dma_declare_coherent_memory()
> > looks like the last address to be used, but the expected value should
> > be the size of the reserved region, e.g.:
> >
> > 	dma_declare_coherent_memory(&ap325rxa_ceu_device.dev,
> > 			ceu_dma_membase, ceu_dma_membase,
> > 			ceu_dma_membase + CEU_BUFFER_MEMORY_SIZE - 1);
> >
> > Do you (or anyone else on Cc) agree that this is a braino, and all these
> > boards should actually use CEU_BUFFER_MEMORY_SIZE as the size of their
> > DMA pools rather than membase + CEU_BUFFER_MEMORY_SIZE - 1?
> > =20
>=20
> Thanks for spotting this.. I tried to track down where this comes from
> digging out the CEU and the platform file from 4.16, but it seems this
> simply is a brain fart from my side.
>=20
> I presume this is very much dead code, as the commit message of
> 39fb993038e1 ("media: arch: sh: ap325rxa: Use new renesas-ceu camera
> driver") says: "Compile tested only." and nobody has ever reported
> bugs.
>=20
> Feel free to send patches and cc me, as long as this code is around
> it's nice to have it correct at least.

Thank you for confirmation. I'll do that.

> Thank you!
>    j
>=20
> PS: if you ask me, as nobody clearly run this code in the last 5
> years, I would simply drop all these platform files. But that's
> maintainers' call.

Since the beginning of the coherent region is declared correctly, it is
possible that it just happens to work, merely unreliably, frustrating
users with occasional freezes/crashes which may not be easily linked
with the CEU camera.

OTOH it is much more likely that this code is simply dead.

Petr T
