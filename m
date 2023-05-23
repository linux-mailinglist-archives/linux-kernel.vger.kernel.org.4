Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8200270E319
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237834AbjEWQyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 12:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjEWQyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 12:54:20 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29E9E5
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 09:54:18 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f608074b50so867015e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 09:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684860857; x=1687452857;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+IpOI6DjQvsWYmDscf/WJ+Iv5OpwjIhaEoLM2tDvqjs=;
        b=qPLj+t7fMYCcTYpOl945/05++fCK7Dg2DPxLSXl6hSItdQAiS+Uv1q/fKy9041A2gv
         JBs0ANkA63E9eL6WtBxVv5EuquwIZhHJlJtm4BAho71Nba09bXMohGVszalUU+EeQYBN
         udBJg8qHZvYFu8a5sfyfkrKpTr3x8w2O5IIzxQ4Zf7c5CXkftBTYiI3UhGx4D2EfC9yu
         e9ZAln37baQpHZtlsUQDlLNxka+bMNHYimnrK3gFq/GTMDlTGDQiQ6OhZ5ohv/W1R426
         SvyEa9s4Mz5E0C/iu1QXmGs1rWPumPEE/m0B7Cpct+EI3ghZRy+CL62mB70diLhpQOIl
         ApFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684860857; x=1687452857;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+IpOI6DjQvsWYmDscf/WJ+Iv5OpwjIhaEoLM2tDvqjs=;
        b=iPg4jspu8yg4Yj0wgEWc+76Wz8HoFdIdkd02I2BIjIM29V6iMzv2hCzFnWqMEdWg0J
         pwaprFufwXP+6yhzMTJywYAOQmTiDTBeqRw1SB/RdtvdsekfN3ghYz68e9bDqHIGY6T/
         MJUYsaopY4DHRCV3U8zdm3g6xLpY6kCjWpgXmzFd63+qS4fK7Dn7o/21TfWvw6rh6qO1
         Ay0SO9F1I++WEkPGgMZK07OqVylefWm96Tf5gFqdnfIoDLdwNEe81MTiirJ6+e8c3L1S
         0HRmnY76ifFRA2sEqW1BMgjmpeG9bA9X0+MWus+x9hYFIwbd14e/4JX681QmlA1MiwYR
         dYEA==
X-Gm-Message-State: AC+VfDyjA9U16R4ntcqn+Jk4bIFYjJfuONB0KFjCJVP7WvyRfokc5cdi
        Wrll/VUe+pwzxnEZN+R6Cf8Lvg==
X-Google-Smtp-Source: ACHHUZ4kBw+gSodRazsb2pOCQnnKcrUn1lDCjvQhAR7zwA7XQGBiwx6vfTyxl5SfnMwdvoZCjQG4JA==
X-Received: by 2002:a7b:c447:0:b0:3f4:e4a2:9f7f with SMTP id l7-20020a7bc447000000b003f4e4a29f7fmr9903955wmi.36.1684860857247;
        Tue, 23 May 2023 09:54:17 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id c11-20020adfe74b000000b00306281cfa59sm11783321wrn.47.2023.05.23.09.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 09:54:16 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        ckeepax@opensource.cirrus.com, kuninori.morimoto.gx@renesas.com,
        linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] ASoC: codecs: wcd938x-sdw: do not set can_multi_write flag
Date:   Tue, 23 May 2023 17:54:14 +0100
Message-Id: <20230523165414.14560-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

regmap-sdw does not support multi register writes, so there is
no point in setting this flag. This also leads to incorrect
programming of WSA codecs with regmap_multi_reg_write() call.

This invalid configuration should have been rejected by regmap-sdw.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wcd938x-sdw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/wcd938x-sdw.c b/sound/soc/codecs/wcd938x-sdw.c
index 402286dfaea4..9c10200ff34b 100644
--- a/sound/soc/codecs/wcd938x-sdw.c
+++ b/sound/soc/codecs/wcd938x-sdw.c
@@ -1190,7 +1190,6 @@ static const struct regmap_config wcd938x_regmap_config = {
 	.readable_reg = wcd938x_readable_register,
 	.writeable_reg = wcd938x_writeable_register,
 	.volatile_reg = wcd938x_volatile_register,
-	.can_multi_write = true,
 };
 
 static const struct sdw_slave_ops wcd9380_slave_ops = {
-- 
2.21.0

