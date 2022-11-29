Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFFC163C4D6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235277AbiK2QLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233577AbiK2QLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:11:43 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878EA3F052
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:11:42 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id m19so2153772wms.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PS16BaMsGM8fPVcu3pJjD4sqiTElQ39L2P7MYCam4Hs=;
        b=JbLTc66S+a4yjSJthCcjaemWtafnxEHl4YwXNz2UKbDNOZD+IjrCqfzpvLSBZkVb+x
         4MVdxAmsJgNUZAEUfmPkCLms9u7ZD3Oh5Xc2x1/ZKQ01ir66+gG/EO8WssPlulWSFP8f
         4OcqzGhwM6wtAAFOQGclhycM9Ip6Pi5I5gQ3/oKxLHEUZBPf+esHFSTVn7dBK/qFpzjN
         9z520nEd3HdXLJvQQnWaXk025/0oGDORl+095QkZymYck64IBDixXYBAGwqx+bb0W7i0
         hHEi8oSed+oyjYc6LeFFy06yivG7mESOCJHijMkrBPCDT6z6psjCeaqxsV551IQKMmtE
         KlJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PS16BaMsGM8fPVcu3pJjD4sqiTElQ39L2P7MYCam4Hs=;
        b=kFx2FvoIlFsGaRKK+mT5GMe0dVcEGLiQhRjwRSL2iuTDxq4//YLQ/FKYGEIqhymV8O
         Pjaz9xL2PcMDrrhUpj35fcI8XkkHAYsx1mhAvyHgV+fqEjMlP5OTKcLFcp5U7/OYC80n
         FH8n1eKD2G5LvCM0uNZDNuXbmAFKiboeDjbyOxZin3LnFWzRslEwxivPMDh0z/bGWxli
         aFsOQdmx7ngraiBZIn3iM1LZpuIWAimME+NJel8jBBZzL0AwtJxJbldpT+6eFIxU9WOE
         Gy2Wn0na27gcXm0fmclTDXP25XvGFtd7PdoVThVhX6H9qkshSgstnYkZXqOZknP51M7H
         9vMQ==
X-Gm-Message-State: ANoB5pm0lIOO7fjVbv5mpVTagkgQybBhpmFt1TjteQ7ra8jNHEIsXcit
        dMU+OgFv/QQt8OAUCBMEisrJVnIu9lDhnBIH
X-Google-Smtp-Source: AA0mqf6sqjdebQkwajXeWtwvLY0Dr02g5RUFeYTv/8U16oo/veotp5nVeWf1lK0ltMugYHbqhD/oHw==
X-Received: by 2002:a1c:7404:0:b0:3cf:b091:e5a1 with SMTP id p4-20020a1c7404000000b003cfb091e5a1mr41487404wmc.44.1669738301046;
        Tue, 29 Nov 2022 08:11:41 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id n26-20020a05600c3b9a00b003c6b70a4d69sm3144522wms.42.2022.11.29.08.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 08:11:40 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH v8 0/4] Add devicetree support for max6639
Date:   Tue, 29 Nov 2022 17:11:30 +0100
Message-Id: <20221129161134.2672474-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches adds devicetree support for MAX6639.

Changes in V8:
- remove items for reg property
- Fix indentation example
- Set pwms property type to object
- Update pwms property description
- Update title
- Remove unrelated changes
Changes in V7:
- Split the patch into
 1. add dt support for max6639
 2. Add pwm support
- Ad DT property min-rpm in fan-common.yaml
Changes in V6:
- Remove unused header file
- minor cleanup 
Changes in V5:
- Add pwms support
Changes V4:
- Fix dt error
- update comment
Changes V3:
- correct fan dt property name
- remove unrelevent changes
Changes V2:
- Fix dt schema error.
Changes:
- Add fan-common dt schema.
- add dt-binding support for max6639
- add max6639 specific property

Marcello Sylvester Bauer (2):
  dt-bindings: hwmon: Add max6639
  hwmon: (max6639) Change from pdata to dt configuration

Naresh Solanki (2):
  dt-bindings: hwmon: fan: Add Common Fan Properties
  hwmon: (max6639) Add pwm support

 .../devicetree/bindings/hwmon/fan-common.yaml |  48 +++
 .../bindings/hwmon/maxim,max6639.yaml         |  92 +++++
 drivers/hwmon/Kconfig                         |   1 +
 drivers/hwmon/max6639.c                       | 363 +++++++++++++++---
 include/linux/platform_data/max6639.h         |  15 -
 5 files changed, 459 insertions(+), 60 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/fan-common.yaml
 create mode 100644 Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
 delete mode 100644 include/linux/platform_data/max6639.h


base-commit: 10b7c400596e0010ce12b373ac7b18b7eb334e92
-- 
2.37.3

