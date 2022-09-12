Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2105B55AC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 10:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiILIDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 04:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiILIDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 04:03:24 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DEB248E8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 01:03:23 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id 9so7799999plj.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 01:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=iKISEmkpK7fsWaPsy3OTrEfNVDPawQecv0hfPWF5gkk=;
        b=k5zW+iyB7pLjCGd0kDIN3K671MDPBuWzD1ScOWVlTpDU5OItpnpftyKROk+ibcdG3M
         4kACcejZHx2wjDnzgOWqq0iY+BIZp10PEPA7fF8pe7sqXArA0F5L1dxMXNua9GFarwwG
         yMJem6q+OhzZVlwiU3t3UNV+ky1DVXlc8CB5qK7p0jOLuFFAweCCk0ExJNz9bkRlthzr
         UL9RrnL5Om1SRJaXBE/IF3JNgKv+RNeZwxKk2xLRQF7IP7jpnQIQ/IjhghzQYPLuDQTO
         HIeeGhgEdbV5rcijzK/cV4w/0D5qPZ9lLB/LkbGDpamFx6hnvlMTAbL/OjkkOgTWKojM
         tOfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=iKISEmkpK7fsWaPsy3OTrEfNVDPawQecv0hfPWF5gkk=;
        b=2x1EYWz9dmex8RxrpL90MZQIcMrk1X1zJ75vrfYTTl4fdo4hgwl5B7+2iX3CtG7+ih
         lN9+8Trj49mE8hzI9oe564z7frEeSp6dgn/SI38F5BW8H8LDdjEHnNPKYuT1FXgzSo6o
         UnVZC9Tfz+9rbeq8NENRnKesUQTy8D1jLQw0fxFgCuY1Y/9i6s+d8ozTrMqbQNJr7pEf
         rlF5jRrVs2UYXmaHMc/uihCCUhhMSogGOWc9BFDI6WAMERIAQO53wE1bnNc4kUEEyHz4
         tigdfvXcPO9O5+iO93IrreyTe44ryyvFiHFVX2v2BGbybR1ZpLxW3MUazuZOooRXH31J
         Grdg==
X-Gm-Message-State: ACgBeo18pp1zPxXspHr1OTb7oOhoakLvC/uhavHkLZeVa1XKEHfEP54s
        X+CIvlIzb9ApmomyPjM7yCc=
X-Google-Smtp-Source: AA6agR5iI16WDHAje6TrCAI69bS8g/RPwxfN3U+TGHOo0D/NpKeNOTetgvgeC9q3ppZus1eezCnY+A==
X-Received: by 2002:a17:903:2601:b0:178:a68:82ee with SMTP id jd1-20020a170903260100b001780a6882eemr14061536plb.163.1662969802657;
        Mon, 12 Sep 2022 01:03:22 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id c13-20020a170903234d00b001755f43bc22sm5287767plh.175.2022.09.12.01.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 01:03:21 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.panda@zte.com.cn
To:     mingo@redhat.com
Cc:     juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, Xu Panda <xu.panda@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] sched/build_utility: remove duplicate referenced header files
Date:   Mon, 12 Sep 2022 08:03:03 +0000
Message-Id: <20220912080302.17366-1-xu.panda@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu Panda <xu.panda@zte.com.cn>

linux/psi.h is included more than once.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
---
 kernel/sched/build_utility.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/sched/build_utility.c b/kernel/sched/build_utility.c
index 99bdd96f454f..80a3df49ab47 100644
--- a/kernel/sched/build_utility.c
+++ b/kernel/sched/build_utility.c
@@ -34,7 +34,6 @@
 #include <linux/nospec.h>
 #include <linux/proc_fs.h>
 #include <linux/psi.h>
-#include <linux/psi.h>
 #include <linux/ptrace_api.h>
 #include <linux/sched_clock.h>
 #include <linux/security.h>
-- 
2.15.2

