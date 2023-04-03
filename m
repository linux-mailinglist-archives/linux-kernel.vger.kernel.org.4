Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E906D3C58
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 06:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjDCENY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 00:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjDCENV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 00:13:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA99B658E
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 21:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=JCaTQDH69Gr7URRj8QyibVsxSrgDVKe91Qxc5yJkGbU=; b=SjkWhVfETbkBwIiO3wuXoyAZcx
        hcJd/IM2FXNh9RH8xcEz1SCvIM76JjdQ8pxXeaaXa4gP7+8Oa9NA9uJHjMuV/k5Cd0HxapJhOTAsA
        aYMDeICvhSMEMLzKLFEjS3D5Ul/lMoYYBm+DzwT7C7D75cc3MjVgzFDpvMzHW83H/59XVWQRnO1eG
        nAmLZ8WYVmeTLZsF0cKznYrp+YmX3NyzShe9nF6OZeYBqcjD9BGOyVv3zyRUBBCF3ohdpBat44eku
        CC24y6hpszrJ3dpsj0kwDP03Gloh6jbb8ROX+oHYPlKh+DlPBPdcW4czkJpYQTPKkmZv1MK+aGzHX
        ziCVIu1Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pjBZ5-00DmSH-Ru; Mon, 03 Apr 2023 04:13:07 +0000
Date:   Mon, 3 Apr 2023 05:13:07 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     =?utf-8?B?6YOt6L6J?= <guohui@uniontech.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev
Subject: Re: [PATCH] mm: remove all the slab allocators
Message-ID: <ZCpSU3ys00BC34BR@casper.infradead.org>
References: <20230401094658.11146-1-vbabka@suse.cz>
 <D9446192D1350A06+edeebc7d-b55d-571e-ef25-98ecb9d2662b@uniontech.com>
 <ZClhKouKa5e6/jha@casper.infradead.org>
 <CAPj211unsM2zM8Y-7iZ09jmKF135xZ6pSPzyzN2dkFvN=wUZFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPj211unsM2zM8Y-7iZ09jmKF135xZ6pSPzyzN2dkFvN=wUZFA@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 05:51:42AM +0200, Fabio M. De Francesco wrote:
> On Sun, 2 Apr 2023, 13:04 Matthew Wilcox, <willy@infradead.org> wrote:
> 
> > On Sun, Apr 02, 2023 at 05:09:14PM +0800, 郭辉 wrote:
> > > On 4/1/23 5:46 PM, Vlastimil Babka wrote:
> > > > As the SLOB removal is on track and the SLAB removal is planned, I have
> > > > realized - why should we stop there and not remove also SLUB? What's a
> > > > slab allocator good for in 2023? The RAM sizes are getting larger and
> > > > the modules cheaper [1]. The object constructor trick was perhaps
> > > > interesting in 1994, but not with contemporary CPUs. So all the slab
> > > > allocator does today is just adding an unnecessary layer of complexity
> > > > over the page allocator.
> > >
> > > The slab allocator is very core and very important to the Linux kernel.
> > > After the patch is merged into the mainline, it will have a very profound
> > > impact on the development of the Linux kernel.
> >
> > https://en.wikipedia.org/wiki/April_Fools%27_Day
> 
> 
> Wow!
> 
> The most interesting implication of this "patch" is that you noticed that
> some people may actually need the link above to be able to distinguish
> between foolishness and reality...

As the article says, this is a Western tradition, and we shouldn't
assume that somebody from (I assume) China would be familiar with this
particular foolishness ;-)
