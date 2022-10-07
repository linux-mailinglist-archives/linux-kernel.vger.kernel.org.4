Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFEA55F7D27
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 20:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiJGSKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 14:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiJGSKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 14:10:02 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2BF1571A
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 11:09:46 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id nb11so13003370ejc.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 11:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1W+79VQMxxPF69KCE1QRHN//RmajMzwiHI85YAJXiHU=;
        b=YhpFFg1DCfKvchdSNInDtg+FWnvFyOsyzoq3ayJWyurAV34SzyClnB5VxCzp2JAyi0
         d3xqFVatIL20JQimUc7S3gY2+IUFT9pIv0ROcsSZ1tvKmBBTKf0Lk6cE8qMmJiIZypys
         E9XDTixmt9gKqKDyRc71lc71okS3Np/zkvQEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1W+79VQMxxPF69KCE1QRHN//RmajMzwiHI85YAJXiHU=;
        b=RHlCH4fYlmISxE7WdRtYGMgDh6o1sxG5zkZ/9QprJGQSLANYJFSBujkTVAp5683JJk
         L7CVBVN7ZutPRPE9cqaklgZmQEuRMYWpXe1AkvN3VDctwgrQOGLBjgf+6H0hUEt4pvUl
         KM8wHL8twYdfkzrX6xRNQMWycEn3D6VY8n+EthPD9xIWpfYBbvKBQdeQ/suWc/9JL3/I
         4KT3Xkzic44FEoq0VuaQs8aJ+MxMtV0FdLDvOrUPdaHOA5s3/HdTIMqNT02LcRbG6wG5
         Au+iRJIA9YHx3sqXh2Yoa6EDFm1uS+X8JCs3N1SQeOZOxp8ZV9lf6RxB847J7dTK6AU5
         XR3g==
X-Gm-Message-State: ACrzQf0Vh+4hV8Pqpq64DdUUAGhBjQF7tfnlkAiuKE0Lo0WZVw9aa80P
        wiai1ceZJnv26iCO/27pf+69RcdP4D5T0A==
X-Google-Smtp-Source: AMsMyM5Aklg3HT1QlUckSQQB0kyZ45Yeep6dAspemDsMdxJ1/cVRVLTTsgdLk/ywhTVwJUnDX9tnew==
X-Received: by 2002:a17:907:9708:b0:787:6f95:2bff with SMTP id jg8-20020a170907970800b007876f952bffmr5118719ejc.81.1665166153298;
        Fri, 07 Oct 2022 11:09:13 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id z25-20020aa7cf99000000b0044e9601e53fsm1901225edx.19.2022.10.07.11.09.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 11:09:12 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id k2so13029657ejr.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 11:09:12 -0700 (PDT)
X-Received: by 2002:a17:906:9753:b0:787:8e6a:103c with SMTP id
 o19-20020a170906975300b007878e6a103cmr5201845ejy.337.1665166152049; Fri, 07
 Oct 2022 11:09:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220923005827.1533380-1-dverkamp@chromium.org>
 <Yy2U2BW6Tx0imGpK@zn.tnic> <CABVzXAk9AXj2Ns7YAh7cCA38t2sGxOEYLv-EfLCoFHr-SUQ2Mw@mail.gmail.com>
 <Yy3yJfz213Lqo4KC@zn.tnic>
In-Reply-To: <Yy3yJfz213Lqo4KC@zn.tnic>
From:   Daniel Verkamp <dverkamp@chromium.org>
Date:   Fri, 7 Oct 2022 11:08:45 -0700
X-Gmail-Original-Message-ID: <CABVzXAkO4pU+gpUcWOEWDw+W4id=1WEOgeP5+3tBG_LR6=oa=g@mail.gmail.com>
Message-ID: <CABVzXAkO4pU+gpUcWOEWDw+W4id=1WEOgeP5+3tBG_LR6=oa=g@mail.gmail.com>
Subject: Re: [PATCH] x86: also disable FSRM if ERMS is disabled
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 10:51 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Sep 23, 2022 at 10:25:05AM -0700, Daniel Verkamp wrote:
> > Yes, we hit this in crosvm when booting the guest kernel with either
> > OVMF or u-boot on an Intel 12th Gen CPU. The guest kernel boots fine
> > when loaded directly (using the crosvm kernel loader and not running
> > any firmware setup in the guest), but it crashes when booting with
> > firmware inside the first forward memmove() after alternatives are set
> > up (which happens to be in printk). I haven't gotten to the bottom of
> > why exactly using firmware is causing this to be set up in an
> > inconsistent way, but this is a real-world situation, not just a
> > hypothetical.
>
> Sounds like broken virt firmware or so. And if that is not an issue on
> baremetal, then the virt stack should be fixed - not the kernel.
>
> > Now that I look at it with fresh eyes again, maybe we should instead
> > directly patch the memmove FSRM alternative so that the flag-set
> > version just does the same jmp as the ERMS one. I can prepare a patch
> > for that instead of (or in addition to) this one if that sounds
> > better.
>
> So, if the virt firmware deviates from how the real hardware behaves,
> then the kernel needs no fixing.
>
> So you'd have to figure out why is the virt firmware causing this and
> not baremetal.
>
> Then we can talk about fixes.

Hi Borislav,

We found that the IA32_MISC_ENABLE MSR setup was missing in the crosvm
firmware boot path (but not when directly booting a kernel, which is
why it did not get noticed for a while). Setting the fast string bit
in the MSR avoids the issue.

However, I still think it would be appropriate to apply this patch or
something like it, since there could be a CPU, microcode update, BIOS,
etc. that clears this bit while still having the CPUID flags for FSRM
and ERMS. The Intel SDM says: "Software can disable fast-string
operation by clearing the fast-string-enable bit (bit 0) of
IA32_MISC_ENABLE MSR", so it's not an invalid configuration for this
bit to be unset.

Additionally, something like this avoids the problem by making the
FSRM case jump directly to the REP MOVSB rather than falling through
to the ERMS jump in the next instruction, which seems like basically
free insurance (but if the FSRM flag gets used somewhere else in the
future, having it set consistently with ERMS is probably still a good
idea, per the original patch):

diff --git a/arch/x86/lib/memmove_64.S b/arch/x86/lib/memmove_64.S
index 724bbf83eb5b..8ac557409c7d 100644
--- a/arch/x86/lib/memmove_64.S
+++ b/arch/x86/lib/memmove_64.S
@@ -38,7 +38,7 @@ SYM_FUNC_START(__memmove)

         /* FSRM implies ERMS => no length checks, do the copy directly */
 .Lmemmove_begin_forward:
-        ALTERNATIVE "cmp $0x20, %rdx; jb 1f", "", X86_FEATURE_FSRM
+        ALTERNATIVE "cmp $0x20, %rdx; jb 1f", "jmp .Lmemmove_erms",
X86_FEATURE_FSRM
         ALTERNATIVE "", "jmp .Lmemmove_erms", X86_FEATURE_ERMS

And hey, this means one less instruction to execute in the FSRM path. :)

Thanks,
-- Daniel
