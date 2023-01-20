Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1885674CDC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjATFyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjATFy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:54:28 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26EA3EFE5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 21:54:02 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id q9so3340462pgq.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 21:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XEgtvFA6+F4WM7Ve7jmcRA5AwRyqqoMyKb2aacevr/Q=;
        b=OMjxPMKINUxW1Zg9mQBY4bvTzNh1wOoeBHuNYGsTKgEN6tB0vvgS8gn0xqszFHLlAA
         U4WlCdHJ2CYYKuUTCjMZ6QnWgYiAnbiCp/GdNp+G0TqKtPFAzvmp0N1maRPYqPsXMiPt
         Px3WtrA5IGh7cYplyFjms0QpExFQOeKMVYuWr48xBjt9acK7FxbYiAACP6W4Fpj+PDhE
         6CrTdjTwGqzCnSxUt61s3RKyigoW14B5aYd/z/wmIlkppViTv+yv7uHcMA8I9q1iisLU
         h/R9lLjjvW2CpUMgQ3+QIBuSIhmFF73YN+b71jyuDnqo9woHBVD2udEkDRxNqpIiI4cD
         oHbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XEgtvFA6+F4WM7Ve7jmcRA5AwRyqqoMyKb2aacevr/Q=;
        b=Md4T11HGlxrBpGvsCugqlTQa2zXx/gffnKq7Sk6mfi8hKrRX9XQQH2E4MXNFm2uRwN
         CmJ2wb5/hY9014O/4VZ5KpFB8YuGdfxyo/I+FWJsBq/4SWjvE8uWbdev7Ox+AYEmHT7J
         DZ+3gqoJDCMjfTRz/r4FnqakL7iI1yE+vhoCPY0x5WBuJY+wyEpjAd7+eXGe8zucsqLO
         MaG2lLJH/SXVDW/LrsaUd1j+OSJ1VRgLSGvgFAJM74Vc25tE7q/O7oYHE6cwvky418D3
         DIzkuvxuBsQxwQri1WN31RlvPClspgN7Dtg2UkVB5M1Jxf37S4vSrO5hIiw+vHz4XsvE
         vLAw==
X-Gm-Message-State: AFqh2krqShbUdBvznThrUapssIb/RNiM187OKfmfSQRi4XIweTW5kgmI
        eNOsForJz/Osq0bXWy5ZP0L2vA==
X-Google-Smtp-Source: AMrXdXs4GqqCkoE/QMECL9AAEXgrwRRlGh/r737QhOGSVyu48+Bf9A/8rRzVmtqj4amISSUpw8zWTg==
X-Received: by 2002:a05:6a00:1da0:b0:58d:f607:52f7 with SMTP id z32-20020a056a001da000b0058df60752f7mr6588138pfw.12.1674194042105;
        Thu, 19 Jan 2023 21:54:02 -0800 (PST)
Received: from DougS18 (s173-180-45-4.bc.hsia.telus.net. [173.180.45.4])
        by smtp.gmail.com with ESMTPSA id c28-20020a056a00009c00b0058d9428e482sm9736758pfj.85.2023.01.19.21.54.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jan 2023 21:54:01 -0800 (PST)
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rafael@kernel.org>,
        "'Huang Rui'" <ray.huang@amd.com>, <sedat.dilek@gmail.com>,
        <li.meng@amd.com>
Cc:     "Doug Smythies" <dsmythies@telus.net>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH] selftests: amd-pstate: Don't delete source files via Makefile
Date:   Thu, 19 Jan 2023 21:54:01 -0800
Message-ID: <001201d92c93$98c8a040$ca59e0c0$@telus.net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: Adksk2/bdcN3GcROR06Ww6PAk04iSg==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Revert the portion of a recent Makefile change that incorrectly
deletes source files when doing "make clean".

Fixes: ba2d788aa873 ("selftests: amd-pstate: Trigger tbench benchmark and test cpus")
Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Signed-off-by: Doug Smythies <dsmythies@telus.net>
---
 tools/testing/selftests/amd-pstate/Makefile | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/testing/selftests/amd-pstate/Makefile b/tools/testing/selftests/amd-pstate/Makefile
index 5f195ee756d6..5fd1424db37d 100644
--- a/tools/testing/selftests/amd-pstate/Makefile
+++ b/tools/testing/selftests/amd-pstate/Makefile
@@ -7,11 +7,6 @@ all:
 uname_M := $(shell uname -m 2>/dev/null || echo not)
 ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)

-ifeq (x86,$(ARCH))
-TEST_GEN_FILES += ../../../power/x86/amd_pstate_tracer/amd_pstate_trace.py
-TEST_GEN_FILES += ../../../power/x86/intel_pstate_tracer/intel_pstate_tracer.py
-endif
-
 TEST_PROGS := run.sh
 TEST_FILES := basic.sh tbench.sh gitsource.sh

--
2.25.1


