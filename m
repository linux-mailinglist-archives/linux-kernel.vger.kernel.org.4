Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F8D71192F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 23:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241640AbjEYVcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 17:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241590AbjEYVcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 17:32:31 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EF39B;
        Thu, 25 May 2023 14:32:29 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f6d7abe9a4so545685e9.2;
        Thu, 25 May 2023 14:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685050348; x=1687642348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aGYKDyqaRYyF06kc0kQI1x33jaIORBrVfDXbHMi3/zg=;
        b=DP6lYqPky6px5tmigzrw/JPlbeESfU308MJAS79DQ6vDKpqwMfxMi5DwpyrLXMEaoq
         DMimX/Z90r45mP53YSJGL6pChnWHKLuTYKLV3gwSkDIij8EIk9MkloKUelhP+ZTcI80Y
         TYXKHU/mb8XYrswhRY6e5rnxo/I6uyy1xuYOFx5gnJj43U/ICgeqvDvJ98xc0UW72ZEy
         Uos4qCoBkiHBdUe3VM8sNY0BAGZrYOq1ikTCEe2Z9GneYDMZB5TSv5VpzoxXqCBdhiIr
         lc2wTFJDbu4l5kJ3nKPsvWsb5gX3kpxdOLpcEU4N9yH7ysGWmpMN9HspjPDzGdqkCeBd
         Nh5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685050348; x=1687642348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aGYKDyqaRYyF06kc0kQI1x33jaIORBrVfDXbHMi3/zg=;
        b=jth0qIAXsxALg7QKjDinpH4OpRQmfJKkfIgDZClZrqnyYXZ8egpH81BzhpXNEL7KQS
         9oeUBHARnj1NBUQptEmuRnIvIbCPTsoJd6ZGKdmOYy6BMsK8VPkWfXZxB85/aSr0pHzo
         S1kK/EDJZsXddc+tb98RidWE98TOWuYd4m5D4HJahj4rEsK+E3Oqs9czyaGPH/yFhXaZ
         349YLGPO1ftTmKOAYJkIfgWMvU3e4lLs9amNLmAlauvyVfj939sH/aRHJ6K5JfhIatyS
         ZRJNXBbg/RSE/O9I3HCFva+kDRKM6Nx+6VjwclWlJM/bIthTsBDpOasKWdnjT6D6kc46
         DjQQ==
X-Gm-Message-State: AC+VfDzVn4A1e3IyVHQ2Q4F+8xRxxE4XiR6CWk31nOPb89PXjCkj+pHr
        Y/COXJzmpTf12bLOKf5MG4k=
X-Google-Smtp-Source: ACHHUZ6Kqbdzmyh+me9CcSttyVU8juNLoSIzVzRJlsLP1JcGG1MAXG0U7Zt4z68P7xgsHatXlDMIUA==
X-Received: by 2002:a05:600c:2104:b0:3f6:675:3219 with SMTP id u4-20020a05600c210400b003f606753219mr3214367wml.40.1685050347984;
        Thu, 25 May 2023 14:32:27 -0700 (PDT)
Received: from xws.localdomain (pd9e5a196.dip0.t-ipconnect.de. [217.229.161.150])
        by smtp.gmail.com with ESMTPSA id 10-20020a05600c228a00b003f42461ac75sm6814504wmf.12.2023.05.25.14.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 14:32:27 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH 1/2] platform/surface: aggregator_tabletsw: Add support for book mode in KIP subsystem
Date:   Thu, 25 May 2023 23:32:17 +0200
Message-Id: <20230525213218.2797480-2-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230525213218.2797480-1-luzmaximilian@gmail.com>
References: <20230525213218.2797480-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Devices with a type-cover have an additional "book" mode, deactivating
type-cover input and turning off its backlight. This is currently
unsupported, leading to the warning

  surface_aggregator_tablet_mode_switch 01:0e:01:00:01: unknown KIP cover state: 6

Therefore, add support for this state and map it to enable tablet-mode.

Fixes: 9f794056db5b ("platform/surface: Add KIP/POS tablet-mode switch driver")
Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/platform/surface/surface_aggregator_tabletsw.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/platform/surface/surface_aggregator_tabletsw.c b/drivers/platform/surface/surface_aggregator_tabletsw.c
index 8f52b62d1c195..4a029f5db20a9 100644
--- a/drivers/platform/surface/surface_aggregator_tabletsw.c
+++ b/drivers/platform/surface/surface_aggregator_tabletsw.c
@@ -210,6 +210,7 @@ enum ssam_kip_cover_state {
 	SSAM_KIP_COVER_STATE_LAPTOP        = 0x03,
 	SSAM_KIP_COVER_STATE_FOLDED_CANVAS = 0x04,
 	SSAM_KIP_COVER_STATE_FOLDED_BACK   = 0x05,
+	SSAM_KIP_COVER_STATE_BOOK          = 0x06,
 };
 
 static const char *ssam_kip_cover_state_name(struct ssam_tablet_sw *sw,
@@ -231,6 +232,9 @@ static const char *ssam_kip_cover_state_name(struct ssam_tablet_sw *sw,
 	case SSAM_KIP_COVER_STATE_FOLDED_BACK:
 		return "folded-back";
 
+	case SSAM_KIP_COVER_STATE_BOOK:
+		return "book";
+
 	default:
 		dev_warn(&sw->sdev->dev, "unknown KIP cover state: %u\n", state->state);
 		return "<unknown>";
@@ -244,6 +248,7 @@ static bool ssam_kip_cover_state_is_tablet_mode(struct ssam_tablet_sw *sw,
 	case SSAM_KIP_COVER_STATE_DISCONNECTED:
 	case SSAM_KIP_COVER_STATE_FOLDED_CANVAS:
 	case SSAM_KIP_COVER_STATE_FOLDED_BACK:
+	case SSAM_KIP_COVER_STATE_BOOK:
 		return true;
 
 	case SSAM_KIP_COVER_STATE_CLOSED:
-- 
2.40.1

