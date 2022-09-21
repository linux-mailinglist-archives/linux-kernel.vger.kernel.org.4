Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A485C0539
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 19:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiIURYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 13:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiIURYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 13:24:31 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2A4E74
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 10:24:29 -0700 (PDT)
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 566373F179
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 17:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1663781068;
        bh=9piyT/VCnJlMmHymPvmNLYxbTaKtOFLio9F+8h9hJ9c=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=a2ZngO40iK8x1Kw9MJT3uWsIz1QdxLC9nQrFF86CM6T8HfHTcJhoIfu5rC/dz3oV4
         gV5Z3kym1LyMOuLmcPHF+iorQIzjQpypS62qbk9SJmjawQVtLXA8CyE92OYzQXGfjY
         MsxrRCNq3jz4iC5Vgk/UiTY+B1x8nzZd4NpqBliGSdtkZwMuBBYuSxuXpz0sy54RLe
         YQVOKCF+I+YenG64Wm0Mp32/ODnyX+uB6nJ5PUpomYz047mfq3txaJ6soaiB9cXtc7
         JXU+HRA4zffACi5Wouw4zgVOi/pui7SHM8AS7aMee5a1GU6R4S19zD2POs3VSa5pOx
         Udl2DyHev8FXw==
Received: by mail-pf1-f197.google.com with SMTP id u10-20020a056a00098a00b00543b3eb6416so3897314pfg.15
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 10:24:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=9piyT/VCnJlMmHymPvmNLYxbTaKtOFLio9F+8h9hJ9c=;
        b=XkGtFzGIfyhCJS525UklunPVREcg7IkvMhZ8XP5pTRwfoBzWdPBIFvYJNTMDVEhN1N
         7ISdHLZaOVK9ZNOXGpDarJaxXI9/4tqNw/i97+Y9mdDubylKJAtsx2WRZgzV0PSKBcnP
         VGXNrRZg8IYzI27enC4C5K9isshyUWGvc1JeBevq1ccVT5XAlIrza88wAroS2XBBZJt1
         aPXEE40K7BgLp87ERfmqNp6FM3OhDhqvcZCqkcPHa9iO4bBIyfpIvT0l3U1doJzHojPs
         TA8F+72dzFvLOk2wSD1D8PBoPxfayru+jSJuu8m0P4DZxjipBwtp6eiGvsTU6ryH8QB1
         oEmQ==
X-Gm-Message-State: ACrzQf1zJu5+00U6VThACXnTPdjA3qK9GYXMoxmn2ueWWkHHIhsYkTmg
        pGT65C/1NEy4/KCjmVPlMf3MGhac3YzNXfl1L3XnI/7uOPYQvEPV14RTlAsPyXnxt5+JGq/JoVK
        U18qR2jqNjH85iXTKVPDtjw6z75NYaSoqC9ewLqUy1g==
X-Received: by 2002:a17:902:d4c1:b0:176:b795:c639 with SMTP id o1-20020a170902d4c100b00176b795c639mr5717730plg.154.1663781065317;
        Wed, 21 Sep 2022 10:24:25 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4WX1aYTbIwRcfCVN4W588CV/XvjYWHcK6PVkEXvP4qjobX++S8B4HCEEzInRCAY75VXKnmwQ==
X-Received: by 2002:a17:902:d4c1:b0:176:b795:c639 with SMTP id o1-20020a170902d4c100b00176b795c639mr5717712plg.154.1663781065065;
        Wed, 21 Sep 2022 10:24:25 -0700 (PDT)
Received: from workstation.canonical.bluequartz.xyz (c-68-84-194-247.hsd1.az.comcast.net. [68.84.194.247])
        by smtp.gmail.com with ESMTPSA id b8-20020a170902650800b00178a9b193cfsm2310861plk.140.2022.09.21.10.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 10:24:24 -0700 (PDT)
From:   Kellen Renshaw <kellen.renshaw@canonical.com>
To:     linux-acpi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org, lenb@kernel.org,
        hui.wang@canonical.com, kellen.renshaw@canonical.com
Subject: [PATCH] ACPI: resources: Add ASUS model S5402ZA to quirks
Date:   Wed, 21 Sep 2022 10:24:22 -0700
Message-Id: <20220921172422.650880-1-kellen.renshaw@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Asus Vivobook S5402ZA has the same keyboard issue as Asus Vivobook 
K3402ZA/K3502ZA. The kernel overrides IRQ 1 to Edge_High when it
should be Active_Low.

This patch adds the S5402ZA model to the quirk list.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=216158
Tested-by: Kellen Renshaw <kellen.renshaw@canonical.com>
Signed-off-by: Kellen Renshaw <kellen.renshaw@canonical.com>
---
Follows e12dee373673 (ACPI: resource: Skip IRQ override on Asus Vivobook 
K3402ZA/K3502ZA).

 drivers/acpi/resource.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 8b4faec8cae7..5d688e546239 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -414,6 +414,13 @@ static const struct dmi_system_id asus_laptop[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "K3502ZA"),
 		},
 	},
+	{
+		.ident = "Asus Vivobook S5402ZA",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "S5402ZA"),
+		},
+	},
 	{ }
 };
 
-- 
2.25.1

