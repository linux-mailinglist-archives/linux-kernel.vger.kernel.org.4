Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B154648432
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 15:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiLIOxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 09:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiLIOxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 09:53:36 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0ED5C0E3
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 06:53:34 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id l11so3404609edb.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 06:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQNKuz5965naByKUS4y1VIo8yUx5dsUc2Lu+3dW2kE8=;
        b=DULViScp0ZVXctPxlfv4qNn3cbilafSOKGMk8dRJw6i79Vudl6DOMfT79rpjRXPf0h
         Cby/vdu1mbCSR5Pn1rz+wJ/UCZYjXWxxXHWINZiipWv4QJoPQadESG07ukq3PX2z1e2y
         QaX76pV4y0QLJ8BAT8gHsy28rsADUqeOHOembmFs70/VOMQVVf6Ubt31LYagnvEc0GJa
         p8KQ4d9Iw3OGQI2KTwoVqlFWfGfaJcfFe/egS5Kmqj2CN19y216WgrcyU94kOCDH7OOt
         P+yF159+WVZEXSM6ECXkVUZ4IbilDRTHiXQ2/MLbb3HqoB3wSY2oZTo8gVb4MzO7CMJC
         G1hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sQNKuz5965naByKUS4y1VIo8yUx5dsUc2Lu+3dW2kE8=;
        b=gKYPJL2d1rxQ4zWe4UM81aei7iKIm7rJ5l7mmn+BQ2Xzhp27mDop1nP+h1IejmBDV2
         ZE1egERDm1dGlS/u239qwQ2UVmz/J9VrEeAzMzeW2liaOjC1sHDDqp141pc6bsmoJt95
         +59nQJ3hmlsjOQaoHmna1dzA1ekblki7CLe/Gk3nqzl3prafyApOd+v7tNMrbpePLzLe
         B2CRm4/d3VBomPJJQ8t0AiVTa4r0tJ7tBZqGFGjk959Liu2YZmiLt7TzDmKatBpg+9W3
         8kSAKRu6CnEQn3426eh33eDbCUjQm5XM9rvQyU19Kmn6IhCCW1bQ1ttB4wpYCiMElICz
         GmKg==
X-Gm-Message-State: ANoB5pnZCavRh+6glKtzVO17g09UUtNY8n/RDVnPYspcZUG0nExh4cj/
        Pb7S5VyIcApLtQTltqo7/Qa8OA==
X-Google-Smtp-Source: AA0mqf5/exKOQ2UtDww2W1sqkCHfaWxm6TJeIW8pBJLUQGIbDQbARma3JEOCV+NUeA1Xc09JANibUw==
X-Received: by 2002:a05:6402:25c7:b0:461:c5b4:a7d0 with SMTP id x7-20020a05640225c700b00461c5b4a7d0mr5638007edb.24.1670597612854;
        Fri, 09 Dec 2022 06:53:32 -0800 (PST)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id bd21-20020a056402207500b0046bb7503d9asm728424edb.24.2022.12.09.06.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 06:53:32 -0800 (PST)
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
Subject: [PATCH 1/8] drbd: adjust drbd_limits license header
Date:   Fri,  9 Dec 2022 15:53:20 +0100
Message-Id: <20221209145327.2272271-2-christoph.boehmwalder@linbit.com>
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

See also commit 93c68cc46a07 ("drbd: use consistent license"). We only
want to license drbd under GPL-2.0, so use the corresponding SPDX header
consistently.

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
Reviewed-by: Joel Colledge <joel.colledge@linbit.com>
---
 include/linux/drbd_limits.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/drbd_limits.h b/include/linux/drbd_limits.h
index 9e33f7038bea..d64271ccece4 100644
--- a/include/linux/drbd_limits.h
+++ b/include/linux/drbd_limits.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
   drbd_limits.h
   This file is part of DRBD by Philipp Reisner and Lars Ellenberg.
-- 
2.38.1

