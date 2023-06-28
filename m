Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863DF741922
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 21:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbjF1T6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 15:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjF1T6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 15:58:19 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257941FE7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 12:58:18 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso56025a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 12:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687982297; x=1690574297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SLKKj3K4u0AlIAtmQW7z5se9epOJGry5f3WiL2g4NwY=;
        b=bX9n4EZZyTbXN54Rp0GUhOYll5IXE//1a0nNjN2h20oHk4WN/oIlsZWQFuTtDjNB3s
         a0ls74kLCHwip1lHi8qogxSWcaGBS6fcnDHDR26NY29EEYazFE7nYZEwDlzaY4KmCu1z
         iN9/b9wlgfLjIXCZRzzSwOVfWJtLNKQEP06VI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687982297; x=1690574297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SLKKj3K4u0AlIAtmQW7z5se9epOJGry5f3WiL2g4NwY=;
        b=UMMhze2fWCQKqgra1/4UQ01ZNAVbLYMjDlGks+ZkTslsGOaKuDBwZ2awHLyPLcv0Ey
         Bmc67P0OmNTZLmYisnn+Peq07N2d+6QzYDIy0KjQ5qrsyEquQaLoubBTjGHuuqITIQUi
         8Bk40V4oD3Xdac+4Ajcrk1XWedLt3EU0SWuhcNh2OejhfBTCMffbLn5aJ08r9BSnuSpa
         aXRdu8UOBa/V8j4NdXcukKypfBA7tx8XFSVgGGdUm0Ee3NxtIfO/71zkeoGMitYh8SRH
         QZRYuMjM7uEX0EkfpfB3GTKq4ANY5Avvv18HxSUrwm0CF2rJSqSGoJcXW1ZJSFl+1RSW
         8oAQ==
X-Gm-Message-State: AC+VfDy2IKZZFu3UyFIFU0CKgR2Lzc++ogD3QrmwX6JczJQ2N/0gW02s
        LcVOIwEglC65v/z76+epZD0A9g==
X-Google-Smtp-Source: ACHHUZ5TLdkXmDvbkiEIedIWvx1hwus+8KkOIvcmR/GosTyB+JZbqCpMg+YoO6VmeXjJk4WpAJVCQA==
X-Received: by 2002:a17:90a:930f:b0:262:ebb9:dd59 with SMTP id p15-20020a17090a930f00b00262ebb9dd59mr9131691pjo.20.1687982297575;
        Wed, 28 Jun 2023 12:58:17 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:1228:a4c5:d742:666b])
        by smtp.gmail.com with ESMTPSA id nw13-20020a17090b254d00b00262ff206931sm5040108pjb.42.2023.06.28.12.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 12:58:16 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] kdb: Handle LF in the command parser
Date:   Wed, 28 Jun 2023 12:56:17 -0700
Message-ID: <20230628125612.1.I5cc6c3d916195f5bcfdf5b75d823f2037707f5dc@changeid>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main kdb command parser only handles CR (ASCII 13 AKA '\r') today,
but not LF (ASCII 10 AKA '\n'). That means that the kdb command parser
can handle terminals that send just CR or that send CR+LF but can't
handle terminals that send just LF.

The fact that kdb didn't handle LF in the command parser tripped up a
tool I tried to use with it. Specifically, I was trying to send a
command to my device to resume it from kdb using a ChromeOS tool like:
  dut-control cpu_uart_cmd:"g"
That tool only terminates lines with LF, not CR+LF.

Arguably the ChromeOS tool should be fixed. After all, officially kdb
seems to be designed such that CR+LF is the official line ending
transmitted over the wire and that internally a line ending is just
'\n' (LF). Some evidence:
* uart_poll_put_char(), which is used by kdb, notices a '\n' and
  converts it to '\r\n'.
* kdb functions specifically use '\r' to get a carriage return without
  a newline. You can see this in the pager where kdb will write a '\r'
  and then write over the pager prompt.

However, all that being said there's no real harm in accepting LF as a
command terminator in the kdb parser and doing so seems like it would
improve compatibility. After this, I'd expect that things would work
OK-ish with a remote terminal that used any of CR, CR+LF, or LF as a
line ending. Someone using CR as a line ending might get some ugliness
where kdb wasn't able to overwrite the last line, but basic commands
would work. Someone using just LF as a line ending would probably also
work OK.

A few other notes:
- It can be noted that "bash" running on an "agetty" handles LF as a
  line termination with no complaints.
- Historically, kdb's "pager" actually handled either CR or LF fine. A
  very quick inspection would make one think that kdb's pager actually
  could have paged down two lines instead of one for anyone using
  CR+LF, but this is generally avoided because of kdb_input_flush().
- Conceivably one could argue that some of this special case logic
  belongs in uart_poll_get_char() since uart_poll_put_char() handles
  the '\n' => '\r\n' conversion. I would argue that perhaps we should
  eventually do the opposite and move the '\n' => '\r\n' out of
  uart_poll_put_char(). Having that conversion at such a low level
  could interfere if we ever want to transfer binary data. In
  addition, if we truly made uart_poll_get_char() the inverse of
  uart_poll_put_char() it would convert back to '\n' and (ironically)
  kdb's parser currently only looks for '\r' to find the end of a
  command.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 kernel/debug/kdb/kdb_io.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 5c7e9ba7cd6b..813cb6cf72d6 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -131,6 +131,7 @@ char kdb_getchar(void)
 	int escape_delay = 0;
 	get_char_func *f, *f_prev = NULL;
 	int key;
+	static bool last_char_was_cr;
 
 	for (f = &kdb_poll_funcs[0]; ; ++f) {
 		if (*f == NULL) {
@@ -149,6 +150,18 @@ char kdb_getchar(void)
 			continue;
 		}
 
+		/*
+		 * The caller expects that newlines are either CR or LF. However
+		 * some terminals send _both_ CR and LF. Avoid having to handle
+		 * this in the caller by stripping the LF if we saw a CR right
+		 * before.
+		 */
+		if (last_char_was_cr && key == '\n') {
+			last_char_was_cr = false;
+			continue;
+		}
+		last_char_was_cr = (key == '\r');
+
 		/*
 		 * When the first character is received (or we get a change
 		 * input source) we set ourselves up to handle an escape
@@ -244,7 +257,8 @@ static char *kdb_read(char *buffer, size_t bufsize)
 			*cp = tmp;
 		}
 		break;
-	case 13: /* enter */
+	case 10: /* linefeed */
+	case 13: /* carriage return */
 		*lastchar++ = '\n';
 		*lastchar++ = '\0';
 		if (!KDB_STATE(KGDB_TRANS)) {
-- 
2.41.0.162.gfafddb0af9-goog

