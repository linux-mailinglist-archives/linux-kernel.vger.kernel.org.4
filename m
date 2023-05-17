Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D0D705FC5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 08:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbjEQGNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 02:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbjEQGNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 02:13:47 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F066DC5
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 23:13:46 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1addac3de73so3768895ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 23:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684304026; x=1686896026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gyObQoV+F21B1icMVV2fdZPl1sH5ARH00xmcwrbzWEM=;
        b=qoj0xTBn9xcoxUsjhUYNPVSEtM/CuiUiU/b3Pg1sZn5y3HmrX26PYztvBVKOhBw/lu
         J3njsdReotYNHOyfdCzZZtENGmI7Zpls7S8pcQjY1LJGaoaFw1Xh9k58QAa5Gz8II7im
         8VnhwRXbZk3o96Rn0JE2BASML8nXBmBSU0MEU9g98DqkdS81b2e2qskA6XbOkF/5tGRJ
         m/nVyOvpFUs3zLz0AEtz0LYuHUzVOZXBTEizxg8qub5xPBDMk7PLUG1Gz+cBiJxe4jLb
         Uxt5WxTJ8bAc3MAxB8FSsC+/3pup7qGQIARJn+Q01G/ZfdTjM9PkYljalM+c0pre8fzt
         HnOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684304026; x=1686896026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gyObQoV+F21B1icMVV2fdZPl1sH5ARH00xmcwrbzWEM=;
        b=lZazSVM9JOcE20jwLUOvHpla781xr1H+7dFeEPw9exqV0YKT34WlHEMLOtJ7F+MNWm
         //yoAXG2shCv207MtYBSYxaygpXY0JtEjoh3q542c6sOvuUdwco/PMSFCzIUdk/HFgzQ
         0AL2kHW0CJv8j88o7kNukcAKELDq65PmkQVD7ip3+0w4zzwYKgSsfcsnbF84MoD3h40p
         q00VxREZ4uOdxS8nSdNTIUMQ/z4JUEZKzvz2Hrx9eZI/89joQGoy7/tRqq0rWz5PEmfC
         EmGtEMs3XrDI6g+U3xd9m9zY5gbgAARLb4dr/sARdZI/23GG3OvNKuinU01gH88xsezD
         8pmA==
X-Gm-Message-State: AC+VfDyAngGz9tPURm6Ddns2cIwm2kFFwZepA50+0YA7dY1AorfVbbIP
        H+h4PlmaW9aGaUoJ8DBwXxQ=
X-Google-Smtp-Source: ACHHUZ4rMnZr3W18iCVghUOEPw9TQvxl0NUcdJtqQy4e2NHc0dkfe0EUdF8FcrckCXEOzGvi//kK3w==
X-Received: by 2002:a17:902:e810:b0:1a6:7ed0:147e with SMTP id u16-20020a170902e81000b001a67ed0147emr54565036plg.33.1684304026340;
        Tue, 16 May 2023 23:13:46 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-16.three.co.id. [180.214.232.16])
        by smtp.gmail.com with ESMTPSA id f12-20020a170902860c00b001ac6293577fsm16529066plo.110.2023.05.16.23.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 23:13:45 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 752CF10627D; Wed, 17 May 2023 13:13:41 +0700 (WIB)
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
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 0/3] SPDX conversion on pcmcia drivers
Date:   Wed, 17 May 2023 13:13:35 +0700
Message-Id: <20230517061338.1081810-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1873; i=bagasdotme@gmail.com; h=from:subject; bh=3e7JSXEAL0RYoeG2Z0AEXlhkSui0MEbofClK97WTnjQ=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDCkpBT3GHfsMttS+VhV8tfHSEZaqLM6C1xt2zeeckvDgU dblf26zO0pZGMS4GGTFFFkmJfI1nd5lJHKhfa0jzBxWJpAhDFycAjCR44KMDHNmhi2Vz726dL6Q kZ33J0HG1CPf+5ec+C1//eD+Q8vZLgQy/M+Wnt1hWqa6b8+Eiq2zAtaG93BU/uy4dcmmg215/W3 bODYA
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

This series is SPDX conversion for pcmcia drivers. It is splitted from
v2 of my SPDX conversion series in response to Didi's GPL full name
fixes [1]. I intend to have it merged via driver-core tree as
Dominik's tree (pcmcia-next) is lagging and had not seen any activity
in recent months.

The difference from v2 is the conversion patches are split by license type. 

Happy reviewing!

[1]: https://lore.kernel.org/linux-spdx/20230512100620.36807-1-bagasdotme@gmail.com/

Bagas Sanjaya (3):
  pcmcia: Convert dual GPL/MPL notice to SPDX license identifier
  pcmcia: Add SPDX identifier for GPL 2.0-licensed driver files
  pcmcia: pd6729: Replace unversioned GPL notice with SPDX identifier

 drivers/pcmcia/bcm63xx_pcmcia.c |  5 +----
 drivers/pcmcia/cirrus.h         | 21 +--------------------
 drivers/pcmcia/i82365.c         | 22 +---------------------
 drivers/pcmcia/i82365.h         | 21 +--------------------
 drivers/pcmcia/o2micro.h        | 21 +--------------------
 drivers/pcmcia/pd6729.c         |  3 +--
 drivers/pcmcia/pxa2xx_base.h    |  1 +
 drivers/pcmcia/ricoh.h          | 21 +--------------------
 drivers/pcmcia/sa1100_generic.c | 22 +---------------------
 drivers/pcmcia/sa11xx_base.c    | 22 +---------------------
 drivers/pcmcia/sa11xx_base.h    | 22 +---------------------
 drivers/pcmcia/soc_common.c     | 22 +---------------------
 drivers/pcmcia/tcic.c           | 22 +---------------------
 drivers/pcmcia/tcic.h           | 21 +--------------------
 drivers/pcmcia/ti113x.h         | 21 +--------------------
 drivers/pcmcia/topic.h          | 23 +----------------------
 drivers/pcmcia/vg468.h          | 21 +--------------------
 17 files changed, 17 insertions(+), 294 deletions(-)


base-commit: f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6
-- 
An old man doll... just what I always wanted! - Clara

