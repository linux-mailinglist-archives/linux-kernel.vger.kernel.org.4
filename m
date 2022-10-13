Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25BE05FDD1C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 17:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiJMPYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 11:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiJMPXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 11:23:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8662A63343;
        Thu, 13 Oct 2022 08:23:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71B3461843;
        Thu, 13 Oct 2022 15:23:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 379A1C433C1;
        Thu, 13 Oct 2022 15:23:41 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="DWY7sMnQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1665674619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Zbm6Vmx3sUgdXMvn6nLfsZeuKOKciv8fS7d6WFzgxM0=;
        b=DWY7sMnQI9los3VC++PX7LaZiNzDIcbPF9DiUHhB5FSFRkidSUaafwOD8aJmew2hqEjW8z
        HuPq7iACbapLj4E2t5/wl0jq+bHtC3T62Aeob1a8XOzFYXQbt0vR39K8eWm/NqHUlN+BPS
        brGalF0YfD2B8lPIEaJPWe7qGQumfkk=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b93cf1eb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 13 Oct 2022 15:23:38 +0000 (UTC)
Date:   Thu, 13 Oct 2022 09:23:36 -0600
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-toolchains@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: gcc 5 & 6 & others already out of date?
Message-ID: <Y0gteD0QYVlYxSZh@zx2c4.com>
References: <CAHmME9prBJHmo9Bw6aobuGLjtxLsjxKJ9wopOv5+BY6ZtuKaNg@mail.gmail.com>
 <Y0gLyLbdOCetX5LN@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y0gLyLbdOCetX5LN@sirena.org.uk>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 01:59:52PM +0100, Mark Brown wrote:
> The expected users for old toolchains was always users doing something
> like building a newer kernel on an old enterprise distro rather than
> people actually developing anything AIUI.
> Two or three releases seems a bit ambitious, I'm sitting here in front
> of a Debian stable system which probably has another year or so of being
> the latest release left and it's sitting at GCC 10.2 with the latest
> release of GCC being 12.2.  Probably also worth noting that GCC did a
> 9.5 release in May this year as it went out of their support window.
> A quick look suggests that RHEL 7 is at GCC 4.8 (so running into trouble
> anyway), RHEL 8 at 8.x, SLES looks like it makes newer compilers
> available even for the old releases (eg, there's GCCs up to 10 available
> for SLES 12 AFAICT).  Ubuntu 16.04 does seem to use GCC 5 but it's on
> extended security support at this point, their 18.04 is at GCC 7.4 from
> the looks of it.

The thing is, do we really want to be catering to this? In the first
place, enterprise users and enterprise kernels are already doing freaky
things, forked to no end. But moreover, do we actually want to support
people building the kernel with a different compiler than most of us
develop with? In a basic way, that just seems like a recipe for
disaster.

It's also easy, nearly trivial, to download toolchains. Arnd provides a
bunch with his crosstool. "Must use a toolchain from your distro" is a
requirement that affects nobody.

So I just think we're thinking about this all wrong. It doesn't matter
what's available on the distros. It matters what the most reasonable
compiler to develop with is, first of all. And secondly, it matters that
this compiler is easily available for users to download in a variety of
settings need-be. And I'm pretty sure this latter part is already the
case.

Plus, as I mentioned earlier, this is already the model we're going
toward by virtue of Rust (and to a small extent, Clang) invading.

Jason
