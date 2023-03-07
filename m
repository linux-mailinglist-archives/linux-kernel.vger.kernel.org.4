Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA1F66ADE91
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 13:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbjCGMUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 07:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjCGMU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 07:20:29 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAED5302AC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 04:20:27 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id z10so7433918pgr.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 04:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678191627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zR3SqOIJEtppTiQ5ZJZtYtRZxphAv9rsA+9/zUbIboo=;
        b=ntg9YKaHYSvNV0n9rp/He7GTZHoPjspMXn2a3Z+Xpo5HRF42WlyfzawcxBf4QHRaku
         O4+92vfVHLH+8ZQeivMZ3He+9MnpmVGwzOjG6tcnn1ihhSv+vQFMAThps7doRHBsZBYS
         Zag0lftoSAQs5oIBHyIC/Gb6HfJ9HrEjJ6MNBz5qagsT2AIzB8YMti7obBQVPvGM4Ssv
         3HmB7NcuiMCeEvcvMOG8JeSY+FzhnWDG/SE4dvYOu4wi+qPQSQgrj+1U2AKWb+ZBcxsb
         XA0C0VokCCxGvaHeMFj5NWevZa9/uhkIH4Za3uBUHGE8ojUN2LyKvN6Iq/w3poVHba9o
         OFHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678191627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zR3SqOIJEtppTiQ5ZJZtYtRZxphAv9rsA+9/zUbIboo=;
        b=phCofyAxIEE1CVkQL6GZxncHLbBfgotedCaXe+tXawQNIDsX1yIgjb9czmnGHX/8Xh
         OoN6mZnzMWooPsJTXkoDxwB1UR3eXXla2S7kSABYn6K86Tq1OfW9R1z93s1EY2cjhA+o
         EMEjrE14M5oUlF/P6HB4Iz5ejJcUKSzqfbrnBBJ6O928BjW138JiZ0YHJ8XSdOGlix6V
         fUl559EVoXFWrbYOIHLXxodfXVnMox/KhWenhpwrPrJ93AA+h5MhgC7YWP9hXvnTgCtl
         fzciBVhxJ4EJCfSFj5Sgu+NOh75zctvRQTN+c+bYmmdOsBwmtjXdzYBvUmgo01UFTDag
         R6ww==
X-Gm-Message-State: AO0yUKX43EhRwwgQkwrFGsI/tn3b/RiPcWnYuj4BNHpO9LBAlrHddw4o
        HoAYd9eP3OxzfCDIEWq9OyQ=
X-Google-Smtp-Source: AK7set9Q+ap+0E+m5VrEF2rj5byWm+UCrUB/9hVJ1TyAMY7po6SpVX3AwPn8hzHuj4Cg2gVVQk6y2Q==
X-Received: by 2002:a62:7b03:0:b0:5a8:c699:3eaa with SMTP id w3-20020a627b03000000b005a8c6993eaamr14749539pfc.9.1678191627325;
        Tue, 07 Mar 2023 04:20:27 -0800 (PST)
Received: from passwd123-ThinkStation-P920.. ([222.20.94.23])
        by smtp.gmail.com with ESMTPSA id k19-20020aa792d3000000b0058173c4b3d1sm7792506pfa.80.2023.03.07.04.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 04:20:26 -0800 (PST)
From:   Kang Chen <void0red@gmail.com>
To:     fancer.lancer@gmail.com
Cc:     allenbh@gmail.com, dave.jiang@intel.com, jdmason@kudzu.us,
        linux-kernel@vger.kernel.org, ntb@lists.linux.dev,
        void0red@gmail.com
Subject: [PATCH v2] ntb_tool: check null return of devm_kcalloc in tool_init_mws
Date:   Tue,  7 Mar 2023 20:20:21 +0800
Message-Id: <20230307122021.1569285-1-void0red@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230306152810.ptb622tfhoxehhdc@mobilestation>
References: <20230306152810.ptb622tfhoxehhdc@mobilestation>
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

devm_kcalloc may fails, tc->peers[pidx].outmws might be null
and will cause null pointer dereference later.

Fixes: 7f46c8b3a552 ("NTB: ntb_tool: Add full multi-port NTB API support")
Signed-off-by: Kang Chen <void0red@gmail.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
---
v2 -> v1: add Fixes and Reviewed-by tags

 drivers/ntb/test/ntb_tool.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
index 5ee0afa62..eeeb4b1c9 100644
--- a/drivers/ntb/test/ntb_tool.c
+++ b/drivers/ntb/test/ntb_tool.c
@@ -998,6 +998,8 @@ static int tool_init_mws(struct tool_ctx *tc)
 		tc->peers[pidx].outmws =
 			devm_kcalloc(&tc->ntb->dev, tc->peers[pidx].outmw_cnt,
 				   sizeof(*tc->peers[pidx].outmws), GFP_KERNEL);
+		if (tc->peers[pidx].outmws == NULL)
+			return -ENOMEM;
 
 		for (widx = 0; widx < tc->peers[pidx].outmw_cnt; widx++) {
 			tc->peers[pidx].outmws[widx].pidx = pidx;
-- 
2.34.1

