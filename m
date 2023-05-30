Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9CE7157A5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjE3Hxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjE3Hxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:53:36 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9C1BF;
        Tue, 30 May 2023 00:53:33 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f6d7abe9a4so27529025e9.2;
        Tue, 30 May 2023 00:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685433211; x=1688025211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oJat+S2GRgqfm5ZimEWfP+mzTLI8bh6EOyD08golq/0=;
        b=UpieOk9BHq8mFg2B9lc37PmA3YmachbEQ0bDEErszcfoGBe0Q038rWYwIecXoOtRcT
         nkBlkMm9WQoqsvG4DMUq7SfEjCcaQK6TmSuutlIDwikWKpm5fLfB6d++CCS7GpD2/7xs
         nZoNtzH4rU4uzR3mPE4sSP2AAHgFs3bKlE+J73Rbgwf2X01ndDdoFmz74rVzAH7Jty/a
         SrKn1+SZoR8nzn2kg1BsI6CVteNzPmUrXCeKJWJI6tevNOaQ+AV5mNtFzTEf67Y76/L6
         8O0U2WE4d42JAwkHIzdDwEqJfh6KkI9btRSQrsTmTKpXtA/z4byklhMwzTeP8Qh77MyU
         xnFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685433211; x=1688025211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oJat+S2GRgqfm5ZimEWfP+mzTLI8bh6EOyD08golq/0=;
        b=HvHG9+SbU6mVgkylZyjAgzV40EYBQYkK3bOdi0+ObsKjODmvMNPrtBPYTgotK8A05+
         grPkiRiLZuMo+VqKpyaTqGRbedDSEDOfA32Gt8avp5R4yv4Z/Azu/30h4Iq8RcFP8t7+
         dMbJmcsaxKdJZmOcrozIS4rSPOHGELSPXLq2nuQE3W7GgcJEykoF63PqvrZ4ZV6hmHUD
         fa1GeuWryjGqXzX7vfu/UtiFdP/+lLGT4/GxYXr2eVVpXlRTC10IqNTuMcot+Ny9CsD7
         NHoMyBA/tegr+2hzcE25fXYIEmOhkiPUVt6Rs1vIrsvnpFaz/GHO4QNr4hrFuHEbmLCW
         F+Jw==
X-Gm-Message-State: AC+VfDxSH9C3NlSLsHWVvRMrAnWOnqHF0/g0vtXxoNoPmhqgTwt2Ri9F
        52oC49sGT7BD+C0HpNHjV+M=
X-Google-Smtp-Source: ACHHUZ7neRCo9PQMbFtuPKWWxHGVTFThCJ5fkWOBvPHhxRv52GblTGsu/qhVliAgHJj/52flMColSg==
X-Received: by 2002:a05:600c:2106:b0:3f6:be1:b8d9 with SMTP id u6-20020a05600c210600b003f60be1b8d9mr752088wml.6.1685433211177;
        Tue, 30 May 2023 00:53:31 -0700 (PDT)
Received: from PC-UT2.ad.ennebielettronica.com ([78.152.97.130])
        by smtp.gmail.com with ESMTPSA id x21-20020a05600c21d500b003f6041f5a6csm16561275wmj.12.2023.05.30.00.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 00:53:30 -0700 (PDT)
From:   fl.scratchpad@gmail.com
To:     jic23@kernel.org, Alexandru Tachici <alexandru.tachici@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fabrizio Lamarque <fl.scratchpad@gmail.com>,
        Nuno Sa <nuno.sa@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 2/5] iio: adc: ad7192: Fix internal/external clock selection
Date:   Tue, 30 May 2023 09:53:08 +0200
Message-Id: <20230530075311.400686-3-fl.scratchpad@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530075311.400686-1-fl.scratchpad@gmail.com>
References: <20230530075311.400686-1-fl.scratchpad@gmail.com>
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

From: Fabrizio Lamarque <fl.scratchpad@gmail.com>

Fix wrong selection of internal clock when mclk is defined.

Resolve a logical inversion introduced in c9ec2cb328e3.

Fixes: c9ec2cb328e3 ("iio: adc: ad7192: use devm_clk_get_optional() for mclk")
Signed-off-by: Fabrizio Lamarque <fl.scratchpad@gmail.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/ad7192.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 94a9cf34a255..5a9c8898f8af 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -367,7 +367,7 @@ static int ad7192_of_clock_select(struct ad7192_state *st)
 	clock_sel = AD7192_CLK_INT;
 
 	/* use internal clock */
-	if (st->mclk) {
+	if (!st->mclk) {
 		if (of_property_read_bool(np, "adi,int-clock-output-enable"))
 			clock_sel = AD7192_CLK_INT_CO;
 	} else {
-- 
2.34.1

