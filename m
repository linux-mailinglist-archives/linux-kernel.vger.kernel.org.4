Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8641660934
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 23:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236616AbjAFWBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 17:01:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236760AbjAFWAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 17:00:55 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48939872B7;
        Fri,  6 Jan 2023 14:00:19 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id h10so1886395qvq.7;
        Fri, 06 Jan 2023 14:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g6DgrH0Sk4KsUxnwXEKBG8ESnSK8kFufSNig1ESrwiI=;
        b=UrM6ujdkaWodaW0zftdlr+Sk8JdskA/LGrsqC+Ci4a2cmyshvXB0PLKPP31DLrNOCK
         RPu4QQC1GxPFOrn05qkxzEoOmRXK8TXobDT29PGtUOvf6Rpn9V8IMODIeA+YN39JxS1c
         7rfwhWP5boSSNl7OKw26l4TPMB4WgQ+nTS/kOV3w2GpeqH9BAdktkap26TQcOaLvQTbl
         GnMIQ45eSQD1/VWmW/3aPkvSvXn/o6rsVIDCl8L1ClPOV91T9+WelSiweMpnGO6rotgh
         xHlj+qQDpUi9FXldYbPezRUcShQGesD/glEneRWxaaied7h7K2CJVaDdR1nPuPCutvmH
         seRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g6DgrH0Sk4KsUxnwXEKBG8ESnSK8kFufSNig1ESrwiI=;
        b=WfJSHMlJ6KGAC1s7nnz4yIeyyOe69l7BHmQqXt1EPYvAU7NsxBU/KI/S64tr7zY88a
         aesOhTPVSZSI+/QvpNZAW3hz0O8GS7JhZirhGB1fF5t375ZFdm02oS4kzNv/QAjWsFJZ
         z7t+c9pDiYb5nFcip0SMQ0FJVoMShQG72skK7ILq9OQZjSHRMpgBu/DimW/1MrRuEoVF
         uNCuV/c9p9IF9kVjmM+UFWICJz08LjXogv3LMR9FVc2GhTF1dTkMaBBcrTTY/fcqLBg3
         BGn0L/bkDbFWIHKvj9CugwefhLIuemeS3KiUBGyJiaTMEaOCbqn6IwJYB4f/bmpiIVn1
         rByA==
X-Gm-Message-State: AFqh2kpxNAoDDoA+IGh/E+YFXIp6leI1Yfo0MaKDRJ7jIPS2i8EKjzp6
        hw4zqOOa9mgDYLxbNKMASCHY+kQO3VvQ1w==
X-Google-Smtp-Source: AMrXdXtxtyTe7T1goD59WwRliwzvvtUp/pYQxl+gVZnkdrZ3UrwWOeczyYQJ6N68vi/MpSKeNy3U7w==
X-Received: by 2002:a05:6214:b32:b0:531:b260:dc62 with SMTP id w18-20020a0562140b3200b00531b260dc62mr39043722qvj.13.1673042418031;
        Fri, 06 Jan 2023 14:00:18 -0800 (PST)
Received: from localhost (fwdproxy-nao-007.fbsv.net. [2a03:2880:23ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id h10-20020a05620a284a00b006feea093006sm1172952qkp.124.2023.01.06.14.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 14:00:17 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     corbet@lwn.net
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@meta.com, akpm@linux-foundation.org
Subject: [PATCH] Docs/admin-guide/mm/zswap: remove zsmalloc's lack of writeback warning
Date:   Fri,  6 Jan 2023 14:00:16 -0800
Message-Id: <20230106220016.172303-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Writeback has been implemented for zsmalloc, so this warning no longer
holds.

Suggested-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 Documentation/admin-guide/mm/zswap.rst | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/mm/zswap.rst b/Documentation/admin-guide/mm/zswap.rst
index f67de481c7f6..6dd74a18268b 100644
--- a/Documentation/admin-guide/mm/zswap.rst
+++ b/Documentation/admin-guide/mm/zswap.rst
@@ -70,9 +70,7 @@ e.g. ``zswap.zpool=zbud``. It can also be changed at runtime using the sysfs
 The zbud type zpool allocates exactly 1 page to store 2 compressed pages, which
 means the compression ratio will always be 2:1 or worse (because of half-full
 zbud pages).  The zsmalloc type zpool has a more complex compressed page
-storage method, and it can achieve greater storage densities.  However,
-zsmalloc does not implement compressed page eviction, so once zswap fills it
-cannot evict the oldest page, it can only reject new pages.
+storage method, and it can achieve greater storage densities.
 
 When a swap page is passed from frontswap to zswap, zswap maintains a mapping
 of the swap entry, a combination of the swap type and swap offset, to the zpool
-- 
2.30.2

