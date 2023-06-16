Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC84D7330B4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345040AbjFPMEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345104AbjFPMEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:04:20 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5681130CF
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 05:04:11 -0700 (PDT)
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C208A3F460
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 12:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686917049;
        bh=927ZT3SpMX4GIfbYzorfuIN9F9EwjFp+WEVN3jcKmbk=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=MV5ufRNAFapYuznvMGgdFAGWHoxj9wZ3Vtb/VR7Qww/tqm8N0TzUprVydXxmlfY03
         sr5SrGeoUrYQ07lY/1FuDKlYaAbfcMxwFrb2xjMuxJHT7P8zdqWYtHE+aks9wZMbNd
         q7WZAZb6z8D4I3UhKeFb7FmeSQ5tM+5WkWQ/OX0MzwgqkI0yKGfkNSIA7cLWgBFj8S
         1j2rAOcdpzybrAamiMGaq/vhZr7Mq2vAZvW/xTr00T5LLoUYetexg2boURM/ubHtdH
         f2IBAJOS9fLAHUDmfo2AkzyzTC/ebDv5ByZ+0OrOlD1iMQktPRQKY9bDdpLytDW+ao
         Mnz+0zRZjW7AQ==
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-30ae4ed92eeso207690f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 05:04:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686917049; x=1689509049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=927ZT3SpMX4GIfbYzorfuIN9F9EwjFp+WEVN3jcKmbk=;
        b=PsStk2Z6VRkL5njBdzjmGt4LjLuLO9+Uu4zYo/xlsW7YcX3WGTT3GykysoXvTipQWm
         OpYKBS9HyZU9Bld7Uqwh8bEV2mySbfltPwjcINinZS1Hwcim43jduSRmSvtut+6jksVF
         juWWsnNrTNVTGQiwNK/P5HANncHTawTZhbf3tdebehbnIq6dS+oByRfvIEHLsczZt9sY
         E6mWw3+DcAHCYTZgS6Nu3KN6auvwA9W93dVc0GNB6jskHF+FqsTmRpkX0ywihg6gIroj
         BjC1N3LWE1d0y6HW2HgvFkyfF+3FbdE4t4ngPvU0fDpZ7W2m3JioCH/ZVEtJXPPx5PPj
         fIOw==
X-Gm-Message-State: AC+VfDxpDP42Uh5U8i8UNcp9R/VBf+3vyPufEQFHpOwGIxFW0K8ivcw0
        k5qeQ2UPKNWo/Pjvz4V3SiMLu0gZBud6pXJs9DWkKpIQvlvAFzk7plR3Q2JAZM6Ktr04oXN/EkA
        UE60uP7M/tJjmDW3UVIEmOmm7YaYMHnmpwK0kt/xUKQ==
X-Received: by 2002:adf:fd02:0:b0:311:1b84:c493 with SMTP id e2-20020adffd02000000b003111b84c493mr1389377wrr.41.1686917049338;
        Fri, 16 Jun 2023 05:04:09 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5TrSelc2JN4ghb2rEQvkJ+AW1irR9YzNxVZWmiOouaKWaLBOYgxEHGUhA4cEzwWysS0pvn6g==
X-Received: by 2002:adf:fd02:0:b0:311:1b84:c493 with SMTP id e2-20020adffd02000000b003111b84c493mr1389357wrr.41.1686917049030;
        Fri, 16 Jun 2023 05:04:09 -0700 (PDT)
Received: from localhost ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id b14-20020adfe30e000000b00307a86a4bcesm23567625wrj.35.2023.06.16.05.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 05:04:08 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl, juerg.haefliger@canonical.com
Subject: [PATCH] media: bttv: Add MODULE_FIRMWARE macro
Date:   Fri, 16 Jun 2023 14:04:06 +0200
Message-Id: <20230616120406.1027187-1-juerg.haefliger@canonical.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The module loads firmware so add a MODULE_FIRMWARE macro to provide that
information via modinfo.

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
---
 drivers/media/pci/bt8xx/bttv-cards.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/pci/bt8xx/bttv-cards.c b/drivers/media/pci/bt8xx/bttv-cards.c
index ec78f7fc5e1b..867c1308de23 100644
--- a/drivers/media/pci/bt8xx/bttv-cards.c
+++ b/drivers/media/pci/bt8xx/bttv-cards.c
@@ -126,6 +126,7 @@ MODULE_PARM_DESC(audiodev, "specify audio device:\n"
 		"\t\t 3 = tvaudio");
 MODULE_PARM_DESC(saa6588, "if 1, then load the saa6588 RDS module, default (0) is to use the card definition.");
 
+MODULE_FIRMWARE("hcwamc.rbf");
 
 /* I2C addresses list */
 #define I2C_ADDR_TDA7432	0x8a
-- 
2.37.2

