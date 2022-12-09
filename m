Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6439648436
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 15:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbiLIOxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 09:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiLIOxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 09:53:37 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6B551311
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 06:53:36 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id z92so3425981ede.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 06:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8SGWONfVHjklNBkXRu6sFYgnXokffLko1IC/BWEcSP8=;
        b=CFMhSCPpgXLUtR6ZiK2YFnEjmqjxsmtam0ueM6OrVLZCwoq1Oilpg6M5PZJ5VDSeRY
         2nE9gDgF744dYJmapJAukrxcvxghsFbizFHO8pW5DKE2bzJ3FsilMaxka5dKBEWkrFR4
         bxIYOOHLxBKLfut+dvsdXvJml72ts9e+HPqwQ4iEBjXFew8vsZmblks6fGeIbkP2nGs8
         tyYw5HkvY8I//dTSV7SXupiPcIQdsZUp8TVf4DuVTEdPoxPhV+9siPeVNOT9GGlyGMBc
         mIchahEZyIMQQwH165aDUoaTh7N0GnYCdaLRx0RV38O0s9CtpE6NIeVbckZg5bXk6bN6
         gveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8SGWONfVHjklNBkXRu6sFYgnXokffLko1IC/BWEcSP8=;
        b=I+IYvfSQ1v1THdtQvp8wsJHBbYTs7VetbemYdlZJpCTl66GBhNaNCHJnonv2YsQdJ1
         Zf8abpBnu7vPlhZbY/mxE/5g8U60k5no01xPu6bzIwz52FWOot+dSN6V5Nzolr9NU7ya
         D/POeUfBrRC6xplwRpObHKY0OsFMIChg/FhoNgzM2p6hll9/klHNP2kBQXicRla3q0gk
         3T4BWNMfMR2Dc6x3SkOICUSugOIiaAylp+81QVtqEbOf2UX+J/OT7teJ4KUxHKpnXOzY
         3Ud42EP/RF4a2gSOfS5PO9lScmZ93UUxynqL+DePCouG46TcvNADt6nBUu/bySaoz2ow
         pilQ==
X-Gm-Message-State: ANoB5pl/k6j50ngpijJo9Ww0K9B0dWBT0cQiDNSKHe163qBeP5IL9knx
        42a93UKgxw6FFeYb5kmyW2zjtA==
X-Google-Smtp-Source: AA0mqf5B8665LOfSRiKHkdYlF7U7pudYJLGfAmYc2LJBFOdrl94ZlNt0ilq4X+thHNKv4jvSoQf7Ew==
X-Received: by 2002:a05:6402:1f06:b0:461:7da0:f85a with SMTP id b6-20020a0564021f0600b004617da0f85amr5871865edb.5.1670597615018;
        Fri, 09 Dec 2022 06:53:35 -0800 (PST)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id bd21-20020a056402207500b0046bb7503d9asm728424edb.24.2022.12.09.06.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 06:53:34 -0800 (PST)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>,
        Joel Colledge <joel.colledge@linbit.com>
Subject: [PATCH 4/8] drbd: remove unnecessary assignment in vli_encode_bits
Date:   Fri,  9 Dec 2022 15:53:23 +0100
Message-Id: <20221209145327.2272271-5-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221209145327.2272271-1-christoph.boehmwalder@linbit.com>
References: <20221209145327.2272271-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
Reviewed-by: Joel Colledge <joel.colledge@linbit.com>
---
 drivers/block/drbd/drbd_vli.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_vli.h b/drivers/block/drbd/drbd_vli.h
index 1ee81e3c2152..941c511cc4da 100644
--- a/drivers/block/drbd/drbd_vli.h
+++ b/drivers/block/drbd/drbd_vli.h
@@ -327,7 +327,7 @@ static inline int bitstream_get_bits(struct bitstream *bs, u64 *out, int bits)
  */
 static inline int vli_encode_bits(struct bitstream *bs, u64 in)
 {
-	u64 code = code;
+	u64 code;
 	int bits = __vli_encode_bits(&code, in);
 
 	if (bits <= 0)
-- 
2.38.1

