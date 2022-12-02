Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1CE640E27
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 20:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234507AbiLBTCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 14:02:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbiLBTB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 14:01:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B24FE2545
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 11:01:56 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670007715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hGD3C2OE9Qr7B30PrUOZTVQpnPl/hR6oT6hCymS6mLQ=;
        b=cP1lR3J1+7x602QMu+R7Zmq6JJQ/tCP7vavRb9MLflK0KE3oiouqHqwrYM5cDQ3bZG0XAw
        u4iWqFXeDpQSZ02r0Qz6y8HmKPPz5vQcmSZcTK5YcDE032gG1Klw3EP9v1v7HI65pGTwP+
        3wR2w2zREpD7Ok9VQ8cYcLEChgTZmR/H5It/SMc4f6Fc1W0LfEZ65Hn6jQaL8WIEMbMPpB
        7pySlj018ZY4tRuTBXroGx/fdc2K1JiBUPAUQt9Mje9iC1mfE4Oz263H3Hg9FHGB8Ar8wN
        XkNTZzbfcW56ZHRIKcxQsJUldvz3RMntI6ReMvWd8ihuJfnxvQOSA4cSWelfVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670007715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hGD3C2OE9Qr7B30PrUOZTVQpnPl/hR6oT6hCymS6mLQ=;
        b=Fi5AU0bx2GJoGywQ/bKSnMtAADSdLFyl+TCsQN27Sc3jeLFZ50FsDuWQ4HrZbEQdFHzKmV
        aM0+nih/s5akZwAg==
To:     Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@alien8.de>
Cc:     X86-kernel <x86@kernel.org>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>, alison.schofield@intel.com,
        reinette.chatre@intel.com
Subject: Re: [Patch V1 2/7] x86/microcode/intel: Remove retries on early
 microcode load
In-Reply-To: <20221129210832.107850-3-ashok.raj@intel.com>
References: <20221129210832.107850-1-ashok.raj@intel.com>
 <20221129210832.107850-3-ashok.raj@intel.com>
Date:   Fri, 02 Dec 2022 20:01:54 +0100
Message-ID: <87a645pr31.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29 2022 at 13:08, Ashok Raj wrote:
> Microcode loading can fail. This happens today when handling mixed
> steppings. But it can also happen for other reasons such as corrupted
> image, Security Version Number (SVN) preventing anti-rollback,
> dependencies on BIOS loaded microcode image for some capabilities.
>
> When the microcode loading fails, the kernel will quietly hang at boot.
> This has been observed by end users (Links below) who had to revert their
> microcode packages in order to boot again.
>
> The hang is due to an infinite retry loop. The retries were in place to
> support systems with mixed steppings. Now that mixed steppings are no
> longer supported, there is only one microcode image at a time. Any retries
> will simply reattempt to apply the same image over and over without making
> progress.
>
> Some possible past bugs that could be due to this bug are below.
>
> There is no direct evidence that these end user issues were caused by this
> retry loop. However, the early boot hangs along with reverting the
> microcode update workaround provide strong circumstantial evidence to
> support the theory that they are linked.
>
> Remove the retry loop and only attempt to apply microcode once.

Very concise and informative changelog. See, you can do it :)

> Link: https://bugs.launchpad.net/ubuntu/+source/intel-microcode/+bug/1911959
> Link: https://forums.linuxmint.com/viewtopic.php?p=1827032#1827032
> Link: https://askubuntu.com/questions/1291486/boot-crash-after-latest-update-of-intel-microcode-nov-11-2020
> Fixes: 06b8534cb728 ("x86/microcode: Rework microcode loading")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>

Nit: Can you order the tags according to the tip documentation next time
     please?

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
