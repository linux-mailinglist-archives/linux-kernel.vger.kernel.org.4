Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68197714841
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 12:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbjE2K7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 06:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbjE2K7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 06:59:41 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708A9E4
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 03:59:39 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-64d426e63baso3657027b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 03:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685357978; x=1687949978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ep47zFrzrdEJ44Hqc9XXjwqqYSSyPX231+NhLADfiSE=;
        b=BA2fC5N1ViNb2dN8CaIv6BZ9CCv38VCwNNvuctEjmYMVKzxpEkHud0V5SJbJaSgXw9
         zoplBdEAGJ0tbsPTqJx9bbZJGJirQztqVYGv7Qt4y1oMhENq68yp0BESuTZTgigN57Yr
         I08pIgJyGduPlNM/ePTDS9TqbTkXwo8PkOayh0vlouWBXRqcEGUQcyEXdm/V6/hnHeSf
         e0soX/X499Z8kzDESYgjPkSOWcWDextsasMh4MXWHrbx/dNuZCpu14Ni4Z5UOKKgueyy
         sZF4OkVi4l4Br7QuLAvZIuSwNe22BG8fNXhdm2RTagOXVbR3BB+GU43dNHl9pcamn5Pi
         KkWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685357978; x=1687949978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ep47zFrzrdEJ44Hqc9XXjwqqYSSyPX231+NhLADfiSE=;
        b=FHGb4qwXxXVfwgSyJexM0ryZ9Y4sFrHEhyFPG41zX7bIA+PZXLl2zD5NVxozRQJW7y
         8dblAm4yrmR6vvaRIMZWBo6FKrbKnTh5zp4vDsJVwCKcpQ8SB8X3wJlMkaDrNppQunW8
         +7pCMCs5YTUsB4+tU4DKfNS6mXo/HA18qcu168HDrAslCIuU/b/R5r8g8nXxvMyziLvx
         NQOepi/w65JKj3dUExrT3wYR0fOZBZYUqqU0PsOG5vpYNJGNnNI1QUDrrhmIWL1bFivx
         ScYSGHoAv4eUHM4mr+PKqsORncacPpbYWlNwXyaRVVxIIXgdBTOmEU5sITvZl0j5gBCl
         LLSw==
X-Gm-Message-State: AC+VfDzYkvNuGrdWU/tKT6yhuiflAVafgtctGwzFuaFUVCxMkyC+GHsG
        /cgFOv+wgck0sVyIF7FWxHw=
X-Google-Smtp-Source: ACHHUZ5d174/h7CwQtC7Bod/+WNGrMAoyHWHrWbfqf3DkpTp/xsWlFE4CKHSjR1+BQpvsXQDE83POw==
X-Received: by 2002:a05:6a20:d705:b0:107:10b6:4c84 with SMTP id iz5-20020a056a20d70500b0010710b64c84mr8144873pzb.21.1685357978667;
        Mon, 29 May 2023 03:59:38 -0700 (PDT)
Received: from localhost.localdomain ([143.92.64.20])
        by smtp.gmail.com with ESMTPSA id v7-20020a63d547000000b0053f22b76cdcsm6863110pgi.82.2023.05.29.03.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 03:59:38 -0700 (PDT)
From:   "brookxu.cn" <brookxu.cn@gmail.com>
To:     kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 4/4] nvme-tcp: remove admin_q quiescing from nvme_tcp_teardown_io_queues
Date:   Mon, 29 May 2023 18:59:26 +0800
Message-Id: <1976b5b41456b03a3c5acf68f25b8f6c0873da92.1685350577.git.chunguang.xu@shopee.com>
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

remove admin q quiescing form nvme_tcp_teardown_io_queues(),
as it will done by nvme_tcp_teardown_admin_queue() and other
functions.

Signed-off-by: Chunguang Xu <chunguang.xu@shopee.com>
---
 drivers/nvme/host/tcp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index cfebcae7fc9b..75f39a02e685 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2020,7 +2020,6 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
 {
 	if (ctrl->queue_count <= 1)
 		return;
-	nvme_quiesce_admin_queue(ctrl);
 	nvme_start_freeze(ctrl);
 	nvme_quiesce_io_queues(ctrl);
 	nvme_sync_io_queues(ctrl);
-- 
2.25.1

