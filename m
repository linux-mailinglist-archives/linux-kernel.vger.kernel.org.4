Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A727101D0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 01:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbjEXXvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 19:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjEXXu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 19:50:58 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E9C99
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 16:50:57 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-64d2d0f5132so907155b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 16:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684972256; x=1687564256;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cSR7SiejqAADkjtE2sfBUw7kBDCwXi6R0Pqg2+hbZ5M=;
        b=sBgm/c/eypRScnM/5VK84NQJotHmdUBdtdu7k+AA2ntAYB6j5QG/rkORL1OXol+KHR
         V8olrWLcq19w9iPuiX8It70T0bWgLUavXKJVcMFrc9Lcc5uNtTL3TSMcBs6peyxVYbHz
         8TJwNaRveyodUpGx9k1rKBmJBq6fJYXXo3pftEa2308DCGiNODq5j7xEaVXVbBilzMZR
         nUvrsvFQxCd4Jh1hWPgKLPYY84wfc/rszy2CSOGTQIirnhWYC64OIaDAYkPGm4obhw+Q
         KvfboAFt7XMNOhnDUGg7wdUu6I1fkWo6S+YncB0LvSAtW8ZcIyBYPPGeODVGBwdqcnBI
         4/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684972256; x=1687564256;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cSR7SiejqAADkjtE2sfBUw7kBDCwXi6R0Pqg2+hbZ5M=;
        b=cx7sJcaG4pk19odC8Zojl16xGhmJ0BGrrePdkkLFcpl+twfh4OGPqeg8NfDj2hAWyY
         2hLKQ3kfzjeCk783HWqoCXsRpkms7kTcaDpXKtfaerZKq6KDSkxGJiXPaPmGEtc9Kd9U
         cX2UzxLbTh6aDqo0UUi/epEh+Wcycjp6/IsBS5vUBAlGy9JYNjU21F4hHaMsSe/5d38y
         qgtN7qQeMUbBxQVcCOKSYsIYg4pBF0jvM3sS+XrIbRee/jjqW44iXoo1zLuuyjslsIUH
         AoF2xSswDT7t1FIJNWQE1ky8ha+jLqUls7wEewU5GEUwT2nlCSPJkuyc97zAl5JwKuYb
         JI5Q==
X-Gm-Message-State: AC+VfDxO4G0Vs+t4MqaJpzvWaiXbqVsV08V7DRLCtbZqUMRFS0Cxo+2w
        IHFqI5f9KZrZERHdor8D8RyIpcxRzMU=
X-Google-Smtp-Source: ACHHUZ5++i/grgISdAgXADrF+3dpyM58oC7OV69ywkCye0aodewP+oJLe6AqjUhs2UrhIZ1ob43Es59MFt0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:189c:b0:63a:ff2a:bf9f with SMTP id
 x28-20020a056a00189c00b0063aff2abf9fmr1730016pfh.2.1684972256482; Wed, 24 May
 2023 16:50:56 -0700 (PDT)
Date:   Wed, 24 May 2023 16:50:54 -0700
In-Reply-To: <20230420104622.12504-8-ljrcore@126.com>
Mime-Version: 1.0
References: <20230420104622.12504-1-ljrcore@126.com> <20230420104622.12504-8-ljrcore@126.com>
Message-ID: <ZG6i3sqOcZDg/UCG@google.com>
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
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023, Jinrong Liang wrote:
> From: Jinrong Liang <cloudliang@tencent.com>
> 
> From: Jinrong Liang <cloudliang@tencent.com>
> 
> Add test to verify the behavior of the pmu event filter when an
> incomplete kvm_pmu_event_filter structure is used. By running the
> test, we can ensure that the pmu event filter correctly handles
> incomplete structures and does not allow events to be counted when
> they should not be.
> 
> Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
> ---
>  .../kvm/x86_64/pmu_event_filter_test.c        | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
> index 9be4c6f8fb7e..a6b6e0d086ae 100644
> --- a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
> @@ -881,6 +881,24 @@ static bool fixed_ctr_is_allowed(uint8_t idx, uint32_t action, uint32_t bitmap)
>  		(action == KVM_PMU_EVENT_DENY && !(bitmap & BIT_ULL(idx)));
>  }
>  
> +struct incompatible_pmu_event_filter {
> +	__u32 action;
> +	__u32 nevents;
> +	__u32 fixed_counter_bitmap;
> +};
> +
> +static uint64_t test_incompatible_filter(struct kvm_vcpu *vcpu, uint32_t action,
> +					 uint32_t bitmap)
> +{
> +	struct incompatible_pmu_event_filter err_f;
> +
> +	err_f.action = action;
> +	err_f.fixed_counter_bitmap = bitmap;
> +	ioctl((vcpu->vm)->fd, KVM_SET_PMU_EVENT_FILTER, &err_f.action);

This is completely busted.  It "passes" by luck, not because it's a valid test.
The size of the argument is embedded in the IOCTL number itself, which means that
unless glibc is being very nice and using a macro + typeof + sizeof to sanity check
things, which I highly doubt is the case, this ioctl() is passing random stack data,
a.k.a. garbage, to KVM.

In short, drop this patch.
