Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7E45E8357
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 22:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbiIWURZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 16:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbiIWUPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 16:15:21 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEEFB133CAF
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 13:14:09 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id y5so1595260wrh.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 13:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ydw55lqdXmkmsbsCcaoEXopsXmkoCfvtM0sMy2xUSwA=;
        b=YkCHZeQWyKK1GpB6F456RiJ7Yb74hD8+IEEfzNx7sb6tQE5rufNOfUp3VKV0KrwxxA
         ujRw5oc6cjVVZfvbGwgafDv+qcWH+U4DYpw5VUQKmx2CGT5KHOiyJmo/v36ZjkFhDLIW
         p/7h9aEx1wgxVrd8no0QqhBrbN5c1vF2Pd4tfS3kyYvJOIkCY3RMHUahawoHy+/8ISyC
         /Lar9mYI9S7wk93vPV4w052rMNpeuNs2KPL+yLzsoHFRSUKT7KDiEttFum/zYG68FTPY
         UZJqEE2kBIZJdKY9fe5wfL0+t8rljDiiRgxRXF75PN7N8tqmucQ/niogM21MxZp7xMjF
         /jvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ydw55lqdXmkmsbsCcaoEXopsXmkoCfvtM0sMy2xUSwA=;
        b=0iTGy/J4422OSqE1+1vWoMuMeFVEzgxCONGw9s/3LRn8XgySd24bvrH1lqEbMXTHi3
         Qwzjq7ghUbBGjSTOlZU52DQom5oKGxQEBhFvdFqVGlIqkcy3dtPuSbMpele74bWrL6hK
         fbQdy9GzVQtjzrxQY+UtnF1E2uG47ysoI5pm3lUI8Lje7X++/VOoTdLKLvq3GLIFWU3x
         mKhkYbGV9X5g5yKR4IRQSVrvGDyRC3SO2sxKrX49oKlBRh/f3EiSh+Hxpl0UwG1Rjdij
         mBbdOdSy888vm1VTDziuS/fOc02hKUmg55zpwAdrUzQC1e4L6DnhQY2ZP5O7B6K0nzs5
         pBeA==
X-Gm-Message-State: ACrzQf3PWodlfkDLUKF/B9Y/wbXtfITp4lwahRhR6i72b2LFb8ZldlxX
        CuShikLwHVFsZzVlP1PQNfp10YSeXwwrVw==
X-Google-Smtp-Source: AMsMyM77TMlMXe9pnmrWRNK0ObdosqljrY6J5sE6o7j/owpmdEkyloX7F9TNss6fYJ+dIVnjq9cALw==
X-Received: by 2002:adf:d206:0:b0:228:64c1:c3fb with SMTP id j6-20020adfd206000000b0022864c1c3fbmr6224078wrh.260.1663964049214;
        Fri, 23 Sep 2022 13:14:09 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id k11-20020a05600c0b4b00b003b492753826sm3281056wmr.43.2022.09.23.13.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 13:14:08 -0700 (PDT)
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
Subject: [PATCH v2 27/35] selftest/net: Add TCP-AO ICMPs accept test
Date:   Fri, 23 Sep 2022 21:13:11 +0100
Message-Id: <20220923201319.493208-28-dima@arista.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220923201319.493208-1-dima@arista.com>
References: <20220923201319.493208-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reverse to icmps-discard test: the server accepts ICMPs, using
TCP_AO_CMDF_ACCEPT_ICMP and it is expected to fail under ICMP
flood from client. Test that the default pre-TCP-AO behaviour functions
when TCP_AO_CMDF_ACCEPT_ICMP is set.

Expected output for ipv4 version (in case it receives ICMP_PROT_UNREACH):
> # ./icmps-accept_ipv4
> 1..3
> # 3209[lib/setup.c:166] rand seed 1642623870
> TAP version 13
> # 3209[lib/proc.c:207]    Snmp6             Ip6InReceives: 0 => 1
> # 3209[lib/proc.c:207]    Snmp6             Ip6InNoRoutes: 0 => 1
> # 3209[lib/proc.c:207]    Snmp6               Ip6InOctets: 0 => 76
> # 3209[lib/proc.c:207]    Snmp6            Ip6InNoECTPkts: 0 => 1
> # 3209[lib/proc.c:207]      Tcp                    InSegs: 3 => 23
> # 3209[lib/proc.c:207]      Tcp                   OutSegs: 2 => 22
> # 3209[lib/proc.c:207]  IcmpMsg                   InType3: 0 => 4
> # 3209[lib/proc.c:207]     Icmp                    InMsgs: 0 => 4
> # 3209[lib/proc.c:207]     Icmp            InDestUnreachs: 0 => 4
> # 3209[lib/proc.c:207]       Ip                InReceives: 3 => 27
> # 3209[lib/proc.c:207]       Ip                InDelivers: 3 => 27
> # 3209[lib/proc.c:207]       Ip               OutRequests: 2 => 22
> # 3209[lib/proc.c:207]    IpExt                  InOctets: 288 => 3420
> # 3209[lib/proc.c:207]    IpExt                 OutOctets: 124 => 3244
> # 3209[lib/proc.c:207]    IpExt               InNoECTPkts: 3 => 25
> # 3209[lib/proc.c:207]   TcpExt               TCPPureAcks: 1 => 2
> # 3209[lib/proc.c:207]   TcpExt           TCPOrigDataSent: 0 => 20
> # 3209[lib/proc.c:207]   TcpExt              TCPDelivered: 0 => 19
> # 3209[lib/proc.c:207]   TcpExt                 TCPAOGood: 3 => 23
> ok 1 InDestUnreachs delivered 4
> ok 2 server failed with -92: Protocol not available
> ok 3 TCPAODroppedIcmps counter didn't change: 0 >= 0
> # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0

