Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6BA5B6A6B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 11:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbiIMJMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 05:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbiIMJMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 05:12:37 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BF55A800
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 02:12:36 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id q62-20020a17090a17c400b00202a3497516so8387119pja.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 02:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=RludiuXI04g98bb6hCOo/Y+uQHagYxl6mhzM1wptlJE=;
        b=ZziSErcgXFTobtgN4y5qbgv8tURNEb5sxc0isyqeQJfLoU0RVzXarfIlNoeDn5ElEx
         l8gU5Xg2lvH0gIdizMMxc0mXyNlZJnn92OaJNh6aJdoe8Qf+EtKJz1nFD+Kdy96RVfSl
         EtJBEV9RCQrEydMLHeBhCUKUVSvkGeGfWU1cQXw0ghtjLKRiuxq00frbiw6pAKvomMBT
         FDg/8PJotaxvkLOYrix15q3LSA9jyJN/Ot++L4/Tx8+9GhOqtlTM/3myg+YkyOZ7+OTp
         6kZwlU3F5WjuWtZYCvGk3HfP8dOw2inqKcgsVGJqnd5GoDycJbIzD8ZhsTH0mfqxULTC
         2//Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=RludiuXI04g98bb6hCOo/Y+uQHagYxl6mhzM1wptlJE=;
        b=3ed6c0W4nuxPQRaidEc67ruao7g9sy8Kh0inePl6VKyVooeNSanDORNv4q2lkutJ94
         j5ns9sJFHJXIxkbn9lvoTrnIwY49fKqO4MOcm7rzrbSJuvdZZe8ensJqvZK0zRm4aV18
         WY7TnxFh9YE/wejHZpxvvjyPze0hgDxedq+QHsn7h8jsb5QECKxbGDGzIx1w5yhnQtPN
         jnweNX+nqinK0/LlUg88/Mcpw8pWKfVv4e1Gixr7dKJfXRDu+lkdqoLUiUqt8ZyRXSyK
         iLeW4fh7CiF0uIt+fsK8/Tiv8SmzKE1CYgCj8r3yn/kOHgMNhbEVKFOy2wXsJ0fYG0xg
         iTsg==
X-Gm-Message-State: ACgBeo3IzVpNky5VWlsQSSBCNwGje1JeV6c1HR1UYKWWxuR9VAsra+Bk
        FWneSwfJeX4uxH1MvxbHmw==
X-Google-Smtp-Source: AA6agR5fkOMWeikIf2G4s+cnzgehLhSEMVAMumnMknm+iaDNywQoKQy3BUN6M0oQGYLVlkC5XlHvHg==
X-Received: by 2002:a17:903:22c9:b0:178:18a1:d170 with SMTP id y9-20020a17090322c900b0017818a1d170mr17125135plg.2.1663060355904;
        Tue, 13 Sep 2022 02:12:35 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.3])
        by smtp.gmail.com with ESMTPSA id h10-20020a170902680a00b0015e8d4eb1d5sm7804661plk.31.2022.09.13.02.12.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Sep 2022 02:12:35 -0700 (PDT)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     sj@kernel.org, akpm@linux-foundation.org
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH 4/4] mm/damon/vaddr: indicate the target is invalid when 'nr_regions' is zero
Date:   Tue, 13 Sep 2022 17:11:27 +0800
Message-Id: <1663060287-30201-5-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1663060287-30201-1-git-send-email-kaixuxia@tencent.com>
References: <1663060287-30201-1-git-send-email-kaixuxia@tencent.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kaixu Xia <kaixuxia@tencent.com>

When 'init()' and 'update()' DAMON operations failed and the number
of the damon_target regions is zero, the kdamond would do nothing
to this monitoring target in this case. It makes no sense to run
kdamond when all of monitoring targets have no regions. So add the
judgement in 'target_valid()' operation to indicate the target is
invalid when 'nr_regions' is zero.

Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 mm/damon/vaddr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 39ea48d9cc15..65ff98d49ec0 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -598,6 +598,9 @@ static bool damon_va_target_valid(void *target)
 	struct damon_target *t = target;
 	struct task_struct *task;
 
+	if (!damon_nr_regions(t))
+		return false;
+
 	task = damon_get_task_struct(t);
 	if (task) {
 		put_task_struct(task);
-- 
2.27.0

