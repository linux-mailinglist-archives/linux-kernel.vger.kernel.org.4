Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4DC05BFB0E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbiIUJd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbiIUJdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:33:42 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B79D8F949;
        Wed, 21 Sep 2022 02:33:41 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d82so5325321pfd.10;
        Wed, 21 Sep 2022 02:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=+XDtsTjJuB5jKoAMJSeri0MhQB//esckwwpwet6c63k=;
        b=bdydpms+vWk0pA8hbNzofwI+783khB3Jnx+9DxEeImz6zg6XDHap9Tko3ztM3dxjZe
         wOa3XoLV/cHOmAxR9V6VqWQ7038wtA4+X53lcQ8m5a+mQw52YiUbRjnsBhhfIfp9Fs02
         NbTWKwhyc3asZU3HckpqHaI2gqnKfbB/w8Jru+wXrd3PUyEnQ5D1ufQKbxOb5NjRsIrz
         wCbpIpRic7DcVag8/XlDIZUdynUTeLPSwbcn1zUAL3gw6hmV1EBMqlZaXvy/iWz3Nu+h
         Y1QU2a7o0dswzOhnaXt9oCnR/lPp7YTi+BiEcCUq8DU6arVjbghZkbGESzuHfYs5Lkuw
         YQQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=+XDtsTjJuB5jKoAMJSeri0MhQB//esckwwpwet6c63k=;
        b=HlJAOwwD4bVjatgxgiEWhB59cY3Sg0+C+VLvI7RF+9NXm6YfM0us5zlM9YD9BFDmin
         w12f3+F1dG/CNov+Z5Z55a3onyMXDJtPNcCMPZO2Kb9fEJp1MSIdLLgXCZTF4RzMuIdR
         uvNL8SEG08axJKDup/cFwWYQAuN/NsQV1ocANwY7K2vn9l2dkE59CLeiFDGANJl+yHFf
         xMJ3EiIyJK+gjkzNCyWYAwqSpW8Mn6ysqHdvN0J32c/UQHDIB/tEG96BSmQtRLiFljxX
         f8iiHYCueMoZYD5D3dAu8dwVDJ/P8TC87soWgEmE4jtmsuGJ6fW7HPo0FC5RsmSWIwLk
         UJxQ==
X-Gm-Message-State: ACrzQf1+czrwNV2NwomR5sIaqWaK0XhCUAfkLc2v7tXhPW805I+J+0US
        VbFegC31mA2qwx2duVXHfEo=
X-Google-Smtp-Source: AMsMyM6fTzEmWV+a/UaZUa7nOnJ46pEd1NnTfiBQoh6ZA2RqEks0JyNCUGGRUvHqco0Jl9DyrxqT4w==
X-Received: by 2002:a63:ff5a:0:b0:42c:61f:b81 with SMTP id s26-20020a63ff5a000000b0042c061f0b81mr23953875pgk.254.1663752820774;
        Wed, 21 Sep 2022 02:33:40 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d80-20020a621d53000000b00540e1117c98sm1606505pfd.122.2022.09.21.02.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 02:33:40 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     acme@kernel.org
Cc:     mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] perf parse-events: use strscpy() is more robust and safer
Date:   Wed, 21 Sep 2022 09:33:35 +0000
Message-Id: <20220921093336.230635-1-ye.xingchen@zte.com.cn>
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
 tools/perf/util/print-events.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index ba1ab5134685..36c242ea6314 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -430,7 +430,7 @@ static void print_tool_event(const struct event_symbol *syms, const char *event_
 		if (syms->alias && strlen(syms->alias))
 			snprintf(name, MAX_NAME_LEN, "%s OR %s", syms->symbol, syms->alias);
 		else
-			strlcpy(name, syms->symbol, MAX_NAME_LEN);
+			strscpy(name, syms->symbol, MAX_NAME_LEN);
 		printf("  %-50s [%s]\n", name, "Tool event");
 	}
 }
@@ -485,7 +485,7 @@ void print_symbol_events(const char *event_glob, unsigned int type,
 		if (!name_only && strlen(syms->alias))
 			snprintf(name, MAX_NAME_LEN, "%s OR %s", syms->symbol, syms->alias);
 		else
-			strlcpy(name, syms->symbol, MAX_NAME_LEN);
+			strscpy(name, syms->symbol, MAX_NAME_LEN);
 
 		evt_list[evt_i] = strdup(name);
 		if (evt_list[evt_i] == NULL)
-- 
2.25.1
