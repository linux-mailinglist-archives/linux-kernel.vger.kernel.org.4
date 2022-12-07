Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA72864538A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 06:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiLGFul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 00:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLGFui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 00:50:38 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2D556EF7;
        Tue,  6 Dec 2022 21:50:35 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id v3so15351954pgh.4;
        Tue, 06 Dec 2022 21:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ztdTBdFFzUgQtkWJUCxW6jiR87PJzZ+mXWctPgKolvM=;
        b=cwaZlpRJcZkWrW1FyxsDLEheAAy0epxJZIGVnF2OHn+vxCTv9Gx1WPd2EYZzlC2atf
         /8i3aEbTRITS1FSxe/j6ZGozNNti9FaDRbOcmEyFYVuKEgSExDemoMc0IFJSFBm5WKgQ
         DW0uH5ReUEnIi4wXXWMBUp6e5SQYj9oeGm8tTiYlhev8KWakKvAMnBfexG1HcwIrJgYJ
         RUWLSFWSlJOI9+0jNiAzQh4of1wd1WwP04bX0YNmLXAqctvMYYqMRX3lXBaa3BZm0TJp
         x8lCxvjzAGNSvnfC2Mxh9F30DXCoJq+oAk0lzAeRDRJDuclluxWXsp3LxtpsV/gZ/Elg
         6fdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ztdTBdFFzUgQtkWJUCxW6jiR87PJzZ+mXWctPgKolvM=;
        b=8FbmzSUj5VhSdi9XTzfoWHHGAW/tlvsbPvvEpJx06lP6h0RnxMuxG1pnomki+86bDQ
         A7rgW5D/RIFQMav90cnHD4MbTVyromK7uzUNBkHvNNd6YMqbsZxb3TQ5u3LVYT9w/Bc5
         wliwhKkgUJUM8rUbgAqHN2xLgPakD+EzjVnhbVAJdPgrQflMf0TnTRM5d+NSN3iG/7tx
         Tx1+4wQoiOVk/yi7Y1EO8Fx2shFkye5HCH4RFyp6QWjqlJEH7seRNcdjxAMgaxn0OQXY
         fELouO5uTsp6eEJmDpzI1nLxOHjMPKZN0BnAEzRnBnzsUFMR4CL07S89dGEeqE2UxCU9
         dDTQ==
X-Gm-Message-State: ANoB5pkULcLtEChWz58Hl0Tb0ykzsGbQNsNvbIpd8U3eXoH4br7c4MbQ
        ZtwIFCPqomJVzDNEQc9iEDk=
X-Google-Smtp-Source: AA0mqf5mbJs2dMxZ6PHqkjyrhifzu6YOoUOjBC8Ai/bTwE1VvdZ4l/P23iP+6RwVJNQPxuiZqFSnUg==
X-Received: by 2002:a63:1055:0:b0:46e:f011:9548 with SMTP id 21-20020a631055000000b0046ef0119548mr63000322pgq.553.1670392234534;
        Tue, 06 Dec 2022 21:50:34 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id e7-20020a630f07000000b004777c56747csm10585615pgl.11.2022.12.06.21.50.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Dec 2022 21:50:33 -0800 (PST)
From:   Li-hao Kuo <lhjeff911@gmail.com>
To:     rafael@kernel.org, krzk@kernel.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amitk@kernel.org, robh+dt@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lh.kuo@sunplus.com, Li-hao Kuo <lhjeff911@gmail.com>
Subject: [PATCH v13 0/2] Add thermal control driver for Sunplus SoC
Date:   Wed,  7 Dec 2022 13:50:34 +0800
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

