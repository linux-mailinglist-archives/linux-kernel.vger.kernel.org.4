Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9185659A3F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 16:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235183AbiL3P7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 10:59:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbiL3P7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 10:59:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B127295A4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 07:59:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6BB41B81CE9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 15:59:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A7CC433D2;
        Fri, 30 Dec 2022 15:59:38 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Y2n4Akq2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1672415976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=odCq3jpvKxUWWKR9uehguYLEqxNLuteo6ze0jLkLXpI=;
        b=Y2n4Akq2SMowOVlkk1GwtvB6BrrWGskyHXKpLlKQsQI2e7qiy+u8vGrUCORfpGhnB8ZjlC
        srQZczqj4q1N5xniwghg9QK57o+vqEjybCL1ttI7BiP6/1QzI/egOqPmQPuwEEGax5ZRro
        Z/swpfgzzIZvDKIQpxD/mXuzM7dkPEI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 78847be2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 30 Dec 2022 15:59:36 +0000 (UTC)
Date:   Fri, 30 Dec 2022 16:59:30 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     pbonzini@redhat.com, ebiggers@kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
        ardb@kernel.org, kraxel@redhat.com, bp@alien8.de, philmd@linaro.org
Subject: Re: [PATCH qemu] x86: don't let decompressed kernel image clobber
 setup_data
Message-ID: <Y68K4mPuz6edQkCX@zx2c4.com>
References: <20221228143831.396245-1-Jason@zx2c4.com>
 <6cab26b5-06ae-468d-ac79-ecdecb86ef07@linaro.org>
 <Y6xvJheSYC83voCZ@zx2c4.com>
 <Y6x1knb8udpSyMSp@zx2c4.com>
 <9188EEE9-2759-4389-B39E-0FEBBA3FA57D@zytor.com>
 <Y6z765zHrQ6Rl/0o@zx2c4.com>
 <AF921575-0968-434A-8B46-095B78C209C1@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AF921575-0968-434A-8B46-095B78C209C1@zytor.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Dec 28, 2022 at 11:31:34PM -0800, H. Peter Anvin wrote:
> On December 28, 2022 6:31:07 PM PST, "Jason A. Donenfeld" <Jason@zx2c4.com> wrote:
> >Hi,
> >
> >Read this message in a fixed width text editor with a lot of columns.
> >
> >On Wed, Dec 28, 2022 at 03:58:12PM -0800, H. Peter Anvin wrote:
> >> Glad you asked.
> >> 
> >> So the kernel load addresses are parameterized in the kernel image
> >> setup header. One of the things that are so parameterized are the size
> >> and possible realignment of the kernel image in memory.
> >> 
> >> I'm very confused where you are getting the 64 MB number from. There
> >> should not be any such limitation.
> >
> >Currently, QEMU appends it to the kernel image, not to the initramfs as
> >you suggest below. So, that winds up looking, currently, like:
> >
> >          kernel image            setup_data
> >   |--------------------------||----------------|
> >0x100000                  0x100000+l1     0x100000+l1+l2
> >
> >The problem is that this decompresses to 0x1000000 (one more zero). So
> >if l1 is > (0x1000000-0x100000), then this winds up looking like:
> >
> >          kernel image            setup_data
> >   |--------------------------||----------------|
> >0x100000                  0x100000+l1     0x100000+l1+l2
> >
> >                                 d e c o m p r e s s e d   k e r n e l
> >		     |-------------------------------------------------------------|
> >                0x1000000                                                     0x1000000+l3 
> >
> >The decompressed kernel seemingly overwriting the compressed kernel
> >image isn't a problem, because that gets relocated to a higher address
> >early on in the boot process. setup_data, however, stays in the same
> >place, since those links are self referential and nothing fixes them up.
> >So the decompressed kernel clobbers it.
> >
> >The solution in this commit adds a bunch of padding between the kernel
> >image and setup_data to avoid this. That looks like this:
> >
> >          kernel image                            padding                               setup_data
> >   |--------------------------||---------------------------------------------------||----------------|
> >0x100000                  0x100000+l1                                         0x1000000+l3      0x1000000+l3+l2
> >
> >                                 d e c o m p r e s s e d   k e r n e l
> >		     |-------------------------------------------------------------|
> >                0x1000000                                                     0x1000000+l3 
> >
> >This way, the decompressed kernel doesn't clobber setup_data.
> >
> >The problem is that if 0x1000000+l3-0x100000 is around 62 megabytes,
> >then the bootloader crashes when trying to dereference setup_data's
> >->len param at the end of initialize_identity_maps() in ident_map_64.c.
> >I don't know why it does this. If I could remove the 62 megabyte
> >restriction, then I could keep with this technique and all would be
> >well.
> >
> >> In general, setup_data should be able to go anywhere the initrd can
> >> go, and so is subject to the same address cap (896 MB for old kernels,
> >> 4 GB on newer ones; this address too is enumerated in the header.)
> >
> >It would be theoretically possible to attach it to the initrd image
> >instead of to the kernel image. As a last resort, I guess I can look
> >into doing that. However, that's going to require some serious rework
> >and plumbing of a lot of different components. So if I can make it work
> >as is, that'd be ideal. However, I need to figure out this weird 62 meg
> >limitation.
> >
> >Any ideas on that?
> >
> >Jason
> 
> As far as a crash... that sounds like a big and a pretty serious one at that.
> 
> Could you let me know what kernel you are using and how *exactly* you are booting it?

I'll attach a .config file. Apply the patch at the top of this thread to
qemu, except make one modification:

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 628fd2b2e9..a61ee23e13 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -1097,7 +1097,7 @@ void x86_load_linux(X86MachineState *x86ms,
 
             /* The early stage can't address past around 64 MB from the original
              * mapping, so just give up in that case. */
-            if (padded_size < 62 * 1024 * 1024)
+            if (true || padded_size < 62 * 1024 * 1024)
                 kernel_size = padded_size;
             else {
                 fprintf(stderr, "qemu: Kernel image too large to hold setup_data\n");

Then build qemu. Run it with `-kernel bzImage`, based on the kernel
built with the .config I attached.

You'll see that the CPU triple faults when hitting this line:

        sd = (struct setup_data *)boot_params->hdr.setup_data;
        while (sd) {
                unsigned long sd_addr = (unsigned long)sd;

                kernel_add_identity_map(sd_addr, sd_addr + sizeof(*sd) + sd->len);  <----
                sd = (struct setup_data *)sd->next;
        }

, because it dereferences *sd. This does not happen if the decompressed
size of the kernel is < 62 megs.

So that's the "big and pretty serious" bug that might be worthy of
investigation.

Jason
