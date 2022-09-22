Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065655E5812
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 03:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiIVBdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 21:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiIVBde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 21:33:34 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E899F196;
        Wed, 21 Sep 2022 18:33:33 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id w20so7352306ply.12;
        Wed, 21 Sep 2022 18:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=GD4Djx6utyz7GQPUScmodVtC9ixtIbFOC/vi8N3b1us=;
        b=BFqDCyWLlsO59PJlfq4NzaQXtm28yToAcL7G6jpKWKpRfd6TsS7CJnycKrS+bbWVNv
         NfeYzKF8eAYpVt8Nvciqh9jI0l4knIemANRyr+Fq9A+6+iB7VDJSQVudU4Mm3h6oQas5
         /HtWt883b0FHE94Uyq/VMw6AwkNXz+AfzDGhuoAmOxlQjohnxOmaMfzW+eOmVopI5jTl
         JkNj2GYIg1o0UBLcCnohqpWJtTzGz1Gw4eOfxZMm6bFuifuo0dctZ8NZCDx8LXGPvjUs
         rhzHAMkODAQtH3BpjvX3FcOgDAWci2ay96Kw+HN+TiXufXOBLbxzI3uw1NPTrdzzo1ci
         A9kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=GD4Djx6utyz7GQPUScmodVtC9ixtIbFOC/vi8N3b1us=;
        b=C6FEYa+A3+skI+9EMOgucnwbxFdxerH0pVifZq1f5hr1i6e4PsYtxc5W0hNZxmux2z
         /9Py0H9bGaOUwyhh8tQU1Jk6fc4jFKwQibq6bs3sUN4s8QK6shDTg8NP8CcfvEn45Axo
         B08Dujy3Ics+0SMVjd6Y++0UddVUm4xo/h5aG56UApY+PhNDIvojgQW8wisxmjG/316V
         tSTSyQJiRKk8fu7SQryGbKi6uIL3ZKHXHGkL7/kJ4RgsvG/QMor/CS4MQ5yLxWGJkjKw
         ImfLnmNtd4vszjPg2OJWrnu4nm3uln3UlBkmJ/gUaGuQEC/V74KyJztCipLpkmgYdz96
         Ey9A==
X-Gm-Message-State: ACrzQf1DIiOt0A4CXmT8lPiEx8dn6mkihIy/q1GObe+CRJTTTck8Kncv
        ixTy2y73SJxPRFBPf9MwjvU=
X-Google-Smtp-Source: AMsMyM5OzEbkzXWEMdmTlKzYsIelYRBhetB9m0wkuhZ0KPYAiMvIrKK81uFWHOKtenSxfx+jOLMXpA==
X-Received: by 2002:a17:902:f547:b0:178:39fe:5b14 with SMTP id h7-20020a170902f54700b0017839fe5b14mr975029plf.100.1663810412979;
        Wed, 21 Sep 2022 18:33:32 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id bj3-20020a056a02018300b0043a1c0a0ab1sm2521346pgb.83.2022.09.21.18.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 18:33:32 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     acme@kernel.org
Cc:     mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        leo.yan@linaro.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] perf synthetic-events: use strscpy() is more robust and safer
Date:   Thu, 22 Sep 2022 01:33:28 +0000
Message-Id: <20220922013328.232998-1-ye.xingchen@zte.com.cn>
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
 tools/perf/util/synthetic-events.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 0ff57ca24577..9f82b66f6271 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -1947,7 +1947,7 @@ int perf_event__synthesize_event_update_unit(struct perf_tool *tool, struct evse
 	if (ev == NULL)
 		return -ENOMEM;
 
-	strlcpy(ev->unit, evsel->unit, size + 1);
+	strscpy(ev->unit, evsel->unit, size + 1);
 	err = process(tool, (union perf_event *)ev, NULL, NULL);
 	free(ev);
 	return err;
@@ -1981,7 +1981,7 @@ int perf_event__synthesize_event_update_name(struct perf_tool *tool, struct evse
 	if (ev == NULL)
 		return -ENOMEM;
 
-	strlcpy(ev->name, evsel->name, len + 1);
+	strscpy(ev->name, evsel->name, len + 1);
 	err = process(tool, (union perf_event *)ev, NULL, NULL);
 	free(ev);
 	return err;
-- 
2.25.1
