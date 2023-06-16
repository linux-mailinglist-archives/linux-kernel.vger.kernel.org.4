Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C597334AF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 17:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345960AbjFPP0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 11:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345955AbjFPP0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 11:26:11 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE872948
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 08:26:10 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b5018cb4dcso5707205ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 08:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686929170; x=1689521170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TUdwy2/36hgEkTz9QJkYNZGHUYq2szwxedz8pSMdEEc=;
        b=n80NvEX/NzO2un18OWbPTOcYy0kouVcPki0WsS/d1yCArFZjQKB8cXvLE+Rb3GCB/H
         fTdgmhCzUJ4VM4raCRG8Sxx/SEUmYmCllGtk9HPOZe1H3uFt2DNpaJcuytR28HCOZGEx
         1t3GcY8XpXSZU4hqfWt+T7OkEXIrtMQVmc9NcZIhrtgS6SC2H0KfB1x2AlDL0sGN4Ut7
         psB5S0KnDvOAtcNttjgWLDyHv8qzXZB1DPUe7KZRkH8reQGEttf5QD1nIYwmePtDsNAu
         t28HTDhWIOK4+S7YAq+cccetIYra3Yir4sXU5E6dOWTTwiHCboZXzfPv9wwWLeW8yCk+
         y/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686929170; x=1689521170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TUdwy2/36hgEkTz9QJkYNZGHUYq2szwxedz8pSMdEEc=;
        b=b73bpjjIi29RpuzMEF6YUhg6X0UfAPoJ675XKzDtbhKcyJ9Jn+gIcshrSHA+tEdFJv
         vQTlSlhppHDKiPaQvaQ3ZNTAQx9iCKxa4qpejbqA6mVgCHf2wZlpEbtCFzx8+Kvu2un/
         xdWCDv/CMhAbpHoWUrvi+VnK5O3kJfV7B/QzoF0UlfscowxPItAD/EmFJUNQqBiezTSD
         L/tCN+Uk9us43dDGDqUxyOwrBeHWh1V7tkNIN9A6vsa8tzu3mP7uZ+tSZK6MENcgOmS+
         scoErWyufddcjh1ZjrdvEWmc++KUOov3m847MCgSch24DoU/1SvTbRxdVzdi0nzO1vQr
         eraA==
X-Gm-Message-State: AC+VfDxnV9J0hmeYA2BwUFmuzzlcOzmB+IGc9N6pOuS9dSoNnH9Xk5W2
        c/0Eke5NCxhT9fmeaQCTOcw=
X-Google-Smtp-Source: ACHHUZ6tJnqdu9WxuDJ8CmeYjIt9Y0w9V7dOW1Z2eAhkp89iu/BfwTMbBZhm5OuOV7uCMXrrDrVwZg==
X-Received: by 2002:a17:902:bb96:b0:1ac:8837:de9 with SMTP id m22-20020a170902bb9600b001ac88370de9mr1716854pls.3.1686929169864;
        Fri, 16 Jun 2023 08:26:09 -0700 (PDT)
Received: from redkillpc.. ([49.207.203.99])
        by smtp.gmail.com with ESMTPSA id y13-20020a17090322cd00b001a69dfd918dsm15992057plg.187.2023.06.16.08.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 08:26:08 -0700 (PDT)
From:   Prathu Baronia <prathubaronia2011@gmail.com>
To:     prathubaronia2011@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Khadija Kamran <kamrankhadijadj@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     dan.carpenter@linaro.org, error27@gmail.com, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, oe-kbuild@lists.linux.dev
Subject: [PATCH v5 1/2] axis-fifo: use devm_kasprintf() for allocating formatted strings
Date:   Fri, 16 Jun 2023 20:55:59 +0530
Message-Id: <20230616152602.33232-1-prathubaronia2011@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZIiTL5bzMUgs3L5K@redkillpc>
References: <ZIiTL5bzMUgs3L5K@redkillpc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In various places, string buffers of a fixed size are allocated, and
filled using snprintf() with the same fixed size, which is error-prone.

Replace this by calling devm_kasprintf() instead, which always uses the
appropriate size. Allocate the device name with a unique identifier
instead of a kernel address.

Signed-off-by: Prathu Baronia <prathubaronia2011@gmail.com>
---
V4 -> V5: Remove the dev_info() and use a unique identifier for dev name
V3 -> V4: Split into warning fixing and cleanup commits
V2 -> V3: Fix smatch warnings from kernel test robot
V1 -> V2: Split into logical commits and fix commit message

 drivers/staging/axis-fifo/axis-fifo.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index 7a21f2423204..5e070e00e27a 100644
--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -816,10 +816,6 @@ static int axis_fifo_probe(struct platform_device *pdev)
 	 * ----------------------------
 	 */
 
-	device_name = devm_kzalloc(dev, 32, GFP_KERNEL);
-	if (!device_name)
-		return -ENOMEM;
-
 	/* allocate device wrapper memory */
 	fifo = devm_kzalloc(dev, sizeof(*fifo), GFP_KERNEL);
 	if (!fifo)
@@ -857,7 +853,11 @@ static int axis_fifo_probe(struct platform_device *pdev)
 	dev_dbg(fifo->dt_device, "remapped memory to 0x%p\n", fifo->base_addr);
 
 	/* create unique device name */
-	snprintf(device_name, 32, "%s_%pa", DRIVER_NAME, &r_mem->start);
+	device_name = devm_kasprintf(dev, GFP_KERNEL, "%s_%d", DRIVER_NAME, pdev->id);
+	if (!device_name) {
+		rc = -ENOMEM;
+		goto err_initial;
+	}
 	dev_dbg(fifo->dt_device, "device name [%s]\n", device_name);
 
 	/* ----------------------------

base-commit: fb054096aea0576f0c0a61c598e5e9676443ee86
-- 
2.34.1

