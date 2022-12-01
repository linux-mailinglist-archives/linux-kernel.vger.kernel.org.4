Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A7563EED6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 12:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbiLALFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 06:05:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbiLALEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 06:04:41 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B61CA1A35
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 03:04:35 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id z92so1917267ede.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 03:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7UKkmLnS7e989OMhpUZSFxG6zsBK4ZNO7k7rEn6zAvQ=;
        b=NdBYpyarUWAT/sr43u9vgxJ9FnZRbHIzAzX6wo9aQr7ckd26XfVdMXHFeOaROWLwaV
         e5by3aT6ed/GdHBMsT45Ttmxtf9OOJTMZuOL5gw/8PneunyPeObA/kBRq82PzzGciCc2
         I1nHVEsf0mJ3XB3zB69NRFC9hZijOfLg0rmXV97k+ZczcmNZZFDEVdX7VIHZFbaDEY+q
         qO8FvA8ptz4ZLSAo1/UTywTjbi4c+poh1Lh+3LLn5F1LJNrLSXO08yZ7eK3+t6jw6nVr
         bYhBXVU2l94j8VjH5ClIDL6T32/09xEDG/Z9kJvvO5wV+YKJv4O2N1Nh5yszszcQaiUC
         5aPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7UKkmLnS7e989OMhpUZSFxG6zsBK4ZNO7k7rEn6zAvQ=;
        b=V7hUgCCctfiMI99poE6LcNb7RZKPCRRb9QNmqBXMGT/FxzJG6EAhQcKyGWtWfa3tqa
         Rj8qf7lDfAacCc9t/Hblss8RuQemQFArgHIkoOndwRSDnpqN8rFolwLrOBxyIM6AnkCb
         x4HRcAOb6euhLSFwtif3lqVQg2yjaYiEkt2VwkIwTIBDxL0Y+mxCvk9zhPWMlKa9P/92
         917JdSxNrN3ttnkN/Uaj9HtITJ1nREdAV7Y9sVOsBe0Z3EvNcEz+1d+sGO90arf5Rhh2
         XifqpWwCZ/GfPUvMf8KQmUdkDSVlc3UCyndURGBurXCFQp/PRJq5jwjQhvBmJ9mV3iwy
         cpZQ==
X-Gm-Message-State: ANoB5pm2Ec8lyKwaapSBrMDXIOgkiswQzwr4SStFHNO0sBrm2k0YO+Ps
        EP4F72aaGgi2g4Qps9w+BXX1zaAzLPg2qmnA
X-Google-Smtp-Source: AA0mqf6U7lfqjEfrlvj2q7CWbLMODJ1yxvd8+fFiAk5pR6E9xio/wnMh1kPd8le0z0yZ122tm9nHPQ==
X-Received: by 2002:a05:6402:1802:b0:461:72cb:e5d with SMTP id g2-20020a056402180200b0046172cb0e5dmr51001875edy.410.1669892673832;
        Thu, 01 Dec 2022 03:04:33 -0800 (PST)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id f26-20020a056402161a00b00463a83ce063sm1576424edv.96.2022.12.01.03.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 03:04:33 -0800 (PST)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: [PATCH 1/5] drbd: unify how failed assertions are logged
Date:   Thu,  1 Dec 2022 12:03:46 +0100
Message-Id: <20221201110349.1282687-2-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221201110349.1282687-1-christoph.boehmwalder@linbit.com>
References: <20221201110349.1282687-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unify how failed assertions from D_ASSERT() and expect() are logged.

Originally-from: Andreas Gruenbacher <agruen@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_int.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index e29bd10ac52f..ea92df778c66 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -122,9 +122,11 @@ void drbd_printk_with_wrong_object_type(void);
 #define dynamic_drbd_dbg(device, fmt, args...) \
 	dynamic_dev_dbg(disk_to_dev(device->vdisk), fmt, ## args)
 
-#define D_ASSERT(device, exp)	do { \
-	if (!(exp)) \
-		drbd_err(device, "ASSERT( " #exp " ) in %s:%d\n", __FILE__, __LINE__); \
+#define D_ASSERT(x, exp)							\
+	do {									\
+		if (!(exp))							\
+			drbd_err(x, "ASSERTION %s FAILED in %s\n",		\
+				 #exp, __func__);				\
 	} while (0)
 
 /**
-- 
2.38.1

