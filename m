Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17BE473EE9F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 00:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjFZWW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 18:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjFZWWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 18:22:23 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7780C12C
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 15:22:20 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-573d70da2afso50825047b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 15:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687818139; x=1690410139;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ReaGFdXUELI9PgBSlmcQgutJNUU9rWS286W3Y2GOPjE=;
        b=mRyQcWd/3PQ9a1T188edfBVp8yNWu707NMKt/vy97GpPbIx3kIqyWY8/mWnuOaWkSn
         uBE2osFUfS2BjCW7kayeSHiPOzf7fnlK1Jub0yKf19vKr7tJaEC3VyyjaSRgLDia63oO
         jb8HTlYENw1UQ2NarIrsjZ19Djl3j7kivsW25X6qcFxY9hWsnU1rIxPdncde2r3HWUcw
         twzuq3nZvVBfKi6y9cO8185E/MVnjCjn8RH0woL0gIANNVwMLqP0IbaBqxgw2nqaVFkb
         JrdypXWO7ezj7hTWzxiQ4vctrLgyKIjSObv1qIhJqFuLNboYPU6ct4eFoOVX21P4502d
         njEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687818139; x=1690410139;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ReaGFdXUELI9PgBSlmcQgutJNUU9rWS286W3Y2GOPjE=;
        b=EYonEJzZaIn76XRqJz46lFRTijMQlcrm5GmknBA3Wf8SQ8DIcuCq4df9vE6bgCGyYE
         sKt5cbRZxwOZegqTI6NqKf04LllIbWMY07DLtW/ghIwJHB8vtP3s2WzyR7XdzZHyInJT
         uWLfTg5C2ZKfIzO5rkknII1468kBtyWZJvb5HCkvvH/K2E/slpgmsw+/GnySAlUIxP6j
         +Wf/sy0S20MZn7azleu3kTH68VyeKMvCMUAKG+fde1wAd1Y9r3wXP7Z/YxeGCuVEleQd
         DJOUdGdTCu46/MgGS353Pr6wc2qreO+EvGNkSZ7abGNN3pODrp1BRFYHFeUsTt4QdzUp
         pT1A==
X-Gm-Message-State: AC+VfDz3ejhosWqVmusr+ybwTdnGO0F84JAzIV3YB+PDQt2shgHEOVk3
        jqfXZoqZ9wgacTmkfY1V+396Ly/dEnmY
X-Google-Smtp-Source: ACHHUZ7gz9Yo5lAlqDgEYFa3dJHBmAHKvYNu4W/+sZOojNuNpmEEnHWhkCyrt4w+12Zi4Ke8ZW5MVVSM5J8E
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:497e:a125:3cde:94f])
 (user=irogers job=sendgmr) by 2002:a81:ac1d:0:b0:565:9e73:f937 with SMTP id
 k29-20020a81ac1d000000b005659e73f937mr13364436ywh.4.1687818139573; Mon, 26
 Jun 2023 15:22:19 -0700 (PDT)
Date:   Mon, 26 Jun 2023 15:22:13 -0700
Message-Id: <20230626222213.366550-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v1] lib subcmd: Avoid use-after-free when no commands are excluded
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

The array shortening may be an unnecessary array copy. Before commit
657a3efee43a ("lib subcmd: Avoid memory leak in exclude_cmds") this
was benign, but afterwards this could lead to a segv.

Fixes: 657a3efee43a ("lib subcmd: Avoid memory leak in exclude_cmds")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/subcmd/help.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/lib/subcmd/help.c b/tools/lib/subcmd/help.c
index 67a8d6b740ea..b59ca17e406d 100644
--- a/tools/lib/subcmd/help.c
+++ b/tools/lib/subcmd/help.c
@@ -77,10 +77,11 @@ void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes)
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
2.41.0.162.gfafddb0af9-goog

