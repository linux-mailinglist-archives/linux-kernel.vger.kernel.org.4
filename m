Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0DA6E7856
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 13:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbjDSLRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 07:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbjDSLRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 07:17:12 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96132146E5;
        Wed, 19 Apr 2023 04:16:39 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-63d4595d60fso6135296b3a.0;
        Wed, 19 Apr 2023 04:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681902939; x=1684494939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F7+u9xQhLDQrqjy4o4RJRJ8DCzaXxJZlsawnZVjNt3s=;
        b=g9tElXFhLI2LM3U0SMnA9tTDN79NflMAFeMM9JwZPuAOPASC90wunJ5LWNPooTMYiS
         vF8A7X2qZOHB20OaZ/1ijX+qPlMQ6IT2p1hywRhTTfbAlxDPuEnv00wTz/egUeIlhBjG
         xNhRby8s6DEaPxyd8Gr8tbAf86GO6e4CASaVDK22oSY2LYWtpczKVLqFYYkQ7N+63xWw
         TJO6BMTg2ToYvs8a5YCrzcXKGVZ/bTr2QXjx6L0yHXkCWo3d5grS7KCHBrfmu3hSevM6
         NDf53OeVEnZyKw0plNIl/u9jk4gMZL/YFQXxE+Aja7Kh4+PeeyW6DoiSGeUt/kRHRg6S
         mifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681902939; x=1684494939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F7+u9xQhLDQrqjy4o4RJRJ8DCzaXxJZlsawnZVjNt3s=;
        b=NFd0v6UPfbZUdgOvioEFSyR/hTE3z9j4Pjr6zyvmqBCixqLRvNShAYoQWdrdHi8Toh
         p25BtXZQiz6XyIeg7QxjejVG6tvl4MJU/zRhxuL3RmK63iz0FsS8i5MF3PbQ57V/H2KG
         4IDgMm430DZhi5DrHlnn+qNq1TR0L89Yd1V8n9eTtzTFs1REQ7mVnlsFlg4BNH/AvTNg
         d0psIWLSmI1HJxjhh+wyxZC0kUt9rz3MhquFbfluLfXUQ5yEBooz0NjlWssx7j0tSa+W
         LsIBrAinJvJM4CCH2B2NvGt+oiQctkKQGn/p+iJWke87sjWEJUmygIcGbXwDpmXsBamF
         8IIA==
X-Gm-Message-State: AAQBX9d9oi4t5dPO7PmFPRG3/uC3RWFFZgua01FD5tjjQQoFnrzr64DB
        eTH8Rm3uodSladcRn+EO65NSBgJjTFs=
X-Google-Smtp-Source: AKy350a21cL08vpppTtL6kpNrYMoThyva9XUw3uT0DzkomW6MhBVlSDcxusUPZevt8anqS9NlY5sww==
X-Received: by 2002:a17:902:c40f:b0:1a6:6edc:c884 with SMTP id k15-20020a170902c40f00b001a66edcc884mr2856114plk.16.1681902938762;
        Wed, 19 Apr 2023 04:15:38 -0700 (PDT)
Received: from cxl-test.. ([103.181.222.211])
        by smtp.gmail.com with ESMTPSA id o4-20020a170902bcc400b001a6566045ccsm11194914pls.192.2023.04.19.04.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 04:15:38 -0700 (PDT)
From:   Raghu H <raghuhack78@gmail.com>
To:     linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        raghuhack78@gmail.com, Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [STYLE v1 2/3] cxl/core/port: Use tabs to fix styling errors
Date:   Wed, 19 Apr 2023 11:14:42 +0000
Message-Id: <20230419111443.231151-3-raghuhack78@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230419111443.231151-1-raghuhack78@gmail.com>
References: <20230419111443.231151-1-raghuhack78@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Styling errors due to linux of unwanted spaces in the definition,
modified the definition to use tab to fix the styling issue.

Signed-off-by: Raghu H <raghuhack78@gmail.com>
---
 drivers/cxl/core/port.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 8ee6b6e2e2a4..7c3aaed180ca 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -95,15 +95,15 @@ static ssize_t size_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(size);
 
-#define CXL_DECODER_FLAG_ATTR(name, flag)                            \
-static ssize_t name##_show(struct device *dev,                       \
-			   struct device_attribute *attr, char *buf) \
-{                                                                    \
-	struct cxl_decoder *cxld = to_cxl_decoder(dev);              \
-                                                                     \
-	return sysfs_emit(buf, "%s\n",                               \
-			  (cxld->flags & (flag)) ? "1" : "0");       \
-}                                                                    \
+#define CXL_DECODER_FLAG_ATTR(name, flag)				\
+static ssize_t name##_show(struct device *dev,				\
+			   struct device_attribute *attr, char *buf)	\
+{									\
+	struct cxl_decoder *cxld = to_cxl_decoder(dev);			\
+									\
+	return sysfs_emit(buf, "%s\n",					\
+			  (cxld->flags & (flag)) ? "1" : "0");		\
+}									\
 static DEVICE_ATTR_RO(name)
 
 CXL_DECODER_FLAG_ATTR(cap_pmem, CXL_DECODER_F_PMEM);
-- 
2.39.2

