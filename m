Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEA45BFB0C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbiIUJcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbiIUJcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:32:50 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFED91D1F;
        Wed, 21 Sep 2022 02:32:50 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id b21so5050403plz.7;
        Wed, 21 Sep 2022 02:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=+sgmI5x+CbCdgE3PXJ6rABHNxrOJeMweJ1rcU9zLz6o=;
        b=mYKUQyuuAlMqt+lS/hi8cSV2h50HiYO2FWlexj6curd4Z2wdd3hn4M6C8vYMusjc7r
         dN/GbBGp0p7tm88mZAMmHP2FA7+9Dtr6Yl+7pINvK8TPvAhoBaTFq0aQIIPHUrcEb9Rn
         JdmROGO4BMIUbqcecUEFszauQ5XevA2SSSDljpl5WP2mzV8YQKFipS0SVub/5nBS6XcP
         P88MrLZ3rJyhJdZyi9afXBiZEIvpUyUNJpAPvNsfAdgVfeVfeOP7bVMHPEcmVTgJ9EWF
         /lRYzXjshrRJn6gqnSrGFl8qY+UHnBA3Ut3oErc/iKW5zhe1k7ZD8rbVtAUcXky6JRhS
         3Cxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=+sgmI5x+CbCdgE3PXJ6rABHNxrOJeMweJ1rcU9zLz6o=;
        b=nCGK4lFWR2fanBxDc+wH0IF/y99ZyJ7yqSmoP3LFBbpB3RUpZmSqIAWJFAx4NDl002
         qPIv0orthwAx7BUL2pE6gKXC3lt9cKKfkcv+cFXJdwxAm2OxC8IGvBbkUvP/xzTEqNr1
         VZNlW5zhvRbGeM1HSZVBvGCrTN2QKuCZr5jxNnRFWUJixEaN5Uz4PLi1rRnsjz1WaJOT
         ZQ/3RQ8y65NStbmZ3HaDkXAysZF/lrI2PIZGq57T7F7LMh24EiDWcDoIwjFAxA0BtZaf
         kDTOUvdgyEZBWn2N/w0Z96Ov6eVxjqoNUc7WLSQu74pmEMc+VrSCCsiKuDVrtsYEws9O
         U7yA==
X-Gm-Message-State: ACrzQf0ClxaKJLpGv+DDed3CRGF33DpRsAZcx7yEoCaGYoVdnG2d/Y+I
        BAhMYirmU5W1mrCpE7u4Brc=
X-Google-Smtp-Source: AMsMyM7oWxNH1U3tW/8H/pC9d1GEppLvB1UAOMvQF0AO2jVR8v8TEng4L9pXIf75vQvE5ltWSl1cFg==
X-Received: by 2002:a17:90b:4b51:b0:202:aa27:ceb4 with SMTP id mi17-20020a17090b4b5100b00202aa27ceb4mr8709275pjb.131.1663752769672;
        Wed, 21 Sep 2022 02:32:49 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id a67-20020a624d46000000b005465ffaa89dsm1601221pfb.184.2022.09.21.02.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 02:32:49 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     acme@kernel.org
Cc:     mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        james.clark@arm.com, ye.xingchen@zte.com.cn, shaolexi@huawei.com,
        mpetlan@redhat.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] perf symbol: use strscpy() is more robust and safer
Date:   Wed, 21 Sep 2022 09:32:44 +0000
Message-Id: <20220921093244.230579-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

The implementation of strscpy() is more robust and safer.

That's now the recommended way to copy NUL terminated strings.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 tools/perf/util/symbol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index a3a165ae933a..689007a23335 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1886,7 +1886,7 @@ int dso__load(struct dso *dso, struct map *map)
 							      name);
 			if (new_name) {
 				is_reg = is_regular_file(new_name);
-				strlcpy(name, new_name, PATH_MAX);
+				strscpy(name, new_name, PATH_MAX);
 				free(new_name);
 			}
 		}
@@ -2138,7 +2138,7 @@ static int find_matching_kcore(struct map *map, char *dir, size_t dir_sz)
 		scnprintf(kallsyms_filename, sizeof(kallsyms_filename),
 			  "%s/%s/kallsyms", dir, nd->s);
 		if (!validate_kcore_addresses(kallsyms_filename, map)) {
-			strlcpy(dir, kallsyms_filename, dir_sz);
+			strscpy(dir, kallsyms_filename, dir_sz);
 			ret = 0;
 			break;
 		}
-- 
2.25.1
