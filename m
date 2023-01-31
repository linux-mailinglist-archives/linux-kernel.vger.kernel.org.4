Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C558B682D4D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbjAaNGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:06:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbjAaNF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:05:58 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7C41164B
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 05:05:44 -0800 (PST)
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5D6F044217
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 13:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1675170342;
        bh=wLRgJ2g3xT7I9yLnLnLzzOK8LNCx5zIY7gjodxJIDxM=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=P8JXC72wt33u/UceY8dTXheM7xelfqxyXpUK/EYECZy+rTXj4TLN0Ozgi3fdhrmaw
         FztmCBIWDoAnNE2dThy9gKKa7lpEaZ9WZvlUeDO+JEAL8WZPHQjy+JfeK46wHWWQ/3
         4ya+D38Km9B6x/YikZicKkTd0t4pEUWou8oJ1wv0g7GFqGCyOUekCsc685GXABoo0E
         eu2L6IaWRm9wM2up17lCWPuTIKIDdTcZmRadiRd5UfBhQaMzDk6EfcPHWuUmDswV2A
         AWjNWPYA3AVPUavz5/r3eYFvPxVsm8h0LGnSLteFi+vld+NkQWcpRYFoy0NMilOYBK
         MJALVcBH0/qNw==
Received: by mail-wr1-f70.google.com with SMTP id i9-20020a0560001ac900b002bfda39265aso1569683wry.13
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 05:05:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wLRgJ2g3xT7I9yLnLnLzzOK8LNCx5zIY7gjodxJIDxM=;
        b=WKB7We4bzw4PtURY0hrqJihMMYQH+qZFQpIiwfxDH7L/lRH1f0Bhc2HjPGDacO4xs7
         2SpemHMbuZtR79VB8lde1EDzfnhRJyrrtdUNeXlZP7Raf8qcny4EUnUIQ3oIJHf/3wZE
         CJ3svHTkuOu2ozBU8v+fYgxwxS43IVekQJkMl4jALWktOWI28I9rlKN/XyxxDGnZa64i
         EODVJ6U0lRbxyzYYOy0sauIPRUzMaKJGWn56RdoNxjfzy7Mcv4uzhF7R0SeOEBwMkxHb
         bpIih9nRj6dTciL0SvrM59kU2ETDP8FaeaDjgeol3FpnaInGvUbb9vMOASGDvqfQdEBF
         dneA==
X-Gm-Message-State: AO0yUKWCDzS4SGZz6GCkRSaxBJNxhgo6W/fQEW6dnXNMuU/jV9BN8nos
        gAuzYDMC8wv7n+ShgVFYrkxjVoxgRwd80aBRVrUgKt0c1ju/h46x3yiFOq5Plq+F3p4A9Kh4jgC
        3++YqhCMciUPkS+AfXYkpO4i9Vno4UkmfVfF3wmqH/w==
X-Received: by 2002:a5d:4650:0:b0:2c3:6a8b:2cec with SMTP id j16-20020a5d4650000000b002c36a8b2cecmr112499wrs.60.1675170339384;
        Tue, 31 Jan 2023 05:05:39 -0800 (PST)
X-Google-Smtp-Source: AK7set/akIjMwFjtuH5Lbc7zxow/+PDAFODmUjLu7C6rpySt8f3yNU6mZDxAvz/bS+Ahd90c23ovow==
X-Received: by 2002:a5d:4650:0:b0:2c3:6a8b:2cec with SMTP id j16-20020a5d4650000000b002c36a8b2cecmr112452wrs.60.1675170338732;
        Tue, 31 Jan 2023 05:05:38 -0800 (PST)
Received: from localhost.localdomain ([2001:67c:1560:8007::aac:c4dd])
        by smtp.gmail.com with ESMTPSA id f6-20020a5d50c6000000b002bfc24e1c55sm14741436wrt.78.2023.01.31.05.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 05:05:38 -0800 (PST)
From:   Andrei Gherzan <andrei.gherzan@canonical.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc:     Andrei Gherzan <andrei.gherzan@canonical.com>,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] selftests: net: udpgso_bench_tx: Cater for pending datagrams zerocopy benchmarking
Date:   Tue, 31 Jan 2023 13:04:12 +0000
Message-Id: <20230131130412.432549-4-andrei.gherzan@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230131130412.432549-1-andrei.gherzan@canonical.com>
References: <20230131130412.432549-1-andrei.gherzan@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The test tool can check that the zerocopy number of completions value is
valid taking into consideration the number of datagram send calls. This can
catch the system into a state where the datagrams are still in the system
(for example in a qdisk, waiting for the network interface to return a
completion notification, etc).

This change adds a retry logic of computing the number of completions up to
a configurable (via CLI) timeout (default: 2 seconds).

