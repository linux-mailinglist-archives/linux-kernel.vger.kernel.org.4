Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D02634143
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 17:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234346AbiKVQQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 11:16:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234311AbiKVQP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 11:15:59 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45124742FF
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 08:13:52 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id h187-20020a1c21c4000000b003d03017c6efso50475wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 08:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6EnLZTbXxSL2FI/2nYeFbJDmENMDcS1iuMek2QEUr08=;
        b=G9RzKKtCDt5c9dzi8X22RqhLrnod3nErEO25pix2cxbKz/OMph4+2+ilPXT7FSuQsr
         ERqPtPSph5try5oxyaAQ47r90iQEILAZLyCnzYiTXp55A89eUmLUrDEszWynO+ZXz1hy
         46KiCTIQ1d9M28y7e9XIOWkFugU1XKSgGPuP2ikQSxP+baZHGfQ8kaHOlF6F+FZIkwCX
         W/UpZPSKO6wjYa22g8VEBfDxrbyHOOLdhD3Pr62srPTdgFghOzfsBM3t9D/bscNxX6DQ
         MNoRJALD8OxCqKW+PdcPWESOGuDBu3xUbXV/QLoy8lFkwXDykoQRdkRDT3C3W84dReLl
         OxNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6EnLZTbXxSL2FI/2nYeFbJDmENMDcS1iuMek2QEUr08=;
        b=mJvqJDt4s5IrW/P/c3QBw+dxiva5hu8SnwLur011QLgIqD3ODdpLX3JkIHWj7VGcDC
         uPR1+F4fTFKwvXxura5ljGcYU7RibxfDADGXe9lhdQ8PYlzfuQLm/BKKrJksWEF2yxXj
         yBHnacTKXYXOaGb6mPMxAEoc3EHp1dPqEgTAS7Cmj87rJ7m+RsayBApWnAOxhx51fmzV
         yjXnW71pyHaaI8TpQI7ct3fo/iKkeHUIBMtl2XomNpNsGvV1MISltg8P1vrYglqMuvW0
         5WaNpjizomR+fKoUEDXmJ8kv0rZgbkglsoGIhRWU7Al2BSennCowsm6ksfxKdjdE6dSq
         XlPg==
X-Gm-Message-State: ANoB5pkSn2giIyN9HlUdUcbD1Bh6GeKsG4ZbnDewJVDsV64pQZJbueLO
        +FB+nQ30BwrPIQzIMr8KYWM=
X-Google-Smtp-Source: AA0mqf4diCLwhyGC4EECNViDWe8RFYkZU6NCwEoQ7Pmlk27AiT8leVCuNenwLo2PD4Diu03UuEgW7A==
X-Received: by 2002:a05:600c:5408:b0:3d0:1c3f:e3ae with SMTP id he8-20020a05600c540800b003d01c3fe3aemr7867140wmb.27.1669133630877;
        Tue, 22 Nov 2022 08:13:50 -0800 (PST)
Received: from localhost.localdomain (2001-1ae9-2f0-fa00-5962-fdfb-2a9a-17bd.ip6.tmcz.cz. [2001:1ae9:2f0:fa00:5962:fdfb:2a9a:17bd])
        by smtp.googlemail.com with ESMTPSA id j13-20020adff54d000000b0023655e51c33sm14610846wrp.4.2022.11.22.08.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 08:13:50 -0800 (PST)
From:   Petr Skocik <pskocik@gmail.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org,
        Petr Skocik <pskocik@gmail.com>
Subject: [PATCH 1/1] Fix kill(-1,s) returning 0 on 0 kills
Date:   Tue, 22 Nov 2022 17:12:41 +0100
Message-Id: <20221122161240.137570-2-pskocik@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221122161240.137570-1-pskocik@gmail.com>
References: <20221122161240.137570-1-pskocik@gmail.com>
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

Make kill(-1,s) return -ESRCH when it has nothing to kill.
It's the sensible thing to do, it's what FreeBSD does, and
it also seems to be the unrealized intention of the original code.

Signed-off-by: Petr Skocik <pskocik@gmail.com>
---
 kernel/signal.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index d140672185a4..02e7c85c7152 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1600,20 +1600,18 @@ static int kill_something_info(int sig, struct kernel_siginfo *info, pid_t pid)
 		ret = __kill_pgrp_info(sig, info,
 				pid ? find_vpid(-pid) : task_pgrp(current));
 	} else {
-		int retval = 0, count = 0;
 		struct task_struct * p;
 
+		ret = -ESRCH;
 		for_each_process(p) {
 			if (task_pid_vnr(p) > 1 &&
 					!same_thread_group(p, current)) {
 				int err = group_send_sig_info(sig, info, p,
 							      PIDTYPE_MAX);
-				++count;
 				if (err != -EPERM)
-					retval = err;
+					ret = err; /*either all 0 or all -EINVAL*/
 			}
 		}
-		ret = count ? retval : -ESRCH;
 	}
 	read_unlock(&tasklist_lock);
 
-- 
2.25.1

