Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1196A2E6C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 06:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjBZFkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 00:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjBZFj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 00:39:59 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537CE136F2;
        Sat, 25 Feb 2023 21:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=HOomam99WaNIQXbFT/rjlLSN0DNgUGphOu08F90yWb4=; b=1dLCZvQkudXTaKFBvI3S7iA1N9
        5iYkLfTq2a0QOKkHfo9rt38xzfD+xBLIzrKc6yWt7Qaud3nLKhnXBhjnx0jI5hjQjpft3TgSmH+rB
        7xXr0AI+c3NGzW2+vo642Qx2tVGbwNEy/tCfYJK0t9hFGI2/UlNB22bImGjzX3GRXXEB3qLu3tY4Q
        7ayuDoXn/usLwFSBQsXy+L/g96TTq8ZXh1u6B0CUvmKWDRjt7Gy7ggSLeD7DR4fvHK5YR2L6HN+6L
        Ytzmi45vGRH9Na0qaenIW4MB6FswupthXaf9FeUZg6qn8QCKG6tf1aPIT69SSiIqWTwjpmcZvpkzl
        eOghchog==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pW9lN-006qYL-Ak; Sun, 26 Feb 2023 05:39:57 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Darren Hart <dvhart@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH 6/8] platform: x86: MLX_PLATFORM: select REGMAP instead of depending on it
Date:   Sat, 25 Feb 2023 21:39:51 -0800
Message-Id: <20230226053953.4681-7-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230226053953.4681-1-rdunlap@infradead.org>
References: <20230226053953.4681-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

REGMAP is a hidden (not user visible) symbol. Users cannot set it
directly thru "make *config", so drivers should select it instead of
depending on it if they need it.

Consistently using "select" or "depends on" can also help reduce
Kconfig circular dependency issues.

Therefore, change the use of "depends on REGMAP" to "select REGMAP".

Fixes: ef0f62264b2a ("platform/x86: mlx-platform: Add physical bus number auto detection")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Vadim Pasternak <vadimp@mellanox.com>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Mark Gross <markgross@kernel.org>
Cc: platform-driver-x86@vger.kernel.org
---
 drivers/platform/x86/Kconfig |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff -- a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -955,7 +955,8 @@ config SERIAL_MULTI_INSTANTIATE
 
 config MLX_PLATFORM
 	tristate "Mellanox Technologies platform support"
-	depends on I2C && REGMAP
+	depends on I2C
+	select REGMAP
 	help
 	  This option enables system support for the Mellanox Technologies
 	  platform. The Mellanox systems provide data center networking
