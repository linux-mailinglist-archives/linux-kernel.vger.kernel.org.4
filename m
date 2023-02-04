Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B885A68A7DC
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 03:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbjBDCl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 21:41:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjBDClz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 21:41:55 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D2784F88
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 18:41:55 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-517f8be4b00so68082747b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 18:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JaGD77z6glMAqdeMPmzRcweXd3jq1lm/S+vUg4niZQc=;
        b=UUk/GaXrUQS33YnwFDGA8QeyE5UvG61YlpFcQBrMve3bTjG8xd5WLboKcHFeneo43v
         CrQy6mtTB/dLbCCObdwdObC6bXy2R9RrLkCCaaUyMkWLnxMnBJ9yuCX3ib2sDQ/drw+h
         I4NoeasDNtTeA10XEx2OM6PDK2mqF9VrWb/Vn//xVv6/VPC56DxHebhRaABqWyIXKiAD
         9NcAX22n+jQm/nfQkFFA3sANTFtdSxJ9IsfccMp3DJYShoAX00F9x9hWj7FH6XWh1zVL
         xSbenv/O0d70/O4Et+2Bq5fzZ9w/GsVAe7coJhD6H1q06NjBF9Pt95iSed7O2Y48HxMk
         UeZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JaGD77z6glMAqdeMPmzRcweXd3jq1lm/S+vUg4niZQc=;
        b=tpkmZE6uPVb5F6kci4EoMqPXYReHaJukp2g8Oyt+tRy08Wq3ierPctMOske1kAaW8V
         t4AWpa0oL4QJkTfQQ2WiOI26Q+0PVqAYA0KpY/vwby+wbC2Kgnt7IB2HUGCOrBELNDyY
         4AxHKVBNJcv1KhKDAw+yyUqzOPvNbiTvFfFMaCUYs5FeDUN68gLgX7P3LXxQF88REJNI
         d9+4qYFHw8f8hGugotc0oRiLYFZaBfN53K+JI3BhXN/JqbmSb4Nx6m3p/4l5WXSEaVvu
         e5eDNXkvAUrgrTC/lHilejyIpQfEUZpVsJKREjxe9rFU5rxWBshwUQOs31iYgwm5yAu7
         +JhQ==
X-Gm-Message-State: AO0yUKXqHKHUPyPOVclwTHRaAKkYU1Qb3UOBPi92Bs14PyksLx8iIR+Z
        TpZZ4pLSoQ5PRq7wBAzEvDiJSH5lbeo=
X-Google-Smtp-Source: AK7set/DquwsjecH3NSCJtOiptGpwbB9+Xfbpj6ZYipn33L9V+uQ39TMDaIRWr8Gy2XwXd7OuGya6KPKPi4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:8910:0:b0:874:5ecb:3cae with SMTP id
 e16-20020a258910000000b008745ecb3caemr302913ybl.319.1675478514247; Fri, 03
 Feb 2023 18:41:54 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat,  4 Feb 2023 02:41:47 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Message-ID: <20230204024151.1373296-1-seanjc@google.com>
Subject: [PATCH v2 0/4] KVM: selftests: xen_shinfo cleanups and slowpath test
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        David Woodhouse <dwmw@amazon.co.uk>
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

David's new testcase to validate the slow path for EVTCHNOP_send, on top
of cleanups to reduce the amount of copy+paste in the test.

Applies on top of `kvm-x86 selftests`.

David Woodhouse (2):
  KVM: selftests: Use enum for test numbers in xen_shinfo_test
  KVM: selftests: Add EVTCHNOP_send slow path test to xen_shinfo_test

Sean Christopherson (2):
  KVM: selftests: Move the guts of kvm_hypercall() to a separate macro
  KVM: selftests: Add helpers to make Xen-style VMCALL/VMMCALL
    hypercalls

 .../selftests/kvm/include/x86_64/processor.h  |   2 +
 .../selftests/kvm/lib/x86_64/processor.c      |  37 ++-
 .../selftests/kvm/x86_64/xen_shinfo_test.c    | 221 +++++++++---------
 3 files changed, 145 insertions(+), 115 deletions(-)


base-commit: 531f33c5a6edf259da4960de694293e458262d14
-- 
2.39.1.519.gcb327c4b5f-goog

