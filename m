Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4376E6BF56C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 23:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjCQW5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 18:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCQW5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 18:57:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AEA2CFCB;
        Fri, 17 Mar 2023 15:57:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9946460B61;
        Fri, 17 Mar 2023 22:57:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7DCFC4339C;
        Fri, 17 Mar 2023 22:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679093831;
        bh=u6caXNtWGnQDeyAlomNSHtdC57pwicFqB+r2UCDaZFk=;
        h=From:To:Cc:Subject:Date:From;
        b=ZbAGqZd7dNpKozt6g6c62b56qo7KhTnMZduxmpoay8Ej8+xcwoM+GUw82PvEwLdk/
         kmzkLjm4lkt/KJt3TS/EtUIbFKZvbd/ltdI3zXBUwK6HvCO5LJBjQF6W/qfRJSTBy2
         I/MiJOS59L94V9jdTF9OWOW6B2dlgPnJL0OKflRxFsDV1mQOADIqGKacn2eeFcHZdz
         NeXvNF/HH960mk2sVwGYGCygFTRqYCZM/jSxL67bAT81Vopo7sw6H1KkqAPMs65esh
         y1fhzcwOhxkklyTOnh7AeBgMdUIfafHg/Yhp5WDfy7LMUnCqclLnCTNXgRS6JN2rcp
         bnZGT4H99zkKg==
Received: by mercury (Postfix, from userid 1000)
        id 8300910620FB; Fri, 17 Mar 2023 23:57:08 +0100 (CET)
From:   Sebastian Reichel <sre@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCHv3 00/14] Add DT support for generic ADC battery
Date:   Fri, 17 Mar 2023 23:56:53 +0100
Message-Id: <20230317225707.1552512-1-sre@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series cleans up the generic ADC battery driver and adds
devicetree support. The plan is to use the driver to add upstream
support for a handheld thermal camera.

Instead of reading and exposing the monitored battery data manually
I started the series with an addition to the power-supply core,
which allows automatic handling of the static battery information.
It simplifies the generic-adc-battery driver a lot and should also
be useful for other battery drivers.

Changes since PATCHv2:
 * collect more Reviewed-by (again skipped PATCH 1)
 * updated battery-info auto-exposure to only do it for TYPE_BATTERY
   power-supply devices.
 * Fix battery-info auto-exposure to avoid duplicated uevent variables
 * Added two more cleanup patches at the end of the series

Changes since PATCHv1:
 * collect Reviewed-by
   (I did not collect them for the auto-exposure because of the
   code changes)
 * always auto expose battery data (without opt-in)
 * update DT binding according to feedback
 * add temperature support
 * fix issues pointed out by the Intel build bot
  - move power_supply_battery_info_properties to power_supply_core.c
  - restore accidently removed EXPORT_SYMBOL for power_supply_get_property

-- Sebastian

Sebastian Reichel (14):
  dt-bindings: power: supply: adc-battery: add binding
  power: supply: core: auto-exposure of simple-battery data
  power: supply: generic-adc-battery: convert to managed resources
  power: supply: generic-adc-battery: fix unit scaling
  power: supply: generic-adc-battery: drop jitter delay support
  power: supply: generic-adc-battery: drop charge now support
  power: supply: generic-adc-battery: drop memory alloc error message
  power: supply: generic-adc-battery: use simple-battery API
  power: supply: generic-adc-battery: simplify read_channel logic
  power: supply: generic-adc-battery: add temperature support
  power: supply: generic-adc-battery: add DT support
  power: supply: generic-adc-battery: update copyright info
  power: supply: generic-adc-battery: improve error message
  power: supply: generic-adc-battery: style fixes

 .../bindings/power/supply/adc-battery.yaml    |  70 +++++
 drivers/power/supply/generic-adc-battery.c    | 245 +++++-------------
 drivers/power/supply/power_supply_core.c      | 179 +++++++++++--
 drivers/power/supply/power_supply_sysfs.c     |  23 +-
 include/linux/power/generic-adc-battery.h     |  23 --
 include/linux/power_supply.h                  |   8 +
 6 files changed, 325 insertions(+), 223 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/adc-battery.yaml
 delete mode 100644 include/linux/power/generic-adc-battery.h

-- 
2.39.2

