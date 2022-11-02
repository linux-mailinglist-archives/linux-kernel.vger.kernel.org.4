Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476696169EB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 18:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbiKBRAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 13:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiKBRAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 13:00:19 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838A811145;
        Wed,  2 Nov 2022 10:00:18 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id g12so29268396lfh.3;
        Wed, 02 Nov 2022 10:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c/rGavM3FugbFBXko20gXd+JeFm1aC+oWeUZwwWY/lw=;
        b=E3u3i4q3Tti6P3TxzuaAcCyRGnzta9nQ16qIWquesyNBecLL+RWDpubJuvcnAxt0Hy
         dxIgCb48MNn9+aGQKyzNg0/akwaZoQeSfg3cMgKo+jxjEIMnTcVL3oz5prkN2GCnYkc8
         Tu3b70ax5lsH4Zbf3gEjtdnH6o5JFPZDPeKx7RBx73x11IviuoRs8y+VznaDpcZ9vMj7
         AXrfs1TnBShWGcFCvlfeLZ1UBp5SSSrnBSI2PIknZ2wtgDKoi+Vi2dzUUXZ+FzJC8nWZ
         iaknqvmtSuxV6DPz5HiQFN7TdyXKJgNVisIkxQZPYeweBaHwvAHA1t+oM7lWPxIh5DVB
         Z/gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c/rGavM3FugbFBXko20gXd+JeFm1aC+oWeUZwwWY/lw=;
        b=I9j4b9abFkZPoFAQKi/hyxDWU31vE0oihZ2UxiI0S2eYN/FaL0nVlHiksWy4DPFBDu
         VVOYmsyOa2kLoNSloX2eGAVkAm30eQZnZzddoexepEZPnQuPx497OzuO6/n8y3ShzhEn
         Qq8xJVyJDQ0EJ3Y2nYzB49Drf/f7xaXKlbjfq4WLiaFNk/HJboBAWFyZCVy4k6pGNfYM
         yqzfJVy3K3uR3J2v53y3e+bLtO8xaK5Q7accdfWY/RbOVwqS8BrCC2TkP6nNr+c6YU4L
         hCAMEoA0V7kxAQ9zo5R2hqxUIi0bKKQaou0rhEY2jx8lcbgtFzoo8OaDWPBmFhPJqmf4
         +jgQ==
X-Gm-Message-State: ACrzQf2AXASTo38d4NPGFTRPQeQBoZ4ne7uZCWK7PKP/35eNWzeevL/I
        ajgrGNw70AOe4u117kYoHy0=
X-Google-Smtp-Source: AMsMyM6MlZEpMYqAUnk3rbDXURU7Be0LYN+4A+v7N+ug4shmMVPFcs0v1mgedizi9dt3uWqKCscj5Q==
X-Received: by 2002:a05:6512:31c6:b0:4a2:7d3b:87f0 with SMTP id j6-20020a05651231c600b004a27d3b87f0mr9331998lfe.382.1667408416810;
        Wed, 02 Nov 2022 10:00:16 -0700 (PDT)
Received: from hp-power-15.localdomain ([193.228.193.7])
        by smtp.gmail.com with ESMTPSA id o14-20020ac25e2e000000b004896ed8dce3sm2078825lfg.2.2022.11.02.10.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 10:00:15 -0700 (PDT)
From:   Siarhei Volkau <lis8215@gmail.com>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Siarhei Volkau <lis8215@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: matrix_keypad - force switch rows to input mode
Date:   Wed,  2 Nov 2022 19:57:47 +0300
Message-Id: <20221102165747.1528988-1-lis8215@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Pin/GPIO controllers can't get current GPIO status when interrupt
mode is set. Specifically Ingenic's JZ4755 always returns status at the
moment of interrupt.

The patch tries to fix that by forcibly setting pin mode to GPIO input
prior to reading actual row status. enable_row_irqs seems to set
interrupt mode back as it should be.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 drivers/input/keyboard/matrix_keypad.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
index 7dd3f3eda..b4c0325bb 100644
--- a/drivers/input/keyboard/matrix_keypad.c
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -127,6 +127,9 @@ static void matrix_keypad_scan(struct work_struct *work)
 
 	memset(new_state, 0, sizeof(new_state));
 
+	for (row = 0; row < pdata->num_row_gpios; row++)
+		gpio_direction_input(pdata->row_gpios[row]);
+
 	/* assert each column and read the row status out */
 	for (col = 0; col < pdata->num_col_gpios; col++) {
 
-- 
2.36.1

