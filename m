Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4821365AD5A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 07:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjABGCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 01:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjABGCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 01:02:10 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF53CBF6
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 22:02:09 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 471CD1EC0589;
        Mon,  2 Jan 2023 07:02:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1672639328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=A5h3QieuYYzDOmoQcc1jOMq8HxvyiZWavNMk7yqAE4w=;
        b=RGoSnp0eXlRVYUC0SrfE1xiexYKt8xMKCv/nkL6NNJdjh3UGoyqOFoIzZ++A4AWOFbsQqd
        Ze5d8AOzno/wRzFC18rPxdTZ4NUxtZETYjXbgO7n7wLn9qFPUdHIB4hbiZY/cy7Ms8Ikx8
        nA0eG4icJt5H2GjDtnDw56Tj5xJ2wYI=
Date:   Mon, 2 Jan 2023 07:01:50 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>, pbonzini@redhat.com,
        ebiggers@kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        qemu-devel@nongnu.org, ardb@kernel.org, kraxel@redhat.com,
        philmd@linaro.org
Subject: Re: [PATCH qemu] x86: don't let decompressed kernel image clobber
 setup_data
Message-ID: <Y7JzTh8JnMXM6ZPS@zn.tnic>
References: <46466e54-25c3-3194-8546-a57cd4a80d9d@zytor.com>
 <Y7A76+IBS4fnucrW@zn.tnic>
 <Y7A8qP05B0YRbQIN@zx2c4.com>
 <Y7A9nBud6UeH+wYd@zn.tnic>
 <Y7A+YELM7m5E2PUQ@zx2c4.com>
 <Y7BGIAL4z6o6FEI5@zn.tnic>
 <Y7B993P1+jYB/etX@zx2c4.com>
 <Y7CGzde+qPB7YJP4@zn.tnic>
 <60566f8b-c90f-12e7-c13e-94e9829eee2d@zytor.com>
 <8f072588-7d66-0932-7486-ed9159ae93ae@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8f072588-7d66-0932-7486-ed9159ae93ae@zytor.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 31, 2022 at 07:31:21PM -0800, H. Peter Anvin wrote:
> It would probably be a good idea to add a "maximum physical address for
> initrd/setup_data/cmdline" field to struct kernel_info, though. It appears
> right now that those fields are being identity-mapped in the decompressor,
> and that means that if 48-bit addressing is used, physical memory may extend
> past the addressable range.

Yeah, we will probably need that too.

Btw, looka here - it can't get any more obvious than that after dumping
setup_data too:

early console in setup code
early console in extract_kernel
input_data: 0x00000000040f92bf
input_len: 0x0000000000f1c325
output: 0x0000000001000000
output_len: 0x0000000003c5e7d8
kernel_total_size: 0x0000000004428000
needed_size: 0x0000000004600000
boot_params->hdr.setup_data: 0x00000000010203b0
trampoline_32bit: 0x000000000009d000

Decompressing Linux... Parsing ELF... done.
Booting the kernel.
<EOF>

Aligning them vertically:

output:				0x0000000001000000
output_len:			0x0000000003c5e7d8
kernel_total_size:		0x0000000004428000
needed_size:			0x0000000004600000
boot_params->hdr.setup_data:	0x00000000010203b0

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
