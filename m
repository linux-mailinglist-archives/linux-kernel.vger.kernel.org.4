Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58425E69E2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 19:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbiIVRuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 13:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbiIVRu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 13:50:27 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4085D1E8C
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 10:50:26 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id g4so7372798qvo.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 10:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=CqyvEnWuu2OG/5fak5hXa2GzoeHEFNlxtcQChIQbDW4=;
        b=HSxCUJ2/ggEynUtvLBjqQNtQmQXc8g4wYZrwsuGSdQprt8ZV9uUrUxN+ZB9D+8/f+Y
         bdeJq2M/T2OD+7jspFc4XqFQM7CPbFey7EZ8VoAVc8qT4zc8wAmkEXiCbcDkNFDjpFIM
         4920pwnelBxUZS+8zRgdhgMVGWQMQ/chdJgBrHt847c+Q6canO1a2JHT6O6ZIRhthh1m
         YT6/L2jm2n5Xgx7MRZduUxVm7xqjGHjdtcMYl0jnSUDGcAA93UiQByjQRkWJFa+06MVY
         jCFp5KO/Mp5eNSpsS1K2H9zD+uSAlBBbY030rt1rskr1cUw+ayq12acdizdojnVcrjaP
         NhRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=CqyvEnWuu2OG/5fak5hXa2GzoeHEFNlxtcQChIQbDW4=;
        b=0f+OiL4bBz3bkWL529a3X2ZDXhdtODAVzxKZCJeXXMsSjHdyQI1Wz+GkmlcTnzFWAo
         2XcWJ/I+MZKb1DyZze52J7UIyPRta55Qe+zDoRqjhuPLNo61gB7oqInm8oe50CwOtLt/
         L4c1dznYwIHNTFmAd/uoajXg1IhgK6lgGQ2Mj4+WJb+NuGOVrWjVU3tRPuGqLJjMvVHU
         ByDwzGUc5Y+b/BsLVuQ6Rut6ioZe8bUupOrQfR7Q+4fY8/bcMLY1N819MCwkiqNRQprH
         yXl874cBZ6ZCDKNX2IhLGFX/ZByBG98eY3WG9kKIizkMg0TmIsjqyVdjUWk6/n9gCCHa
         NdKw==
X-Gm-Message-State: ACrzQf27E94y5c/TurEDu2swuCuCUmWnJd9Px/M5lNjIx7e0ncKKmvJg
        YqlE7vYFBHZ/0ji2NL+V/NjWYxTFjnJghy8gtIL8sQ==
X-Google-Smtp-Source: AMsMyM7PbHyjKpbnubFyQc8xRswuqIQFTEJPB8tTA+nlsBstVCkc1tVte2pbRVGmDvzJFCcq3Ks5AtcxFPM282jfeoM=
X-Received: by 2002:a0c:df12:0:b0:4ac:9a04:78ee with SMTP id
 g18-20020a0cdf12000000b004ac9a0478eemr3698229qvl.63.1663869025643; Thu, 22
 Sep 2022 10:50:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220908233134.3523339-1-seanjc@google.com> <20220908233134.3523339-2-seanjc@google.com>
 <Yyybg3DxgLt4NVn+@google.com> <Yyyd8UN+ZO1Yf/Co@google.com>
In-Reply-To: <Yyyd8UN+ZO1Yf/Co@google.com>
From:   David Matlack <dmatlack@google.com>
Date:   Thu, 22 Sep 2022 10:49:59 -0700
Message-ID: <CALzav=dfL+DCFnKQnUP27SzWLMdWY0kKXr93=nL_VC1nj=aNkg@mail.gmail.com>
Subject: Re: [PATCH 1/5] KVM: selftests: Implement memcmp(), memcpy(), and
 memset() for guest use
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Jones <andrew.jones@linux.dev>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Oliver Upton <oliver.upton@linux.dev>
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

On Thu, Sep 22, 2022 at 10:40 AM Sean Christopherson <seanjc@google.com> wrote:
>
> On Thu, Sep 22, 2022, David Matlack wrote:
> > > +LIBKVM_STRING += lib/kvm_string.c
> >
> > Can this file be named lib/string.c instead? This file has nothing to do
> > with KVM per-se.
>
> Yes and no.  I deliberately chose kvm_string to avoid confusion with
> tools/lib/string.c and tools/include/nolibc/string.h.  The implementations
> themselves aren't KVM specific, but the reason the file _exists_ is 100% unique
> to KVM as there is no other environment where tools and/or selftests link to
> glibc but need to override the string ops.
>
> I'm not completely opposed to calling it string.c, but my preference is to keep
> it kvm_string.c so that it's slightly more obvious that KVM selftests are a
> special snowflake.

Makes sense, the "kvm" prefix just made me do a double-take. Perhaps
string_overrides.c? That would make it clear that this file is
overriding string functions. And the fact that this file is in the KVM
selftests directory signals that the overrides are specific to the KVM
selftests.


>
> > > diff --git a/tools/testing/selftests/kvm/lib/kvm_string.c b/tools/testing/selftests/kvm/lib/kvm_string.c
> > > new file mode 100644
> > > index 000000000000..a60d56d4e5b8
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/kvm/lib/kvm_string.c
> > > @@ -0,0 +1,33 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +#include "kvm_util.h"
> >
> > Is this include necesary?
>
> Nope, I added the include because I also added declarations in kvm_util_base.h,
> but that's unnecessary because stddef.h also provides the declarations, and those
> _must_ match the prototypes of the definitions.  So yeah, this is better written as:
>
> // SPDX-License-Identifier: GPL-2.0-only
> #include <stddef.h>
>
> /*
>  * Override the "basic" built-in string helpers so that they can be used in
>  * guest code.  KVM selftests don't support dynamic loading in guest code and
>  * will jump into the weeds if the compiler decides to insert an out-of-line
>  * call via the PLT.
>  */
> int memcmp(const void *cs, const void *ct, size_t count)
> {
>         const unsigned char *su1, *su2;
>         int res = 0;
>
>         for (su1 = cs, su2 = ct; 0 < count; ++su1, ++su2, count--) {
>                 if ((res = *su1 - *su2) != 0)
>                         break;
>         }
>         return res;
> }
>
> void *memcpy(void *dest, const void *src, size_t count)
> {
>         char *tmp = dest;
>         const char *s = src;
>
>         while (count--)
>                 *tmp++ = *s++;
>         return dest;
> }
>
> void *memset(void *s, int c, size_t count)
> {
>         char *xs = s;
>
>         while (count--)
>                 *xs++ = c;
>         return s;
> }
