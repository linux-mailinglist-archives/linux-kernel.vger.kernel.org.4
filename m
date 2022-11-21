Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157C76330C8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 00:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbiKUXks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 18:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbiKUXkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 18:40:37 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2879C67D9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 15:40:36 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id x30-20020a63485e000000b004779bfed201so286910pgk.18
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 15:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lj+nrpSFC+IPOVqJGeT+M/QqW9oLqnbJUm77sFsOcLo=;
        b=GNqLGO5Glk6kSrIzXwNhyJJ6I1+a6XEIC7UISSMHjmsX7+4eRDzlX6TqDqgV33/8u2
         IdiB80UCRAMTG3VfVu+MyBlmUvbtP2K9uWW8crg6e4b5LVdn4VZl3qts2YNfghkV1u4M
         P7cz6liwBxlRHNDEtGY5K4CX/4wTiYstsEdKsjB36DcXL7Czvowt8f6kOFYmFA8s/Gg1
         wq2iMsmW5cw7u9FHpdm+DDaROryCwjx9XaIM16s28cwsQBySUEwqB+7CDPyeiWLKhStn
         WdVhZPJntiluI8QfDhV2A7/HCapjE9XXtMpnjoz3HgnJRLp6yP0Wn/c9p1He7kXSB73G
         Gfzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lj+nrpSFC+IPOVqJGeT+M/QqW9oLqnbJUm77sFsOcLo=;
        b=u2auYAYysrdZZSM9ivlUfk1Z7YQgt/SBWlDShngQXoklamLcqYsAMSSK3Zs1oSijWK
         2RMTmDRIYCYWfkljHOuiAF1GIUmoa3M+8i+xqQzrueiVkyfCR3NeQR6WG7lzLrZyQ72O
         Af0KJYX7uRH4VVVPaCV5jh5RI8tstLSkg8x0f2644lfEYNGkRKhlV2OxQWrQhnu8mkCy
         IvBfA24uFH3T7I1wKRj+tRwBi0jA93oTB0Tk82DKXqTQBqo4pGA2vdstmZE2d2shbtyA
         aSLwp/osvwrQW0ITQTF6tGDUoD93pbzxg0H+kK5LCFB5O+1qyGMCA+99tlEiQEA81D95
         j5cg==
X-Gm-Message-State: ANoB5pmlv+ZjbvfuQ0aNKbNxTOlKzFM93PHvANS5WFiv8XCpxv8ecG5C
        lr/lIEAKW3dXDT+PN3MgmaRXumdEO1Wz
X-Google-Smtp-Source: AA0mqf5XgH4zKB0SJNVE0UYXvb2akKisO1ZuLKDFsMHZ/VyHB/ETdSJnGgSFkD4hvB7ibzudk0XMSiZQkn7B
X-Received: from vipin.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:479f])
 (user=vipinsh job=sendgmr) by 2002:a17:90a:df8c:b0:20a:fee1:8f69 with SMTP id
 p12-20020a17090adf8c00b0020afee18f69mr1986961pjv.0.1669074036121; Mon, 21 Nov
 2022 15:40:36 -0800 (PST)
Date:   Mon, 21 Nov 2022 15:40:24 -0800
In-Reply-To: <20221121234026.3037083-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20221121234026.3037083-1-vipinsh@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221121234026.3037083-5-vipinsh@google.com>
Subject: [PATCH v2 4/6] KVM: selftests: Replace hardcoded Linux OS id with HYPERV_LINUX_OS_ID
From:   Vipin Sharma <vipinsh@google.com>
To:     seanjc@google.com, pbonzini@redhat.com, vkuznets@redhat.com,
        dmatlack@google.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vipin Sharma <vipinsh@google.com>
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

Use HYPERV_LINUX_OS_ID macro instead of hardcoded 0x8100 << 48

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 tools/testing/selftests/kvm/x86_64/hyperv_clock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_clock.c b/tools/testing/selftests/kvm/x86_64/hyperv_clock.c
index d576bc8ce823..2ee0af0d449e 100644
--- a/tools/testing/selftests/kvm/x86_64/hyperv_clock.c
+++ b/tools/testing/selftests/kvm/x86_64/hyperv_clock.c
@@ -104,7 +104,7 @@ static void guest_main(struct ms_hyperv_tsc_page *tsc_page, vm_paddr_t tsc_page_
 
 	/* Set Guest OS id to enable Hyper-V emulation */
 	GUEST_SYNC(1);
-	wrmsr(HV_X64_MSR_GUEST_OS_ID, (u64)0x8100 << 48);
+	wrmsr(HV_X64_MSR_GUEST_OS_ID, HYPERV_LINUX_OS_ID);
 	GUEST_SYNC(2);
 
 	check_tsc_msr_rdtsc();
-- 
2.38.1.584.g0f3c55d4c2-goog

