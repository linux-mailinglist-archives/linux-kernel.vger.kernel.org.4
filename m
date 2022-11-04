Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A5C61A1F1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 21:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiKDUMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 16:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiKDUMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 16:12:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6E72C66E;
        Fri,  4 Nov 2022 13:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=kaPTClNPEmFEytPts+Xev/fPtAp5vUFNC52w26Gma5E=; b=sHtTCJfSRMFnnX6gmSmuGISc5Q
        NlCQkuSFQAYT5n6OuRbayMx3ZdId54XLkYxluzgKseZyhzWyMDo9vrt/859Rq93RgXBBAqe7K4tF7
        hbnLp5KXI7iXa7pwjmX4F4apIVjiq45mztC5BQV4hBay5qd1P/CuHb5cfwdO4Sgsx6cqAsDph2T/2
        3zQsae+IsivTibRTrkiVS+sEVrTaMcYhtRoWR5hv3ebMiZx26aHp1DThLoNa8mLHzPa1Ez67XB613
        pbrCcoEJl7Lv0LVSDzA0JW1S6cNc4VJGTnp/+5nwOXDWWyGJR2kR7wkVMUQEfoBJD86gtla1fDNHj
        4bdaI4Qg==;
Received: from [2601:1c2:d80:3110::a2e7] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1or33Y-007dUQ-F9; Fri, 04 Nov 2022 20:12:48 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Artur Rojek <contact@artur-rojek.eu>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>
Subject: [PATCH] Input: joystick - fix Kconfig warning for JOYSTICK_ADC
Date:   Fri,  4 Nov 2022 13:12:38 -0700
Message-Id: <20221104201238.31628-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.38.0
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

Fix a Kconfig warning for JOYSTICK_ADC by also selecting
IIO_BUFFER.

WARNING: unmet direct dependencies detected for IIO_BUFFER_CB
  Depends on [n]: IIO [=y] && IIO_BUFFER [=n]
  Selected by [y]:
  - JOYSTICK_ADC [=y] && INPUT [=y] && INPUT_JOYSTICK [=y] && IIO [=y]

Fixes: 2c2b364fddd5 ("Input: joystick - add ADC attached joystick driver.")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Artur Rojek <contact@artur-rojek.eu>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Cc: Paul Gazzillo <paul@pgazz.com>
Cc: Necip Fazil Yildiran <fazilyildiran@gmail.com>
---
 drivers/input/joystick/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff -- a/drivers/input/joystick/Kconfig b/drivers/input/joystick/Kconfig
--- a/drivers/input/joystick/Kconfig
+++ b/drivers/input/joystick/Kconfig
@@ -46,6 +46,7 @@ config JOYSTICK_A3D
 config JOYSTICK_ADC
 	tristate "Simple joystick connected over ADC"
 	depends on IIO
+	select IIO_BUFFER
 	select IIO_BUFFER_CB
 	help
 	  Say Y here if you have a simple joystick connected over ADC.
