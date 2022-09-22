Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E155A5E581B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 03:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbiIVBgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 21:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIVBgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 21:36:16 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812F498C8B;
        Wed, 21 Sep 2022 18:36:15 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id w13so7399308plp.1;
        Wed, 21 Sep 2022 18:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=7O4m8cnVq8WWnJoS2DEBavHRbdH+17ihkVjS04pYNls=;
        b=hYPe/lXlNw3QzwSqwWf8lKjQciQa2qM5TlM7jMgOOMbplAj3inE7bUmP+NpedAtrQg
         SCE2jnRp/SqYXc6moWnu3KwD1m1s0WjgHcWpYiY6ylNvxeNkxEXR8rCYMVDSl88nUYVK
         cd++XxqryKoBN6+XCnCxP0aJIOQpOKxFL0siJML1oGRledhBfb+nZGWN04lUAZ3eaiw3
         cfBtHEoJT8RoJaL8+T6jBxppP+vYeAyHdldgYvbkTZ1X6A9wnLzsHAfMDR7XsabpoMmS
         tN50iJNloInnYXsPFR9od5KnMmNq514ea6HRI4IyeOoKHIvu24GADoUnBH9dX2xxDVUx
         I5DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=7O4m8cnVq8WWnJoS2DEBavHRbdH+17ihkVjS04pYNls=;
        b=Gd8f3ML1BtjL5IxSBuSVdsTxLz5Juy7SmYNJJzVmREZf5SCbzVlYin+XcSQ9iRviVB
         FijOO+nqkNj8kBJrLFQVDqRrnQmhn796if2VuGmfBVRffvjInjg8TaHjNLmENbsHIpw7
         B2BgMzQZrfZ5M+CSo6OOuVSCVeShIe/bIN02As/jSrp0BRvLSkMtXOJEQEE7GVRd3m1k
         PuxZMWZTMkwIH2G61MDs1ReDONUuv5HSQ8ELpSOpD42XcaxTO/gYU7A/+nHitUojapYu
         6rYNueKbzj0PGkz0b2QT30SMYjVud9Ox8AOl10uywYa7noH4bOJ9Foma4xTFAiA5ecrN
         bU3g==
X-Gm-Message-State: ACrzQf3BnKvhskm5Q1DcRiMzq17/oPIMK9HlEu6c+McyKVmnauBEBi9A
        IH45M5znIzD7YDND6E0PJfQ=
X-Google-Smtp-Source: AMsMyM732w0THghPR3BV0YGsjE9w2A16g73sTkNY4o1Rz/5bBCcLGFPDIbQK6qPtq7pvvSbPRvTQbQ==
X-Received: by 2002:a17:90b:38ca:b0:203:64d2:dac5 with SMTP id nn10-20020a17090b38ca00b0020364d2dac5mr1041433pjb.209.1663810574984;
        Wed, 21 Sep 2022 18:36:14 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id u10-20020a170903124a00b001782a0d3eeasm2670964plh.115.2022.09.21.18.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 18:36:14 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     acme@kernel.org
Cc:     mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] perf test: use strscpy() is more robust and safer
Date:   Thu, 22 Sep 2022 01:35:56 +0000
Message-Id: <20220922013556.233163-1-ye.xingchen@zte.com.cn>
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
 tools/perf/tests/dlfilter-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/dlfilter-test.c b/tools/perf/tests/dlfilter-test.c
index 84352d55347d..bbb79e98294c 100644
--- a/tools/perf/tests/dlfilter-test.c
+++ b/tools/perf/tests/dlfilter-test.c
@@ -233,7 +233,7 @@ static int get_dlfilters_path(char *buf, size_t sz)
 		if (access(path, R_OK))
 			return -1;
 	}
-	strlcpy(buf, dirname(path), sz);
+	strscpy(buf, dirname(path), sz);
 	return 0;
 }
 
-- 
2.25.1
