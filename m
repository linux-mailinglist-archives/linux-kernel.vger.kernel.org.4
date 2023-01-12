Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116A1667156
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 12:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjALLzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 06:55:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbjALLya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 06:54:30 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4B04F11B
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 03:44:11 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9BBD53F068;
        Thu, 12 Jan 2023 11:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673523849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=BG+fHBqxWABJrZCJncRSe6CbRjngbYvlt+A/PF25LZk=;
        b=kWLGTEjxSQk3Cb2StwWbZFlOWF+YA0LqlBFUAyBw6edbcWEylnNhi9wRjxg8rClMbpA5qa
        AOYhzkfoqqPp9f1L2jnxxB04530FWTyip9X0augMuZ3x2cON1tmyHUkamLOkQdlNio3YaD
        uaL2HLvW4kJXyykD1dXM0uBYY4+YR6g=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 40989136AE;
        Thu, 12 Jan 2023 11:44:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id nGcODInyv2MyTgAAGKfGzw
        (envelope-from <antonio.feijoo@suse.com>); Thu, 12 Jan 2023 11:44:09 +0000
From:   Antonio Alvarez Feijoo <antonio.feijoo@suse.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Antonio Alvarez Feijoo <antonio.feijoo@suse.com>
Subject: [PATCH] tools/bootconfig: fix single & used for logical condition
Date:   Thu, 12 Jan 2023 12:42:15 +0100
Message-Id: <20230112114215.17103-1-antonio.feijoo@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A single & will create a background process and return true, so the grep
command will run even if the file checked in the first condition does not
exist.

Signed-off-by: Antonio Alvarez Feijoo <antonio.feijoo@suse.com>
---
 tools/bootconfig/scripts/ftrace2bconf.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bootconfig/scripts/ftrace2bconf.sh b/tools/bootconfig/scripts/ftrace2bconf.sh
index 6183b36c6846..1603801cf126 100755
--- a/tools/bootconfig/scripts/ftrace2bconf.sh
+++ b/tools/bootconfig/scripts/ftrace2bconf.sh
@@ -93,7 +93,7 @@ referred_vars() {
 }
 
 event_is_enabled() { # enable-file
-	test -f $1 & grep -q "1" $1
+	test -f $1 && grep -q "1" $1
 }
 
 per_event_options() { # event-dir
-- 
2.35.3

