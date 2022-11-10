Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC3B623926
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 02:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiKJBs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 20:48:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiKJBsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 20:48:25 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1FCB78
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 17:48:24 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id pj8-20020a17090b4f4800b002140219b2b3so3281883pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 17:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=czRAUIKopWS6UNhZrlaJNdPvNfcaMl7pKNzRt/2ikJM=;
        b=fpoDzxDMW+3u08v36DNw63uremA9sbsMmIFu2x8khM3/gBySJsYse9ASpc0svRbvn3
         WQfcM4iyPITgrDTDgu2S+qClNj83o6nuifGmu20kTjfEirlD/zB2d5DAxK+98c5vAtNY
         4EqK+gmP3PZu4PVATaG3O6S9sjZ3mhBPlKsQZnOiDOKOKlP0GVBzxW/QYbH1w9P71/Ch
         3NKukEyx9UR9a0oNc8eyQWd/KcZHZBuzxeiSeCmK6itvS7/7XGxSuME1jWAUJKhbEdRq
         hRBlvRJb58rTmNTItfyIlGspaQC3OCJAVlM3te1nuqOjNjiR2hNHdUbClxbUl80OrtAZ
         +3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=czRAUIKopWS6UNhZrlaJNdPvNfcaMl7pKNzRt/2ikJM=;
        b=2eEL8KSU/3iiA8swVucFi9Sx1HrdH79Neg3QWwlrTj1eacPpCZe9FLdoWaLLAgHdv0
         p2pQiK4S4dyO4RTyo7uhVtyvqLnula+Rp2eMZpEuSYCM1RAZ2vmPT+J3SPjZMyhMmj55
         n+5YMspr5vzrdF3rb1qiWya+wrT1T4mfDZ1dfMgHJUiUhvAPZzC/KaQNx4NvaAGuzQvU
         XO01bxHhgl7zB/JEsksOIhTLjTDkPw++YXIvcrLdxzS6cTmQnsyayRvAVL39tSq5XGw0
         1FvxeD4C7wzHsOY4g9Nh4jGOqLnPUQhesLaJsZRgMQWpYrK6t0UMEy4gJJCo949WLc0j
         8/YA==
X-Gm-Message-State: ACrzQf2MLXHNGEdHIlOtKErJLM/999mRsp7UmaB3AfUqiYc3qW2rj272
        qDxeaOXNa27CPEoZItQuzitmSzwpF2U=
X-Google-Smtp-Source: AMsMyM6/3/k/CW504Zws+OFFGRxwl1sYlYMYPI5zGDC9GxPtGjRoTYY/y/tk9KC1z2QJzEV+7Zl3zdqVVNs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a62:1b11:0:b0:56d:568d:c293 with SMTP id
 b17-20020a621b11000000b0056d568dc293mr55789021pfb.41.1668044904195; Wed, 09
 Nov 2022 17:48:24 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 10 Nov 2022 01:48:19 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221110014821.1548347-1-seanjc@google.com>
Subject: [PATCH 0/2] KVM: x86/mmu: Use page-track only for... page tracking
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yan Zhao <yan.y.zhao@intel.com>
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

Don't bounce through the page-track notifier when zapping+flushing SPTEs
in response to memslot changes as the need to zap+flush isn't strictly
limited to page-tracking.  With that done, register KVM's notifier on the
first allocation of a shadow root, as KVM's ->track_write() hook is used
only to react to writes to gPTEs.

Aside from avoiding a RETPOLINE on emulated writes, dropping KVM's internal
use will allow removing ->track_flush_slot() altogether once KVM-GT moves
to a different hook[*].  Tracking "flushes" of slots is a poor fit for
KVM-GT's needs as KVM-GT needs to drop its write-protection only when a
memslot change is guaranteed to be committed, whereas the "flush" call is
speculative in the sense that KVM may abort a memslot update after flushing
the original memslot.

https://lore.kernel.org/all/20221108084416.11447-1-yan.y.zhao@intel.com

Sean Christopherson (2):
  KVM: x86/mmu: Don't rely on page-track mechanism to flush on memslot
    change
  KVM: x86/mmu: Register page-tracker on first shadow root allocation

 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/mmu/mmu.c          | 24 ++++++++----------------
 arch/x86/kvm/x86.c              |  2 ++
 3 files changed, 11 insertions(+), 16 deletions(-)


base-commit: d663b8a285986072428a6a145e5994bc275df994
-- 
2.38.1.431.g37b22c650d-goog

