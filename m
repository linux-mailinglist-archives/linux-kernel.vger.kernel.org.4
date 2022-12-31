Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE85765A43A
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 13:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235580AbiLaMzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 07:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235583AbiLaMzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 07:55:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790B4131
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 04:55:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26357B80759
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 12:55:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF2C3C433D2;
        Sat, 31 Dec 2022 12:55:39 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Zj+6Yeu6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1672491338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WtAEE7+A30698oarN7kLZng0aHalPx3eHSCK0c4NZ4Q=;
        b=Zj+6Yeu6IKHkbjh3w8ulIKp0JX/VtWBFOj14CAflyHJ+n8iXBigBmLi7IeaTq0LN/SwKvo
        TV9V5xhqF6m/qbS4UeCrqxRQdy4gg7/2lkMvFtOC395/Sk28Aolfo81AtWtFKmIOux4I0i
        ZyK6onKXNIvl4UIycmmga0mTpmPM5oM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 3a678b71 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Sat, 31 Dec 2022 12:55:38 +0000 (UTC)
Date:   Sat, 31 Dec 2022 13:55:32 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Borislav Petkov <bp@alien8.de>, pbonzini@redhat.com,
        ebiggers@kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        qemu-devel@nongnu.org, ardb@kernel.org, kraxel@redhat.com,
        philmd@linaro.org
Subject: Re: [PATCH qemu] x86: don't let decompressed kernel image clobber
 setup_data
Message-ID: <Y7AxRMn7l8J512eZ@zx2c4.com>
References: <Y6z765zHrQ6Rl/0o@zx2c4.com>
 <AF921575-0968-434A-8B46-095B78C209C1@zytor.com>
 <Y62MdawGaasXmoVL@zn.tnic>
 <Y68Js5b0jW/2nLU4@zx2c4.com>
 <Y68Zf/MKmX3Rr18E@zn.tnic>
 <CAHmME9oPUJemVRvO3HX0q4BJGTFuzbLYANeizuRcNq2=Ykk1Gg@mail.gmail.com>
 <Y69B40T9kWfxZpmf@zn.tnic>
 <E5D0A77E-5ABC-4978-9A66-37B60DA43869@zytor.com>
 <Y69h6ur79SMhu61F@zx2c4.com>
 <46466e54-25c3-3194-8546-a57cd4a80d9d@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <46466e54-25c3-3194-8546-a57cd4a80d9d@zytor.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2022 at 05:06:55PM -0800, H. Peter Anvin wrote:
> 
> 
> On 12/30/22 14:10, Jason A. Donenfeld wrote:
> > On Fri, Dec 30, 2022 at 01:58:39PM -0800, H. Peter Anvin wrote:
> >> See the other thread fork. They have identified the problem already.
> > 
> > Not sure I follow. Is there another thread where somebody worked out why
> > this 62meg limit was happening?
> > 
> > Note that I sent v2/v3, to fix the original problem in a different way,
> > and if that looks good to the QEMU maintainers, then we can all be happy
> > with that. But I *haven't* addressed and still don't fully understand
> > why the 62meg limit applied to my v1 in the way it does. Did you find a
> > bug there to fix? If so, please do CC me.
> > 
> 
> Yes, you yourself posted the problem:
> 
> > Then build qemu. Run it with `-kernel bzImage`, based on the kernel
> > built with the .config I attached.
> > 
> > You'll see that the CPU triple faults when hitting this line:
> > 
> >         sd = (struct setup_data *)boot_params->hdr.setup_data;
> >         while (sd) {
> >                 unsigned long sd_addr = (unsigned long)sd;
> > 
> >                 kernel_add_identity_map(sd_addr, sd_addr + sizeof(*sd) + sd->len);  <----
> >                 sd = (struct setup_data *)sd->next;
> >         }
> > 
> > , because it dereferences *sd. This does not happen if the decompressed
> > size of the kernel is < 62 megs.
> > 
> > So that's the "big and pretty serious" bug that might be worthy of
> > investigation.
> 
> This needs to be something like:
> 
> kernel_add_identity_map(sd_addr, sd_addr + sizeof(*sd));
> kernel_add_identity_map(sd_addr + sizeof(*sd),
> 	sd_addr + sizeof(*sd) + sd->len);
> 

Oh, right, duh. Thanks for spelling it out.

Jason
