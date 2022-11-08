Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4DE4621AF5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 18:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234116AbiKHRpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 12:45:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233945AbiKHRpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 12:45:15 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642F254B0E
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 09:45:14 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id g127so18238777ybg.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 09:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yA7pydEspZBBPyifImk/4u2PUu7iL2nAKzA6SsMSd3g=;
        b=PCIny41ekZYub1NRysqPw75m0nSrvinWBYMDPYLhb6QP25vd+sqG7N76sHdkIIJpT/
         mA4kxxhGjyBpbF8TBFmO+VunUKcQOti/p8ywIpBtqST/Rk5C+D3xUKH2yDOyIRc9DJG3
         pl0GEllrCugPbgkwYla5dglp5AIOFqltQhTPxjaLePOnpTJTkK0O/BtlJqdVCaMbcCgT
         SuzqzoIAa3n/tG/gxONUKaK8e40q24porCgvV/I5FrMookkxTu2O/OkzXjQA9DvMv2GP
         KDwSAEZdTycnVNx+KRhChCZ7vofOzB3Srj/yzWusDjhTVyCSNilt36hTGJkbkG8dHTyG
         y17w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yA7pydEspZBBPyifImk/4u2PUu7iL2nAKzA6SsMSd3g=;
        b=a1aQdBFj5dJgpwMRHfLam+BM3tC/94a14R9u3sgPCeOSnM4IuENR4ATJB3rw+lwpJN
         DQK+ufawd5QWr5wZ3mHzwXpxozIUsAV3vMZ/DTBXTbiYzD/397UgYLUIbninGhxj0hj8
         lAI71x68CYS9o5ILtIhOp/c+fT7j7t19AfK0s+8FkHAY+retDe85Ov7k3njMWcv+Hz9X
         3u9dy3LX8R0MTrltSjnX7BASB7UEEJYYLJBRV98wg5+UzM3LafnV/hstmDHWcdCjRuT2
         kJ6H00M0W9nEbwMSKH6JGiVuvbN83WhxGH/zGR9mpn/A4CZiDfgZR562q5kND9bfEM4B
         LtUA==
X-Gm-Message-State: ANoB5pk6NsNdfNlhKqSit2A9r7YkKVQDJGC2otx6vNuo6lBLOPPr/QAY
        yiSTNN24Ck51d842RFGB1v3WyopqCDPCwsq7mqYEkg==
X-Google-Smtp-Source: AA0mqf75YC0vo4yMSgplwTnddN900v/f0fIN3IfLu2e0EEe7HWMrqG/ATUNoG5ybO/rv99RE/NpuccYE+TYbea+TXMA=
X-Received: by 2002:a25:2458:0:b0:6d5:d9bd:3a20 with SMTP id
 k85-20020a252458000000b006d5d9bd3a20mr14557762ybk.582.1667929513560; Tue, 08
 Nov 2022 09:45:13 -0800 (PST)
MIME-Version: 1.0
References: <20221105045704.2315186-1-vipinsh@google.com> <20221105045704.2315186-7-vipinsh@google.com>
 <Y2lWG7wV+UvzX5jm@google.com> <CAHVum0eM7NtBDRFhXa9pk9DAEere1q4XVTUti2TFZuKPiGK6LQ@mail.gmail.com>
In-Reply-To: <CAHVum0eM7NtBDRFhXa9pk9DAEere1q4XVTUti2TFZuKPiGK6LQ@mail.gmail.com>
From:   David Matlack <dmatlack@google.com>
Date:   Tue, 8 Nov 2022 09:44:46 -0800
Message-ID: <CALzav=eX=kCtrRJhVwSJbE9yJm3pi1srf+rd6iX5uSShBzYVPQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] KVM: selftests: Test Hyper-V extended hypercall exit
 to userspace
To:     Vipin Sharma <vipinsh@google.com>
Cc:     seanjc@google.com, pbonzini@redhat.com, vkuznets@redhat.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, Nov 7, 2022 at 6:05 PM Vipin Sharma <vipinsh@google.com> wrote:
>
> On Mon, Nov 7, 2022 at 11:01 AM David Matlack <dmatlack@google.com> wrote:
> >
> > On Fri, Nov 04, 2022 at 09:57:04PM -0700, Vipin Sharma wrote:
> > > +
> > > +     TEST_ASSERT((run->exit_reason == KVM_EXIT_IO),
> > > +                 "unexpected exit reason: %u (%s)", run->exit_reason,
> > > +                 exit_reason_str(run->exit_reason));
> >
> > Optional: Asserting a specific exit reason is a pretty common pattern in
> > the x86 selftests. It'd be nice to create a common macro for it. e.g.
> >
> >         ASSERT_EXIT_REASON(vcpu, KVM_EXIT_IO);
> >
>
> This is much better. I can add a patch which creates this API.
>
> Should it be run or vcpu? Seems like everything needed is in struct kvm_run{}.

Either one but I suspect vcpu will produce a cleaner final result
since all tests pass around struct kvm_vcpu and only use kvm_run to
check the exit reason. i.e. I suspect you'll be able to delete several
struct kvm_run local variables as part of adding ASSERT_EXIT_REASON().
