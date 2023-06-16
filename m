Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF9073307C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 13:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343618AbjFPLyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 07:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjFPLyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 07:54:39 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C655D30C3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 04:54:37 -0700 (PDT)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 14BD13F0F8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 11:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686916476;
        bh=sLVGap7x4sxeAYbFdajItjxU/GxjLbYhz9H3rvqQDXU=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=BVDNin/SboI4iG4E2Al6EKaetM9dktrbf3KtO+uHKQJzff8ACRMr6wEIaMN0xlY95
         m7OGCEI/tXC8PpDgY3+Qh/jZZ2Xf2+gN8RPtd6BZ9v5H85H+n02j6dOdFX0QhSpo58
         3RO66xawvUqmwka/HTkvRTBrZWCUnRVCXWnugUoPgRykYyJ5Pd2zohx/I1VYCCGuYv
         qtpMnpoyShBG+5IDnOM1LGq57JmrljcArZW2l9bibfaAIJ/EZ5zaahAfOr6K58MKmf
         Du7ZLln9E32yYHNPGsw1YDikieBhrvKePcdzaFK7stC04KJrnTKK+YyebSGGxCKc2b
         pMgsvokK4J6xw==
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f42bcef2acso2368425e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 04:54:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686916475; x=1689508475;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sLVGap7x4sxeAYbFdajItjxU/GxjLbYhz9H3rvqQDXU=;
        b=XapE/dH8pjG3u8ViorYUMSAMw6mIxfCD8XnylWhl3cmvSA3BZnjoTQMXith7cTlKVF
         9KBDm4H4Tmwgsk8L/VNoMzjmLAFKrTF3oKMp6m5BGCZi6IHzJC472PYMDt6ny0NfNG6H
         tEKQIZAibipqPb73/zOhG7k0f4kwsiTdGop5MdZEuyyDdWykR+xSxGTXdak3ReBcdgoJ
         G80MoDTef9WAWOk2DMS3rjAkQrlCFUUMz4hu+hlLzxYdCrMHTiHttqqbSaJu9x6NOiq6
         L5nYjCcVp0DuIg/f7J6Zr6d4rXZoaXaftVUGoCHUHeSa3nvpOyF19zVjUxGNpqX5Wb+D
         GYSA==
X-Gm-Message-State: AC+VfDx/NH9EoqPmjZQQ/5O6/cd3UvV5J+99ZsyjY9++QSLQ+REsPcNK
        XJ7OJ9zssFziNeDC4P1BUPiZ9yw61mklzj3Q2aOxFn3kptbRYNyU66dqMirQUCrrzenc3ypfavA
        2E2gyXrRfw78yWr58ffqjv1gx89c+9ZSxCnx1I1jfcNvkzT8cTg==
X-Received: by 2002:a05:600c:2295:b0:3f7:5e3:c1f2 with SMTP id 21-20020a05600c229500b003f705e3c1f2mr1576277wmf.8.1686916475805;
        Fri, 16 Jun 2023 04:54:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5ZJx3D+sk0J+4p9n8paf68JVv1pnslll6eY87FpntkLaIvEy9qj3//FdXtnHrmhRSCzmTJEw==
X-Received: by 2002:a05:600c:2295:b0:3f7:5e3:c1f2 with SMTP id 21-20020a05600c229500b003f705e3c1f2mr1576268wmf.8.1686916475530;
        Fri, 16 Jun 2023 04:54:35 -0700 (PDT)
Received: from localhost ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id l20-20020a7bc354000000b003f4248dcfcbsm2005155wmj.30.2023.06.16.04.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 04:54:35 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, ckeepax@opensource.cirrus.com,
        juerg.haefliger@canonical.com
Subject: [PATCH] ASoC: codecs: wm0010: Add MODULE_FIRMWARE macros
Date:   Fri, 16 Jun 2023 13:54:32 +0200
Message-Id: <20230616115432.1011707-1-juerg.haefliger@canonical.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The module loads firmware so add MODULE_FIRMWARE macros to provide that
information via modinfo.

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
---
 sound/soc/codecs/wm0010.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/wm0010.c b/sound/soc/codecs/wm0010.c
index 034a4e858c7e..1d4259433f47 100644
--- a/sound/soc/codecs/wm0010.c
+++ b/sound/soc/codecs/wm0010.c
@@ -994,3 +994,6 @@ module_spi_driver(wm0010_spi_driver);
 MODULE_DESCRIPTION("ASoC WM0010 driver");
 MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfsonmicro.com>");
 MODULE_LICENSE("GPL");
+
+MODULE_FIRMWARE("wm0010.dfw");
+MODULE_FIRMWARE("wm0010_stage2.bin");
-- 
2.37.2

