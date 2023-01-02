Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9488665AEAE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 10:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjABJcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 04:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjABJcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 04:32:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8205326E2
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 01:32:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1552460EF7
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 09:32:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE45C433F0
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 09:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672651936;
        bh=Ry+t4NYxz2LnY50+lHocjvCB/yPTIKyyLB5poiRirY4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mXkQCAUXRpMx2BxXatIs9QzKh/4YtzXyuyea26MbEENziG7Yu6Lfk9u+w05FoNSfy
         1X6iZNd+HpzprTGn+7DA9Biey2i28aBtA4qNY1pSHk6y9WgQkjX8yhl6rjZ/WYvye8
         gpz013krvFpoHqWDhUVl/DRzNBdHBiqGR2KRWjOrCABClrr74Sl/NGB4wwlBCeTjhl
         ntCK9Sylg6yyVEJwtGY+poDlc5+oeII0Hx6zvCrcD7jjMTJkqy/yqlyFV0R7BVD5Ue
         ZkK9UKpLVRFUyb4sSIkkSvKy9val09B183s7D6YATCtcmbGMZrv2PSq3eMyq4PopbV
         xJ9gydXkCBqrQ==
Received: by mail-lj1-f174.google.com with SMTP id p2so13003071ljn.7
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 01:32:16 -0800 (PST)
X-Gm-Message-State: AFqh2kr3eceiWAT+ucrAIW2pMAULXpC9PCPcOUyEL5IO1s878pNu0nai
        xmHwzCSiwg2QJUUxeaBHWiTpY4UKRMrGvG4FwrA=
X-Google-Smtp-Source: AMrXdXumaiU5c64MbvVjmQn+Emq3s+Anlwtq0//DHOL0975Aj9+8uS9+d4EPAXnlu81fcPtiuajpivRg/BklVkuooXI=
X-Received: by 2002:a05:651c:1a25:b0:27f:5559:a998 with SMTP id
 by37-20020a05651c1a2500b0027f5559a998mr1811588ljb.69.1672651934461; Mon, 02
 Jan 2023 01:32:14 -0800 (PST)
MIME-Version: 1.0
References: <Y7A76+IBS4fnucrW@zn.tnic> <Y7A8qP05B0YRbQIN@zx2c4.com>
 <Y7A9nBud6UeH+wYd@zn.tnic> <Y7A+YELM7m5E2PUQ@zx2c4.com> <Y7BGIAL4z6o6FEI5@zn.tnic>
 <Y7B993P1+jYB/etX@zx2c4.com> <Y7CGzde+qPB7YJP4@zn.tnic> <60566f8b-c90f-12e7-c13e-94e9829eee2d@zytor.com>
 <8f072588-7d66-0932-7486-ed9159ae93ae@zytor.com> <Y7JzTh8JnMXM6ZPS@zn.tnic> <Y7J3B50kn1kWrxlk@zn.tnic>
In-Reply-To: <Y7J3B50kn1kWrxlk@zn.tnic>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 2 Jan 2023 10:32:03 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHDw5p5yX25TnKiQ7sgqVbhEjB+=fu=7Oz67shQD-fL6Q@mail.gmail.com>
Message-ID: <CAMj1kXHDw5p5yX25TnKiQ7sgqVbhEjB+=fu=7Oz67shQD-fL6Q@mail.gmail.com>
Subject: Re: [PATCH qemu] x86: don't let decompressed kernel image clobber setup_data
To:     Borislav Petkov <bp@alien8.de>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, pbonzini@redhat.com,
        ebiggers@kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        qemu-devel@nongnu.org, kraxel@redhat.com, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Jan 2023 at 07:17, Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Jan 02, 2023 at 07:01:50AM +0100, Borislav Petkov wrote:
