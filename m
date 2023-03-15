Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDB86BBD20
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 20:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjCOTW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 15:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjCOTWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 15:22:24 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9E182A90
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 12:22:22 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id i11-20020a256d0b000000b0086349255277so21502696ybc.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 12:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678908142;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IjQU/FMea+bquT8yzAW8th5tVg0rB5Baq1V5vXqzqGY=;
        b=Phpx2ynRY3JKv3qNmSvS84Ce3Yws9EzckL7k1b/oWXMGc5kARSVhY/AKXnpnE3P6KN
         y3QG0khv+ywkkz9ec7yiMmLcLsL5uuaA6nc0EHMPTjnhzCV9yimOWBfe+rpbQGAgEbWT
         ltaSJIaQv6of2fDWKyxeMMj/9OoaKTN57ksm4/atKr9NXAClBp3udboLzHmxOSyk/sR4
         QekMzPnMrlKFVYl4wkrSV3RwZRhVTQ2XfjGRWJkzweb4SEC+P+/3AjmeouRHwR3ByRSs
         PeTQyHoFGDUYa7LG+ElzA0FnD34ozwJxxnvqZ8/VZpCPTy4b+Fa+70f9gO9EC0Kd9Fw/
         W5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678908142;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IjQU/FMea+bquT8yzAW8th5tVg0rB5Baq1V5vXqzqGY=;
        b=riYAU4oUBKPSKwlIpIYB1LwX7tuLFBwz3w7DKft67P66wpoG6Ig8URI7OZXF2JRHSl
         waApOjxtr7n19WuEkLrlpZI6kl6RQJoBxEo7P8Sh50pS0M9Bmt4hZveZmEPQ76qFBhTd
         W2IKNdU6do7SjV2zfxGs5ld+AvXB1YAizCqkRUWMvNNtEBZ2bwdFVtV8jv0PXXAYcdPl
         +UXumXfU+LWMsWRW3lPC3cVlzOWm6K6stWfvNGYbHVMyKcfNFqInkeRpaws26HFSr7TW
         HoxLTjAIvqP5LNUFyAyYJUJrmWPynrntRNHxJHc5tS//40VoLDdALF/VJeHrPeszyCBm
         zrnQ==
X-Gm-Message-State: AO0yUKUppT7g5eupXqboyh8pu8gUnPdEwpMUtHj9+mOaESNPiGKz9LGN
        I1zHPWxGqUy2wFFUbKymp0SvygWtWNc=
X-Google-Smtp-Source: AK7set+yPSQMufcBA3Wod7SHFhqapWTyhQvb2TsJYI7z7tzGCh4CGJEUdQrR39DD0blFSJQnc3Zu7+rGGl8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:8f8c:0:b0:b21:a3b8:45cd with SMTP id
 u12-20020a258f8c000000b00b21a3b845cdmr16322454ybl.0.1678908142135; Wed, 15
 Mar 2023 12:22:22 -0700 (PDT)
Date:   Wed, 15 Mar 2023 12:22:20 -0700
In-Reply-To: <199f404d-c08e-3895-6ce3-36b21514f487@redhat.com>
Mime-Version: 1.0
References: <20230131181820.179033-1-bgardon@google.com> <CABgObfaP7P7fk66-EGF-zPEk0H14u3YkM42FRXrEvU=hwFSYgg@mail.gmail.com>
 <CABgObfYAStAC5FgJfGUiJ=BBFtN7drD+NGHLFJY5fP3hQzVOBw@mail.gmail.com>
 <CALzav=c-wtJiz9M6hpPtcoBMFvFP5_2BNYoY66NzF-J+8_W6NA@mail.gmail.com>
 <CABgObfYm6roWVR0myT5rHUWRe7k09TkXgZ7rYAr019QZ80oQXQ@mail.gmail.com> <199f404d-c08e-3895-6ce3-36b21514f487@redhat.com>
Message-ID: <ZBIa7NQI4qRP6uON@google.com>
Subject: Re: [PATCH V5 0/2] selftests: KVM: Add a test for eager page splitting
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Peter Xu <peterx@redhat.com>,
        Vipin Sharma <vipinsh@google.com>,
        Ricardo Koller <ricarkol@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023, Paolo Bonzini wrote:
> On 3/15/23 13:24, Paolo Bonzini wrote:
> > On Tue, Mar 14, 2023 at 5:00=E2=80=AFPM David Matlack <dmatlack@google.=
com> wrote:
> > > I wonder if pages are getting swapped, especially if running on a
> > > workstation. If so, mlock()ing all guest memory VMAs might be
> > > necessary to be able to assert exact page counts.
> >=20
> > I don't think so, it's 100% reproducible and the machine is idle and
> > only accessed via network. Also has 64 GB of RAM. :)
>=20
> It also reproduces on Intel with pml=3D0 and eptad=3D0; the reason is due
> to the different semantics of dirty bits for page-table pages on AMD
> and Intel.  Both AMD and eptad=3D0 Intel treat those as writes, therefore
> more pages are dropped before the repopulation phase when dirty logging
> is disabled.
>=20
> The "missing" page had been included in the population phase because it
> hosts the page tables for vcpu_args, but repopulation does not need it.
>=20
> This fixes it:
>=20
> -------------------- 8< ---------------
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH] selftests: KVM: perform the same memory accesses on ever=
y memstress iteration
>=20
> Perform the same memory accesses including the initialization steps
> that read from args and vcpu_args.  This ensures that the state of
> KVM's page tables is the same after every iteration, including the
> pages that host the guest page tables for args and vcpu_args.
>=20
> This fixes a failure of dirty_log_page_splitting_test on AMD machines,
> as well as on Intel if PML and EPT A/D bits are both disabled.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>=20
> diff --git a/tools/testing/selftests/kvm/lib/memstress.c b/tools/testing/=
selftests/kvm/lib/memstress.c
> index 3632956c6bcf..8a429f4c86db 100644
> --- a/tools/testing/selftests/kvm/lib/memstress.c
> +++ b/tools/testing/selftests/kvm/lib/memstress.c
> @@ -56,15 +56,15 @@ void memstress_guest_code(uint32_t vcpu_idx)
>  	uint64_t page;
>  	int i;
> -	rand_state =3D new_guest_random_state(args->random_seed + vcpu_idx);
> +	while (true) {
> +		rand_state =3D new_guest_random_state(args->random_seed + vcpu_idx);

Doesn't this partially defeat the randomization that some tests like want? =
 E.g.
a test that wants to heavily randomize state will get the same pRNG for eve=
ry
iteration.  Seems like we should have a knob to control whether or not each
iteration needs to be identical.
