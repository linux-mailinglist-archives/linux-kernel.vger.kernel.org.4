Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EABA970B1EF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 01:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjEUW77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 18:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjEUW7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 18:59:50 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C74BF;
        Sun, 21 May 2023 15:59:46 -0700 (PDT)
Received: (Authenticated sender: contact@artur-rojek.eu)
        by mail.gandi.net (Postfix) with ESMTPSA id 86FB91C0002;
        Sun, 21 May 2023 22:59:43 +0000 (UTC)
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-mips@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH v2 0/2] iio/adc-joystick: buffer data parsing fixes
Date:   Mon, 22 May 2023 00:58:59 +0200
Message-Id: <20230521225901.388455-1-contact@artur-rojek.eu>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this is a long overdue v2 for fixes [1] related to adc-joystick channel
parsing.

Patch [1/2] now also addresses a case where a readout of ADC data
containing samples for two channels, where only one channel is active,
would push the data into a buffer without discarding the disabled
channel first.

Patch [2/2] addresses concerns about exposure to channels the clients
shouldn't know about. The IIO helpers from v1 are gone and the offsets
are now calculated based only on the channels adc-joystick has access
to.

Tested on GCW Zero (by me) and on Anbernic RG350 (by Paul).

[1] https://lore.kernel.org/all/20220817105643.95710-1-contact@artur-rojek.eu/ 

Cheers,
Artur

Artur Rojek (2):
  iio/adc: ingenic: Fix channel offsets in buffer
  input: joystick: Fix buffer data parsing

 drivers/iio/adc/ingenic-adc.c         |  20 +++--
 drivers/input/joystick/adc-joystick.c | 102 +++++++++++++++++++++++---
 2 files changed, 103 insertions(+), 19 deletions(-)

-- 
2.40.1

