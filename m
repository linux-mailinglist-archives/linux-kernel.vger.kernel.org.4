Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19F85EB5D8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 01:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiIZXgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 19:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbiIZXgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 19:36:07 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46608876A7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 16:36:06 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id z20so729469plb.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 16:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=0Ri0hdyjjQOCW9kUZSLE4SDFJDME1VH1Qa6o9N0mexY=;
        b=AGkHGYtfdRbpfuxKoojjixISpAe8IesyJuPmj6h2nNoEMMJKdqYuOf258wbI5GGL6h
         StWZAJ6gBdgJfEm7YNyxsKCadRk573WbDemjW9XH4S6sNbHohLtF3YualJcz36w0IE74
         u03tAXARDZrQEUXYN/A5n7FbVgPQ1Wu6pmOmaBS2p4leqvBaiJ4piNB5Dh5L8gyAmsJs
         AYoxkn4/KWAr/UgYTJ1kUMS6BnuNSot1h3Hbbi8Wy7T6PzoQhUvXs2YjUPdKJXtxsfHl
         yH/sPogyTHv3DwHHoHckWUHaQ9HdPl89utssdsjjy72lpyU+QM1NUp1FL/7Pz5b2/pF9
         q8LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=0Ri0hdyjjQOCW9kUZSLE4SDFJDME1VH1Qa6o9N0mexY=;
        b=xIun3LLyNNbgI9pbd8/rZj+ysseQC7Bz2UlUdlCXyOfeuu2U/JnqnrCWZAU4yAmIAE
         BIvH9q8MV9Vh9Pv9PfRgD2URCjufrN4A/eVGRr9p2fm/r5DsdkGieBCztnE3yVwf4XLp
         HdLDYVW6KRh/ShIz4FguR3/uBtr31hDrGQZiVEy3Ar4TB+MxKRbEU0g0DsZYEg7jU7qM
         h1HAQATQdB2JAWBaEX7g4vghFbYWdtCRclWVpfbWY6Du/MU3y0QxKuY9QeSKW6Wmn/Ae
         LHKGBRTqKVmkpAdw+aoIB0NOrSs7wBHDwYBsmWK9TuQXijK3qNx2wrrTB2Pdr1nxJ0SI
         WXMQ==
X-Gm-Message-State: ACrzQf2Gx3YXMwMaYd2N2pNY8o0rH4IYU645P7MT7TDUsyaP2R6Vs5kr
        v5576xEj5f9IAMsvF/LHlAwaBZ4cRZw2epGCeDqywwNiEj0=
X-Google-Smtp-Source: AMsMyM7g50/OEn6XsgXnuVK+DYvnqUG0NJ6k22vHXlyV7oD0oosObQo+N9q/cHWolJpYaKNE/7WziFhf7YP1VRbg2Tk=
X-Received: by 2002:a17:90b:384b:b0:200:3215:878b with SMTP id
 nl11-20020a17090b384b00b002003215878bmr1246782pjb.176.1664235365540; Mon, 26
 Sep 2022 16:36:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220915000448.1674802-1-vannapurve@google.com>
 <20220915000448.1674802-8-vannapurve@google.com> <YyuFkmJRP/4ynKqD@google.com>
In-Reply-To: <YyuFkmJRP/4ynKqD@google.com>
From:   Vishal Annapurve <vannapurve@google.com>
Date:   Mon, 26 Sep 2022 16:35:54 -0700
Message-ID: <CAGtprH8SVWQM=NpNaQtDsg7d=xuQJS-JRzw9KZ0XvV8KdRCkow@mail.gmail.com>
Subject: Re: [V2 PATCH 7/8] Kvm: selftests: x86: Execute cpu specific vmcall instruction
To:     David Matlack <dmatlack@google.com>
Cc:     x86 <x86@kernel.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, shuah <shuah@kernel.org>,
        Ben Gardon <bgardon@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Oliver Upton <oupton@google.com>, peterx@redhat.com,
        Vitaly Kuznetsov <vkuznets@redhat.com>
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

On Wed, Sep 21, 2022 at 2:43 PM David Matlack <dmatlack@google.com> wrote:
>
> On Thu, Sep 15, 2022 at 12:04:47AM +0000, Vishal Annapurve wrote:
> > Update the vmcall instruction invocation to happen according to the cpu
> > type.
> >
> > Suggested-by: Sean Christopherson <seanjc@google.com>
> > Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> > ---
> >  tools/testing/selftests/kvm/include/x86_64/processor.h    | 8 ++++++++
> >  tools/testing/selftests/kvm/x86_64/vmx_apic_access_test.c | 2 +-
> >  .../selftests/kvm/x86_64/vmx_nested_tsc_scaling_test.c    | 2 +-
> >  tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c  | 2 +-
>
> What's the reason to use kvm_hypercall() for these tests? All of these
> are Intel-specific. i.e. is_amd_cpu() will always return false.
>

That's right. This change is attempting to have hypercalls from guest
code done via a common API as far as possible.

> >  4 files changed, 11 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
> > ...
> > --
> > 2.37.2.789.g6183377224-goog
> >
