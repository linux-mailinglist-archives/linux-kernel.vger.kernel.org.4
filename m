Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31985FBBA3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 21:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiJKT6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 15:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiJKT6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 15:58:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4995797EF2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 12:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665518293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=nW4Tem6gjDlyI55SAwvtu6ESz8FR9RsyePOG8cHS2ck=;
        b=Ki+XbOdtf2t/LBjdeAJNm5Sclzfl7rO1BjRuCOwt3Qrk/rOmknAL+DXfJOqHo+6eYKB9jP
        6uGkMRvS/MoPT4zHoTDnQUYpQvH77ScV8wOjd/RDaQ6s0/ONwTH5dSYZDJwaXqHIfpsZ7I
        Atpy2ea/ZUKlCa0EVWaFTCV7Vu8Ljm8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-113-9Md6r8G1Pq2sarmailt6kA-1; Tue, 11 Oct 2022 15:58:12 -0400
X-MC-Unique: 9Md6r8G1Pq2sarmailt6kA-1
Received: by mail-qv1-f70.google.com with SMTP id cy11-20020a05621418cb00b004b17b3cf429so8525311qvb.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 12:58:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nW4Tem6gjDlyI55SAwvtu6ESz8FR9RsyePOG8cHS2ck=;
        b=1XtRUiJ+RQrH1bSySjLrYthmPt6qi8MEha6r6TImaU4S0p11fLua0UXMduS2RKvZuT
         MrQbw1nfmlw/hMUDCPF2fuUQ137EQzqvvuhpE9a9OXYyqttX+hDkptxVJQPzRBtql7ID
         dI4KQWo4XP0s5ZkaEHEf8j98csWRhBkBECqbHUAwyCkvPpticDoZ3N7ztPJXDXo09QVa
         l6eNu5+mP7JX0N5n7e60CiDh+chVE+66J0gbhtICBoV+dY42OztvEzN4PqdrzHVq96fG
         OyEfGgApQVP8D59ZiFjsQDzMrB/vyDAKEBVymaAlezRwgwrzusTVz8p5OLrw6A+Oa2n5
         QMbg==
X-Gm-Message-State: ACrzQf0focSGxlo5dOq0Y5RoeckzJoBKGZZXCktr9h4K63IJ/sIhPwF0
        jCx1uI6qQAYZEQ1PfcpLkU4TFu/2ZY6pTJR4O8Jhnkjk+fvXYHj3XWQgyVmNdiVoFs7jAd91FeV
        MMKL33vwcqjWC93WmlFkmvhmT
X-Received: by 2002:a05:622a:488:b0:38f:9e9f:e7b7 with SMTP id p8-20020a05622a048800b0038f9e9fe7b7mr20902569qtx.212.1665518291947;
        Tue, 11 Oct 2022 12:58:11 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7mQvmLS4z3S3ameJmrhZO1RKNCxdtRNzX6xV5FGmZxATHaHR21SAyjqAS7KGxUgld/hg7iLw==
X-Received: by 2002:a05:622a:488:b0:38f:9e9f:e7b7 with SMTP id p8-20020a05622a048800b0038f9e9fe7b7mr20902555qtx.212.1665518291701;
        Tue, 11 Oct 2022 12:58:11 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id az31-20020a05620a171f00b006ce9e880c6fsm13648837qkb.111.2022.10.11.12.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 12:58:10 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>, peterx@redhat.com,
        John Hubbard <jhubbard@nvidia.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Linux MM Mailing List <linux-mm@kvack.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v4 0/4] kvm/mm: Allow GUP to respond to non fatal signals
Date:   Tue, 11 Oct 2022 15:58:05 -0400
Message-Id: <20221011195809.557016-1-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4:
- Split patch 2+3 into three patches [Sean]

rfc: https://lore.kernel.org/r/20220617014147.7299-1-peterx@redhat.com
v1:  https://lore.kernel.org/r/20220622213656.81546-1-peterx@redhat.com
v2:  https://lore.kernel.org/r/20220721000318.93522-1-peterx@redhat.com
v3:  https://lore.kernel.org/r/20220817003614.58900-1-peterx@redhat.com

One issue was reported that libvirt won't be able to stop the virtual
machine using QMP command "stop" during a paused postcopy migration [1].

It won't work because "stop the VM" operation requires the hypervisor to
kick all the vcpu threads out using SIG_IPI in QEMU (which is translated to
a SIGUSR1).  However since during a paused postcopy, the vcpu threads are
hang death at handle_userfault() so there're simply not responding to the
kicks.  Further, the "stop" command will further hang the QMP channel.

The mm has facility to process generic signal (FAULT_FLAG_INTERRUPTIBLE),
however it's only used in the PF handlers only, not in GUP. Unluckily, KVM
is a heavy GUP user on guest page faults.  It means we won't be able to
interrupt a long page fault for KVM fetching guest pages with what we have
right now.

I think it's reasonable for GUP to only listen to fatal signals, as most of
the GUP users are not really ready to handle such case.  But actually KVM
is not such an user, and KVM actually has rich infrastructure to handle
even generic signals, and properly deliver the signal to the userspace.
Then the page fault can be retried in the next KVM_RUN.

This patchset added FOLL_INTERRUPTIBLE to enable FAULT_FLAG_INTERRUPTIBLE,
and let KVM be the first one to use it.  KVM and mm/gup can always be able
to respond to fatal signals, but not non-fatal ones until this patchset.

One thing to mention is that this is not allowing all KVM paths to be able
to respond to non fatal signals, but only on x86 slow page faults.  In the
future when more code is ready for handling signal interruptions, we can
explore possibility to have more gup callers using FOLL_INTERRUPTIBLE.

Tests
=====

I created a postcopy environment, pause the migration by shutting down the
network to emulate a network failure (so the handle_userfault() will stuck
for a long time), then I tried three things:

  (1) Sending QMP command "stop" to QEMU monitor,
  (2) Hitting Ctrl-C from QEMU cmdline,
  (3) GDB attach to the dest QEMU process.

Before this patchset, all three use case hang.  After the patchset, all
work just like when there's not network failure at all.

Please have a look, thanks.

[1] https://gitlab.com/qemu-project/qemu/-/issues/1052

Peter Xu (4):
  mm/gup: Add FOLL_INTERRUPTIBLE
  kvm: Add KVM_PFN_ERR_SIGPENDING
  kvm: Add interruptible flag to __gfn_to_pfn_memslot()
  kvm: x86: Allow to respond to generic signals during slow PF

 arch/arm64/kvm/mmu.c                   |  2 +-
 arch/powerpc/kvm/book3s_64_mmu_hv.c    |  2 +-
 arch/powerpc/kvm/book3s_64_mmu_radix.c |  2 +-
 arch/x86/kvm/mmu/mmu.c                 | 18 ++++++++++----
 include/linux/kvm_host.h               | 14 +++++++++--
 include/linux/mm.h                     |  1 +
 mm/gup.c                               | 33 ++++++++++++++++++++++----
 mm/hugetlb.c                           |  5 +++-
 virt/kvm/kvm_main.c                    | 30 ++++++++++++++---------
 virt/kvm/kvm_mm.h                      |  4 ++--
 virt/kvm/pfncache.c                    |  2 +-
 11 files changed, 85 insertions(+), 28 deletions(-)

-- 
2.37.3

