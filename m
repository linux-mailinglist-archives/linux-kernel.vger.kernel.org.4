Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD246ADF66
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjCGNAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:00:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjCGM7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 07:59:33 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B087B4A4;
        Tue,  7 Mar 2023 04:58:52 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id n6so13935163plf.5;
        Tue, 07 Mar 2023 04:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678193930;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=14KEI7DKb7/XgYTk/mAvRRCNE1njt0Ubmbcu0U/o2i8=;
        b=B9KIsBBHPiA2BPfdnUytopIE29AZLAjY8edo7J+4Tel8M3KFP9c4EU0LsKdQPBI7xu
         B8P6T+peKou5jXwwJWJy0IAd9JmNgXhzIFuFENxDANvoHixlMPJMql7knTNTPJ1C/LsK
         KbC00wV6gVx6Eg5c2WX3sJve3JTA3zcffDALmE55MtCkJNha0SGEcvA1oUJeCOnw9tmK
         NlSWOj/sYSJ+NUaSIt1c0/9uj2OYDuyxlyzObOwKqtCkyqdoVuh0BnQuoQtUIH1DJ017
         lqNu/1YmB1Z7Yrkl7anMvLxK5utn9Pn4fbE14sKS4o+eQ+l4hKtLU8B7zSJSc6lryONC
         kNgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678193930;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=14KEI7DKb7/XgYTk/mAvRRCNE1njt0Ubmbcu0U/o2i8=;
        b=DNz1rK8Pg34RLRASiPX0pbAsvwwt8uTrT7J0f/1j2crPDJcU1CtaTNd06gc+NU+/AE
         0lCKF9Yl2Cq8vkvNCrUHh5ox2J3oleM66BOZP00/dRUFRolo8zs3DPZxf2lhiXUTY3Co
         u1k/C+5BR+1AKWM2eosGfw0L6QBVeUr6c8z+O+A/AD9rBF9y/YbjDSZjdqLEx5JtdvpM
         0wkNAWfwYjYVgp3XjH5deN/6VFZspRgJgCjFJyrgeq5HtwclS1WYaDWXSmL3ZHnSOJpv
         XxHYm4gyoO3TjnXgra6ikZFzOq+kIVwydBvYyqotwnAteUy+GOKs02HzaN1xfKinedbT
         351Q==
X-Gm-Message-State: AO0yUKVc+j9Hih6c4LISvAb9G9VQpOE9AVLZFT5M7yib41soqkboDyDt
        GCvHUufFvsaj85XfcRWptjw=
X-Google-Smtp-Source: AK7set+gmznO1briq15scDCO3CmlkNAWZHRE+CMnQ5g6FcmgnV4O0iXGQj2YIhOV2h5pY4RxWQSXnQ==
X-Received: by 2002:a17:902:db0e:b0:19d:1c5:adb9 with SMTP id m14-20020a170902db0e00b0019d01c5adb9mr17466721plx.3.1678193929687;
        Tue, 07 Mar 2023 04:58:49 -0800 (PST)
Received: from kevin-NL5.. (2001-b400-e30a-9c5a-d50f-1833-f384-bd8c.emome-ip6.hinet.net. [2001:b400:e30a:9c5a:d50f:1833:f384:bd8c])
        by smtp.gmail.com with ESMTPSA id le3-20020a170902fb0300b0019edf582a95sm1312591plb.20.2023.03.07.04.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 04:58:49 -0800 (PST)
From:   Kevin Chiu <kevin.chiu.17802@gmail.com>
To:     bleung@chromium.org, mchehab@kernel.org
Cc:     groeck@chromium.org, linux-media@vger.kernel.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        Kevin Chiu <kevin.chiu.17802@gmail.com>
Subject: [PATCH] media: platform: cros-ec: Add Gladios/Lisbon to the match table
Date:   Tue,  7 Mar 2023 20:58:45 +0800
Message-Id: <20230307125845.64231-1-kevin.chiu.17802@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Google Gladios/Lisbon device uses the same approach as the Google Brask
which enables the HDMI CEC via the cros-ec-cec driver.

Signed-off-by: Kevin Chiu <kevin.chiu.17802@gmail.com>
---
 drivers/media/cec/platform/cros-ec/cros-ec-cec.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
index 6ebedc71d67d..96c4c055d691 100644
--- a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
+++ b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
@@ -225,6 +225,10 @@ static const struct cec_dmi_match cec_dmi_match_table[] = {
 	{ "Google", "Kinox", "0000:00:02.0", "Port B" },
 	/* Google Kuldax */
 	{ "Google", "Kuldax", "0000:00:02.0", "Port B" },
+	/* Google Gladios */
+	{ "Google", "Gladios", "0000:00:02.0", "Port B" },
+	/* Google Lisbon */
+	{ "Google", "Lisbon", "0000:00:02.0", "Port B" },
 };
 
 static struct device *cros_ec_cec_find_hdmi_dev(struct device *dev,
-- 
2.38.2

