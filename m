Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B6766E6D8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 20:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235284AbjAQTVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 14:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbjAQTMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 14:12:32 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA43137B4A
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:26:34 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id x2-20020a17090a46c200b002295ca9855aso7111902pjg.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+Mu9koWxZO+GAicl5/zS5kt22OU1K36mNzIi6VF5ODg=;
        b=Mq6oH5qKA0GiWeJKgDxS3jtZ54iKpVzxllLLtClfwonnVI3fy2+MSy6gdiEg2ybH4d
         YI0bAD7AvA5UEWkaMXE4411ssRNhQkOhgXfcR2Rw/UCdZU++9Qem8/gmytQ9peDSb1OL
         v3QUh9MAoM0fZZPpItddCM3cYixpIokrCLznzbXMeyWGB+YRHIf6uyj++pUwTLBYo7dn
         yzLg6DACo1QzFEzV/0jo7aNC1Ck5BUOJ25jB5Eo4/W6Yit08/MZUJvl23JqTH+yq6Sl1
         ptKdz147F9MraZ/7qPiae3JFTdJcm3naETmXOzH2DB+YRPHYNjWo+c5w8pcVEsdv8LcP
         QAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Mu9koWxZO+GAicl5/zS5kt22OU1K36mNzIi6VF5ODg=;
        b=xKE9pnBIadwIekPR3mYSAT1tPr/lIXi116trPPAAQDHtXUr/bFOopgJc3XaWX7ebg2
         A0OZptjTP237cVqXWo3Ai/ZKUXdYf8ccZ/TnwiHPBPJatTQaPT2MwiY1D2uPHjUSWOsO
         USoLx5QPBR17GXruX4GFfzf5GPoLJybkT0VssgZ5y1E/tNWq9InYgb469+xvGmOv0J9v
         rXGpODgndHiiIDejTiXs9cHIpl7fM0vNfb7row6loN0NUBYPrg/HW9egNYGd5CwjffN4
         BZWAHAzqrEPUl+7SmIJz5ssTNm3zHQy0lFvLmv8y5UNN9nP+rVMhxy+LgKByPYjBq+J6
         0vwg==
X-Gm-Message-State: AFqh2koTE6d9K7LzbBAXNXLnpiJerGZp0PUcR+tqvExGIRtPLiZBjcuX
        nKq7bos0jcpfdT21Gg51+woYPDBrRgdH2BTaH+GOZQ==
X-Google-Smtp-Source: AMrXdXvJa7vxqW9Vr1N/MIHgCkmy9xvGXdr0Vk9R68Oj1WsBq6ZPcxpTTZCAAiGC/Z30NaGDzmrSxhBYW4WF+Di+7u4=
X-Received: by 2002:a17:90a:ad92:b0:229:41a0:c5de with SMTP id
 s18-20020a17090aad9200b0022941a0c5demr351566pjq.107.1673979993589; Tue, 17
 Jan 2023 10:26:33 -0800 (PST)
MIME-Version: 1.0
References: <20230111123736.20025-1-kirill.shutemov@linux.intel.com>
 <20230111123736.20025-9-kirill.shutemov@linux.intel.com> <Y8adEg2CYUSVpwtk@hirez.programming.kicks-ass.net>
 <20230117135703.voaumisreld7crfb@box> <Y8a4bmCU9wsenvvF@hirez.programming.kicks-ass.net>
 <CAHk-=wiwiA7FdSww9fTg59r5S7G-DZHtzAcq9u5zBJKYXc1agQ@mail.gmail.com> <CAHk-=wj4HUBvCvfX3oZLZAZTzPc2vdwsObFqnOsQ-UZrdzm_rQ@mail.gmail.com>
In-Reply-To: <CAHk-=wj4HUBvCvfX3oZLZAZTzPc2vdwsObFqnOsQ-UZrdzm_rQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 17 Jan 2023 10:26:22 -0800
Message-ID: <CAKwvOdnCJmcGurUpHcdO44vVazz67jGDTXzug9LGv6C84xGmPw@mail.gmail.com>
Subject: Re: [PATCHv14 08/17] x86/mm: Reduce untagged_addr() overhead until
 the first LAM user
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Bharata B Rao <bharata@amd.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        joao@overdrivepizza.com
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

On Tue, Jan 17, 2023 at 9:29 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Jan 17, 2023 at 9:18 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > The reason clang seems to generate saner code is that clang seems to
> > largely ignore the whole "__builtin_expect()", at least not to the
> > point where it tries to make the unlikely case be out-of-line.
>
> Side note: that's not something new or unusual. It's been the case
> since I started testing clang - we have several code-paths where we
> use "unlikely()" to try to get very unlikely cases to be out-of-line,
> and clang just mostly ignores it, or treats it as a very weak hint. I
> think the only way to get clang to treat it as a *strong* hint is to
> use PGO.

I'd be surprised if that were intentional or by design.

Do you guys have a bug report we could look at?

> So clang ignoring the likely() hint is probably the right thing here,
> and then the wrong thing in some other places.

-- 
Thanks,
~Nick Desaulniers
