Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D7B6172D6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 00:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbiKBXkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 19:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbiKBXjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 19:39:54 -0400
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC16E10077
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 16:32:45 -0700 (PDT)
Received: by mail-pl1-f202.google.com with SMTP id s15-20020a170902ea0f00b00187050232fcso253047plg.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 16:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6wM4Oy0nUMfbEGH4TnyyZoGSCQjO5BHCNka2AusodrI=;
        b=aaWoxlOtXkyHzeY2UI1c5F/unLAqVQbf9+TC5N/PBWZcNjul/X5RFIAFzlGtRKcWs4
         OgpA6zR7t7i8bZhrEWaXGoRjthT+d7NlbbV8pts9ahkg/WJdtUj2WxbzjOrh3MtpQG+j
         I3YxOyGr8bB0FnEUdY7hJgvBFP5IUCdQXpvcoGcm13WAlHgXuMWQ6OfZg8we6s31U+ss
         Nq0gb/FWFJgrxu4Avp0ZRyDh8zt3rkVuYn+/b8lHOzIGWYEYaFiP4tYRr2F3njnNm4Ju
         pbJsgauh5cZJbDLA2GdVFxGKwOJUHopQxVNefGf9xBQweKlu6TwzVCDAV9rq30AzD+dg
         s8zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6wM4Oy0nUMfbEGH4TnyyZoGSCQjO5BHCNka2AusodrI=;
        b=66mcJMmM8hqjHF+eSvJoDS41Q4J7EU1h/+41xVuc5s83G/g2XTS0Ffmggs+/JweIYT
         YcNDSSRCdbadtWXbJoTNjeGhXZtAchky6HKl9GEonFdSY3O+3CnAXpyqMejCMZtK0b/P
         3870dlMbPqgF9gm61Cy+faogvC//+Y61ixQ/vKUwHvh9rolLuQP+aDPVtE9GqHXNu0lP
         b3Ssa/qT3jZdMGt0Wu19kOOmCE6qatnvkr4GrEhe9T91zFvtrQkTs3EufmIevwf7mjwA
         mZ2ZaHPDrLiWeMr7jS7M2sDZq1Ljt2QKhU0tFeUMnszBuISPxKe+8Mnzmd0Rm7JoVg9D
         5MrQ==
X-Gm-Message-State: ACrzQf2zfJ4fDqy1AH3UN4tlia4HPoRev8X2HaG3G+IVz9MZ30hoQlv8
        Q77N4hUusp4dveiPexo8zX/Va+LrnbIe
X-Google-Smtp-Source: AMsMyM7KtspsKrWGWx2g82Q+EOYHX4ltcWQoGfJpypZF0UhQpS9wL+m7oeIkkgJ5cX1qlx693WhOKI6/DWtI
X-Received: from vipin.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:479f])
 (user=vipinsh job=sendgmr) by 2002:a17:90b:4b0e:b0:214:1328:e33a with SMTP id
 lx14-20020a17090b4b0e00b002141328e33amr10680462pjb.207.1667431662479; Wed, 02
 Nov 2022 16:27:42 -0700 (PDT)
Date:   Wed,  2 Nov 2022 16:27:31 -0700
In-Reply-To: <20221102232737.1351745-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20221102232737.1351745-1-vipinsh@google.com>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
Message-ID: <20221102232737.1351745-2-vipinsh@google.com>
Subject: [PATCH v8 1/7] KVM: selftests: Add missing break between -e and -g
 option in dirty_log_perf_test
From:   Vipin Sharma <vipinsh@google.com>
To:     seanjc@google.com, pbonzini@redhat.com, dmatlack@google.com
Cc:     andrew.jones@linux.dev, wei.w.wang@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Sean Christopherson <seanjc@google.com>
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
2.38.1.273.g43a17bfeac-goog

