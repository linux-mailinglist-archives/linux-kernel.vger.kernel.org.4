Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A5764FDA9
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 06:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiLRFEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 00:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiLRFEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 00:04:15 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670BDDF54
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 21:04:14 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id m4so6083044pls.4
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 21:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+8uGGe5vOHJy+eJbczvZUafBVT7vGqMpKgjkjdLPuI=;
        b=AUG89S3jopByrFoGln5MN2jF636XiStemIMcMCSuWk6oMNg9iO5UueelIFV1njqVHI
         8xNZEK61XzIFE2aWXLg7XVYQC1MaKdi04PvGO8eEWf5i0agL+phx0a/uzwxqJ2TJTgwH
         AycuZtmDn3/WjVykXDC1dg5Mberq7kxe2g/BlX3iT/qih/EOb9StiFbVsITj++WLdqKi
         HJ/OQx8/vocQ0oOZqlOUc+f52B4lnLYMNRCSivjeLzqjt81UXIlt1PyO/OvGS6g157/0
         toRr2GFIHeXC5KeT/KPDcr04xRb8r9YktQ5di2tIWEFfiODOoieEoMEsf6vTWIepEr8P
         /N9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f+8uGGe5vOHJy+eJbczvZUafBVT7vGqMpKgjkjdLPuI=;
        b=Gi7w3zHrf80xQk1bdTuMZ7anxOZ+QWBgT7cTj6HJh1VQYgPoIMoRw78VwmKLVXaUEN
         xtUu2tPEIRCBaKwc2m+DyU7WrlmyO1rDBGzkmXK/VxB/FoDC04hfkiyguKTLug0GRAla
         Py6oe+GgMnTdPELrNl2Yt+jbKbnBahbCKgHH/8hS1Qwt5Z4+BJBJy4T315pLH89lOxu1
         NiODpZ2woXCW0khLuuCSPQrt+Su9qWuQeO8FDvDgVxXViqwU48AmqzLCSskN2/855N/Z
         BPWgu02h3wm4FCOcUjLri3BnkLN0Lbgz94nUioUhLHW4677/CNESdUMMnAjRSdxOuFkW
         hSYw==
X-Gm-Message-State: ANoB5pmZFA9v4LD5PQM4YWuBK9sazh0AG0PPY1SzL6wI5oAohNNvUSjG
        zCVx2eXasyQQNBAhzbz3mwLekyzsueczuNbt
X-Google-Smtp-Source: AA0mqf4fYXX0D8kW4sXkaUW54DlF0CmQmMpx1VD8zG+Ot+MLlJkclZfPF/nBOvlrmMAFTwpnCLaHkg==
X-Received: by 2002:a05:6a21:9212:b0:9f:2dd1:c2bc with SMTP id tl18-20020a056a21921200b0009f2dd1c2bcmr47116953pzb.49.1671339853827;
        Sat, 17 Dec 2022 21:04:13 -0800 (PST)
Received: from devtp.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id v20-20020a170902ca9400b001708c4ebbaesm4339348pld.309.2022.12.17.21.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Dec 2022 21:04:13 -0800 (PST)
From:   wuqiang <wuqiang.matt@bytedance.com>
To:     mhiramat@kernel.org, davem@davemloft.net,
        anil.s.keshavamurthy@intel.com, naveen.n.rao@linux.ibm.com,
        rostedt@goodmis.org, peterz@infradead.org,
        akpm@linux-foundation.org, sander@svanheule.net,
        ebiggers@google.com, dan.j.williams@intel.com, jpoimboe@kernel.org
Cc:     linux-kernel@vger.kernel.org, lkp@intel.com, mattwu@163.com,
        wuqiang <wuqiang.matt@bytedance.com>
Subject: [PATCH v8 5/5] MAINTAINERS: objpool added
Date:   Sun, 18 Dec 2022 13:03:10 +0800
Message-Id: <20221218050310.1338630-6-wuqiang.matt@bytedance.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221218050310.1338630-1-wuqiang.matt@bytedance.com>
References: <20221218050310.1338630-1-wuqiang.matt@bytedance.com>
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

ojbpool, a scalable and lockless ring-array based object pool, was
introduced to replace the original freelist (a LIFO queue based on
singly linked list) to improve kretprobe scalability.

Signed-off-by: wuqiang <wuqiang.matt@bytedance.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 886d3f69ee64..9584aa440eb9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14914,6 +14914,13 @@ F:	include/linux/objagg.h
 F:	lib/objagg.c
 F:	lib/test_objagg.c
 
+OBJPOOL
+M:	Matt Wu <wuqiang.matt@bytedance.com>
+S:	Supported
+F:	include/linux/objpool.h
+F:	lib/objpool.c
+F:	lib/test_objpool.c
+
 OBJTOOL
 M:	Josh Poimboeuf <jpoimboe@kernel.org>
 M:	Peter Zijlstra <peterz@infradead.org>
-- 
2.34.1

