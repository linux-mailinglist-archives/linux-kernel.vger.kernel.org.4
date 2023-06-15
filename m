Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD49730C9F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 03:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237123AbjFOBbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 21:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjFOBbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 21:31:32 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63181212D
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 18:31:31 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b3dd3ca7adso28305915ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 18:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686792691; x=1689384691;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hx/F41WmoagRHV/54mU3GIZ0Rr4r8+ldlSacsREhph0=;
        b=RlbJpt/LYH+6wShImnDyT/vnic79PMh24HXKnIOo2SBShDTz6PgzaEV8qDJwyuSSwv
         Kv/C+msLxEQjsxmv+SScprcnneAD/ul0vJaLDiffndK/A1oVu5zvrrSRBVlcIeygc9It
         aEwsENZb0IstuPWrUi5VWjzEhHz1syRUYcrq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686792691; x=1689384691;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hx/F41WmoagRHV/54mU3GIZ0Rr4r8+ldlSacsREhph0=;
        b=fZ0Xcibuh+Esoemp4CrUyOxgf13JqPts5tCAalfBaC6dMnZ5Xnp+JNn8Fnc6h67KOd
         SYVzEO7KvBT/e8jPu0zcwBDST6XPUgtv+dLdMDoxqMFWEoJPCps51e81R6Jg+lNUUvhx
         YN2QBNvUEq27suYKIPb6k3+BnFtNHhCiWyqMdcHqLvtfw/FibkDJ9QW+6SKq0QJbTX1v
         qNCrB/qyvHBKOLDjN5kr9sCUINntTaAHrZA50jpB4YfxzPr84K6r0u9Eg8otdvuJfDNQ
         eQ/iARml04qJAqmvGX18gKuWXVgCaeWLkmSoT2f0YN9PvUo9KTWvOyun7JEuduNJcXTS
         XFpw==
X-Gm-Message-State: AC+VfDxagfPcGl/vKjAlU+w7r+SWGxWH8rZJ0ut2t1cDJm/bxhLkXk/Q
        M1eNbFhLC+z81WE74LkmQxMYbg==
X-Google-Smtp-Source: ACHHUZ6imJV4tdkMAZGbqKKz9yGtfgME6SpsoWFSbHJHRTkI03u6IBqYRU7NSiIC5O+8Kpr8vFtBSQ==
X-Received: by 2002:a17:903:32c7:b0:1b0:4c32:5d6d with SMTP id i7-20020a17090332c700b001b04c325d6dmr18495150plr.31.1686792690899;
        Wed, 14 Jun 2023 18:31:30 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:e1a3:812:fed0:eeab])
        by smtp.gmail.com with ESMTPSA id w22-20020a170902d71600b001a64851087bsm3925829ply.272.2023.06.14.18.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 18:31:30 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Brian Geffon <bgeffon@google.com>
Subject: [PATCHv2] zram: further limit recompression threshold
Date:   Thu, 15 Jun 2023 10:30:20 +0900
Message-ID: <20230615013122.3564479-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recompression threshold should be below huge-size-class watermark.
Any object larger than huge-size-class is a "huge object" and
occupies a whole physical page on the zsmalloc side, in other
words it's incompressible, as far as zsmalloc is concerned.

Suggested-by: Brian Geffon <bgeffon@google.com>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 1867f378b319..5676e6dd5b16 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1753,7 +1753,7 @@ static ssize_t recompress_store(struct device *dev,
 		}
 	}
 
-	if (threshold >= PAGE_SIZE)
+	if (threshold >= huge_class_size)
 		return -EINVAL;
 
 	down_read(&zram->init_lock);
-- 
2.41.0.162.gfafddb0af9-goog