Expected output for ipv6 version (in case it receives ADM_PROHIBITED):
> # ./icmps-accept_ipv6
> 1..3
> # 3277[lib/setup.c:166] rand seed 1642624035
> TAP version 13
> # 3277[lib/proc.c:207]    Snmp6             Ip6InReceives: 6 => 31
> # 3277[lib/proc.c:207]    Snmp6             Ip6InDelivers: 4 => 29
> # 3277[lib/proc.c:207]    Snmp6            Ip6OutRequests: 4 => 24
> # 3277[lib/proc.c:207]    Snmp6               Ip6InOctets: 592 => 4492
> # 3277[lib/proc.c:207]    Snmp6              Ip6OutOctets: 332 => 3852
> # 3277[lib/proc.c:207]    Snmp6            Ip6InNoECTPkts: 6 => 31
> # 3277[lib/proc.c:207]    Snmp6               Icmp6InMsgs: 1 => 6
> # 3277[lib/proc.c:207]    Snmp6       Icmp6InDestUnreachs: 0 => 5
> # 3277[lib/proc.c:207]    Snmp6              Icmp6InType1: 0 => 5
> # 3277[lib/proc.c:207]      Tcp                    InSegs: 3 => 23
> # 3277[lib/proc.c:207]      Tcp                   OutSegs: 2 => 22
> # 3277[lib/proc.c:207]   TcpExt               TCPPureAcks: 1 => 2
> # 3277[lib/proc.c:207]   TcpExt           TCPOrigDataSent: 0 => 20
> # 3277[lib/proc.c:207]   TcpExt              TCPDelivered: 0 => 19
> # 3277[lib/proc.c:207]   TcpExt                 TCPAOGood: 3 => 23
> ok 1 Icmp6InDestUnreachs delivered 5
> ok 2 server failed with -13: Permission denied
> ok 3 TCPAODroppedIcmps counter didn't change: 0 >= 0
> # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0

With some luck the server may fail with ECONNREFUSED (depending on what
icmp packet was delivered firstly).
For the kernel error handlers see: tab_unreach[] and icmp_err_convert[].

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/net/tcp_ao/Makefile     |  4 +++-
 .../testing/selftests/net/tcp_ao/icmps-accept.c |  1 +
 .../selftests/net/tcp_ao/icmps-discard.c        | 17 +++++++++++++++--
 3 files changed, 19 insertions(+), 3 deletions(-)
 create mode 120000 tools/testing/selftests/net/tcp_ao/icmps-accept.c

diff --git a/tools/testing/selftests/net/tcp_ao/Makefile b/tools/testing/selftests/net/tcp_ao/Makefile
index 9acfd782c20f..a178bde0af08 100644
--- a/tools/testing/selftests/net/tcp_ao/Makefile
+++ b/tools/testing/selftests/net/tcp_ao/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-TEST_BOTH_AF := connect icmps-discard
+TEST_BOTH_AF := connect icmps-discard icmps-accept
 
 TEST_IPV4_PROGS := $(TEST_BOTH_AF:%=%_ipv4)
 TEST_IPV6_PROGS := $(TEST_BOTH_AF:%=%_ipv6)
@@ -43,3 +43,5 @@ $(OUTPUT)/%_ipv4: %.c
 $(OUTPUT)/%_ipv6: %.c
 	$(LINK.c) -DIPV6_TEST $^ $(LDLIBS) -o $@
 
+$(OUTPUT)/icmps-accept_ipv4: CFLAGS+= -DTEST_ICMPS_ACCEPT
+$(OUTPUT)/icmps-accept_ipv6: CFLAGS+= -DTEST_ICMPS_ACCEPT
diff --git a/tools/testing/selftests/net/tcp_ao/icmps-accept.c b/tools/testing/selftests/net/tcp_ao/icmps-accept.c
new file mode 120000
index 000000000000..0a5bb85eb260
--- /dev/null
+++ b/tools/testing/selftests/net/tcp_ao/icmps-accept.c
@@ -0,0 +1 @@
+icmps-discard.c
\ No newline at end of file
diff --git a/tools/testing/selftests/net/tcp_ao/icmps-discard.c b/tools/testing/selftests/net/tcp_ao/icmps-discard.c
index 16d691809567..143571277548 100644
--- a/tools/testing/selftests/net/tcp_ao/icmps-discard.c
+++ b/tools/testing/selftests/net/tcp_ao/icmps-discard.c
@@ -43,8 +43,17 @@ const int sk_ip_level	= SOL_IP;
 const int sk_recverr	= IP_RECVERR;
 #endif
 
-#define test_icmps_fail test_fail
-#define test_icmps_ok test_ok
+/*
+ * Server is expected to fail with hard error if
+ * TCP_AO_CMDF_ACCEPT_ICMP is set
+ */
+#ifdef TEST_ICMPS_ACCEPT
+# define test_icmps_fail test_ok
+# define test_icmps_ok test_fail
+#else
+# define test_icmps_fail test_fail
+# define test_icmps_ok test_ok
+#endif
 
 static void serve_interfered(int sk)
 {
@@ -100,6 +109,10 @@ static void *server_fn(void *arg)
 
 	lsk = test_listen_socket(this_ip_addr, test_server_port, 1);
 
+#ifdef TEST_ICMPS_ACCEPT
+	flags = TCP_AO_CMDF_ACCEPT_ICMP;
+#endif
+
 	if (test_set_ao(lsk, "password", flags, this_ip_dest, -1, 100, 100))
 		test_error("setsockopt(TCP_AO)");
 	synchronize_threads();
-- 
2.37.2

