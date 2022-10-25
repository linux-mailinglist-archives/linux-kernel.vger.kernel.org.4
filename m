Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFBF660C221
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 05:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiJYDM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 23:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbiJYDMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 23:12:19 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B85D876B6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 20:12:18 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id w74so12935806oie.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 20:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ky6qFTGUzDCxE2nmyXvKTwImJIBIkGkmoKX6VJVuxKw=;
        b=TKcdm0fGAM7UfT/4bM+x2uzA7HriMAKJl9WaImR2ikCxfVawMblKXVP/4bY+osf8o1
         otxCnoof/2fn7WWochr+I5vDQX1fp+60XTogJUfiLDeSUk39Ky2D96YWP5FEygS7fKkm
         ME/drEiviYxIz4/dy2oT/QgpXUfRV6lHTG1XHc1i5/s0wTxhD97eXNrSQRvYNk/gaTO1
         oM3lXmKpPZ6Z9BmwWdH2OaUeMCqsl56dxn9ktK/CrBaiPG+qzxFvpecA5RvdMoRuZefl
         C7xRCN0rjp3KPUeODKu/gLXiOv0Tr5x0XvhOil69FXqzS6t+FYPz8DRejgx9z/AssSms
         EqQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ky6qFTGUzDCxE2nmyXvKTwImJIBIkGkmoKX6VJVuxKw=;
        b=Q7FOb1y6bkq6pAKFLQSr8SFs5F9/KxNCjkcG2y36c4l6etkq+/jd39lKeQ1ocPK6VQ
         f/FzLNggoJhrSFLYUadgipUCI0bI0+kg8oAVAayJrG4lQC5suGuTiYqFTkKoyswOnYDZ
         2fhHbqQwBguRclb6iE3e1xYwI3FwgUQNs+JFNxXsF+YPBEQI7vsHH/B2Fr1u9snegRk5
         z1bKYKDdKnbbxVeiywkPtG+wXUNV/HSXPAZ1WCEndhjq/+b7EeELSFBWbtOc1UEJkxZw
         UmDRn/CGOtuBej9FUPF4wvzuRZTyjbN9DqgaSgiFl/OZAYLMImBJdNn/fL9WBk5DVerS
         LqRw==
X-Gm-Message-State: ACrzQf1xRHod0p5sXet3yvObKkQwfqOf013O6rSBybZHZWDhGJeRUFqq
        qExY6hh85bxl+WK73jsbBXWxuX4ENO8=
X-Google-Smtp-Source: AMsMyM67MsSXs4oY0nE/orw86s99sohelI+Ss++5IlRhOPUPkTKKzeblNY8rTdSO5q3dq/MwmVV+oQ==
X-Received: by 2002:a05:6808:60a:b0:355:50f8:1743 with SMTP id y10-20020a056808060a00b0035550f81743mr18021511oih.125.1666667537659;
        Mon, 24 Oct 2022 20:12:17 -0700 (PDT)
Received: from macondo.. ([2804:431:e7cc:c8c9:744c:3c6d:ae1f:be49])
        by smtp.gmail.com with ESMTPSA id q10-20020a05683033ca00b00661a33883b8sm506013ott.71.2022.10.24.20.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 20:12:17 -0700 (PDT)
From:   Rafael Mendonca <rafaelmendsr@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Rafael Mendonca <rafaelmendsr@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fprobe: Check rethook_alloc() return in rethook initialization
Date:   Tue, 25 Oct 2022 00:12:08 -0300
Message-Id: <20221025031209.954836-1-rafaelmendsr@gmail.com>
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

Check if fp->rethook succeeded to be allocated. Otherwise, if
rethook_alloc() fails, then we end up dereferencing a NULL pointer in
rethook_add_node().

Fixes: 5b0ab78998e3 ("fprobe: Add exit_handler support")
Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>
---
 kernel/trace/fprobe.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index aac63ca9c3d1..71614b2a67ff 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -141,6 +141,8 @@ static int fprobe_init_rethook(struct fprobe *fp, int num)
 		return -E2BIG;
 
 	fp->rethook = rethook_alloc((void *)fp, fprobe_exit_handler);
+	if (!fp->rethook)
+		return -ENOMEM;
 	for (i = 0; i < size; i++) {
 		struct fprobe_rethook_node *node;
 
-- 
2.34.1

