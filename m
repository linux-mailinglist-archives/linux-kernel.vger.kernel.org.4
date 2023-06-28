Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE167412B4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 15:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbjF1Niv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 09:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbjF1Nim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 09:38:42 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7981B1FDC
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 06:38:41 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fa99742bd1so33336795e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 06:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687959520; x=1690551520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/vfQOuKGwQGjFlFPrXNZqTLKUFzS/2MyEVN12NS22zU=;
        b=GH2JkageMSynd6IaD064W1MAY7DMIEUEBAWRUBgV8BMlsnbcOXzo5bNP0SLOOOzHN4
         ugVM3PqqukZCP0axhC6abn64D+0b2vA3nBF3EkQb/KboMPLGhRkx3iIq5tnoAZ7j68sP
         iI2Oa1+dvJmtuUBdFwcJn2AeyZ1sXrVTms1KB7CQHhjWWRxNgIlI0tuiewHvdjRmr5WP
         I9GEbHae0oaPGSx9KguCV1Ub7QzP3Oh0b3qx+N344iuFpRwHXHHDemSsWgYY1E5nfAQ2
         DVtJ+3StlwPYPJRzTnuMUHpcKw0w3OZC8XOy/qDw+yN+n05ByT4q+vPmbveNiOyVhsgG
         zlqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687959520; x=1690551520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/vfQOuKGwQGjFlFPrXNZqTLKUFzS/2MyEVN12NS22zU=;
        b=dzpvFtq/ceizLTr9Udz1hHlceBSwD97D6Q5Q+/Tgu93KekJtuG/gIr25MwsYotSg20
         B8Xch3afnw67g6tKRuBONfgoYnljpf/8Iz1BEJ94eKWAeQE0nS3aze3z+f/N24wMSfCP
         pZ9m7Uu2fr4khM1YfSUMCmwatRXZfIY5ytlWVHg4QMHKd7BgPAM/6ioebWphvFb1pTUd
         IUUi9URN7hq61xEA/TGgta61U1Nf+k5NnYQ5+uIYG6cGk+Ta2rtF8FhERkeAyNPJy6WE
         X+L+ItWIiE38bZiP1VfBR6Su9gxj0tDW8G9l6/UDdgxwDIe5hw0S+zxgmtqx31RoKZ0m
         rOyQ==
X-Gm-Message-State: AC+VfDwRPD2nWzjXsNxniLidOw5tpItEfDqQ0DpeD+xbfMDimKIuqJFo
        c5YATw9BY+fPeu9BSdbHYgXHPA==
X-Google-Smtp-Source: ACHHUZ4GDk+xDZ6anRxhPtEO4mbCDmFanNfZ/1ZcxYcY0VHiyvYzil51yqltVXbuWMtgTGsfSVJq3A==
X-Received: by 2002:a05:600c:22d2:b0:3f9:b297:1804 with SMTP id 18-20020a05600c22d200b003f9b2971804mr19633307wmg.17.1687959520081;
        Wed, 28 Jun 2023 06:38:40 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id o23-20020a05600c379700b003fae92e7a8dsm7657539wmr.27.2023.06.28.06.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 06:38:39 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     gregkh@linuxfoundation.org, johan@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        david@ixit.cz, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v6 2/2] usb: serial: add myself as maintainer of CH348
Date:   Wed, 28 Jun 2023 13:38:34 +0000
Message-Id: <20230628133834.1527941-3-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230628133834.1527941-1-clabbe@baylibre.com>
References: <20230628133834.1527941-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since I did the driver and have hardware to test, set myself as
maintainer of it.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 342cb79a9ac5..e95b51594bac 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22044,6 +22044,11 @@ F:	Documentation/usb/usb-serial.rst
 F:	drivers/usb/serial/
 F:	include/linux/usb/serial.h
 
+USB SERIAL DRIVER FOR CH348
+M:	Corentin Labbe <clabbe@baylibre.com>
+S:	Maintained
+F:	drivers/usb/serial/ch348.c
+
 USB SMSC75XX ETHERNET DRIVER
 M:	Steve Glendinning <steve.glendinning@shawell.net>
 L:	netdev@vger.kernel.org
-- 
2.39.3

