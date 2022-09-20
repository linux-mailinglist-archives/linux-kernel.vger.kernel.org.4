Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3965BE336
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 12:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiITKbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 06:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiITKbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 06:31:13 -0400
Received: from mail-m11875.qiye.163.com (mail-m11875.qiye.163.com [115.236.118.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6472C62ABD
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 03:31:12 -0700 (PDT)
Received: from localhost.localdomain (unknown [58.22.7.114])
        by mail-m11875.qiye.163.com (Hmail) with ESMTPA id 30EDD280B4F;
        Tue, 20 Sep 2022 18:31:10 +0800 (CST)
From:   Jianqun Xu <jay.xu@rock-chips.com>
To:     linus.walleij@linaro.org, heiko@sntech.de, brgl@bgdev.pl,
        andriy.shevchenko@linux.intel.com
Cc:     robert.moore@intel.com, robh@kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        lenb@kernel.org, rafael@kernel.org,
        Jianqun Xu <jay.xu@rock-chips.com>
Subject: [PATCH 00/20] Rockchip pinctrl/GPIO support ACPI
Date:   Tue, 20 Sep 2022 18:30:48 +0800
Message-Id: <20220920103108.23074-1-jay.xu@rock-chips.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFJSktLSjdXWS1ZQUlXWQ8JGhUIEh9ZQVkaSxgfVksfTx8fSR1JTh9JSlUTARMWGhIXJB
        QOD1lXWRgSC1lBWU5DVUlJVUxVSkpPWVdZFhoPEhUdFFlBWU9LSFVKSktISkxVSktLVUtZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ngw6Vjo5MT0qEBwwPQlWLyoT
        FBdPC0pVSlVKTU1ITU1CQ0xLQ0tMVTMWGhIXVREaAlUDDjsJFBgQVhgTEgsIVRgUFkVZV1kSC1lB
        WU5DVUlJVUxVSkpPWVdZCAFZQUhLS0g3Bg++
X-HM-Tid: 0a835a739f802eb1kusn30edd280b4f
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patchset will fix the pinctrl and GPIO driver to support ACPI
enabled. There are several patches sent seperated for pinctrl and gpio
branch, now let send them together make it easy to review.

Andy Shevchenko (1):
  ACPI: utils: Add acpi_dev_uid_to_integer() helper to get _UID as
    integer

Jianqun Xu (19):
  pinctrl/rockchip: populate GPIO platform early
  pinctrl/rockchip: use fwnode instead of of_node
  pinctrl/rockchip: switch to use device_get_match_data
  pinctrl/rockchip: of_populate_platform for gpio only for of node
  pinctrl/rockchip: parse dt only if the fwnode is of node
  pinctrl/rockchip: print a message if driver probed successfully
  gpiolib: make gpiochip_find_by_name to be common function
  gpio/rockchip: drop 'bank->name' from the driver
  gpio/rockchip: revert deferred output settings on probe
  gpio/rockchip: add of_node for gpiochip
  gpio/rockchip: add return check for clock rate set
  gpio/rockchip: disable and put clocks when remove
  gpio/rockchip: switch to use irq_domain_create_linear
  gpio/rockchip: disable and put clocks when gpiolib register failed
  gpio/rockchip: try to get gpio id from uid when ACPI enabled
  gpio/rockchip: print device with fwnode name when probe successful
  gpio/rockchip: make use of device property
  gpio/rockchip: make GPIO module work well under ACPI enabled
  pinctrl/rockchip: find existed gpiochip by gpio label

 drivers/acpi/utils.c               |  24 +++
 drivers/gpio/gpio-rockchip.c       | 325 ++++++++++++++++-------------
 drivers/gpio/gpiolib.c             |  16 +-
 drivers/pinctrl/pinctrl-rockchip.c | 108 +++++-----
 drivers/pinctrl/pinctrl-rockchip.h |   9 +-
 include/acpi/acpi_bus.h            |   1 +
 include/linux/acpi.h               |   5 +
 include/linux/gpio/driver.h        |  12 ++
 8 files changed, 289 insertions(+), 211 deletions(-)

-- 
v1:
 - continue with the suggestion from Andy and Johan

2.25.1

