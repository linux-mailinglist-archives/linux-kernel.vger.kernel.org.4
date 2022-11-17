Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012E162D5C5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 10:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239462AbiKQJEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 04:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233439AbiKQJEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 04:04:24 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBCF5803E;
        Thu, 17 Nov 2022 01:04:23 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id h14so1089753pjv.4;
        Thu, 17 Nov 2022 01:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ztdTBdFFzUgQtkWJUCxW6jiR87PJzZ+mXWctPgKolvM=;
        b=g4ODfDzPtXVSokneAxBQlarJdcnZHju91Z9fxXEitgbMyfTaW2tAVB6Z20U3KsRsQW
         aBOrGxf3MX2XcmXk+6P80KeA+qRqBhCBCTlaMOuQCoMLwy3JZbqBxr1xNOTziSc/TkTY
         Cqd0fiy1IRuPSIiFkMae5rnmWoqYvq9Pi3GqDURKPzvfyGFMJJw0bZ9LTP4kPkRHm063
         pQnwakQOYJ0Iu6yBR/akZxmI/KdLsMVw7lQ4d5BhEOMTOIduCgKBOB8VxFvMRfDMYPiC
         rFuKn6Etng5U5iYG8nUpHKnKlo4w9315FQhxp96zxLoeWC2epRnmf71exmOdwJ6/+1H2
         QY9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ztdTBdFFzUgQtkWJUCxW6jiR87PJzZ+mXWctPgKolvM=;
        b=yolg7uh3xqBHbZPqKiXJE1IT0NxZ+2YSVxS5wNvj8wHcc0GeeOLH1vTibdvhrWliUi
         wa/+FhJBv1/PUDikeaiw5RglxFSGX3qSUn7BKfU5vHEw7IR9QwVfy6WmOfRiEAnZFTxG
         nBL0N7WFkFEaOQPZki/9P8LLf0VY5Y/gDgmOzw7Oi66pZEXYsmIIJPkhSRZlAUjR0CKC
         wsEVKtp7rXlmq+d69V9q3mccBtu60lC0SROiF2SuZeaQzBaMLYdQ9OHR5m8Omu3J2GPs
         WNe/fUa4n6uglIULRlE0HGAKpocmDrePTlMLOIWutVe2D+OgJ5P6+OF47s2kzQXXLleb
         nTAA==
X-Gm-Message-State: ANoB5pndfFrcQffL6F91N3BFjhlSAi6h2RM151LJwA6fXX1DUSDLphZ4
        e5txVIU/jG2vEXUYMB1rzXg=
X-Google-Smtp-Source: AA0mqf7+sFmVASCLRickTHWUOgdTM7bwItc5i5L9389lvmtDZgTHdGyfXNdhEv424VUFOsx2r+aVyg==
X-Received: by 2002:a17:903:292:b0:186:6f1e:5087 with SMTP id j18-20020a170903029200b001866f1e5087mr1834711plr.119.1668675862758;
        Thu, 17 Nov 2022 01:04:22 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id m13-20020a170902db0d00b00188767268ddsm731239plx.151.2022.11.17.01.04.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Nov 2022 01:04:22 -0800 (PST)
From:   Li-hao Kuo <lhjeff911@gmail.com>
To:     krzk@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
        amitk@kernel.org, rui.zhang@intel.com, robh+dt@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lh.kuo@sunplus.com, Li-hao Kuo <lhjeff911@gmail.com>
Subject: [PATCH v11 0/2] Add thermal control driver for Sunplus SoC
Date:   Thu, 17 Nov 2022 17:04:19 +0800
Message-Id: <cover.1665990345.git.lhjeff911@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch series for thermal driver for Sunplus SoC.

Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates
many peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD card and
etc.) into a single chip. It is designed for industrial control.

Refer to:
https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
https://tibbo.com/store/plus1.html

Li-hao Kuo (2):
  thermal: Add thermal driver for Sunplus
  dt-bindings: thermal: Add Sunplus schema

 .../bindings/thermal/sunplus,sp7021-thermal.yaml   |  43 +++++++
 MAINTAINERS                                        |   7 ++
 drivers/thermal/Kconfig                            |  10 ++
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/sunplus_thermal.c                  | 130 +++++++++++++++++++++
 5 files changed, 191 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/sunplus,sp7021-thermal.yaml
 create mode 100644 drivers/thermal/sunplus_thermal.c

-- 
2.7.4

