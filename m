Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8674E610353
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 22:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237183AbiJ0UuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 16:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237134AbiJ0Usd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 16:48:33 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6832BE7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 13:44:41 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id l32so1794564wms.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 13:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RiUzQY/KDOVQ9OpO7U/pjYWKIDHSHLqGcD95KlhxZRE=;
        b=cCJ7TNvnRDYM8NVUP7gAR+/UvYLpXy8bhDJB+F+2c8SxLYPWwFOnMqWyvzrsKBRWpQ
         ajD1KUi0H+UQIQoXweFZ/g15baxLVxe4QfNJb6/H/tXRZG58x4/sBcbvyRG6ybVtNDML
         wWqZtw2qn4XaaIuF9XrEVliJk45Bt4zRrarh4SANuJ9Crg7J43ztNsCgbhL8jybg0mK4
         ZzBV+Juh41FLKorJDTRfqJ+iG37yhhn6+e5kVOnIXLOUBZPsYOpS3MhSexqo6gNFfBns
         MrGXZKGtAN7LZPMLWD7mnqp4AfcuNTl7XcvG9jriee5qhAzfNIE087AgyACP56GUT4Pm
         1QUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RiUzQY/KDOVQ9OpO7U/pjYWKIDHSHLqGcD95KlhxZRE=;
        b=q5Vtg2Tl5+8nLXBbrFBeKjXC7tyIJMmI+phYpsEamKkQvEQoUtVWMIb0D8JAhi4cf1
         T7euP7F6htOOtMdlJ0lLJw/WUqgZ8HxmKkf4NMRbBG/LLREsR5/5ez10RElvHNQTr5RO
         1qSCvT8H4utAKvjMQHS0tlKQ2YYOaqIdpIhxUkoCjnb/GaSo6B/VhLcINtqANKtCjoLe
         sk33zdadgDPUiU5emmAbBy+6W0lm6a5oIsAOTQNSs6x+38pye3SETp6U8YWSepbniFSL
         HhK9+xJ63VvAlqP/l4lqiqCRuoNI8+0+JByDSdm5zDRFDchjhCOSvk4Vl3CURBaeLUKv
         9FCw==
X-Gm-Message-State: ACrzQf07Gnt9Qr8Jmaq7eDDLYwUCqfMSEJXH2JL2k8g52RyH71S2lkok
        hNeK71gvZjZo7mQGGE19jJM2rZKqX2WKFW/6
X-Google-Smtp-Source: AMsMyM5Hav1UL9exmQ7gJ56RA3Xu8SsGKY9DmS/6nfnlhg3pgZgYwcgV0syDrqZl7lrauKdTco6LZQ==
X-Received: by 2002:a05:600c:5127:b0:3c6:47ff:5d33 with SMTP id o39-20020a05600c512700b003c647ff5d33mr7500384wms.68.1666903480665;
        Thu, 27 Oct 2022 13:44:40 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id n3-20020a5d6b83000000b00236644228besm1968739wrx.40.2022.10.27.13.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 13:44:40 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org, David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>
Cc:     Dmitry Safonov <dima@arista.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Bob Gilligan <gilligan@arista.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Francesco Ruggeri <fruggeri@arista.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ivan Delalande <colona@arista.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Leonard Crestez <cdleonard@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Salam Noureddine <noureddine@arista.com>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: [PATCH v3 30/36] selftest/tcp-ao: Add test for TCP-AO add setsockopt() command
Date:   Thu, 27 Oct 2022 21:43:41 +0100
Message-Id: <20221027204347.529913-31-dima@arista.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221027204347.529913-1-dima@arista.com>
References: <20221027204347.529913-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Verify corner-cases for UAPI.
Sample output:
> # ./setsockopt-closed_ipv6
> 1..16
> # 9508[lib/setup.c:173] rand seed 1643819055
> TAP version 13
> ok 1 minimum size
> ok 2 extended size
> ok 3 bad algo
> ok 4 bad ao flags
> ok 5 empty prefix
> ok 6 prefix, any addr
> ok 7 no prefix, any addr
> ok 8 too short prefix
> ok 9 too big prefix
> ok 10 too big maclen
> ok 11 bad key flags
> ok 12 too big keylen
> not ok 13 duplicate: full copy: setsockopt() was expected to fail with 17
> ok 14 duplicate: any addr key on the socket
> ok 15 duplicate: add any addr key
> not ok 16 duplicate: add any addr for the same subnet: setsockopt() was expected to fail with 17

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/net/tcp_ao/Makefile   |   3 +-
 .../selftests/net/tcp_ao/setsockopt-closed.c  | 191 ++++++++++++++++++
 2 files changed, 193 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/net/tcp_ao/setsockopt-closed.c

