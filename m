Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31DB1674484
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 22:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjASVcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 16:32:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbjASVbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 16:31:10 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBFBA791C
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 13:25:29 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id 24-20020aa79118000000b00580476432deso1460907pfh.23
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 13:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vgnyLDNSgvwVcu8AmZopvdgW3ASujbk2oM4NuNZjZP0=;
        b=g898MByqpR4QSdftZPPM8wJDP652HbA9+ZoMck6HqIY8547fIVJkQecY35bALgkuPd
         PwVfUBLHI/Pc1DE+zmAXJ9FoEqn7DOqt7PwrqU6yyZSn7YCmGVfH2QIQmUWB7Xp4j5no
         DkjiYEr8kDHWxOVqs3B22PKilcSQ65XNsUUM1RaWm9kTSjcjeQewFvrsBsr9jhq8B54m
         Dm4z3FlRDZzfXGw1sxpe76q8kM+QRApZA/E16DnbeYu5tG2boGFuHaPhKsL2sNLhSru+
         8f92Y8e1sIWEb0uLYDXnx0XLEfL83kjSWOuL1N78+JcgqIlRhHGLkx97xR4ZklUL0T++
         RVTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vgnyLDNSgvwVcu8AmZopvdgW3ASujbk2oM4NuNZjZP0=;
        b=h+aWHTEPV7LPfB+yMgtSa8LKP7ws+MxdlV55XdSeICo6FipCmwsVt+4VpneBYezzih
         Man1kohVv5XFZiq2hlCWiB/ILST3/Smh3R3Ow7Fhgv+1A60PU/z7KeUxFusjY5aI51MT
         yGFYNrjyEDr/li9zELH2sk1nlM37b6G9uqNaSyrdibmdfUy0pwH+jouOXXXzYdBohwow
         G8vL/6yMlfbTfB5JwGx5fiYr5lw+2JeTbMBpLIRyJWgH8LpZBTpaFb/nGDnbhThlXOch
         vPGRllk/PBp4GcU+tdO8MQznrZayxX7b3tdujbTqh+oNl2gd8SR2hSEsCJOXxIcK3ie7
         j6aw==
X-Gm-Message-State: AFqh2kr7NvlielZOmzLCHCjJU7XK+P8dkS4E2jCZvo5MUtz4XYi7Z0Ms
        MI2A8S50AOpaPzOSe7kk1dy3INpTUOgHE30aONgVD8qIZFdheQ7ntjkhp+Pc5tQRpJ7myuHxjV/
        Dk8f80t3g2sLl8UQ7t9j/e3a+pPieEDfco7aP1/FKuIkxWzDwnRHZV3imNojwUv1fX2ZNPNQD
X-Google-Smtp-Source: AMrXdXsRjd0daJT+VjjXiboL/8dO+R8B8aw5WpitBxaWhaDlAZ5nDoMUEkMtP6482azch2U/BAwlzi7Iqqq6
X-Received: from sweer.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:e45])
 (user=bgardon job=sendgmr) by 2002:a17:90a:d505:b0:229:1740:1051 with SMTP id
 t5-20020a17090ad50500b0022917401051mr1239826pju.111.1674163513524; Thu, 19
 Jan 2023 13:25:13 -0800 (PST)
Date:   Thu, 19 Jan 2023 21:25:08 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.405.gd4c25cc71f-goog
Message-ID: <20230119212510.3938454-1-bgardon@google.com>
Subject: [PATCH 0/2] selftests: KVM: Add a test for eager page splitting
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

Please ignore the RFC version of this series. It was not meant as an RFC
and did not include a cover letter.

Ben Gardon (2):
  selftests: KVM: Move dirty logging functions to memstress.(c|h)
  selftests: KVM: Add page splitting test

 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/dirty_log_perf_test.c       |  84 +----
 .../selftests/kvm/include/kvm_util_base.h     |   2 +
 .../testing/selftests/kvm/include/memstress.h |   8 +
 tools/testing/selftests/kvm/lib/kvm_util.c    |   5 +
 tools/testing/selftests/kvm/lib/memstress.c   |  72 ++++
 .../kvm/x86_64/page_splitting_test.c          | 314 ++++++++++++++++++
 7 files changed, 409 insertions(+), 77 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86_64/page_splitting_test.c

-- 
2.39.1.405.gd4c25cc71f-goog

