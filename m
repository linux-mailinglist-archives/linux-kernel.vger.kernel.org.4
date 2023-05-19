Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E113709FBF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 21:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjESTKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 15:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbjESTKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 15:10:22 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F18171B
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 12:09:49 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id a1e0cc1a2514c-783eef15004so1198934241.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 12:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1684523388; x=1687115388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t64UzVHVroabp76Xd4g1LLeTmZtqX+n8nvVYbfjxh90=;
        b=o7UU9iUhAbrwB44BtKTmc5RQ8dUPaFjHnnyhvbFZd+1u585u1S76A7OrnTd4nASMLC
         ZkUXlYY0ZOkyICYNTcwic2MeSK8V8ncKEVmdi5sB8vbXKubDEMtEYecQ/rgSsn59s9aX
         4//vGzJMsIiFGeko/yn1WZd6ewTT2Ke489JRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684523388; x=1687115388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t64UzVHVroabp76Xd4g1LLeTmZtqX+n8nvVYbfjxh90=;
        b=dEBcVAA0E4U1SpxVjea2KiWrD9cCxsqzUUT7PzjQmoG0vN2mEki+wHqlFnMUfqFyvS
         SbiufRweUZ0cJCoMw7AkCi+ptt/aIjtangPlibysYGxBa/z5uGzA8VPprPLm6tk9J4pc
         i6/WDHyshVnZ7hL/zh5dJXB13HONlC/XdT8q6sT+f3zDniav9ONjMkCDb3DpOVwHKkhy
         ztCcxBp5q94M6G2t4dZTad5YHqRuxoXf6lQ2sJCDKiY93HTRxSegAdnnGFsqTfR8mRQC
         /wzdjjwjU2e3Lk7Vym5rosKyutPe6pazYu+yt50JIYVPfH/pHVywLfxaWRMkzBuyRnBv
         3fKA==
X-Gm-Message-State: AC+VfDybHroqQNvz2bbfv1CvA4wNk0ntQ7Byb+N/LOd1PnaB5p/bevAX
        mZD+odNQQbOwb0T1vO8tJyWAKzA8WziMb8x0vDA=
X-Google-Smtp-Source: ACHHUZ4jFcbT1ve1tL/ufSb7el3GoyODcR910N727rMH2QSU4iGxgxnP0MXarC1z3MztdTo718x5vw==
X-Received: by 2002:a67:f050:0:b0:435:f378:8ee8 with SMTP id q16-20020a67f050000000b00435f3788ee8mr163030vsm.26.1684523388002;
        Fri, 19 May 2023 12:09:48 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id q20-20020ae9e414000000b0074e1ee30478sm1317611qkc.37.2023.05.19.12.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 12:09:47 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Kirill A Shutemov <kirill@shutemov.name>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH v2 2/4] selftests: mm: Fix failure case when new remap region was not found
Date:   Fri, 19 May 2023 19:09:32 +0000
Message-ID: <20230519190934.339332-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
In-Reply-To: <20230519190934.339332-1-joel@joelfernandes.org>
References: <20230519190934.339332-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a valid remap region could not be found, the source mapping is not
cleaned up. Fix the goto statement such that the clean up happens.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 tools/testing/selftests/mm/mremap_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/mremap_test.c b/tools/testing/selftests/mm/mremap_test.c
index 5c3773de9f0f..6822d657f589 100644
--- a/tools/testing/selftests/mm/mremap_test.c
+++ b/tools/testing/selftests/mm/mremap_test.c
@@ -316,7 +316,7 @@ static long long remap_region(struct config c, unsigned int threshold_mb,
 		if (addr + c.dest_alignment < addr) {
 			ksft_print_msg("Couldn't find a valid region to remap to\n");
 			ret = -1;
-			goto out;
+			goto clean_up_src;
 		}
 		addr += c.dest_alignment;
 	}
-- 
2.40.1.698.g37aff9b760-goog

