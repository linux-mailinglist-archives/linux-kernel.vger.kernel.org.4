Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A23735737
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 14:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjFSMs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 08:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjFSMsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 08:48:51 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35275120
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 05:48:49 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-54f85f8b961so2622042a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 05:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1687178928; x=1689770928;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zkvtgJhNiAhlhE/5X9KIzqXme2yxIHOQ4aJAd2h6f9c=;
        b=Sy4BZQSQxGMw6NONjzbcq2N7RyjpWRHbA6AvoFZp8NRVHtp783fyfgNtZaScvfKhMq
         6KVatXhq782lhFz5kt4R8SHgs3hbFpvVxWm1daPJds0XiUCcY/EeGoEciKB9xofPWt66
         JXuOF9+OspCQ0j5tjiOMTFPPxsu7Q4j0y2G+eazqGvqqjbYr4uEGMBYBGnQuEhDHSeo7
         iMKwKmjOxJj/nJBwMDF3ZHBclzTjYVRukgbfIPUb+BxtzacxWRMKd7RUjgz0YmtOd3Fy
         FVk5qmlxKAHp/4omdq9Ei3HsZX6yEwLpA3jTjIaADA+P/mP4WazNN694252yL4sU0wnM
         ya9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687178928; x=1689770928;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zkvtgJhNiAhlhE/5X9KIzqXme2yxIHOQ4aJAd2h6f9c=;
        b=eJkUzBFmbmZwR4a51WxjE/IEZD7vAz1tkQ7weTreApJKMCcdZpeBkRgD5H+JIo6hAW
         TXU8ijGNzhg+JWDaZ0pX0nPoAJGc9wYsLEhsr8S+gTG/93zxJeJ9/lVDyTG+H3qKa2XI
         AXkMWzyRBq2nnOJE/nGc8lDK3vtkfc0AfXlQjoi8LwlUYtmAy0t9eJjdtg9G0cYyH073
         PO+yeRXGEtDC9WQmHnxSgEw2wcDz6QZgXJ/IYm768AkR0S+byfxsNsfPKN1MIgcT+7lm
         L2WWoj6z9lrQZsC3KA5txJHe7U7w33Y3l/Mr9/Bq1M8fJzyM4xNp450U36ag6KsCP/hV
         FNIQ==
X-Gm-Message-State: AC+VfDxLKp2a7M/vUXty+ODxFoPYBJtCZYnWfP4EhPtyj4O08D9dvidI
        DaJ1q/eUtQnwqbkS6UFYg5SIrg==
X-Google-Smtp-Source: ACHHUZ5mUsmBPn48KvGeEemZhnT2w4mL+mwLrRoTndxKIzScpVQqN0QtZtsqPxDgwaKC5qYR30kPBQ==
X-Received: by 2002:a17:90a:ff09:b0:25c:7f2:2e5d with SMTP id ce9-20020a17090aff0900b0025c07f22e5dmr9442987pjb.13.1687178928639;
        Mon, 19 Jun 2023 05:48:48 -0700 (PDT)
Received: from ubuntu-hf2.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id fr3-20020a17090ae2c300b0024de39e8746sm5597090pjb.11.2023.06.19.05.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 05:48:48 -0700 (PDT)
From:   Haifeng Xu <haifeng.xu@shopee.com>
To:     mhocko@kernel.org
Cc:     roman.gushchin@linux.dev, hannes@cmpxchg.org, shakeelb@google.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mkoutny@suse.com,
        akpm@linux-foundation.org, Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH] selftests: cgroup: fix unexpected failure on test_memcg_sock
Date:   Mon, 19 Jun 2023 12:47:35 +0000
Message-Id: <20230619124735.2124-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before server got a client connection, there were some memory allocation
in the test memcg, such as user stack. So do not count those memory not
related to socket when checking socket memory accounting.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
---
 tools/testing/selftests/cgroup/test_memcontrol.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index f4f7c0aef702..9e0d6d315826 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -987,7 +987,9 @@ static int tcp_client(const char *cgroup, unsigned short port)
 	char servport[6];
 	int retries = 0x10; /* nice round number */
 	int sk, ret;
+	long allocated;
 
+	allocated = cg_read_long(cgroup, "memory.current");
 	snprintf(servport, sizeof(servport), "%hd", port);
 	ret = getaddrinfo(server, servport, NULL, &ai);
 	if (ret)
@@ -1015,7 +1017,8 @@ static int tcp_client(const char *cgroup, unsigned short port)
 		if (current < 0 || sock < 0)
 			goto close_sk;
 
-		if (values_close(current, sock, 10)) {
+		/* exclude the memory not related to socket connection */
+		if (values_close(current - allocated, sock, 10)) {
 			ret = KSFT_PASS;
 			break;
 		}
-- 
2.25.1

