Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4375EB5DB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 01:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbiIZXhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 19:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiIZXhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 19:37:39 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0938287F9C
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 16:37:37 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so14005154pjq.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 16:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=KjIJcMu3j47863rruoPF+gRowBl1pX33rzUpZJzpgKY=;
        b=kA3Wow+Cy1NPefOHwt4wlLxeC3b4cz0oOKWyCx8F6hj0fHOKBrI5p/iJKBaXHWEZ/0
         dg8TKvgE4ZisSNAg+pvZ2rrH6uPErC15MDJcPUBOHRFfv/n40crMquSW9uAZh5tNpO97
         oYKAKSIbjzO6DB9ivITC48fSSmSkvpPv57YbuczBAHp/IyaU5wTCZo2xTpQhmJl80HDA
         L8dAxxbLUuGq/EvQEf08+mKOS4pv+nGZRozVveLl3enya8GECDeykoItZI9tUZFcg2es
         eisFgmhl+oN8AvJy3bTszGK/leazPVzDWdgHib4WBV1dBWfkA9/YJnLCs3IZavSMVpD/
         Bj8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=KjIJcMu3j47863rruoPF+gRowBl1pX33rzUpZJzpgKY=;
        b=HzN6bcthnnUXlaVlV9wAhd65Pi/afC5mcEJ2G3KRcQjU+uF8DlA/8H2jfn4qCV+Z2p
         wq3UDBgyctTws0TSxINOc7wzEiD7W8hO9sIWHpL2HZo25CA0YEnp6fkgO9dXHVZ6ZWC1
         9YFiHtACS+0onALnwY3EGuSZiFUGd4/C5l5FGMQ0rbqJjqxepaZXtHfvEz4hrL8JPmcV
         dd5bAoErAufI2WOyaGLCpqEAB/z4/HKtrfEabtJIwklrp9xj080LOsGhWkTouKPaN3QQ
         V8odtMtGHFdVR/H3vdmviArJSSRepe2m5c8fYV4rxJYAdNhU/PABXuBG690gXgSJbx85
         IvEQ==
X-Gm-Message-State: ACrzQf3u7RYCU8bfU2RgTPsGtGPbmbF5Q8KUQ6rXipaqTWCAebtAGIZ3
        +rsmqMZJFcLGNBvMn3HztTx/d2I2lZ8Zu0mvLO55fQ==
X-Google-Smtp-Source: AMsMyM6AQvbyCxZs18zCw8yhX3gLnr4hVjYGPIHK/1lOaW50c7UnNTF6H7HSfrNfwg5vbOtFxhhGXJTUXuiWW54RNpE=
X-Received: by 2002:a17:902:d143:b0:178:456b:8444 with SMTP id
 t3-20020a170902d14300b00178456b8444mr24515711plt.137.1664235457301; Mon, 26
 Sep 2022 16:37:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220915000448.1674802-1-vannapurve@google.com>
 <20220915000448.1674802-9-vannapurve@google.com> <YyuGgX/wA+wvLiOg@google.com>
In-Reply-To: <YyuGgX/wA+wvLiOg@google.com>
From:   Vishal Annapurve <vannapurve@google.com>
Date:   Mon, 26 Sep 2022 16:37:26 -0700
Message-ID: <CAGtprH9n10JgKAR1ims-KJSG0ehOkqYR5EWx7MNZne7MXnAsPg@mail.gmail.com>
Subject: Re: [V2 PATCH 8/8] KVM: selftests: x86: xen: Execute cpu specific
 vmcall instruction
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

On Wed, Sep 21, 2022 at 2:47 PM David Matlack <dmatlack@google.com> wrote:
>
> On Thu, Sep 15, 2022 at 12:04:48AM +0000, Vishal Annapurve wrote:
> > Update xen specific hypercall invocation to execute cpu specific vmcall
> > instructions.
> >
> > Suggested-by: Sean Christopherson <seanjc@google.com>
> > Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> > ---
> >  .../selftests/kvm/x86_64/xen_shinfo_test.c    | 64 +++++++------------
> >  .../selftests/kvm/x86_64/xen_vmcall_test.c    | 14 ++--
> >  2 files changed, 34 insertions(+), 44 deletions(-)
> > ...
> > diff --git a/tools/testing/selftests/kvm/x86_64/xen_vmcall_test.c b/tools/testing/selftests/kvm/x86_64/xen_vmcall_test.c
> > index 88914d48c65e..e78f1b5d3af8 100644
> > --- a/tools/testing/selftests/kvm/x86_64/xen_vmcall_test.c
> > +++ b/tools/testing/selftests/kvm/x86_64/xen_vmcall_test.c
> > @@ -37,10 +37,16 @@ static void guest_code(void)
> >       register unsigned long r9 __asm__("r9") = ARGVALUE(6);
> >
> >       /* First a direct invocation of 'vmcall' */
> > -     __asm__ __volatile__("vmcall" :
> > -                          "=a"(rax) :
> > -                          "a"(rax), "D"(rdi), "S"(rsi), "d"(rdx),
> > -                          "r"(r10), "r"(r8), "r"(r9));
> > +     if (is_amd_cpu())
> > +             __asm__ __volatile__("vmmcall" :
> > +                     "=a"(rax) :
> > +                     "a"(rax), "D"(rdi), "S"(rsi), "d"(rdx),
> > +                     "r"(r10), "r"(r8), "r"(r9));
> > +     else
> > +             __asm__ __volatile__("vmcall" :
> > +                     "=a"(rax) :
> > +                     "a"(rax), "D"(rdi), "S"(rsi), "d"(rdx),
> > +                     "r"(r10), "r"(r8), "r"(r9));
>
> Can we create common helper functions or macros for doing hypercalls to
> reduce the amount of duplicated inline assembly?
>

Ack, will fix this in the next series.

> >       GUEST_ASSERT(rax == RETVALUE);
> >
> >       /* Fill in the Xen hypercall page */
> > --
> > 2.37.2.789.g6183377224-goog
> >
