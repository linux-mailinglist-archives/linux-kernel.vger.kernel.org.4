Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC755E708A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 02:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbiIWAOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 20:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbiIWAOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 20:14:05 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5EFF8FB2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 17:14:04 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d7-20020a170903230700b00177f6dd8472so6930656plh.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 17:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date;
        bh=Eoz/GbBhWdRi9r3rGJFCcKHaAhmqK3eeqjttldZRzH4=;
        b=RSqv9qjAKIlz9mPJRNQrn4icDJ8lw1D2bMmXxIKWKpDAV+GV5tTIUugaurm8QxatQU
         Jmmke/pNm3AxCDPiKV2a8eOd57EqSTuYY+lMnGZIflAQebJNZiXrwaGTCItaIbveROzj
         E99hiQUozMAzJH+Eao6WdNt0Ts3Eo1o662jaf2nFzYb7LAH7/VVj3Llp1+N7KKOzxZJt
         rkadq1V3DsdH+g5Kj1fB+3ODPLR+TKrQ5lG7aITh54rfHrKrsmwKpV1rg8AQwyVHgPsY
         AlcT9fkbbRBfeFi5xD4aK58brsRqu50ptq8IMj+gk+irkeDMJVKdS1RiKGxxUlGPtAz6
         4Gwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Eoz/GbBhWdRi9r3rGJFCcKHaAhmqK3eeqjttldZRzH4=;
        b=gAPNCW15RwWSEdBvo2FX4zwSPc0OuqSEr0/v15Lx6Z754mxkB6SQTxutSf+Yo9vRfr
         Sr3mTXn/TP0vHQgztlQME4OU/7L99UMdb7YoWxwKjVAqD2rLqIioOhNpBdLQNv8kYx+u
         r/sbpccH0Hsp2anDKHYOSUYtv+VOt1sZcQPCATwvdx+S0FSD0RK/XDT9V5IDJYDHpGUy
         MKUnjYh6pjRcvEPwuMFTnhr+UMxxgqer0MKDwDnUoVBoL0Cet21SQB1G16ivmqRHhiDS
         ZIUl94AU26a271rUXn9TRb3qDf4ilXYlVMsC0BkEv2XRg+O5NH6rnXTJ7ExZ52HdSug2
         Y0Wg==
X-Gm-Message-State: ACrzQf1jLQLrUjcC9LnQMFVJDd13MAiNyVg2q/QLIgdO2aydYw3E5XQg
        5ye6k8liLI0Q63px4OOSn0Ney0saFOc=
X-Google-Smtp-Source: AMsMyM4XsvpJ5wmr3a9XHFUtmece1NeSX6VpwnqYX3hkNQp4c6XrjcvE0KmqeKUOFCOlxd5oif4ybKFymYE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:aa7:998f:0:b0:54d:a441:85da with SMTP id
 k15-20020aa7998f000000b0054da44185damr6084834pfh.20.1663892044177; Thu, 22
 Sep 2022 17:14:04 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 23 Sep 2022 00:13:51 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220923001355.3741194-1-seanjc@google.com>
Subject: [PATCH 0/4] KVM: x86/pmu: Counter reprogramming fixes
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aaron Lewis <aaronlewis@google.com>,
        Like Xu <likexu@tencent.com>,
        Wanpeng Li <wanpengli@tencent.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The headliner is Like's patches to fix a bug where KVM's sleeps with IRQs
disabled due to attempting to pause and reprogram PMU counters in the
VM-Exit fast path.

Patches 1 and 2 (mine) fix mostly theoretical issues found when reviewing
Like's code, and would conflict with Like's patches if posted separately.

This is _very_ lightly tested, borderline RFC, but Like's updated PMU
KUT tests pass, as do the filter selftests, and I'm feeling lucky.

And I'm offline until Monday, so a traditional Friday patch bomb is in
order ;-)

Like Xu (2):
  KVM: x86/pmu: Defer reprogram_counter() to kvm_pmu_handle_event()
  KVM: x86/pmu: Defer counter emulated overflow via pmc->prev_counter

Sean Christopherson (2):
  KVM: x86/pmu: Force reprogramming of all counters on PMU filter change
  KVM: x86/pmu: Clear "reprogram" bit if counter is disabled or
    disallowed

 arch/x86/include/asm/kvm_host.h | 17 ++++--
 arch/x86/kvm/pmu.c              | 92 +++++++++++++++++++++------------
 arch/x86/kvm/pmu.h              |  6 ++-
 arch/x86/kvm/svm/pmu.c          |  4 +-
 arch/x86/kvm/vmx/pmu_intel.c    | 10 ++--
 5 files changed, 86 insertions(+), 43 deletions(-)


base-commit: efc8a6befa592de7e2fd4927b1b9a56a5ec7d8cf
-- 
2.37.3.998.g577e59143f-goog

