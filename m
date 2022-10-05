Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66825F59E4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 20:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiJESbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 14:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiJESay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 14:30:54 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D5F220D6
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 11:30:53 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id x32-20020a17090a38a300b00209dced49cfso2590211pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 11:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=SOulkWlMqD4ikKLjwZwv0QJa8SgXnmDIXhP5lgZ0IBY=;
        b=QByDXNQ78QE2NihBTtx5VKnZFGZ+NAVpDvuiyAgqDpj/zzIEO46GWQYOiFbYeFBtgK
         bOX7WQ2q6i5v7LUYgqAv32yYJuZz3Jb7IqRGuwDgCFBg8JJ9v99JmmSjy82nqAULfTZY
         B5OwiqfAoIKpSqi6vzQzSnLOLjCWH+VpNcjm+qWfe6aDxRE6dulBpS6OY84yHaMkYipt
         32dkA1P1uX/dKidboCwXgjHsffgnfCO2/9JOw5Kd6RPKautihFPyVvBeSxzfnfcNARkV
         dtSJ7jCKIpSt9iUiwmTX737ZcaA0ZwDDf3c7ggaPPm70U/v4pFBVNFP4TtY+6gd/LUKh
         senw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=SOulkWlMqD4ikKLjwZwv0QJa8SgXnmDIXhP5lgZ0IBY=;
        b=P/Pkurz64L6BxB7JhS+8x1FcDXDG9xxjqiewcFSjS5kwtZ4DSrUQYg8Tdr4ws0AM27
         nIJegZSxKqvFRtpzhes09uTbE7zq254RCJ8LxAYdZ/xyqvOlKfEbzXAWQQ1Ornn93TIp
         RPZuW7OFkM3CK0H+ZrZdXasbV1senBR9CI4uvgQxci+kR0sMLn4CREdeOm7YBeRg5Pz1
         E5UsQLSlVoJSrKWCeMdw7IO5ppxwlN3fncf+Mp/zHaEF4oQzT+Qyic5zUmVB8zyrSIz6
         X+KvpFLCo+GjBN/Di4Aou2FynA23uy7Eg98qnet/BQ6gPy+B2rcBVQrqZAoQ24/Ru1n4
         DRkA==
X-Gm-Message-State: ACrzQf21MVmBOc/uJz84NQT6YrPS+v2eqQiJaQdEMU/AIIah48uTe3pO
        W8hY4wsfiI8hALf/FY1zmbGLook3rXqEavqJk3rCCgpb4G878g==
X-Google-Smtp-Source: AMsMyM4wM3Z46RY/wp/PyTGKrqPDS01mO+oFFcyGpzZC2bzJko4uH8zMkl79MuwKgItzM8o8+PfYS0qA2j6wk+AKTsE=
X-Received: by 2002:a17:90b:33c3:b0:20a:ebc3:6514 with SMTP id
 lk3-20020a17090b33c300b0020aebc36514mr4971248pjb.147.1664994652315; Wed, 05
 Oct 2022 11:30:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220927153338.4177854-1-me@inclyc.cn> <20221005072913.982634-1-me@inclyc.cn>
In-Reply-To: <20221005072913.982634-1-me@inclyc.cn>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 5 Oct 2022 11:30:40 -0700
Message-ID: <CAKwvOdm6wSgG-_HrRR_9+mLnksbK4qNA8-F--bAVTjwY1C4brA@mail.gmail.com>
Subject: Re: [PATCH v2] x86/fpu: use _Alignof to avoid UB in TYPE_ALIGN
To:     YingChi Long <me@inclyc.cn>
Cc:     bp@alien8.de, chang.seok.bae@intel.com,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        pbonzini@redhat.com, tglx@linutronix.de, x86@kernel.org,
        peterz@infradead.org, david.laight@aculab.com
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

On Wed, Oct 5, 2022 at 12:29 AM YingChi Long <me@inclyc.cn> wrote:
>
> Kindly ping :)

Hi YingChi,
Sorry for the delay in review.

I think https://godbolt.org/z/sPs1GEhbT has convinced me that
TYPE_ALIGN is analogous to _Alignof and not __alignof__; so your patch
is correct to use _Alignof rather than __alignof__.  I think that test
case demonstrates this clearer than the other links in the commit
message.  Please consider replacing the existing godbolt links with
that one if you agree.

Please reword the paragraphs in the commit message from:
```
In PATCH v1 "TYPE_ALIGN" was substituted with "__alignof__" which is a
GCC extension, which returns the *preferred alignment*, that is
different from C11 "_Alignof" returning *ABI alignment*. For example, on
i386 __alignof__(long long) evaluates to 8 but _Alignof(long long)
evaluates to 4. See godbolt links below.

In this patch, I'd like to use "__alignof__" to "_Alignof" to preserve
the behavior here.
```
to:
```
ISO C11 _Alignof is subtly different from the GNU C extension
__alignof__. _Alignof expressions evaluate to a multiple of the object
size, while __alignof__ expressions evaluate to the alignment dictated
by the target machine's ABI.  In the case of long long on i386,
_Alignof (long long) is 8 while __alignof__ (long long) is 4.

The macro TYPE_ALIGN we're replacing has behavior that matches
_Alignof rather than __alignof__.
```
In particular, I think it's best to avoid language like "returns" in
favor of "evaluates to" since these are expressions, not function
calls.  I think it's also good to avoid the term "preferred alignment"
since that isn't meaningful; it looks like it was pulled from one of
the GCC bug reports rather than the GCC docs or latest ISO C standard
(https://www.open-std.org/jtc1/sc22/wg14/www/docs/n3054.pdf).  I'm not
sure that the links to the GCC bug tracker add anything meaningful
here; I think those can get dropped, too.  It's also perhaps confusing
to refer to earlier versions of the patch.  One thing you can do is
include comments like that "below the fold" in a commit message as a
meta comment to reviewers.  See
https://lore.kernel.org/llvm/20220512205545.992288-1-twd2.me@gmail.com/
as an example of commentary "below the fold" on differences between
patch versions.  Text in that area is discarded by git when a patch is
applied.

With those changes to the commit message in a v3, I'd be happy to sign
off on the change.  Thanks for your work on this!
-- 
Thanks,
~Nick Desaulniers
