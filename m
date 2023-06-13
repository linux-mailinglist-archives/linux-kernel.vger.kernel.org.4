Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC3A72EEE3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 00:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238987AbjFMWIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 18:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233282AbjFMWIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 18:08:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4001BCA
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 15:08:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C3F663B88
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 22:08:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C6CC433CA;
        Tue, 13 Jun 2023 22:08:26 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1q9CBc-000EFo-3C;
        Tue, 13 Jun 2023 18:08:24 -0400
Message-ID: <20230613220824.813403175@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 13 Jun 2023 18:07:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        William White <chwhite@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [for-next][PATCH 08/11] rtla/hwnoise: Reduce runtime to 75%
References: <20230613220750.330146797@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Bristot de Oliveira <bristot@kernel.org>

osnoise runs 100% of time by default. It makes sense because osnoise
is preemptive. hwnoise checks preemption once a second, so it
reduces system progress.

Reduce runtime to 75% to avoid problems by default. I added a Fixes
as it might avoid problems for first time users as it lands on distros.

Link: https://lkml.kernel.org/r/af0b7113ffc00031b9af4bb40ef5889a27dadf8c.1686066600.git.bristot@kernel.org

Cc: William White <chwhite@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Tested-by: Juri Lelli <juri.lelli@redhat.com>
Fixes: 1f428356c38d ("rtla: Add hwnoise tool")
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
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
2.39.2
