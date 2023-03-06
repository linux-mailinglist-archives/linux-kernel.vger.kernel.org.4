Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B5D6AC98E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 18:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjCFRP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 12:15:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjCFRPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 12:15:06 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F3549899
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 09:14:44 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id ay29-20020a05600c1e1d00b003e9f4c2b623so8692498wmb.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 09:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678122821;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gj13L4BUXvytGxxa1g10XICA4jSK6uFNLJQ+EdDsYDA=;
        b=lwipPy4w6ZgFewdDOcufE0PASv0Lac+0DO0Al+fxtEKhmU+ZaF6Gsngrp7tVg8ZqvC
         4vUNOFnP5F0aJ3covIEcYDCx1OOY3IFTl0MD+XPNOCKRTAwqWDTE53DQqAPmkQXWKrXn
         CX9QKZe5xazXf7dHa4CkurYXCPrJnqOm66mOxVSNqLQj9VspZpYvLJT6Vd0dOYrPOMsx
         o/AqZx8wBnf5FiHgbd0PUYsNH5QDxm6f1k4DOPlakLgaS7TnNiHpfjYwhMa+pXHN6mHe
         Lrkn5uXddEl5eCCKdJx+9QV1p0yeoPuOxXYAZqUpYmN2TmIrMAJlzE5fN6kA33RkEqrY
         UDTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678122821;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gj13L4BUXvytGxxa1g10XICA4jSK6uFNLJQ+EdDsYDA=;
        b=0po3uwmxD8/yLvUjn9UAOP0LwmG7JQecD6GicB3gw7INNHX7PYDppDH9shEUIq7Cil
         QzX7fhHwQ0uZ/oLfKY+5C5yo2kG3A0wLkfUT2XRochk+nKohJXUfsmKOm2u2f9GfDbP9
         58Xcg23KGrjhdMBBstrh/4lvNVLagYyvPyiynzvxM9QMrgBkuFEnhiU58HmFMKlH3y3I
         QfuQ6J8ElocDpa6eHTTRmVe3fYQJGQ59JUvWOAt8X7Zt+FvVymQCrJqExxoODC5AhCAf
         TKtnRYXmccT6Cd22yOj38fEds4Xj4oCeWRVATV3MCmcMND72WDFJvm2OC1k6vZB0VOmV
         bxSw==
X-Gm-Message-State: AO0yUKXMfqFA/duwMAp9bKFoh7VdVLpIJvhVXc43lw7v73yI0R7W2jCs
        GwD05qzlnyQjy1JUFzG73hPfUJm4mb04MCp8yO+XHg==
X-Google-Smtp-Source: AK7set+NlylrgXCQEd0NBIjjvBltXMJIo9VQQCn7U8WLf0FuBNSvm77ccyWMsIkMAvFmtisDe11jLksGFkRy2hy2Nek=
X-Received: by 2002:a05:600c:a3a2:b0:3eb:246d:7ee6 with SMTP id
 hn34-20020a05600ca3a200b003eb246d7ee6mr2574115wmb.3.1678122821567; Mon, 06
 Mar 2023 09:13:41 -0800 (PST)
MIME-Version: 1.0
References: <20230306135520.4222-1-ldufour@linux.ibm.com> <7161f75e-9f40-f881-84b8-1eaaec0b0e3f@redhat.com>
 <d720d943-ea5d-451b-b8fa-ec9ad56f6dbf@linux.ibm.com>
In-Reply-To: <d720d943-ea5d-451b-b8fa-ec9ad56f6dbf@linux.ibm.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 6 Mar 2023 09:13:29 -0800
Message-ID: <CAJuCfpEEcWcU26n11t=r9DKj8DH41E=rdA3=81BDpTKp9PPKEA@mail.gmail.com>
Subject: Re: [PATCH] powerpc/mm: fix mmap_lock bad unlock
To:     Laurent Dufour <ldufour@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Sachin Sant <sachinp@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 6, 2023 at 6:09 AM Laurent Dufour <ldufour@linux.ibm.com> wrote:
>
> On 06/03/2023 15:07:26, David Hildenbrand wrote:
> > On 06.03.23 14:55, Laurent Dufour wrote:
> >> When page fault is tried holding the per VMA lock, bad_access_pkey() and
> >> bad_access() should not be called because it is assuming the mmap_lock is
> >> held.
> >> In the case a bad access is detected, fall back to the default path,
> >> grabbing the mmap_lock to handle the fault and report the error.
> >>
> >> Fixes: 169db3bb4609 ("powerc/mm: try VMA lock-based page fault handling
> >> first")
> >> Reported-by: Sachin Sant <sachinp@linux.ibm.com>
> >> Link:
> >> https://lore.kernel.org/linux-mm/842502FB-F99C-417C-9648-A37D0ECDC9CE@linux.ibm.com
> >> Cc: Suren Baghdasaryan <surenb@google.com>
> >> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
> >> ---
> >>   arch/powerpc/mm/fault.c | 8 ++------
> >>   1 file changed, 2 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> >> index c7ae86b04b8a..e191b3ebd8d6 100644
> >> --- a/arch/powerpc/mm/fault.c
> >> +++ b/arch/powerpc/mm/fault.c
> >> @@ -479,17 +479,13 @@ static int ___do_page_fault(struct pt_regs *regs,
> >> unsigned long address,
> >>         if (unlikely(access_pkey_error(is_write, is_exec,
> >>                          (error_code & DSISR_KEYFAULT), vma))) {
> >> -        int rc = bad_access_pkey(regs, address, vma);
> >> -
> >>           vma_end_read(vma);
> >> -        return rc;
> >> +        goto lock_mmap;
> >>       }
> >>         if (unlikely(access_error(is_write, is_exec, vma))) {
> >> -        int rc = bad_access(regs, address);
> >> -
> >>           vma_end_read(vma);
> >> -        return rc;
> >> +        goto lock_mmap;
> >>       }
> >>         fault = handle_mm_fault(vma, address, flags |
> >> FAULT_FLAG_VMA_LOCK, regs);
> >
> > IIUC, that commit is neither upstream not in mm-stable -- it's unstable.
> > Maybe raise that as a review comment in reply to the original patch, so we
> > can easily connect the dots and squash it into the original, problematic
> > patch that is still under review.
> >
> Oh yes, I missed that. I'll reply to the Suren's thread.

Thanks Laurent! Seems simple enough to patch the original change.

>
> Thanks,
> Laurent.
