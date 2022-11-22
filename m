Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68BB463480A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 21:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234851AbiKVUXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 15:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234764AbiKVUW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 15:22:59 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC3313CDD
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 12:22:56 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id i64-20020a1c3b43000000b003d016c21100so6562668wma.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 12:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/H1ZqhIuZy8QlHRoLj3AM+LOchaHyXXorL44J22nLEQ=;
        b=ktgh8Q7aXosYwKwF/HA/yApt01fTh3rfWEvb1f75m0e0Pys/Yx3FM8Psh1JwvB5srA
         crVkvVTMeNYYcr+By1VZ+u2/48adOSzZYy7jD2cdpbrOhA7LkkdJMTqBdmDYGYWV5ZMz
         8SoNIWuSon5KlWI/428QgDSJ2lAw/PruipgMQLME8Jx9xjSqapTHh5+c+DqQoqum6jW6
         RGKGA6ncQWeDQ7BODSG+CMNcL1MuC7imDHh/YmkL4JAYT+Z6RV8CFALVvT5nnY9tM4Hk
         dHvahaUESDTVC54EffKygLUckiF1upDL08fDhg9exieqDxrNLONFfUqwEb+zQ4AIXBAT
         TrYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/H1ZqhIuZy8QlHRoLj3AM+LOchaHyXXorL44J22nLEQ=;
        b=5dwXF0N5AGnVR8ZWY0B7Ah9WykLVQ4I54ZVCDB0GR8N6UiIkGAmfhvMD5uV5PV0hUK
         RmflidKZs+Pbt5cD4qcgrzl36/o/70vqgs6WQG0F4ElTRvXXAyuZYZC1mDkx5QHXq46K
         4UL0dkZ+WcXpE85Dg1erBCY0IRucsawLEfbBi/8sYyTvAQTVMd02h18p79alH9st50p6
         2Kkwciig41NyfwfJYwqivhgyCsE1UFyW4G44tCk4KljbVnKimvOYraes252dikQlMJNp
         mVBDQavdWAOE8Up0z8kzoGIRScifG3Laq8P/GnpeDRSz00O48Xf2QivLvtncsXuZLczb
         7iTA==
X-Gm-Message-State: ANoB5pnJNcL8NOAx4fh0MVgr9vP5p01nsjtnO9A5/AOWJlg4rHvw52Al
        F69pE8JRJbOmFyCK5tN30Adhng==
X-Google-Smtp-Source: AA0mqf6nQxPzsswssRMVgnULveQQDi6TeWIITPP403dC9T8gPgmNHs+FtJE5QnLQJqOGRQSbwZBw+w==
X-Received: by 2002:a05:600c:4a9a:b0:3c6:d811:6cff with SMTP id b26-20020a05600c4a9a00b003c6d8116cffmr21684875wmp.43.1669148575259;
        Tue, 22 Nov 2022 12:22:55 -0800 (PST)
Received: from nicolas-Precision-3551.home ([2001:861:5180:dcc0:53ef:17fc:fb98:916b])
        by smtp.gmail.com with ESMTPSA id f19-20020a05600c155300b003c6f3e5ba42sm25718555wmg.46.2022.11.22.12.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 12:22:54 -0800 (PST)
From:   Nicolas Frayer <nfrayer@baylibre.com>
To:     nm@ti.com, kristo@kernel.org, ssantosh@kernel.org,
        linux-arm-kernel@lists.infradead.org, jassisinghbrar@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     khilman@baylibre.com, glaroque@baylibre.com, nfrayer@baylibre.com
Subject: [PATCH 3/3] firmware: config: ti-sci: Default set to ARCH_K3 for the ti sci driver
Date:   Tue, 22 Nov 2022 21:22:45 +0100
Message-Id: <20221122202245.449198-4-nfrayer@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221122202245.449198-1-nfrayer@baylibre.com>
References: <20221122202245.449198-1-nfrayer@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Defaulting the build to ARCH_K3 for the TI SCI driver.

Signed-off-by: Nicolas Frayer <nfrayer@baylibre.com>
---
 drivers/firmware/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index b59e3041fd62..9e29055f62ba 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -261,6 +261,7 @@ config SYSFB_SIMPLEFB
 config TI_SCI_PROTOCOL
 	tristate "TI System Control Interface (TISCI) Message Protocol"
 	depends on TI_MESSAGE_MANAGER
+	default ARCH_K3
 	help
 	  TI System Control Interface (TISCI) Message Protocol is used to manage
 	  compute systems such as ARM, DSP etc with the system controller in
-- 
2.25.1

