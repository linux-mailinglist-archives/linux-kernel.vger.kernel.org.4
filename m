Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C9C62C5C0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 18:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234187AbiKPRDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 12:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233746AbiKPRDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 12:03:41 -0500
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF8F10FD8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:03:39 -0800 (PST)
Received: by mail-ej1-x64a.google.com with SMTP id sh31-20020a1709076e9f00b007ae32b7eb51so10246858ejc.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cqmymE4F1AzcVr0rAjT0TqGqidpCow5ff2C/QyEftUQ=;
        b=d5fT1+t1Uo2vlTG633RLZsby5RVVFLgn62ja1ehg00dbGfGQEC4Dclj3otyomMqUPd
         dRK431qRTVccl0zLA+QR3Sg1k5tDwTP8ZvlufaosrJTeU3I9SGP6OP3RA3fRRBtnD8Ra
         5Bw4S/8y6bjg7zU/jiFNGb7HTGS1TeUhX/xk/4NS1EVllxg4OgkSwcX6hc6UYr74us+Q
         7JJL7Zfs2I7Vnj52QpXivh6m59Efsn5pt519MvUQncwPIFm88yDje7J8NmlGrXYMAjTf
         qIASv6dOtCL/6Kntz4wo0E5kYL/8nDfVYFicos/exbnXSX97JGrG8tez3uP+AGBti+4i
         s/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cqmymE4F1AzcVr0rAjT0TqGqidpCow5ff2C/QyEftUQ=;
        b=oiLx/Y4hQI2QYHjyLdKxZTDkXOWySVYL4ypAt/G0GIXvrsRr3QT6pC3tTdzEqtx3IU
         VwYgYHVEtku8XRwsNGafdhDJuXs6DeRhWcJPZWGo51fehqedS6GlhuAr+qaZ8yfULkQB
         2dJH7Hfyejn1hlDYY1r+Jh+JrJj6JQHl1mfwFlJf84ACFJUysAuac4chDzVQWj+mygxY
         YYap9V22SjH9vkyRttJ188iwe0FRP2JFQG2+yItvFF2Rq08jdYBK6ugNbaEDLf4FewI3
         LuLWYWPijziE4/mgWguosbBxscSm3AGqsajSPrCnfgSDmfmjexBo0bCd9vSIs39rNGFA
         3HBw==
X-Gm-Message-State: ANoB5pkVMjQ+NGQ3Zc2V5gRzb8v6zEv/0MaRBORQnDZZHe5FoXMplixE
        lrqEvERicaHVM+JROc4JaN8/SFxJRm92
X-Google-Smtp-Source: AA0mqf4kQcttgHovLZay3IZ5h8ySDasGuaZQArDBf5GZUHdssSgbM3MLRht2rLrBlFf4v9LLwgRpdc7gy3Ky
X-Received: from big-boi.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:129])
 (user=qperret job=sendgmr) by 2002:a17:906:6893:b0:7ad:14f8:7583 with SMTP id
 n19-20020a170906689300b007ad14f87583mr19341242ejr.185.1668618218081; Wed, 16
 Nov 2022 09:03:38 -0800 (PST)
Date:   Wed, 16 Nov 2022 17:03:23 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221116170335.2341003-1-qperret@google.com>
Subject: [PATCH 00/12] KVM: arm64: FF-A proxy for pKVM
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Andrew Walbran <qwandor@google.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        kernel-team@android.com, qperret@google.com
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

Hi all,

pKVM's primary goal is to protect guest pages from a compromised host by
enforcing access control restrictions using stage-2 page-tables. Sadly,
this cannot prevent TrustZone from accessing non-secure memory, and a
compromised host could, for example, perform a 'confused deputy' attack
by asking TrustZone to use pages that have been donated to protected
guests. This would effectively allow the host to have TrustZone
exfiltrate guest secrets on its behalf, hence breaking the isolation
that pKVM intends to provide.

This series addresses this problem by providing pKVM with the ability to
monitor SMCs following the Arm FF-A protocol. FF-A provides (among other
things) a set of memory management APIs allowing the Normal World to
share, donate or lend pages with Secure. By monitoring these SMCs, pKVM
can ensure that the pages that are shared, lent or donated to Secure by
the host kernel are only pages that it owns.

