Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94D974F007
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 15:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbjGKNV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 09:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjGKNVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 09:21:54 -0400
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35860B1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 06:21:53 -0700 (PDT)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id 99EEA1493F2;
        Tue, 11 Jul 2023 15:21:49 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1689081709; bh=FbmvmuBgtrerOFIBhYR5FxcE9YytPiDxS97CDx6aAfU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nuyCUha/ZmQg8eB5jvQE6d2q8mSJ0BrgzdV+U7hfnbc+pGnRULamyF6B3Wpny6UCW
         M8IYvKWVLtXr2J6iEMkxrZwo+m94LLtOhU6KCifOUHQ3W6m49OeaDd6qEwHpFKU5K1
         bumSB28E/gKf4ndyUG5z4WHXxoscQto2K4Vkh3/fxoTFPH9jMkGK7utaICG/AMmtAN
         lzaxhA+dBcBbkZ6c5sIjFQFvcSEayuhmR+kDX4rvkwpXphgt6iSG2cBppjoWNO4wdG
         bUWXzcKsDAYTlje7c3xizq8tO0LSeMjkLzZV2eSPQpGaC6W1ylzDxrgOPUX00A7woN
         iYra/4+6V+dqA==
Date:   Tue, 11 Jul 2023 15:21:45 +0200
From:   Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To:     Mike Lothian <mike@fireburn.co.uk>
Cc:     Roberto Sassu <roberto.sassu@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
        Petr Tesarik <petrtesarik@huaweicloud.com>,
        open list <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 0/7] Allow dynamic allocation of software IO TLB
 bounce buffers
Message-ID: <20230711152145.7372af4a@meshulam.tesarici.cz>
In-Reply-To: <CAHbf0-FjiOAMHjh-7D_6gvS+oHr2tGKJArnYu=0AKYHbD8Ntrw@mail.gmail.com>
References: <cover.1681898595.git.petr.tesarik.ext@huawei.com>
        <20230426141520.0caf4386@meshulam.tesarici.cz>
        <2023042617-wobble-enlighten-9361@gregkh>
        <20230426144439.5674f8bc@meshulam.tesarici.cz>
        <20230509091635.27450bd9@meshulam.tesarici.cz>
        <2023050949-grueling-verify-a43b@gregkh>
        <CAHbf0-HY0-u4MwgU39b53hjOM+bWfGmOEYQuvHARjV+6j+O7Kg@mail.gmail.com>
        <20230711110325.2521472c@meshulam.tesarici.cz>
        <CAHbf0-FjiOAMHjh-7D_6gvS+oHr2tGKJArnYu=0AKYHbD8Ntrw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jul 2023 12:29:44 +0100
Mike Lothian <mike@fireburn.co.uk> wrote:

> On Tue, 11 Jul 2023 at 10:03, Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz> w=
rote:
> >
> > On Mon, 10 Jul 2023 23:23:45 +0100
> > Mike Lothian <mike@fireburn.co.uk> wrote:
> > =20
> > > Hi
> > >
> > > I was hoping this might land for 6.5-rc1, is there a new version that
> > > might apply against 6.5? =20
> >
> > Yes, there is a v3, which is a complete rewrite based on feedback from
> > various people on this mailing list:
> >
> > https://lore.kernel.org/linux-iommu/cover.1687859323.git.petr.tesarik.e=
xt@huawei.com/T/
> >
> > Petr T
> > =20
>=20
>=20
> Patch 2 doesn't apply cleanly for me on 6.5-rc1

Ah, right. I'm going to rebase the series and include a few other
suggested changes.

I'm a bit worried that Christoph and all other maintainers (all taken
back into Cc) have stayed silent about the v3 series.

@Christoph: Are uncomfortable with something in the idea itself, or are
you just busy with other things?

Petr T
