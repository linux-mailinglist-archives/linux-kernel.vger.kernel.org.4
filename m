Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41ECC6AAC34
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 20:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjCDTqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 14:46:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjCDTqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 14:46:46 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0111B56C;
        Sat,  4 Mar 2023 11:46:39 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id o38-20020a05600c512600b003e8320d1c11so4308900wms.1;
        Sat, 04 Mar 2023 11:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677959198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJ68f/XfFKM2MgP6LnaIRfQLo6GnMqWHhH7pP7brWGY=;
        b=i47dN/lTe7BsroWGjOvJ38KsaW5HypdPDhTcpqnH+r6BvlaQ7V0eKH604fdAVOYdaZ
         VVjUSXQPs2WPEy64a7LQmRqaZ7w93onxAnWoZtMm2IEXSuGlOiGQIcurrt3jRThjZhjV
         9Tdo2PyjcPDxkcqm7fcWbJ3zU1cBN3AOuGTvh26QcEdratHRXoxj7ocd/U6RUPKM0Ol6
         w5RqswgKgd4/yA8wEORwwUQeVUYP67r6ZB2wNsOG/VavW4JUQ2A28gp8jh5LTqpCu2mV
         HYX22iEtHfNUsC5hWFrPolsJDfyfZAPI/mUaiQcYbel3wqyejMTuyoCDtnps5Mxur7ag
         H1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677959198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lJ68f/XfFKM2MgP6LnaIRfQLo6GnMqWHhH7pP7brWGY=;
        b=nsNlrccnDGJv6XSr7uphmvvk+obbDJbXaKCouqlPqUwvLZZszQ/vub2xil0Wki69WJ
         rS9lnAdkP+Lqp2oNGOqIKZK2c1JYj4bk9+focgs7UWt8Dpg/tS+tfAoGuGY2/lj8gMMj
         0lZ3J8LkntNyamt868nGiJR5JJC9Z8E39LOTEvtcgmGbV6TCGrl+Kc1ee047e/NNUXzq
         Xq+Zud3oLEcZ5qfn8hZAWd8Qt4c31QOOXEntUo46Bpx5NSEsAvDKBbBp9uJyXoB06RGD
         9MSU5RGn73X8R9b7s+35k3mLFtlZScGe2TUQLJA5ZFa0tKPgaDRj9o3qVPEvOHRFA8rh
         UgGQ==
X-Gm-Message-State: AO0yUKWqLJlU42JQz3mE03EwSH8QCZu9QhS2xmQYF6coZILIRyoD4Tva
        0QgX0mQZ8+c3DJjAxEAPmWY=
X-Google-Smtp-Source: AK7set/RS0lWHxIAhuRbi5PNnJ+xv0169LC712Om0NSu5MYYAWlxxcHC0MNWRtd18+z4Gr38J4FAVw==
X-Received: by 2002:a7b:c451:0:b0:3eb:2db4:c626 with SMTP id l17-20020a7bc451000000b003eb2db4c626mr5167106wmi.38.1677959197991;
        Sat, 04 Mar 2023 11:46:37 -0800 (PST)
Received: from xws.localdomain ([217.138.207.232])
        by smtp.gmail.com with ESMTPSA id n37-20020a05600c3ba500b003e2052bad94sm10696067wms.33.2023.03.04.11.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 11:46:37 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH 3/3] platform/surface: aggregator_registry: Add support for tablet-mode switch on Surface Pro 9
Date:   Sat,  4 Mar 2023 20:46:11 +0100
Message-Id: <20230304194611.87770-4-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230304194611.87770-1-luzmaximilian@gmail.com>
References: <20230304194611.87770-1-luzmaximilian@gmail.com>
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

Add support for the POS-subsystem tablet-mode switch used on the Surface
Pro 9.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/platform/surface/surface_aggregator_registry.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
index 296f72d52e6a..0fe5be539652 100644
--- a/drivers/platform/surface/surface_aggregator_registry.c
+++ b/drivers/platform/surface/surface_aggregator_registry.c
@@ -305,7 +305,7 @@ static const struct software_node *ssam_node_group_sp9[] = {
 	&ssam_node_bat_ac,
 	&ssam_node_bat_main,
 	&ssam_node_tmp_pprof,
-	/* TODO: Tablet mode switch (via POS subsystem) */
+	&ssam_node_pos_tablet_switch,
 	&ssam_node_hid_kip_keyboard,
 	&ssam_node_hid_kip_penstash,
 	&ssam_node_hid_kip_touchpad,
-- 
2.39.2

