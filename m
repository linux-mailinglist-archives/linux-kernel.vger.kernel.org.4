Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950B3654187
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 14:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235335AbiLVNLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 08:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiLVNLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 08:11:51 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F582A244
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 05:11:46 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 79so1281273pgf.11
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 05:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osomprivacy-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HTxpr8OTwVUnA5lBZp48nUe1O/FN08Y+aL/21Eg+0wA=;
        b=5pE7tne5EbpVKBuoJr0pNjXIJdqktJ3ZlIRzEsBUYP6syqfPNlObycFCIO5CZVqDrS
         M5yggRA97DjM5G3Q8asIm+nD7yUZDMGIsowYY/egYWc9oRz8rF/gybIP7O6ohfWajc8Y
         298wLIJFfRF27PHKWXusEqLDVdjKk8LInUxUZacPx7ulKsYJpYHTqwuH17DU/fedfUR4
         ru+4xncU25baZuGpDaFniK8nWeMTEyUQru2lNjittvKmdGe4svcqqaORnNCRDsOZwNjQ
         /XLkv1br2NmKURxwe/ea/RIIvyn8do9WjGm7GLhuYabeZsV+rk+WR8HMDQE5xiJFfhat
         ysLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HTxpr8OTwVUnA5lBZp48nUe1O/FN08Y+aL/21Eg+0wA=;
        b=yk36YfQ0nrVSV2Evu1nbVxJEsIa+1Rc0N4thuiZDHzYVfHJd4OoBOmdO/lI6Z0ICN5
         +U1Ua8oGsCsyJot9gCyzNu156/aYOGO/3C80qSuUwUcGSraUTBbCwFgRUqyNS1VYg1cz
         2Qn15u7iKQxP1KO7iRgoTaTxTsiqsplr6y6eveG8bUYmhAGHz5An6vek5FgjajmHX28S
         5Y2uv7dHeNLERWXzsTqz7I96Q2m0usSrqy2AjfIBcwMAeyozAvMI7HN0m9yREmYy0tRQ
         VWiSmAdUZLPLBSpK50/OWDfV7EhjLlpZAIZimqTY+3twRe6wEACLxpIla6mj91ceEge3
         y5mA==
X-Gm-Message-State: AFqh2ko4mRr+kT8FJZerYd+zl4khDjsg3WpKAbUUuOpE39TwLKF8jixp
        ThHgJ+NJRd0VotheALVAuhx/9g==
X-Google-Smtp-Source: AMrXdXtk7Pe/e91MbO6+vfqZGhYXq65DEHn4r8XaBm21ZJLpTAoIfkM5Fq4ICyt0t7KGQmxuLuacQQ==
X-Received: by 2002:aa7:8e89:0:b0:576:6320:3a1a with SMTP id a9-20020aa78e89000000b0057663203a1amr6372622pfr.7.1671714705845;
        Thu, 22 Dec 2022 05:11:45 -0800 (PST)
Received: from luca020400-fedora.lan (net-31-156-139-99.cust.vodafonedsl.it. [31.156.139.99])
        by smtp.googlemail.com with ESMTPSA id c3-20020a056a00008300b00575448ab0fdsm676742pfj.114.2022.12.22.05.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 05:11:45 -0800 (PST)
From:   Luca Stefani <luca@osomprivacy.com>
Cc:     Luca Stefani <luca@osomprivacy.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Mukesh Ojha <mojha@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pstore: Properly assign mem_type property
Date:   Thu, 22 Dec 2022 14:10:49 +0100
Message-Id: <20221222131049.286288-1-luca@osomprivacy.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If mem-type is specified in the device tree
it would end up overriding the record_size
field instead of populating mem_type.

As record_size is currently parsed after the
improper assignment with default size 0 it
continued to work as expected regardless of the
value found in the device tree.

Simply changing the target field of the struct
is enough to get mem-type working as expected.

Fixes: 9d843e8fafc7 ("pstore: Add mem_type property DT parsing support")
Signed-off-by: Luca Stefani <luca@osomprivacy.com>
---
 fs/pstore/ram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index fefe3d391d3a..28cb1555920c 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -670,7 +670,7 @@ static int ramoops_parse_dt(struct platform_device *pdev,
 		field = value;						\
 	}
 
-	parse_u32("mem-type", pdata->record_size, pdata->mem_type);
+	parse_u32("mem-type", pdata->mem_type, pdata->mem_type);
 	parse_u32("record-size", pdata->record_size, 0);
 	parse_u32("console-size", pdata->console_size, 0);
 	parse_u32("ftrace-size", pdata->ftrace_size, 0);
-- 
2.38.1

