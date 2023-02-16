Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10AA698B5D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 05:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjBPEQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 23:16:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjBPEQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 23:16:35 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EB242BCD;
        Wed, 15 Feb 2023 20:16:34 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id fu4-20020a17090ad18400b002341fadc370so4586887pjb.1;
        Wed, 15 Feb 2023 20:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EGrE7P/RLSwFwaWCO57vY0wVj6rzIfMRiDd6bZoW6BQ=;
        b=DhTPzAE3f6yq6fyPApmrGwn7zw+Dd8Ng2+RZO1N2QJTVvvM80hhWNglRiR031C/SLW
         9ew8p+T1E2RPR+VOpl31+5mVoPONlVXB0XLRhCHq+xv1Uw4tzTohh9TwDd1aAq2qGHzR
         ftZNEsKqL38HK+fdcaLBmgBHbE25w2c32ZTuUa02ttBFad+F7mU7JWTTE39TcdlhQ37u
         kfNnZpnYHFdQ2nH0UAOOtSWJXGEIlEomVW/2u8uEqm2S4pUUOiHrfJxAvMqVqQODSWGh
         rRgEYK0CQ5YL0iS9yL6bGOIgLAam3+a7PkkhczoxQpPMJcKyPD3d/qtaFUxOf42q9BFp
         08Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EGrE7P/RLSwFwaWCO57vY0wVj6rzIfMRiDd6bZoW6BQ=;
        b=Cigu9v15l/vGPVrBHCAI93VK7Ej5drvS5RepS91+nrNjNHLKgkml4AFWzXOVXosFzM
         c3VoXFb4JjLZ5KutthObks8NsiDw89L2VEhIqp0ZRfpZ0qlJGwkw71uKrAQqp1+/xLgI
         a8bYOVYK9kG4WZrN3BW9rSyLykAPq3xzqBcYj3ONSXlCGtKUeXRKFq3HHE5HOQgYefvq
         FsgPbnFwx5cEHtAeVgsX1qUq19xYPLqSYTfFiPTfUb/ZQBlCwZe9ywZsWu5hTYpbkyQU
         w4C7Ww0FkGcUPED0Gqkw9Iw3RAbcTZ0DcUrgwSaDSD76fLStMmcsSLPTwkw1Q2bb2eiy
         Vrtw==
X-Gm-Message-State: AO0yUKUWkivmFOABA/uzkLy2J6OXA8uPBtgIp6x2N6mI1JvR9Z9Zrcud
        WZ67gGc5G38siJjE/KVAJU0/RVIQUpIPWw==
X-Google-Smtp-Source: AK7set9bY5ng4qImVqOCjmhhCoCIluxSPvPL9SM4uOleieP5iZaMKrZ0vAuJjIvZCFWCrGkyqpGJCw==
X-Received: by 2002:a17:903:28c6:b0:19a:6f58:1c89 with SMTP id kv6-20020a17090328c600b0019a6f581c89mr3873457plb.59.1676520994079;
        Wed, 15 Feb 2023 20:16:34 -0800 (PST)
Received: from localhost.localdomain ([202.53.32.211])
        by smtp.gmail.com with ESMTPSA id ij21-20020a170902ab5500b00198d1993b4esm157539plb.69.2023.02.15.20.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 20:16:33 -0800 (PST)
From:   Orlando Chamberlain <orlandoch.dev@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>,
        Aditya Garg <gargaditya08@live.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Kerem Karabay <kekrby@gmail.com>,
        Andy Shevchenko <andy@infradead.org>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
        Orlando Chamberlain <orlandoch.dev@gmail.com>
Subject: [PATCH 1/2] Documentation: leds: standardise keyboard backlight led names
Date:   Thu, 16 Feb 2023 15:12:26 +1100
Message-Id: <20230216041224.4731-2-orlandoch.dev@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230216041224.4731-1-orlandoch.dev@gmail.com>
References: <20230216041224.4731-1-orlandoch.dev@gmail.com>
MIME-Version: 1.0
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

Advice use of either "input*:*:kbd_backlight" or ":*:kbd_backlight". We
don't want drivers using vendor or product name (e.g. "smc", "apple",
"asus") as this information is available from sysfs anyway, and it made the
folder names inconsistent.

Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
---
 Documentation/leds/well-known-leds.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/leds/well-known-leds.txt b/Documentation/leds/well-known-leds.txt
index 2160382c86be..4e5429fce4d8 100644
--- a/Documentation/leds/well-known-leds.txt
+++ b/Documentation/leds/well-known-leds.txt
@@ -44,6 +44,14 @@ Legacy: "lp5523:kb{1,2,3,4,5,6}" (Nokia N900)
 
 Frontlight/backlight of main keyboard.
 
+Good: ":*:kbd_backlight"
+Good: "input*:*:kbd_backlight"
+Legacy: "*:*:kbd_backlight"
+
+Many drivers have the vendor or product name as the first field of the led name,
+this makes names inconsistent and is redundant as that information is already in
+sysfs.
+
 Legacy: "button-backlight" (Motorola Droid 4)
 
 Some phones have touch buttons below screen; it is different from main
-- 
2.39.1

