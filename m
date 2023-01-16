Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046D766BC17
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 11:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjAPKpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 05:45:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjAPKpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 05:45:36 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F00D4683;
        Mon, 16 Jan 2023 02:45:35 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C553D676BA;
        Mon, 16 Jan 2023 10:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673865933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=07tGz6KgbKklDF1+St8lfTDW5T8BQgfj3DAzdtWsD9g=;
        b=LQdOaJX8EV+wYaNrqmbkXaFbawj3kRdqciizymTrkj2hOzDLROhNLue1qNtwB2zFAddfkK
        YkL6bUr1r67r//HHPXckHEAaYtQbTcA9xsCEbs5jJfDiK4Q7gr9ls55ZU1qNur+sT9oaQw
        3kDSJWGm8sr5Mm2fRuKVz6t2VtvRiUI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673865933;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=07tGz6KgbKklDF1+St8lfTDW5T8BQgfj3DAzdtWsD9g=;
        b=0yoE3f2+OQ2/GoKwOJKl+rb9IAzvOmCKgUkF50WNxGu8+RVUtYgYCZowQaH1Pc+6tJrVAH
        rIPB2950VQyBFCAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A055E138FE;
        Mon, 16 Jan 2023 10:45:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YU4LJs0qxWM7WwAAMHmgww
        (envelope-from <mliska@suse.cz>); Mon, 16 Jan 2023 10:45:33 +0000
Message-ID: <ed72aa98-151a-0f1b-062b-fbea08b38f6f@suse.cz>
Date:   Mon, 16 Jan 2023 11:45:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
From:   =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
Subject: [PATCH] scripts: support GNU make 4.4 in jobserver-exec
To:     linux-kernel@vger.kernel.org
Content-Language: en-US
Cc:     linux-block@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>, nicolas@fjasle.eu,
        axboe@kernel.dk, josef@toxicpanda.com, keescook@chromium.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Starting with GNU make 4.4, --jobserver-auth newly uses named
pipe (fifo) instead of part of opened file descriptors:
https://www.gnu.org/software/make/manual/html_node/POSIX-Jobserver.html

Support also the new format.

Signed-off-by: Martin Liska <mliska@suse.cz>
---
 scripts/jobserver-exec | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/scripts/jobserver-exec b/scripts/jobserver-exec
index 4192855f5b8b..7eca035472d3 100755
--- a/scripts/jobserver-exec
+++ b/scripts/jobserver-exec
@@ -26,11 +26,20 @@ try:
 	# If the MAKEFLAGS variable contains multiple instances of the
 	# --jobserver-auth= option, the last one is relevant.
 	fds = opts[-1].split("=", 1)[1]
-	reader, writer = [int(x) for x in fds.split(",", 1)]
-	# Open a private copy of reader to avoid setting nonblocking
-	# on an unexpecting process with the same reader fd.
-	reader = os.open("/proc/self/fd/%d" % (reader),
-			 os.O_RDONLY | os.O_NONBLOCK)
+
+	# Starting with GNU Make 4.4, named pipes are used for reader and writer.
+	# Example argument: --jobserver-auth=fifo:/tmp/GMfifo8134
+	_, _, path = fds.partition('fifo:')
+
+	if path:
+		reader = os.open(path, os.O_RDONLY | os.O_NONBLOCK)
+		writer = os.open(path, os.O_WRONLY)
+	else:
+		reader, writer = [int(x) for x in fds.split(",", 1)]
+		# Open a private copy of reader to avoid setting nonblocking
+		# on an unexpecting process with the same reader fd.
+		reader = os.open("/proc/self/fd/%d" % (reader),
+				 os.O_RDONLY | os.O_NONBLOCK)
 
 	# Read out as many jobserver slots as possible.
 	while True:
-- 
2.39.0

