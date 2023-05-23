Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B89E70E3F9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235559AbjEWRpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238312AbjEWRpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:45:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855F8129;
        Tue, 23 May 2023 10:45:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0EDD96243B;
        Tue, 23 May 2023 17:45:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39573C433D2;
        Tue, 23 May 2023 17:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684863901;
        bh=NspQ5eSfzkW/s4ZKEIvi8KiViH9J4SR7mF8q0fY8gJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TY+dULhJSQIb+7SoIlNsFJ3c2ybN3aqIpmMeueRUNtqDI5hPOBq7OdysOVf30W142
         7IvIDLpkWexZrAKSjweMi52QGIbxfDUG8+xIPl6pYxo/BB07y1eVvYiZcbdLBvk2b1
         S/uJCJqg8gQcqWMGFmopC95fhhAKIxFN4DuuyyBdMaoJRPSx9beO99VZnjntgC21zv
         UTaxYe7Hqsf6AZTGLmClB3TVyMI7fS75NxR59iDt9NQKO9oXDBuOAPIHDaHCyOD0qO
         8LfF9RXOXdqLqGTOIEq4roGFsDywKxcCB4P2mRr18eBGyLYjpw2B7xZTpQbRhfiVbl
         XFNw/PI2ZcKag==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-doc@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        William White <chwhite@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH V2 8/9] rtla/hwnoise: Reduce runtime to 75%
Date:   Tue, 23 May 2023 19:44:30 +0200
Message-Id: <b5ee037b2c246afc6115883afef78b4a7d8040d4.1684863094.git.bristot@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1684863094.git.bristot@kernel.org>
References: <cover.1684863094.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

osnoise runs 100% of time by default. It makes sense because osnoise
is preemptive. hwnoise checks preemption once a second, so it
reduces system progress.

Reduce runtime to 75% to avoid problems by default. I added a Fixes
as it might avoid problems for first time users as it lands on distros.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Fixes: 1f428356c38d ("rtla: Add hwnoise tool")
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 tools/tracing/rtla/src/osnoise_top.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 85abba568faf..f7c959be8677 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -348,8 +348,14 @@ struct osnoise_top_params *osnoise_top_parse_args(int argc, char **argv)
 	if (!params)
 		exit(1);
 
-	if (strcmp(argv[0], "hwnoise") == 0)
+	if (strcmp(argv[0], "hwnoise") == 0) {
 		params->mode = MODE_HWNOISE;
+		/*
+		 * Reduce CPU usage for 75% to avoid killing the system.
+		 */
+		params->runtime = 750000;
+		params->period = 1000000;
+	}
 
 	while (1) {
 		static struct option long_options[] = {
-- 
2.38.1