Signed-off-by: Andrei Gherzan <andrei.gherzan@canonical.com>
---
 tools/testing/selftests/net/udpgso_bench_tx.c | 38 +++++++++++++++----
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/udpgso_bench_tx.c b/tools/testing/selftests/net/udpgso_bench_tx.c
index b47b5c32039f..5a29b5f24023 100644
--- a/tools/testing/selftests/net/udpgso_bench_tx.c
+++ b/tools/testing/selftests/net/udpgso_bench_tx.c
@@ -62,6 +62,7 @@ static int	cfg_payload_len	= (1472 * 42);
 static int	cfg_port	= 8000;
 static int	cfg_runtime_ms	= -1;
 static bool	cfg_poll;
+static int	cfg_poll_loop_timeout_ms = 2000;
 static bool	cfg_segment;
 static bool	cfg_sendmmsg;
 static bool	cfg_tcp;
@@ -235,16 +236,17 @@ static void flush_errqueue_recv(int fd)
 	}
 }
 
-static void flush_errqueue(int fd, const bool do_poll)
+static void flush_errqueue(int fd, const bool do_poll,
+		unsigned long poll_timeout, const bool poll_err)
 {
 	if (do_poll) {
 		struct pollfd fds = {0};
 		int ret;
 
 		fds.fd = fd;
-		ret = poll(&fds, 1, 500);
+		ret = poll(&fds, 1, poll_timeout);
 		if (ret == 0) {
-			if (cfg_verbose)
+			if ((cfg_verbose) && (poll_err))
 				fprintf(stderr, "poll timeout\n");
 		} else if (ret < 0) {
 			error(1, errno, "poll");
@@ -254,6 +256,22 @@ static void flush_errqueue(int fd, const bool do_poll)
 	flush_errqueue_recv(fd);
 }
 
+static void flush_errqueue_retry(int fd, const bool do_poll, unsigned long num_sends)
+{
+	unsigned long tnow, tstop;
+	bool first_try = true;
+
+	tnow = gettimeofday_ms();
+	tstop = tnow + cfg_poll_loop_timeout_ms;
+	do {
+		flush_errqueue(fd, do_poll, tstop - tnow, first_try);
+		first_try = false;
+		if (!do_poll)
+			usleep(1000);  // a throttling delay if polling is enabled
+		tnow = gettimeofday_ms();
+	} while ((stat_zcopies != num_sends) && (tnow < tstop));
+}
+
 static int send_tcp(int fd, char *data)
 {
 	int ret, done = 0, count = 0;
@@ -413,8 +431,9 @@ static int send_udp_segment(int fd, char *data)
 
 static void usage(const char *filepath)
 {
-	error(1, 0, "Usage: %s [-46acmHPtTuvz] [-C cpu] [-D dst ip] [-l secs] [-M messagenr] [-p port] [-s sendsize] [-S gsosize]",
-		    filepath);
+	error(1, 0,
+			"Usage: %s [-46acmHPtTuvz] [-C cpu] [-D dst ip] [-l secs] [-L secs] [-M messagenr] [-p port] [-s sendsize] [-S gsosize]",
+			filepath);
 }
 
 static void parse_opts(int argc, char **argv)
@@ -423,7 +442,7 @@ static void parse_opts(int argc, char **argv)
 	int max_len, hdrlen;
 	int c;
 
-	while ((c = getopt(argc, argv, "46acC:D:Hl:mM:p:s:PS:tTuvz")) != -1) {
+	while ((c = getopt(argc, argv, "46acC:D:Hl:L:mM:p:s:PS:tTuvz")) != -1) {
 		switch (c) {
 		case '4':
 			if (cfg_family != PF_UNSPEC)
@@ -452,6 +471,9 @@ static void parse_opts(int argc, char **argv)
 		case 'l':
 			cfg_runtime_ms = strtoul(optarg, NULL, 10) * 1000;
 			break;
+		case 'L':
+			cfg_poll_loop_timeout_ms = strtoul(optarg, NULL, 10) * 1000;
+			break;
 		case 'm':
 			cfg_sendmmsg = true;
 			break;
@@ -679,7 +701,7 @@ int main(int argc, char **argv)
 			num_sends += send_udp(fd, buf[i]);
 		num_msgs++;
 		if ((cfg_zerocopy && ((num_msgs & 0xF) == 0)) || cfg_tx_tstamp)
-			flush_errqueue(fd, cfg_poll);
+			flush_errqueue(fd, cfg_poll, 500, true);
 
 		if (cfg_msg_nr && num_msgs >= cfg_msg_nr)
 			break;
@@ -698,7 +720,7 @@ int main(int argc, char **argv)
 	} while (!interrupted && (cfg_runtime_ms == -1 || tnow < tstop));
 
 	if (cfg_zerocopy || cfg_tx_tstamp)
-		flush_errqueue(fd, true);
+		flush_errqueue_retry(fd, true, num_sends);
 
 	if (close(fd))
 		error(1, errno, "close");
-- 
2.34.1

