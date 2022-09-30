Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3DA5F1219
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 21:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbiI3TIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 15:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbiI3TIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 15:08:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F541C99CD
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 12:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664564914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2ho5HUk/k6PdSH+MVcpkSJ4cYO9ebBSiHEKpSKcMZVA=;
        b=CKd5MNNotUxgOwV3a6ePfzJbNNP87f61uXq1PeDqfxpJkhP+Eid9oPPJsR13S4iY5MHpKf
        ISA6fkUsL8B6stbtJpCtSD07meNNz8FO1MvdR3W/HyYHUGGwH9O0on9T2fWW+5a9z1j3xu
        ZvkXGFD0zBfVpmLmm/xcRHNQwx5CzSc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-411-XszdREGpPi6wjLrjYSIG_A-1; Fri, 30 Sep 2022 15:08:33 -0400
X-MC-Unique: XszdREGpPi6wjLrjYSIG_A-1
Received: by mail-ed1-f70.google.com with SMTP id w20-20020a05640234d400b00450f24c8ca6so4150235edc.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 12:08:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=2ho5HUk/k6PdSH+MVcpkSJ4cYO9ebBSiHEKpSKcMZVA=;
        b=VzahiTGiVpgxsXIuJ1llvrrfKJiwjZFvAKxZV6nlYjk79kVkQptmYxy6RASQi+hmtw
         hR0pzlkYDjO48odMxLfAxkfl2ZpaHUtPzsYG7ywvYbf8S4F2rDV+KYNzhewbXh2FxZUC
         TNCmo00jdqmO8G4JUdjJgKoSTuXi8VDC4uRf6i62t/LyJoB2lye8YCJ129BZR9YhAYLe
         5OUZDcM++6d3GSek3df2erQcZF0k+2QsEz8QGGzLmyi0e4jSswEIJ7LwSjv2i8HiHWJs
         gIiECoIwNCheNEWRm1R6QLp48Ka3lFVtohLlyUPFOA1sPUfazdNBgdpmWP/fCyOMB9CF
         YzzA==
X-Gm-Message-State: ACrzQf2cxiB+VHgFHbfYgsYGvkaamcGuQ//+npNNUuoW6IwK3E+ffXx3
        BrepuSzvqtMPV4Wese0KYInARQFwlgYhl3R3TmbeGMqI3WiWgTKXRk37mCPp1R7QBCBOhIlLBNB
        tCGES+bA3YhajMIydeN8DATD4
X-Received: by 2002:aa7:cc86:0:b0:457:f801:2951 with SMTP id p6-20020aa7cc86000000b00457f8012951mr9018662edt.16.1664564911975;
        Fri, 30 Sep 2022 12:08:31 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4AneXVS/tv8vESVK+vpN3uJLhQgCqt2orY0RNpjmenzjQ8MZ56VRv+hjtCuuOTxMRHh+7ybg==
X-Received: by 2002:aa7:cc86:0:b0:457:f801:2951 with SMTP id p6-20020aa7cc86000000b00457f8012951mr9018651edt.16.1664564911735;
        Fri, 30 Sep 2022 12:08:31 -0700 (PDT)
Received: from avogadro.local ([2001:b07:6468:f312:1c09:f536:3de6:228c])
        by smtp.gmail.com with ESMTPSA id s15-20020a50ab0f000000b0044ef2ac2650sm2066367edc.90.2022.09.30.12.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 12:08:31 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: [GIT PULL] Final set of (mostly selftests) KVM patches for Linux 6.0
Date:   Fri, 30 Sep 2022 21:08:28 +0200
Message-Id: <20220930190828.116565-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 69604fe76e58c9d195e48b41d019b07fc27ce9d7:

  Merge tag 'kvm-s390-master-6.0-2' of https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into HEAD (2022-09-23 10:06:08 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus-6.0

for you to fetch changes up to 07834cc4df06d48a354bb0b1eb1b07069584e581:

  KVM: selftests: Compare insn opcodes directly in fix_hypercall_test (2022-09-29 12:54:02 -0400)

----------------------------------------------------------------
A small fix to the reported set of supported CPUID bits, and selftests fixes:

* Skip tests that require EPT when it is not available

* Do not hang when a test fails with an empty stack trace

* avoid spurious failure when running access_tracking_perf_test in a KVM guest

* work around GCC's tendency to optimize loops into mem*() functions, which
  breaks because the guest code in selftests cannot call into PLTs

* fix -Warray-bounds error in fix_hypercall_test

----------------------------------------------------------------
David Matlack (2):
      KVM: selftests: Skip tests that require EPT when it is not available
      KVM: selftests: Gracefully handle empty stack traces

Emanuele Giuseppe Esposito (1):
      KVM: selftests: replace assertion with warning in access_tracking_perf_test

Jim Mattson (1):
      KVM: x86: Hide IA32_PLATFORM_DCA_CAP[31:0] from the guest

Sean Christopherson (2):
      KVM: selftests: Implement memcmp(), memcpy(), and memset() for guest use
      KVM: selftests: Compare insn opcodes directly in fix_hypercall_test

 arch/x86/kvm/cpuid.c                               |  2 --
 tools/testing/selftests/kvm/Makefile               | 11 +++++-
 .../selftests/kvm/access_tracking_perf_test.c      | 25 +++++++++-----
 tools/testing/selftests/kvm/include/x86_64/vmx.h   |  1 +
 tools/testing/selftests/kvm/lib/assert.c           | 20 +++++++----
 tools/testing/selftests/kvm/lib/string_override.c  | 39 ++++++++++++++++++++++
 tools/testing/selftests/kvm/lib/x86_64/vmx.c       | 20 +++++++++++
 .../selftests/kvm/x86_64/fix_hypercall_test.c      | 34 +++++++++----------
 8 files changed, 115 insertions(+), 37 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/lib/string_override.c

