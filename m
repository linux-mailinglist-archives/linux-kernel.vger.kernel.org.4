Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDEA2691F26
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 13:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbjBJMaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 07:30:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbjBJMaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 07:30:39 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8E2735A5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 04:30:35 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so6172638wmb.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 04:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rzXGI750nbovUeOo5nq7VVxphblkXYgiOmT1I27ynB0=;
        b=p0C9LCJhQmE3+pTdu2b7vLtvu4Th0IhyEjIUpTHsqCL/np+iI7yAslpGQXuvBpC2gZ
         0sli6pHc0g2QfD3+Q52TnoLY+qFA77nbqC3rxWxlNG0rE+RhQZU6U0R75Tyhd8zM2Wix
         uVF7/TfWlwHQ0um76o7uCTJgGWQg5nzd3n14Zv1fxe6nUMsAj04TsofPeZbm10ND2aSk
         tu0U8knLBiLjM2HsmgwEMWICDlTIvri+o5tZmuJpTjw7wyupTwmaJ0G8xr87lLlr7d6w
         FLvBuh5j8hwJYSFqqyPyU+95iormsRjlquc32lKxRJFU875dCHUkwbiu9q8MWnXHQswy
         FDvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rzXGI750nbovUeOo5nq7VVxphblkXYgiOmT1I27ynB0=;
        b=B8ekfNEn9UCYgyKOEwOMuRQvnwnMmSA72gWTcRlvtvKYDMeh9B4XXRKi+MU8XkUGf3
         9bGsPV83dGuB0OE7mu+rGDQqfaMx7n5IJg0RPqzcOxDNfU0IHPDpSfbVh+LfonSUE397
         BD70Av/hGyxbzHoTELKkn58OYkWzOBYkC48wDT+s/OEPq+MPnnH0yOo0hRHxU25epF8A
         lGNk+w5Whv59daoG5OIEL5Zcal1OAKVsNrEJAuHsvFfHH0aKomsZELgd0MhoGCgM3Q/z
         9juODiUZoMUwQikaHaZcNmYszSbQoPtaSR9wCjoneesKbsYrwqzXR0TVQD1CGkmiMNBw
         dTwA==
X-Gm-Message-State: AO0yUKWdpgQMDPoiNdyjJ+fgEbefe5xiV//0PdjV/2P8Z95TFjvwPE6/
        Av93rIH3zjJHPA4lhXeBN6cerStrxFZTzpwEetHuNw==
X-Google-Smtp-Source: AK7set+2W7zCRxhS+H1bs0QPTQO0pDTooCKg7pQearQx5rjejCJe4/yy+VTRLLhCDPYxabCvirSxrIvBpkE+ammej3M=
X-Received: by 2002:a7b:c2f7:0:b0:3e0:c45:3456 with SMTP id
 e23-20020a7bc2f7000000b003e00c453456mr909332wmk.44.1676032234074; Fri, 10 Feb
 2023 04:30:34 -0800 (PST)
MIME-Version: 1.0
References: <20230123220500.21077-1-kirill.shutemov@linux.intel.com> <20230123220500.21077-10-kirill.shutemov@linux.intel.com>
In-Reply-To: <20230123220500.21077-10-kirill.shutemov@linux.intel.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 10 Feb 2023 13:29:44 +0100
Message-ID: <CAG_fn=UZK8c39grJBcrC+=8EhmO8KBkAq-zoo3kgg=GP616W7A@mail.gmail.com>
Subject: Re: [PATCHv15 09/17] mm: Expose untagging mask in /proc/$PID/status
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Bharata B Rao <bharata@amd.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
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

On Mon, Jan 23, 2023 at 11:05 PM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> Add a line in /proc/$PID/status to report untag_mask. It can be
> used to find out LAM status of the process from the outside. It is
> useful for debuggers.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>


>         mm->context.untag_mask = -1UL;
> diff --git a/fs/proc/array.c b/fs/proc/array.c
> index 49283b8103c7..d2a94eafe9a3 100644
> --- a/fs/proc/array.c
> +++ b/fs/proc/array.c

Right now mm_untag_mask() is visible from array.c thanks to inclusion
of <linux/cpuset.h>, which happens to include <linux/mmu_context.h>.
But maybe it would be better to directly include mmu_context.h here?
