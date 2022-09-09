Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F985B3B70
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 17:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbiIIPGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 11:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbiIIPGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 11:06:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E39A4B32
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 08:06:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4DB5B82551
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 15:06:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76679C433D6;
        Fri,  9 Sep 2022 15:05:57 +0000 (UTC)
Date:   Fri, 9 Sep 2022 16:05:53 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     George Pee <georgepee@gmail.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        "Kirill A. Shutemov" <kirill.shtuemov@linux.intel.com>,
        Austin Kim <austindh.kim@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Report support for optional ARMv8.2 half-precision
 floating point extension
Message-ID: <YxtWUasndYl8syE1@arm.com>
References: <20220901141307.2361752-1-georgepee@gmail.com>
 <f765da5c-d484-adf2-e1bb-77011780dc0b@arm.com>
 <CAKj0CMv1EY5YCeQ4G6PnGP=XfELJkkN5BaN8W1TGe0fOTXfJBw@mail.gmail.com>
 <YxtIiBvAGs2vAl1P@arm.com>
 <CAKj0CMtkY_BSkAY3Lo5QbMDM1g0Wa9F8MsVuW0fyJiuPe3z4aA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKj0CMtkY_BSkAY3Lo5QbMDM1g0Wa9F8MsVuW0fyJiuPe3z4aA@mail.gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 09:57:39AM -0500, George Pee wrote:
> On Fri, Sep 9, 2022 at 9:07 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Fri, Sep 09, 2022 at 08:34:26AM -0500, George Pee wrote:
> > > Adding the hwcap was part of the diagnosis process-- I added it just
> > > to make sure that the cpu in question supported the optional
> > > extension.
> > > It seems like it could be useful to be able to check for support in
> > > /proc/cpuinfo.
> >
> > Ah, I wasn't aware that the feature doesn't work on arm32. I don't think
> > it makes sense to expose a hwcap bit to user in this case.
> 
> The details are here.  I originally thought it was a compiler bug
> because it first showed up after a toolchain update.
> 
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=106763
> 
> Since FP16 is an optional extension, wouldn't it be beneficial to a
> user who compiled some userspace float16 code using gcc
> -mcpu=cortex-a55 which ran on a cortex-a55 with FP16 extensions but
> SIGILL'd on a cortex-a55 w/o FP16?

(please don't top-post)

My point is that if the kernel doesn't have full support for FP16, it
shouldn't advertise it to user even if the hardware supports it. If you
fix the kernel to properly handle FP16 on supporting hardware, then the
HWCAP part is fine by me.

-- 
Catalin
