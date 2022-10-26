Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1ED60DB83
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 08:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbiJZGnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 02:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbiJZGnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 02:43:12 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C211BAB811
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 23:43:11 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d24so13153072pls.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 23:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2vDHbR3DUkOE8yzEgxQeEjgSGriB6gXr4mj/JHU68GA=;
        b=3/n+rSZU8/t1Wq/6UHdwxWJ/8Vnhs8z6PwAm5Q2hEuWtzX6kmnp8vuaa5tYQbvB0OV
         4MpN9jo1LH8lgZ1jamhoo0Sjb40IdRXctYrxAXL67Ohk/oA6bt0Na66lv1cho5zf0uMl
         gyR5JXei1RA2oVkDjlZo47+m7BBBujoXRp2X62P+Sq1LZ1t/Hr51wspwvP37u+BzLJkW
         4ZJGbNJ4ht98tOv0KvSHOyP4vHrE3ZELhHP3ZaNaIS27Q56LSv7zuUzcqF5f/5/ATzEK
         Mbw2E4BuJ1IHHTFKUKFZIV0dyKNF/CBEfLc7HFQ3DjqVrojXa96YRyxjSEH+2NVPl1vo
         nvRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2vDHbR3DUkOE8yzEgxQeEjgSGriB6gXr4mj/JHU68GA=;
        b=GxBq0NqZC57V9bcrVyG/i4bhUROOqWoVdBALnIX4dlNehtxuZsYhLdgLEyfPTKePrO
         DfsZxmVO0+VIT+YJOk9ztkabt2dP4MY3iE+KRTolQDtv0rycl89v1+arHVJZcxjBjZ2Q
         GJpWbiY2jpQmjIlYT3ozLMyV73q6/AZ09ArpfIKT2ET2MuEsfFC/YpVxPo4i7EI2Hp6Q
         nWKeJ/I0Hcb00J+DO5h4pT5Ed8BYg+BCXszB2Cn/mnQAyCWtG/iIgtVyS+FK/swPZQF1
         pF37Y2OE23SjN1+f+HIEZ+UOIZ6J3pSs3Plnve4wL4NsIvEBPQXRRCd+O0d85bYD8Ecc
         rw9Q==
X-Gm-Message-State: ACrzQf2sVYXufgBGqKv0Op7U/uRwjNvDr067nsJ//9LOitvDseukAYje
        fChMIjsbENNntDbYcPl7coJRNg==
X-Google-Smtp-Source: AMsMyM49O7VZxmAxF64S29upS0h/lnTifqOIwAKaq++uAWxZOuDfp+VnWF5QD9N8QZ1dvtlE/NO31w==
X-Received: by 2002:a17:902:ea06:b0:185:3d64:8d55 with SMTP id s6-20020a170902ea0600b001853d648d55mr41791672plg.7.1666766591314;
        Tue, 25 Oct 2022 23:43:11 -0700 (PDT)
Received: from C02G87K0MD6R.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id b62-20020a621b41000000b0056b932f3280sm2363187pfb.103.2022.10.25.23.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 23:43:10 -0700 (PDT)
From:   Hao Jia <jiahao.os@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net
Cc:     linux-kernel@vger.kernel.org, Hao Jia <jiahao.os@bytedance.com>
Subject: [PATCH v2 0/2] Clean up the process of scanning the CPU for some functions
Date:   Wed, 26 Oct 2022 14:42:58 +0800
Message-Id: <20221026064300.78869-1-jiahao.os@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
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

These two patches clean up the process of scanning the CPU.

Patch 1 stops checking for a new idle core in time
if an idle core has already been found.

Patch 2 tries to minimize false attempts by adjusting the order
of scanning CPU.

v1->v2:
    - Simplified patch1 code and add
      "Acked-by: Mel Gorman <mgorman@techsingularity.net>"
    - Modify commit description to make it more clear

[v1] https://lore.kernel.org/all/20221021061558.34767-1-jiahao.os@bytedance.com

Hao Jia (2):
  sched/numa: Stop an exhastive search if an idle core is found
  sched/core: Adjusting the order of scanning CPU

 kernel/sched/core.c | 2 +-
 kernel/sched/fair.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.37.0

