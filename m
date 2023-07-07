Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6828674B9CB
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 01:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjGGXJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 19:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjGGXJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 19:09:31 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7DE2125
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 16:09:30 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5428d1915acso3308588a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 16:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688771370; x=1691363370;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CP7T/EtIJGkevktQnNbzryuIvZqQCSF8n70H+YZm7c8=;
        b=Dcqd7CQTycET5DHgae6qTE1mVnRzmbusYJ5VDcC6QwFOeTNjMxKFerpfrvn/pnNYOS
         GATnSNgIEuBieULuN5X4SyaL9kQJoH9v5du6dKUIAERPOZxC5GaA+qmFpFUNGZY3eZzP
         ySefCSbfF93r0By2jw06GNX5PZ41KqkTNegPJqa8jg2fO9GyFv38TAzt7rY57nkcFI2e
         AoRxThPAjv2KaB+lW64nWF20xv295whXs4FJtnhSorsNERHn8zVSeJ2pWuAjxn5Cw+K9
         nfycCHdtPDLdt70hEnlTCOo4N1mfqXDwQv01OoL41/73qDQKQwZP6ITmlo6qhbT3dLqt
         yChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688771370; x=1691363370;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CP7T/EtIJGkevktQnNbzryuIvZqQCSF8n70H+YZm7c8=;
        b=N/mJ3qtM7uiQaIXJH8AE30epdyziBCdqmuV80KtYmOuQ9nQ6afhFWeKLp1b2YB7nwt
         LZRh1JRcjCPzk5wuDZpXGNk4dmGendK5qpsak4DEUXhbz4mMXQMUO2DHzsdC1P6sjKFE
         Yr5VFVR+1F2QHscTRMA0CGXT3k3vrOiZBdgJZXsQ4FJ4g9Br3oAM4nab8VPeXaf0+pmA
         3HYKr1CO4XUxKnaQf7uIaoCVbd3tqkCQiav4BXuOboLggRWRqv6hSsFmAhTwEdXd08dF
         wqAYdu4/JC1ZWCAR8bTxtdISO3IgWIqT/WGC6bBj2Swh+SMNtSJwNYdGNgYrC5844ui+
         QhTw==
X-Gm-Message-State: ABy/qLb1R2lLKDxv5Nuv+fHJ7N1XHTtR+QGWq+ADo3LSLT10kQXSUmHK
        JBfhhrI/eMsCnD0rHI4wQTyUcCG7LWay
X-Google-Smtp-Source: APBJJlFPNVgdJZuGOrOH/izeHPUmvxYdaMvpiIO1Q6MqiLkrPL+lB8LFn0HDO1xohq8+HtcSy0ZAYgecQa0s
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:40b5:5dd9:ddcd:34f4])
 (user=irogers job=sendgmr) by 2002:a63:3d04:0:b0:534:67f7:9364 with SMTP id
 k4-20020a633d04000000b0053467f79364mr4720006pga.4.1688771370217; Fri, 07 Jul
 2023 16:09:30 -0700 (PDT)
Date:   Fri,  7 Jul 2023 16:09:26 -0700
Message-Id: <20230707230926.841086-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.390.g38632f3daf-goog
Subject: [PATCH v2] lib subcmd: Avoid segv/use-after-free when commands aren't excluded
From:   Ian Rogers <irogers@google.com>
To:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Chenyuan Mi <cymi20@fudan.edu.cn>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The array shortening may perform unnecessary array copies. Before
commit 657a3efee43a ("lib subcmd: Avoid memory leak in exclude_cmds")
this was benign, but afterwards this could lead to a segv.

Fixes: 657a3efee43a ("lib subcmd: Avoid memory leak in exclude_cmds")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/subcmd/help.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/tools/lib/subcmd/help.c b/tools/lib/subcmd/help.c
index 67a8d6b740ea..adfbae27dc36 100644
--- a/tools/lib/subcmd/help.c
+++ b/tools/lib/subcmd/help.c
@@ -68,8 +68,13 @@ void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes)
 	while (ci < cmds->cnt && ei < excludes->cnt) {
 		cmp = strcmp(cmds->names[ci]->name, excludes->names[ei]->name);
 		if (cmp < 0) {
-			zfree(&cmds->names[cj]);
-			cmds->names[cj++] = cmds->names[ci++];
+			if (ci == cj) {
+				ci++;
+				cj++;
+			} else {
+				zfree(&cmds->names[cj]);
+				cmds->names[cj++] = cmds->names[ci++];
+			}
 		} else if (cmp == 0) {
 			ci++;
 			ei++;
@@ -77,10 +82,11 @@ void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes)
 			ei++;
 		}
 	}
-
-	while (ci < cmds->cnt) {
-		zfree(&cmds->names[cj]);
-		cmds->names[cj++] = cmds->names[ci++];
+	if (ci != cj) {
+		while (ci < cmds->cnt) {
+			zfree(&cmds->names[cj]);
+			cmds->names[cj++] = cmds->names[ci++];
+		}
 	}
 	for (ci = cj; ci < cmds->cnt; ci++)
 		zfree(&cmds->names[ci]);
-- 
2.41.0.390.g38632f3daf-goog

