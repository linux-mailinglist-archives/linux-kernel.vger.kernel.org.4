Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E429B6EF54F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 15:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241029AbjDZNQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 09:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241122AbjDZNQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 09:16:17 -0400
X-Greylist: delayed 3645 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 26 Apr 2023 06:16:14 PDT
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F1765B3;
        Wed, 26 Apr 2023 06:16:13 -0700 (PDT)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id 51497164FAB;
        Wed, 26 Apr 2023 15:16:10 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1682514970; bh=ySihG43IoB4tpWhlx7AVZWC9Dx5jlOj4dyXUyipMA7Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Iu7UL+tAHg2VEC+RL5h27qD/fNQUAKbT7kgcZZf1g497AeyfPIPaGhhRtpEslQbb3
         6kxX27a/K4P+3Knn/iGYBK84Y7BITpnKqlS+mxanOplxfWK6trlORAISOUDAnsPfYi
         ZMYwi7x/I0iH+jtQLXcwkBViPSo3yhjEa0Ji3MrcaBZx1u+3h1M9n0ll9o49dUUuVw
         qqq0BKQgT/A9dQ6iWf7cl49Zt+7Z0FzUfVGYfy7bnY5GmiR9/SNS8seHF+2yrISHvH
         tjloekhRtq0ZySIC6pSQhn6hQ+cxYY+i2mxsL+nDWjGfobITrNxU5mIn8j9iOjMnKs
         +4nGOe2XjYzHw==
Date:   Wed, 26 Apr 2023 15:16:09 +0200
From:   Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Petr Tesarik <petrtesarik@huaweicloud.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Kim Phillips <kim.phillips@amd.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Muchun Song <muchun.song@linux.dev>,
        Ondrej Zary <linux@zary.sk>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Petr Tesarik <petr.tesarik.ext@huawei.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Won Chung <wonchung@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v2 0/7] Allow dynamic allocation of software IO TLB
 bounce buffers
Message-ID: <20230426151609.2f922349@meshulam.tesarici.cz>
In-Reply-To: <2023042630-amends-speech-7db2@gregkh>
References: <cover.1681898595.git.petr.tesarik.ext@huawei.com>
        <20230426141520.0caf4386@meshulam.tesarici.cz>
        <2023042617-wobble-enlighten-9361@gregkh>
        <20230426144439.5674f8bc@meshulam.tesarici.cz>
        <2023042630-amends-speech-7db2@gregkh>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Apr 2023 14:53:52 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Wed, Apr 26, 2023 at 02:44:39PM +0200, Petr Tesa=C5=99=C3=ADk wrote:
> > Hi Greg,
> >=20
> > On Wed, 26 Apr 2023 14:26:36 +0200
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> >  =20
> > > On Wed, Apr 26, 2023 at 02:15:20PM +0200, Petr Tesa=C5=99=C3=ADk wrot=
e: =20
> > > > Hi,
> > > >=20
> > > > On Wed, 19 Apr 2023 12:03:52 +0200
> > > > Petr Tesarik <petrtesarik@huaweicloud.com> wrote:
> > > >    =20
> > > > > From: Petr Tesarik <petr.tesarik.ext@huawei.com>
> > > > >=20
> > > > > The goal of my work is to provide more flexibility in the sizing =
of
> > > > > SWIOTLB.
> > > > >=20
> > > > > The software IO TLB was designed with these assumptions:
> > > > >=20
> > > > > 1. It would not be used much, especially on 64-bit systems.
> > > > > 2. A small fixed memory area (64 MiB by default) is sufficient to
> > > > >    handle the few cases which require a bounce buffer.
> > > > > 3. 64 MiB is little enough that it has no impact on the rest of t=
he
> > > > >    system.
> > > > >=20
> > > > > First, if SEV is active, all DMA must be done through shared
> > > > > unencrypted pages, and SWIOTLB is used to make this happen without
> > > > > changing device drivers. The software IO TLB size is increased to
> > > > > 6% of total memory in sev_setup_arch(), but that is more of an
> > > > > approximation. The actual requirements may vary depending on the
> > > > > amount of I/O and which drivers are used. These factors may not be
> > > > > know at boot time, i.e. when SWIOTLB is allocated.
> > > > >=20
> > > > > Second, other colleagues have noticed that they can reliably get
> > > > > rid of occasional OOM kills on an Arm embedded device by reducing
> > > > > the SWIOTLB size. This can be achieved with a kernel parameter, b=
ut
> > > > > determining the right value puts additional burden on pre-release
> > > > > testing, which could be avoided if SWIOTLB is allocated small and
> > > > > grows only when necessary.   =20
> > > >=20
> > > > Now that merging into 6.4 has begun, what about this patch series? =
I'm
> > > > eager to get some feedback (positive or negative) and respin the ne=
xt
> > > > version.   =20
> > >=20
> > > It's the merge window, we can't add new things that haven't been in
> > > linux-next already. =20
> >=20
> > This is understood. I'm not asking for immediate inclusion.
> >  =20
> > >   Please resubmit it after -rc1 is out. =20
> >=20
> > If you can believe that rebasing to -rc1 will be enough, then I will
> > also try to believe I'm lucky. ;-)
> >=20
> > The kind of feedback I really want to get is e.g. about the extra
> > per-device DMA-specific fields. If they cannot be added to struct
> > device, then I'd rather start discussing an interim solution, because
> > getting all existing DMA fields out of that struct will take a lot of
> > time... =20
>=20
> I thought the goal was to get them out of the device and into the bus
> instead right?  Or was it the other way around?  I can't remember
> anymore, sorry...

You remember it almost right. The goal is to get them out of struct
device into the bus (or platform device, or whatever holds struct
device). But I'd like to keep this task decoupled from the dynamic
swiotlb.

Thanks,
Petr T
