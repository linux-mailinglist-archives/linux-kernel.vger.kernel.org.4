Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B0F64DCAC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 15:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiLOOBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 09:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiLOOBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 09:01:00 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FA3108E
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 06:00:58 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id ja17so10914453wmb.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 06:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KjEOQQ+8uupaS0mKTtbvYBCgcEH6xxxaD1jrK+jhVk4=;
        b=vMqF25ETk0WiIa7FVKY4Vk5UErKHJwccEuxBOOpeFTw1N6qyX8gu0pTyEy8OnTkiEH
         1R/NZkU/AKq8dxzhh7zF+CV4BFxykXdJpt4SsZhqTQt4xaMcsFUCthl7Tzeb5qyMpqFB
         OAngUBW5TIbOhzcmiCaAO2NxxFZvjVazT7qtjMeh5etF0tawhZX9O31pvzI1el1rNeSz
         OPHiIlBVFyDkYHdtSMaKhxMTVIxndYH9oicOgCJk7nIHVHKzN+UAiQnRTHNLN1hO0Bch
         lTNTTwznYQOO9/yZb7ELDohNjbH6cOJ5k9spy+FK+9oLU2ZjnWEFW7QhIywX+7H7mOHF
         XyUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KjEOQQ+8uupaS0mKTtbvYBCgcEH6xxxaD1jrK+jhVk4=;
        b=dgSrdC6GP4Dw7PsZJOeyfMaSImlxxjOqJYBxNcHQ0TvvCRDZ1Mczd4K3xFdjp1sib+
         UXWyb5KT/rf6VhnaxIWiFjjeSle8zhKtNVhSIfSflx55OKA4roT2iOmggS83w6HGSg61
         Xd+tbXO27stZYt7iEXFeNvF5TxkbsfFzlzyKUrkyq8W/JuHvR6yxKjSBZJ8QA6yx7G04
         Kp8PTcvhHAzfKKt8FL//KJksRxroaumMAe5g99g02XVn3lwUWvuseh6XwVGAOUsyWvxt
         rJE8SYPGQFr/AHdn4xBbKH+4KCbn1vXr1MnlOQpkjEP3F9e4Zw6Z0et8zD2cqfF8RPX/
         zG1Q==
X-Gm-Message-State: ANoB5pmz98rArx+tHt7DWOHtbRvCPzJaZUd2aHad9r1VCjOpYtZD56j+
        g4rCE5cHQ4eSYODFqzesrvgQtA==
X-Google-Smtp-Source: AA0mqf6tp8fpwKpb7TdU38UI4K8GgTe3SLb26HdIJ3mfFWrWPmDdAif1zDUyiqXkTSuza6cuLihmlg==
X-Received: by 2002:a05:600c:500b:b0:3cf:6d5b:8768 with SMTP id n11-20020a05600c500b00b003cf6d5b8768mr21451414wmr.8.1671112856736;
        Thu, 15 Dec 2022 06:00:56 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id h5-20020a05600c2ca500b003d1e1f421bfsm6888028wmc.10.2022.12.15.06.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 06:00:56 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     gregkh@linuxfoundation.org, johan@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v4 2/2] usb: serial: add myself as maintainer of CH348
Date:   Thu, 15 Dec 2022 14:00:45 +0000
Message-Id: <20221215140045.2584886-3-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221215140045.2584886-1-clabbe@baylibre.com>
References: <20221215140045.2584886-1-clabbe@baylibre.com>
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

Since I did the driver and have hardware to test, set myself as
maintainer of it.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 997e75dbca5c..60c901626241 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4914,6 +4914,11 @@ S:	Maintained
 F:	drivers/auxdisplay/cfag12864bfb.c
 F:	include/linux/cfag12864b.h
 
+CH348 USB SERIAL ADAPTER
+M:	Corentin Labbe <clabbe@baylibre.com>
+S:	Maintained
+F:	drivers/usb/serial/ch348.c
+
 CHAR and MISC DRIVERS
 M:	Arnd Bergmann <arnd@arndb.de>
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
-- 
2.37.4

