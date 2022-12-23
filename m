Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5A3654B58
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 03:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235834AbiLWCyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 21:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiLWCx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 21:53:56 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD2F21813;
        Thu, 22 Dec 2022 18:53:50 -0800 (PST)
From:   Thomas =?utf-8?q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1671764028;
        bh=ipHZgib+Lby6GodEXoPKlNcMMUGuBYXzjHfoe9lgkqQ=;
        h=From:Subject:Date:To:Cc:From;
        b=V57zR7NVxVnHAK6Oz4c1V6nN+1UiHYX48OjoLrRy2jhbJPXGnMP7IN2EVBkfyb3B8
         Kl0SPxsPbXhrR/SfTB9z+RyYkD6aiPXwubReL6t57UA7Wk5o/IqyRlek5EfcbkQLXD
         mkmhjB5FVqPFYRMTRAecjXoXIqzEIBIeYXt9a2Ms=
Subject: [PATCH 0/2] HID: i2c-hid: use standard debugging APIs
Date:   Fri, 23 Dec 2022 02:53:34 +0000
Message-Id: <20221223-hid-dbg-v1-0-f641e80263eb@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAC8YpWMC/x2M0QqDMAwAf0XyvMAaUcZ+RfbQJtEGpJOWDUH8d
 4OPdxx3QNNq2uDdHVD1b82+xSE8OuAcy6Jo4gz0JApEPWYTlLQgCwcZRnmxKnidYlNMNRbO3pff
 urrcqs623/vpc54XWJQVwG4AAAA=
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas =?utf-8?q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.11.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1671764024; l=1180;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=ipHZgib+Lby6GodEXoPKlNcMMUGuBYXzjHfoe9lgkqQ=;
 b=TG7tPdchLgspc33yI9e12sHfbf7zDVwCH5El/E3t/LqYCDQX4yBCp8VCBOuRbyy1BXDfyGi2mqfs
 PtVWoscXDFG64zJ/PusGL9nUVh8GXAfI47MCB98L6CAcRwpr0pOj
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When trying to debug i2c-hid I was not able to use the builtin debug
mechanism because the "debug" module parameter is not writable.

We can change i2c-hid to use the standard kernel debugging APIs which are
more discoverable and have more features.

There is a bit of a stilistic conflict between consistently using
i2c_hid_dbg() and consistently using dev_<level>().

The second patch aligns debugging on i2c_hid_dbg().
If this is unneeded, feel free to drop it.

It would also be easy to just use dev_dbg() everywhere for consistency.

To: Jiri Kosina <jikos@kernel.org>
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

---
Thomas Weißschuh (2):
      HID: i2c-hid: switch to standard debugging APIs
      HID: i2c-hid: use uniform debugging APIs

 drivers/hid/i2c-hid/i2c-hid-core.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)
---
base-commit: 8395ae05cb5a2e31d36106e8c85efa11cda849be
change-id: 20221223-hid-dbg-cdc1d56d8cee

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>
