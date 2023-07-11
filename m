Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941B674FB9C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 01:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjGKXBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 19:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjGKXBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 19:01:36 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6308610CF
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 16:01:35 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1b8a7735231so64505355ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 16:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689116495; x=1691708495;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ArFj1o9NSdPQxx1m9ygKjSQno20NdD8JCdPYTouZybg=;
        b=x3HRX0SKKbx4+NkpXEbDDUTRypVaGi5VgoGmKzAPfyHkaq+gWEOmJea0l+ewoaRCoI
         MO0KeNEAbjAVDfwPZsGrevdQcfi1D23vyyqcKUfZ9uuB1Mp1DpNJFiM+rupUsres0QDw
         U4GVVXSxS1rEzthJHabrf1jVkEVc4hMyLnCLHC/qrZZly88AWh0Fn5bPdfV14ch1ap1q
         M0LOUGuRRtXHH0IHWpipEXuSwvQDCv9+aMUrqtrbEc9ijPXBDT4lPCc8NzGyjtxQIFrZ
         M2q4eqVEWBtxTQBkSW96Zv56mj0cnwERzxiQ/8KWp0+vM9060eSDFwE2f7jzcQj9c8xl
         oj7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689116495; x=1691708495;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ArFj1o9NSdPQxx1m9ygKjSQno20NdD8JCdPYTouZybg=;
        b=XApTZNe07CkJrGsmVyHGfdlKLuV8h8dc00z1de8+L5Tl3jmIDuXPFjOIUcXPXQG8Va
         50bwMYpHBbsWmkEJL3vTnzpw0JYvsS+kpTYgt2Odh989qfnd4sKlJ26wt7JGJ9fiQyGe
         PgLYlk3FcUKQcGFgPsb+9tyS+gcHQbWznpMvrTAvpuWHO7cAhhNLMVibtPBttEOleL/R
         3J0L3Af7d0ZRaaL8fG+HaEyRgQ9G6kU9S0JWYEnUnoT2dCPrGz6rP+vCDXbPQ6s3KpiZ
         EiCmOTkhIcU/lBVKquBSSeuF2ctjkNuGLiZNvfOaFhFX9vm2pFNZb7BzGOYI/6zAaIlV
         gVeg==
X-Gm-Message-State: ABy/qLaLCX5b1XV1OW0xbpDvA6mgMhSJ5jsVYRC0jtmLDnQRrqh1Mu8Y
        oypXPQLhGNL7u2LMDp9hzxSikobXOzE=
X-Google-Smtp-Source: APBJJlEnsGjdY86SpJV8AfP5O0Y+w0eDh5v2W1Ha3ueE6ESzD8l1xlfCwxQzysRlxUoU47FTo8Gi3Z0O4EQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:aa09:b0:1b8:95fc:d0f with SMTP id
 be9-20020a170902aa0900b001b895fc0d0fmr12256129plb.7.1689116494750; Tue, 11
 Jul 2023 16:01:34 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 11 Jul 2023 16:01:24 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230711230131.648752-1-seanjc@google.com>
Subject: [PATCH 0/7] KVM: Grab KVM references for stats fds
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zheng Zhang <zheng.zhang@email.ucr.edu>,
        Kees Cook <keescook@chromium.org>,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Grab a reference to the VM when handing a userspace stats fds for VMs and
vCPUs to ensure the stats files don't outlive the VM and its vCPUs, and add
a regression testcase in selftests.

Sean Christopherson (7):
  KVM: Grab a reference to KVM for VM and vCPU stats file descriptors
  KVM: selftests: Use pread() to read binary stats header
  KVM: selftests: Clean up stats fd in common stats_test() helper
  KVM: selftests: Explicitly free vcpus array in binary stats test
  KVM: selftests: Verify userspace can create "redundant" binary stats
    files
  KVM: selftests: Verify stats fd can be dup()'d and read
  KVM: selftests: Verify stats fd is usable after VM fd has been closed

 .../selftests/kvm/include/kvm_util_base.h     |  6 +-
 .../selftests/kvm/kvm_binary_stats_test.c     | 72 ++++++++++++-------
 virt/kvm/kvm_main.c                           | 24 +++++++
 3 files changed, 75 insertions(+), 27 deletions(-)


base-commit: 255006adb3da71bb75c334453786df781b415f54
-- 
2.41.0.255.g8b1d071c50-goog

