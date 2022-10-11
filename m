Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3E65FBB10
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 21:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiJKTG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 15:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiJKTGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 15:06:12 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC9B175B6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 12:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1665515168; x=1697051168;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=ILP6lC9qOdbFL3ALxKp8xEJRrZpkoLP2MTnKGw5NKRM=;
  b=Zci6mc5XvCwaS3ETvZGJbDpurlytsgOlxG9h00gbuZGPYKE11fAg5fQn
   0HEPypUDbXpwpZ1uVYNismW79f47Rg70FBbMpdKgvC1Ml4cg2I2LNoaiJ
   Whpf9WRg+nAVy/rs3fF63pvvvpe5A2Ast08FunDxWqZeNc7iqCHKeuPpU
   8=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 11 Oct 2022 12:06:07 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 12:06:07 -0700
Received: from hu-gurus-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 11 Oct 2022 12:06:06 -0700
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
To:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
CC:     Elliot Berman <quic_eberman@quicinc.com>,
        John Moon <quic_johmoo@quicinc.com>, <llvm@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>
Subject: [PATCH 1/1] scripts/clang-tools: Convert clang-tidy args to list
Date:   Tue, 11 Oct 2022 12:06:00 -0700
Message-ID: <a10e25f13205cb96e1ad63f1b1371a76f37af549.1665515051.git.quic_gurus@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert list of clang-tidy arguments to a list for ease of adding to
them and extending them as required.

Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
---
 scripts/clang-tools/run-clang-tools.py | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/scripts/clang-tools/run-clang-tools.py b/scripts/clang-tools/run-clang-tools.py
index bb78c9b..56f2ec8 100755
--- a/scripts/clang-tools/run-clang-tools.py
+++ b/scripts/clang-tools/run-clang-tools.py
@@ -45,13 +45,14 @@ def init(l, a):
 
 def run_analysis(entry):
     # Disable all checks, then re-enable the ones we want
-    checks = "-checks=-*,"
+    checks = []
+    checks.append("-checks=-*")
     if args.type == "clang-tidy":
-        checks += "linuxkernel-*"
+        checks.append("linuxkernel-*")
     else:
-        checks += "clang-analyzer-*"
-        checks += ",-clang-analyzer-security.insecureAPI.DeprecatedOrUnsafeBufferHandling"
-    p = subprocess.run(["clang-tidy", "-p", args.path, checks, entry["file"]],
+        checks.append("clang-analyzer-*")
+        checks.append("-clang-analyzer-security.insecureAPI.DeprecatedOrUnsafeBufferHandling")
+    p = subprocess.run(["clang-tidy", "-p", args.path, ",".join(checks), entry["file"]],
                        stdout=subprocess.PIPE,
                        stderr=subprocess.STDOUT,
                        cwd=entry["directory"])
-- 
2.7.4

