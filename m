Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D795065A2C5
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 06:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbiLaF2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 00:28:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbiLaF16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 00:27:58 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D76E140B7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 21:27:57 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id n65-20020a17090a2cc700b0021bc5ef7a14so23338563pjd.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 21:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qvXUYwi5ZyU74DKdX9d8zZyO8Ta/Eto0kB/925S6woI=;
        b=eNVSgI8Iffys1qMsVkR5qdhv5aDN9L6WgHnk771KmegnIxIojGrOuyoK/H7l8rlrbe
         z0JsinNRo5iAZWKrEsqQciRzTfvRVJgkoU+6yj+lRCms6MsO96Dk8b1OweA28AWQ2yXt
         amtxjM4FZx0K5IU7pwXWQoEBARvZH9eB/XAwfkIpcfcEzgoSS6zW0PMOEmAm1mvgbnuA
         0Le//8Qj0wF2vhZ7Gn77N5TDY4GFreoykrkMxUn2vQrnSwnOFdYXiGC3Prvz8+NNRTLh
         jYTVbxpg5Y1eiDnab3Q7O1Oe2zt5yiT2BHkJ6RW/N4BPQ9x4SRw4xvSUxCn0X/BL44m+
         8FUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qvXUYwi5ZyU74DKdX9d8zZyO8Ta/Eto0kB/925S6woI=;
        b=xkVf474l4ZVbBfWC6CvQ7hoKqG149oCjHfhCGyTClL1G0lhz5L5TmGuEPzj+DT7Ofc
         GY9WL4wkFsdMdE74cdR+rxmlpeZ3H0aYfXAF3o7hA2MyMgIyCaq3kmIvtk4pt9cwKK6t
         TCQjpEbXd0fAwVIePlg25ANywmM8JugRkbSfJ1Hq9R0Ki5Eg+n8iuUl2rXApB6UMCrjS
         SnjWCzDfqA8hbWn6F4FimGVfMOHvcyjY1NgjiFeHeCyn4eTQ5W/EctYf1KBIpgRHIBSz
         FkkWaPEplzQ5jtAKSXWdxM5h8rlGkFaMDUGEnUgMz5QPGhbs+mxC5++PVp9gwXiOF90B
         dtjw==
X-Gm-Message-State: AFqh2kpnbdjhMm5hbHInK30XLZfmafhhv4tttXttqicItampgXh47yj8
        BIKZlmOR/wwluJB/IjMLtpFV5w==
X-Google-Smtp-Source: AMrXdXsGSF4DED03XvcK7I2wPfr7RidesmY8h4auVFQgGrgKL5ewV9ZB6jZlmLnBYUDjvl/EKf/KIw==
X-Received: by 2002:a17:903:40cb:b0:192:8502:77f9 with SMTP id t11-20020a17090340cb00b00192850277f9mr18853159pld.27.1672464477035;
        Fri, 30 Dec 2022 21:27:57 -0800 (PST)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id c16-20020a170903235000b0016d773aae60sm15836612plh.19.2022.12.30.21.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 21:27:56 -0800 (PST)
From:   Eric Lin <eric.lin@sifive.com>
To:     peterz@infradead.org, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, palmer@dabbelt.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     paul.walmsley@sifive.com, greentime.hu@sifive.com,
        vincent.chen@sifive.com, Eric Lin <eric.lin@sifive.com>
Subject: [PATCH] perf tools riscv: Fix perf tool build error on riscv
Date:   Sat, 31 Dec 2022 05:27:31 +0000
Message-Id: <20221231052731.24908-1-eric.lin@sifive.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the definition of 'struct perf_sample' has been moved to sample.h,
we need to include this header file to fix the build error as follows:

arch/riscv/util/unwind-libdw.c: In function 'libdw__arch_set_initial_registers':
arch/riscv/util/unwind-libdw.c:12:50: error: invalid use of undefined type 'struct perf_sample'
   12 |         struct regs_dump *user_regs = &ui->sample->user_regs;
      |                                                  ^~

Fixes: 9823147da6c8 ("perf tools: Move 'struct perf_sample' to a separate header file to disentangle headers")
Signed-off-by: Eric Lin <eric.lin@sifive.com>
---
 tools/perf/arch/riscv/util/unwind-libdw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/riscv/util/unwind-libdw.c b/tools/perf/arch/riscv/util/unwind-libdw.c
index 19536e172850..54a198714eb8 100644
--- a/tools/perf/arch/riscv/util/unwind-libdw.c
+++ b/tools/perf/arch/riscv/util/unwind-libdw.c
@@ -4,7 +4,7 @@
 #include <elfutils/libdwfl.h>
 #include "../../util/unwind-libdw.h"
 #include "../../util/perf_regs.h"
-#include "../../util/event.h"
+#include "../../util/sample.h"
 
 bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
 {
-- 
2.17.1

