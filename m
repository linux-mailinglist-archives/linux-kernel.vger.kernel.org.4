Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFCE72754E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 04:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233873AbjFHCyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 22:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233835AbjFHCyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 22:54:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA032103;
        Wed,  7 Jun 2023 19:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=xA93YpODwXSEXwOg759c50kN9HhjwSvfbwEHkBFXNMM=; b=EBli7UlTGu/OQDRqm5hvXT6rNk
        6w+MOgYceFTD0zypl9H1P0yPFfo9XL25UL7rWfZvxELR8dr47WwRgkd7GOqoiLoM3sLypqzh47QvN
        /Hk/KskMYPkRQfoKguqwzRczFkVzPsJGPQbUiYb3SQPAJFHTuyaJlMrORnqvlcmWSr1PnnmZgKbtg
        I+nNbLuC7jxLA9ge3XZ0XRO22MlfgZCIpcM41Fk7OyK7bjP6IgxQ1ij6RwomqMJ85k0gjhAaLn46Q
        /sfAv+U/YTfl8gPHZ0YUDOXXiB6/Ze7b4B3HTrah8K5+hAuNjvoA1BYNcnYcH2H+h47y5SbgV1n23
        YCq/qm2w==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q75nI-007rnl-1K;
        Thu, 08 Jun 2023 02:54:36 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jeff Chase <jnchase@google.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Joe Tessler <jrt@google.com>, linux-media@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] media: cec: i2c: ch7322: also select REGMAP
Date:   Wed,  7 Jun 2023 19:54:35 -0700
Message-Id: <20230608025435.29249-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Selecting only REGMAP_I2C can leave REGMAP unset, causing build errors,
so also select REGMAP to prevent the build errors.

../drivers/media/cec/i2c/ch7322.c:158:21: error: variable 'ch7322_regmap' has initializer but incomplete type
  158 | static const struct regmap_config ch7322_regmap = {
../drivers/media/cec/i2c/ch7322.c:159:10: error: 'const struct regmap_config' has no member named 'reg_bits'
  159 |         .reg_bits = 8,
../drivers/media/cec/i2c/ch7322.c:159:21: warning: excess elements in struct initializer
  159 |         .reg_bits = 8,
../drivers/media/cec/i2c/ch7322.c:160:10: error: 'const struct regmap_config' has no member named 'val_bits'
  160 |         .val_bits = 8,
../drivers/media/cec/i2c/ch7322.c:160:21: warning: excess elements in struct initializer
  160 |         .val_bits = 8,
../drivers/media/cec/i2c/ch7322.c:161:10: error: 'const struct regmap_config' has no member named 'max_register'
  161 |         .max_register = 0x7f,
../drivers/media/cec/i2c/ch7322.c:161:25: warning: excess elements in struct initializer
  161 |         .max_register = 0x7f,
../drivers/media/cec/i2c/ch7322.c:162:10: error: 'const struct regmap_config' has no member named 'disable_locking'
  162 |         .disable_locking = true,
../drivers/media/cec/i2c/ch7322.c:162:28: warning: excess elements in struct initializer
  162 |         .disable_locking = true,
../drivers/media/cec/i2c/ch7322.c: In function 'ch7322_probe':
../drivers/media/cec/i2c/ch7322.c:468:26: error: implicit declaration of function 'devm_regmap_init_i2c' [-Werror=implicit-function-declaration]
  468 |         ch7322->regmap = devm_regmap_init_i2c(client, &ch7322_regmap);
../drivers/media/cec/i2c/ch7322.c:468:24: warning: assignment to 'struct regmap *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
  468 |         ch7322->regmap = devm_regmap_init_i2c(client, &ch7322_regmap);
../drivers/media/cec/i2c/ch7322.c: At top level:
../drivers/media/cec/i2c/ch7322.c:158:35: error: storage size of 'ch7322_regmap' isn't known
  158 | static const struct regmap_config ch7322_regmap = {

Fixes: 21b9a47e0ec7 ("media: cec: i2c: ch7322: Add ch7322 CEC controller driver")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jeff Chase <jnchase@google.com>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Joe Tessler <jrt@google.com>
Cc: linux-media@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Brown <broonie@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
---
 drivers/media/cec/i2c/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff -- a/drivers/media/cec/i2c/Kconfig b/drivers/media/cec/i2c/Kconfig
--- a/drivers/media/cec/i2c/Kconfig
+++ b/drivers/media/cec/i2c/Kconfig
@@ -5,6 +5,7 @@
 config CEC_CH7322
 	tristate "Chrontel CH7322 CEC controller"
 	depends on I2C
+	select REGMAP
 	select REGMAP_I2C
 	select CEC_CORE
 	help
