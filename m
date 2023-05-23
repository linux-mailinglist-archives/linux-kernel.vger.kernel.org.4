Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A3E70E0DC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 17:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237410AbjEWPsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 11:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235630AbjEWPsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 11:48:00 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A45B11A
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 08:47:59 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f417ea5252so393765e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 08:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684856877; x=1687448877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wQCfe4UyM82vmyTRFBM4WHyG7YgqkrNHdPfn864Gl+8=;
        b=XI33DDyKIlOhh0N/WCTe3/A54qgbzrtME6LI7rRzz+FXMx+ISS41uwFhQDBwtOmy4q
         aLPNelYtU+JQg5Wa2sImzUXTBePkCQpTHPBxtlXKqbN3nVvSbkLm/YenPGVFbitNfKrN
         kRUR7aiSZ2kyqrkYrD76nTZLCOcG/c3qAC7TGyjlI8G8lktBr7DWMgTxIf80NGd+Htt7
         /Fw5pVOduACQ/0kQ67HdHHWfZSE60wgw7+n8ROp0ZighNUwwLzbYTECBNk7R/avrK2S5
         CrlY4Vh4ksrc6VXYFTSTUXSdQjRi7cmAVMg5k0oQ/yuyKCdPPwXf5RBFelrDHqLuza+4
         sB3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684856877; x=1687448877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wQCfe4UyM82vmyTRFBM4WHyG7YgqkrNHdPfn864Gl+8=;
        b=D0qQuch48H4GL01dTChxwwuDFBWID/zcnXD0pbfCfZpkceu1A1RHfRGZ2ZE4HzqAfZ
         OVfDeVgHdfwWvODlpE+/NGMrA/T+P9h2xT8w7svi5QOqY/gWM2cRKER3Hkl3n1xRNNle
         r5z8A55okuuH8uOmnJrXVD7RfOnl6n0vaZUu4Y/l2EhL7JQPdxbuD08eEY73224qXxIr
         GchOlJQBOVFm+tAtA/7xAprg1223x6/ZDo3tfFR0PtFYb9Zgsa1RxOk2p0PB6dp/Ihls
         gsKXAIihcAyFxvM7GH9Gh3c6hJnYT2GxiwQQX2bmDkq+QFNykcRRiz+KZ5SpMo8dwIO9
         EFbA==
X-Gm-Message-State: AC+VfDymHYuQyRxV/WiR1FU4CLSn9BPHGyrdv5xKqXms5Zmfr8By16Rf
        tnrPbRSngssCXfOE09hNUZxxRg==
X-Google-Smtp-Source: ACHHUZ7CPsTH5MMiP5kdNXdVZV0bfwqRP6BQlHOunHj7pJHFJvIoFx/mtWtRhIKOMH6MhbPrmxHxKA==
X-Received: by 2002:a1c:6a03:0:b0:3f6:580:b091 with SMTP id f3-20020a1c6a03000000b003f60580b091mr4773535wmc.16.1684856877505;
        Tue, 23 May 2023 08:47:57 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id g3-20020a7bc4c3000000b003f427687ba7sm12052386wmk.41.2023.05.23.08.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 08:47:56 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        ckeepax@opensource.cirrus.com, tanureal@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] regmap: sdw: check for invalid multi-register writes config
Date:   Tue, 23 May 2023 16:47:47 +0100
Message-Id: <20230523154747.5429-1-srinivas.kandagatla@linaro.org>
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

SoundWire code as it is only supports Bulk register writes and
it does not support multi-register writes.

Any drivers that set can_multi_write and use regmap_multi_reg_write() will
easily endup with programming the hardware incorrectly without any errors.

So, add this check in bus code to be able to validate the drivers config.

Fixes: 522272047dc6 ("regmap: sdw: Remove 8-bit value size restriction")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/base/regmap/regmap-sdw.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/base/regmap/regmap-sdw.c b/drivers/base/regmap/regmap-sdw.c
index 09899ae99fc1..159c0b740b00 100644
--- a/drivers/base/regmap/regmap-sdw.c
+++ b/drivers/base/regmap/regmap-sdw.c
@@ -59,6 +59,10 @@ static int regmap_sdw_config_check(const struct regmap_config *config)
 	if (config->pad_bits != 0)
 		return -ENOTSUPP;
 
+	/* Only bulk writes are supported not multi-register writes */
+	if (config->can_multi_write)
+		return -ENOTSUPP;
+
 	return 0;
 }
 
-- 
2.21.0

