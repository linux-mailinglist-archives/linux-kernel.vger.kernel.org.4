Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC17767F2B3
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 01:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbjA1AHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 19:07:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbjA1AHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 19:07:39 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAE88BBB9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 16:07:29 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-4fa63c84621so72145917b3.20
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 16:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yIdfwvHbGEKLCTuQ4JXyBNWQ+dba6F3QA3306R/+8B8=;
        b=qZ/Cw1ZpKuyVqQo0SIKQO3hFAy3CjY/9aaJMfZbyC+AAQA8Lr/CZGet+F+ConZZLLJ
         ix2/DtqZwP8+DVkUu/LLr0bdmL1ZNIXHNKA2BYtX0abF7Znnnibh6gxhTbaT4aX74vki
         vR2EK8jSEoPacNVbr9Gv9dt4WpOszJjFZZ62fCf9Tup6nzGSFf91eJ1sWj+iX6nLiYOc
         VgbFlkRj4A3P3UxDk4zNVPKcQg/M0hJVgdnx69WmpT+hjNBTUTGM7X25WwPsnXLbTI26
         bj+eSjaDF+gCMUeV3cEtRPBk1FLRMo8wKKnmp7JEVu4fy8/JsVr/SoGCVKJWyOkTTE/2
         JBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yIdfwvHbGEKLCTuQ4JXyBNWQ+dba6F3QA3306R/+8B8=;
        b=A+6vEbFqbE6WcuDdwD7aNmiGy9EmpBtaPXV+acJCe9gx8Dd2kLahUek/zdGX+pKrRa
         26IBiHys5BRzZ2yIcxcAskDpOg6b176cUPIflG2jLclGcGbnu/D6vpNseLEjHVN2lN3U
         89jEVHcat3P4vo9oHEC+SwNlIapUMOpbVEMY/bgg7IQVlsseC45MCU3qoVk2ouUa1iTM
         1RmIT6sw/W+vSNEfHIJrgzDFscsd99BK7Zj65wzP4dbsiR53xpRNMVBMFOXRbyA5QBxZ
         bkZc9URIoTAZeJCPEHkzJvfBOfuWrWh8rDYfm9LoQzX8bgRpEyXd2h85gIu3EkI3a8TL
         V5vg==
X-Gm-Message-State: AFqh2kqO3Hyshw7dCtJI6DsSidt1X6VaGphnBUHLoWyN24ETlXkuQhFj
        8SCnFmVPniMxQwJMtOnM+Q7V7uVuXt0=
X-Google-Smtp-Source: AMrXdXu57lkI2niI3+7FRw2C2JFNsAB9MeEoQ5LT6cdV+pzn/rs/r3PwjzjR3S6Xqv2ClauRzdM5YbSuZDk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:e786:0:b0:500:b5eb:cdd with SMTP id
 q128-20020a0de786000000b00500b5eb0cddmr3940728ywe.95.1674864448762; Fri, 27
 Jan 2023 16:07:28 -0800 (PST)
Date:   Sat, 28 Jan 2023 00:07:17 +0000
In-Reply-To: <20230124234905.3774678-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230124234905.3774678-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <167478505768.321030.6496153359402477383.b4-ty@google.com>
Subject: Re: [PATCH 0/6] KVM: x86/pmu: Misc PMU MSR fixes
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aaron Lewis <aaronlewis@google.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Like Xu <likexu@tencent.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jan 2023 23:48:59 +0000, Sean Christopherson wrote:
> Fix a handful of minor PMU MSR issues, mostly related to KVM's reporting
> and handling of MSRs when the PMU is disabled.  E.g. running the
> state_test selftest with enable_pmu=0 fails because KVM tells userspace
> to save/restore the fixed counter MSRs, but then rejects attempts to
> access said MSRs from userspace.
> 
> 
> [...]

Applied to kvm-x86 pmu.  As mentioned in the cover letter (trimmed by b4),
I'll yank these out of the queue if any objects and/or there are problems.

[1/6] KVM: x86/pmu: Cap kvm_pmu_cap.num_counters_gp at KVM's internal max
      https://github.com/kvm-x86/linux/commit/8911ce66697e
[2/6] KVM: x86/pmu: Gate all "unimplemented MSR" prints on report_ignored_msrs
      https://github.com/kvm-x86/linux/commit/e76ae52747a8
[3/6] KVM: x86/pmu: Use separate array for defining "PMU MSRs to save"
      https://github.com/kvm-x86/linux/commit/2374b7310b66
[4/6] KVM: x86/pmu: Don't tell userspace to save PMU MSRs if PMU is disabled
      https://github.com/kvm-x86/linux/commit/c3531edc79a7
[5/6] KVM: x86/pmu: Don't tell userspace to save MSRs for non-existent fixed PMCs
      https://github.com/kvm-x86/linux/commit/e33b6d79acac
[6/6] KVM: x86/pmu: Provide "error" semantics for unsupported-but-known PMU MSRs
      https://github.com/kvm-x86/linux/commit/2de154f541fc

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
