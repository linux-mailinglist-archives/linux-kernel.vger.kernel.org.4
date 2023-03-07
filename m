Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085C16ADF21
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 13:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjCGMvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 07:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjCGMvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 07:51:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138AA7BA05;
        Tue,  7 Mar 2023 04:51:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9378D61354;
        Tue,  7 Mar 2023 12:51:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37392C433EF;
        Tue,  7 Mar 2023 12:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678193500;
        bh=Zo0wnvFTycDHaoRZvtwRIJG6IH0TJ/chf9KnXuXEC0k=;
        h=From:Subject:Date:To:Cc:From;
        b=W7069/89i6YN6jzXXHBwaUdYnbt1Vx1XIy6UQNuF+VQ/pG/2j8a6sBzc3pFcKLzjI
         AKEZigiLapjZPIOvCfCPdfluoGuXnDqYFYWPIbRLX38JrwrzvGOBUSaMvNJ8snIEOZ
         JjYvO/61bWPvPdOPcsnxXI2OCqpPRII3jGcSml1ou5YnZEQeTOoqHcn1eR/OwBQ1Ye
         /ENSTQfJCM2ODPP99JqVbtmBtGSPXYh9o5m2uiauNE8cGA2abYWcu/MhN3BHBDsopY
         FlpW/pJ+motoff2Q4LBl02lQX9Mrashf6ckGmC0XBHMUKZEI54bbvjANHAvhSxqYtH
         XptTO9m0RJulg==
From:   Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 0/2] pinctrl: at91: Minor cleanups
Date:   Tue, 07 Mar 2023 12:51:26 +0000
Message-Id: <20230216-gpio-at91-immutable-v2-0-326ef362dbc7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE4zB2QC/32NQQ6CMBBFr2K6dgwt1FBX3sOwaHEKE4GSaSUaw
 t0tHMDl+z8vbxURmTCK22kVjAtFClMGdT6JtrdTh0DPzEIVqiyUvEI3UwCbjAQax3eybkDQpW+
 dMdqpWotsOhsRHNup7Xd3tDEh78fM6Olz5B5N5p5iCvw96ovc1/+hRUIBVeW18rKqrTP3F/KEw
 yVwJ5pt237oOSBN0AAAAA==
To:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-bd1bf
X-Developer-Signature: v=1; a=openpgp-sha256; l=905; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Zo0wnvFTycDHaoRZvtwRIJG6IH0TJ/chf9KnXuXEC0k=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkBzNXoQNZFXDo5VZwccpab70++10eQsUHws2D7gMl
 ScqNBQSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZAczVwAKCRAk1otyXVSH0NpCB/
 4+3JW3aY4u0RfZLOSMWvZVHdZ7weUyroE+MmXVOygTCUNb1HnY1Zf158uxjzF0mK6oWLUIUhAuanuB
 702UQGUooghxUaDB85MBDGYTMNx9a0BkgktULL/puWRtIjko8oNdvtQDS0DwTvftbIzd5sLM/PSLjN
 GORwK7HG9CMhhucUq3Ce9W4bmjCrC9tHIfiw9E3Rtw8IDoRP8yBGEYztnh2o6gAOlleNHBo66zN6AO
 wdFXnPaUQtw+pXpDaNKc+HU7YjfRvLEL7HXqs4Jn3Ch1VcoWvZteLjJZxFiq4vDrW+nm6UJ2426lNq
 MTFpXgqHGF7yRKgTnQC81tIUM+5x5o
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few cleanups for the at91 driver, making the GPIO irqchip
immutable and removing an unused member from the driver data.
The driver is still using statically assigned GPIO numbers, we
can't just remove that since the driver itself is still relying
on them even if there are no longer board files for this
platform.

Changes in v2:
- Rebased onto Linus' devel branch.
- Link to v1: https://lore.kernel.org/r/20230216-gpio-at91-immutable-v1-0-44f52f148ab9@kernel.org

---
Mark Brown (2):
      pinctrl: at91: Make the irqchip immutable
      pinctrl: at91: Remove pioc_index from struct at91_gpio_chip

 drivers/pinctrl/pinctrl-at91.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)
---
base-commit: 00408f28c344fd1cafe6e66fe0f454607a2605f9
change-id: 20230216-gpio-at91-immutable-53fcb995b285

Best regards,
-- 
Mark Brown <broonie@kernel.org>

