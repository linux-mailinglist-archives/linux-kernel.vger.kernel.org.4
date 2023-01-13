Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8222266979C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241619AbjAMMpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241846AbjAMMnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:43:46 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBA01263D
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 04:36:18 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id ud5so52042634ejc.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 04:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CtCs8GxpjiNUlKe9jLRTDXiumifJAjD1jl0L4CeLiMA=;
        b=iVjJ3nWfodyyNsQdbwae7vcZ9yAMAWRUHvPDFFsqJ+ZbRLWA7X3Od2Dcrc1o5ASha/
         ijoKbtCtcrhtq3o7HgrmHZIKXgnavTg78URe7orHzD3doZEH0cWgnHM1va4F+kT1vPdv
         QEiei1roTDFPApr4rbDokzLo0mbijR0PndJUPtQR/hBXy0Gc941NCaH7uNlwPLH/M304
         zqE/jQ+ve8/3I1qHy7dmQT098fctIvjnarLt2h7S1sFUPdo0ak8YGHwWz7YC57yrrxX2
         HW5ZmbPMyGQiOq3GGIimgOYzoeUnFrxQrRs7RpFEsh9hNXTjq4QtKHaRxp8fhgEL7zKa
         ViaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CtCs8GxpjiNUlKe9jLRTDXiumifJAjD1jl0L4CeLiMA=;
        b=7gWGlXxnbkmgEgpzRXfTndoUEMI4bjN3FRDoBzrqijzObDmPsFQPqUshmZYEZxDs2S
         ZaOVRG/OTsfXwUBMbdFnA5iK61cNsIng7vNW++YExdQA/WzWZ08x0VxbLw+wmgstRE35
         pLNHSY4imDBLasAc1R1VjzFpBmZlCw6Rs3/GtJ0aLW/a66bv8oFkm0CSvjVaLBdLfH+B
         aMb7Bkb8gcOryIp1flGXSMfSWyHEty6O+jHi5d+zKmjqIIrCztkSoj58wKAVfxFxhmWn
         Yp7HT4mqUr5pFY0+hOrHPGgwEfJ5ULB6Moa9DuN/82hEzwFITnhfQzOJ0P4VUl7aJaJ/
         n08g==
X-Gm-Message-State: AFqh2kokKCEPvqiJIMOAZ7pXSZUsYPEEH6V8sJ5fTYtmVQvdNAymoZw8
        B9/W9rARCR8q7GjVBTIctDdbQVUPe2qVKUXTylI=
X-Google-Smtp-Source: AMrXdXscUQGyihFd72/UBQHujIY3PI028gGBGoZyl+Ii+Ozg85WvOyE0kQeJO4cYA4H80HINGbZLnw==
X-Received: by 2002:a17:906:2d4a:b0:84c:cf42:e16 with SMTP id e10-20020a1709062d4a00b0084ccf420e16mr33260592eji.1.1673613342548;
        Fri, 13 Jan 2023 04:35:42 -0800 (PST)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906329100b007c0bb571da5sm8402496ejw.41.2023.01.13.04.35.41
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
        <christoph.boehmwalder@linbit.com>
Subject: [RESEND PATCH 0/8] Miscellaneous DRBD reorganization
Date:   Fri, 13 Jan 2023 13:35:30 +0100
Message-Id: <20230113123538.144276-1-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.38.1
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

Some more mostly trivial "alignment patches" to (slowly but surely)
move further in the direction of re-upstreaming DRBD.

These should be fairly uncontroversial.

Andreas Gruenbacher (1):
  drbd: drbd_insert_interval(): Clarify comment

Christoph Böhmwalder (5):
  drbd: adjust drbd_limits license header
  drbd: make limits unsigned
  drbd: remove unnecessary assignment in vli_encode_bits
  drbd: remove macros using require_context
  MAINTAINERS: add drbd headers

Lars Ellenberg (1):
  drbd: interval tree: make removing an "empty" interval a no-op

Robert Altnoeder (1):
  drbd: fix DRBD_VOLUME_MAX 65535 -> 65534

 MAINTAINERS                        |   1 +
 drivers/block/drbd/drbd_int.h      |  12 +-
 drivers/block/drbd/drbd_interval.c |   6 +-
 drivers/block/drbd/drbd_vli.h      |   2 +-
 include/linux/drbd_limits.h        | 204 ++++++++++++++---------------
 5 files changed, 110 insertions(+), 115 deletions(-)


base-commit: f596da3efaf4130ff61cd029558845808df9bf99
-- 
2.38.1

