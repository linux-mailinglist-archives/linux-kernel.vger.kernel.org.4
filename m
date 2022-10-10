Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDEF5FA782
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 00:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiJJWF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 18:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiJJWFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 18:05:51 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8276112B
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 15:05:45 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id n56-20020a056a000d7800b00562b27194d1so4732842pfv.19
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 15:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mLExz0EMZSyuFB8Q/Foo73cV0V2iUxH9jl6FjrHgHuA=;
        b=MkaNzqUg6OQAS3KXi/d3EbVRp+bK/mHHYYU7YS4eEOcwCnxft2bx4VYtxVPSxLKiwC
         fQ7Tw1l+vwPqb+QLM/2zYNjyrfI3p/HNNpyYmPzjk0HMovr2yeCwxe4dmKj8eNjaAqlK
         mAL3alJu+IyzyVhVzBZifiCqjtB43ANoyE2nRCVK8unJoXM/kkEgyo+1fdj7ZLwmbf+M
         7wF1YLY42oeGeT5iPsipXNXuxmyszTUnbfQjfZTu9C51ffB0Tn5nffKn1sANITjR4Sg1
         CIFjcb0yQf3xwNvje8haD83ZeMqbmdUO9SvYNgoBdjcyDfzdR5VOi5XQSSZNHZzBVf7W
         ZrHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mLExz0EMZSyuFB8Q/Foo73cV0V2iUxH9jl6FjrHgHuA=;
        b=6Lwo9rW4vSAsuOO2Og2ThBHSPiQAvRiPPZMJWkulso5Dkly5/g+V7mIB5EotvjUt2+
         mdpV/LVE8lG7KD3SpWR4JV4a/Q3FiShsXxndFFojZwRKjk6ZX2u2Snkujirai3Z8Ue9b
         89d1pQKL37/ABJZ0PcY+idRqrLKAgnHryQ1VRMK1xylpIyY/XAwz2gk9PDBqqCRt0HxP
         qssfW3n4FpIDFCUXPt/90qAJAjo7ZwzOMCl2S97ullGw3EJMAUWjFmUK3vVhGQXnEMTD
         pNW4/YEPSGC6XSbHnwKVeBqS9OT8NrImS5qXtFI9Z9KK9C1za150F3CIw2R7XCaDUscU
         czEA==
X-Gm-Message-State: ACrzQf0GvNR86UfF+wGJFADwCahm09ASzMzNM8qhVSbQKUMtz1LLox5T
        /71He7A80hwWB8TdiHkKHsfvMpeK2Z1R
X-Google-Smtp-Source: AMsMyM4seMxlZd3QKtALD3XcVrNvAyFwyzsTklJg8t92jVWY9SS0eoPi2DPJxddWEJzfefZiARsvcz1CeL54
X-Received: from vipin.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:479f])
 (user=vipinsh job=sendgmr) by 2002:a05:6a00:e09:b0:563:69ac:5633 with SMTP id
 bq9-20020a056a000e0900b0056369ac5633mr6808226pfb.54.1665439544947; Mon, 10
 Oct 2022 15:05:44 -0700 (PDT)
Date:   Mon, 10 Oct 2022 15:05:34 -0700
In-Reply-To: <20221010220538.1154054-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20221010220538.1154054-1-vipinsh@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221010220538.1154054-2-vipinsh@google.com>
Subject: [PATCH v5 1/5] KVM: selftests: Add missing break between -e and -g
 option in dirty_log_perf_test
From:   Vipin Sharma <vipinsh@google.com>
To:     seanjc@google.com, pbonzini@redhat.com, dmatlack@google.com
Cc:     andrew.jones@linux.dev, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vipin Sharma <vipinsh@google.com>
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

Passing -e option (Run VCPUs while dirty logging is being disabled) in
dirty_log_perf_test also unintentionally enables -g (Do not enable
KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2). Add break between two switch case
logic.

Fixes: cfe12e64b065 ("KVM: selftests: Add an option to run vCPUs while disabling dirty logging")
Signed-off-by: Vipin Sharma <vipinsh@google.com>

---
 tools/testing/selftests/kvm/dirty_log_perf_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/kvm/dirty_log_perf_test.c b/tools/testing/selftests/kvm/dirty_log_perf_test.c
index f99e39a672d3..56e08da3a87f 100644
--- a/tools/testing/selftests/kvm/dirty_log_perf_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_perf_test.c
@@ -411,6 +411,7 @@ int main(int argc, char *argv[])
 		case 'e':
 			/* 'e' is for evil. */
 			run_vcpus_while_disabling_dirty_logging = true;
+			break;
 		case 'g':
 			dirty_log_manual_caps = 0;
 			break;
-- 
2.38.0.rc1.362.ged0d419d3c-goog

