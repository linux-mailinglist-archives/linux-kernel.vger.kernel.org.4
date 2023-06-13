Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF8472EA53
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 19:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbjFMR5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 13:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjFMR5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 13:57:09 -0400
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342BB13E
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 10:57:08 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-3f8d61cb36cso5888745e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 10:57:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686679026; x=1689271026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WN82Z//hA8DCGnigkJsaIDeW/GJCYIky/AxnHlgXepY=;
        b=XuBvJ82r6jVqwTGPb4VzDV2bKoqZEWlOyuWKZDF8zXn3+qdn3n8wOarKIglSN/WoG9
         u9q+fX1cwov7EIb3X5xMuOjMQ/Khi2izi5A03FXDOyT4z2HgrQ06ngtWfPz9oJbMavSJ
         XTW9OQIGzEIeQbZit3aF/b006ey0ww4C/yTSS9plpBuZryLGYZQHIHkXMyYL7dujdFba
         YqLl/uPHrgFtsxzbJ5JrjoHqWSnSU1dG9xeN12W2wnw2c/g6ACDB8m/+vHhRbIX728fZ
         H+opzBvrLxGkcq+qj38SyMnuYuRobi11uNaEYZmEWmEkv2a+f5kebP+nssMkXHh78YFH
         U+Qw==
X-Gm-Message-State: AC+VfDx7vjvyLMAxdtLnxfSx3rBhntFxtDoFQmgM60Ieqctru5lkRWVM
        k1UqlYZzb/PMaUffMBv3QFN6/AfDJ9I=
X-Google-Smtp-Source: ACHHUZ4SvIkjRYigE3R7EfXa2NFlEKkpMNeBI7KHYvVwGTof6n1wmdR157IKfm7DOfWOMvfDXj+mQQ==
X-Received: by 2002:a7b:cc84:0:b0:3f6:476:915 with SMTP id p4-20020a7bcc84000000b003f604760915mr10289073wma.6.1686679026365;
        Tue, 13 Jun 2023 10:57:06 -0700 (PDT)
Received: from localhost (fwdproxy-cln-116.fbsv.net. [2a03:2880:31ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id e8-20020adff348000000b00304adbeeabbsm16029549wrp.99.2023.06.13.10.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 10:57:05 -0700 (PDT)
From:   Breno Leitao <leitao@debian.org>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     leit@fb.com,
        linux-nvme@lists.infradead.org (open list:NVM EXPRESS DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] nvme: Print capabilities changes just once
Date:   Tue, 13 Jun 2023 10:55:37 -0700
Message-Id: <20230613175538.331639-1-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This current dev_info() could be very verbose and being printed very
frequently depending on some userspace application sending some specific
commands.

Let's turn it into a dev_info_once(), since it is not useful to know
about it all the time.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3ec38e2b9173..459e5a84e596 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1134,7 +1134,7 @@ void nvme_passthru_end(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u32 effects,
 		mutex_unlock(&ctrl->scan_lock);
 	}
 	if (effects & NVME_CMD_EFFECTS_CCC) {
-		dev_info(ctrl->device,
+		dev_info_once(ctrl->device,
 "controller capabilities changed, reset may be required to take effect.\n");
 	}
 	if (effects & (NVME_CMD_EFFECTS_NIC | NVME_CMD_EFFECTS_NCC)) {
-- 
2.34.1

