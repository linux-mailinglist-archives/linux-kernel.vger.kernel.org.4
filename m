Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA63E626827
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 09:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234733AbiKLIdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 03:33:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234656AbiKLId1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 03:33:27 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9245FB33
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 00:33:26 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id io19so6025285plb.8
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 00:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uKgNXpHSoU4bJRdAiprU+Siq+ztqOPTG6adKu9Aw2Mw=;
        b=fBP3FX0pwml50Uh6/7TLPrlSWu4YWvKJq6zHrIeKb0qe8NHom1gBIj7oK7F129fe6y
         aQulO3GzWYv65HSqRYzxN64wM63L70wge67TQdtKPZ0J5aojcZnDrahYEf9czVi0zdJa
         oxcEQlq7LokErV4Z76/A1SFCNFHpcAwoCMVTDaMeNmhdSOdQNaFhXUAiUU22//JmaZmY
         nsoVISIeSGI2ojwWXIRHMNQ4o3YKdSf6cZtJ64c6elvK+q4kuDnCZqO/XyCuW4qrC/bs
         BfEH5RfWE1ybX/0QxNDyleXrBOMqvSJpKySj1bz+7Wl9B0KgIzyy9VgVRcfJoPrsRr9/
         nCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uKgNXpHSoU4bJRdAiprU+Siq+ztqOPTG6adKu9Aw2Mw=;
        b=izVa0XJmJlrR2LuggdPUmNU2K/6hdVNvBjn3hxJtLFG0qACav5Ao8QbdL11ZKpIaVQ
         RNcZ4op2Gj4VnFr8qED6eQo8Xt04GPCpIYBjO4z6r1xlGb9P5xYmN5Lf1KNBueNKDl+I
         lNPxmZ8EdMQKYHl36JMDFEnR04GWrLbdM6Eo4Pi9dMkmyAbWlcbUfQvNaHZxqb2L3jS3
         3RcHBHsu72EnRXcpa0jKiRDct5D+ICaLC77vFxYdW82pHgJ71ot4+wPrMLdKQrZy60ZH
         qTf6xp/4dgXO5mgXk63FyIfTN5VTUchMJtMkS2xq+zmHkyR6w5qoL0FQIx3UxLa9LEZZ
         MVCg==
X-Gm-Message-State: ANoB5plDxd5UiChWa12uuUrRn5EIfYwl/c77C6jVVMxnZ7GIqm7qXSmD
        us0t+fXuWccB7tXtjIOJWeEfEIhVlDg=
X-Google-Smtp-Source: AA0mqf4ULTYzbfuO1jXL9AwmtP2BbudfwlpLYyhMZW16sEQ+6W5t/RVYFye2WVxtIEoTh/ZopmR5Lg==
X-Received: by 2002:a17:90a:d302:b0:20d:2f:709d with SMTP id p2-20020a17090ad30200b0020d002f709dmr5660496pju.40.1668242005943;
        Sat, 12 Nov 2022 00:33:25 -0800 (PST)
Received: from VirtualBox.. ([129.227.152.6])
        by smtp.gmail.com with ESMTPSA id i11-20020a1709026acb00b001870533c443sm3066927plt.236.2022.11.12.00.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 00:33:25 -0800 (PST)
From:   Yuwei Guan <ssawgyw@gmail.com>
X-Google-Original-From: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yuwei.Guan@zeekrlife.com
Subject: [PATCH 2/3] f2fs: cleanup for 'f2fs_tuning_parameters' function
Date:   Sat, 12 Nov 2022 16:32:49 +0800
Message-Id: <20221112083250.295700-3-Yuwei.Guan@zeekrlife.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221112083250.295700-1-Yuwei.Guan@zeekrlife.com>
References: <20221112083250.295700-1-Yuwei.Guan@zeekrlife.com>
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

A cleanup patch for 'f2fs_tuning_parameters' function.

Signed-off-by: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
---
 fs/f2fs/super.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 2f36824ff84b..f18ae5410b2c 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2192,14 +2192,12 @@ static void f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
 
 static void f2fs_tuning_parameters(struct f2fs_sb_info *sbi, bool is_remount)
 {
-	struct f2fs_sm_info *sm_i = SM_I(sbi);
-
 	/* adjust parameters according to the volume size */
-	if (sm_i->main_segments <= SMALL_VOLUME_SEGMENTS) {
+	if (MAIN_SEGS(sbi) <= SMALL_VOLUME_SEGMENTS) {
 		F2FS_OPTION(sbi).alloc_mode = ALLOC_MODE_REUSE;
 		if (f2fs_block_unit_discard(sbi))
-			sm_i->dcc_info->discard_granularity = 1;
-		sm_i->ipu_policy = 1 << F2FS_IPU_FORCE |
+			SM_I(sbi)->dcc_info->discard_granularity = 1;
+		SM_I(sbi)->ipu_policy = 1 << F2FS_IPU_FORCE |
 					1 << F2FS_IPU_HONOR_OPU_WRITE;
 	}
 
-- 
2.34.1

