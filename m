Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEB2616709
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbiKBQEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbiKBQEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:04:35 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FDF2D1D8
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 09:03:58 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id b2so482547iof.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 09:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xv6cL0ZSGPHAFthg9NzBypc1kXfNTRd7Jr+ckvgr8EQ=;
        b=dUREi1KBpt9LKyWLyHp/8nfkpssv9BdL8zcw/pvQpoq/Or0dteNa8SRDWqgYgxgkZE
         tBFxFMz8GzAnftA32BARgBUOw8C88DN0j3DRBXv9GkKOrpv4Fn9qEriYc0tXa819vRSY
         TQGQ8uqIMmtvNyBjhoUfr8R7JFtlCj4876sZpx4mHs+wsqWpit8knC5JBw4B8hGK61aj
         NmRTHB5i5hXKQHZ/2q3EOLVwJllhfRtCqQbILdt0MsN1iHoAC3bk52Tb33ooi2For1xD
         ZHObNdB/C8W3uq6fl0CSB14xWG0jEwoMPxorHVWB7a1+k1A20gGkIM/go2wANBsyRjRI
         ecFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xv6cL0ZSGPHAFthg9NzBypc1kXfNTRd7Jr+ckvgr8EQ=;
        b=SpU2UyLBh31eiXIwN/RvD5d7E6cEW2Hn7TL1Qn7Exq8vdJkp4MuDzJJyGLZtEb3AZB
         6Ociv6Qi+74CKtFJcSt73gRskAeB0KXgOsb9VbybIbKG0nBaQh0pZl8XyAoMC+kn9Jrr
         BCIoJNeGrqsZQjlnangu1ftQRj0ZHfFXaWQsQXzTUzcbLvJw7Lfn/HScG776N2a4WgN7
         4UTjKdU+4tTNy9SeGtQ1DCV0iTF2yENWCNXwo4q3LtY2taO2falggizwfxi6hkZ7lbA9
         gKwBsquNqNgmKGrVHOYwmuLnvu/uETXh50bBSQeNzldj8yZNfk2DP00dwSanfMGjtawX
         gGaA==
X-Gm-Message-State: ACrzQf1J6Qk3HwBFg5GokKUpgaLLrYz3hMTQAqy5UOcQQ4jfl7wfU6fi
        XKbSnAuvUmMtlSj93rZ3k17rxBvh1zbnsRSv
X-Google-Smtp-Source: AMsMyM6jy4NiBcZGkM2BB0yNIg8a8QqqUHETrWBCpJrfQX8c7HJ2aoPDDSspVRCVfKalQ+aFdFbl+w==
X-Received: by 2002:a05:6638:304c:b0:363:ff68:8ebc with SMTP id u12-20020a056638304c00b00363ff688ebcmr17337143jak.294.1667405037604;
        Wed, 02 Nov 2022 09:03:57 -0700 (PDT)
Received: from ip-172-31-23-7.us-east-2.compute.internal (ec2-52-14-118-98.us-east-2.compute.amazonaws.com. [52.14.118.98])
        by smtp.googlemail.com with ESMTPSA id y4-20020a92d804000000b002f66aacb98asm4704327ilm.70.2022.11.02.09.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 09:03:56 -0700 (PDT)
From:   Jianlin Lv <iecedge@gmail.com>
To:     rostedt@goodmis.org, alison.schofield@intel.com,
        davidgow@google.com, thunder.leizhen@huawei.com
Cc:     iecedge@gmail.com, jianlv@ebay.com, linux-kernel@vger.kernel.org
Subject: [PATCH] tracepoint: Allow livepatch module add trace event
Date:   Wed,  2 Nov 2022 16:02:36 +0000
Message-Id: <20221102160236.11696-1-iecedge@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the case of keeping the system running, the preferred method for
tracing the kernel is dynamic tracing (kprobe), but the drawback of
this method is that events are lost, especially when tracing packages
in the network stack.

Livepatching provides a potential solution, which is to reimplement the
function you want to replace and insert a static tracepoint.
In such a way, custom stable static tracepoints can be expanded without
rebooting the system.

Signed-off-by: Jianlin Lv <iecedge@gmail.com>
---
 kernel/tracepoint.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index f23144af5743..8d1507dd0724 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -571,8 +571,8 @@ static void for_each_tracepoint_range(
 bool trace_module_has_bad_taint(struct module *mod)
 {
 	return mod->taints & ~((1 << TAINT_OOT_MODULE) | (1 << TAINT_CRAP) |
-			       (1 << TAINT_UNSIGNED_MODULE) |
-			       (1 << TAINT_TEST));
+				(1 << TAINT_UNSIGNED_MODULE) | (1 << TAINT_TEST) |
+				(1 << TAINT_LIVEPATCH));
 }
 
 static BLOCKING_NOTIFIER_HEAD(tracepoint_notify_list);
-- 
2.25.1

