Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F04D7359A0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 16:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjFSOdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 10:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjFSOd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 10:33:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1B4A0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 07:33:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80BEF60C7B
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 14:33:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 490B5C433C0;
        Mon, 19 Jun 2023 14:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687185206;
        bh=hIIq8chjQCgD1ZEHiHRy09V04+UgLA9zqjF2LMOBua8=;
        h=Date:From:To:Cc:Subject:From;
        b=I9uXHaBHkFG4Qlud+eTHbv/wOvt+4vSu9aSxXU17PN5zvy05UAmiBgBn0XD570SbU
         /E8Ky8rbULiglKsN3BsHxtyNu0DlOyXp/jXMXXNDTPKy0syDYjRGsFaXBQxrw1ht4E
         a8E983D0iurPmpniJu31QDKmu6Fh6IyUEsCimsOtdO0Nspw6bOr7RyH+uXscUTO5WH
         U5r1nxdQmNvP5kcYC4an17EGRFMNbFXwKCSB/O5HhiqlaRTrgY06HIWpaGdf1WJBjQ
         Vkwz9C60EVx+KCKHkOOhKpR+HZ+c6ndm/laR4NmL0IyzMqLn4HPP5vd237cf+aQO+1
         4LTtL9fFWpwSg==
Message-ID: <2164491b-973d-3e54-fd28-f00d6efa3cce@kernel.org>
Date:   Mon, 19 Jun 2023 23:33:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Chanwoo Choi <chanwoo@kernel.org>
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>, chanwoo@kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>, y0.cho@samsung.com,
        yuni.seo@samsung.com
Subject: [GIT PULL] extcon next for 6.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg,

This is extcon-next pull request for v6.5. I add detailed description of
this pull request on below. Please pull extcon with following updates.

Best Regards,
Chanwoo Choi


The following changes since commit 7877cb91f1081754a1487c144d85dc0d2e2e7fc4:

  Linux 6.4-rc4 (2023-05-28 07:49:00 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-6.5

for you to fetch changes up to 94da3da96c35744001adfdb65e501e633a64cb51:

  dt-bindings: extcon: wlf,arizona: drop unneeded quotes (2023-06-10 22:06:45 +0900)

----------------------------------------------------------------
Update extcon next for v6.5

Detailed description for this pull request:
1. Clean-up extcon core without any behavior changes
- Add extcon_alloc_cables/muex/groups to improve the readability
  of extcon_dev_register.

- Fix kernel doc of property and property capability fields to aovid warnings
  and add missing description of struct extcon_dev.

- Use DECLARE_BITMAP macro and sysfs_emit instead of sprintf

- Use device_match_of_node helper instead of accessing the .of_node

- Use ida_alloc/free to get the unique id for extcon device


2. Update extcon-usbc-tusb320.c to support usb_role_switch and accessory detection
- Add usb_role_switch support on extcon-usbsc-tusb320.

- Add additional accessory detection for audio/debug accessory
  and then pass the deteced accessory information to typec subsystem
  on extcon-usbsc-tusb320.c.

- Add the support of unregistration of typec port on both error handling
  and driver removal step on


3. Update extcon provider drivers (apx288/qcom-spmi-misc/palmas)
- Replace put_device with acpi_dev_put on extcon-axp288.c

- Use platform_get_irq_byname_optional for getting irq of
  usb_id and usb_vbus on extcon-qcom-spmi-misc.c.

- Remove unused of_gpio.h on extcon-palmas.c.

4. Fix the devicetree binding document
- Rename misc node name to 'usb-dect@900' on pm8941-misc.yam

- Fix usb-id and usb_vbus defintion on pm8941-misc.yaml

- Drop unneeded quotes from extcon-arizona.c devicetree documentation

----------------------------------------------------------------
Alvin Šipraga (3):
      extcon: usbc-tusb320: Unregister typec port on driver removal
      extcon: usbc-tusb320: add accessory detection support
      extcon: usbc-tusb320: add usb_role_switch support

Andy Shevchenko (13):
      extcon: axp288: Replace open coded acpi_dev_put()
      extcon: palmas: Remove unused of_gpio.h
      extcon: Fix kernel doc of property fields to avoid warnings
      extcon: Fix kernel doc of property capability fields to avoid warnings
      extcon: Use DECLARE_BITMAP() to declare bit arrays
      extcon: Use sysfs_emit() to instead of sprintf()
      extcon: Amend kernel documentation of struct extcon_dev
      extcon: Use device_match_of_node() helper
      extcon: Use dev_of_node(dev) instead of dev->of_node
      extcon: Remove dup device name in the message and unneeded error check
      extcon: Use unique number for the extcon device ID
      extcon: Use sizeof(*pointer) instead of sizeof(type)
      extcon: Drop unneeded assignments

Arnd Bergmann (1):
      extcon: usbc-tusb320: add USB_ROLE_SWITCH dependency

Bryan O'Donoghue (2):
      dt-bindings: pm8941-misc: Fix usb_id and usb_vbus definitions
      extcon: qcom-spmi: Switch to platform_get_irq_byname_optional

Bumwoo Lee (4):
      extcon: Remove redundant null checking for class
      extcon: Add extcon_alloc_cables to simplify extcon register function
      extcon: Add extcon_alloc_muex to simplify extcon register function
      extcon: Add extcon_alloc_groups to simplify extcon register function

Krzysztof Kozlowski (1):
      dt-bindings: extcon: wlf,arizona: drop unneeded quotes

Luca Weiss (1):
      dt-bindings: pm8941-misc: rename misc node name

Uwe Kleine-König (1):
      extcon: Switch i2c drivers back to use .probe()

 .../bindings/extcon/qcom,pm8941-misc.yaml          |  14 +-
 .../devicetree/bindings/extcon/wlf,arizona.yaml    |  14 +-
 drivers/extcon/Kconfig                             |   1 +
 drivers/extcon/extcon-axp288.c                     |   2 +-
 drivers/extcon/extcon-fsa9480.c                    |   2 +-
 drivers/extcon/extcon-palmas.c                     |   1 -
 drivers/extcon/extcon-ptn5150.c                    |   2 +-
 drivers/extcon/extcon-qcom-spmi-misc.c             |   4 +-
 drivers/extcon/extcon-rt8973a.c                    |   2 +-
 drivers/extcon/extcon-sm5502.c                     |   2 +-
 drivers/extcon/extcon-usbc-tusb320.c               | 155 +++++++--
 drivers/extcon/extcon.c                            | 368 ++++++++++++---------
 drivers/extcon/extcon.h                            |   8 +-
 13 files changed, 366 insertions(+), 209 deletions(-)
