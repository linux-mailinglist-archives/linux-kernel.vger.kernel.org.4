Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 667485E69F4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 19:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbiIVRxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 13:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiIVRxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 13:53:13 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF37103FF0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 10:53:12 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-12b542cb1d3so14892283fac.13
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 10:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=xx8/hTLwW8xNGeq7Lk/5IjrOS3Brq0vxjqtu9F4GI1M=;
        b=VTOYuTLEi50gG6KIrbl9wsk80XvEjE3JSrIrFmEVdsyd4EpYZZ2JeT/cYMj6DccVfh
         paPuDjzmNFuRFte/dyasDnWkUMKJFTmWmGkzvf0Lgut9+uJnKNdFt37UwTXE5JYAwCm4
         RCka9wJKHfFbhVSyQuKNo5xTtf0L/p8rQ49Hq3Etsfv9reD6fR/gV+6dydefIeD+Mq33
         fiosPow8AHXG7Z8q2fp9XGRrVupVxE+P9SWC8n+v+IxBWQNMWTzVWGpxbfDiEAicxKk/
         DeMLrMVE9AKtkoz5SSZgRy+UtjN/X3MUwwEtMRSE0/XbGBK/gRkL48wp/43MNePeMPP2
         q8Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=xx8/hTLwW8xNGeq7Lk/5IjrOS3Brq0vxjqtu9F4GI1M=;
        b=p1G6W7xXMpUL5/th+SDPRXsXR4KGSsNa/uI8w3SoR4NY/3tEe0pjhwkYSd2XJpjtI9
         o4sfxj3mp6JA4iOoBw83LIDZD5xGxnNRtdRxrRkCL5fZ6xSiIP8RW6yAkCDikSVcKz5b
         Ko25nSnMigbYQzFCmHSdF1piTmeWLrzC8mU+mo8QfdXLvJXD8sCXF+VFxAqtOk8NVhgS
         /dp1KIGZD6UOdIGM8Vl0IEf2/dIv2yuVWvThOzmFWaR4vR+FnDi2IS2Yx/VJYFWSqQl6
         54Y42Zfb7izS1Zffmjg9n+cpZ1HFV9vmHjKY83NnbK7bz6E0sl5vLK05yvjEy/qqEaV4
         nQew==
X-Gm-Message-State: ACrzQf22L0xBbKHqV84nEe5K/nsWZvgzWtMyrGnJQotMzG4lLlojC40i
        2NQpBKL9kjpiW3j754yii4DmOY1udlaZl9X0/3rRrg==
X-Google-Smtp-Source: AMsMyM5+BzfItPpe+PRx6+ilxZfavGRYnkVx6PXMPyXiwe6iHkk7muBkXh/kJeOfVLV3LTQRGRSKxXfaUPdvlb6LZUQ=
X-Received: by 2002:a05:6870:580c:b0:12a:f136:a8f5 with SMTP id
 r12-20020a056870580c00b0012af136a8f5mr8773540oap.269.1663869192083; Thu, 22
 Sep 2022 10:53:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220908233134.3523339-1-seanjc@google.com> <CALzav=cZBsmtD3+hBko3kW6bh2+RC7j533r94576ExuPx7SgEQ@mail.gmail.com>
In-Reply-To: <CALzav=cZBsmtD3+hBko3kW6bh2+RC7j533r94576ExuPx7SgEQ@mail.gmail.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 22 Sep 2022 10:53:01 -0700
Message-ID: <CALMp9eTgQyj22XgO4r1MYvjh4UVC3+4KF+xMUZxV50W3iYYgVw@mail.gmail.com>
Subject: Re: [PATCH 0/5] KVM: selftests: Fix "fix hypercall test" build errors
To:     David Matlack <dmatlack@google.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
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

On Thu, Sep 22, 2022 at 10:20 AM David Matlack <dmatlack@google.com> wrote:
>
> On Thu, Sep 8, 2022 at 4:34 PM Sean Christopherson <seanjc@google.com> wrote:
> >
> > After a toolchain upgrade (I think), the x86 fix_hypercall_test started
> > throwing warnings due to -Werror=array-bounds rightly complaining that
> > the test is generating an out-of-bounds array access.
> >
> > The "obvious" fix is to replace the memcpy() with a memcmp() and compare
> > only the exact size of the hypercall instruction.  That worked, until I
> > fiddled with the code a bit more and suddenly the test started jumping into
> > the weeds due to gcc generating a call to the external memcmp() through the
> > PLT, which isn't supported in the selftests.
> >
> > To fix that mess, which has been a pitfall for quite some time, provide
> > implementations of memcmp(), memcpy(), and memset() to effectively override
> > the compiler built-ins.  My thought is to start with the helpers that are
> > most likely to be used in guest code, and then add more as needed.
>
> Ah ha! This also fixes an issue I've long since noticed and finally
> got around to debugging this morning. userspace_io_test fails for me
> when built with Clang but passes with GCC. It turns out Clang
> generates a call to <memset@plt>, whereas GCC directly generates rep
> stos, to clear @buffer in guest_code().

Hey! Did I miss a revert of commit ed290e1c20da ("KVM: selftests: Fix
nested SVM tests when built with clang") in that patch set?