> > On Sat, Dec 31, 2022 at 07:31:21PM -0800, H. Peter Anvin wrote:
> > > It would probably be a good idea to add a "maximum physical address for
> > > initrd/setup_data/cmdline" field to struct kernel_info, though. It appears
> > > right now that those fields are being identity-mapped in the decompressor,
> > > and that means that if 48-bit addressing is used, physical memory may extend
> > > past the addressable range.
> >
> > Yeah, we will probably need that too.
> >
> > Btw, looka here - it can't get any more obvious than that after dumping
> > setup_data too:
> >
> > early console in setup code
> > early console in extract_kernel
> > input_data: 0x00000000040f92bf
> > input_len: 0x0000000000f1c325
> > output: 0x0000000001000000
> > output_len: 0x0000000003c5e7d8
> > kernel_total_size: 0x0000000004428000
> > needed_size: 0x0000000004600000
> > boot_params->hdr.setup_data: 0x00000000010203b0
> > trampoline_32bit: 0x000000000009d000
> >
> > Decompressing Linux... Parsing ELF... done.
> > Booting the kernel.
> > <EOF>
> >
> > Aligning them vertically:
> >
> > output:                               0x0000000001000000
> > output_len:                   0x0000000003c5e7d8
> > kernel_total_size:            0x0000000004428000
> > needed_size:                  0x0000000004600000
> > boot_params->hdr.setup_data:  0x00000000010203b0
>
> Ok, waait a minute:
>
> ============    ============
> Field name:     pref_address
> Type:           read (reloc)
> Offset/size:    0x258/8
> Protocol:       2.10+
> ============    ============
>
>   This field, if nonzero, represents a preferred load address for the
>   kernel.  A relocating bootloader should attempt to load at this
>   address if possible.
>
>   A non-relocatable kernel will unconditionally move itself and to run
>   at this address.
>
> so a kernel loader (qemu in this case) already knows where the kernel goes:
>
> boot_params->hdr.setup_data: 0x0000000001020450
> boot_params->hdr.pref_address: 0x0000000001000000
>                                 ^^^^^^^^^^^^^^^^^
>
> now, considering that same kernel loader (qemu) knows how big that kernel is:
>
> kernel_total_size: 0x0000000004428000
>
> should that loader *not* put anything that the kernel will use in the range
>
> pref_addr + kernel_total_size
>

This seems to be related to another issue that was discussed in the
context of this change, but affecting EFI boot not legacy BIOS boot
[0].

So, in a nutshell, we have the following pieces:
- QEMU, which manages a directory of files and other data blobs, and
exposes them via its fw_cfg interface.
- SeaBIOS, which invokes the fw_cfg interface to load the 'kernel'
blob at its preferred address
- The boot code in the kernel, which interprets the various fields in
the setup header to figure out where the compressed image lives etc

So the problem here, which applies to SETUP_DTB as well as
SETUP_RNG_SEED, is that the internal file representation of the kernel
blob (which does not have an absolute address at this point, it's just
a file in the fw_cfg filesystem) is augmented with:
1) setup_data linked-list entries carrying absolute addresses that are
assumed to be valid once SeaBIOS loads the file to memory
2) DTB and/or RNG seed blobs appended to the compressed 'kernel' blob,
but without updating that file's internal metadata

Issue 1) is what broke EFI boot, given that EFI interprets the kernel
blob as a PE/COFF image and hands it to the Loadimage() boot service,
which has no awareness of boot_params or setup_data and so just
ignores it and loads the image at an arbitrary address, resulting in
setup_data absolute address values pointing to bogus places.

It seems that now, we have another issue 2), where the fw_cfg view of
the file size goes out of sync with the compressed image's own view of
its size.

As a fix for issue 1), we explored another solution, which was to
allocate fixed areas in memory for the RNG seed, so that the absolute
address added to setup_data is guaranteed to be correct regardless of
where the compressed image is loaded, but that was shot down for other
reasons, and we ended up enabling this feature only for legacy BIOS
boot. But apparently, this approach has other issues so perhaps it is
better to revisit that solution again.

So instead of appending data to the compressed image and assuming that
it will stay in place, create or extend a memory reservation
elsewhere, and refer to its absolute address in setup_data.

-- 
Ard.


[0] https://lore.kernel.org/all/CAMj1kXFr6Bv4_G0-wCTu4fp_iCrG060NHJx_j2dbnyiFJKYYeQ@mail.gmail.com/
