Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D926FEBBF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 08:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbjEKG1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 02:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236751AbjEKG1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 02:27:30 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDF9103;
        Wed, 10 May 2023 23:27:29 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-51b0f9d7d70so7437391a12.1;
        Wed, 10 May 2023 23:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683786449; x=1686378449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BUM/womBq8zG0iIiWwWTRkqn2H+jvaSWOmmttRj5uZA=;
        b=QVkS6/mfk8fj+fZi8lFlKmIk8nPgYKzj4H1gYEY24Nc0TMmQJ0SNvHM5yPrbqOQfez
         S509jegR0jRiPSkb5q6EpjrQlc8BZmq7/uzRWMURB2sUOb1B8W4qCx+YeGhIG1+tyZ+Y
         JZ7MVI2Qr8dpfFvczODEDR2pZIDgJt/L3nZjlWihYI6ZgCxTgYVPgoMMohmAHoJm0YHJ
         csf6IDnjecRXuoahJO/J6TXkhlBSpNbw9Eyoa0eg4f2eWrvwbzODuMFxbOJssWCkY2pB
         6IRD/wZz56p9HWtMibiYOzR75HJk+YcZqX0lj6dghNkh4YUkCOo796cgbFz7HhsEA3lV
         T+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683786449; x=1686378449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BUM/womBq8zG0iIiWwWTRkqn2H+jvaSWOmmttRj5uZA=;
        b=SZUYzB1Va2cyi6Or0mPerN1HICTU28wF4KDSHnkx+Z+J+GalLfEWwzGXbGTYa7GqNj
         aQTbMEfZAfH0+S3U6Z4fFeF497l70SNN4rQJNRc7eHkXW5RngQH8ZWHSws15YwjTPLk5
         eNSf1Yh/mQy8+xPpnpD51bgxToiyySdLes7kv4h+gy29KLzdGHkB3FmhvwZ7rA7IOoYp
         XzyOeBSwskGc9DBvTjKMX4Q122jk2kQ9dAEZTm84NsnjIdiWWFJWTwHn0MPjHa4jKXbr
         yZ4FPlEh8PAkG3Y+WUFgvbpjOmS9uNeX6Vpa59brbOHDhT/MV2guovSDi2kFJY4HgW3j
         NUOA==
X-Gm-Message-State: AC+VfDwoV5bvfp34JGbu1EgpSdyjynNcCM65pfSBWTOdf/7DwQed+824
        B3YsMY/mG5CH2kmq8AonsX0=
X-Google-Smtp-Source: ACHHUZ74w2hCkiKy/x/b9809bt+OPI4LJAVDv1QVb1FH6S8QXBhvKah1mnfVslzU97GE0NEA2QMPBA==
X-Received: by 2002:a17:902:b68d:b0:1ac:7405:d3ba with SMTP id c13-20020a170902b68d00b001ac7405d3bamr13535688pls.40.1683786449496;
        Wed, 10 May 2023 23:27:29 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6700:7f00:c18c:3210:36c3:c88c])
        by smtp.gmail.com with ESMTPSA id jj17-20020a170903049100b001ac2be2639asm4925683plb.223.2023.05.10.23.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 23:27:29 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 2/3] perf annotate: Parse x86 SIB addressing properly
Date:   Wed, 10 May 2023 23:27:24 -0700
Message-ID: <20230511062725.514752-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
In-Reply-To: <20230511062725.514752-1-namhyung@kernel.org>
References: <20230511062725.514752-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the source argument of mov instruction is look like below, it didn't
parse the whole operand and just stopped at the first comma.

  mov    (%rbx,%rax,1),%rcx

Fix it by checking the parentheses and move it to the closing one.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index ca9f0add68f4..6053ddf9c32d 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -550,6 +550,19 @@ static int mov__parse(struct arch *arch, struct ins_operands *ops, struct map_sy
 		return -1;
 
 	*s = '\0';
+
+	/*
+	 * x86 SIB addressing has something like 0x8(%rax, %rcx, 1)
+	 * then it needs to have the closing parenthesis.
+	 */
+	if (strchr(ops->raw, '(')) {
+		*s = ',';
+		s = strchr(ops->raw, ')');
+		if (s == NULL || s[1] != ',')
+			return -1;
+		*++s = '\0';
+	}
+
 	ops->source.raw = strdup(ops->raw);
 	*s = ',';
 
-- 
2.40.1.521.gf1e218fcd8-goog

