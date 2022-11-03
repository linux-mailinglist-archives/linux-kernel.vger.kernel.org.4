Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8E4618692
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 18:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbiKCRsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 13:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbiKCRsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 13:48:20 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F0A1C13C
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 10:47:51 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id cw4-20020a056a00450400b00561ec04e77aso1059765pfb.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 10:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8f8dJb7CmxUii0k7ReZbO/xecf8YvrxT0ueHHyma1BU=;
        b=D28rs6T8OGKqTwv+0w2tiy+Wo2uFgszomXWqOdz4bK8oHd/bxnx+ygDF11Merktoeh
         W0x/tTWAy+1K4R3PBvAmW6StBWEh4cu44wlQ5LyUHpThEqN8JyKhrY2ReJcTBvWxXctN
         c7p7B7aknkrGsUM+sQ8VoC51Ja99SE9d0zKTb0LZRMMyqsZV+Hcc3tWGzdC8Cx4BaYXj
         Q9CwKe+1CpuIX73dKrvuIkNUu0j8EPQ5Pg5VIsESR4Ixa3K6vFdcHCYbaKvgxXFV59jb
         j2jy2YJh6CyY4ElDHkYBrbjJLVuqzKlskpFuivE9C34VpXsmDwdCPXTY88fXmz/gLC1t
         qn0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8f8dJb7CmxUii0k7ReZbO/xecf8YvrxT0ueHHyma1BU=;
        b=kN7ojaO2P9aOiDsaJUU8rY0vAmrlWchd3/l5/MujteGT3y90MuMR61m+Rj5W6EOrTH
         m3zKZOLy7YZpZp3dbRyYHvmvn5oeqZbxkipiV4bODLgD9UOcCJRCB5KQGvGa652X/dNK
         /Z14/YVoR0rr1cXhwxRfu3ZOkAdXkZYKR2j4XBS0SIxa5bioUS9KOLfQhmaYrm+VU+eG
         5DajP7SBMHwe+AqTYDbyCCWWaqJP2qbghu/+gmv94wnNDcATkjYh0V8g7pnNcWK+Mrwv
         0KEMMW5U9G1fh6oBPzpLO0ZLb69ABA1FVmkyZNjFjZNVFTN3/qtWS4XVYM3mo+cBhB5L
         tjvw==
X-Gm-Message-State: ACrzQf01m6fXaWKZo8XGVMpZupnmVqCeNpsIHMTS3tmXdGR2mJu5r2pQ
        lkFBcYRAuqu39kWv3JnACpmz8J+yS8S3jg==
X-Google-Smtp-Source: AMsMyM4Ls8UcrKSslT8x5WlYpTRZIayBCz8AJvQ97WsPxMXWt4gyd0VthhQSDtdpv7NGJeGnmrzlzFFtJYNjTA==
X-Received: from dlatypov-spec.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3f35])
 (user=dlatypov job=sendgmr) by 2002:a17:90b:4c8a:b0:214:2ed8:6501 with SMTP
 id my10-20020a17090b4c8a00b002142ed86501mr9877245pjb.70.1667497671335; Thu,
 03 Nov 2022 10:47:51 -0700 (PDT)
Date:   Thu,  3 Nov 2022 10:47:40 -0700
In-Reply-To: <20221103174740.3492603-1-dlatypov@google.com>
Mime-Version: 1.0
References: <20221103174740.3492603-1-dlatypov@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221103174740.3492603-3-dlatypov@google.com>
Subject: [PATCH v2 3/3] kunit: tool: remove redundant file.close() call in
 unit test
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     rmoar@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, Daniel Latypov <dlatypov@google.com>
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

We're using a `with` block above, so the file object is already closed.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: David Gow <davidgow@google.com>
---
v1 -> v2: just rebased onto linux-kselftest/kunit
---
 tools/testing/kunit/kunit_tool_test.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 5e3429a1202b..90c65b072be9 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -242,8 +242,6 @@ class KUnitParserTest(unittest.TestCase):
 		self.assertEqual(
 			"example",
 			result.subtests[1].name)
-		file.close()
-
 
 	def test_ignores_prefix_printk_time(self):
 		prefix_log = test_data_path('test_config_printk_time.log')
-- 
2.38.1.431.g37b22c650d-goog

