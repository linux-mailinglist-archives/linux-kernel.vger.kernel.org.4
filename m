Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73986CBBA7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 12:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbjC1J7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 05:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbjC1J7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:59:12 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDCD5BAE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:58:47 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id i15so7583110pfo.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1679997527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=15Z/PJf0Etf+mCvL+KJkEExIR5UO6fpjH+VUxXpLOps=;
        b=Qx3+v0sZWmUR+ce5l5MqQpd0SAUJEWb0aMDPuqaDGWTo2nZ3Wt+/EWNMN0CiEAmd00
         oTzaOuBYvp5IpyTjML80vgl9ojlZu6X7RxGSvyffWJFXCt43KPzhXd/iS8yeRgsejWrP
         FB+3T6fofiINoekHWqN2WApQUWGvX7bhd+zsJ0LEfvQMmZC7J/Z58o6Yu8Fg0YJgA5dD
         U5S/kAP6t560+N8wYkN1uqz4IRP232N9dBKfyi+Pr0qHtZeRD4S7DIfi+nbFhJk6P5UR
         6HnQZc7vHWimyHei7ItyH6oDI/3Q67JEsR5mXPYeO9JRjRx5a5nwt5lMF5XG/eFNzRa0
         KjZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679997527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=15Z/PJf0Etf+mCvL+KJkEExIR5UO6fpjH+VUxXpLOps=;
        b=cspVaHqkDgbYks2bHSmgAqyouTsKvT5cDU0LF/6XQT8aWXu33ycrDSJDgoPYzHVFVY
         lyOniZNhqffAIZXzPU7z1wgeSQzt+2evSGyB9kSNkwPDXZfHB0Fpn/er0tS8ACk1Mzdo
         zyjgQVJe5ABkKgv4OLDiQDZTe0Vyf0kdJ1ftHXVbTnwhXAlwifO8AqK6Qk2ay6apwezz
         mqZDyB1mKNTv2Li1H81td/eqBaJejQj5RiJ6DYCprmo0PTCScSqn2o5H2pjpN52MSmYM
         TAA65LhJdfZ1sahrs0pD6kF9uIJyoa7N4vsgXSMrtWR93GTRXdZHTU9zdIuKiugxXScX
         MiEQ==
X-Gm-Message-State: AAQBX9fCp5L0WsSbBbn0Bs5NJ3h8SDzSMWLCkZH1AYnqYOFDCJP7mQ+q
        cIxzizubnLJa14Ge2Omx734xNQ==
X-Google-Smtp-Source: AKy350ZjS30LuwRfFP7DkSp3XNPM4Idyf1sfqofA7Lh6rHryfmWu8BfaGo3V4Xaq7lv0dFHBxL1eMg==
X-Received: by 2002:a62:6454:0:b0:5a8:b2bf:26ac with SMTP id y81-20020a626454000000b005a8b2bf26acmr14066890pfb.20.1679997527531;
        Tue, 28 Mar 2023 02:58:47 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id m26-20020aa78a1a000000b005a8a5be96b2sm17207556pfa.104.2023.03.28.02.58.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Mar 2023 02:58:46 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     glider@google.com, elver@google.com, dvyukov@google.com,
        akpm@linux-foundation.org, jannh@google.com, sjpark@amazon.de,
        muchun.song@linux.dev
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 4/6] mm: kfence: remove useless check for CONFIG_KFENCE_NUM_OBJECTS
Date:   Tue, 28 Mar 2023 17:58:05 +0800
Message-Id: <20230328095807.7014-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230328095807.7014-1-songmuchun@bytedance.com>
References: <20230328095807.7014-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CONFIG_KFENCE_NUM_OBJECTS is limited by kconfig and vary from 1 to
65535, so CONFIG_KFENCE_NUM_OBJECTS cannot be equabl to or smaller than
0. Removing it to simplify code.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/kfence/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index 5726bf2ae13c..41befcb3b069 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -115,7 +115,6 @@ EXPORT_SYMBOL(__kfence_pool); /* Export for test modules. */
  * Per-object metadata, with one-to-one mapping of object metadata to
  * backing pages (in __kfence_pool).
  */
-static_assert(CONFIG_KFENCE_NUM_OBJECTS > 0);
 struct kfence_metadata kfence_metadata[CONFIG_KFENCE_NUM_OBJECTS];
 
 /* Freelist with available objects. */
-- 
2.11.0

