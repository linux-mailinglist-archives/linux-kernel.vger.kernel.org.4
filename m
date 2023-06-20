Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3757B737194
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 18:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbjFTQat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 12:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjFTQaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 12:30:35 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1764F171B
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 09:30:34 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f8792d2e86so1888411e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 09:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687278632; x=1689870632;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cw8TzJlxypWM9F2CnTaH65ECFFJEZ73AOXC4Ef09ORA=;
        b=QcAMgkg8/jg7Gy8GFpuSNkXkN+MJwhSVyJbLQ8QwajO+7hXdCKYEDpx50cPyheT/Tg
         AMmkUKfuDDpuHWqQRYGjFEG67Apn67LgvsmU8IrpXJUZhEg5UYuC19aeePyVqjmTNKWm
         B/Y0NgHPpkhjbiY1m0ST2LLBB3yntYBWO6MvF6rLBQ7J8AaW8uZHuZuDtsPUsr168j9o
         OTx1Ic6ajJdPdHWYOeBAHTLMPbuhIZdQG/rlbHQKOedyivOTZF9x/x/TgG3SlTw9ULrL
         Lr3MW1WBMbLDd9OcqUrtyttN9IS4dA18XSEMKacaSQ9EmNa79W2MKEkN8h/Hv+nQ3rZH
         1P9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687278632; x=1689870632;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cw8TzJlxypWM9F2CnTaH65ECFFJEZ73AOXC4Ef09ORA=;
        b=EWxxS2cY/NT9cMJg4i5ec94HN6VmxqGwJs3XXok1ozHzuajsOt/9eqfXCt7P30VMNv
         M07pMsfDkEU4NGipefYPpuG7qgVsGrZ4cMM5oAGZUTsQBAOYqtb7WqCZuVGEegDFOkZy
         FtD4Sx+g6y7dkshZ4lYMrPi29SGFcuYY+L2cLTCHz1MzrAdl/mrw/HTv2MA8OzRZcSoM
         codEIa3SAti6eJ+H0GAgQUc8e6NwOE8662+vFIs+oni4JyfNGdFOO/6NA6nV3YUFrODH
         YuJfRnP0Te4iDTNb0ig/bpoX6WxbFOJ7HMOcD4ZPmNSu810gxi7qH3hlA2tCcl7cQUwq
         FNeQ==
X-Gm-Message-State: AC+VfDw8K08u/iPIjDPRw7xnYEY4dl+q2zKtCv1PbliAk15TTi8CimsO
        S4yOZKkyVnGCS2ZDiwnyQMcnRA==
X-Google-Smtp-Source: ACHHUZ7SsG4GMmxgaGwM6m5wdeDwFVzuPmg5kzenOkvT95GYOUJB11czfQhig7z+1rQOOrASE58kpg==
X-Received: by 2002:a19:790a:0:b0:4f8:4aee:1fac with SMTP id u10-20020a19790a000000b004f84aee1facmr6705566lfc.66.1687278632308;
        Tue, 20 Jun 2023 09:30:32 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id y7-20020a05600c364700b003f8fbe3bf7asm12064342wmq.32.2023.06.20.09.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 09:30:32 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Tue, 20 Jun 2023 18:30:16 +0200
