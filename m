Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5054D628FB3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 03:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbiKOCDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 21:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237069AbiKOCDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 21:03:34 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4766173
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 18:03:33 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id w23so5387847ply.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 18:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vdd6wJ5NHUkCTmQNLvOrBAdkgXBRb2Cpd5/hUt+h78A=;
        b=fJEU7irM0O2nMclKI7/J3Hkzc35+jjb7Q/dkHGzqp2E259Tx5X7e/qQnnTsSBtT9YY
         HXf5AKiEdiLIodtz3zkJNQPh8OAv5td8PNHwsf90RYl7YdGF6WmYDz6gl162add+miVI
         POA5H6UT7GlngiuPVa21uJ7Kkl8xdpVv5qhHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vdd6wJ5NHUkCTmQNLvOrBAdkgXBRb2Cpd5/hUt+h78A=;
        b=UM1mMGIgk/jGLGlu93XYLRXig+OzlzOb61jOSXqgB29OBqoJhQLoCAP7+VAlG5jA73
         BnXRK0GkKfchYthew+pL57HxVJpWRpOslQzvqoaRG4+mGGot96aoeVskZ1t8kRMQzayF
         hWKv+SDnFUxesVVRYNRM4KDhi2aMa7MvOnXtBPzewnVfJeZdJdd9qgaHUjPlDakcpBPo
         4S/gbToi7Iq95bJchydVuq81jyL7aqU6ZU2O+vU7v0KjbQQJHuScEq8BkJIXbgDCy+fI
         4BVKXaj6ZMtau+7FSCkgUSS/sIOVQ/e3af7/L+Y/trCE3iNPvBkZJQdNT+zl2k2l+gSF
         LyxA==
X-Gm-Message-State: ANoB5pmrOKkXn7vmZ9ZqAsI5dMsqRCtKTgECAnFgN7/XnJfHNkt3K7xh
        ttExHkSJTilTDbOEhXRNOB3FvLYWb3vwJA==
X-Google-Smtp-Source: AA0mqf6Z3MbhwlJq1s5ouogONhbaS3Vemac11WjiNbBDzujusZs7/av9WMfQyejI0DPC9vNCFV1J/A==
X-Received: by 2002:a17:903:2152:b0:188:867a:e090 with SMTP id s18-20020a170903215200b00188867ae090mr1906203ple.39.1668477812743;
        Mon, 14 Nov 2022 18:03:32 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:f1c2:342d:ba37:dca0])
        by smtp.gmail.com with ESMTPSA id f15-20020a62380f000000b0056c360af4e3sm7393878pfa.9.2022.11.14.18.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 18:03:32 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] Docs/ABI/zram: document zram recompress sysfs knobs
Date:   Tue, 15 Nov 2022 11:03:14 +0900
Message-Id: <20221115020314.386235-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document zram re-compression sysfs knobs.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 Documentation/ABI/testing/sysfs-block-zram | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-block-zram b/Documentation/ABI/testing/sysfs-block-zram
index 14b2bf2e5105..628a00fb20a9 100644
--- a/Documentation/ABI/testing/sysfs-block-zram
+++ b/Documentation/ABI/testing/sysfs-block-zram
@@ -137,3 +137,17 @@ Description:
 		The writeback_limit file is read-write and specifies the maximum
 		amount of writeback ZRAM can do. The limit could be changed
 		in run time.
+
+What:		/sys/block/zram<id>/recomp_algorithm
+Date:		November 2022
+Contact:	Sergey Senozhatsky <senozhatsky@chromium.org>
+Description:
+		The recomp_algorithm file is read-write and allows to set
+		or show secondary compression algorithms.
+
+What:		/sys/block/zram<id>/recompress
+Date:		November 2022
+Contact:	Sergey Senozhatsky <senozhatsky@chromium.org>
+Description:
+		The recompress file is write-only and triggers re-compression
+		with secondary compression algorithms.
-- 
2.38.1.431.g37b22c650d-goog

