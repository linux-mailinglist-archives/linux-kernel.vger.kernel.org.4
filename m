Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5B766979A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241712AbjAMMpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:45:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241943AbjAMMoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:44:11 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9C33E86B
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 04:36:27 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id c17so30961013edj.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 04:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ROtOQl0iT4Ua6doSdkwJJ3Gv1mhqQe8GXYrZrg3slxM=;
        b=ErKW/TxlAkHOp6yWMyc0PYQKS3vas/8+4CtSulX5ZBNX8lQJcb++ZtigEvatXIzNe6
         kD/LuncciPfQjSE7BmEZmrNUraJOcS5aSzS/KWkviHFHVa2WlI/nfg+ZtDDC2x5ICv54
         WJqdCuKUi2pca6TXQdejgPN0R4Od9CDVv8/ZKl+aT3b3Cm75o9M0XqbyIQ5azzLuukGo
         5QfuG83/H2UTMigQgtM/ZeE4MqN4JhZAvmMQLIaxKSRUzCtrwY5GDjyRjlzCrctba+OQ
         ky9Dl5f6NcgrF5Fzc+xUf/eVUlIlSETcnSby4Itn790wXKydl9L8q+QMudSDkFFGDrNF
         tXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ROtOQl0iT4Ua6doSdkwJJ3Gv1mhqQe8GXYrZrg3slxM=;
        b=PTKWHPT3vRQtB03SEEztnveyWdGgSj9L5jusTfMYYKI91ODSSwUPBedzEuE4GHD7X8
         tiICTnGHC0zogQ9r8hFzsOCu5vqba3cq4utInpEolRv7KTPwnWJx2+3CUIsxWdT7St+B
         oVZpiAZ76fWsjG+vQfj2bHUs6CQSgnXSPZxbaY3AcECFZMxupsh+Q8KNrWHWLrOuiWpu
         zK+CHmgitjx4yaTKKOXYWV+Q7lvoztghswoUGFOmyXHqAn6443C2qmEi9qpVFOXaTyNH
         efe6VK30TwhvwChANOyi6NC7Ia6Y5qI4RWWxIGt4X7QDllymGdLQTFNTGApKmFNqSd1F
         nbdA==
X-Gm-Message-State: AFqh2kqlqk4ebHWo+xvrVlLouwZBtJcJMw1K2fLFHshabyMIkopVpca4
        fQFBO8myAldY1nCZWnv6Linnsg==
X-Google-Smtp-Source: AMrXdXsG7JRoo4+Hp7wbro81KZ3BeWAye4WXsbiO+i6r7mLULfUsoBiLYp9o21eoMeL3awA+AfhBtQ==
X-Received: by 2002:aa7:cad0:0:b0:492:8207:f2ba with SMTP id l16-20020aa7cad0000000b004928207f2bamr24829569edt.1.1673613346743;
        Fri, 13 Jan 2023 04:35:46 -0800 (PST)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906329100b007c0bb571da5sm8402496ejw.41.2023.01.13.04.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 04:35:46 -0800 (PST)
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
Subject: [PATCH 5/8] drbd: remove macros using require_context
Date:   Fri, 13 Jan 2023 13:35:35 +0100
Message-Id: <20230113123538.144276-6-christoph.boehmwalder@linbit.com>
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

This require_context attribute originated in a proposed sparse patch by
Philipp Reisner back in 2008. Johannes Berg had a different solution to
a similar problem, and that patch "won" in the end; so the require_context
thing never got merged. The whole history can be read at [0].

DRBD kept using these annotations anyway for a while. Nowadays, on a
modern unmodified sparse, they obviously do nothing, and they are hardly
used anymore anyway.

So, just remove the definitions of these macros.

[0] https://www.spinics.net/lists/linux-sparse/msg01150.html

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
Reviewed-by: Joel Colledge <joel.colledge@linbit.com>
---
 drivers/block/drbd/drbd_int.h | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index ae713338aa46..edce1f7ac2da 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -39,16 +39,6 @@
 #include "drbd_protocol.h"
 #include "drbd_polymorph_printk.h"
 
-#ifdef __CHECKER__
-# define __protected_by(x)       __attribute__((require_context(x,1,999,"rdwr")))
-# define __protected_read_by(x)  __attribute__((require_context(x,1,999,"read")))
-# define __protected_write_by(x) __attribute__((require_context(x,1,999,"write")))
-#else
-# define __protected_by(x)
-# define __protected_read_by(x)
-# define __protected_write_by(x)
-#endif
-
 /* shared module parameters, defined in drbd_main.c */
 #ifdef CONFIG_DRBD_FAULT_INJECTION
 extern int drbd_enable_faults;
@@ -774,7 +764,7 @@ struct drbd_device {
 	unsigned long flags;
 
 	/* configured by drbdsetup */
-	struct drbd_backing_dev *ldev __protected_by(local);
+	struct drbd_backing_dev *ldev;
 
 	sector_t p_size;     /* partner's disk size */
 	struct request_queue *rq_queue;
-- 
2.38.1

