Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA15711930
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 23:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241754AbjEYVcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 17:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241590AbjEYVcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 17:32:33 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139DB99;
        Thu, 25 May 2023 14:32:31 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f6cbdf16d2so537435e9.2;
        Thu, 25 May 2023 14:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685050349; x=1687642349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8mEj8qP5XF/9ldbcMemiLlsXak845k7PJxDzZ1dMqEU=;
        b=ioiKn9CBYthG8xxKYQo8TxKOtdDY5SlG4ZXk92xoPbp0Nb+I3H0U0WVwXzKmcFGlxR
         3J3IZOj3Hv+bPlOmtHbfEWsION+boDaK1z69IUNbJoVVPtBz87LL6dX0qLLFxAKBBVQD
         Z92SgeZztCxaYqZjTglZ6VEcdZWVthA1HFnOmuqctyv38vmKoC6DCckMAToL1kHSsN1i
         oo4tObTqlpyuKnTjc+YYxUO2siYI0VUbVz/jeGCmtd4BLkuINxci4P+7FG2qEGKNleNm
         UGGABJC7WXTvWeM6GbC4E+oGc5YNsz0KEO+x/ga0E2AnrtDmqMKRoYDufvcNO7thl4Bj
         o3xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685050349; x=1687642349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8mEj8qP5XF/9ldbcMemiLlsXak845k7PJxDzZ1dMqEU=;
        b=V4vXL35v3BIH3yReQRHXZ2gDXvueQMvhi/G9LAMnQ4E9mAkIB/OVXUwaNbUjdUdIrH
         h45VhitDVQ8CHZfWXnOqaM6MuRppGoxuqwLFpYpChTRnsHgIhSWtINwTINn836NAqfoc
         DRMRPPI8lF0nuywzdzjhIMK4XaLFbLjG1FRmqCV9DZZ0bnoe/CLjCr4mcKtSVtsfmHy4
         4SQoplFQ4OQ4VNZRInBYyVdFIwHYvz8CNpahlaz9ldN2kI4c3OiNMVhg8xLoXWeHwnmz
         Lhrj5JrJa3kf9SLWUaiSVrniWyqH+PsMGQkTfQnj4Zvi5qk/FqqtXenliXnOfwpWnHxR
         zfAQ==
X-Gm-Message-State: AC+VfDx9cP0D+US3vXE0hpq6WuddhisHHYhycbly6GDMgZzDyMY+Z4GV
        CtfTXdYezUffI1ge49avUp4=
X-Google-Smtp-Source: ACHHUZ5bhPJjwV31GPGt81pXFy720Z4YPIi76oGnWG+ridyglI01EIaIW60NbblCE00XCHI2ruWCeg==
X-Received: by 2002:a05:600c:2046:b0:3f6:683:628b with SMTP id p6-20020a05600c204600b003f60683628bmr3061032wmg.3.1685050349373;
        Thu, 25 May 2023 14:32:29 -0700 (PDT)
Received: from xws.localdomain (pd9e5a196.dip0.t-ipconnect.de. [217.229.161.150])
        by smtp.gmail.com with ESMTPSA id 10-20020a05600c228a00b003f42461ac75sm6814504wmf.12.2023.05.25.14.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 14:32:28 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH 2/2] platform/surface: aggregator_tabletsw: Add support for book mode in POS subsystem
Date:   Thu, 25 May 2023 23:32:18 +0200
Message-Id: <20230525213218.2797480-3-luzmaximilian@gmail.com>
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

  surface_aggregator_tablet_mode_switch 01:26:01:00:01: unknown device posture for type-cover: 6

Therefore, add support for this state and map it to enable tablet-mode.

Fixes: 37ff64cd81ff ("platform/surface: aggregator_tabletsw: Add support for Type-Cover posture source")
Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/platform/surface/surface_aggregator_tabletsw.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/platform/surface/surface_aggregator_tabletsw.c b/drivers/platform/surface/surface_aggregator_tabletsw.c
index 4a029f5db20a9..c0a1a5869246e 100644
--- a/drivers/platform/surface/surface_aggregator_tabletsw.c
+++ b/drivers/platform/surface/surface_aggregator_tabletsw.c
@@ -340,6 +340,7 @@ enum ssam_pos_state_cover {
 	SSAM_POS_COVER_LAPTOP        = 0x03,
 	SSAM_POS_COVER_FOLDED_CANVAS = 0x04,
 	SSAM_POS_COVER_FOLDED_BACK   = 0x05,
+	SSAM_POS_COVER_BOOK          = 0x06,
 };
 
 enum ssam_pos_state_sls {
@@ -372,6 +373,9 @@ static const char *ssam_pos_state_name_cover(struct ssam_tablet_sw *sw, u32 stat
 	case SSAM_POS_COVER_FOLDED_BACK:
 		return "folded-back";
 
+	case SSAM_POS_COVER_BOOK:
+		return "book";
+
 	default:
 		dev_warn(&sw->sdev->dev, "unknown device posture for type-cover: %u\n", state);
 		return "<unknown>";
@@ -421,6 +425,7 @@ static bool ssam_pos_state_is_tablet_mode_cover(struct ssam_tablet_sw *sw, u32 s
 	case SSAM_POS_COVER_DISCONNECTED:
 	case SSAM_POS_COVER_FOLDED_CANVAS:
 	case SSAM_POS_COVER_FOLDED_BACK:
+	case SSAM_POS_COVER_BOOK:
 		return true;
 
 	case SSAM_POS_COVER_CLOSED:
-- 
2.40.1

