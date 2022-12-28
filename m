Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F8D658237
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 17:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234883AbiL1Qdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 11:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234814AbiL1QdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 11:33:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE8DDCE
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 08:30:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C3AC8B81888
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 16:30:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4937CC433F2;
        Wed, 28 Dec 2022 16:30:41 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Bnt+skTk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1672245039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u0Zn+bBTFed2/1RZkgN1sK7uWyOuyZ80v3AHCcAcyw8=;
        b=Bnt+skTkWREmE/Cr76o+HWIhI9nJ6payiMUeKeObAMOh1ZRX2/znTspB6WwTUaq+tepEYL
        Jefc0BfgA0avgwY856Zpqs0QsEg4Fy0/idH+UfAKYi0p7NOFFDwGXcYi3a5QywwNIyk9FZ
        ymzQ5K06EtW5nhDZrYIN/yZq7u0aOks=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 67ab20fe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 28 Dec 2022 16:30:38 +0000 (UTC)
Date:   Wed, 28 Dec 2022 17:30:30 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc:     pbonzini@redhat.com, ebiggers@kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
        ardb@kernel.org, kraxel@redhat.com, hpa@zytor.com, bp@alien8.de
Subject: Re: [PATCH qemu] x86: don't let decompressed kernel image clobber
 setup_data
Message-ID: <Y6xvJheSYC83voCZ@zx2c4.com>
References: <20221228143831.396245-1-Jason@zx2c4.com>
 <6cab26b5-06ae-468d-ac79-ecdecb86ef07@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6cab26b5-06ae-468d-ac79-ecdecb86ef07@linaro.org>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2022 at 05:02:22PM +0100, Philippe Mathieu-Daudé wrote:
> Hi Jason,
> 
> On 28/12/22 15:38, Jason A. Donenfeld wrote:
> > The setup_data links are appended to the compressed kernel image. Since
> > the kernel image is typically loaded at 0x100000, setup_data lives at
> > `0x100000 + compressed_size`, which does not get relocated during the
> > kernel's boot process.
> > 
> > The kernel typically decompresses the image starting at address
> > 0x1000000 (note: there's one more zero there than the decompressed image
*compressed image

> > +        uint32_t target_address = ldl_p(setup + 0x258);
> 
> Nitpicking, can the Linux kernel add these magic values in
> arch/x86/include/uapi/asm/bootparam.h? Or can we use
> offsetof(setup_header) to get them?

I suspect the reason that x86.c has always had those hardcoded offsets
is because this is how it's documented in Documentation/x86/boot.rst?

> > +        if ((start_setup_data >= start_target && start_setup_data < end_target) ||
> > +            (end_setup_data >= start_target && end_setup_data < end_target)) {
> > +            uint32_t padded_size = target_address + decompressed_length - prot_addr;
> > +
> > +            /* The early stage can't address past around 64 MB from the original
> > +             * mapping, so just give up in that case. */
> > +            if (padded_size < 62 * 1024 * 1024)
> 
> You mention 64 but check for 62, is that expected? You can use the MiB
> definitions to ease code review: 64 * MiB.

62 is intentional. But I'm still not really sure what's up. 63 doesn't
work. I haven't totally worked out why this is, or why the 64 MiB limit
exists in the first place. Maybe because this is a very early mapping
set up by real mode? Or because another mapping is placed over it that's
executable? There's that 2MiB*4096 gdt entry, but that'd cover all 4
gigs. So I really don't know yet. I'll continue to poke at it, but on
the off chance somebody here understands what's up, that'd save me a
bunch of head scratching.

> Fix looks good, glad you figured out the problem.

I mean, kind of. The solution here sucks, especially given that in the
worst case, setup_data just gets dropped. I'm half inclined to consider
this a kernel bug instead, and add some code to relocate setup_data
prior to decompression, and then fix up all the links. It seems like
this would be a lot more robust.

I just wish the people who wrote this stuff would chime in. I've had
x86@kernel.org CC'd but so far, no input from them.

Jason
