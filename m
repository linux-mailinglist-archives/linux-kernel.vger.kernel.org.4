Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8716FEFFE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 12:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237745AbjEKKgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 06:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjEKKgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 06:36:44 -0400
Received: from bee.tesarici.cz (bee.tesarici.cz [IPv6:2a03:3b40:fe:2d4::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8941D2;
        Thu, 11 May 2023 03:36:41 -0700 (PDT)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id B71DB1595D1;
        Thu, 11 May 2023 12:36:38 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1683801399; bh=56/JMFS+y5+CL0epGr/j+rgw0VuJ8cbzk2SU58O1JvY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0BHwBStv5OjKVHlW+V+xEk83k2yG4uBHsF/ilA8hjkkAZ2+xWGZuvq7yXChlnSsQ/
         vkg+2FgTIizvKFk8fiYtSIQmtFvDQa27jGXi6MRaQbKwgPqEv7BreWlqS16s2La/yo
         dHRa/Ov4etWgJ4M/KJ12Ehz776rYZwYs7TUHbI9nbuSG8iWSJQjeitND5atJVAgpPh
         MibcahQ0DMPohWnsYlSwt/V3d+3M2xO/HJlLAKCeVSVVQK+a1ZffycgxH6VmDhrBGv
         u7pUIGEmwPs+E0LGUfiW2nerpG6eumk+X+b1ee6ADXXP8Ft+v5bpcQn5cvA7rxn18k
         RwB+DRtbM9xjA==
Date:   Thu, 11 May 2023 12:36:36 +0200
From:   Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To:     Juerg Haefliger <juergh@proton.me>
Cc:     Petr Tesarik <petrtesarik@huaweicloud.com>,
        Christoph Hellwig <hch@lst.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Kim Phillips <kim.phillips@amd.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Alexander Graf <graf@amazon.com>
Subject: Re: [RFC v1 3/4] swiotlb: Allow dynamic allocation of bounce
 buffers
Message-ID: <20230511123636.168eb62f@meshulam.tesarici.cz>
In-Reply-To: <20230406134440.72959135@gollum>
References: <4268fa4e-4f0f-a2f6-a2a5-5b78ca4a073d@huaweicloud.com>
        <20230331092553.677e9649@smeagol>
        <20230331110043.7b1ddfa3@meshulam.tesarici.cz>
        <20230406134440.72959135@gollum>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-suse-linux-gnu)
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

On Thu, 06 Apr 2023 11:44:55 +0000
Juerg Haefliger <juergh@proton.me> wrote:

> On Fri, 31 Mar 2023 11:00:43 +0200
> Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz> wrote:
>=20
> > Hi Juerg,
> >
> > On Fri, 31 Mar 2023 07:26:09 +0000
> > Juerg Haefliger <juergh@proton.me> wrote:
> > =20
> > > On Tue, 28 Mar 2023 09:54:35 +0200
> > > Petr Tesarik <petrtesarik@huaweicloud.com> wrote:
> > >
> > >[...] =20
> > > > Anyway, I suspected that the buffers need not be imported into the =
vc4
> > > > driver (also hinted by Eric Anholt in a 2018 blog post [1]), and it
> > > > seems I was right. I encountered the issue with Ubuntu 22.10; I
> > > > installed latest openSUSE Tumbleweed yesterday, and I was not able =
to
> > > > reproduce the issue there, most likely because the Mesa drivers have
> > > > been fixed meanwhile. This makes the specific case of the Raspberry=
 Pi 4
> > > > drivers moot. The issue may still affect other combinations of driv=
ers,
> > > > but I don't have any other real-world example ATM. =20
> > >
> > > I'm only seeing this problem with Wayland, no issue when switching Ub=
untu to
> > > X. It seems Tumbleweed is using X by default. =20
> >
> > I know; I was the team lead of SUSE low-level graphics engineers until
> > end of last year... I have just double-checked, but this output of
> > wayland-info in the GNOME session accessed over RDP is quite convincing=
: =20
>=20
> It sure is but how did you get that??

I'm sorry for late reply.

Yes, the default is GNOME on X.org, but you can change it on the GDM
login screen. After choosing your account, a settings gear icon appears
in the lower right corner. Click on it and choose GNOME. That starts a
Wayland session.

HTH
Petr T
