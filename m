Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A8465A628
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 20:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbiLaTAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 14:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiLaTAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 14:00:36 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809C1E9C
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 11:00:35 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E73191EC04AD;
        Sat, 31 Dec 2022 20:00:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1672513234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=wtcKKnYS0ZHRn/fZeFnfnImCwHmhNYrXNEufS2qk2IY=;
        b=rEFqycmTC2OglrzR35Kb4FvOYMQmK/u+hjZ6Q5DeDghRR3Fkb9g8m7lrzZc5JZNaWOwBX/
        zD3l3yzMBfMonVKI8o0kPn9TcqZwlLgAZVF67+Hh4yOH01/7sXYXBMl/OE47/DJzISZO0c
        miXtD/9pE4oLWzklFvb4oXm4DJFs1MY=
Date:   Sat, 31 Dec 2022 20:00:29 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, pbonzini@redhat.com,
        ebiggers@kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        qemu-devel@nongnu.org, ardb@kernel.org, kraxel@redhat.com,
        philmd@linaro.org
Subject: Re: [PATCH qemu] x86: don't let decompressed kernel image clobber
 setup_data
Message-ID: <Y7CGzde+qPB7YJP4@zn.tnic>
References: <Y69B40T9kWfxZpmf@zn.tnic>
 <E5D0A77E-5ABC-4978-9A66-37B60DA43869@zytor.com>
 <Y69h6ur79SMhu61F@zx2c4.com>
 <46466e54-25c3-3194-8546-a57cd4a80d9d@zytor.com>
 <Y7A76+IBS4fnucrW@zn.tnic>
 <Y7A8qP05B0YRbQIN@zx2c4.com>
 <Y7A9nBud6UeH+wYd@zn.tnic>
 <Y7A+YELM7m5E2PUQ@zx2c4.com>
 <Y7BGIAL4z6o6FEI5@zn.tnic>
 <Y7B993P1+jYB/etX@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y7B993P1+jYB/etX@zx2c4.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 31, 2022 at 07:22:47PM +0100, Jason A. Donenfeld wrote:
> So with that understanding confirmed, I'm confused at your surprise that
> hpa's unrelated fix to the different issue didn't fix this issue.

No surprise there - I used a qemu variant without your patch to prevent the
setup_data clobbering so hpa's fix can't help there.

> But since the kernel doesn't do this now, and the 62MiB bug also seems
> to apply to existing kernels, for the purposes of QEMU for now, I think
> the v3 patch is probably best, since it'll handle existing kernels.

Right, we can't fix all those guests which are out there.

> Alternatively, setup_data could be relocated, the boot param protocol
> could be bumped, and then QEMU could conditionalized it's use of
> setup_data based on that protocol version. That'd work, but seems a bit
> more involved.

I think this is at least worth considering because the kernel overwriting
setup_data after having been told where that setup_data is located is not really
nice.

Well not explicitly at least - it gets the pointer to the first element and
something needs to traverse that list to know which addresses are live. But
still, that info is there so perhaps we need to take setup_data into
consideration too before decompressing...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
