Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BECBC6F6AC9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 14:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjEDMDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 08:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjEDMDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 08:03:33 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8B16183;
        Thu,  4 May 2023 05:03:31 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3063433fa66so247703f8f.3;
        Thu, 04 May 2023 05:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683201810; x=1685793810;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6TAZl+kz9m/wfssQC8KSu0Un2Jma1I5gxk5FcUuBx+Y=;
        b=BtYlugv9onVDOyEM6Gl6oY2521RH/4BVNmWgrZ/jPnuvSPwfCcLnoiobU55A9ghhaa
         k2KW1jMeZo3MuUVgfOHQTn7Dc7gqTZK2W/JKmhr0LvMIyPV4HbBHDfusomH3olhMpw7r
         XC++1ckzzDRUsaNdRlf6XeifvPz3OohN0QJ+RMa7TuYQLuJBc3QKI6JHySUwoldvsYv1
         NLWUvrDwjZc3sXSO+qpeB4x+IVzJvJN8RfHtZXkMMdkCXAcm/vwj6iRh4lZn3qWATH4e
         biEdOMUtLextTK5HlQ/f5gPvARJQNl1Nx1E8+JZBnJILfVidXvSonSkvotE4DiXwAgYc
         pEFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683201810; x=1685793810;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6TAZl+kz9m/wfssQC8KSu0Un2Jma1I5gxk5FcUuBx+Y=;
        b=dnXnjfg1pEtbS9BKshg0Z4NA1lzk92lM/MGPTpzskBUw/RE1x+PHdsCjiRp2D3Av7L
         7UtZf0zwn3QzlAfmhwmu3UGKRsAMs480kv2mjddYzQZBKjc+tOtZs+Y/6WcgGF745iyJ
         cwSPKsSdXEPBR7QGpa5hqNgodRJTqOPos5VeOY4ayOIosPQHVLSYdnQ6giU/6CXTSA6p
         NjsRK63C2veWQx+uPTQ3gTZx1+ENTkLlPVQRLGj3+X7zvY+prAtDJCgjkemaWx2sYLgp
         42PQb1/71M+bysXrfAwj+cY8OQKA/DsviMNugSMtG4AgyHaXn3M+Gq8x/k4ysNqKzIy4
         Cjug==
X-Gm-Message-State: AC+VfDwBX/L1+9IQCNIrEV0TIiumeEB9wl7wU77cYYJeWfNVCF+QlRB7
        N4Pux8jAWlaNg8uPxdlaBkk=
X-Google-Smtp-Source: ACHHUZ5MvQV5jgyMT+n6Shrlvy3UauNflttZKSFYqWrdYD5sgCai0+2C+kCZZj6UU2uh4U5hSQCx0w==
X-Received: by 2002:a05:6000:d2:b0:306:37ac:ef8e with SMTP id q18-20020a05600000d200b0030637acef8emr2262442wrx.56.1683201810312;
        Thu, 04 May 2023 05:03:30 -0700 (PDT)
Received: from koko.localdomain (cgn-89-1-213-9.nc.de. [89.1.213.9])
        by smtp.gmail.com with ESMTPSA id a7-20020adfdd07000000b003062db9cc21sm10942632wrm.92.2023.05.04.05.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 05:03:29 -0700 (PDT)
From:   Maximilian Weigand <mweigand2017@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Maximilian Weigand <mweigand@mweigand.net>,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v3 0/1] Small fixes to the cyttsp5 touchscreen driver
Date:   Thu,  4 May 2023 14:03:15 +0200
Message-Id: <20230504120316.408687-1-mweigand2017@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maximilian Weigand <mweigand@mweigand.net>

Currently the cyttsp5 driver does not put the device to sleep during
suspend, which can have unwanted side effects if an irq trigger of type
EDGE_FALLING is used, as well as leads to increased power usage.

Correspondingly, sleep and wakeup commands to the touchscreen were
derived from the GPL-2 vendor/android driver by Cypress Semiconductor
(copyright note for Cypress Semiconductor is already in the current
driver).

Tested on the Pine64 PineNote.

Changes in v3:
- dropped patches 1,2,5: already applied in v2
- dropped patch 4 "Input: cyttsp5 - properly initialize the device as a
  pm wakeup device" - functionality is already taken care of in the
  kernel
- dropped patch 3 "dt-bindings: input: cypress,tt21000 - fix interrupt
  type in dts example": it was suggested that the driver should work
  with both interrupt types, falling edge and level low. Once a solution
  is found it will be submitted as a separate patch.
- reworked patch 6 "Input: cyttsp5 - implement proper sleep and wakeup
  procedures" in response to review comments:
	- use the existing completion instead of adding a new one for
	  sleep/wakeup command handling
	- use device_may_wakeup() to determine if the device should be
	  suspended upon entering standby
	- clarified commit message

Changes in v2:
- fix subject lines
- fix 'unused variable' errors reported by the kernel test robot
- clean up commit message of patch 2

Maximilian Weigand (1):
  Input: cyttsp5 - implement proper sleep and wakeup procedures

 drivers/input/touchscreen/cyttsp5.c | 118 ++++++++++++++++++++++++++++
 1 file changed, 118 insertions(+)


base-commit: 457391b0380335d5e9a5babdec90ac53928b23b4
--
2.39.2

