Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A0167ED47
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 19:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235095AbjA0SSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 13:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235258AbjA0SSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 13:18:04 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04C68015A
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 10:17:41 -0800 (PST)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id AB79A3F51A
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 18:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1674843401;
        bh=NS1tmL66awX/7is5ZjMX3UkQ9Ca2dXMZqnsizI2is20=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=ptrMIMhp2EfBm9ahy7KdQzy6yG2xk4XEze/IxYUv/QvJnNAVa0IF9z0CYP/46pcCp
         uZBkYcceeaQW8qVlOgbwZbDI+oud6z4UD7Qt8ctjDhdEMjkJ+xGeN2dnVo40V9Th3d
         fXDrignwZMbKAS+iJOueuoFwZLhTrTTm/ZQRlEKhLA3FjBbxAL4lPRQxe+yPJkMTT3
         pEz7Ksjj/CIdJv0NV076c+VWUZ1Pq4kcWOywa/qlf3hAV1liZGNuFsDjPXOmj+kCUD
         T9yQPHIhq2hEyPIMjeljhC5ASdRm/GDgKbanl5BTOs0Uid7JdeJ03+lmBYxvzyPFp3
         2QIr2jpFSqWQA==
Received: by mail-wm1-f72.google.com with SMTP id m10-20020a05600c3b0a00b003dafe7451deso3183871wms.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 10:16:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NS1tmL66awX/7is5ZjMX3UkQ9Ca2dXMZqnsizI2is20=;
        b=VgpUTtRUdw5feEL5i1BlQPW9PZUXpbcVrzW8X3t5G0DLTLW72NTLlD9W+QjW/Kxyn4
         Lu8wfHEvq4l2tHHYQ/SKFg15bUfisyNWlwr0BiWi2OjXOlA4clkckGe/HnKL/inqpLY/
         c4AoqqAspC8kg/Fbw8JN3NYpJAzxtyngFGmYwQUYdjkKUVtdTmYBIHkGEDSTsFzIPxS4
         R/m7S+ILR56HM06Wqsh5378UU+K10r43jo3k1sP/NDmku4wQImb0kYNoL3JeiOQPueH1
         4G9APLT/R5dgT2Fw9opDqgRxfPfGfT5fGjlRWpATkjxfAUtcX9CwbyIhJpiA9gKdL/QK
         n1ig==
X-Gm-Message-State: AFqh2kraUYOhY0DnbW9pCLqNJY+9JkWq1dZv0dsPLm0M1gxG3oIIf7er
        EdW+H/D8c7Pe8GGeh+teihLELLdfnAEPor09W9rUTud0RsIoXlM9z9RPaUEHq73tlfg6w/vFdQS
        7fD8jNzONVIpoT+/XLEBVRFPUHoFQKzB6GU18tc6E9A==
X-Received: by 2002:adf:ce06:0:b0:2bf:95cc:744c with SMTP id p6-20020adfce06000000b002bf95cc744cmr22921795wrn.0.1674843401387;
        Fri, 27 Jan 2023 10:16:41 -0800 (PST)
X-Google-Smtp-Source: AMrXdXs81PzIVwkImeU01Xj6gNTWRhY8/AaM+bmQlNIMb3W6rmGJizQ7t8D6RRx8NOndZeC5qb9/ug==
X-Received: by 2002:adf:ce06:0:b0:2bf:95cc:744c with SMTP id p6-20020adfce06000000b002bf95cc744cmr22921787wrn.0.1674843401196;
        Fri, 27 Jan 2023 10:16:41 -0800 (PST)
Received: from qwirkle.internal ([81.2.157.149])
        by smtp.gmail.com with ESMTPSA id a18-20020adffad2000000b002be53aa2260sm5122798wrs.117.2023.01.27.10.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 10:16:40 -0800 (PST)
From:   Andrei Gherzan <andrei.gherzan@canonical.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Willem de Bruijn <willemb@google.com>
Cc:     Andrei Gherzan <andrei.gherzan@canonical.com>,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: net: udpgso_bench_tx: Introduce exponential back-off retries
Date:   Fri, 27 Jan 2023 18:16:25 +0000
Message-Id: <20230127181625.286546-1-andrei.gherzan@canonical.com>
X-Mailer: git-send-email 2.34.1
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

The tx and rx test programs are used in a couple of test scripts including
"udpgro_bench.sh". Taking this as an example, when the rx/tx programs
are invoked subsequently, there is a chance that the rx one is not ready to
accept socket connections. This racing bug could fail the test with at
least one of the following:

./udpgso_bench_tx: connect: Connection refused
./udpgso_bench_tx: sendmsg: Connection refused
./udpgso_bench_tx: write: Connection refused

This change addresses this by adding routines that retry the socket
operations with an exponential back off algorithm from 100ms to 2s.

