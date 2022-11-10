Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3396238D4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 02:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbiKJBaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 20:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbiKJBaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 20:30:06 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0344C23EBB
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 17:30:06 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id s16-20020a632c10000000b0047084b16f23so168484pgs.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 17:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VGW9SN/GU1zlYr612KLp3zu/eRHjgyHcOmNcSA044xE=;
        b=Vr19dn9AojCDpmbeuLHsQIs320UZS/f9vRkdbWhgZ76TTVay1/WB+OheKVdr3k/Kgp
         VjZry09gHmd3XLJLmidZYD7TJn/xJfCO6FQuC91vY5JvHa/odf112ViOSJc+9h2v+yJo
         pfHqrQzjpUcpspCwiLfQpFDMIjXGMlIzewZSxzlCfYkCzFz3Xbs+6KxrvJQho0aQbjC3
         7v9v2UguuY9ghN5fejm5UGajgyc7xxOX7uLbDc7kOA2fy2jpWQk+T6UtQKixExc2v30U
         LWNW59Yuhm4Aijz9kJyQuP1hZQ9+K/0VZK/2DAVpAsN9IvsrkpN970uVTvtLWqBe92fh
         iIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VGW9SN/GU1zlYr612KLp3zu/eRHjgyHcOmNcSA044xE=;
        b=n0ARUGGGRPo8Onsfdrh9iLl87nAtJ1qI7NU+VAypAOnCAAtCosLZK7Wk/ZUUHAAzIq
         e9+A+xOA0PAEkbDUdPwdJ6CBINvzR5qJvH+bwxcDASGSaI/NdytGpwd1wJtoxcuTwA66
         9uoTUTSWhgDV3Dsup/pe535TkJhhm+LMJcGF3Zv0l/wWMpM7X/ifgSOrMd1vTrK5S+nH
         heIESh1By8epfR7/N26DLrHWAdIZU/JNQyo0D2EZo2JIMYfi+PMJE9nkfu7hqruv0Lwc
         /eTDb/T9WqLwZENEkRHwoEzliMGq6NuofLobxpbuzUi8iVvDHPK0cj91huQ4qQogleTX
         HmGQ==
X-Gm-Message-State: ACrzQf0kF2sKF8yQp9pcykmbQEkslGKx9h9fB9TQ8yiLt93rMF36+Hfc
        H6cNK55eHE//gdXjJDkg6BN3adD0Hjw=
X-Google-Smtp-Source: AMsMyM400SkFFxkF1iT6t1XOvw3bzHsCwRfac5RUsDcthCc2zo6ufwdOqy7sT0L4hI8vABmlxsDL+rcddnM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:bf01:b0:188:571f:3756 with SMTP id
 bi1-20020a170902bf0100b00188571f3756mr35538364plb.171.1668043805499; Wed, 09
 Nov 2022 17:30:05 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 10 Nov 2022 01:30:00 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221110013003.1421895-1-seanjc@google.com>
Subject: [PATCH 0/3] KVM: Mark vendor module param read-only after init
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
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

Mark the read-only VMX and SVM module params, and a few other global
variables, read-only after init.  In many cases, KVM is royally hosed if
a configuration knob changes while VMs are running, e.g. toggling the TDP
knob would result in spectacular fireworks.

This series is probably best queued very early in a cycle, as the result
of mis-labeled variable is an unexpected kernel #PF.

Sean Christopherson (3):
  KVM: VMX: Make module params and other variables read-only after init
  KVM: SVM: Make MSR permission bitmap offsets read-only after init
  KVM: SVM: Make module params and other variables read-only after init

 arch/x86/kvm/svm/svm.c          | 38 ++++++++++++++++-----------------
 arch/x86/kvm/svm/svm.h          |  2 +-
 arch/x86/kvm/vmx/capabilities.h | 16 +++++++-------
 arch/x86/kvm/vmx/nested.c       |  4 ++--
 arch/x86/kvm/vmx/sgx.c          |  2 +-
 arch/x86/kvm/vmx/sgx.h          |  2 +-
 arch/x86/kvm/vmx/vmx.c          | 36 +++++++++++++++----------------
 7 files changed, 50 insertions(+), 50 deletions(-)


base-commit: d663b8a285986072428a6a145e5994bc275df994
-- 
2.38.1.431.g37b22c650d-goog

