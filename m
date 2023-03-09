Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2CE6B3152
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 23:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjCIWvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 17:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbjCIWuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 17:50:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F127DF8656;
        Thu,  9 Mar 2023 14:50:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8C749B820C6;
        Thu,  9 Mar 2023 22:50:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05051C4339E;
        Thu,  9 Mar 2023 22:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678402246;
        bh=iCMgj+CPrlEuf1ZGNOclyieKYt4V6/ejryH1dc1Ea6g=;
        h=From:To:Cc:Subject:Date:From;
        b=CIn1tilWaisniSGHJ3/x27i7Zyc215rJ8lNNLSQ4z6+KXGMT/XFVXxG8EAzs53XKj
         puCH3jUhybLnNv38JLR8qwjc7W7tLbEpAMbxDCFfT6k7VG6z+WTmeZ0JVVRHBFHbUL
         2Y/Oi+gBIOLrGetm8Uzh752LBak7sjEhBdAR6jLnh3+jScPJxLlomkB4iEfCZE5Q4r
         g1dq4HNRik6ZMZ0gaw/HYCk4pJpRo8s5BTXD0C1YKmiCEJgyowyX6GZXI2pCDdidmu
         NCZo95LFnijsU66gTJJBcqnmf7IMbSVFUgHTQ329V4Sr+S+2SgnCelmLgh7GzWxg5l
         El+BnBfUOLz7A==
Received: by mercury (Postfix, from userid 1000)
        id 57A03106083C; Thu,  9 Mar 2023 23:50:43 +0100 (CET)
From:   Sebastian Reichel <sre@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCHv1 00/11] Add DT support for generic ADC battery
Date:   Thu,  9 Mar 2023 23:50:30 +0100
Message-Id: <20230309225041.477440-1-sre@kernel.org>
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

-- Sebastian

Sebastian Reichel (11):
  dt-bindings: power: supply: adc-battery: add binding
  power: supply: core: auto-exposure of simple-battery data
  power: supply: generic-adc-battery: convert to managed resources
  power: supply: generic-adc-battery: fix unit scaling
  power: supply: generic-adc-battery: drop jitter delay support
  power: supply: generic-adc-battery: drop charge now support
  power: supply: generic-adc-battery: drop memory alloc error message
  power: supply: generic-adc-battery: use simple-battery API
  power: supply: generic-adc-battery: simplify read_channel logic
  power: supply: generic-adc-battery: add DT support
  power: supply: generic-adc-battery: update copyright info

 .../bindings/power/supply/adc-battery.yaml    |  67 ++++++
 drivers/power/supply/generic-adc-battery.c    | 221 +++++-------------
 drivers/power/supply/power_supply_core.c      | 153 ++++++++++--
 drivers/power/supply/power_supply_sysfs.c     |  16 ++
 include/linux/power/generic-adc-battery.h     |  23 --
 include/linux/power_supply.h                  |  31 +++
 6 files changed, 301 insertions(+), 210 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/adc-battery.yaml
 delete mode 100644 include/linux/power/generic-adc-battery.h

-- 
2.39.2

