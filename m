Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217756EAB31
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 15:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbjDUNEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 09:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbjDUNEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 09:04:00 -0400
Received: from bee.tesarici.cz (bee.tesarici.cz [IPv6:2a03:3b40:fe:2d4::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9638D44A8;
        Fri, 21 Apr 2023 06:03:56 -0700 (PDT)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id 74AB015F397;
        Fri, 21 Apr 2023 15:03:51 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1682082231; bh=sGBRvJGV7WV4NbrM0zicd1I0kijHaIpvCeCXTkGH27E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=x12krQEYJpaSr6cDmf7P+YQo8RV/NgldpWlH2k3pQHvLiJ3Vk5Y52NY7izNb+AuCa
         8kmzq8cizHOKF4Mn9A/GGsVE9n/U1dXxJ+thnkfdsM37A/jJBUv/4skZlGJNlVuvJe
         vE9piS1JUuCdMNPfZTW35WD0rJ9UqP3cCSKs5jMmnS4yy+XkGvQ9Bb0vIxrmT5TkrR
         zl+BPyJSI8gtULfPfxaRgyGk9dGtlkdbat0VVy8mOmWKXCl65CBtQpW4vQ8elSOhox
         4jO5UgefdhAAzz/uxTRgr3gF3zdmRpeZsXC6newwGo0VCvaM11Z+YlX5O2ZRR/GTzj
         PYDwZAr8lgHIg==
Date:   Fri, 21 Apr 2023 15:03:49 +0200
From:   Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Petr Tesarik <petrtesarik@huaweicloud.com>,
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
Message-ID: <20230421150349.35966e0b@meshulam.tesarici.cz>
In-Reply-To: <20230407121555.4290a011@meshulam.tesarici.cz>
References: <cover.1679309810.git.petr.tesarik.ext@huawei.com>
        <0334a54332ab75312c9de825548b616439dcc9f5.1679309810.git.petr.tesarik.ext@huawei.com>
        <20230328040724.GB25506@lst.de>
        <4268fa4e-4f0f-a2f6-a2a5-5b78ca4a073d@huaweicloud.com>
        <8cf7c515-9ce6-a2ed-0643-972aa3eba2fb@huaweicloud.com>
        <20230407055704.GD6803@lst.de>
        <20230407121555.4290a011@meshulam.tesarici.cz>
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

Hi Christoph!

I'd like to follow up on this sub-thread:

On Fri, 7 Apr 2023 12:15:55 +0200
Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz> wroe:

> On Fri, 7 Apr 2023 07:57:04 +0200
> Christoph Hellwig <hch@lst.de> wrote:
>[...]
> > (Btw, in case anyone is interested, we really need to get started
> > on moving the dma fields out of struct device into a sub-struct
> > only allocated for DMA capable busses) =20
>=20
> I like this idea. In fact, my WIP topic branch now moves the swiotlb
> fields into a separate struct,

As you have noticed, I have removed that commit again in v2.

The reason is that I'm not sure about the intended goal. I have looked
around for examples of moving fields out of struct device and found
different approaches:

A. struct dev_msi_info
   The MSI fields are merely grouped in a separate struct, which is
   defined in device.h and embedded in struct device. I don't see much
   benefit.

B. struct dev_pm_info
   This struct is also embedded in struct device, but it is defined in
   <linux/pm.h>, which is mentioned in MAINTAINERS. The benefit is that
   further changes are reviewed by this maintainer. The downside is
   that device.h includes pm.h.

C. struct dev_pin_info
   This struct is merely declared in device.h and defined
   pinctrl/devinfo.h (which is not included). Only a pointer to this
   struct is stored in struct device. Of course, the pointer must be
   initialized (and released) somehow.

Here my question: What did you want for DMA fields?

A. Only grouping those fields in their own struct?
B. Or move the definition to another include file (cf. MAINTAINERS)?
C. Or store a pointer in struct device?

Since you mentioned "allocated", it sounds like you want to achieve C,
but:

1. Is it worth the extra dereference for every use?
2. How should the struct be allocated? Presumably not with kmalloc() in
   device_initialize(), because I don't know how to determine if a
   device is DMA capable this low in the call stack. So, should it be
   allocated together with the containing structure? AFAICS this would
   mean changing nearly all device drivers...

As you can see, I need some more guidance from you before I can start
working on this. ;-)

Petr T