Subject: [PATCH net-next 3/9] selftests: mptcp: explicitly tests aggregate
 counters
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-upstream-net-next-20230620-mptcp-expose-more-info-and-misc-v1-3-62b9444bfd48@tessares.net>
References: <20230620-upstream-net-next-20230620-mptcp-expose-more-info-and-misc-v1-0-62b9444bfd48@tessares.net>
In-Reply-To: <20230620-upstream-net-next-20230620-mptcp-expose-more-info-and-misc-v1-0-62b9444bfd48@tessares.net>
To:     mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2670;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=awLfDurrvmULc5mmvI7zYCGtlKgibsGn03vwIgEXgPU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkkdQkNw66cmfj8X9pRKxH2KmDjBcVKt+1v/+/V
 8wgWjbyPeaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZJHUJAAKCRD2t4JPQmmg
 c5T9EACORdoVd2YO2KSq2pVhigyD8nklAEeomq+4ClUtAKDlmsWepku3TDU9HUdfKZY3+/xS9Gd
 6TsIuSyaCUZoXB7GsxfWVhEjHYN7DWRv8SQVUvZSKh3KyGs3WhmgCEnAziBwjYngtN1HGoZe1fS
 SANm+lOtfC/dHW30zTYJ05s7MOzI/yTikjcfLcA8qTmmz8GQtCGnXJSQXpU6TknWpadRhQhJQdO
 y5/a9MzHzrFDNG5bWkKDWAzuRyHnvUlpdB+kao1OOddIZy7LVrpOMIs3AhDhvxXqTtU3HWiK2E3
 GXp0JhCseKSp4+qHIumE8c4X4cfddOpmK2z2TKCTA8R64C2NfjKVlkggJuhEiTLGxBqEm+erTip
 7YQ8Z0inrZXSXIvQbf5EPn/UlKM0Nr88ZjwtZ2iiuMtSI9Sje2RIQUEwQ1nP7c2IkWog5M5zcYR
 vRnjN+RbLDI7Al11wflb55k+svnaXeDp7MtmxSS5Xz292Lb2zOnXohigONn4l6zENmVjPqOtFuO
 E3KgErhG9tlZpj6byt8+9tNPfikSnz6f3g85WBsS5NHVHVmKJBiPi3JrSzvRqyjGUGGLVLdx+zM
 Pjbi0RlAQraCkIy9l54yoEAvtvKZvxeTefEMLl8TpQ9XFVqH4SaZ5Tr0nRSk+WVw1ffAYGZBVxg
 j1+Esu5eL1JmZbQ==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Abeni <pabeni@redhat.com>

Update the existing sockopt test-case to do some basic checks
on the newly added counters.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/385
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 27 ++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index b35148edbf02..5ee710b30f10 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -51,6 +51,11 @@ struct mptcp_info {
 	__u8	mptcpi_local_addr_used;
 	__u8	mptcpi_local_addr_max;
 	__u8	mptcpi_csum_enabled;
+	__u32	mptcpi_retransmits;
+	__u64	mptcpi_bytes_retrans;
+	__u64	mptcpi_bytes_sent;
+	__u64	mptcpi_bytes_received;
+	__u64	mptcpi_bytes_acked;
 };
 
 struct mptcp_subflow_data {
@@ -83,8 +88,10 @@ struct mptcp_subflow_addrs {
 
 struct so_state {
 	struct mptcp_info mi;
+	struct mptcp_info last_sample;
 	uint64_t mptcpi_rcv_delta;
 	uint64_t tcpi_rcv_delta;
+	bool pkt_stats_avail;
 };
 
 #ifndef MIN
@@ -322,8 +329,9 @@ static void do_getsockopt_mptcp_info(struct so_state *s, int fd, size_t w)
 	if (ret < 0)
 		die_perror("getsockopt MPTCP_INFO");
 
-	assert(olen == sizeof(i));
+	s->pkt_stats_avail = olen >= sizeof(i);
 
+	s->last_sample = i;
 	if (s->mi.mptcpi_write_seq == 0)
 		s->mi = i;
 
@@ -562,6 +570,23 @@ static void process_one_client(int fd, int pipefd)
 	do_getsockopts(&s, fd, ret, ret2);
 	if (s.mptcpi_rcv_delta != (uint64_t)ret + 1)
 		xerror("mptcpi_rcv_delta %" PRIu64 ", expect %" PRIu64, s.mptcpi_rcv_delta, ret + 1, s.mptcpi_rcv_delta - ret);
+
+	/* be nice when running on top of older kernel */
+	if (s.pkt_stats_avail) {
+		if (s.last_sample.mptcpi_bytes_sent != ret2)
+			xerror("mptcpi_bytes_sent %" PRIu64 ", expect %" PRIu64,
+			       s.last_sample.mptcpi_bytes_sent, ret2,
+			       s.last_sample.mptcpi_bytes_sent - ret2);
+		if (s.last_sample.mptcpi_bytes_received != ret)
+			xerror("mptcpi_bytes_received %" PRIu64 ", expect %" PRIu64,
+			       s.last_sample.mptcpi_bytes_received, ret,
+			       s.last_sample.mptcpi_bytes_received - ret);
+		if (s.last_sample.mptcpi_bytes_acked != ret)
+			xerror("mptcpi_bytes_acked %" PRIu64 ", expect %" PRIu64,
+			       s.last_sample.mptcpi_bytes_acked, ret2,
+			       s.last_sample.mptcpi_bytes_acked - ret2);
+	}
+
 	close(fd);
 }
 

-- 
2.40.1

