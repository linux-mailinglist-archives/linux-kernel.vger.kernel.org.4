Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B65705FC7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 08:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbjEQGNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 02:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbjEQGNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 02:13:48 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27028F9
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 23:13:47 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-51452556acdso214126a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 23:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684304026; x=1686896026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+xe++PPFxAqZmFUmk8nxOwFru2SEGtMw+b/q79MKRQ=;
        b=dTVywf4BrKEnKnyC6rf/+P+vJiymsp9QtzdF2IFgyk/0DOAUJTmhFsq5fByCNyNzgj
         Rq9GvYECoyllqQC1eGWSIW+jn8xRkSMPeDLXMkGs1qC8az9ZrdaQQRuODegeRhv0m29h
         6q1n+6IuTW4CZ/ZRv1pGe4jW+62uiEQJ5wRZ+lm7cIZOjuquJj1HNfSHri7Uwx5AiZo5
         7cjByCFhF+6avIwzu8zio/OPdHwLJ84qho7flwoO7DDlZBRa0vSSDANOXYr0V7DkXxUl
         U1pmVMh5PEc0MB+AgVA8mHrNDGSM4h4dGpeaE48bzaYJ3K7a3aEe/uwIhGO9nW46ITFQ
         jvyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684304026; x=1686896026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y+xe++PPFxAqZmFUmk8nxOwFru2SEGtMw+b/q79MKRQ=;
        b=f9f8BSphBSni/5a6ccdPcDcJYmzktAAoiyABePmfi6iNLz6WfWkA3iIy8ffg9KyvUg
         m8yaXoiAQOz+zjSJozq/MskJP1cTkZmBtMKV9LZ+5WBtSYp82katpKpGB4MiumNzICP6
         jtkzVbik0BXlEgAFoVdhTGgEHv/xt0vcwld14Uv4lvAJnte5MqfyQwtd1Wc1bbg7yzox
         zXF5tsjyV6IFO/Ta5vQrgR77p4J8ixiCY7j7pZi6ozfbDg6dPZqGuP1z7EKJArSaL27/
         CUjkLaad22n1cqUdNbeeqV6aGiemeVS4ycp/23E6yXzzDu0WBr1bpt3UzpG93cT+/YVP
         Q5Lw==
X-Gm-Message-State: AC+VfDwFu93+J/r9nHNBgIwi3HvZzXUmYtmR7nZXlumKwSTJwm0kTMyj
        3nxMhM2QpU5VuKBOFBpI5Xk=
X-Google-Smtp-Source: ACHHUZ6OO4AjAi8uPO/dKHzm6AcMcHjztS9mq/PtNLNVKViq2cjV+8tgyjVMnpWsNV2VbN6LaQaBJA==
X-Received: by 2002:a05:6a20:160f:b0:103:81cc:dd3f with SMTP id l15-20020a056a20160f00b0010381ccdd3fmr32736910pzj.48.1684304026519;
        Tue, 16 May 2023 23:13:46 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-16.three.co.id. [180.214.232.16])
        by smtp.gmail.com with ESMTPSA id o33-20020a635a21000000b0052871962579sm14282506pgb.63.2023.05.16.23.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 23:13:45 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 1F527106280; Wed, 17 May 2023 13:13:41 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Pavel Machek <pavel@ucw.cz>, Kalle Valo <kvalo@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Maxime Bizon <mbizon@freebox.fr>
Subject: [PATCH 2/3] pcmcia: Add SPDX identifier for GPL 2.0-licensed driver files
Date:   Wed, 17 May 2023 13:13:37 +0700
Message-Id: <20230517061338.1081810-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517061338.1081810-1-bagasdotme@gmail.com>
References: <20230517061338.1081810-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1578; i=bagasdotme@gmail.com; h=from:subject; bh=Txu1+lAptVI2WkqeHh/4tmKyXztRyadDj4Ftm2l9gFU=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDCkpBZMmXTTjPs4mtPipsizbsygvtpPzdCTyWHbOSGNbs 4inNKy2o5SFQYyLQVZMkWVSIl/T6V1GIhfa1zrCzGFlAhnCwMUpABORWcPwP5D5ofTi5m3rOPzL VvAe5/qhWKVr+l/j8jdG8YRl++qF9jL8FeVpLdvno1kXIjH78993GjM5BSbZqv5LLZsqsudT+q+ XrAA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

License notice for pcmcia driver for bcm63xx contains pointer to COPYING
in the top-level directory of kernel tree. Replace the boilerplate with
SPDX tag for GPL 2.0 (the same license as Linux kernel itself).

On the other hand, px2xx_base.h doesn't have any SPDX tag. Add the tag
for GPL 2.0 too.

Cc: Maxime Bizon <mbizon@freebox.fr>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 drivers/pcmcia/bcm63xx_pcmcia.c | 5 +----
 drivers/pcmcia/pxa2xx_base.h    | 1 +
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pcmcia/bcm63xx_pcmcia.c b/drivers/pcmcia/bcm63xx_pcmcia.c
index dd3c2609904877..0564bcabf85dc9 100644
--- a/drivers/pcmcia/bcm63xx_pcmcia.c
+++ b/drivers/pcmcia/bcm63xx_pcmcia.c
@@ -1,8 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
  * Copyright (C) 2008 Maxime Bizon <mbizon@freebox.fr>
  */
 
diff --git a/drivers/pcmcia/pxa2xx_base.h b/drivers/pcmcia/pxa2xx_base.h
index e58c7a41541880..9583d08983f5cd 100644
--- a/drivers/pcmcia/pxa2xx_base.h
+++ b/drivers/pcmcia/pxa2xx_base.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 int pxa2xx_drv_pcmcia_add_one(struct soc_pcmcia_socket *skt);
 void pxa2xx_drv_pcmcia_ops(struct pcmcia_low_level *ops);
 void pxa2xx_configure_sockets(struct device *dev, struct pcmcia_low_level *ops);
-- 
An old man doll... just what I always wanted! - Clara

