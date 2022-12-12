Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F369164A486
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 17:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiLLQBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 11:01:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbiLLQBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 11:01:19 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9EF95A3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 08:01:18 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id h6so120961iof.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 08:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/NeFznWR0ULlrkxNZ94eeYdH6fRsw0PGtJw8DSFEPf4=;
        b=ovvTcWS7RZFaNJWyIFQAg9zUL2MuG75Rqo9oCtt/jukSEcBozO7kB7Z8RxrrjgNFug
         uig+PG9JTA9+hAN8uoffZqee6+qDpvXhcil9iqTMK+dxS7FF6RT76+69whFsclH84jA3
         p/OfrJBdUzmzCmGrFA4ro+LOl8o5zsK0ZBBV0HE5AnFHisEV4QYSldcvX3pneuQ3u8Vg
         11ucF4ObfN0NeMSC3RYnQ3vUQskjaLEx+jaAQSu0AOy6I+QXbvUePYnxcyAYwKWhOwLN
         TNwrNafiBvCayBuZDn6O//8QxZF72Nc/Asuu+ahihwhHRUJV28/fLaZZtk/iB0QO883T
         j/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/NeFznWR0ULlrkxNZ94eeYdH6fRsw0PGtJw8DSFEPf4=;
        b=qu0eX7matsBhazM4u+BTRPgpJkrV/nqrwBXbDkpR/r2mKFPwWAFedr4MRDwvf/0ST6
         DkyAC78qNxgBEqXyau+Bj3WRI1prmM+3PJXQBAg5aW1SVaNk60crqWHrnR48aOY2bg2y
         9+fuy/EJKS37wZJAE6RFfncS6mYWd7cOskFp7h+YQaIaA5akcM6ubhpVxHqHWm81pv3I
         FA5Kgm7g2YyAyZ70thXOWKd+xrqIaJ4bGvt07Z0DLPb0aWIMfA+7VOMO4lFlCpXrBrww
         2puXtl3KmNtpJNi3/V+FHCxRds3i2t0ozbflLi4ITqaSYkShRgCNA8um4mgpOBHLp2UD
         udHw==
X-Gm-Message-State: ANoB5pkhz8Hh2Bes0r5LIX8X5M0ZDGw98qISMAeHCVub+yBr8+zflfY4
        PbR7JchR3QDFMXl9Ev+NoR9g2wT7ZGKCTwEcMmaj9g==
X-Google-Smtp-Source: AA0mqf4TIxQiVuqebsemYtwT7zRQ4I7GltT+Q37EmQfWY2OQedW6iBgtHZqhGTq7O0/S/oF/7AI2bK/xymdUAdK/F3s=
X-Received: by 2002:a05:6638:3786:b0:363:b82d:d510 with SMTP id
 w6-20020a056638378600b00363b82dd510mr44610550jal.112.1670860877213; Mon, 12
 Dec 2022 08:01:17 -0800 (PST)
MIME-Version: 1.0
References: <20221205191430.2455108-1-vipinsh@google.com> <20221205191430.2455108-13-vipinsh@google.com>
 <Y5OtpwM8ue8nZwG/@google.com> <Y5PlW+U2MblIObHT@google.com>
In-Reply-To: <Y5PlW+U2MblIObHT@google.com>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Mon, 12 Dec 2022 08:00:00 -0800
Message-ID: <CAHVum0c8HXQhj9sgzsn=VbZ+2LYgW1JE4EkQePMRQKbjypCd5g@mail.gmail.com>
Subject: Re: [Patch v3 12/13] KVM: selftests: Make vCPU exit reason test
 assertion common.
To:     Sean Christopherson <seanjc@google.com>
Cc:     David Matlack <dmatlack@google.com>, pbonzini@redhat.com,
        vkuznets@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Fri, Dec 9, 2022 at 5:48 PM Sean Christopherson <seanjc@google.com> wrote:
>
> On Fri, Dec 09, 2022, David Matlack wrote:
> > On Mon, Dec 05, 2022 at 11:14:29AM -0800, Vipin Sharma wrote:
> > > Make ASSERT_EXIT_REASON() macro and replace all exit reason test assert
> > > statements with it.
> > >
> > > No functional changes intended.
> > >
> > > Suggested-by: David Matlack <dmatlack@google.com>
> > > Signed-off-by: Vipin Sharma <vipinsh@google.com>
> >
> > Reviewed-by: David Matlack <dmatlack@google.com>
> >
> > > ---
> > >  .../testing/selftests/kvm/aarch64/psci_test.c |  4 +--
> > >  .../testing/selftests/kvm/include/test_util.h | 10 ++++++++
> > [...]
> > >  .../selftests/kvm/x86_64/xapic_ipi_test.c     |  6 +----
> > >  .../selftests/kvm/x86_64/xen_shinfo_test.c    |  7 +-----
> > >  .../selftests/kvm/x86_64/xen_vmcall_test.c    |  5 +---
> > >  44 files changed, 71 insertions(+), 293 deletions(-)
> >
> > Nice diff stat :)
>
> I like the diffstat too, but I think we need a slightly different name for the
> macro.  "EXIT_REASON" can be interpreted as "hardware exit reason" or "KVM exit
> (to userspace) reason".  Most usage will be fairly obvious, but I'd like to avoid
> confusion when swapping between selftests and KVM-unit-tests (which often asserts
> on the hardware exit reason).   The name will be a bit longer, but I don't think
> line length with ever be a problem.  And most people will just copy+paste so finger
> fatigue likeliy won't be an issue either.
>
> I also vote to prefix it with TEST, i.e. TEST_ASSERT_KVM_EXIT_REASON(), for
> consistency and to make it very clear it's a TEST_ASSERT() wrapper.  ASSERT_EQ()
> makes me twitch every time I see it.  This is definitely a personal preference
> (or problem) I can survive with though :-)

I will send a patch with TEST_ASSERT_KVM_EXIT_REASON. No one should
twitch while reading code!
