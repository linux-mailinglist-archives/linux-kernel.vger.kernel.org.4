Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16BE9649EB7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 13:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbiLLMde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 07:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbiLLMdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 07:33:07 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B4ECD1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 04:33:05 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d15so2309817pls.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 04:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+8uGGe5vOHJy+eJbczvZUafBVT7vGqMpKgjkjdLPuI=;
        b=tcqTn2obQf6CbBT4rNITkZLHWBYQLrodivwc8sWIEM+ZtA8FvvSKHEO3iImOl2evuH
         fd6gl+Kn6aU7TmqewmevTq5xzUuVks6WM5BE12+V2FA80OLRBs/dATSgK5jieZarWOk4
         xv9gyA7iG18WMx+A+J/f/uOMeMIOGQk5Qf0qWwJhFFeDEP0m3MS+I+e1x1pVQwNYezzu
         k8eG9TeW03WbwjF1b+UNoNrsnz9g3W0Eq6xlXW91UTVhuezYcW27GRZK5gJg/QVNcJbG
         4xeg4P1bxeRiAmUgelLqB34waeS9h+S1DRAt05jAV6mS9gJMMYBNhKEnYS+hJvRhFKg1
         ipfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f+8uGGe5vOHJy+eJbczvZUafBVT7vGqMpKgjkjdLPuI=;
        b=nfYGdey9y/lJ0JfcCx4fSg00PNN8y2n0J4hXFyLiqQGCLbgObnVkxffym3YPgrel9l
         cOQNXQosOpLmueulPZxjyuaC3r8qFiS2wRbpW6PHU8T7vn/Z1mzGMlvofHGw2f2UINHh
         iqEyvaesJAPkujypDBzApRQkUL5jbeWibjpj8rdonQ0uSq81A57pv/Y4RX8W9VY8+GSW
         GNzbOlwejhm23fP/VOJpg2hlzNQyjkUad3HqIrIT2tHnRnlkvz/CY46GpyeRQ27ldvI/
         xyElVfAAb5kSSQml1DfsPM1EvriecL7sFYJhxTTsRfdJQxK28SoW0xTmaaHRCgRWWbFr
         5oBQ==
X-Gm-Message-State: ANoB5pld+4ujMDl+qCs08ASVN7vsF5UUJpSyXdh1uON36HikDGBKXI01
        ijNc0sQgrNE6OQpBbGS0NTRicQ==
X-Google-Smtp-Source: AA0mqf7FMWv/CA6ZPCGa6ZPJawKAr286zXvKMBRS2JLCv2L6CjK/v5BrjHAo75w2b8d92mtAThm/XA==
X-Received: by 2002:a17:903:2412:b0:188:f47f:ac06 with SMTP id e18-20020a170903241200b00188f47fac06mr14926109plo.19.1670848385329;
        Mon, 12 Dec 2022 04:33:05 -0800 (PST)
Received: from devtp.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id jw1-20020a170903278100b001869ba04c83sm6219987plb.245.2022.12.12.04.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 04:33:05 -0800 (PST)
From:   wuqiang <wuqiang.matt@bytedance.com>
To:     mhiramat@kernel.org, davem@davemloft.net,
        anil.s.keshavamurthy@intel.com, naveen.n.rao@linux.ibm.com,
        rostedt@goodmis.org, peterz@infradead.org,
        akpm@linux-foundation.org, sander@svanheule.net,
        ebiggers@google.com, dan.j.williams@intel.com, jpoimboe@kernel.org
Cc:     linux-kernel@vger.kernel.org, lkp@intel.com, mattwu@163.com,
        wuqiang <wuqiang.matt@bytedance.com>
Subject: [PATCH v7 5/5] MAINTAINERS: objpool added
Date:   Mon, 12 Dec 2022 20:31:53 +0800
Message-Id: <20221212123153.190888-6-wuqiang.matt@bytedance.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221212123153.190888-1-wuqiang.matt@bytedance.com>
References: <20221212123153.190888-1-wuqiang.matt@bytedance.com>
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

