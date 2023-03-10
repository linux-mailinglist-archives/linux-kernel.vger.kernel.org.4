Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B476B4335
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbjCJOLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:11:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbjCJOKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:10:41 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251B810E252
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 06:09:46 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id h11-20020a17090a2ecb00b00237c740335cso5269743pjs.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 06:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1678457385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6SczCfFTY/KJFxBt0YFVietITxxXbodBIi134Qsi0M=;
        b=asKUtiJYwQqgvMbN60l/bVTcYy2W5TZi9AcVU4FhwMRejoM8MKEoTejGDXrB4L5qRb
         apETIhrKGJqUxZte8/van/OhvRDQPA6LTjZdPQYxQy56FIXwSfYtblPmPlJaMseRJfCk
         /yfIf/MqQYjQt0TQom3v4HX7d9OQO9QM0TLMhqyOmcyJNEW9vYdHhWIAHfGXKlMTIJG8
         33aFH4rBUKRtz1XBQmXjUCY1FGm6mtprh9lqOS/mAuq0AE1VUTJcJYRCp14hiDaJ4m1/
         bHLS+N/9p6xMEGCJSRATQivnN79niKr7Z/zt+6bOH/T7hEOAme9agNB41jtnTSqcXhxy
         msag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678457385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u6SczCfFTY/KJFxBt0YFVietITxxXbodBIi134Qsi0M=;
        b=smjr0QLuNerKvAV+l83qSYwDPUkZ3sYVOTDZ03aGuOQ0Gz4AKQ/GFoNj6c58fVwETz
         UGAlsM6vOiICfm59vpf4kwhcUZiCrODnetq/Nf44awi+edd/mggG7zsgCjMKhCgzOYT0
         iMS0UsCBV/M/VC+xYgVC5LiSw0HhAiuEn7QjkbGVNu/DdJAD2bdle9b7O+ICQm4RY+SY
         +as7+au2B8PNmFLtL7F9vpaA/xSUmCc1mfRVr3O9+IVdpp0jfP9vcjReq1tgh341wo4n
         GCq8zQmxTxAVH8psWHr4TWHUUBjSqNwMktQSEdBXwfnkAlO+x8PPbj9fvUm13ncejSnQ
         C3oQ==
X-Gm-Message-State: AO0yUKUQOQ7eXfHR5gEx3gM3r9wto3Tj79DIAxmHJiv/x4DGudXECY3I
        WFvtnm+PCHX2tTZ3GvJ0GvZy2Q==
X-Google-Smtp-Source: AK7set9+KnLDpZhKt5A/OsgVVC228AHdamUX5+ieIAuoF72IdXUgpKu58Km7GNjqb3S3CgyDiWDx5g==
X-Received: by 2002:a17:90b:2353:b0:233:cea2:dac6 with SMTP id ms19-20020a17090b235300b00233cea2dac6mr26150338pjb.47.1678457385677;
        Fri, 10 Mar 2023 06:09:45 -0800 (PST)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id fu11-20020a17090ad18b00b002375c356b0csm6753pjb.19.2023.03.10.06.09.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Mar 2023 06:09:45 -0800 (PST)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH 4/4] maple_tree: Simplify the code of mas_mab_cp()
Date:   Fri, 10 Mar 2023 22:08:47 +0800
Message-Id: <20230310140848.94485-5-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230310140848.94485-1-zhangpeng.00@bytedance.com>
References: <20230310140848.94485-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the code of mas_mab_cp(), and improve readability.
No change in functionality.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index de43ff19da72..688b062728a2 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -1914,32 +1914,18 @@ static inline void mas_mab_cp(struct ma_state *mas, unsigned char mas_start,
 	void __rcu **slots;
 	unsigned long *pivots, *gaps;
 	int i = mas_start, j = mab_start;
-	unsigned char piv_end;
 
 	node = mas_mn(mas);
 	mt = mte_node_type(mas->node);
 	pivots = ma_pivots(node, mt);
-	if (!i) {
-		b_node->pivot[j] = pivots[i++];
-		if (unlikely(i > mas_end))
-			goto complete;
-		j++;
-	}
 
-	piv_end = min(mas_end, mt_pivots[mt]);
-	for (; i < piv_end; i++, j++) {
-		b_node->pivot[j] = pivots[i];
-		if (unlikely(!b_node->pivot[j]))
+	for (; i < min(mas_end, mt_pivots[mt]); i++, j++) {
+		if (unlikely(!pivots[i] && i) ||
+		    unlikely(mas->max == pivots[i]))
 			break;
-
-		if (unlikely(mas->max == b_node->pivot[j]))
-			goto complete;
+		b_node->pivot[j] = pivots[i];
 	}
-
-	if (likely(i <= mas_end))
-		b_node->pivot[j] = mas_safe_pivot(mas, pivots, i, mt);
-
-complete:
+	b_node->pivot[j] = mas_safe_pivot(mas, pivots, i, mt);
 	b_node->b_end = ++j;
 	j -= mab_start;
 	slots = ma_slots(node, mt);
-- 
2.20.1

