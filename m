Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E79688031
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 15:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbjBBOdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 09:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbjBBOdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 09:33:16 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BDE6DFC6;
        Thu,  2 Feb 2023 06:33:11 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id me3so6476667ejb.7;
        Thu, 02 Feb 2023 06:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DHsKnCrkXhOuDYV6+psb/tAdbPB1L9cKyhHKv9nMf6Y=;
        b=jDvvFl1HOwLXc0lbexFGVnSiiWaY+hhv9rMr5kUceI/zzR0eQV4gXV4+jzbe2CH7Or
         4jizr+0XBF6cFSgmDJf5MszV48SOf1KU1aScqcdb60stjZiPS6PUCwvUDvMCOaKs0QYo
         6lFWaXTYz1aknDvr3UfH4r4VGpG9LPo+axd7OVHJ7G3iXulq0YtmnAK1viZvW837RsTu
         awZxD4U3yc6QgN4a3HoXWLZy8vXb5BDXl7f2+IsKQoNotyPH60soQubKufK/Fl0A0kys
         dsk0Ijf8TQcGS5PyYlOaVZ6wiuuK41CtwXso8VpeyD08InIa9mP2bIpUYMl6KErKRbEA
         f7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DHsKnCrkXhOuDYV6+psb/tAdbPB1L9cKyhHKv9nMf6Y=;
        b=O4wWjOTsqxmCfWhiV2/mT5VQRArZ7alhSv4fu8mjgFd1qs5FISWrb1Twejg2Q8oFv3
         P+lrHuTNAt8RK+3ChWdD03zCnRITXqgCZuwMYEp4GWOW4jJmWz6NzcYZZmMTfax5FGfj
         tGpoBaui08LhtDCc5bC5Fyf7bbfepf+0Py5ESGsUFBUWMG1PjGYDYu+TdQarUri+Aeml
         tHYfqtakt4R2Sl8x1tRtcPURxhWa/e0m4z+G6auk8cEIfX8GeQe99ewZbcXe5reQ7l9L
         HmAArL84mqfCounEizc23pwh6eGyOpZy7LHG9ACVlABJq/tAlvXk6ByB0DSOIKcB272U
         w6ww==
X-Gm-Message-State: AO0yUKXCRd8sHBjmoZSLuCleZ/dEPjAB8ofulCXIxSz/UfNu45KxPNvs
        gKvJUrjnqQGCjfr/oXEacnYo1Pts6P1dWg==
X-Google-Smtp-Source: AK7set9YH61SsDQpzrCjhRdmXusAByNf2t2Y7y9NvtsXebSPFTPdIDbKu7QwrbLLU6TjpFEuu3mwYA==
X-Received: by 2002:a17:906:8a43:b0:861:4671:a834 with SMTP id gx3-20020a1709068a4300b008614671a834mr5664657ejc.71.1675348389392;
        Thu, 02 Feb 2023 06:33:09 -0800 (PST)
Received: from fedora.local.tbs-biometrics.cz (176-74-132-138.netdatacomm.cz. [176.74.132.138])
        by smtp.gmail.com with ESMTPSA id h17-20020a1709066d9100b0087856bd9dbbsm11814237ejt.97.2023.02.02.06.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 06:33:08 -0800 (PST)
From:   =?UTF-8?q?Martin=20Za=C5=A5ovi=C4=8D?= <m.zatovic1@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        gregkh@linuxfoundation.org, martin.petersen@oracle.com,
        beanhuo@micron.com, arnd@arndb.de, avri.altman@wdc.com,
        iwona.winiarska@intel.com, fmdefrancesco@gmail.com,
        dipenp@nvidia.com, ogabbay@kernel.org, bvanassche@acm.org,
        mathieu.poirier@linaro.org, yangyicong@hisilicon.com,
        dan.j.williams@intel.com, devicetree@vger.kernel.org,
        linus.walleij@linaro.org,
        =?UTF-8?q?Martin=20Za=C5=A5ovi=C4=8D?= <m.zatovic1@gmail.com>
Subject: [PATCHv2 0/4] Wiegand bus driver and GPIO bit-banged controller
Date:   Thu,  2 Feb 2023 15:33:01 +0100
Message-Id: <20230202143305.21789-1-m.zatovic1@gmail.com>
X-Mailer: git-send-email 2.39.1
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

Thank you for your feedback on the last version.

I came to a realization, that it is for the best to let message
formats and checksum calculation be handled by device drivers.
Support of these options was removed from the bus driver.

The GPIO bitbanging controller driver contained two attribute
files - format and payload_len. The format file is obviously not
needed anymore, however I have decided to keep the payload_len
file. It seems to me to be the best way to communicate this
information to the controller driver. This information needs
to be provided especially in order for the /dev file to work
properly(as the driver has no idea where the message ends). If
there is a better way to approach this problem, please let me
know.

Device drivers will not face the same problem, as the length of
a message is passed with every call of the transfer_message()
function.

CHANGELOG since v1:
- added dt-bindings for wiegand_gpio driver
- dt_binding_check now passes
- added help texts to Kconfig files
- removed controller list from bus driver
- removed the option to add a device from another driver (along
  with wiegand_baord_info structure)
- moved the bus driver to drivers/wiegand/
- removed all explicit castings, used specific getters instead
- fixed indentation
- removed fromat attribute from controller structure
- removed format implementation from wiegand_gpio driver

Martin Zaťovič (4):
  dt-bindings: wiegand: add Wiegand controller common properties
  wiegand: add Wiegand bus driver
  dt-bindings: wiegand: add GPIO bitbanged Wiegand documentation
  wiegand: add Wiegand GPIO bit-banged controller driver

 .../ABI/testing/sysfs-driver-wiegand-gpio     |   9 +
 .../bindings/wiegand/wiegand-controller.yaml  |  50 ++
 .../bindings/wiegand/wiegand-gpio.yaml        |  51 ++
 MAINTAINERS                                   |  14 +
 drivers/Kconfig                               |   2 +
 drivers/Makefile                              |   1 +
 drivers/wiegand/Kconfig                       |  28 +
 drivers/wiegand/Makefile                      |   2 +
 drivers/wiegand/wiegand-gpio.c                | 324 +++++++++++
 drivers/wiegand/wiegand.c                     | 543 ++++++++++++++++++
 include/linux/wiegand.h                       | 177 ++++++
 11 files changed, 1201 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-wiegand-gpio
 create mode 100644 Documentation/devicetree/bindings/wiegand/wiegand-controller.yaml
 create mode 100644 Documentation/devicetree/bindings/wiegand/wiegand-gpio.yaml
 create mode 100644 drivers/wiegand/Kconfig
 create mode 100644 drivers/wiegand/Makefile
 create mode 100644 drivers/wiegand/wiegand-gpio.c
 create mode 100644 drivers/wiegand/wiegand.c
 create mode 100644 include/linux/wiegand.h

-- 
2.39.1

