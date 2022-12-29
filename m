Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4416588A6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 03:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbiL2CbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 21:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiL2CbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 21:31:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4268513D27
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 18:31:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9C88615A5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 02:31:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC84BC433EF;
        Thu, 29 Dec 2022 02:31:11 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Vq8QSPON"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1672281070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fo1jslvfeopSkuICCRwlACwE2DX39yLIKwrIJZqYHzI=;
        b=Vq8QSPON47EV4x6TnTViJgI6ozO4r5JLnAo/dYSxkIpP6q+0821Jw9K4zZoaeGJecFR7GP
        AtZPNYm426vAh6bLbVxlhWUECiL0VLL2b5PfSODtaIVrDrenWx6Xxiie06KoATfLhAMvip
        zRW9dQqu13vmuk/sxaXYwGx9KfRTS8I=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 675c8781 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 29 Dec 2022 02:31:09 +0000 (UTC)
Date:   Thu, 29 Dec 2022 03:31:07 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     pbonzini@redhat.com, ebiggers@kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
        ardb@kernel.org, kraxel@redhat.com, bp@alien8.de, philmd@linaro.org
Subject: Re: [PATCH qemu] x86: don't let decompressed kernel image clobber
 setup_data
Message-ID: <Y6z765zHrQ6Rl/0o@zx2c4.com>
References: <20221228143831.396245-1-Jason@zx2c4.com>
 <6cab26b5-06ae-468d-ac79-ecdecb86ef07@linaro.org>
 <Y6xvJheSYC83voCZ@zx2c4.com>
 <Y6x1knb8udpSyMSp@zx2c4.com>
 <9188EEE9-2759-4389-B39E-0FEBBA3FA57D@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9188EEE9-2759-4389-B39E-0FEBBA3FA57D@zytor.com>
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

Read this message in a fixed width text editor with a lot of columns.

On Wed, Dec 28, 2022 at 03:58:12PM -0800, H. Peter Anvin wrote:
> Glad you asked.
> 
> So the kernel load addresses are parameterized in the kernel image
> setup header. One of the things that are so parameterized are the size
> and possible realignment of the kernel image in memory.
> 
> I'm very confused where you are getting the 64 MB number from. There
> should not be any such limitation.

Currently, QEMU appends it to the kernel image, not to the initramfs as
you suggest below. So, that winds up looking, currently, like:

          kernel image            setup_data
   |--------------------------||----------------|
0x100000                  0x100000+l1     0x100000+l1+l2

The problem is that this decompresses to 0x1000000 (one more zero). So
if l1 is > (0x1000000-0x100000), then this winds up looking like:

          kernel image            setup_data
   |--------------------------||----------------|
0x100000                  0x100000+l1     0x100000+l1+l2

                                 d e c o m p r e s s e d   k e r n e l
		     |-------------------------------------------------------------|
                0x1000000                                                     0x1000000+l3 

The decompressed kernel seemingly overwriting the compressed kernel
image isn't a problem, because that gets relocated to a higher address
early on in the boot process. setup_data, however, stays in the same
place, since those links are self referential and nothing fixes them up.
So the decompressed kernel clobbers it.

The solution in this commit adds a bunch of padding between the kernel
image and setup_data to avoid this. That looks like this:

          kernel image                            padding                               setup_data
   |--------------------------||---------------------------------------------------||----------------|
0x100000                  0x100000+l1                                         0x1000000+l3      0x1000000+l3+l2

                                 d e c o m p r e s s e d   k e r n e l
		     |-------------------------------------------------------------|
                0x1000000                                                     0x1000000+l3 

This way, the decompressed kernel doesn't clobber setup_data.

The problem is that if 0x1000000+l3-0x100000 is around 62 megabytes,
then the bootloader crashes when trying to dereference setup_data's
->len param at the end of initialize_identity_maps() in ident_map_64.c.
I don't know why it does this. If I could remove the 62 megabyte
restriction, then I could keep with this technique and all would be
well.

> In general, setup_data should be able to go anywhere the initrd can
> go, and so is subject to the same address cap (896 MB for old kernels,
> 4 GB on newer ones; this address too is enumerated in the header.)

It would be theoretically possible to attach it to the initrd image
instead of to the kernel image. As a last resort, I guess I can look
into doing that. However, that's going to require some serious rework
and plumbing of a lot of different components. So if I can make it work
as is, that'd be ideal. However, I need to figure out this weird 62 meg
limitation.

Any ideas on that?

Jason
