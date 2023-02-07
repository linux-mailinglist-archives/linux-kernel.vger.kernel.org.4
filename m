Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464B868CD6F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 04:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjBGD1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 22:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjBGD1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 22:27:44 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA3D1CF4F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 19:27:43 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id y8so14969294vsq.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 19:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZ/mrmJlqmnVt82aHOUrWzMk7/Vts23//ynlk42Gb2I=;
        b=7rY8scGPrJj8K6pOW2C5C3iG5ShGX3vJTHKEdLzsAGPO/6c5ieHmS08cJfrY69DghV
         YTFukr8S5+OKKqG8cgX4QKv6rvj1h25IpJX76xsaUquQjWEXBkpbSqqrRA3UL5vID5ii
         jgcpz+n4eE2sSs50Sz4sZEDenoL4Vshpy1itv1EXdNyCerFmFkBlU9wJyU+IqDvaSaeu
         hmr7babtRG5CP1bslOOuEi5yQ87GcSbEtlFj/Zi2xbP/DEZ5an4L/7ZNjoDYBdHknCN+
         WJGeP/cY3HgMGhtPDMIDpKIeASkcTbE2bXxi0+rg38SQz6PXSXTvtGHt7tnR1hdB0q4A
         4N9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fZ/mrmJlqmnVt82aHOUrWzMk7/Vts23//ynlk42Gb2I=;
        b=kGPi1tibzXPdY0oSMR7Krcl+Zyv1pWtytBIVbYGqPq+J4KAH0+iAf59YKfzTTivqQS
         m/yK28+g0gQBo38HfD8DIS872VCdbW1kfppDyvzrpFpGgojfXOFJ9BygqBGo9JEtXH6E
         KkzDDDJrsQfJZb3RtpHIjKYN0JTR0f0r+aHZjkQ5HHy6oexP8lM1LmgXzpTR3TSNysdQ
         AJcTsVQ5y2fr0UO6zKFb7IE6vtF+slXrCr+sQU7VgsUJBPEk0j71ntAhl0ml8nlzhKM7
         FU8LNahkbM1LkPIoiXCA89K5cKH+pqfziJEaBo8Eoo2uYZoOUCGtE1pjb5txPcXcnZcy
         +Ovg==
X-Gm-Message-State: AO0yUKX0yZ2jvEeNXKc6aTJIe0suSUDrvb9QBYDF48reuXS5H6VmUg+z
        xgHzKzJv05AreecS6ivxmrCtBmMNYCHnhx5JZfg1kQ==
X-Google-Smtp-Source: AK7set8vwQTyyrw2mI6WSHOv5KfVg0pjlIbtoO3lTtGG3+xS+VgMzPaWdvEqTn/k4uJjeQkGRY25cG5rzBswGSoyWbs=
X-Received: by 2002:a67:e10e:0:b0:3d3:d797:33c3 with SMTP id
 d14-20020a67e10e000000b003d3d79733c3mr385421vsl.51.1675740462297; Mon, 06 Feb
 2023 19:27:42 -0800 (PST)
MIME-Version: 1.0
References: <20230203100418.2981144-1-mie@igel.co.jp> <HE1PR0401MB2331582DC0401DFA4EB5540C88D79@HE1PR0401MB2331.eurprd04.prod.outlook.com>
 <CANXvt5pCnC=7DaPkFi4v1WUbzrgETVL03aAi=aq-uBFFxqhTyA@mail.gmail.com>
In-Reply-To: <CANXvt5pCnC=7DaPkFi4v1WUbzrgETVL03aAi=aq-uBFFxqhTyA@mail.gmail.com>
From:   Shunsuke Mie <mie@igel.co.jp>
Date:   Tue, 7 Feb 2023 12:27:31 +0900
Message-ID: <CANXvt5p5DvOpqZui9ogv+tHiE4yJUeNnuQHi+=2-MypacQZ5DA@mail.gmail.com>
Subject: Re: [EXT] [RFC PATCH 0/4] PCI: endpoint: Introduce a virtio-net EP function
To:     Frank Li <frank.li@nxp.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, Jon Mason <jdmason@kudzu.us>,
        Ren Zhijie <renzhijie2@huawei.com>,
        Takanari Hayama <taki@igel.co.jp>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023=E5=B9=B42=E6=9C=887=E6=97=A5(=E7=81=AB) 10:43 Shunsuke Mie <mie@igel.c=
o.jp>:
>
> 2023=E5=B9=B42=E6=9C=884=E6=97=A5(=E5=9C=9F) 6:48 Frank Li <frank.li@nxp.=
com>:
> >
> > > foundation.org
> > > Subject: [EXT] [RFC PATCH 0/4] PCI: endpoint: Introduce a virtio-net =
EP
> > > function
> > >
> >
> > The dependent EDMA patch can't be applied at last linux-next.
> > Can you provide a git link? So I can try directly.
> Sorry, I've missed it. The embedded DMA's patchset is
> https://lore.kernel.org/linux-pci/20230113171409.30470-1-Sergey.Semin@bai=
kalelectronics.ru/
> and, merged to a pci/dwc branch on kernel/git/lpieralisi/pci.git . The
> link is here:
> https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/commit=
/?h=3Dpci/dwc
In addition, the patches are merged into next-20230131 .
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tag/?h=
=3Dnext-20230131

> I'll add the information to a cover letter from the next submission.
> > Frank
> >
> > >
> > > About this patchset has 4 patches. The first of two patch is little c=
hanges
> > > to virtio. The third patch add APIs to easily access virtio data stru=
cture
> > > on PCIe Host side memory. The last one introduce a virtio-net EP devi=
ce
> > > function. Details are in commit respectively.
> > >
> >
> Best,
> Shunsuke
