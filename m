Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB206B9A7B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 17:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjCNQA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 12:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjCNQA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 12:00:56 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC9B2A161
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 09:00:55 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id x14so14508673vso.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 09:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678809654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uby9qlcFKmMY2fsZUKJLGUq3FWjzW0DSSs7z/4wZjPc=;
        b=DeQ6DMTwPYVJOy67swDKCZkFrTsT6aC7WKKM6LuOrsZSMHJvovMsb9sFSn8hEDS/DB
         UzxtLwtMXOD9+lqIAQ6LO7i9mKaClTb2GhS3+mZNobCXT5SGA2DfeLlOxpUh68inj4o4
         WI1eH/7ptO19emktw++HegtvaBvCiK7IecZ2g4Hz5oBp3tx9I/lgOYMcklqG4l1zXPly
         SGxpBXArcOHkkMCjdoC1Hyq3sC7q6iYI4uxvS9KsyyIYZhOM/ubMaCMnBxXjkXggjTHK
         0hccdd9mzHlBkJK1bjW3fraWcutiqJ8uHu85PrTxuoQe54fSjN4ifLx3MD8AZaKwbOjP
         Cp4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678809654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uby9qlcFKmMY2fsZUKJLGUq3FWjzW0DSSs7z/4wZjPc=;
        b=j9CundVfzlu30nSlAGuHHfvxjltB4zUwp/yw3Hru5K198qF0Im254qj5fIv7NeH6/d
         /Rbq2VATXHXYMMZv3yssopvpebkrzPRzrlXYAn47h0/rZXMBg54K109VxpizZLB0rWej
         CW+exDcOE74oxKG5jiy8CcD1tuhear7Rz2jaZFHJ/3DpuYDod8IMXPpETa1r8f9roL3k
         bqgmfZOlXNLytKYeUQ9MO7KyzEuYAlHRVeIJ1y8n9pA8Zv5yEGLFaVp+CU3VT+vLQ59y
         1g6PqHMI209Uh3J6pcs7XJ/+zvqD9pno4ghgu+UUhUDhxzxZiBM/hItvmCEL8a7uxROK
         5Ozw==
X-Gm-Message-State: AO0yUKUXGlOHS/cVdxmuio4bUJNUUVhe0NRnvm0bya8Bzx3Dtbirgv+x
        vuWZCVjYEpPq5y1c/8cYGRfILsWqCETvtp8LYroyNA==
X-Google-Smtp-Source: AK7set+JhqzS0W9CSOklKEQKTPAJWFCt+2/xyhR2xXzm6EQAcRxtGVgrMWA5Xiu7RQGE33YvU8AhvlCh5c8PM8ZXTmo=
X-Received: by 2002:a67:d81b:0:b0:423:e7f7:bc52 with SMTP id
 e27-20020a67d81b000000b00423e7f7bc52mr7079439vsj.2.1678809654397; Tue, 14 Mar
 2023 09:00:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230131181820.179033-1-bgardon@google.com> <CABgObfaP7P7fk66-EGF-zPEk0H14u3YkM42FRXrEvU=hwFSYgg@mail.gmail.com>
 <CABgObfYAStAC5FgJfGUiJ=BBFtN7drD+NGHLFJY5fP3hQzVOBw@mail.gmail.com>
In-Reply-To: <CABgObfYAStAC5FgJfGUiJ=BBFtN7drD+NGHLFJY5fP3hQzVOBw@mail.gmail.com>
From:   David Matlack <dmatlack@google.com>
Date:   Tue, 14 Mar 2023 09:00:28 -0700
Message-ID: <CALzav=c-wtJiz9M6hpPtcoBMFvFP5_2BNYoY66NzF-J+8_W6NA@mail.gmail.com>
Subject: Re: [PATCH V5 0/2] selftests: KVM: Add a test for eager page splitting
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Ricardo Koller <ricarkol@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Mar 14, 2023 at 7:23=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> On Tue, Mar 14, 2023 at 2:27=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.co=
m> wrote:
> > I have finally queued it, but made a small change to allow running it
> > with non-hugetlbfs page types.
>
> Oops, it fails on my AMD workstation:
>
> $ tools/testing/selftests/kvm/x86_64/dirty_log_page_splitting_test
> Testing guest mode: PA-bits:ANY, VA-bits:48,  4K pages
> guest physical test memory: [0x7fc7fe00000, 0x7fcffe00000)
> =3D=3D=3D=3D Test Assertion Failure =3D=3D=3D=3D
>   x86_64/dirty_log_page_splitting_test.c:195: __a =3D=3D __b
>   pid=3D1378203 tid=3D1378203 errno=3D0 - Success
>      1    0x0000000000402d02: run_test at dirty_log_page_splitting_test.c=
:195
>      2    0x000000000040367c: for_each_guest_mode at guest_modes.c:100
>      3    0x00000000004024df: main at dirty_log_page_splitting_test.c:245
>      4    0x00007f4227c3feaf: ?? ??:0
>      5    0x00007f4227c3ff5f: ?? ??:0
>      6    0x0000000000402594: _start at ??:?
>   ASSERT_EQ(stats_populated.pages_4k, stats_repopulated.pages_4k) failed.
>     stats_populated.pages_4k is 0x413
>     stats_repopulated.pages_4k is 0x412
>
> Haven't debugged it yet.

I wonder if pages are getting swapped, especially if running on a
workstation. If so, mlock()ing all guest memory VMAs might be
necessary to be able to assert exact page counts.

>
> Paolo
>
