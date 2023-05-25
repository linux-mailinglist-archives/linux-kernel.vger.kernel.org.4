Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D37D711021
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 17:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241798AbjEYPzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 11:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241156AbjEYPzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 11:55:33 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B4A18D
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 08:55:31 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5343c1d114cso1796458a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 08:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685030130; x=1687622130;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FJhJfniAgX/K6aNPg00s0hgGDGDmvcJtzARRej6TGOA=;
        b=JAaXmQsUiv1MMYlIIQMGz3uobblUt+My3r9AwWFGnhn64piKXxlgqJS5+wucLy7MX3
         8W/3BpF8qOQtu6SAArifGNKD3hCklvCmZpEX3UU9dlx0SdajPT2NtDYQWrTbkKG3Ojnf
         863L28cxpMROTC5dUKAGZYr2NkUtGUp1du0EBjsmVt7RAfEl4M1yaJle7dEFJ55egM3Y
         358v2Bftq3Nn8nSX2IALvmQ4d07XxVKxWUIfpH5C4Ty2GctFW5EfeIuFOkZEb8C4vLGf
         88mD9zkeC8Arr0UFhwosZRucjhhf4/uUv36ml6I9iMBgPxMHsLjIA9pZx5KYjuTACVIa
         61mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685030130; x=1687622130;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FJhJfniAgX/K6aNPg00s0hgGDGDmvcJtzARRej6TGOA=;
        b=Xh+nV9q9gY5DOsYFBJF3Qkl2Q+D9YIZwZTmFI/K5+WprgNm61jr6/J6/frD/8Dfxmh
         bMdOlA0l737PDDyGY3nB3visQeQCZPdvw1I4aJXbXKhxv7mTSmMY/VoiL+3Tk4qm+ISj
         TfaZlI0bJ1wo7oz5lS0l0WYH48jaoSvNBpfbn9xLWfuUvmyrnJHDVzY6THulq59Vx8DV
         tQHvXObRv9ubvaVfFd6DjZOd+NIkc0xcM8kbZJAMR6tVbgxBxFRu1qof5dYc02qGVF5g
         ljrfNVXpZG0797fHjlrqPGnguSbC9dF2EhKjDWSKYx/5P9w03lWTqqvvhHf4Gqel2s4d
         Fpvw==
X-Gm-Message-State: AC+VfDyu22LuD5YD6Fop7JiQ7iqSagh5ru67hDgggQyFydJVGAfjZFgp
        8IHnOp2/b5Zvdhc6xFMuNgMBDcYhL+w=
X-Google-Smtp-Source: ACHHUZ47p24uic5C5tj2sNPe5bf+qa+viyHFYH/qvq+YqkWURKU7nrdyH74GNV/lKXtUyQjQgvbLXa0+QgE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:9804:b0:24d:f3d9:48b5 with SMTP id
 z4-20020a17090a980400b0024df3d948b5mr505815pjo.3.1685030130685; Thu, 25 May
 2023 08:55:30 -0700 (PDT)
Date:   Thu, 25 May 2023 08:55:29 -0700
In-Reply-To: <CAFg_LQWdSnNOd+VwTu8pQezL7qaN=4L_YffHVQUQWJiV5U76wQ@mail.gmail.com>
Mime-Version: 1.0
References: <20230420104622.12504-1-ljrcore@126.com> <20230420104622.12504-8-ljrcore@126.com>
 <ZG6i3sqOcZDg/UCG@google.com> <CAFg_LQWdSnNOd+VwTu8pQezL7qaN=4L_YffHVQUQWJiV5U76wQ@mail.gmail.com>
Message-ID: <ZG+E8YtFtCbKn7fi@google.com>
Subject: Re: [PATCH v2 7/7] KVM: selftests: Test pmu event filter with
 incompatible kvm_pmu_event_filter
From:   Sean Christopherson <seanjc@google.com>
To:     Jinrong Liang <ljr.kernel@gmail.com>
Cc:     Like Xu <like.xu.linux@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>,
        Aaron Lewis <aaronlewis@google.com>,
        David Matlack <dmatlack@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023, Jinrong Liang wrote:
> Sean Christopherson <seanjc@google.com> =E4=BA=8E2023=E5=B9=B45=E6=9C=882=
5=E6=97=A5=E5=91=A8=E5=9B=9B 07:50=E5=86=99=E9=81=93=EF=BC=9A
> > > +static uint64_t test_incompatible_filter(struct kvm_vcpu *vcpu, uint=
32_t action,
> > > +                                      uint32_t bitmap)
> > > +{
> > > +     struct incompatible_pmu_event_filter err_f;
> > > +
> > > +     err_f.action =3D action;
> > > +     err_f.fixed_counter_bitmap =3D bitmap;
> > > +     ioctl((vcpu->vm)->fd, KVM_SET_PMU_EVENT_FILTER, &err_f.action);
> >
> > This is completely busted.  It "passes" by luck, not because it's a val=
id test.
> > The size of the argument is embedded in the IOCTL number itself, which =
means that
> > unless glibc is being very nice and using a macro + typeof + sizeof to =
sanity check
> > things, which I highly doubt is the case, this ioctl() is passing rando=
m stack data,
> > a.k.a. garbage, to KVM.
> >
> > In short, drop this patch.
>=20
> Thank you for letting us know about the issues with the patch. I will
> drop the patch as suggested. Would you advise me to prepare version 3
> to remove this patch?

More comments on the other patches are incoming, please hold off on v3 unti=
l then.
