Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23565B5531
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 09:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiILHSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 03:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiILHRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 03:17:42 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3DF2E69A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 00:16:28 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id j6-20020a17090a694600b00200bba67dadso7271373pjm.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 00:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=EvqfGMItntvj3tXACRyyuEo+bS35fFfUx1B1FitAac0=;
        b=ogO4VCcvCUEbfliaC6X5DabNww9AbRA9i/MmioT7U0e7XTwCVCAgbEq8cNvK2faAR8
         N4OHmI0412Nqk0KaXLB0Mn336cWufBiD0Fs0S9vPe8/RoB1kTA7jpQ4HnpmuloJUf52R
         pgikGRA3Sv5emrHmpKpFGXQzYPTYkiMdIitdmexQj43q8TpW6ITEQuImqwD928n9KBrv
         7J6X+xfhQBDjcKXN1O28VGjunjiOX4sy79/+ySejoQu7kqJNqddXlSGIXN1HqDBA2UZt
         lHsneteEiPqPSCl6nx5NoXLyA5cMuT7XGGYo754AEuDA4CWwcC0xBDE7aCX37uUgfHic
         871w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=EvqfGMItntvj3tXACRyyuEo+bS35fFfUx1B1FitAac0=;
        b=v8cgdxIQZ9fmzJFy6sC8GgfKPCd5ZnVydinYlDrrpxpsxw1pSNtldiF+ZGLywdhOc/
         T5hc3ers58p9Gs2U0WhLiRyEuW4BaUeZxmHE8Ru4zAAZGIx2uM+vTvutKRkjU+DGEZli
         09II/RS68Tg887+qlgQ3KQn8rFnlM5pHDHG80MAfjznQSXdY4vN7poiBch2CqidAsYW2
         8pTV4h1yyUZmaIianUcQuqDmBjNOKEVVC5ZzYETM/uLkh8fOhKD/d55gauZUnOz90fMg
         1jElrXj9rk1lbpH19tJgwFKB3jIxbOHtzjCtgNVFrpL7+xnSdagN00P9P7rHn1ZVohF5
         SkHQ==
X-Gm-Message-State: ACgBeo1Wf8uf7rSswOdMGAN9F0TgP1kEcwGwBLOlVbgJD0XprzSnKx2K
        Z1Z8Xlx3z2DCsfiTTNSanCY=
X-Google-Smtp-Source: AA6agR4qlDYx7sWIsz7Lf9Fsfeqsqx5biYaLB3ABeDIVz9TK0Se1leNpLIKDvyLuqQYTfYubYMkTog==
X-Received: by 2002:a17:90a:a60b:b0:200:919a:55a1 with SMTP id c11-20020a17090aa60b00b00200919a55a1mr22484660pjq.194.1662966978065;
        Mon, 12 Sep 2022 00:16:18 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id q8-20020a170902dac800b0017832c8cc85sm1431410plx.292.2022.09.12.00.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 00:16:17 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.panda@zte.com.cn
To:     brauner@kernel.org
Cc:     ebiederm@xmission.com, akpm@linux-foundation.org,
        tglx@linutronix.de, luto@kernel.org, bigeasy@linutronix.de,
        Liam.Howlett@Oracle.com, fenghua.yu@intel.com,
        linux-kernel@vger.kernel.org, Xu Panda <xu.panda@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] fork: remove duplicate included header files
Date:   Mon, 12 Sep 2022 07:15:57 +0000
Message-Id: <20220912071556.16811-1-xu.panda@zte.com.cn>
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

linux/sched/mm.h is included more than once.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
---
 kernel/fork.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index bfb23851b6eb..52e4497635d1 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -96,7 +96,6 @@
 #include <linux/scs.h>
 #include <linux/io_uring.h>
 #include <linux/bpf.h>
-#include <linux/sched/mm.h>

 #include <asm/pgalloc.h>
 #include <linux/uaccess.h>
-- 
2.15.2

