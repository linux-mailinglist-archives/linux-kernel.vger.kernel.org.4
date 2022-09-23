Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707F55E8121
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 19:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbiIWRvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 13:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbiIWRvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 13:51:46 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE5E13A072
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 10:51:43 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e795329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e795:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9FCDF1EC0628;
        Fri, 23 Sep 2022 19:51:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1663955497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=NX0uxLsETnQjBDMbT8fMjsShz4e7A36/sdTSflSPHMk=;
        b=Qz6+1YcTlhabcvK6hvgl2WvdnbLAEEEu5ONZfRUACRdJ8+1eYfR0LKY/z5tChIMM64E0JB
        X5vNjpBUjQoTIzhu3UgxcIAbzY7WEhwRCYHr3jJ5xYvX00iXIvM6KQy/HrrPCaxl5eLBQr
        6mmdMmEb1cErTFhu2yD0fSk2B1Q1bfU=
Date:   Fri, 23 Sep 2022 19:51:33 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Daniel Verkamp <dverkamp@chromium.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH] x86: also disable FSRM if ERMS is disabled
Message-ID: <Yy3yJfz213Lqo4KC@zn.tnic>
References: <20220923005827.1533380-1-dverkamp@chromium.org>
 <Yy2U2BW6Tx0imGpK@zn.tnic>
 <CABVzXAk9AXj2Ns7YAh7cCA38t2sGxOEYLv-EfLCoFHr-SUQ2Mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABVzXAk9AXj2Ns7YAh7cCA38t2sGxOEYLv-EfLCoFHr-SUQ2Mw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 10:25:05AM -0700, Daniel Verkamp wrote:
> Yes, we hit this in crosvm when booting the guest kernel with either
> OVMF or u-boot on an Intel 12th Gen CPU. The guest kernel boots fine
> when loaded directly (using the crosvm kernel loader and not running
> any firmware setup in the guest), but it crashes when booting with
> firmware inside the first forward memmove() after alternatives are set
> up (which happens to be in printk). I haven't gotten to the bottom of
> why exactly using firmware is causing this to be set up in an
> inconsistent way, but this is a real-world situation, not just a
> hypothetical.

Sounds like broken virt firmware or so. And if that is not an issue on
baremetal, then the virt stack should be fixed - not the kernel.

> Now that I look at it with fresh eyes again, maybe we should instead
> directly patch the memmove FSRM alternative so that the flag-set
> version just does the same jmp as the ERMS one. I can prepare a patch
> for that instead of (or in addition to) this one if that sounds
> better.

So, if the virt firmware deviates from how the real hardware behaves,
then the kernel needs no fixing.

So you'd have to figure out why is the virt firmware causing this and
not baremetal.

Then we can talk about fixes.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
