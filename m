Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C570965469E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 20:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235600AbiLVTcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 14:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbiLVTcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 14:32:18 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C310C13CE5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 11:32:13 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 131-20020a1c0289000000b003d35acb0f9fso4657187wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 11:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jDiwzfYpfBYHVyYN+/2TxvIpjORzNkEStGkw7U52JN8=;
        b=3eSwxBargP1omjDDq0ZA1996dcXF3g49GWzmxqzUFkjNwRWeqAdFmPxHbEYaqYstw7
         +GzbCRyfo2r+ydzi1HPAo6gzqUNW0b5RIu0if3BSQ284udvCu1pMd1uECRq0sUovBRqw
         o5f9YsQ6csT+GPTAczEJSE4Zi+BAZkjhi8N+UmZ+4bd0ODkRF0dsQihAPTtVhXkT/nds
         Sjm5aCtpRzE9fkeaFPBQDDQG8QLqRmd+4+F0cPQk+uWDZRYXHUTBxfLDLSyPKAkr+es9
         jkfZA7obJIb6Mxd3WIZbMGr0weFlenD15Tt9FFBxh6QKWs14Tx3/DWvZQhBbusb4Yv4Y
         YS2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jDiwzfYpfBYHVyYN+/2TxvIpjORzNkEStGkw7U52JN8=;
        b=WRm+i19UL493yUrDAk8I1DSEheg495QPC91VOnj9yEbHlJS1JXqX9XQBnErEtyxT54
         jhwPLJFbwdeZvs0J57A9ORzM7NyArrgnK79XpILbj3so04BQFl5b+01+OgH5qah2+f6f
         EfuvZ2NdCJFMD5SOqw7iZK7tTtWw7USIxyU9gHjc0clbI+N3kwLDLJQexUsF2tbAVVag
         2gIBJqn8U1WvGJ1S6rQsGYNidlzLTd37Wf2D+WUID0e3X3gXhOSiZ1Y++oS+I3ARQtso
         3VSoGn7jjXmCUeLihw1ztn846kraJ8HjjwdcdmwMyfVojONrhoUm9DGcf1PUChKvs9nL
         tnQA==
X-Gm-Message-State: AFqh2kopmadPLhhn3aetiqvaW9ejcKcf+5UMxssVvOqbtku1v3KnWHL2
        BtMkuGZt3Q6jqilx8UUJj0A9VQ==
X-Google-Smtp-Source: AMrXdXuAVdA5WYdGRizU5NUAp6rlMP0fCDh6PNv6yPA9BUg3oDwvIb9d1UA/+kv231vIIgkwAnpD4w==
X-Received: by 2002:a05:600c:3b82:b0:3d3:4877:e560 with SMTP id n2-20020a05600c3b8200b003d34877e560mr5086382wms.27.1671737532342;
        Thu, 22 Dec 2022 11:32:12 -0800 (PST)
Received: from nicolas-Precision-3551.home ([2001:861:5180:dcc0:f5e4:afec:1c65:21c3])
        by smtp.gmail.com with ESMTPSA id p12-20020a05600c468c00b003cf57329221sm4446729wmo.14.2022.12.22.11.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 11:32:11 -0800 (PST)
From:   Nicolas Frayer <nfrayer@baylibre.com>
To:     nm@ti.com, kristo@kernel.org, ssantosh@kernel.org,
        tglx@linutronix.de, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Cc:     khilman@baylibre.com, glaroque@baylibre.com,
        mkorpershoek@baylibre.com, nfrayer@baylibre.com
Subject: [PATCH v2 0/2] irqchip: Kconfig: Add module support for TI inta/intr
Date:   Thu, 22 Dec 2022 20:31:59 +0100
Message-Id: <20221222193201.1552711-1-nfrayer@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added module support for TI interrupt aggregator and interrupt router
drivers. Default value for both drivers is ARCH_K3 and the interrupt
aggregator depends on ARCH_K3 as it contains 64 bit only ops.
Tested allmodconfig builds with ARCH=arm and ARCH=arm64.

v1->v2:
- Added depends on ARCH_K3 for the interrupt aggregator driver as it uses
64 bit ops

Nicolas Frayer (2):
  irqchip: Kconfig: module build support for the TI interrupt router
    driver
  irqchip: Kconfig: Added module build support for the TI interrupt
    aggregator

 arch/arm64/Kconfig.platforms | 2 --
 drivers/irqchip/Kconfig      | 8 +++++---
 2 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.25.1

