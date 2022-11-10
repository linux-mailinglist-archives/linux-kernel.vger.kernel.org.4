Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617AF623878
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 01:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiKJA5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 19:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbiKJA5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 19:57:09 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1B520353
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 16:57:08 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id a33-20020a630b61000000b00429d91cc649so127517pgl.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 16:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eUq0vFA8ndY9d6ONKF6p5o14/szo67j4mO31X1fzXhQ=;
        b=ISnjkw4UhuHmVKuUmoCNvGEqjV3MQKsrd9zzkNWNwK8a5nTV5bjg+MAfo5L3xdGRlH
         I0bzMV0ysYNJajwQ0GqoVKfcBtI3elSbtl+H99V23yzRL4DL16WsVVSKaCaB4IznNo71
         5JIfdPkB5N0lAq/MAzTD1wvFA5xFsZoasy3Bf1EJshqmdFWP+IBW5krsZlRwypozTO8Q
         30XcaOD5aQh+PopTn9CMmqzy+ML1WhKHi2ZS9JzEkl1BLzwu/MWAmLGQBh4/WwqlPMuj
         IRkiKYYSWwd8xRcApXG60iCqKce2bCZN5qmzIjAkGyes06ExYOFbWEJpqGE5cENTJW64
         64Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eUq0vFA8ndY9d6ONKF6p5o14/szo67j4mO31X1fzXhQ=;
        b=dQGahMh8zlqX3km6oWcyXkspSVw7mOhivgEJ817pqfi73sLogAWYES5JU4A2Z65Lij
         VOAImGyjfS6zSj893I285R2YlT3pWnJoJFZFKAqx7cMBzoXMZXLYzBclq8a+keWDR/+Q
         ZXhwtGEo473/boeftYu3h95+Cd650ialMln94yROEQ8cm6fTek2MaBMya2bl98VsP7tK
         jV3XlGJp/7CWdLy27i8qGIvmbJDI0iI8Q6nFF42paF+BEConKV98noXE3Y2/cZwiEZ+2
         IL8CcNfuGWuJSsbEjTrkAfOBS2FyF+++gvLf8X3evELv81tIhcJYpbc2a0LiFjf+Vp+p
         ATwg==
X-Gm-Message-State: ACrzQf29RotBdZGSAjwElwMXVfsVTT1eYdF6wn5RAeAlQUK2esZgANDB
        kZg6s4qln8Xjq1mAmKBNrnnS8wM59Mw=
X-Google-Smtp-Source: AMsMyM69pqxrJF/SLakpGezFAlKg1pWH1oDKq/6oavYLLCQJLbq60mbR5Ufk/J/JEHcclX2miXFSWxZ1eis=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:aa7:8549:0:b0:56c:ba99:7951 with SMTP id
 y9-20020aa78549000000b0056cba997951mr63536349pfn.83.1668041828368; Wed, 09
 Nov 2022 16:57:08 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 10 Nov 2022 00:57:04 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221110005706.1064832-1-seanjc@google.com>
Subject: [PATCH 0/2] KVM: nVMX: Fix another case where KVM overrides VMX MSRs
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yu Zhang <yu.c.zhang@linux.intel.com>
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

Fix another case where KVM overrides the VMX MSRs (well, just the one MSR)
during KVM_SET_CPUID.  Similar to somewhat recent reverts

  8805875aa473 ("Revert "KVM: nVMX: Do not expose MPX VMX controls when guest MPX disabled"")
  9389d5774aca ("Revert "KVM: nVMX: Expose load IA32_PERF_GLOBAL_CTRL VM-{Entry,Exit} control"")

undo misguided KVM behavior where KVM overrides allowed-1 settings in the
secondary execution controls in response to changes to the guest's CPUID
model.  To avoid breaking userspace that doesn't take ownership of the
VMX MSRs, go hands off if and only if userpace sets the MSR in question

Sean Christopherson (2):
  KVM: nVMX: Don't muck with allowed sec exec controls on CPUID changes
  KVM: selftests: Test KVM's handling of VMX's sec exec MSR on
    KVM_SET_CPUID

 arch/x86/kvm/vmx/capabilities.h               |  1 +
 arch/x86/kvm/vmx/nested.c                     |  3 +
 arch/x86/kvm/vmx/vmx.c                        |  2 +-
 .../selftests/kvm/include/x86_64/processor.h  |  1 +
 .../selftests/kvm/include/x86_64/vmx.h        |  4 +-
 .../selftests/kvm/x86_64/vmx_msrs_test.c      | 92 +++++++++++++++++++
 6 files changed, 100 insertions(+), 3 deletions(-)


base-commit: d663b8a285986072428a6a145e5994bc275df994
-- 
2.38.1.431.g37b22c650d-goog

