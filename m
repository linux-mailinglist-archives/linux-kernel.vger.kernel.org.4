Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E44602392
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 06:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbiJRE4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 00:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiJRE4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 00:56:07 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6493A2AAE
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 21:56:01 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id h185so12311080pgc.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 21:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z6j2M3ywUHsS1+ykQ/OfNhi067lR0Bt99BN92Wk+zcw=;
        b=H4tQqYyGb10hilriYTv+DvIcK69suR/MknRv/uI/c7Sq8IVi/fkI5CgIYlaPZTn3R3
         fcnApKLzJ2JC3QxaMOGgeKe9UHO+kkbWQ0logwCwtTSA1l45M7ttQfjxjlmDarqRhC/q
         +YH2hyuuTFmys4kuUH7wG9CPoEgVf6/DURZSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z6j2M3ywUHsS1+ykQ/OfNhi067lR0Bt99BN92Wk+zcw=;
        b=s5uiRztdyFh6JDyd40dx7FiK2xryZfvNxNa5yLUMZy2UuqQfMcPYn2C1pkgcv5j+K5
         fcVfStp5WpoID7ok/iCugO47uLMnkvaG8rVUqWUao66aqgzNIvjLivH2K75g/jDw0DW8
         EumFSBxUYmWPo1rqCm54PdTnGNJWJp+pujPYjnSI6xf5u8akFwbqTJAWXMoQhOWN9o3r
         m9NaJeKtBZ1vTwMOOUtwMsdm/rx/RstnOGRWsBq9+YgqLOK+LGBuS3qunx0BP8N6iYWr
         W1qB6iZvyfO/aQWegx3BpKayaGtbsKL5DxFuLShdZ1bWOQ4KZz1tFDBxyM9JQRRusFHx
         lLJA==
X-Gm-Message-State: ACrzQf0dkoA2ONEkZM4oGGas5IrMsTk0s6TUNpyu/xS9XRUYtM/bQG9H
        77Dm6rjB8IJLo84FY4D7+QSK5Q==
X-Google-Smtp-Source: AMsMyM4x6naz3nZNmfa/NQmCK6M9uAvOmZsk0imfFXfuxX/g0/1/X6ammsTwTiolzSPSQ6r1RUIKpQ==
X-Received: by 2002:a65:6849:0:b0:461:8779:2452 with SMTP id q9-20020a656849000000b0046187792452mr1089661pgt.383.1666068961162;
        Mon, 17 Oct 2022 21:56:01 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:17a9:73b0:c262:eccd])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902e74400b0017b69f99321sm7549220plf.219.2022.10.17.21.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 21:56:00 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv4 8/9] zram: Clarify writeback_store() comment
Date:   Tue, 18 Oct 2022 13:55:32 +0900
Message-Id: <20221018045533.2396670-9-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221018045533.2396670-1-senozhatsky@chromium.org>
References: <20221018045533.2396670-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re-phrase writeback BIO error comment.

Reported-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 5d760467e0bc..6b56f6f2ce82 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -758,8 +758,12 @@ static ssize_t writeback_store(struct device *dev,
 			zram_clear_flag(zram, index, ZRAM_IDLE);
 			zram_slot_unlock(zram, index);
 			/*
-			 * Return last IO error unless every IO were
-			 * not suceeded.
+			 * BIO errors are not fatal, we continue and simply
+			 * attempt to writeback the remaining objects (pages).
+			 * At the same time we need to signal user-space that
+			 * some writes (at least one, but also could be all of
+			 * them) were not successful and we do so by returning
+			 * the most recent BIO error.
 			 */
 			ret = err;
 			continue;
-- 
2.38.0.413.g74048e4d9e-goog

