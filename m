Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDE46F68AD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 11:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjEDJvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 05:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjEDJvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 05:51:18 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E7CCD;
        Thu,  4 May 2023 02:51:17 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-517bdc9e81dso96203a12.1;
        Thu, 04 May 2023 02:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683193877; x=1685785877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7CKov2TobfwCTjaWyM91275MatNo9xTyTP5cQswtwXI=;
        b=fO1zG520RUJK2HUth/fLCrNJ8frC3lqpjN8VMyLgi2hyw2HCzoX+BhHzc6GsKAHF4b
         4llZI4Y76rVMZjAzMBh7YQuiO0Hw8zl/64CyKqj6uueL+Bxs7o1I7PYrd961Napbo0G2
         F/aqx3CoHEdyu8Y9OSq8pniKcMPl0hMr374Ox3itlV9x5OjDPVnmIWJyIQ58hbXGJFHp
         rocT0Ffac99QEgO7LOS1R6faAmeNFrJYUxXKGx8Y3yIklAoCaJqLXF9O2HFald2rxN3l
         UK1HeRROOzASXc0kwhVwQomAnZhejjciH9duH+hgw95NUiOjGPOCwqk6ONPnL0G9FnE0
         Ao9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683193877; x=1685785877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7CKov2TobfwCTjaWyM91275MatNo9xTyTP5cQswtwXI=;
        b=aIaYrEfUbn2rR4K4DxhGAhOcf5EUdbcYmZ4jrXVRGi2BfBvHzsc8cO7Jz+5wr6Sx0t
         APKu0+xnAeiXYEkDpeexJ5/ARRH0Vp5Ywde9aNKoUp9ZptHaljgQaZM5HVGDvllxzVFl
         TlCHmA4A91gCbDgOAOkY+qTPvBL6aa52URLpAu7lEw7jeNeQK7p3O7GkIDiwPhl4T538
         AeAKWgKUrCUgmwuN6uL23LXsH1GQ68/1QHCkehmUQicfFLFEeSWpthXARL1Ur3bBciUO
         9auogBPr/z2Sd3/wQqVPyh7RhXqvuwj0dPmKpV4+0+usTpv3xAFnlraYxOauQ1B9grCn
         J+Rw==
X-Gm-Message-State: AC+VfDy24JwmEIzow8wbf0B7KR6iCjWReyIaZXvYBYv1zdITzyTrlViE
        V6y0cE5lnvx1wUfki0Ty6Dw=
X-Google-Smtp-Source: ACHHUZ63PWM4FtDd5mPwoZUgHolHaDA4Ua7GcELEIewVvQ5ajd4RAGGqGGO1vzL7Jdb2flL/6HNOjg==
X-Received: by 2002:a17:902:e751:b0:1a9:6183:f965 with SMTP id p17-20020a170902e75100b001a96183f965mr4003552plf.60.1683193877062;
        Thu, 04 May 2023 02:51:17 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.8])
        by smtp.gmail.com with ESMTPSA id bf9-20020a170902b90900b001a245b49731sm23092963plb.128.2023.05.04.02.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 02:51:16 -0700 (PDT)
From:   Quanfa Fu <quanfafu@gmail.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Quanfa Fu <quanfafu@gmail.com>
Subject: [PATCH] perf: Remove the redundant assignment operation
Date:   Thu,  4 May 2023 17:50:56 +0800
Message-Id: <20230504095056.3677889-1-quanfafu@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit bd2756811766 ("perf: Rewrite core context handling"), the variable
err will be assigned a value before use, so no need to assign it to -EINVAL
here.

Signed-off-by: Quanfa Fu <quanfafu@gmail.com>
---
 kernel/events/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 68baa8194d9f..c57b7aebf3ee 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4752,7 +4752,6 @@ find_get_context(struct task_struct *task, struct perf_event *event)
 		return ctx;
 	}
 
-	err = -EINVAL;
 retry:
 	ctx = perf_lock_task_context(task, &flags);
 	if (ctx) {
-- 
2.31.1

