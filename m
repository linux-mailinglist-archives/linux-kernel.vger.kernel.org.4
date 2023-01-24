Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB0567A710
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 00:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjAXXo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 18:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjAXXoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 18:44:54 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDA07A90
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 15:44:27 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id f22-20020a056a00239600b0058d956679f5so7368487pfc.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 15:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fFFBfvEu5VLg59defmzH2FvlyOfW8E99gd126tA324U=;
        b=kzQfMnQc7bDctel0y6zkSBKEPTzMTe+C8KfGYbkPSASXRkLjhqOXeHmVcSqokcZiux
         P3KMX1nFgKchcLywxZDYGxpl0pkcp6iYPIo+/HnJFbv0vqcmLaMJTlCSfM3n+kD9t6Gr
         cmc19YqbaCrBtdrTDnrcJiPDeBodxFFID5vFnjJlLbe++tkX4yuo/wQpJsQiB13tcCpd
         JFDT7WgEyILqjNvOX2IMTJuwdI6HGnhmQdqx70W798Vr529YcYGBxbvh1bmqFP2iokiW
         tlCcWOmFH8r1nfQxA7ayCdnjikIDlgftWyDNIVRaA3ihPtfj8VbwgOH1oLIUe5LHB+fr
         FMXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fFFBfvEu5VLg59defmzH2FvlyOfW8E99gd126tA324U=;
        b=XwHNuw69iaYLSm4hb+Kh26iJ54lVbhsir2bM5oaDSLrooamDiyVsGQkmq+kT3Rg1EA
         mvh0Gj7tOscOUhn7bIPTA10X7IbOQN8VFuwq8hmqqVbxuXMJncyfKuLtpELfa+/2isb1
         W6hTIK6WAKXxTbhmSUBxe8GY6iQfqppln/qsUmzEGgTpk1eV6BW9KW75tnU3bt8Nsksl
         A9S0yS81VAYrRpiGpkRj14AyvFMxDmvvpI90nWXBNjoul0slchEFa86CulOqLn3kgpYa
         OXP9Eax0xGDyjDsLTPjeOLBU10ZnigJKtZPrJ9Po9C9IoFPNU815EEDuQnteIbNPEETW
         a2Cw==
X-Gm-Message-State: AFqh2kpV7hapD+wGlCTgHHqjw32Sr5EdzuzF8jOtRVQYakixIun2kOCv
        rmDTUo54EEYgc1wcU3YfXgMs0S31/efkqyOoDOe0gS1kjKp9CmRWXD0u3KyqW825JIJD/8xP/aw
        +1S8VoKXcHWHIgzrEODklBSRDVe9nd4Vp+zTSndtJb1auGqjsAmdqJx1XpP8sy0OuWy/vWB60
X-Google-Smtp-Source: AMrXdXusrDjBo770j41mCfitZrmLxt6U7gsCPWj9jlJLvjFzQ1BbhgI3o7ajkrrDKbT/w5oj4iy0W9YLZi7z
X-Received: from sweer.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:e45])
 (user=bgardon job=sendgmr) by 2002:a05:6a00:4088:b0:586:7e0c:372d with SMTP
 id bw8-20020a056a00408800b005867e0c372dmr3395581pfb.14.1674603865728; Tue, 24
 Jan 2023 15:44:25 -0800 (PST)
Date:   Tue, 24 Jan 2023 23:44:21 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230124234423.1411384-1-bgardon@google.com>
Subject: [PATCH v3 0/2] selftests: KVM: Add a test for eager page splitting
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

Ben Gardon (2):
  selftests: KVM: Move dirty logging functions to memstress.(c|h)
  selftests: KVM: Add dirty logging page splitting test

 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/dirty_log_perf_test.c       |  84 +-----
 .../selftests/kvm/include/kvm_util_base.h     |   1 +
 .../testing/selftests/kvm/include/memstress.h |   8 +
 tools/testing/selftests/kvm/lib/kvm_util.c    |   5 +
 tools/testing/selftests/kvm/lib/memstress.c   |  72 +++++
 .../x86_64/dirty_log_page_splitting_test.c    | 254 ++++++++++++++++++
 7 files changed, 348 insertions(+), 77 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86_64/dirty_log_page_splitting_test.c

-- 
2.39.1.456.gfc5497dd1b-goog

