Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6725EE478
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 20:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233707AbiI1SlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 14:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbiI1Sky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 14:40:54 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF9872B42
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 11:40:53 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-35076702654so127688977b3.17
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 11:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=3935bCieyFmPbWCFJjhpDhrqHj3m5qA7eEIiW2Mb31M=;
        b=YqI1WESsX1JN1SX3EDdN3t0+z5lQnLgO9roDEXa88xtna+McONc24ekfKMWcVHWJ5k
         8Y3BBVp6ZbMUC36mkMgaACQm8lPSjK3jEBA5eV+NVzee9UrbJYCZLEW7gEyLiMhq+KKD
         k+OU2BaH5ZeeLJITqT2dD5Wv5mv+bMGOuRAoDMdTbV8pghU+FM8NRdRbnkp3WLs5sYKp
         Ap+lhwb0ObAUkLzOP3wjhV0hUSSNaU8ft7dQrcxSlvMfC64iyuBsYOafnO6xyjZ+YK/y
         iKEzhpb5PWnlchhpVYALvW4zSxN4DpUTWFhMXg3In4DaE3tBOcC9926kfa/krO/KW+bh
         mn/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=3935bCieyFmPbWCFJjhpDhrqHj3m5qA7eEIiW2Mb31M=;
        b=O/M8n+K4fmJd74998RvPO3rb4ABpOGX00ixn59a6hofVG6XdZjRRPrqaS9OdwvavWw
         B7Fb71kmGqFOLfE8n9Tl4DKbEZ3yyP8M0aETZXSmltIZbKk5dDdlJafSFgMbzJuh8FhQ
         llxuyCYOTcmDTrCwZp5NxxqRzXINBNii48JfHhUc0znqk8+2L83A8v8Ryvj3dgwgPWXZ
         DA4fGlMczWiANhW8BD4MMpd9gpNeb8kPefZzp+uJxQofOFGUpouEiXLBGucca0/pTxJF
         GMk5IxyS6nnTE8WpSQyb+/LPCE398/c2EM4Wm8duxmJWAOJFpoG6fbqsimcoDZnv6R52
         6XBQ==
X-Gm-Message-State: ACrzQf3tLmC4x8KZzggtweK1cZ3QSWYOn8wJ6O5yyU24XedU6aPZm71g
        s6PSf7d61e03sQLIjysqQdYSlQ2IDjGAEs9IZkm1VGVn1QE7fFPMYb6QUpCZ8ATYzx9HhitW8yx
        xgpnX29mdDbFKbMDLt3SI0mldj8tSFrVUcbo2qg1kuvYfJ9GQO/aN1X4I/WM7j2RMGVxtAOUq
X-Google-Smtp-Source: AMsMyM7POtnRycLOa3IZT0STyJLWiXB6VPZUHzYSrRTMaAKl4fQWbR8UYSEFE36mfrgoFLvnsnoHAhekLHl3
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2d4:203:d508:baac:7b11:f912])
 (user=eranian job=sendgmr) by 2002:a0d:f201:0:b0:335:4933:6683 with SMTP id
 b1-20020a0df201000000b0033549336683mr30829921ywf.23.1664390452599; Wed, 28
 Sep 2022 11:40:52 -0700 (PDT)
Date:   Wed, 28 Sep 2022 11:40:42 -0700
In-Reply-To: <20220928184043.408364-1-eranian@google.com>
Message-Id: <20220928184043.408364-2-eranian@google.com>
Mime-Version: 1.0
References: <20220928184043.408364-1-eranian@google.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Subject: [PATCH 1/2] perf/x86/utils: fix uninitialized var in get_branch_type()
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, sandipan.das@amd.com, ananth.narayan@amd.com,
        ravi.bangoria@amd.com
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

offset is passed as a pointer and on certain call path is not set by the
function. If the caller does not re-initialize offset between calls, value
could be inherited between calls. Prevent this by initializing offset on each
call.
This impacts the code in amd_pmu_lbr_filter() which does
   for(i=0; ...) {
       ret = get_branch_type_fused(..., &offset);
       if (offset)
          lbr_entries[i].from += offset;
   }

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 arch/x86/events/utils.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/events/utils.c b/arch/x86/events/utils.c
index 5f5617afde79..76b1f8bb0fd5 100644
--- a/arch/x86/events/utils.c
+++ b/arch/x86/events/utils.c
@@ -94,6 +94,10 @@ static int get_branch_type(unsigned long from, unsigned long to, int abort,
 	u8 buf[MAX_INSN_SIZE];
 	int is64 = 0;
 
+	/* make sure we initialize offset */
+	if (offset)
+		*offset = 0;
+
 	to_plm = kernel_ip(to) ? X86_BR_KERNEL : X86_BR_USER;
 	from_plm = kernel_ip(from) ? X86_BR_KERNEL : X86_BR_USER;
 
-- 
2.37.3.998.g577e59143f-goog

