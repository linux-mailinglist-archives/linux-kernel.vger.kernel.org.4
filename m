Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F346E1835
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 01:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjDMXT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 19:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjDMXTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 19:19:42 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD534488
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 16:19:17 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id j19-20020a17090a841300b00246f53c6eecso2994029pjn.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 16:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681427956; x=1684019956;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JCMmB82W1iV0rZNRcB4yuiudoiFD8yaVnc1kc9rzRxc=;
        b=CchbboH4wpxZF3wdXIWFsDFbfcFijMod9x57lyHR7x7YQFpXrogmvWyD/ZnWlFpJAf
         bBhf5WrDzvMXH+Yk1Tolu6Ye3uOX0tkXrBfIHoWaWnHGFYhH+f8f2j4Qb0lHypUiDS66
         FuzPEfHf/gpKnY+4mTyJplmYP62FHnoIPp3CmjpTxHIlrTwucXZSIbTE9neEJZagcJhU
         KuceyxTl56F0xk68iyitMXsBIQh/VADmP+pbLy+Q2X+rkQYkvpkzLQnsKeusGyEyIXFy
         v5prF5wIIczpv/4rk5u4yG+zoRtsNIWBQHNP7T9ShGFc8TA1+vd2uMOJ1pf8YT8dWe5a
         41fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681427956; x=1684019956;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JCMmB82W1iV0rZNRcB4yuiudoiFD8yaVnc1kc9rzRxc=;
        b=IH7594lbuXUvl52FaqFz5MRpZrXczac96LRxoGrqXR6kcoAABm4hDunl7Alxi4CQ2s
         svg1V7igNxPhWhx2EPO86SvYKkhnSrP+BA/7c5oZu9BrMF6J2357eUCd8jtHB+PZKZDJ
         Ydmbah/V994x58z3iQR80/T6bbRvcZFgR4lEx7LYGeYyb5HpqLDFRpo8fApd53V94GMi
         1Nmz6yj63YnR5w8Lpy1xnctDCBnSe7UNqDiQ0GHjpLIyi8Z5T3dCo15RbbKI4ikeId08
         uiQPJXYxFd6TFUNH/fwnnp6DXvBFYJq3qXDVkzCM6gsOCkLmsSS1Mbn6UNiKikdmvBs3
         qDvA==
X-Gm-Message-State: AAQBX9dxiF5qqXuIHc2Cf8sUKo7cOa7kfYoaLbcJjZtYYogxNchSjzy7
        kiEzaXkbaEDgYb3KcD8bAisXjTY0n/c=
X-Google-Smtp-Source: AKy350acFc3QexXvTPKtpxqBaBvVCJJU5rGAV0CdUo6osfHcQwnar/Nt6Z5ZLLY1zsFbGb+i+tqS5yU4xfE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:7b8c:b0:244:987c:a873 with SMTP id
 z12-20020a17090a7b8c00b00244987ca873mr1066312pjc.7.1681427956699; Thu, 13 Apr
 2023 16:19:16 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 13 Apr 2023 16:19:12 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230413231914.1482782-1-seanjc@google.com>
Subject: [PATCH 0/2] KVM: VMX: UMIP emulation related cleanups
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Hoo <robert.hu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two cleanups for UMIP related code, identified by Robert.  These are
*almost* purely cosmetic, I don't expect any functional impact on real
world setups.

Sean Christopherson (2):
  KVM: VMX: Treat UMIP as emulated if and only if the host doesn't have
    UMIP
  KVM: VMX: Use proper accessor to read guest CR4 in handle_desc()

 arch/x86/kvm/vmx/capabilities.h |  4 ++--
 arch/x86/kvm/vmx/nested.c       |  3 +--
 arch/x86/kvm/vmx/vmx.c          | 10 ++++++++--
 3 files changed, 11 insertions(+), 6 deletions(-)


base-commit: 4d663d83a561344d237c77a77b651f55eb7f7356
-- 
2.40.0.634.g4ca3ef3211-goog

