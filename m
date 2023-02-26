Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC536A2E71
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 06:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjBZFk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 00:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjBZFkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 00:40:00 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21925136F7;
        Sat, 25 Feb 2023 21:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=EI1aXrE2jWnMQpvhJWCxJ0A1m6hExM8zG6kHodDd/Yk=; b=aj3A5Ot6MEhhd9SZR6hiyed6PQ
        EdZuqG07G/Vk/F8skIZAfGRc6sNw4DC3faae0Cu3vMc4szUf4tDAjvfhrUYJgE2qrG+wA3gREi+N9
        PxwHUdCcxP7gl8263NKtViUAcgY2zI6M/LMZBz9lNggC95W1ux6ZsuulZKWLDOGTRoKB45Cn6oWKQ
        wmRpRz9HJa6rXmn93Yj2Kp+oVd2a57W+8ogtuK5beZyvX1IVvMsN0ws+h4BF3CcUdqyDY6oBTAOxv
        yxF6SU+Dxy/zjph+VaxFK8u1DqBXUvUKhjqVRXd4V3udKqotaho/14nhEhUecI4IwtIGLrTY08V5M
        lQmQqocw==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pW9lK-006qYL-N4; Sun, 26 Feb 2023 05:39:54 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Corey Minyard <minyard@acm.org>,
        openipmi-developer@lists.sourceforge.net,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Riku Voipio <riku.voipio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, Dan Murphy <dmurphy@ti.com>,
        Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Lee Jones <lee@kernel.org>, linux-leds@vger.kernel.org,
        Darren Hart <dvhart@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Michael Shych <michaelsh@nvidia.com>,
        Mark Gross <markgross@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>,
        platform-driver-x86@vger.kernel.org,
        Yegnesh S Iyer <yegnesh.s.iyer@intel.com>,
        Bin Gao <bin.gao@intel.com>, Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        Oskar Senft <osk@google.com>, linux-serial@vger.kernel.org
Subject: [PATCH 0/8] drivers: select REGMAP instead of depending on it
Date:   Sat, 25 Feb 2023 21:39:45 -0800
Message-Id: <20230226053953.4681-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

REGMAP is a hidden (not user visible) symbol. Users cannot set it
directly thru "make *config", so drivers should select it instead of
depending on it if they need it.

Consistently using "select" or "depends on" can also help reduce
Kconfig circular dependency issues.

REGMAP is selected 94 times and is depended on 11 times in
current linux-next. Eliminate the uses of "depends on" by
converting them to "select".

 [PATCH 1/8] ipmi: ASPEED_BT_IPMI_BMC: select REGMAP_MMIO instead of depending on it
 [PATCH 2/8] clk: HI655X: select REGMAP instead of depending on it
 [PATCH 3/8] gpio: GPIO_REGMAP: select REGMAP instead of depending on it
 [PATCH 4/8] leds: TI_LMU_COMMON: select REGMAP instead of depending on it
 [PATCH 5/8] platform: mellanox: select REGMAP instead of depending on it
 [PATCH 6/8] platform: x86: MLX_PLATFORM: select REGMAP instead of depending on it
 [PATCH 7/8] thermal: intel: BXT_PMIC: select REGMAP instead of depending on it
 [PATCH 8/8] serial: 8250: ASPEED_VUART: select REGMAP instead of depending on it

diffstat:
 drivers/char/ipmi/Kconfig         |    3 ++-
 drivers/clk/Kconfig               |    2 +-
 drivers/gpio/Kconfig              |    2 +-
 drivers/leds/Kconfig              |    2 +-
 drivers/platform/mellanox/Kconfig |    9 ++++-----
 drivers/platform/x86/Kconfig      |    3 ++-
 drivers/thermal/intel/Kconfig     |    3 ++-
 drivers/tty/serial/8250/Kconfig   |    3 ++-
 8 files changed, 15 insertions(+), 12 deletions(-)

Cc: Andrew Jeffery <andrew@aj.id.au>
Cc: Corey Minyard <minyard@acm.org>
Cc: openipmi-developer@lists.sourceforge.net
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Riku Voipio <riku.voipio@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: linux-clk@vger.kernel.org
Cc: Michael Walle <michael@walle.cc>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org
Cc: Dan Murphy <dmurphy@ti.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Lee Jones <lee@kernel.org>
Cc: linux-leds@vger.kernel.org
Cc: Darren Hart <dvhart@infradead.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Michael Shych <michaelsh@nvidia.com>
Cc: Mark Gross <markgross@kernel.org>
Cc: Vadim Pasternak <vadimp@nvidia.com>
Cc: platform-driver-x86@vger.kernel.org
Cc: Yegnesh S Iyer <yegnesh.s.iyer@intel.com>
Cc: Bin Gao <bin.gao@intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Amit Kucheria <amitk@kernel.org>
Cc: linux-pm@vger.kernel.org
Cc: Oskar Senft <osk@google.com>
Cc: linux-serial@vger.kernel.org
