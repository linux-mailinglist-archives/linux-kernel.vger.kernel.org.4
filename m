Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C13765586F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 06:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiLXFHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 00:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLXFHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 00:07:06 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF90115738
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 21:07:02 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id 17so6626778pll.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 21:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MerBzVDlT2AxTGjJiUrWBD5Md5Tk3n59Vk5ImxwXZUw=;
        b=LuPWVyPcDY0EeHN/nGKZuUeGquteYaywGByMKD5ut+p5GzAd+xNezTANybUYOf65n+
         StuU9hvICsB555Omglz9zFn0Kkgg73dbXNlSFhK3HGCWaxErBHoN87qieoEz2jlrOiDm
         QgrpIpieLaTSzw/epFZQWsX+IDzW4E9iXzAMpRHb3gRfXWtch0nwRkNo8C2m1XfeSmcH
         zHUOEsM1ij+aGF9VIf5jjxGn+FZpW2sRjgILtSNbyaJwJNXfK8WUm/QEEBiMva8qNoj3
         mBsxZ9miHW2tuV/JMbUOb25KCZ9qDDb5eGaQAwNuXtit2H0OcFRYglpitXpW+bSOgMwO
         BEzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MerBzVDlT2AxTGjJiUrWBD5Md5Tk3n59Vk5ImxwXZUw=;
        b=A6eYc4dgFRGt5y/2Iz7lh/Qripg3fCrEwxkxzX2glxUHFVZzn6VcMVclevHHGth+zi
         yZCHQF9sKOQbimvyB/copRT9ir52OSXBa39hahZbrqy24ir5N16dPq9AA2yNvbxIrLVB
         nIWbfKk0ktYFUZZqUbxibY/8hOacyUmrdWnCmAiF6lt3tPM+092QFBqkLGYh4HEoV1o5
         c30KzYTi4jwQ4r22go2Qgr99zEYlVpqQWyEQ4yTBX1Xk/bohGn97YfCusiwHMvsh2lIV
         i/ogzVRzeqsj9QITeFT3NpUPI9TbECLO10a9QEJ7tUWwtkqs+DvEbdqg1S6Xba0ETZ3s
         66Xg==
X-Gm-Message-State: AFqh2kpgi5vYjAdr61nr/qwla3t4Xiu9HEQkeUzuErUnajBww895Ltcq
        +v8N+Yyhr1anTiOcxMw3/dfp6aSPPXERAw==
X-Google-Smtp-Source: AMrXdXsZtp9AqKjq6BpzEAsNEm6lScSUcD2f478RcYWvw4R0eKX6CDPbvS+bZir8i+n3Vc7kKonZog==
X-Received: by 2002:a05:6a20:2a9f:b0:a4:ac45:8a68 with SMTP id v31-20020a056a202a9f00b000a4ac458a68mr18826392pzh.11.1671858422139;
        Fri, 23 Dec 2022 21:07:02 -0800 (PST)
Received: from localhost.localdomain ([191.101.132.84])
        by smtp.gmail.com with ESMTPSA id q6-20020a655246000000b004468cb97c01sm3065499pgp.56.2022.12.23.21.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 21:07:01 -0800 (PST)
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
To:     nathan@kernel.org, ndesaulniers@google.com, trix@redhat.com,
        akpm@linux-foundation.org, geert+renesas@glider.be,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Subject: [PATCH linux-next] lib: Dhrystone: initialize ret value
Date:   Sat, 24 Dec 2022 13:06:40 +0800
Message-Id: <20221224050640.64427-1-zhouzhouyi@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Initialize ret value whenever 'if' condition is false in dhry_run_set.

Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
---
Dear Developers:
When I invoke make bzImage LLVM=1, clang complains followings:
lib/dhry_run.c:61:6: error: variable 'ret' is used uninitialized whenever 'if' condition is false

Fix above complain by initialize the ret value.

Thanks
Zhouyi
--
 lib/dhry_run.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/dhry_run.c b/lib/dhry_run.c
index 31a1d442e4a0..be86e5126c29 100644
--- a/lib/dhry_run.c
+++ b/lib/dhry_run.c
@@ -64,6 +64,7 @@ static int dhry_run_set(const char *val, const struct kernel_param *kp)
 			return ret;
 	} else {
 		dhry_run = true;
+		ret = 0;
 	}
 
 	if (dhry_run && system_state == SYSTEM_RUNNING)
-- 
2.34.1

