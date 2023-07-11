Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8AA74F45A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 18:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbjGKQFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 12:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbjGKQFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 12:05:16 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22C0E6F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 09:05:14 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3094910b150so6439106f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 09:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1689091513; x=1691683513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YGMbrwgBLKOnv+M8jwXMoAH8jG/gfbhQBZp4iiCWWRg=;
        b=X1599FXgOL00p8CKDohLXF9Zr3cMKIazjOaQ+wr9ok+tpfYrW3HSzeLD+mMpSJ0TaX
         mMnlzicef3CocM5gYd0StuU7RNfloN3Zl4ZqLrExv+rUuDepUtcTazZDAEgL8hd9ggbM
         VAorHcH+daZIPqCqK7nkF/upz8zdjMz1hOsUErmsnMGZfhv6CEp2rJuYo4aC9ftjwsPd
         Oo+YJl9PUJVZ8r2POSjKBvS8gc7kGaXAk6vCCUiDug0M7e2EBDE+EQpPpBFJnbQ4CO41
         qtV5jPobJP8hL7/CeIhm9jBl5tMCbfFUoHVkY6/pPvYgKPMafArs3B7iaqDo8WMzOw3c
         jZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689091513; x=1691683513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YGMbrwgBLKOnv+M8jwXMoAH8jG/gfbhQBZp4iiCWWRg=;
        b=XSs3cEqFpEbrlClcN4FHfFA9JXRlwUeHy2dSZwH20tt3zRX7T8gliqHIH8fxGiCdvb
         W+tln8sAo7osFMAjoSMcoszfo+/OKYbJ0sRcBidaGO9uu54IczbXASCHttGxACIE6hEQ
         D7xaTAnMy3B6HOh3zVmVXpG3Y6voWEAJKxzR8zXeKZSge5EHGtwp4PMCU+Q1k8CzP0ug
         fc+djHMIDrSsDIvf03MW8QoCridvpw58SR+NzX8yuP/l+k0Q47OTkGMlXEj1NwVDILEv
         lnO0MEFNdfOfI2fNj0F8+1QOHgeYfh8xxYUJ3i3cYBTOlBZ6ppbWQCj2o352ffcVSC/E
         xy6A==
X-Gm-Message-State: ABy/qLaBEwuj45ZonLYhnDnJ/+3ToTFaf98UoccDToNNxXpLjTlZMpCR
        nLz1KWkCDQEkU6zCuv/WKKFMGe/NSKLH264uNP//vw==
X-Google-Smtp-Source: APBJJlHgLwp34UlDfRu8lFzyRofn21j1gWYc7T4ZYRT5xVced3YXYwegULEStCbhjNSRooP0I+B8Yw==
X-Received: by 2002:adf:de90:0:b0:313:fbd0:9813 with SMTP id w16-20020adfde90000000b00313fbd09813mr14916631wrl.28.1689091512709;
        Tue, 11 Jul 2023 09:05:12 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id f10-20020adff98a000000b003159d2dabbasm2590377wrr.94.2023.07.11.09.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 09:05:12 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        iwona.winiarska@intel.com, linux@roeck-us.net, jdelvare@suse.com
Cc:     Naresh Solanki <Naresh.Solanki@9elements.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        openbmc@lists.ozlabs.org
Subject: [PATCH 1/3] peci: Add Intel Sapphire Rapids support
Date:   Tue, 11 Jul 2023 18:04:49 +0200
Message-ID: <20230711160452.818914-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for detection of Intel Sapphire Rapids processor based on
CPU family & model.

Sapphire Rapids Xeon processors with the family set to 6 and the
model set to INTEL_FAM6_SAPPHIRERAPIDS_X. The data field for this entry
is "spr".

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/peci/cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/peci/cpu.c b/drivers/peci/cpu.c
index de4a7b3e5966..3668a908d259 100644
--- a/drivers/peci/cpu.c
+++ b/drivers/peci/cpu.c
@@ -318,6 +318,11 @@ static const struct peci_device_id peci_cpu_device_ids[] = {
 		.model	= INTEL_FAM6_ICELAKE_X,
 		.data	= "icx",
 	},
+	{ /* Sapphire Rapids Xeon */
+		.family	= 6,
+		.model	= INTEL_FAM6_SAPPHIRERAPIDS_X,
+		.data	= "spr",
+	},
 	{ /* Icelake Xeon D */
 		.family	= 6,
 		.model	= INTEL_FAM6_ICELAKE_D,

base-commit: 4dbbaf8fbdbd13adc80731b2452257857e4c2d8b
-- 
2.41.0

