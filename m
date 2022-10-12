Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B785FC5BE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 14:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiJLM7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 08:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiJLM7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 08:59:07 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EADFC45BD
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 05:59:06 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id i6so11088402pli.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 05:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QQ1XB9BOt5ZTwJN6F6Xw2Al1/ocDwlur6F/M5WoF8aA=;
        b=OdCU0LHvVJQ1uJLGdzZQ3bTgQeqKV+V9Rj+IBC+7//58PaV8kS92YUfgswpOpn4hL5
         Wr8vKKcWCQNuS/nA67gm0LK7itGnGYjHpUHqxn3/SpOZKkKNnFWnd7F0NxP32dCEPk+y
         zN3c1AWz25R/gWXzIxv7WbliHXn7hpOVrynbwXvGwPNFmV0/QxC5bJ7KepNeGnojm19q
         FwXuTaqmWiqwXVKKdk9/YZ2o+DYeL33DH6d8+9SiKo6hLgkF6sHpjNv4r18zBziBmDYo
         4lwhoG+V1NuSf2NH8HAvZ3jhs4mHicMuThbKKODQ6ZAry8xxbJjzd2PbfFbCjwUOZaWe
         nAhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QQ1XB9BOt5ZTwJN6F6Xw2Al1/ocDwlur6F/M5WoF8aA=;
        b=qHqnYVJ+e1w/d6m/O/IbVH8wKEr5aCFhFdUKH4560eTa1wt3AqNNjrLtL07L1sV50v
         jGoD18tsmr56JZQLh+Qh6b4ZOKP5J3tjT+UllANiHbnOHbfKaqe/BmAFyxj1Tw9do47l
         5aYMfKTMb7YE+zUn2SpALY3i3bi4PvHNnYqhGMbhVvsz0d8vcX1gmm5Z5krBxsXjFQMA
         kP0ZsHjTspV0HAGadXmj9vk4F6wBgolaGbDUg8iIH7pzSR75nurnqTVEYqfq3VhFzhv3
         ud758wpBC4wdiT0N+R+5ZNFFV7oCeWjl1Q8QsqoNjB9+m9esgvNYZLGAyeNCba8FjreD
         ggww==
X-Gm-Message-State: ACrzQf38LdzqXaqPeq0hhX3/zi5q1DnTE0ShXQdw6xvWW5jLFa4TgcHu
        qQUzDhooX+6ZWUuRPFfDRdn8qQ==
X-Google-Smtp-Source: AMsMyM44JDouPykzt5BE8CqpT+Nn7ZyQzG4zH14a2EfYR9yTtzntX1UZRfIXJx6hwiVqUZSd3cOTYA==
X-Received: by 2002:a17:90a:8b93:b0:20a:bd84:5182 with SMTP id z19-20020a17090a8b9300b0020abd845182mr5197324pjn.161.1665579545936;
        Wed, 12 Oct 2022 05:59:05 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id z6-20020aa79f86000000b00562ab71b863sm10957168pfr.214.2022.10.12.05.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 05:59:04 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] bpf/btf: Fix is_int_ptr()
Date:   Wed, 12 Oct 2022 20:58:15 +0800
Message-Id: <20221012125815.76120-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When tracing a kernel function with arg type is u32*, btf_ctx_access()
would report error: arg2 type INT is not a struct.

The commit bb6728d75611 ("bpf: Allow access to int pointer arguments
in tracing programs") added support for int pointer, but don't skip
modifiers before checking it's type. This patch fixes it.

Fixes: bb6728d75611 ("bpf: Allow access to int pointer arguments in tracing programs")
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/bpf/btf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index eba603cec2c5..2b343c42ed10 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5316,8 +5316,8 @@ static bool is_int_ptr(struct btf *btf, const struct btf_type *t)
 	/* t comes in already as a pointer */
 	t = btf_type_by_id(btf, t->type);
 
-	/* allow const */
-	if (BTF_INFO_KIND(t->info) == BTF_KIND_CONST)
+	/* skip modifiers */
+	while (btf_type_is_modifier(t))
 		t = btf_type_by_id(btf, t->type);
 
 	return btf_type_is_int(t);
-- 
2.37.2

