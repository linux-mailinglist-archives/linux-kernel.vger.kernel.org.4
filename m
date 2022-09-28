Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D7E5ED837
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 10:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233371AbiI1IuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 04:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233375AbiI1Ita (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 04:49:30 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EE63D597;
        Wed, 28 Sep 2022 01:49:19 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id v4so11607931pgi.10;
        Wed, 28 Sep 2022 01:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=HsRiuLBSIZ4AJTyP6taQh47+3anujKo8VwqSthOZMus=;
        b=aLaGroi0OkO9MdK6+JBr2wA9wTPUulYbYWxZ3aq09VWOOOkrwZKAhW33DrNu8wzCA6
         rScwT/lr6caIO4so6LtAcoTFam8XGizxrj5x/rxJBeqIEzZPsRb0VBLRso3fYAE+S6F4
         Csg+VsVwAbSi/hp4sq0RbTa9RetyFiJOCd9dqqoBsoXNfmQfqr6sFHDkhGpuTQT2gBA1
         2PVLkgAW+xEQ4tzwNF5DDJnvTRzAtwDQzW7UMKttbMWdD+XnOGI7blXo6brdAwJZL+OB
         lkUZOhCSE/HmcXRSkIMcvnTdMckzhjmZqXvfK9DOxyJiVaSrYcfkbq34cWwDfunVCTVX
         vTHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=HsRiuLBSIZ4AJTyP6taQh47+3anujKo8VwqSthOZMus=;
        b=29UQejwpxe+Yqtd2iHD8XEOO5gLokX333vkGUBSDpOfJOuMWEj1lf7mmdkZmFuiWKO
         QtG54tjfRvTSBUy7eE2D2Eh+uVabGB0eT0xmL3LLT2ePSidPQXNPIkV7oxceYXS8z6Xk
         Boaojl6Gax2lIUkwibog1cTVa8VSVVD6jSr2wol19gUv3IxaBCyhZnaztH6/horRkTvd
         EGbeKzUIcz8gUFfr54hCAA0akJAyvbw2khDKS60XZ4KJme0EKTbz6fL0EQBUOeLCpn4s
         comNHynAl18yvCrNNtgKYfYz/EMUpj+yqAr/Js37b6RKEMaR8QIArNuiPcUD9w8dvqyC
         tktw==
X-Gm-Message-State: ACrzQf3mzW12nRtPsIhGVva1yds/0nNa8JGzkXsUvhIHKv3gE+K2p3IW
        5qb0izXG+8wEyDHe5Mq4K5FJdj/fb6o=
X-Google-Smtp-Source: AMsMyM7apwGfFRDIHu9LfviuQI9Bhpfrol/qPqqes0Gvr/UmBXIYeJpXJ2YFQtshaaIoNnrCoIlxiA==
X-Received: by 2002:a05:6a00:1493:b0:546:2856:6d08 with SMTP id v19-20020a056a00149300b0054628566d08mr33617512pfu.84.1664354958891;
        Wed, 28 Sep 2022 01:49:18 -0700 (PDT)
Received: from localhost.localdomain (125-228-123-29.hinet-ip.hinet.net. [125.228.123.29])
        by smtp.gmail.com with ESMTPSA id t1-20020a17090a024100b00200461cfa99sm780456pje.11.2022.09.28.01.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 01:49:18 -0700 (PDT)
From:   Potin Lai <potin.lai.pt@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joel Stanley <joel@jms.id.au>,
        Patrick Williams <patrick@stwcx.xyz>,
        Potin Lai <potin.lai@quantatw.com>,
        Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH 1/1] leds: pca955x: fix return value checking of smbus block read
Date:   Wed, 28 Sep 2022 16:47:09 +0800
Message-Id: <20220928084709.1822312-1-potin.lai.pt@gmail.com>
X-Mailer: git-send-email 2.31.1
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

In i2c_smbus_read_i2c_block_data(), it returns negtive value for error
code, otherwise returns data length of reading.
Change the if statement to "if (err < 0)" to indicate the real error
returned by i2c_smbus_read_i2c_block_data().

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 drivers/leds/leds-pca955x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/leds-pca955x.c b/drivers/leds/leds-pca955x.c
index cf0a9fe20086a..cba9876b11872 100644
--- a/drivers/leds/leds-pca955x.c
+++ b/drivers/leds/leds-pca955x.c
@@ -689,7 +689,7 @@ static int pca955x_probe(struct i2c_client *client)
 	err = i2c_smbus_read_i2c_block_data(client,
 					    0x10 | (pca955x_num_input_regs(chip->bits) + 4), nls,
 					    ls1);
-	if (err)
+	if (err < 0)
 		return err;
 
 	for (i = 0; i < nls; ++i)
-- 
2.31.1

