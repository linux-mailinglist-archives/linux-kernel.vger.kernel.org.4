Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACF45E6985
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 19:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbiIVRUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 13:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbiIVRUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 13:20:35 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79ACAE85D
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 10:20:32 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id l14so7285417qvq.8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 10:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=L+hUS18FjKhDBi5w5G5e0atSm1N+NkDOa+dZsLxbTeU=;
        b=HQcEvIGpM8+Dg9UxOlk23tDZS1GUzyrxbG5DGuCAGodGaEih+WTEvqZFxKJVAg30m1
         hXR8HTbg8tk5+dyk8WIoElKbp3XX/IXwLbTmBD7d2HMC2cmg3CxnffOJE+Xkhj4jtFJw
         HUOsbSCHOKMm3psSSLbOG+X9mDRDN8PDuRxfX0JeUbX6ldlhg71Lfvo1l0OXSOe14qYw
         sXen4mbppBcEnl5dviuX1+gmJufwPwQwsnNNX5WVJLJ3b+gA3Mhzh8g156fpFEmP9X9r
         A/DX1kWX9ITjm7pTxKzWE4YkTjlTGsMpI9+J8hJnhNHBsX+EeM3FGXvIfyqL0Rqf9VYE
         NIaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=L+hUS18FjKhDBi5w5G5e0atSm1N+NkDOa+dZsLxbTeU=;
        b=SxjwRHZsLmUKuoP2KUq7F7elihyaU4cVCstI5EcDw5VaGDBr0mk/5GOt4mSrfySzXz
         tVClirvWe+G8IOWOiEkT4YRBxFOFdSJ8WBfNIdoxGfHsBu7W5ZPjtdM3CnedWHCur7Iy
         HEYooGkUOh8+a/AscrVCGc+3ks4Dq/I+GvPOH5MFGqHTWNTsvfwGOt1J8ML39Cd5W8un
         4aRjiCBMq1Og2GvZeAs/QhHXGzpm4zmwiTlPjuT0BRRBdLbuboL9phyoRVZGXI5SpS6U
         usrllHSC2V1fGzkAfmyBPBVgpDoV/efvPpqw5n9iVbTTJOXlqgem8Agw4ejo1Y4KhtMu
         YVTA==
X-Gm-Message-State: ACrzQf1Wc263i0M4eXzaL2JzEgIADYKZLSt1pusdMsvh2Rjs+/RSMg/h
        42irXCW54qi/s03BcSv085shdIxRac6cNWuUYBPJyg==
X-Google-Smtp-Source: AMsMyM5Woq9JghWWwDSCVEm6zy5xvXQ8FWMqpx0uPm8tpxy6bwABmAjI4dIWHoVRUD/VOqOJxrIgQUbFFFzjNTDN7Wk=
X-Received: by 2002:a05:6214:c2a:b0:4ad:67d:c25a with SMTP id
 a10-20020a0562140c2a00b004ad067dc25amr3554774qvd.125.1663867231753; Thu, 22
 Sep 2022 10:20:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220908233134.3523339-1-seanjc@google.com>
In-Reply-To: <20220908233134.3523339-1-seanjc@google.com>
From:   David Matlack <dmatlack@google.com>
Date:   Thu, 22 Sep 2022 10:20:05 -0700
Message-ID: <CALzav=cZBsmtD3+hBko3kW6bh2+RC7j533r94576ExuPx7SgEQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] KVM: selftests: Fix "fix hypercall test" build errors
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 8, 2022 at 4:34 PM Sean Christopherson <seanjc@google.com> wrote:
>
> After a toolchain upgrade (I think), the x86 fix_hypercall_test started
> throwing warnings due to -Werror=array-bounds rightly complaining that
> the test is generating an out-of-bounds array access.
>
> The "obvious" fix is to replace the memcpy() with a memcmp() and compare
> only the exact size of the hypercall instruction.  That worked, until I
> fiddled with the code a bit more and suddenly the test started jumping into
> the weeds due to gcc generating a call to the external memcmp() through the
> PLT, which isn't supported in the selftests.
>
> To fix that mess, which has been a pitfall for quite some time, provide
> implementations of memcmp(), memcpy(), and memset() to effectively override
> the compiler built-ins.  My thought is to start with the helpers that are
> most likely to be used in guest code, and then add more as needed.

Ah ha! This also fixes an issue I've long since noticed and finally
got around to debugging this morning. userspace_io_test fails for me
when built with Clang but passes with GCC. It turns out Clang
generates a call to <memset@plt>, whereas GCC directly generates rep
stos, to clear @buffer in guest_code().