Fixes: 3a687bef148d ("selftests: udp gso benchmark")
Signed-off-by: Andrei Gherzan <andrei.gherzan@canonical.com>
---
 tools/testing/selftests/net/udpgso_bench_tx.c | 57 +++++++++++++------
 1 file changed, 41 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/net/udpgso_bench_tx.c b/tools/testing/selftests/net/udpgso_bench_tx.c
index f1fdaa270291..4dea9ee7eb46 100644
--- a/tools/testing/selftests/net/udpgso_bench_tx.c
+++ b/tools/testing/selftests/net/udpgso_bench_tx.c
@@ -53,6 +53,9 @@
 
 #define NUM_PKT		100
 
+#define MAX_DELAY	2000000
+#define INIT_DELAY	100000
+
 static bool	cfg_cache_trash;
 static int	cfg_cpu		= -1;
 static int	cfg_connected	= true;
@@ -257,13 +260,18 @@ static void flush_errqueue(int fd, const bool do_poll)
 static int send_tcp(int fd, char *data)
 {
 	int ret, done = 0, count = 0;
+	useconds_t delay = INIT_DELAY;
 
 	while (done < cfg_payload_len) {
-		ret = send(fd, data + done, cfg_payload_len - done,
-			   cfg_zerocopy ? MSG_ZEROCOPY : 0);
-		if (ret == -1)
-			error(1, errno, "write");
-
+		delay = INIT_DELAY;
+		while ((ret = send(fd, data + done, cfg_payload_len - done,
+				cfg_zerocopy ? MSG_ZEROCOPY : 0)) == -1) {
+			usleep(delay);
+			if (delay < MAX_DELAY)
+				delay *= 2;
+			else
+				error(1, errno, "write");
+		}
 		done += ret;
 		count++;
 	}
@@ -274,17 +282,23 @@ static int send_tcp(int fd, char *data)
 static int send_udp(int fd, char *data)
 {
 	int ret, total_len, len, count = 0;
+	useconds_t delay = INIT_DELAY;
 
 	total_len = cfg_payload_len;
 
 	while (total_len) {
 		len = total_len < cfg_mss ? total_len : cfg_mss;
 
-		ret = sendto(fd, data, len, cfg_zerocopy ? MSG_ZEROCOPY : 0,
-			     cfg_connected ? NULL : (void *)&cfg_dst_addr,
-			     cfg_connected ? 0 : cfg_alen);
-		if (ret == -1)
-			error(1, errno, "write");
+		delay = INIT_DELAY;
+		while ((ret = sendto(fd, data, len, cfg_zerocopy ? MSG_ZEROCOPY : 0,
+				cfg_connected ? NULL : (void *)&cfg_dst_addr,
+				cfg_connected ? 0 : cfg_alen)) == -1) {
+			usleep(delay);
+			if (delay < MAX_DELAY)
+				delay *= 2;
+			else
+				error(1, errno, "write");
+		}
 		if (ret != len)
 			error(1, errno, "write: %uB != %uB\n", ret, len);
 
@@ -378,6 +392,7 @@ static int send_udp_segment(int fd, char *data)
 	struct iovec iov = {0};
 	size_t msg_controllen;
 	struct cmsghdr *cmsg;
+	useconds_t delay = INIT_DELAY;
 	int ret;
 
 	iov.iov_base = data;
@@ -401,9 +416,13 @@ static int send_udp_segment(int fd, char *data)
 	msg.msg_name = (void *)&cfg_dst_addr;
 	msg.msg_namelen = cfg_alen;
 
-	ret = sendmsg(fd, &msg, cfg_zerocopy ? MSG_ZEROCOPY : 0);
-	if (ret == -1)
-		error(1, errno, "sendmsg");
+	while ((ret = sendmsg(fd, &msg, cfg_zerocopy ? MSG_ZEROCOPY : 0)) == -1) {
+		usleep(delay);
+		if (delay < MAX_DELAY)
+			delay *= 2;
+		else
+			error(1, errno, "sendmsg");
+	}
 	if (ret != iov.iov_len)
 		error(1, 0, "sendmsg: %u != %llu\n", ret,
 			(unsigned long long)iov.iov_len);
@@ -616,6 +635,7 @@ int main(int argc, char **argv)
 {
 	unsigned long num_msgs, num_sends;
 	unsigned long tnow, treport, tstop;
+	useconds_t delay = INIT_DELAY;
 	int fd, i, val, ret;
 
 	parse_opts(argc, argv);
@@ -648,9 +668,14 @@ int main(int argc, char **argv)
 		}
 	}
 
-	if (cfg_connected &&
-	    connect(fd, (void *)&cfg_dst_addr, cfg_alen))
-		error(1, errno, "connect");
+	if (cfg_connected)
+		while (connect(fd, (void *)&cfg_dst_addr, cfg_alen)) {
+			usleep(delay);
+			if (delay < MAX_DELAY)
+				delay *= 2;
+			else
+				error(1, errno, "connect");
+		}
 
 	if (cfg_segment)
 		set_pmtu_discover(fd, cfg_family == PF_INET);
-- 
2.34.1

