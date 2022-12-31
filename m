Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8341365A608
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 19:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbiLaSW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 13:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiLaSW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 13:22:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596E4E9E
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 10:22:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD466B808C6
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 18:22:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3627DC433D2;
        Sat, 31 Dec 2022 18:22:53 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Zbi0+zXE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1672510970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KstZBdcZcqbHkQ2CxwtPc1Y6fLGICRufWpnz600OBT4=;
        b=Zbi0+zXEV/ee3LPUBCqdMKlQr8LNUJlwOflP3uriV2i5PKPGOGXCFqDh1mr+tcJcUpSYBA
        9SChpE00VU5jNJokTJrAOAgb4B9McJdrzcmggb6HFsqcDcxSx6ZN96cvVeyMdFEIlPycHJ
        BR2AIN6LhrSrmZMcTtXDixHLBfLZ1dc=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 3f12f758 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Sat, 31 Dec 2022 18:22:49 +0000 (UTC)
Date:   Sat, 31 Dec 2022 19:22:47 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, pbonzini@redhat.com,
        ebiggers@kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        qemu-devel@nongnu.org, ardb@kernel.org, kraxel@redhat.com,
        philmd@linaro.org
Subject: Re: [PATCH qemu] x86: don't let decompressed kernel image clobber
 setup_data
Message-ID: <Y7B993P1+jYB/etX@zx2c4.com>
References: <CAHmME9oPUJemVRvO3HX0q4BJGTFuzbLYANeizuRcNq2=Ykk1Gg@mail.gmail.com>
 <Y69B40T9kWfxZpmf@zn.tnic>
 <E5D0A77E-5ABC-4978-9A66-37B60DA43869@zytor.com>
 <Y69h6ur79SMhu61F@zx2c4.com>
 <46466e54-25c3-3194-8546-a57cd4a80d9d@zytor.com>
 <Y7A76+IBS4fnucrW@zn.tnic>
 <Y7A8qP05B0YRbQIN@zx2c4.com>
 <Y7A9nBud6UeH+wYd@zn.tnic>
 <Y7A+YELM7m5E2PUQ@zx2c4.com>
 <Y7BGIAL4z6o6FEI5@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y7BGIAL4z6o6FEI5@zn.tnic>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 31, 2022 at 03:24:32PM +0100, Borislav Petkov wrote:
> On Sat, Dec 31, 2022 at 02:51:28PM +0100, Jason A. Donenfeld wrote:
> > That failure is unrelated to the ident mapping issue Peter and
> > I discussed. The original failure is described in the commit message:
> > decompression clobbers the data, so sd->next points to garbage.
> 
> Right

So with that understanding confirmed, I'm confused at your surprise that
hpa's unrelated fix to the different issue didn't fix this issue.

> and the fact that the kernel overwrites it still feels kinda wrong: the
> kernel knows where setup_data is - the address is in the setup header so
> *actually*, it should take care of not to clobber it.

Yea, technically the bootloader could relocate all the setup_data links
by copying them and updating ->next. This wouldn't be so hard to do.
(Special care would have to be taken, though, to zero out
SETUP_RNG_SEED, though, for forward secrecy and such.)

But since the kernel doesn't do this now, and the 62MiB bug also seems
to apply to existing kernels, for the purposes of QEMU for now, I think
the v3 patch is probably best, since it'll handle existing kernels.
Alternatively, setup_data could be relocated, the boot param protocol
could be bumped, and then QEMU could conditionalized it's use of
setup_data based on that protocol version. That'd work, but seems a bit
more involved.

So maybe for now, v3 works? Hopefully that looks like a correct approach
to hpa, anyhow:
https://lore.kernel.org/lkml/20221230220725.618763-1-Jason@zx2c4.com/
I think it should fit with what he described would work.

Jason
