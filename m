Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBC1690B70
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 15:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjBIOOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 09:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjBIOOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 09:14:34 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1A6422E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 06:14:33 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id j23so1956518wra.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 06:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M0ZM7kywlhkgeziVnTm41PXyqdyaquK5NgWbdbwF9ow=;
        b=oPZCMeIepctN33muHlJ1qR2sjSBQQjbRl2dyIstuvypf4GSSTOZfimMZWcG9+oYx9D
         nqmO5oiGdHHRSgTxUFquM5wNgDN1QLoQhUSWAf++KGH6nv7ccXCzLqakTt6BQgiN7bUO
         e8xZ3+PZMmBKwbv77wyFrKIafyxxMte8SxoRnZYZjwsBXRcXu+zzfncyiQjLoM4AfYyb
         tf0ejDPieEQHNQ/0Jnz+G4Kav6ynWDhJoGMO1L7OGM0cK/IhjyXIL/TYYnbWtMYrtVGG
         PZtVcddLPVfz63JVs3G9KLKtz/Xa8S2rbZ/FDuukhcaaR2KgySStMeqXYcQh+dGielPe
         US1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M0ZM7kywlhkgeziVnTm41PXyqdyaquK5NgWbdbwF9ow=;
        b=dm72B8H1EHQvjXeQyTMCcKEWz8gZMS7dV3KGD9OQezUwnoS155Ji5/BgA0+daLlwyD
         tQjQIB9BsIFEgU36pYcwut/CCMSZT3ssaQLSJkfRVbO2gOLPxexJCCtjJ4EpC9OIDqCd
         UUcEqyd59PVKm4kAjN6G71kmprKuUFdo6BDsVronp4bNiawalkqwAU/wmN/Z50g3yNQV
         uauAVyLJyzAgDaJ+PdhVF0pBGyRQaorIuDBbpzZjrsUqIE7c3hmNKh4nyJQM022M6lJI
         B9aKHsndfgBGaWZ6GOCiecFus8Sb4rvi7m6ksDdFvfWpPoAIuja9thDfhjCfRlBnJHFc
         7urQ==
X-Gm-Message-State: AO0yUKU33Oje1sTZ1cXV8WVsbo5xd3D3BD5H1rq4sWsSq40mtuCvVEXK
        GShYA8gBkHmp4Q3aHgZCAkS20HkpJIRwQIlHC+WEJA==
X-Google-Smtp-Source: AK7set8l3Dc5ALoGD9cLxcfFKe+GPAa19zk51cWrf1J/oRMw1E3E9+SIQ793SYEddVB7ap6z+eXEp4vPRf/xpTMyPRQ=
X-Received: by 2002:a5d:4bcb:0:b0:2c0:c5f:87d2 with SMTP id
 l11-20020a5d4bcb000000b002c00c5f87d2mr271946wrt.228.1675952071905; Thu, 09
 Feb 2023 06:14:31 -0800 (PST)
MIME-Version: 1.0
References: <20230123220500.21077-1-kirill.shutemov@linux.intel.com> <20230123220500.21077-10-kirill.shutemov@linux.intel.com>
In-Reply-To: <20230123220500.21077-10-kirill.shutemov@linux.intel.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 9 Feb 2023 15:13:55 +0100
Message-ID: <CAG_fn=WiZ+srz+TSR8QER1zZYLzq91h3y+0gDOd1f1L6dECL2w@mail.gmail.com>
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
Tested-by: Alexander Potapenko <glider@google.com>
