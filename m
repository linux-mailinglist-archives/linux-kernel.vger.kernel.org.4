Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99FCF723389
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 01:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbjFEXJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 19:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjFEXJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 19:09:01 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B1AD2
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 16:09:00 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1b01d7b3e80so49158475ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 16:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686006540; x=1688598540;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hP1a+zSS6By6YHFWWESMz0z0ScU/pBzOH1GhvDFLrYA=;
        b=ZgkCFlAJ5hyCXXbkLbm9MJEjuZIaWvJLcIOABz3rXCNo+iRqxjc96RcPTUyBEHX2DS
         knKVuNw9xpy8sggfqJRERqPKj0foAnsDxuVT4HS1dKm9/opd8x06XjMhpr+ASjhwYnSg
         l6yFfq5PMlK3Zv3uEhIHRSoBx2fd/v8jYad1VmWEHi+7wztpZ3M+deJlKnmXwtX2W3Of
         zjiqRtJjDYYtZCt5nC8yuIpd1zY8LPcZvLlNs+EBv6pyg83lPRN8jjNTLklQMXnNDusS
         dV7uDv/gAjpCB+BIGSq87FHNrya8rxqh3ozMu4cVXHSchATE/lyWitA1G0uwjmzpPGr3
         AW7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686006540; x=1688598540;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hP1a+zSS6By6YHFWWESMz0z0ScU/pBzOH1GhvDFLrYA=;
        b=LEE7xW//H/4vBMHyXe2sC/oaZRLO7blEj4+UHR7tU6VbqOHlTs8w3yxiFjM8u0kkhL
         g2+6nNnhFxKG3Yt/3+BxNu53G9nHHhPHQ7aH6HyTecFkHgJYdfF3C/7ZEG4NiTM0iGmz
         +DqsBVCVc54VHzvCnjcaD4k5k1RrUkQNlcXk5YpnU4fTd00ka9bMs3r5MySsfPMgim+3
         rWoHmXvaLZzrEkY26Rmbnt9x01SE9V4xEl658WdltV4wDpfLMSfB7FpS+QpiEwmM8n5B
         t9eVLmbYOs6UT3ElqwTv6BZ6d558IxdcOtwd+dKANuiB4xXF5+nTfsFzwcswHqC6eeNQ
         MC6g==
X-Gm-Message-State: AC+VfDwDRFEhpEjTA9dUin9SVcuuv3TBfN1fFpb9vCeohM43ZA7AaoTZ
        d7jE79HpViygj6+9FbrBUrHkkthFTxg=
X-Google-Smtp-Source: ACHHUZ5BytCokqVdWeqjze8JAgKRZhPDjlQZYLTnQweadibywX2Klt0DCOGOtt9oYOBDxnJ6UxYoQWTr4dM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:7c0d:b0:1ac:618a:6d46 with SMTP id
 x13-20020a1709027c0d00b001ac618a6d46mr100851pll.3.1686006540390; Mon, 05 Jun
 2023 16:09:00 -0700 (PDT)
Date:   Mon, 5 Jun 2023 16:08:59 -0700
In-Reply-To: <87pm694jmg.ffs@tglx>
Mime-Version: 1.0
References: <20230603193439.502645149@linutronix.de> <ZH4eNL4Bf7yPItee@google.com>
 <87pm694jmg.ffs@tglx>
Message-ID: <ZH5rCySnEr0KmATT@google.com>
Subject: Re: [patch 0/6] Cure kexec() vs. mwait_play_dead() troubles
From:   Sean Christopherson <seanjc@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Ashok Raj <ashok.raj@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Biederman <ebiederm@xmission.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023, Thomas Gleixner wrote:
> On Mon, Jun 05 2023 at 10:41, Sean Christopherson wrote:
> > On Sat, Jun 03, 2023, Thomas Gleixner wrote:
> >> This is only half safe because HLT can resume execution due to NMI, SMI and
> >> MCE. Unfortunately there is no real safe mechanism to "park" a CPU reliably,
> >
> > On Intel.  On AMD, enabling EFER.SVME and doing CLGI will block everything except
> > single-step #DB (lol) and RESET.  #MC handling is implementation-dependent and
> > *might* cause shutdown, but at least there's a chance it will work.  And presumably
> > modern CPUs do pend the #MC until GIF=1.
> 
> Abusing SVME for that is definitely in the realm of creative bonus
> points, but not necessarily a general purpose solution.

Heh, my follow-up ideas for Intel are to abuse XuCode or SEAM ;-)

> >> So parking them via INIT is not completely solving the problem, but it
> >> takes at least NMI and SMI out of the picture.
> >
> > Don't most SMM handlers rendezvous all CPUs?  I.e. won't blocking SMIs indefinitely
> > potentially cause problems too?
> 
> Not that I'm aware of. If so then this would be a hideous firmware bug
> as firmware must be aware of CPUs which hang around in INIT independent
> of this.

I was thinking of the EDKII code in UefiCpuPkg/PiSmmCpuDxeSmm/MpService.c, e.g.
SmmWaitForApArrival().  I've never dug deeply into how EDKII uses SMM, what its
timeouts are, etc., I just remember coming across that code when poking around
EDKII for other stuff.

> > Why not carve out a page that's hidden across kexec() to hold whatever code+data
> > is needed to safely execute a HLT loop indefinitely?
> 
> See below.
> 
> > E.g. doesn't the original kernel provide the e820 tables for the
> > post-kexec() kernel?
> 
> Only for crash kernels if I'm not missing something.

Ah, drat.

> Making this work for regular kexec() including this:
> 
> > To avoid OOM after many kexec(), reserving a page could be done iff
> > the current kernel wasn't itself kexec()'d.
> 
> would be possible and I thought about it, but that needs a complete new
> design of "offline", "shutdown offline" and a non-trivial amount of
> backwards compatibility magic because you can't assume that the kexec()
> kernel version is greater or equal to the current one. kexec() is
> supposed to work both ways, downgrading and upgrading. IOW, that ship
> sailed long ago.

Right, but doesn't gaining "full" protection require ruling out unenlightened
downgrades?  E.g. if someone downgrades to an old kernel, doesn't hide the "offline"
CPUs from the kexec() kernel, and boots the old kernel with -nosmt or whatever,
then that old kernel will do the naive MWAIT or unprotected HLT and it's hosed again.

If we're relying on the admin to hide the offline CPUs, could we usurp an existing
kernel param to hide a small chunk of memory instead?
