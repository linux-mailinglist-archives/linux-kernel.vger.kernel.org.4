Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D257871284C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 16:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243887AbjEZObR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 10:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243869AbjEZObJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 10:31:09 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D7E199;
        Fri, 26 May 2023 07:31:07 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-97000a039b2so134277966b.2;
        Fri, 26 May 2023 07:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685111466; x=1687703466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Emss/vVgehkGPlk0MWd1pRNn8uU75rHhNKdy8MFJSnM=;
        b=gsR38iCEZDGns9v9iLjxW+SBA4awvzGbW5RP5d0vNxz74tKf5Uh9zrTogcniRJJZ2D
         bjxHMrNwJdrgvAmcxjQIqU+KL6+cMLbyvC+oXohThlbFhCf+n9CW1jUnbtPkZLtA/oYp
         pXqSnbupDGqFAmXJ2UFmHG09BU16hr0jV1FilQWeTBT1BcKpzulB6mY8otfelP+WQSZL
         domvyhCRZyC5l2P4iFKgf57qvFWiztXqP2Bbrtb/KZh2TMkaRYvJGWY7LxcSAR1tfXDK
         wqkWTimbMX5D0Exzl0/b57cEANNsLJYjdSkDFzp0KztDfey6gQvnRIuP/9IuXVpKoGr+
         jGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685111466; x=1687703466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Emss/vVgehkGPlk0MWd1pRNn8uU75rHhNKdy8MFJSnM=;
        b=OkvnTDslWP74PnyEJzZ99g6cU3brszhabNqLzbnRciVcuqRv9iyicbRWw1n7aifUwa
         3ifiqiQ2ZO7yfqxoB4/D9VxVCXqueQME5X67woCccr1Zj3zQpwmTRtYf73bIET1IJAF2
         B8DqbwoiBGnxNA5NsTAnsqvcgIdFi1dPsRgxkfbl31jp6/0w3vDMCWFhzVFQ/3RTSZjM
         aNNAMANFLuxlGlgvedzEFnfg+KneeTaFTUcYh83U+epzjE3gVLHv0CFBJ1Po4aHIxIm/
         lwIjKQfWRxdWRsf9KjVbrhTlJog8/a+Ph+cNKk4hbk+2TTJHg/6xIhr6g+rSeIi+wRDH
         H24g==
X-Gm-Message-State: AC+VfDyq6QmkngRT34f8mH+NpkOOID2/CAi63vD+NF3xEVOU77Z3Pged
        3YZj1zbkV68kK+kgIueCAkc=
X-Google-Smtp-Source: ACHHUZ5WouNaQudIkEYs+iCnf/0BhM7E3ypFhJtT88w+lCCYj2U6islw6WpF/JgHPanJicvF8WyAjQ==
X-Received: by 2002:a17:907:31c1:b0:94f:3bf7:dacf with SMTP id xf1-20020a17090731c100b0094f3bf7dacfmr2027006ejb.71.1685111466157;
        Fri, 26 May 2023 07:31:06 -0700 (PDT)
Received: from carbian.corp.quobyte.com ([2a02:8109:aa3f:ead8::d8a0])
        by smtp.gmail.com with ESMTPSA id r20-20020a170906365400b0094e7d196aa4sm2157023ejb.160.2023.05.26.07.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 07:31:05 -0700 (PDT)
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     jic23@kernel.org, mazziesaccount@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mehdi Djait <mehdi.djait.k@gmail.com>
Subject: [PATCH v4 4/7] iio: accel: kionix-kx022a: Add an i2c_device_id table
Date:   Fri, 26 May 2023 16:30:45 +0200
Message-Id: <ea14686bc9a9262ef9c370d9cd1a4a7b2902b4ea.1685109507.git.mehdi.djait.k@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1685109507.git.mehdi.djait.k@gmail.com>
References: <cover.1685109507.git.mehdi.djait.k@gmail.com>
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

Add the missing i2c device id.

Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
---
v4:
- no changes

v3:                                                                             
- no changes, this patch is introduced in the v2 

 drivers/iio/accel/kionix-kx022a-i2c.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/accel/kionix-kx022a-i2c.c b/drivers/iio/accel/kionix-kx022a-i2c.c
index e6fd02d931b6..b5a85ce3a891 100644
--- a/drivers/iio/accel/kionix-kx022a-i2c.c
+++ b/drivers/iio/accel/kionix-kx022a-i2c.c
@@ -30,6 +30,12 @@ static int kx022a_i2c_probe(struct i2c_client *i2c)
 	return kx022a_probe_internal(dev);
 }
 
+static const struct i2c_device_id kx022a_i2c_id[] = {
+	{ .name = "kx022a" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, kx022a_i2c_id);
+
 static const struct of_device_id kx022a_of_match[] = {
 	{ .compatible = "kionix,kx022a", },
 	{ }
@@ -42,6 +48,7 @@ static struct i2c_driver kx022a_i2c_driver = {
 		.of_match_table = kx022a_of_match,
 	  },
 	.probe_new    = kx022a_i2c_probe,
+	.id_table     = kx022a_i2c_id,
 };
 module_i2c_driver(kx022a_i2c_driver);
 
-- 
2.30.2

