Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11D76785B7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 20:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbjAWTDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 14:03:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbjAWTDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 14:03:36 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0231746B5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 11:03:33 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id t13-20020a056902018d00b0074747131938so14058074ybh.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 11:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c0aPFGh+EbhpDA8u1HNNvqmerWyOrSTVQUevWLuMx4M=;
        b=Q1Xep6WuRTECPnzaTPDk1AXEL0yLRuhCEvbplErSAnbd3CrR3YvxHq8r6K6RXJ0UgQ
         Zy2ZjKKcZrIHaA+Rt3o0dEBEmLbsQ1uXj+SI3S5NUvseyPfZUGWSz1p01WV7HXt1Kkia
         ihKUU5v8C4KxEVhd0lK5i8iCySG9GJqG+An625QnLrjcNy6bBixHCsYTmUJ6leNwQAz1
         aqzT51Gj+ovQJOhjP3uksyHBBD4zwCSMHMbjw8kMixNxfo/P4FQoGbkv8y6Nkr2/MHRn
         E/xHJLGV1JUnQt7nIg2vV9iEZ/FTdPSo6JiagwOvMc1Cjyn4v0HSAUPkW99i91a93N5T
         mrwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c0aPFGh+EbhpDA8u1HNNvqmerWyOrSTVQUevWLuMx4M=;
        b=qraoe3XcVv/ucXe5ooHnSmdAdeRe/wD7K4mXSUzzHhVqCV5BkoQwFARQNgtehXaznQ
         2Fl9vX2CwUe/4ifIfrOI1HdnKDf1kvADCNblfAKOn4uRO9UYPIXj4WfLmiQygYixiCQW
         X18hkOKHIRXqF187IYk1wgFHeaULvik2BExIy+cVZi0jK1tad5lp8UgrgWZZlvuFFGaw
         v/FpqL70m3ARzzF9OVhLNCc9i+VJPFgNL6Z0FKHPHDaSTNYEG8XED22N3480dkfDA5ep
         9NTDEnJXFZd5Ev6FXrkqVuvhK/3yUyayj/f/UvVpVMahhWFzQqXcDPt1YdpMQwbspseP
         gyIA==
X-Gm-Message-State: AFqh2kq7u9F2x9wDMvTDTJk+fcibGqf5+djIVDFe8QxzuaS7O83Q3dZ6
        yQ150YNqKidOliEVr82mdPZkVe5JIGPuL4Wiic3PBg6DmrdwyWVRaxf6WXrH5mNjLHLmR8YZhn4
        Q5rUbAiKExArsXg0XWIsFtfHh6iXe+RPkKn2oYPeXmPt1cVtti7J+aygImfjqwtdnDC72LDKi
X-Google-Smtp-Source: AMrXdXvBPYOOk8PHU2HSNvIU68hsuQuFEwQeQIo3oAvzHvykBwTNsWTHYm5Oh9iFucvI//nhkWcvZo2zMZN8
X-Received: from sweer.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:e45])
 (user=bgardon job=sendgmr) by 2002:a25:300a:0:b0:7e9:643f:155a with SMTP id
 w10-20020a25300a000000b007e9643f155amr1996264ybw.607.1674500612211; Mon, 23
 Jan 2023 11:03:32 -0800 (PST)
Date:   Mon, 23 Jan 2023 19:03:27 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.405.gd4c25cc71f-goog
Message-ID: <20230123190329.520285-1-bgardon@google.com>
Subject: [PATCH v2 0/2] selftests: KVM: Add a test for eager page splitting
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
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

Ben Gardon (2):
  selftests: KVM: Move dirty logging functions to memstress.(c|h)
  selftests: KVM: Add page splitting test

 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/dirty_log_perf_test.c       |  84 +-----
 .../selftests/kvm/include/kvm_util_base.h     |   1 +
 .../testing/selftests/kvm/include/memstress.h |   8 +
 tools/testing/selftests/kvm/lib/kvm_util.c    |   5 +
 tools/testing/selftests/kvm/lib/memstress.c   |  72 +++++
 .../kvm/x86_64/page_splitting_test.c          | 278 ++++++++++++++++++
 7 files changed, 372 insertions(+), 77 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86_64/page_splitting_test.c

-- 
2.39.1.405.gd4c25cc71f-goog

