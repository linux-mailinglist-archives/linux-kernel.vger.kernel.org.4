Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8F568F912
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 21:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbjBHUyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 15:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbjBHUyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 15:54:33 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13C413D68
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 12:54:32 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id 63-20020a630542000000b004fb3982dd50so75042pgf.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 12:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ihU1H4kZ9BjK5BcY5kQ6fGB4N5NmwmZSluNBW8G1cI=;
        b=mZ8IRkuppbwH/Q7ZOij1/LaDs10DIEKxqqKtIBPgb20l6Ct5FzmeWBp01YIQjZVf81
         Kr4ZdZYTre23RMKGNagFEoRP131lzyBy7eHruK25mWjK13ejGNFegVNjB3pcR5ICzL38
         zfbt8w/3J8M+VXDQpJv2jddRyKcMBJ7mKp9+/H0cE350oCVKoHMYyi/WN+P5szigzExc
         GA3CdT5dsF52+bmlYcRtSHWWPghOIflLUQMdZyF87Boy1dmYheS1t+IGW15z+v4ZcNEa
         wWrRCm+vw6KbYs0kTZtujmspAzB4DBBenjOryG3gIbQYfQdQDsG5kXetcyzOMj13b7X0
         xfZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ihU1H4kZ9BjK5BcY5kQ6fGB4N5NmwmZSluNBW8G1cI=;
        b=WJYf0CNFISne7Mvdn76G5wuX15V4JDM6KhSsy+uK4i9bFPBZoEOMilO7VpK3A5nQgu
         juBK1gg7t5ouSPfxEHHUWmntDAqEoQxprN1HXhng2AeECRHK8aRIorkDoDy7Ik67zJpF
         Ro4F+8sgexFqbKihhc3+UUJEx8Toe7EcBfNEs0GfdZpmFrbACWnYww5rH1jP0Ru5AQ5P
         cUc4n4VkxrhxfurVtxw0eOyWC+KZZHn/GQRsCHsxFVHsAyOiD8MZFq7rLWDw52hByQIj
         qsMN+cDcOX//HxYB+W+qeJYp2fIglJi31g1RntaipTkzorggKiy1ZGo0ymIR0YP2XQhO
         NXIA==
X-Gm-Message-State: AO0yUKWYR3EK8pCfSZ2AST4j/8G1V56FPediM1SmUiVa2hmYFTh+qUqv
        CBPjZMeArz0yXXT3BlX+F70F2phYGU8=
X-Google-Smtp-Source: AK7set+WzLnQGVkN6I5+PWOMSY+SQMCEZJbhZPXo65r0/yDnDBzQ8PwacG5KSOG6Z2oourUgRxDCL/0DV7g=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:db0d:b0:199:4e77:7fa8 with SMTP id
 m13-20020a170902db0d00b001994e777fa8mr774950plx.4.1675889672359; Wed, 08 Feb
 2023 12:54:32 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  8 Feb 2023 20:54:28 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Message-ID: <20230208205430.1424667-1-seanjc@google.com>
Subject: [PATCH 0/2] KVM: VMX: Stub out enable_evmcs static key
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Tom Rix <trix@redhat.com>, kvm@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org
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

Stub out the enable_evmcs static key for CONFIG_HYPERV=n.  gcc (as of
gcc-12) isn't clever enough to elide the nop placeholder when there's no
code guarded by a static branch.  With gcc-12, because of the vast number
of VMCS accesses, eliminating the nops reduces the size of kvm-intel.ko by
~7.5% (200KiB).

Patch 1 is tangentially related cleanup.

Applies on `git@github.com:kvm-x86/linux.git vmx`.

Sean Christopherson (2):
  KVM: nVMX: Move EVMCS1_SUPPORT_* macros to hyperv.c
  KVM: VMX: Stub out enable_evmcs static key for CONFIG_HYPERV=n

 arch/x86/kvm/vmx/hyperv.c  | 107 +++++++++++++++++++++++++++++++++-
 arch/x86/kvm/vmx/hyperv.h  | 115 +++----------------------------------
 arch/x86/kvm/vmx/vmx.c     |  15 +++--
 arch/x86/kvm/vmx/vmx_ops.h |  22 +++----
 4 files changed, 132 insertions(+), 127 deletions(-)


base-commit: 93827a0a36396f2fd6368a54a020f420c8916e9b
-- 
2.39.1.519.gcb327c4b5f-goog

