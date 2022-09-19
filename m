Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECCE5BD1B6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 18:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiISQBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 12:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbiISP74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 11:59:56 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F982DA
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 08:59:30 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id r134so23247913iod.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 08:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=H54d0G6AAErtN9paRV2+6Wo2Il0gAFeOcBLywRUXXa0=;
        b=BuHj0aYj11V/uqzAPjciFvNDd0tPx4EwB5NLho7OZ14QYt6P6pPn+/U1G2oP2hOrTG
         W/tY0awdaDq3v+rcheReD8bKyehbxyXSMhSl0M/Jlt6CA88yU3S0R2cMtm8d5TTk9D97
         TnCC3An/UStxFHYuxPuvf38pqX+NkDTNUURDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=H54d0G6AAErtN9paRV2+6Wo2Il0gAFeOcBLywRUXXa0=;
        b=k1W4OyeLYJ2H0ZW1jkwlbZRi1GT7xOzqHEB7U2wC8o3U+5/HwATnTNvrN5L1YViAJx
         xo79+cc3edP278iq8lo29sDxTrC1ja1CWyx9bwoFcnA1Lc6yvUXM04HBcuGVTElo4x1u
         es3xLGW8ZunhJAzDEhJ0okqMROksX+7C/68XsFG0okj9pysIqjelmPGdN2sK74t2l37e
         j2fyN+6jPD2zvT15OPZdVHyw5qPUeoZ1walxaopvPQmG/r3gpRI3Lz5ifjNYGzbOBei3
         u3P7KwpOophpVbo73Oi6JszDTNXPUf2t6hofUb/2D9hNbBUUlXhFqyoJvbqHSa5IzwTh
         zSvw==
X-Gm-Message-State: ACrzQf3WLefH+sWHgqCFbqQwMTY0QkdhV8223AvIPPM9WrG6s43QedA0
        mSm8LX08hlhLV1LpZ98EW7pi2A==
X-Google-Smtp-Source: AMsMyM4YIquTjh66qbsIX9P21MyXK/1UIiwMITpixcMruE6C/vvNhmUKpt7oGmKFM9QZcrhK266mZQ==
X-Received: by 2002:a05:6638:35a1:b0:35a:27ec:b00b with SMTP id v33-20020a05663835a100b0035a27ecb00bmr8540372jal.245.1663603170347;
        Mon, 19 Sep 2022 08:59:30 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id t70-20020a025449000000b00349fb9b1abesm5634154jaa.106.2022.09.19.08.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 08:59:30 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc:     timvp@google.com, hdegoede@redhat.com,
        andriy.shevchenko@linux.intel.com, rafael@kernel.org,
        mario.limonciello@amd.com, jingle.wu@emc.com.tw,
        mika.westerberg@linux.intel.com, dmitry.torokhov@gmail.com,
        linus.walleij@linaro.org, Raul E Rangel <rrangel@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 11/13] Input: elan_i2c - Don't set wake_capable and wake_irq
Date:   Mon, 19 Sep 2022 09:59:13 -0600
Message-Id: <20220919095504.v4.11.I7309b8f322082437b93581c6e2953886eeb998d7@changeid>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
In-Reply-To: <20220919155916.1044219-1-rrangel@chromium.org>
References: <20220919155916.1044219-1-rrangel@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i2c-core will now handle setting the wake_irq and wake capability
for DT and ACPI systems.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

(no changes since v2)

Changes in v2:
- I chose not to keep the legacy code around since systems without DT or ACPI should be rare.

 drivers/input/mouse/elan_i2c_core.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index 3947474e93d16a..b25b94aba3e88e 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1332,22 +1332,6 @@ static int elan_probe(struct i2c_client *client,
 		}
 	}
 
-	/*
-	 * Systems using device tree should set up wakeup via DTS,
-	 * the rest will configure device as wakeup source by default.
-	 */
-	if (!dev->of_node)
-		device_init_wakeup(dev, true);
-
-	/*
-	 * The wake IRQ should be declared via device tree instead of assuming
-	 * the IRQ can wake the system. This is here for legacy reasons and
-	 * will be removed once the i2c-core supports querying ACPI for wake
-	 * capabilities.
-	 */
-	if (!dev->power.wakeirq)
-		dev_pm_set_wake_irq(dev, client->irq);
-
 	return 0;
 }
 
-- 
2.37.3.968.ga6b4b080e4-goog

