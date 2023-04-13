Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775B06E125D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 18:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjDMQeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 12:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjDMQeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 12:34:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88013212C;
        Thu, 13 Apr 2023 09:33:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19D9163FF2;
        Thu, 13 Apr 2023 16:33:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD586C433EF;
        Thu, 13 Apr 2023 16:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681403638;
        bh=EUXwuWZquNO+Y7E+kEoHBKTgHUKZXJPe1OyZlz61KFk=;
        h=From:To:Cc:Subject:Date:From;
        b=sVhPo1uQa3Qhg4rzL9hKAgUPoBLIYZnATfPyf1dK8hxIUyruCdhCZWl4+PgzDIxcp
         OUmie7uCp9rVXOAJ1RmBCDcDGA+gb/bnHS+kcPlFvU337ZuH6Zp5HYTdY8kHMAhrR4
         b+USbYAn14i0AqxJsCb8zsRItFFF+EzbD1lzgsBEzekrdcAq86/r6fnzTkwOc7iKqn
         6l4k3JX5AJB4V6/joC2dQQJGC9sIC53n/Lkxh6qBQPg9+70wilJFaQSmSHEfZIrbc7
         AV6F56jEbFQjbxxKiHxlNgNGylqqrdPenu6yKwr5QifTmdwTmYFq0HS2ZpozF9jL2n
         gaohEUwIsp7Qw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] of: move dummy of_device_get_match_data() helper
Date:   Thu, 13 Apr 2023 18:33:30 +0200
Message-Id: <20230413163353.3408208-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The previous patch only moved the regular declaration but missed
the inline function that is used with CONFIG_OF=n:

drivers/tty/serial/samsung_tty.c:2034:10: error: implicit declaration of function 'of_device_get_match_data' is invalid in C99 [-Werror,-Wimplicit-function-declaration]

Fixes: f5a2dc751657 ("of: Move of_device_get_match_data() declaration")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/of.h        | 5 +++++
 include/linux/of_device.h | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/of.h b/include/linux/of.h
index f94f9e6476c0..c0d1512f979a 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -815,6 +815,11 @@ static inline bool of_console_check(const struct device_node *dn, const char *na
 	return false;
 }
 
+static inline const void *of_device_get_match_data(const struct device *dev)
+{
+	return NULL;
+}
+
 static inline const __be32 *of_prop_next_u32(struct property *prop,
 		const __be32 *cur, u32 *pu)
 {
diff --git a/include/linux/of_device.h b/include/linux/of_device.h
index 455c51a09091..2c7a3d4bc775 100644
--- a/include/linux/of_device.h
+++ b/include/linux/of_device.h
@@ -51,11 +51,6 @@ static inline int of_driver_match_device(struct device *dev,
 static inline void of_device_uevent(const struct device *dev,
 			struct kobj_uevent_env *env) { }
 
-static inline const void *of_device_get_match_data(const struct device *dev)
-{
-	return NULL;
-}
-
 static inline int of_device_modalias(struct device *dev,
 				     char *str, ssize_t len)
 {
-- 
2.39.2

