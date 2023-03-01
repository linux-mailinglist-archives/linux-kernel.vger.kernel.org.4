Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A79B6A6E67
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 15:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjCAO2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 09:28:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjCAO2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 09:28:45 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C229A10FB;
        Wed,  1 Mar 2023 06:28:44 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id s26so54383901edw.11;
        Wed, 01 Mar 2023 06:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rQvtksOZggRmj3D1Q1teEuWEr6DgpvndBNrh4/4a9Hg=;
        b=RePBZJlsYFQWyA+2fWxHCichaqpZzOQX1RzMY+kxNBets7G5/TvWdWbLQQhDNTVRdx
         kL/XTobwrsqCtZbAEzkb0IXgfSMGMazKC810rA3CccVZXWG26HOpZkrUwn0FvihhAeEt
         T025CLnjKkfolr/vB6iqhlK8XYqmglrBMhGXg0MpSn8E9sRQgtxTS/OL8vjwQBZtj1AS
         vGU0Sh1HN01XCKTD7FqMj4Jwbo1BVRUa+z8ujKoIYG5ywFahByW7qAPFi9wLzpyephgR
         g883Jcey8pSSysPAfz4B0qgWUV/gX5fgstnIDY5MtkRG8MEhTvgEul3f4WU9gpwy+yTd
         4oNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rQvtksOZggRmj3D1Q1teEuWEr6DgpvndBNrh4/4a9Hg=;
        b=JzGlzA63vSjBZBL8JS4us3JioVNXzSaa4XEQ69CIti2+eaO+V6JEGWvPLqE0sRQuXw
         wXJUw+G1HrjlETlDSaoDA66SPbBWjZRtrf1c/rjKRxhKwIEjMnyMLa6inPXEdcxQZWOG
         QWML7ftPAxu/oBWXYVg7b/caDoG+adOVAKVinGL9Zo8eb/jg22qOYuaaqc9aGV4/PwIb
         R7ExJ23aX68HNWhsdHhQuy987NKxTTYNHFqdpJHgWk8G5IzLCgFjLMYgOfw5BnbgvCEX
         Ts7k9b5zE/h9CNox/iqh+YJtEXfRuieB1Wnhm+0VnLWpcNgqhfbDLjsm8Qr6FU3aiCKT
         Blcg==
X-Gm-Message-State: AO0yUKU0A3sPRBH6KpudZXRqUykGgomYat8xjvKb8aaWnnoh/hl0AhYd
        slk/o9VmiV+nL2qs+oOzGWjd5zmPvDYReg==
X-Google-Smtp-Source: AK7set8VoipUW4rEHKVOndeGL/emGDQwwsztMm9yfAglSHv2DhoWZl+8acIJ2B70WNuikh2YaiTh3w==
X-Received: by 2002:a17:907:767a:b0:8b2:e92:41e1 with SMTP id kk26-20020a170907767a00b008b20e9241e1mr6891323ejc.9.1677680923134;
        Wed, 01 Mar 2023 06:28:43 -0800 (PST)
Received: from fedora.local.tbs-biometrics.cz (176-74-132-138.netdatacomm.cz. [176.74.132.138])
        by smtp.gmail.com with ESMTPSA id t8-20020a170906178800b008dcf89a72d7sm5972282eje.147.2023.03.01.06.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 06:28:42 -0800 (PST)
From:   =?UTF-8?q?Martin=20Za=C5=A5ovi=C4=8D?= <m.zatovic1@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        gregkh@linuxfoundation.org, airlied@redhat.com, dipenp@nvidia.com,
        treding@nvidia.com, mwen@igalia.com, fmdefrancesco@gmail.com,
        arnd@arndb.de, bvanassche@acm.org, ogabbay@kernel.org,
        axboe@kernel.dk, mathieu.poirier@linaro.org, linux@zary.sk,
        masahiroy@kernel.org, yangyicong@hisilicon.com,
        dan.j.williams@intel.com, jacek.lawrynowicz@linux.intel.com,
        benjamin.tissoires@redhat.com, devicetree@vger.kernel.org,
        furong.zhou@linux.intel.com, andriy.shevchenko@intel.com,
        linus.walleij@linaro.org,
        =?UTF-8?q?Martin=20Za=C5=A5ovi=C4=8D?= <m.zatovic1@gmail.com>
Subject: [PATCHv3 0/4] Wiegand bus driver and GPIO bitbanged controller
Date:   Wed,  1 Mar 2023 15:28:31 +0100
Message-Id: <20230301142835.19614-1-m.zatovic1@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

thank you for the feedback regarding last patch. I have decided against
using a copyright line despite the suggestion.

CHANGELOG since PATCHv2:
- dropped the Wiegand controller example from the dt-bindings doc, as
  the real one is in the bitbanged controller schema
- fixed some indentation issues
- removed controller class
- functions with "__" as prefix are no longer exported
- improved comment style
- fixed the line length of the code to 100 columns
- removed dev_warn calls for uinitialized controller attributes, instead
  the driver informs about the situation using dev_info and sets the
  uninitialized attribute to its default value
- removed modalias from wiegand_device structure, as I have realized it
  is no longer needed
- removed the list from wiegand_controller structure
- used the tool "pahole" to optimally reorganize all the structures
- ordered headers alphabetically
- removed unnecessary casts
- used attribute group instead of creating the files automatically

Martin Zaťovič (4):
  dt-bindings: wiegand: add Wiegand controller common properties
  wiegand: add Wiegand bus driver
  dt-bindings: wiegand: add GPIO bitbanged Wiegand controller
  wiegand: add Wiegand GPIO bitbanged controller driver

 .../ABI/testing/sysfs-driver-wiegand-gpio     |   9 +
 .../bindings/wiegand/wiegand-controller.yaml  |  39 ++
 .../bindings/wiegand/wiegand-gpio.yaml        |  51 ++
 MAINTAINERS                                   |  14 +
 drivers/Kconfig                               |   2 +
 drivers/Makefile                              |   1 +
 drivers/wiegand/Kconfig                       |  28 +
 drivers/wiegand/Makefile                      |   2 +
 drivers/wiegand/wiegand-gpio.c                | 316 +++++++++++
 drivers/wiegand/wiegand.c                     | 500 ++++++++++++++++++
 include/linux/wiegand.h                       | 155 ++++++
 11 files changed, 1117 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-wiegand-gpio
 create mode 100644 Documentation/devicetree/bindings/wiegand/wiegand-controller.yaml
 create mode 100644 Documentation/devicetree/bindings/wiegand/wiegand-gpio.yaml
 create mode 100644 drivers/wiegand/Kconfig
 create mode 100644 drivers/wiegand/Makefile
 create mode 100644 drivers/wiegand/wiegand-gpio.c
 create mode 100644 drivers/wiegand/wiegand.c
 create mode 100644 include/linux/wiegand.h

-- 
2.39.2

