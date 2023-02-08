Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9BC68F6F1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 19:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbjBHSep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 13:34:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjBHSej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 13:34:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4DF25282
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 10:34:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74875B81F3F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 18:34:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55C01C433EF;
        Wed,  8 Feb 2023 18:34:33 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="aZhH/gPf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1675881270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cao7atRAj5EzOKn7eWRiDQw9TlKsKb+eWA3SfBqNxKE=;
        b=aZhH/gPfn495K6PdMZdHWMGLi/CCfz6UzfxXWADnJFFzW+i5jJSz2x7UekVwYPfaeEmPZR
        jvUYaB6HKdjporxvFcqQkcGZoMtyXxLr8nkRLFTFQjuglHH6qyRZlk0GQ5ZmJ4rv0GyZCh
        W5ztMFOymgobnq0ocsqDtvU5Tj3bjOc=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 84942535 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 8 Feb 2023 18:34:30 +0000 (UTC)
Date:   Wed, 8 Feb 2023 19:34:30 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH] x86: temporarily remove all attempts to provide
 setup_data
Message-ID: <Y+PrNmq5nuWKWfGw@zx2c4.com>
References: <20230208180835.234638-1-Jason@zx2c4.com>
 <20230208131125-mutt-send-email-mst@kernel.org>
 <CAHmME9rMnbGDZ+Rq8ao=gZd10kBp5ni=73HcPpFC58ChoKZObA@mail.gmail.com>
 <20230208131805-mutt-send-email-mst@kernel.org>
 <Y+PpPRvnlakC78Is@zx2c4.com>
 <Y+PqePFLgp5Lel4V@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y+PqePFLgp5Lel4V@redhat.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 06:31:20PM +0000, Daniel P. Berrangé wrote:
> On Wed, Feb 08, 2023 at 07:26:05PM +0100, Jason A. Donenfeld wrote:
> > On Wed, Feb 08, 2023 at 01:18:37PM -0500, Michael S. Tsirkin wrote:
> > > On Wed, Feb 08, 2023 at 03:14:38PM -0300, Jason A. Donenfeld wrote:
> > > > On Wed, Feb 8, 2023 at 3:13 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > >
> > > > > On Wed, Feb 08, 2023 at 03:08:35PM -0300, Jason A. Donenfeld wrote:
> > > > > > All attempts at providing setup_data have been made as an iteration on
> > > > > > whatever was there before, stretching back to the original
> > > > > > implementation used for DTBs that [mis]used the kernel image itself.
> > > > > > We've now had a dozen rounds of bugs and hacks, and the result is
> > > > > > turning into a pile of unmaintainable and increasingly brittle hacks.
> > > > > >
> > > > > > Let's just rip out all the madness and start over. We can re-architect
> > > > > > this based on having a separate standalone setup_data file, which is how
> > > > > > it should have been done in the first place. This is a larger project
> > > > > > with a few things to coordinate, but we can't really begin thinking
> > > > > > about that while trying to play whack-a-mole with the current buggy
> > > > > > implementation.
> > > > > >
> > > > > > So this commit removes the setup_data setting from x86_load_linux(),
> > > > > > while leaving intact the infrastructure we'll need in the future to try
> > > > > > again.
> > > > > >
> > > > > > Cc: Michael S. Tsirkin <mst@redhat.com>
> > > > > > Cc: Dov Murik <dovmurik@linux.ibm.com>
> > > > > > Cc: Tom Lendacky <thomas.lendacky@amd.com>
> > > > > > Cc: Gerd Hoffmann <kraxel@redhat.com>
> > > > > > Cc: Daniel P. Berrangé <berrange@redhat.com>
> > > > > > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > > > > > Cc: Richard Henderson <richard.henderson@linaro.org>
> > > > > > Cc: H. Peter Anvin <hpa@zytor.com>
> > > > > > Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> > > > > > Cc: Nathan Chancellor <nathan@kernel.org>
> > > > > > Cc: Borislav Petkov <bp@alien8.de>
> > > > > > Cc: Eric Biggers <ebiggers@kernel.org>
> > > > > > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > > > >
> > > > > I think I'll be happier if this is just a revert of
> > > > > the relevant commits in reverse order to make life easier
> > > > > for backporters.
> > > > > Unless that's too much work as we made other changes around
> > > > > this code?
> > > > 
> > > > I think that's going to be messy. And it won't handle the dtb stuff
> > > > either straightforwardly.
> > > 
> > > List of Fixes tags so people can at least figure out whether they
> > > have a version that needs this fix then?
> > 
> > 7.2 is when the functionality started causing problems for most people.
> > But the buggy code goes back to 3cbeb524 in 2016.
> 
> We can't rip out the full setup_data support back to that point. That
> is deleting significant features that would break -dtb IIUC. For that
> we would need to have a deprecation period to announce the incompatibility.
> 
> I was thinking this would only revert the RNG seed pieces which have
> negligible user impact.

I'm pretty sure -dtb is used by nobody...

Jason
