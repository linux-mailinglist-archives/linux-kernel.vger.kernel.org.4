Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC42770B970
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 11:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbjEVJx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 05:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbjEVJxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 05:53:24 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C097B9
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 02:53:23 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-64d247a023aso2875797b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 02:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1684749203; x=1687341203;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hnIfipm8ADmVcPlfJeR2m6dzYHlF2xT+Sv9iRF6t3cY=;
        b=AOzpCt/R5/HiWo6POXCM45SpS08bNlo11NcaKUQY8fbE74t46SQzwFReeowIfN1QBH
         k42Pa4PS1GDGK68evYz8AKEVOtCHJrI1Ycb8tBHltfRKXUCfVX1cpN31oU4AKAUV/v3b
         atvu/X/oySVxlD9Eqt4fOQR6IS55Z8JZhWRWfm2AikBq/n8wh3FmecrWs6Y5Ev6ljHfQ
         u2sjZwIfVdOOAmurBV6Mx3WGS2fliHR2vLyTGHn7M5FHSLYPQ+zCv1C2h3ehMN+xzzZF
         3022G70xrM3eiXml5jDArQFZrTLKq5hqXeoebTIw7Z+yxmB0sA3rMeGeSB+1U4Ak/wmv
         Xm/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684749203; x=1687341203;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hnIfipm8ADmVcPlfJeR2m6dzYHlF2xT+Sv9iRF6t3cY=;
        b=LfYvFrc06WRb0Vol1sZy1cmQxLXSCGpo0+blWVWXnHq4ugWbHlPxPMkUY+0oC9WItl
         Ns5w0/0yLy9/z/qaWkbB1B7tH1W+OBi46wH/3hFB0lTexJmQ+pvJI4fB14rNk3YX22NT
         26NEcpKBdvOdiSPqaNZXMF6dyRFAagUTfbIdYIhJdfIamJYolrnqdEwIC1jzONktvGzY
         yTRdOFYqyvs9h+gRgjfxhDl0Yg550erE0a/BUY9+xKcYz0I1hnJA3Hg5n1mIKLHEdrha
         L/grrWhezbtBeuac03/2bnckUdLXfps29zGQyGyoRUHuqHCQEM+j5GRkWotaiVgJe52c
         rgVQ==
X-Gm-Message-State: AC+VfDyeaHoyhym392R1IX2I1Dz7NgxwxAAzQuRc/wUpK3vNWzz7txcq
        RBdVyxdhOyMeLoUeGrxfCCwJeA==
X-Google-Smtp-Source: ACHHUZ7Gqy8j0qxhN10JBGVVj+H/ve8NIo22gbIeyse0zofEfmRuw+x0w1VQUfHAQi9FO3kZQC6U3Q==
X-Received: by 2002:a05:6a20:8e07:b0:104:62a9:9006 with SMTP id y7-20020a056a208e0700b0010462a99006mr12512823pzj.36.1684749202957;
        Mon, 22 May 2023 02:53:22 -0700 (PDT)
Received: from ubuntu-hf2.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id g37-20020a632025000000b0051b9e82d6d6sm4089267pgg.40.2023.05.22.02.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 02:53:22 -0700 (PDT)
From:   Haifeng Xu <haifeng.xu@shopee.com>
To:     mhocko@kernel.org
Cc:     roman.gushchin@linux.dev, hannes@cmpxchg.org, shakeelb@google.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH 2/2] selftests: cgroup: fix unexpected failure on test_memcg_low
Date:   Mon, 22 May 2023 09:52:33 +0000
Message-Id: <20230522095233.4246-2-haifeng.xu@shopee.com>
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

Since commit f079a020ba95 ("selftests: memcg: factor out common parts
of memory.{low,min} tests"), the value used in second alloc_anon has
changed from 148M to 170M. Because memory.low allows reclaiming page
cache in child cgroups, so the memory.current is close to 30M instead
of 50M. Therefore, adjust the expected value of parent cgroup.

Fixes: f079a020ba95 ("selftests: memcg: factor out common parts of memory.{low,min} tests")
Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
---
 tools/testing/selftests/cgroup/test_memcontrol.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index f4f7c0aef702..a2a90f4bfe9f 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -292,6 +292,7 @@ static int test_memcg_protection(const char *root, bool min)
 	char *children[4] = {NULL};
 	const char *attribute = min ? "memory.min" : "memory.low";
 	long c[4];
+	long current;
 	int i, attempts;
 	int fd;
 
@@ -400,7 +401,8 @@ static int test_memcg_protection(const char *root, bool min)
 		goto cleanup;
 	}
 
-	if (!values_close(cg_read_long(parent[1], "memory.current"), MB(50), 3))
+	current = min ? MB(50) : MB(30);
+	if (!values_close(cg_read_long(parent[1], "memory.current"), current, 3))
 		goto cleanup;
 
 	if (!reclaim_until(children[0], MB(10)))
-- 
2.25.1

