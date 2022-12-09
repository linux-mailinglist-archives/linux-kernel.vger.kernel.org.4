Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D4C64843F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 15:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiLIOyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 09:54:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiLIOxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 09:53:45 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66B961533
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 06:53:39 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id f7so3391091edc.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 06:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8l6YI6ll5WTtemsFOxZHnG0tRV3sgRpFSwrNSjhQUI=;
        b=QFl7VoOtaGk5JJJiTD/4KIC5FLgDPhNuBOMrb3WnSAoODL2ltc52rELA5f6yl7Bn7j
         mYbNUsXfDCJ75uQrG1lZrpy8vrWDSlLuNc+DwsQQohwm/k745BMOpiYBdnk8YyDlL9Fq
         7eDn+Dtw+CSLH6wmrmqvtN68OZ461bwi3ogQi4pmiDXFrr15Amw9K+7sAjoYiCPtv/mc
         PMf+aDonj+6iew+Dh+5hsyQ1LSgQ6rvpmF51QrTg0U24d6fmLo6yxPrsR37jHc1CbRMJ
         tBqK9JcG0+r3Xk6QRttN7gv2gLonVRU/cK8VMDIfHh+fZ3qa8enXQbuW2vEfMals9jM0
         IO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w8l6YI6ll5WTtemsFOxZHnG0tRV3sgRpFSwrNSjhQUI=;
        b=xdkgeFbxGJZsx5APOJbiRzN3HV3uTepvAYmp1Ymp+blzgyiJqgWbzjpb/OU7OaFltN
         oJMid/bkZETcgbfUzUwyLmsCroKdsxAB98PwEZEqVH8/T2C94ST3mlQwikdF1vvqoh8Y
         Nd8I6iBvcj2SKxhFdN6aiAHfR4MubpZoY6YUEEJghTDpUv3vOl78Y/Maw3Rs52jtoZaF
         kgZS06egSUNaOaN9VVfHjg444+GKmptuX+Sz0lu3sDWPulbQOR3/RamnLo3Hd+u3nyZ8
         +kR/jDkANsmeM4Iw8ooBiJ/8LxcH4E9R1ht+LfM95+Z3TEs+hKuTFbu3pc17btXC1vd7
         Uprg==
X-Gm-Message-State: ANoB5plmMTEJRLJBUjBCh4dyhICCChghrv3BzQCOlPi7qyLZp6ZZ+knJ
        uR3NVfGy+DqEA9EBUGV0XIohcg==
X-Google-Smtp-Source: AA0mqf7iTbuKTrRATtfWNUUyFaIEQ2x3dRPnmp/q01kefuttCVcLa6LUxjn6tqOZ2JV/H/DHj4tTxw==
X-Received: by 2002:aa7:cd46:0:b0:46d:e3f8:4ed4 with SMTP id v6-20020aa7cd46000000b0046de3f84ed4mr2215720edw.21.1670597618194;
        Fri, 09 Dec 2022 06:53:38 -0800 (PST)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id bd21-20020a056402207500b0046bb7503d9asm728424edb.24.2022.12.09.06.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 06:53:37 -0800 (PST)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        Andreas Gruenbacher <agruen@linbit.com>,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: [PATCH 8/8] drbd: drbd_insert_interval(): Clarify comment
Date:   Fri,  9 Dec 2022 15:53:27 +0100
Message-Id: <20221209145327.2272271-9-christoph.boehmwalder@linbit.com>
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

From: Andreas Gruenbacher <agruen@linbit.com>

Signed-off-by: Andreas Gruenbacher <agruen@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_interval.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_interval.c b/drivers/block/drbd/drbd_interval.c
index b6aaf0d4d85b..873beda6de24 100644
--- a/drivers/block/drbd/drbd_interval.c
+++ b/drivers/block/drbd/drbd_interval.c
@@ -58,7 +58,7 @@ drbd_insert_interval(struct rb_root *root, struct drbd_interval *this)
  * drbd_contains_interval  -  check if a tree contains a given interval
  * @root:	red black tree root
  * @sector:	start sector of @interval
- * @interval:	may not be a valid pointer
+ * @interval:	may be an invalid pointer
  *
  * Returns if the tree contains the node @interval with start sector @start.
  * Does not dereference @interval until @interval is known to be a valid object
-- 
2.38.1

