Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD8867B937
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 19:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbjAYSXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 13:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234955AbjAYSXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 13:23:15 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66F621A0F
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 10:23:14 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id n93-20020a17090a2ce600b0022beeabcf6cso1469373pjd.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 10:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M87dcnyKpD7G1vtcjsccWcpFLIefiVPTj+pV2nUpSG4=;
        b=cqpU958WIRRZuxW78R8qLwP+/G95uXUi6naqyOp/KrsDH9if60UbRnnpSi2+pR2nev
         UK0+lCkc1WO0Hpsuy/8qer2ScUxTcEJYaFQyGoElV5ud+7U+8NEi1CsKyjupA4DsYSBl
         6wY/eYBQtIazYv+TRXs9mONbINl5SI/X9zN+sFBW0Ti8ti1GUFv5XiCc01KdJCj87hvm
         JmBFFqc7+pgA6JtPXLoO6x6VspQEw4Vmnm3xWOGBgMo/dhvKSXKAgYxaNqAfttmmUFYW
         HHEkGOtucdfiiqpFfBuyUinQzEo9WwVZ1EwCXBJDlKYfyw8XKi1XHIjs2Q1a8qGrRFx/
         txUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M87dcnyKpD7G1vtcjsccWcpFLIefiVPTj+pV2nUpSG4=;
        b=pJt4qTuSbTd7lnEfvnvBne+z5U8Ng0aFEF79I0CZ0zkTXHZWADYfEXi5LuFDPB7Z7w
         5XMmlLniJAn73FmhzZlEEWD9VvEyYfpEQZO5ToX2SZRJov81D1tqOJu72R2j2vKsP6Ua
         Zas0QzezC2FeA8B4GOM1ux/XRLOOzFTrGvoCrM2HI0Ah1Yv+hj2lXJMRtbliOwT82fql
         YDj8JgPJByQaqASMm4lpFApAbtG+9irfAbwMPffwIMU8WGilaBGqDaGpoywgEJOKnYlK
         6RkBvd9QqmNOMwuN9b5nitozQzo1mn6hNjbqsRdIAKGPg6jnrEmvCUYMFdDcauo76vPu
         w6+A==
X-Gm-Message-State: AFqh2kqrAz0p9mAGCXVcbLPvdRcowXQly+8fZbbk4hwMq3GLSC2CZBbI
        Ql22/EH7wsW4hcBu8aIFfHaQZHZ8MCHw2AMsMoB029a3LrnES3I9rVzo4vfYW3Lty70I+vpTq9b
        JrccfiSjIxyUXN95DQdYW+yvtcSAz0NQXYRgX8VUi8vhxtIYAlD09V4ZNTAsRxm/NhMddLCJz
X-Google-Smtp-Source: AMrXdXtEpWrAsWzep2D2iByFfZUFSPA1b2tP11R7WCW7y9XyIuLS885Q86bi0AFPoSOC3bUhgujVshoODF4I
X-Received: from sweer.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:e45])
 (user=bgardon job=sendgmr) by 2002:a17:902:aa4b:b0:194:b3c6:18ee with SMTP id
 c11-20020a170902aa4b00b00194b3c618eemr3153349plr.29.1674670994101; Wed, 25
 Jan 2023 10:23:14 -0800 (PST)
Date:   Wed, 25 Jan 2023 18:23:09 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230125182311.2022303-1-bgardon@google.com>
Subject: [PATCH v4 0/2] selftests: KVM: Add a test for eager page splitting
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        David Matlack <dmatlack@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Ben Gardon <bgardon@google.com>
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

David Matlack recently added a feature known as eager page splitting
to x86 KVM. This feature improves vCPU performance during dirty
logging because the splitting operation is moved out of the page
fault path, avoiding EPT/NPT violations or allowing the vCPU threads
to resolve the violation in the fast path.

While this feature is a great performance improvement, it does not
have adequate testing in KVM selftests. Add a test to provide coverage
of eager page splitting.

Patch 1 is a quick refactor to be able to re-use some code from
dirty_log_perf_test.
Patch 2 adds the actual test.

V1->V2:
	Run test in multiple modes, as suggested by David and Ricardo
	Cleanups from shameful copy-pasta, as suggested by David
V2->V3:
	Removed copyright notice from the top of
	dirty_log_page_splitting.c
	Adopted ASSERT_EQ for test assertions
	Now skipping testing with MANUAL_PROTECT if unsupported
V3->V4:
	Added the copyright notices back. Thanks Vipin for the right
	thing to do there.

Ben Gardon (2):
  selftests: KVM: Move dirty logging functions to memstress.(c|h)
  selftests: KVM: Add dirty logging page splitting test

 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/dirty_log_perf_test.c       |  84 +-----
 .../selftests/kvm/include/kvm_util_base.h     |   1 +
 .../testing/selftests/kvm/include/memstress.h |   8 +
 tools/testing/selftests/kvm/lib/kvm_util.c    |   5 +
 tools/testing/selftests/kvm/lib/memstress.c   |  72 +++++
 .../x86_64/dirty_log_page_splitting_test.c    | 257 ++++++++++++++++++
 7 files changed, 351 insertions(+), 77 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86_64/dirty_log_page_splitting_test.c

-- 
2.39.1.456.gfc5497dd1b-goog

