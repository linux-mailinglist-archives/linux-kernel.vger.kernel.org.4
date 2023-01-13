Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CF7669796
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241707AbjAMMpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241857AbjAMMnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:43:49 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF0716584
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 04:36:20 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id v6so8991572ejg.6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 04:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQNKuz5965naByKUS4y1VIo8yUx5dsUc2Lu+3dW2kE8=;
        b=Te252XxFJERmj6gsHMX2Ubll+K8vuDQpcz/sz6kK4szts0nTB0oktTg5ouLmIRjLKF
         Zi4O4udWR6to0zU4y5FjIy+WfgYAdAPl/2WYiHxedaBhxqSCXFiCDixV/CsaA31qm7tJ
         ynai0z9jDaha4KBuIJosdtZwVtdFA6yn4MgEsFOm13UnwoMG0wOCFyS+xo2g9Pv0Teh6
         WsGFI9coLfTp7oEzWszSuZfc5ZARh1nXay20UzR7Bb9SWH4hfzkPfXpmbuyAEHS59PNz
         RA6E4YaegtTU5Gcec8wZ9mxcOV4lpje8yFY4O9dpV0y5TGYlrWuVKTrkZ8jCRbdEyE3U
         woPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sQNKuz5965naByKUS4y1VIo8yUx5dsUc2Lu+3dW2kE8=;
        b=3WA4maLWvVCn6kXmvIc46GzgIfxmLTtXDGvD1ynfAFPlQS0xbFd7jXiSpNUlcNxsq8
         jTY/hRWBLOpVnJoys8qTHdi/br5GgAT5D530u6e4Xpi7c9W3+Fu6dImCV34PNXese9Wm
         Kkf/bb3ilTt60go9SUcC+EPbi0bSmcKAHKDBuYz+81JnFKpeGqKAw1JfcBxbfgeE9/J9
         vvWlcy7EHf6thR1AHCMrh4cDY1sDIC4/VZpfGCktSXR1OQel8dIzebTtBiJtSZp1+R5O
         P7BXa3zywIaNPZy15LbweU4uazEWH8SiAbUoShNUH3Kg2cL8j2eXWpqpwesf7s9aV1FI
         hVYQ==
X-Gm-Message-State: AFqh2ko5DQ89eOkQ835bFoGDKwgq2bjd5rD0MZz8a/tqTZR2SaFKJSk7
        H96fCPjkA3Yw/2ow9DKeoZxf3g==
X-Google-Smtp-Source: AMrXdXsHyV5uZaN+B0+k4sLOMGxS6gsjp2oFHq2cCYXc3gkoDk1zoyE97qfqOiUlKxtclhZSmKgEPg==
X-Received: by 2002:a17:907:1710:b0:7c0:c36d:f5df with SMTP id le16-20020a170907171000b007c0c36df5dfmr83242439ejc.70.1673613343347;
        Fri, 13 Jan 2023 04:35:43 -0800 (PST)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906329100b007c0bb571da5sm8402496ejw.41.2023.01.13.04.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 04:35:42 -0800 (PST)
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
Date:   Fri, 13 Jan 2023 13:35:31 +0100
Message-Id: <20230113123538.144276-2-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230113123538.144276-1-christoph.boehmwalder@linbit.com>
References: <20230113123538.144276-1-christoph.boehmwalder@linbit.com>
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

