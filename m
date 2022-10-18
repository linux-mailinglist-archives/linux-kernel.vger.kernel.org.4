Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791CF603000
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 17:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiJRPsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 11:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiJRPsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 11:48:18 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AE3C784E;
        Tue, 18 Oct 2022 08:48:17 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id r8-20020a1c4408000000b003c47d5fd475so15334288wma.3;
        Tue, 18 Oct 2022 08:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kc2UL3oN9PPfeSBBUmmfy9LYW7xOBidoFqGgLYVlKcA=;
        b=W1EUJErqwI2NXCdtJ9Mu7EaR4VFf6TjPQL1ld7IX54YqHmGb4ktRhFl2VvKh5l0i0G
         fiyD8pqaXTMxNddJjh612q5s9XYF8//iy/q9fLPWKNoaztcUFQ11nz8R+C3p5rpD6n7u
         bh3VvBRmM4jfg9V84OaNrwosNYbYXNJ6aaT/wNu6OdQBruXsjssrcS1/rVtCV6hBY/OJ
         HAGexQu+CL5joXUFsSNJW67gydLshAeuLwgWx14owa5dOyY01+qaFV9iA+XBJJbqQDjl
         vNGUck0bkM8p6+CRimR7H9/H/F8JlEZEvBMkIm0aF9jxQm33dmb8mX+4lTiPVaKUF4GG
         /1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kc2UL3oN9PPfeSBBUmmfy9LYW7xOBidoFqGgLYVlKcA=;
        b=2nhn7ty83qcYm6l7eKnL4JZiqNLNLuaLNS9tXh+Y6OR6DC1foqC/mjUgZFAfXrsmLS
         835uu2OZ7w6iKzAaDnv1iv7kpLpaD4McbVYvKOmeYuWYIfyXovDXy+hhqVVrY9DPODCt
         Uw0PMI34gYKGr6kEPHMYWdDdbmKBgdDf8QTy4Vltc30q1s7o1O59HC0fdryS6up9SW88
         1V6Gdq2pFVFLiox5yPDepQhCuNpRFzCmJejNMMbGMIGijVOER39DSYQPvhNeYEe8kbKc
         djaxdhrCs9+cBVLvty+xRZGG9h5uB60zDuW5Snp56zqcStvbSs1uak4+bfBvkI8mBIAW
         IsIw==
X-Gm-Message-State: ACrzQf2BCKQz+13Hb+jh2iZ6PotnX7ASACNQWOmCDo3n0dF7gfPe9RNm
        rKDP22+ghnKH54SwEbpCBW3Ab0o/UTzhmgkj
X-Google-Smtp-Source: AMsMyM4dTruaicUT8XNa3C6PP05o/J4zMO34InV/LERpEWhfnsNk8WiCIcj9E4p2iSMt2tAXo6neOA==
X-Received: by 2002:a05:600c:4449:b0:3c6:fb65:2463 with SMTP id v9-20020a05600c444900b003c6fb652463mr2532149wmn.128.1666108096131;
        Tue, 18 Oct 2022 08:48:16 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id r124-20020a1c2b82000000b003bf3fe1d0c4sm14030316wmr.22.2022.10.18.08.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 08:48:15 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dm thin: make const array descs static
Date:   Tue, 18 Oct 2022 16:48:15 +0100
Message-Id: <20221018154815.943209-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Don't populate the read-only const array ramp_base on the stack but
instead make it static. Add in a const to clean up checkpatch warning
too since the data and the pointer are const. Also makes the object
code a little smaller.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/md/dm-thin.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
index e76c96c760a9..d228177fdf35 100644
--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -293,7 +293,7 @@ static enum pool_mode get_pool_mode(struct pool *pool)
 
 static void notify_of_pool_mode_change(struct pool *pool)
 {
-	const char *descs[] = {
+	static const char * const descs[] = {
 		"write",
 		"out-of-data-space",
 		"read-only",
-- 
2.37.3