diff --git a/tools/testing/selftests/net/tcp_ao/Makefile b/tools/testing/selftests/net/tcp_ao/Makefile
index 5064e34ebe38..a001dc2aed4e 100644
--- a/tools/testing/selftests/net/tcp_ao/Makefile
+++ b/tools/testing/selftests/net/tcp_ao/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
-TEST_BOTH_AF := connect icmps-discard icmps-accept connect-deny
+TEST_BOTH_AF := connect icmps-discard icmps-accept connect-deny \
+		setsockopt-closed
 
 TEST_IPV4_PROGS := $(TEST_BOTH_AF:%=%_ipv4)
 TEST_IPV6_PROGS := $(TEST_BOTH_AF:%=%_ipv6)
diff --git a/tools/testing/selftests/net/tcp_ao/setsockopt-closed.c b/tools/testing/selftests/net/tcp_ao/setsockopt-closed.c
new file mode 100644
index 000000000000..be2cbc407f60
--- /dev/null
+++ b/tools/testing/selftests/net/tcp_ao/setsockopt-closed.c
@@ -0,0 +1,191 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Author: Dmitry Safonov <dima@arista.com> */
+#include <inttypes.h>
+#include "../../../../include/linux/kernel.h"
+#include "aolib.h"
+
+static void clean_ao(int sk, struct tcp_ao *ao)
+{
+	struct tcp_ao_del ao_del = {};
+
+	ao_del.tcpa_sndid = ao->tcpa_sndid;
+	ao_del.tcpa_rcvid = ao->tcpa_rcvid;
+	ao_del.tcpa_prefix = ao->tcpa_prefix;
+	memcpy(&ao_del.tcpa_addr, &ao->tcpa_addr, sizeof(ao->tcpa_addr));
+
+	if (setsockopt(sk, IPPROTO_TCP, TCP_AO_DEL, &ao_del, sizeof(ao_del)))
+		test_error("setsockopt(TCP_AO_DEL) failed to clean");
+	close(sk);
+}
+
+static void setsockopt_checked(int sk, int optname, struct tcp_ao *ao,
+			       int err, const char *tst)
+{
+	int ret;
+
+	errno = 0;
+	ret = setsockopt(sk, IPPROTO_TCP, optname, ao, sizeof(*ao));
+	if (ret == -1) {
+		if (errno == err) {
+			test_ok("%s", tst);
+			return;
+		}
+		test_fail("%s: setsockopt() returned %d", tst, err);
+		return;
+	}
+
+	if (err) {
+		test_fail("%s: setsockopt() was expected to fail with %d", tst, err);
+	} else {
+		test_ok("%s", tst);
+		test_verify_socket_ao(sk, ao);
+	}
+	clean_ao(sk, ao);
+}
+
+static int prepare_defs(struct tcp_ao *ao)
+{
+	int sk = socket(test_family, SOCK_STREAM, IPPROTO_TCP);
+
+	if (sk < 0)
+		test_error("socket()");
+
+	if (test_prepare_def_ao(ao, "password", 0, this_ip_dest, -1, 100, 100))
+		test_error("prepare default tcp_ao");
+
+	return sk;
+}
+
+static void test_extend(void)
+{
+	struct tcp_ao ao;
+	struct {
+		struct tcp_ao ao;
+		char *extend[100];
+	} ao_big = {};
+	int ret, sk;
+
+	sk = prepare_defs(&ao);
+	errno = 0;
+	ret = setsockopt(sk, IPPROTO_TCP, TCP_AO,
+			&ao, offsetof(struct tcp_ao, tcpa_key));
+	if (!ret) {
+		test_fail("minminum size: accepted invalid size");
+		clean_ao(sk, &ao);
+	} else if (errno != EINVAL) {
+		test_fail("minminum size: failed with %d", errno);
+	} else {
+		test_ok("minimum size");
+	}
+
+	sk = prepare_defs(&ao_big.ao);
+	errno = 0;
+	ret = setsockopt(sk, IPPROTO_TCP, TCP_AO, &ao_big.ao, sizeof(ao_big));
+	if (ret) {
+		test_fail("extended size: returned %d", ret);
+	} else {
+		test_ok("extended size");
+		clean_ao(sk, &ao_big.ao);
+	}
+}
+
+static void einval_tests(void)
+{
+	struct tcp_ao ao;
+	int sk;
+
+	sk = prepare_defs(&ao);
+	strcpy(ao.tcpa_alg_name, "imaginary hash algo");
+	setsockopt_checked(sk, TCP_AO, &ao, ENOENT, "bad algo");
+
+	sk = prepare_defs(&ao);
+	ao.tcpa_flags = (uint16_t)(-1);
+	setsockopt_checked(sk, TCP_AO, &ao, EINVAL, "bad ao flags");
+
+	sk = prepare_defs(&ao);
+	ao.tcpa_prefix = 0;
+	setsockopt_checked(sk, TCP_AO, &ao, EINVAL, "empty prefix");
+
+	sk = prepare_defs(&ao);
+	ao.tcpa_prefix = 32;
+	memcpy(&ao.tcpa_addr, &SOCKADDR_ANY, sizeof(SOCKADDR_ANY));
+	setsockopt_checked(sk, TCP_AO, &ao, EINVAL, "prefix, any addr");
+
+	sk = prepare_defs(&ao);
+	ao.tcpa_prefix = 0;
+	memcpy(&ao.tcpa_addr, &SOCKADDR_ANY, sizeof(SOCKADDR_ANY));
+	setsockopt_checked(sk, TCP_AO, &ao, 0, "no prefix, any addr");
+
+	sk = prepare_defs(&ao);
+	ao.tcpa_prefix = 2;
+	setsockopt_checked(sk, TCP_AO, &ao, EINVAL, "too short prefix");
+
+	sk = prepare_defs(&ao);
+	ao.tcpa_prefix = 129;
+	setsockopt_checked(sk, TCP_AO, &ao, EINVAL, "too big prefix");
+
+	sk = prepare_defs(&ao);
+	ao.tcpa_maclen = 100;
+	setsockopt_checked(sk, TCP_AO, &ao, EMSGSIZE, "too big maclen");
+
+	sk = prepare_defs(&ao);
+	ao.tcpa_keyflags = (uint8_t)(-1);
+	setsockopt_checked(sk, TCP_AO, &ao, EINVAL, "bad key flags");
+
+	sk = prepare_defs(&ao);
+	ao.tcpa_keylen = TCP_AO_MAXKEYLEN + 1;
+	setsockopt_checked(sk, TCP_AO, &ao, EINVAL, "too big keylen");
+}
+
+static void duplicate_tests(void)
+{
+	union tcp_addr network_dup;
+	struct tcp_ao ao, ao2;
+	int sk;
+
+	sk = prepare_defs(&ao);
+	if (setsockopt(sk, IPPROTO_TCP, TCP_AO, &ao, sizeof(ao)))
+		test_error("setsockopt()");
+	setsockopt_checked(sk, TCP_AO, &ao, EEXIST, "duplicate: full copy");
+
+	sk = prepare_defs(&ao);
+	ao2 = ao;
+	memcpy(&ao2.tcpa_addr, &SOCKADDR_ANY, sizeof(SOCKADDR_ANY));
+	ao2.tcpa_prefix = 0;
+	if (setsockopt(sk, IPPROTO_TCP, TCP_AO, &ao2, sizeof(ao)))
+		test_error("setsockopt()");
+	setsockopt_checked(sk, TCP_AO, &ao, EEXIST, "duplicate: any addr key on the socket");
+
+	sk = prepare_defs(&ao);
+	if (setsockopt(sk, IPPROTO_TCP, TCP_AO, &ao, sizeof(ao)))
+		test_error("setsockopt()");
+	memcpy(&ao.tcpa_addr, &SOCKADDR_ANY, sizeof(SOCKADDR_ANY));
+	ao.tcpa_prefix = 0;
+	setsockopt_checked(sk, TCP_AO, &ao, EEXIST, "duplicate: add any addr key");
+
+
+	if (inet_pton(TEST_FAMILY, TEST_NETWORK, &network_dup) != 1)
+		test_error("Can't convert ip address %s", TEST_NETWORK);
+	sk = prepare_defs(&ao);
+	if (setsockopt(sk, IPPROTO_TCP, TCP_AO, &ao, sizeof(ao)))
+		test_error("setsockopt()");
+	if (test_prepare_def_ao(&ao, "password", 0, network_dup, 16, 100, 100))
+		test_error("prepare default tcp_ao");
+	setsockopt_checked(sk, TCP_AO, &ao, EEXIST, "duplicate: add any addr for the same subnet");
+}
+
+
+static void *client_fn(void *arg)
+{
+	test_extend();
+	einval_tests();
+	duplicate_tests();
+
+	return NULL;
+}
+
+int main(int argc, char *argv[])
+{
+	test_init(16, client_fn, NULL);
+	return 0;
+}
-- 
2.38.1

