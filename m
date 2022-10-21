Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5644A6080A7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 23:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiJUVSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 17:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiJUVS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 17:18:27 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48982A4E11
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 14:18:26 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id c10-20020a170902d48a00b001825736b382so2320763plg.15
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 14:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2nZIMOkxkPqMdJjizNd12NlButg+wAhOHsOCFogicCg=;
        b=WcPSPUKF7ggBl0Y2IXHy1DMp3RWNL9m8VHXZLCw+DdLzcdtF1JNMgKQ4+7na6BJAIO
         AW0w9JlOFe31ljI0u5nBDWCR37+o2mlUwocMEAqlXjxOFu3JOXkgDD+L7q3ytVQ0j/d0
         UP6haL7G1S52AUDMJEYSVcTRzCj5FokhTEhpN4n5Munvo7sDoC1885BRAhDqnqDwLtC9
         dof/6ipmS0UF3J3LivuOP9ww1qTXAHQ0nYkCdlgv5JnnQNjCbZpfv2DMclRVGtRirlmi
         d3k13p9vzhP6XRidDpiN63cvd8szHaO9Ra9A2xCCBM+I8GXMEtMCp5Kc00ArOhXzxz0l
         cEoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2nZIMOkxkPqMdJjizNd12NlButg+wAhOHsOCFogicCg=;
        b=YCyqlXBjjADU5jTaANl9Sp0EHgRaTSBg7w/0am5FRjtENUcTgNAWInXNuOOQ8FJye/
         ZZ7CGomzeB6MSDeILQH0oS88Fv//8gO7HMyW0Ja1+Rdjg4qkL2hb+uuUeaZxkSwWH940
         Bpck29o+jJ3mSREcd/ZRxmnu96APIzFklIqvP+pHR2cKgEJbe5001AZyXRJ0FOM16MTj
         HiaxOE83+dS6YiL+ykNfnzsQROluLhbZksP0sonbcl4hQj7L2FP090IG5MfHHbb2fHFj
         VrK5jt9lH2sP6lVOEr8aDjgx5ou1ZsXqwwnBo/LyRnIXKw5xsuEqRPU+5OggHGcfqlum
         mXjw==
X-Gm-Message-State: ACrzQf1xcvQ4rkTHUzMa59IpW1r6wt00RIeSyaHhV4LXbgJvX8FVC8HN
        fww3rOsnd/ANoNkHTH8ephv5AbT5jLjp
X-Google-Smtp-Source: AMsMyM4OXiD+7ajtPxOEHRiPXDK+Af2oMl5k7lHB7wGjmfZQr6qEo6HimWCgs7KwZeOsUn41bSVTpJY776yt
X-Received: from vipin.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:479f])
 (user=vipinsh job=sendgmr) by 2002:a63:91c7:0:b0:460:156c:ded7 with SMTP id
 l190-20020a6391c7000000b00460156cded7mr17952216pge.298.1666387106255; Fri, 21
 Oct 2022 14:18:26 -0700 (PDT)
Date:   Fri, 21 Oct 2022 14:18:12 -0700
In-Reply-To: <20221021211816.1525201-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20221021211816.1525201-1-vipinsh@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221021211816.1525201-2-vipinsh@google.com>
Subject: [PATCH v6 1/5] KVM: selftests: Add missing break between -e and -g
 option in dirty_log_perf_test
From:   Vipin Sharma <vipinsh@google.com>
To:     seanjc@google.com, pbonzini@redhat.com, dmatlack@google.com
Cc:     andrew.jones@linux.dev, wei.w.wang@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vipin Sharma <vipinsh@google.com>
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
2.38.0.135.g90850a2211-goog

