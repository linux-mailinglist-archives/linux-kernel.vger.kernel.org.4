Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6430C730DB1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 05:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237381AbjFODu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 23:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241941AbjFODta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 23:49:30 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E2A2122
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 20:48:59 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-75e4497597cso275571585a.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 20:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1686800939; x=1689392939;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NRjYS/ADH2rjGpNFpYFXCA45Do2mTCUsIGO3/Z8z6+w=;
        b=TR6OrR3fFDYNkCl+qhYqAsxfyiD8kknZZjEleHF/oB/mIAtrHmUqxT5dh8hGkLm7x6
         jETfLCXhDDQw3QbD/HPI3dKgkAtov4zpQaVmJPSO1erj3zR9xOsTFOp/lu60HJH6nsZ/
         4QyKhVFs6hTtM1Nv/n0pMN9cqjRyFBJ1twgQJkxpYVM0qUnn216Whur/qwooRbmn9AeT
         kof5U1V3m8rwug8zJXXUBQJk+6gYIZBF4L5DgmHRpFHd4qzoGdTpoEVL0cGg3oFV0vDF
         BLwKzNKm+0bR1j1KZrUOTSyLGxMdfiQRFInPi2+TrbQvj9I13/lac+ftr4xbOUYSQSGb
         ObmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686800939; x=1689392939;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NRjYS/ADH2rjGpNFpYFXCA45Do2mTCUsIGO3/Z8z6+w=;
        b=KnrhIS+HZlFvo+QDDzlo6ZhD+YArWf5DfkvlRpdxg4SCf6shY3+OF1C9LC0hq95vwi
         9ZhGVCOIufDCSrQBXP55ccLMMIBvmsyGIZaJcxUHTP6k/FJE8iX6U8fkfZ65C169BR9Q
         Uu1C0Bi+DeJMLKyMTArCiCu+3/I1q5hfGKs8nu4RTv69nrWFTYh9HHLCL2f+mUnyifx6
         vi+WSNNaznxPbdlbUIhuqrr6+CLMR/9Nmyhucs4Qa8CL8YjcRp1JK6/ogWwoUUM1SfL7
         1diUIjF0s9o0J9Lg+YLoWe80Mb7WTj4UenMlSnYEVNKU9KSSLm7K6YcpyFeT4yZrZtyL
         enuw==
X-Gm-Message-State: AC+VfDzs9yLiJshHMlGSr8qWdzVAf/4nHaw55SUqjpMEOrnI+zmpAE9a
        cr5XMlmCEoRSNCrdLNIKQriJkQ==
X-Google-Smtp-Source: ACHHUZ76N8XpYmzFAvhMwHbuyElh6B1OPNzdSBFlDx7RhGFePCnX/L9cfOqNK5UXZWfPHlXbijOyhA==
X-Received: by 2002:a05:620a:28c8:b0:760:859a:d713 with SMTP id l8-20020a05620a28c800b00760859ad713mr15005467qkp.56.1686800938766;
        Wed, 14 Jun 2023 20:48:58 -0700 (PDT)
Received: from Tower.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id 21-20020aa79215000000b0064559b58eb8sm11012074pfo.154.2023.06.14.20.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 20:48:58 -0700 (PDT)
From:   Zhongkun He <hezhongkun.hzk@bytedance.com>
To:     minchan@kernel.org, senozhatsky@chromium.org, mhocko@suse.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Zhongkun He <hezhongkun.hzk@bytedance.com>
Subject: [RFC PATCH 2/3] memcg: export obj_cgroup* symbol to charge compressed RAM
Date:   Thu, 15 Jun 2023 11:48:49 +0800
Message-Id: <20230615034849.1361940-1-hezhongkun.hzk@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export obj_cgroup* symbol to charge compressed memory in
zsmalloc module.

Signed-off-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
---
 mm/memcontrol.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4b27e245a055..8ba93afacf31 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3064,6 +3064,7 @@ __always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
 	rcu_read_unlock();
 	return objcg;
 }
+EXPORT_SYMBOL(get_obj_cgroup_from_current);
 
 struct obj_cgroup *get_obj_cgroup_from_page(struct page *page)
 {
@@ -3431,11 +3432,13 @@ int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size)
 
 	return ret;
 }
+EXPORT_SYMBOL(obj_cgroup_charge);
 
 void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size)
 {
 	refill_obj_stock(objcg, size, true);
 }
+EXPORT_SYMBOL(obj_cgroup_uncharge);
 
 #endif /* CONFIG_MEMCG_KMEM */
 
-- 
2.25.1

