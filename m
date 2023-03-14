Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0206BA2CE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 23:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjCNWzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 18:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjCNWzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 18:55:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966913771A;
        Tue, 14 Mar 2023 15:55:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FB8761A4D;
        Tue, 14 Mar 2023 22:55:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68ACC433EF;
        Tue, 14 Mar 2023 22:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678834539;
        bh=G7IHTWYU3Hc+755n6/8M/Bh2uOhHrF8UATMy0A1uKCQ=;
        h=From:To:Cc:Subject:Date:From;
        b=EhRQFg+fyLNkwy3Bpcsi+mGCiJMx6YnCpAaeNGWAv8+IBINHHNxagygIh98ouTObA
         CPEaaxuHXUk3TOqK6pSJDLniAP6LjoHqRIvxLugnLj6rttqYuM+9oOx1m3PlzgBcTu
         kn5ML7wkd9/aL75VH2qB/SAgno0vkJGDNsdPYyY4x76As5pAZkPfLoLIPiXUOrE83+
         dB+jPbgnhUdS7pL7UhgX/KP2PRnPV2iAAn/c72t/CZbMO4e4MBECHSN1MmPL6Kdxs4
         aVffBTwnQhQ83ShjScGyptSverJCz8PXgKNVeEFS+2lWS9XyM/3vQkf2f/+cv3vl0E
         6QyRZ4e47iZ1A==
Received: by mercury (Postfix, from userid 1000)
        id D176D10620A0; Tue, 14 Mar 2023 23:55:36 +0100 (CET)
From:   Sebastian Reichel <sre@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCHv2 00/12] Add DT support for generic ADC battery
Date:   Tue, 14 Mar 2023 23:55:23 +0100
Message-Id: <20230314225535.1321736-1-sre@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

Sebastian Reichel (12):
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

 .../bindings/power/supply/adc-battery.yaml    |  70 ++++++
 drivers/power/supply/generic-adc-battery.c    | 227 +++++-------------
 drivers/power/supply/power_supply_core.c      | 173 +++++++++++--
 drivers/power/supply/power_supply_sysfs.c     |  15 ++
 include/linux/power/generic-adc-battery.h     |  23 --
 include/linux/power_supply.h                  |   8 +
 6 files changed, 306 insertions(+), 210 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/adc-battery.yaml
 delete mode 100644 include/linux/power/generic-adc-battery.h

-- 
2.39.2

