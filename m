Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF8371F7DB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 03:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbjFBB0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 21:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbjFBB0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 21:26:10 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C5818D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 18:26:08 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-561eb6c66f6so21469437b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 18:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685669167; x=1688261167;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iwY3spp+fGUtp0w3LjKa+4NnaZkM8DvbIKDWvtVax6A=;
        b=amtNAmM8zVh2VUUWyPoUEZRJs6pOIjakCGtevlewJ4igFgQXtWQSsGZ1wE/gtm5bxM
         t9k7e99DNtJaogeYbOpgLVqYMpvSjin7m6EJ5rpAH4BTVJXWcp70Iz1sYKsiqnKeX5xa
         vBgxu1TKUXy7/8d3Mr0IemvInOtc+ev1qUsPPWeFMU2YZbP8pTQ9BpqXhw2PKMq7qRKG
         AaMWLNkLP+km3LgLkO3mK1O2ALibBC+RBykf4IizzH1XBRXo5y2ogl94yqJnqhOw4DnO
         qT47GMU4q/5N1CESCkv6hQuEvNJStLvpX9T+f+jHeW3PSBMSqwUmQHDUcokPAyedEjpa
         i7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685669167; x=1688261167;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iwY3spp+fGUtp0w3LjKa+4NnaZkM8DvbIKDWvtVax6A=;
        b=A/QhcMfB81o1l/VZ1MArQXz3zVokDv9LpKzEoKtLTIDYwWh5BRVsoNWAHvlPUnWLD8
         M371I7Myfa1M3wq26NMi+vY5c2YJ0YSV2Sn2xSnmAk+F+oGRAvYFCHOS/0z61jpy0O9u
         bPKjeBHiqj4kwzFQowMm+VD7KzS6sTNpnTqy1xBH6SGBsjU0gjhk366EjLWkVQnPfNue
         6cGo9Mz41l3IMM8GSJlze9SbWsuYZVyATS+qRd8EX8LPTGM3WtNtNYKjfimSX4vGvMwv
         Ys7ISl0Ctp5pNPmpJwIiT+xjcbGr6J1Tr9n4NmB6TMnxHw0CgN2I5gDIbfb86lB3aNqM
         uWsg==
X-Gm-Message-State: AC+VfDxlyvGkoTeczoAf+Dm6OR0AUk0ErbUGmcxvIZcr5BjRodOTlrkJ
        bT2X/DDshqGcoS+2OCupTsJ66KjKygw=
X-Google-Smtp-Source: ACHHUZ68qFeLVCrPRJNTeJQCCocYWYe48bFd/0hpjCiMFwiomz6bW84/9hxqZbE6sqO214FFZ2XXQ80Im9U=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:cb0b:0:b0:565:bd68:b493 with SMTP id
 q11-20020a81cb0b000000b00565bd68b493mr6419475ywi.6.1685669167676; Thu, 01 Jun
 2023 18:26:07 -0700 (PDT)
Date:   Thu,  1 Jun 2023 18:25:47 -0700
In-Reply-To: <20230411130338.8592-1-cloudliang@tencent.com>
Mime-Version: 1.0
References: <20230411130338.8592-1-cloudliang@tencent.com>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7-goog
Message-ID: <168565360839.667711.17229671566468688990.b4-ty@google.com>
Subject: Re: [PATCH] KVM: x86/pmu: Remove redundant check for MSR_IA32_DS_AREA
 set handler
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Like Xu <like.xu.linux@gmail.com>,
        Jinrong Liang <ljr.kernel@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Apr 2023 21:03:38 +0800, Jinrong Liang wrote:
> After commit 2de154f541fc ("KVM: x86/pmu: Provide "error" semantics
> for unsupported-but-known PMU MSRs"), the guest_cpuid_has(DS) check
> is not necessary any more since if the guest supports X86_FEATURE_DS,
> it never returns 1. And if the guest does not support this feature,
> the set_msr handler will get false from kvm_pmu_is_valid_msr() before
> reaching this point. Therefore, the check will not be true in all cases
> and can be safely removed, which also simplifies the code and improves
> its readability.
> 
> [...]

Applied to kvm-x86 vmx, thanks!

[1/1] KVM: x86/pmu: Remove redundant check for MSR_IA32_DS_AREA set handler
      https://github.com/kvm-x86/linux/commit/33ab767c2628

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
