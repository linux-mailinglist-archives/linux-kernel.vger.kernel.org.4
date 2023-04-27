Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A41A6F0EB0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 01:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344376AbjD0XFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 19:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjD0XFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 19:05:08 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32FC2D65;
        Thu, 27 Apr 2023 16:05:06 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-63b7096e2e4so7539452b3a.2;
        Thu, 27 Apr 2023 16:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682636706; x=1685228706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=SuthzOP7teE2TJtcGVgcOBqXsLnkwl8x+Mo6/AZ4cCs=;
        b=aoJq6G8Cs2aJyA2rh6thgp9O9iK7mqRD4ejT5mN1yHmdQFwQCQLq0uUgCMF1mfyGXw
         I/jLLuAb//ODC2yli2oQOQyOhByc79nrXhPmvehX/1+Igw1QCSQ2FQHZGOydR4IDUY1B
         q72u27YbAnnx7Khav2KLXm5i86BfDJ2m3vxzx+LJHbL8L4emVkamcDa4HcT/zLWGZ6vW
         V2BBi7Mx3BYBck4Jn1paG+lzFBWbh81bzMpioyLriARqt66QdbDKPWZlMoTOFowsr4hZ
         493JPsIzCKZA/LC+qbwL0QGVAQvZEYbo+JzRKElKN4sz7ABuyC/U8470vh+0uKwpQdoR
         /JGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682636706; x=1685228706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SuthzOP7teE2TJtcGVgcOBqXsLnkwl8x+Mo6/AZ4cCs=;
        b=dfOvVdS7IQTTLpqNLy3F3yE+8pevJg4i3R5Dw9pJGYvFgz1u1xvhdQgbHRHw34UOwW
         S3TQSAfspB86089yVoZv89t7UZy7RJuF5aHq+9lJ1TPO2VXhDLfMyz+kQEFL59C1Va6m
         jSZ0oWTwOcijd466XQF/UFMB+JPYEMq0eeM+JzO8e22Xs34Bd25VhxX4Ic6ZHx1Mt4P8
         zagNYON9IucHrDV2dhipklm0OeiMrNcIWM9KWlfcvFz5vHS2cHQ93GhuWrbSARH6FZXg
         E/YuHuisHB7VrpaTUg+h4mFo6BwogS2/66O9P/wXgB+F0xYBJ5MGFScC7tnUmtZTuEmj
         4Azw==
X-Gm-Message-State: AC+VfDyQpHeVCmZAszdkjDxajbjGJCJ4O7RiL7un4EDeWTlZYuLLsa7p
        y1f6sln7jlArdroIOREps6g=
X-Google-Smtp-Source: ACHHUZ4WHXQpTiHRxq6CrQ9S/QPLQ/YqZEnJut02Sbvj6sO+5VZXxJbKh3neHf9+amrE2qenONm12Q==
X-Received: by 2002:a05:6a20:3d84:b0:f5:3f3e:b716 with SMTP id s4-20020a056a203d8400b000f53f3eb716mr4044876pzi.28.1682636705649;
        Thu, 27 Apr 2023 16:05:05 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2d4:203:55cd:594d:edb:e780])
        by smtp.gmail.com with ESMTPSA id p10-20020aa79e8a000000b005d22639b577sm13636436pfq.165.2023.04.27.16.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 16:05:05 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 1/2] perf list: Fix memory leaks in print_tracepoint_events()
Date:   Thu, 27 Apr 2023 16:05:01 -0700
Message-ID: <20230427230502.1526136-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
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

It should free entries (not only the array) filled by scandirat()
after use.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/print-events.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index d416c5484cd5..0a97912fd894 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -83,11 +83,11 @@ void print_tracepoint_events(const struct print_callbacks *print_cb __maybe_unus
 		if (sys_dirent->d_type != DT_DIR ||
 		    !strcmp(sys_dirent->d_name, ".") ||
 		    !strcmp(sys_dirent->d_name, ".."))
-			continue;
+			goto next_sys;
 
 		dir_fd = openat(events_fd, sys_dirent->d_name, O_PATH);
 		if (dir_fd < 0)
-			continue;
+			goto next_sys;
 
 		evt_items = scandirat(events_fd, sys_dirent->d_name, &evt_namelist, NULL, alphasort);
 		for (int j = 0; j < evt_items; j++) {
@@ -98,12 +98,12 @@ void print_tracepoint_events(const struct print_callbacks *print_cb __maybe_unus
 			if (evt_dirent->d_type != DT_DIR ||
 			    !strcmp(evt_dirent->d_name, ".") ||
 			    !strcmp(evt_dirent->d_name, ".."))
-				continue;
+				goto next_evt;
 
 			snprintf(evt_path, sizeof(evt_path), "%s/id", evt_dirent->d_name);
 			evt_fd = openat(dir_fd, evt_path, O_RDONLY);
 			if (evt_fd < 0)
-				continue;
+				goto next_evt;
 			close(evt_fd);
 
 			snprintf(evt_path, MAXPATHLEN, "%s:%s",
@@ -119,9 +119,13 @@ void print_tracepoint_events(const struct print_callbacks *print_cb __maybe_unus
 					/*desc=*/NULL,
 					/*long_desc=*/NULL,
 					/*encoding_desc=*/NULL);
+next_evt:
+			free(evt_namelist[j]);
 		}
 		close(dir_fd);
 		free(evt_namelist);
+next_sys:
+		free(sys_namelist[i]);
 	}
 
 	free(sys_namelist);
-- 
2.40.1.495.gc816e09b53d-goog

