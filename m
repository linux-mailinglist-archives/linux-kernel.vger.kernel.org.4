Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83E2675EDB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 21:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjATUTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 15:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjATUTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 15:19:01 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1933ECC5E7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 12:18:40 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id t5so5848064wrq.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 12:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eQMkYfa6JOk29l+eO67ftMXjLXVNm5SDSgzNV32RifU=;
        b=K39ljOyKm7WfsPD6blBA9bm2U1CZ2NPUdgsfxWxrWlWrL31gRYh6+TpewUqlKIXXRJ
         toxK7u5kjFkXHB3AQFFN1zG1so22UmMFFzFDQEIIo5C8VMsiWZmPrmReyGk0q5PgcLFu
         Pnivp7AFHW1ZXF77zOMHITaRTGvxx8VsTFyF/QLtI7iBgFmzj8oC9Ku8UMg+mY9OExWf
         nuMHx3n7HARmJFg7iPIMM8jfhQq02y1q7p5PNZrhdIgtToBWjhg3WbJ44KOg/Ms+5WFO
         SqSErAO/+bxb6kYkAI65VRLta8pM1XeUKby2GfMgpIzKYeDm+YqbveYK+cwJFcW1qE2x
         YCKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQMkYfa6JOk29l+eO67ftMXjLXVNm5SDSgzNV32RifU=;
        b=dvkgQ9b4KSkjT4JUznLg4R6KQbp9rh6cABfnQIhsEJisFTajnR9km9CIrKsIJDSzTA
         cngREKn0ufXYt/osARd33iV3BTGNjoUeJPnRSHE+I9kNxpVOcT1gcbnBJekvqFeyqv9u
         4oW0xLv7vMhDAoYfcAbcWSLWEcQoPBhOM3qEeO5JEo2SK845/fDqK3+8aVOHP0q6icq7
         vS7ErgJ5uuZscOSOaUO9K2mFAqFSvzimJnYXXBDmAv/PGTNnFuxxm4X4pK0Zh/Ep2bf2
         sJqP4USM6hEQsHJYManzDZ/8i5HtxMoiE4BO6Zg9tL0r08pmOxwsIyE5kbfP04eR7t4h
         P3gA==
X-Gm-Message-State: AFqh2kqbTiRTinxDGvPxsVAKzAbNUuUF0smGilsmYJHpuo0cz+kwhrXU
        5dn3jsChw+eAIFlHTqyePMk=
X-Google-Smtp-Source: AMrXdXu8/FoafI8vurKHRP39odXC+6tnLMw3l9CkRCV9UmCR1w+pbdBr2hK6MAG0L5fk+BYYuephkQ==
X-Received: by 2002:a05:6000:98d:b0:2bd:ea5e:740e with SMTP id by13-20020a056000098d00b002bdea5e740emr3080443wrb.3.1674245918522;
        Fri, 20 Jan 2023 12:18:38 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935ca5.dip0.t-ipconnect.de. [87.147.92.165])
        by smtp.gmail.com with ESMTPSA id bt14-20020a056000080e00b0027cb20605e3sm13018064wrb.105.2023.01.20.12.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 12:18:38 -0800 (PST)
Date:   Fri, 20 Jan 2023 21:18:36 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] staging: rtl8192e: Remove repeated set to zero of
 powerlevel and friend
Message-ID: <50f28816aa006821d3e3a8346e39ae68c4d53963.1674244819.git.philipp.g.hortmann@gmail.com>
References: <cover.1674244819.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1674244819.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variables powerlevel and powerlevelOFDM24G are initialized to zero and
unchanged. No reason to set them to zero again. Remove dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index d56c58ecc19f..95a21859c7e0 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -591,13 +591,7 @@ void rtl92e_set_tx_power(struct net_device *dev, u8 channel)
 		powerlevel = priv->tx_pwr_level_cck[channel - 1];
 		powerlevelOFDM24G = priv->tx_pwr_level_ofdm_24g[channel - 1];
 	} else if (priv->epromtype == EEPROM_93C56) {
-		if (priv->rf_type == RF_1T2R) {
-			powerlevel = 0;
-			powerlevelOFDM24G = 0;
-		} else if (priv->rf_type == RF_2T4R) {
-			powerlevel = 0;
-			powerlevelOFDM24G = 0;
-
+		if (priv->rf_type == RF_2T4R) {
 			priv->antenna_tx_pwr_diff[2] = 0;
 			priv->antenna_tx_pwr_diff[1] = 0;
 			priv->antenna_tx_pwr_diff[0] = 0;
-- 
2.39.0

