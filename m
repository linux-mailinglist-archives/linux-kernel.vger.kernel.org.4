Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13FCC714843
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 12:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbjE2K7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 06:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjE2K7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 06:59:35 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E9BB2
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 03:59:34 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-64f47448aeaso2317121b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 03:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685357974; x=1687949974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=63KAqVVdXGOoTrSylFFLhnHQleDcSgfdSMcTbn9SMvM=;
        b=oiRjRhuNdihyDtRj+itgk5qVaD+34X0RfxNTyBxmlm4vY8ELsjSxUz0O1elP8t9f0S
         yl3FEaNNR3nohNXCGbFai7uzra7YrPJWEy8wft+1ozLwGRaK8tgIGyq7mBG7Dxm/qi1P
         P+gTHnb9AaarJWzOpYCrYC7Az8hBU8y14pKdc/YuH/3DL9AUNmqaJZYNUOa6W0EQ69n3
         u67bXvHhHso46v+9DH55bCwp3UA7FDUsOyAe3Vs66Mt4VqH6e6aO7ZHsLZaCSN+UnLqp
         ruOyNwYAcwzLPgF49it5/8CDzSqj3yt77nHPZxLaH4ZSOGG2i4lGlgW0vPNt/AKPgwBk
         /4gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685357974; x=1687949974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=63KAqVVdXGOoTrSylFFLhnHQleDcSgfdSMcTbn9SMvM=;
        b=d5WX4pernuCjBOpTcUVyb7LahRBgZeP1dyJCRpHllyEM0Qsh43SgPxh1uY+SNGIrjE
         2zVIwTXrjR2rttD7ncbj0zRksVz3a9dZHfn7ySCGA1AoeK5VcJQ9pCXzxS8mClJK7IER
         w447XyWwxEfKjMOZyomyC+/ycmDF56PnKPIaWDIUddZ6B6xG0CuXDm+jlTYygWQUPKxz
         zRCkXPx78+f/0reGn44z5wPzWRxs3PHU7s7qwG2GnzG04FI4NsqHpnjhaZmgYdv11Qni
         syzR/PFxWupqyNIx3bD1Fe5QJc7WaoGdS6ep+CLfJihr1mwMi5d5SRqNURx11H2p/l6I
         x0Og==
X-Gm-Message-State: AC+VfDy0050h4jo87Lqlc7J6rg2o9h7GdSK4EWW9kNKst4R0awb5tFJR
        kPGSP7YaG5Yi+26md/Mo41k=
X-Google-Smtp-Source: ACHHUZ4h0oIv5BoInIChTF6doTA25m5LmNP6412qwvIAH1L0J0bj9+NiqrJQcu5Qd3qNfQLeOGhhQg==
X-Received: by 2002:a05:6a21:32a2:b0:10f:96aa:9e4a with SMTP id yt34-20020a056a2132a200b0010f96aa9e4amr9774800pzb.2.1685357974245;
        Mon, 29 May 2023 03:59:34 -0700 (PDT)
Received: from localhost.localdomain ([143.92.64.20])
        by smtp.gmail.com with ESMTPSA id v7-20020a63d547000000b0053f22b76cdcsm6863110pgi.82.2023.05.29.03.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 03:59:33 -0700 (PDT)
From:   "brookxu.cn" <brookxu.cn@gmail.com>
To:     kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/4] nvme: donot retry request for NVME_CTRL_DELETING_NOIO
Date:   Mon, 29 May 2023 18:59:24 +0800
Message-Id: <41041f049985675f95a38bdd8bb998c5a4ab140c.1685350577.git.chunguang.xu@shopee.com>
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

According to NVME_CTRL_DELETING_NOIO definition, we should
not requeue any request while controller at this state.

Signed-off-by: Chunguang Xu <chunguang.xu@shopee.com>
---
 drivers/nvme/host/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1f0cbb77b249..304eb4eda6c4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -346,6 +346,8 @@ enum nvme_disposition {
 
 static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
 {
+	struct nvme_ctrl *ctrl = nvme_req(req)->ctrl;
+
 	if (likely(nvme_req(req)->status == 0))
 		return COMPLETE;
 
@@ -362,7 +364,8 @@ static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
 		    blk_queue_dying(req->q))
 			return FAILOVER;
 	} else {
-		if (blk_queue_dying(req->q))
+		if (ctrl->state == NVME_CTRL_DELETING_NOIO ||
+		    blk_queue_dying(req->q))
 			return COMPLETE;
 	}
 
-- 
2.25.1

