Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1B3714844
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 12:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjE2K7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 06:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbjE2K7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 06:59:37 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A90CD
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 03:59:36 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-64fec2e0e25so190186b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 03:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685357976; x=1687949976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14IeKFKyO0pcEcP2T20UmiR679IiGg3A2D145C6b2n0=;
        b=rtw4s0zcr86QVVIPEt0FBcZ14qSZwrUwBbG7EXWGEcEazWjxryPP+540XqF70NitCE
         m4wWSIy0DTOxYr9NASRF2v7CsqTg0L+s5CnP+ocad2v8kmMkjfy+JEF/U6B8BTnhgZtX
         Ow+lQq2udEM8cV7mfH6vX7dLsIAwwK+FolvsM/oG5PGQ0HDbSmWenyzkbX+t4h/Avij1
         bsc4V34eTOynYW/TlICn+55fQtzAVuG3fMkLrrtYHOVSBttRhYtG95miMjY5hZ0CgT+6
         4wFhAJE5uba/FwMSfNzeeSPzRMNz42R8nIx6rP3ZuPXazLhAvaoXDxITLUKWpyNmItzZ
         5r3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685357976; x=1687949976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=14IeKFKyO0pcEcP2T20UmiR679IiGg3A2D145C6b2n0=;
        b=k9smefYk0XomFJsbnWrrDhAuqQmsZxVQ4BjKPpxopkb7DUW6oVQaUCjnIjF5vZT77i
         YnMWWWT0idx841GTheoaz4iCI9s7IRpFJAUPBoiZrrzCDZLcAWx7bKTmSwFCJz6dcYps
         ckWpAxwWL5RLghczqInRyVFlB3T2JLJmROwdUaVbox8o+YzfRM1IkUaTwGfFw56t3enj
         IiWXWsTnMJFAww2qHdGx5npS8Es1QpifCYs+lp2iNwOOXoXkZSLzQdjhGuscDCSAfm7p
         MHNX2MXz3Yau5oofmzZQXyGPUC7PfKVpV7PNQnJD3uFcAKysB+80XrQFKskEa0HZfyWN
         uTCA==
X-Gm-Message-State: AC+VfDwwX8n+VgORXZqwYsTliMTG5yVIUqxa86DBp7S8tojWyQQBxMER
        ruprnUm1nP0TOQQ2wLT3WQk=
X-Google-Smtp-Source: ACHHUZ7I+haGz9+NyjW+6/WdCddkapRJgOEh18pWpXYq10OABHqcb4cm/F8vXLMGzrJL7vwCVhZh5A==
X-Received: by 2002:a05:6a20:8428:b0:10c:b441:5bd3 with SMTP id c40-20020a056a20842800b0010cb4415bd3mr8901649pzd.11.1685357976278;
        Mon, 29 May 2023 03:59:36 -0700 (PDT)
Received: from localhost.localdomain ([143.92.64.20])
        by smtp.gmail.com with ESMTPSA id v7-20020a63d547000000b0053f22b76cdcsm6863110pgi.82.2023.05.29.03.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 03:59:35 -0700 (PDT)
From:   "brookxu.cn" <brookxu.cn@gmail.com>
To:     kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/4] nvme: optimize nvme_check_ready() for NVME_CTRL_DELETING_NOIO
Date:   Mon, 29 May 2023 18:59:25 +0800
Message-Id: <32d00d1689773fcb2a177ca3ce89a3b12c1fa4c5.1685350577.git.chunguang.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685350577.git.chunguang.xu@shopee.com>
References: <cover.1685350577.git.chunguang.xu@shopee.com>
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

From: Chunguang Xu <chunguang.xu@shopee.com>

nvme_check_ready() will directly return queue_alive while
controller is NVME_CTRL_DELETING, maybe we should do the
same things for NVME_CTRL_DELETING_NOIO.

Signed-off-by: Chunguang Xu <chunguang.xu@shopee.com>
---
 drivers/nvme/host/nvme.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a2d4f59e0535..35066ad10cd9 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -793,7 +793,8 @@ static inline bool nvme_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
 	if (likely(ctrl->state == NVME_CTRL_LIVE))
 		return true;
 	if (ctrl->ops->flags & NVME_F_FABRICS &&
-	    ctrl->state == NVME_CTRL_DELETING)
+	    (ctrl->state == NVME_CTRL_DELETING ||
+	     ctrl->state == NVME_CTRL_DELETING_NOIO))
 		return queue_live;
 	return __nvme_check_ready(ctrl, rq, queue_live);
 }
-- 
2.25.1