It should be noted that the robustness of this approach relies on having
all Secure Software on the device use the FF-A protocol for memory
management transactions with the normal world, and not use
vendor-specific SMCs that pKVM is unable to parse. This is an important
software requirement to integrate pKVM correctly on a device. For the
record, this work is tractable in real world scenarios -- it was done
for the Pixel 7 and Pixel 7 Pro devices, both of which launched recently
with pKVM enabled.

This series introduces support for monitoring FF-A SMCs in the form of a
minimal proxy running in the EL2 hypervisor. This proxy aims to be
entirely 'transparent' to both the host kernel and TrustZone when the
system behaves correctly (the host is not compromised). The FF-A proxy
intercepts the SMCs coming from the host, and verifies that the pages
involved in the memory transition can be shared/lent/donated legally
before forwarding the SMC to Secure. The proxy also tracks which pages
have been made accessible to TrustZone at any point in time using
software bits in the stage-2 page-table of the host, to ensure they
can't be subsequently donated to guests.

The patch series is divided as follows:

 - patches 01-02 refactor existing FF-A header to allow code re-use;

 - patches 03-07 provide the initial infrastructure at EL2 to handle
   FF-A SMCs;

 - patches 08-12 use the previously introduced infrastructure to
   intercept the main memory management operations to share, reclaim and
   lend memory to/with Secure, and implement the core of the memory
   tracking logic.

Since this series depends on Will's recent pKVM series [1], it is based
on today's kvmarm/next:

    eb8be68e907e ("Merge branch kvm-arm64/misc-6.2 into kvmarm-master/next")

A branch with all the goodies applied can also be found here:

    https://android-kvm.googlesource.com/linux qperret/ffa-proxy

Feedback welcome!

Cheers,
Quentin

[1] https://lore.kernel.org/kvm/20221110190259.26861-1-will@kernel.org/

Fuad Tabba (1):
  KVM: arm64: Handle FFA_FEATURES call from the host

Quentin Perret (1):
  ANDROID: KVM: arm64: pkvm: Add support for fragmented FF-A descriptors

Will Deacon (10):
  firmware: arm_ffa: Move constants to header file
  firmware: arm_ffa: Move comment before the field it is documenting
  KVM: arm64: Block unsafe FF-A calls from the host
  KVM: arm64: Probe FF-A version and host/hyp partition ID during init
  KVM: arm64: Allocate pages for hypervisor FF-A mailboxes
  KVM: arm64: Handle FFA_RXTX_MAP and FFA_RXTX_UNMAP calls from the host
  KVM: arm64: Add FF-A helpers to share/unshare memory with secure world
  KVM: arm64: Handle FFA_MEM_SHARE calls from the host
  KVM: arm64: Handle FFA_MEM_RECLAIM calls from the host
  KVM: arm64: Handle FFA_MEM_LEND calls from the host

 arch/arm64/include/asm/kvm_host.h             |   1 +
 arch/arm64/include/asm/kvm_pkvm.h             |  21 +
 arch/arm64/kvm/arm.c                          |   1 +
 arch/arm64/kvm/hyp/include/nvhe/ffa.h         |  17 +
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |   3 +
 arch/arm64/kvm/hyp/nvhe/Makefile              |   2 +-
 arch/arm64/kvm/hyp/nvhe/ffa.c                 | 741 ++++++++++++++++++
 arch/arm64/kvm/hyp/nvhe/hyp-main.c            |   3 +
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         |  68 ++
 arch/arm64/kvm/hyp/nvhe/setup.c               |  11 +
 arch/arm64/kvm/pkvm.c                         |   1 +
 drivers/firmware/arm_ffa/driver.c             | 101 +--
 include/linux/arm_ffa.h                       |  93 ++-
 13 files changed, 970 insertions(+), 93 deletions(-)
 create mode 100644 arch/arm64/kvm/hyp/include/nvhe/ffa.h
 create mode 100644 arch/arm64/kvm/hyp/nvhe/ffa.c

-- 
2.38.1.431.g37b22c650d-goog

