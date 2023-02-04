Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E9C68AC13
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 20:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233647AbjBDTVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 14:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbjBDTVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 14:21:12 -0500
Received: from ryne.moe (ryne.moe [157.90.134.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C70A2BF04;
        Sat,  4 Feb 2023 11:21:09 -0800 (PST)
Received: from localhost.localdomain (unknown [170.55.83.2])
        by ryne.moe (Postfix) with ESMTPSA id DEABF1900DD8;
        Sat,  4 Feb 2023 19:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redstrate.com;
        s=default; t=1675538467;
        bh=cAvQmOIg3cfQ9bmkXgcr4M/P7uaRGleq4zD3yqxi1ro=;
        h=From:To:Cc:Subject:Date;
        b=hIAMl7i27OtvBYkG7FhUQfl6HAlJB+IKm/gvIchHN3/F2TqwOoL/unC+o/BLmjLwW
         jrdcBa/b0cV/MQksDrKo+HazWXwbipR1m7tMd8nxgBS9Fo3uC0fQmMIBDUMOvMRX4f
         /jbx/9UJEzAp6l4LkK8r+I/Dcr2k5T59N2ndZu5E=
From:   Joshua Goins <josh@redstrate.com>
To:     linux-input@vger.kernel.org
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, Joshua Goins <josh@redstrate.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v3 0/2] HID: uclogic: Add support for XP-PEN Artist 22R Pro
Date:   Sat,  4 Feb 2023 14:20:49 -0500
Message-Id: <20230204192051.1287369-1-josh@redstrate.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds support for the XP-PEN Artist 22R Pro, including stylus, tablet frame
and pen pressure.

The tablet has 20 buttons, but need to be remapped in order since the
device reports invalid keycodes. Existing tablet functionality should
not be inhibited, as BTN0-8 is still used.

New initialization functions are added since the device differs slightly
from other UGEE v2 devices.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Reported-by: José Expósito <jose.exposito89@gmail.com>
Signed-off-by: Joshua Goins <josh@redstrate.com>
---
v3 changes:
  - Removed duplicate frame initialization code, overriding the num of frame
  buttons instead.
  - Removed unnessecary key > 0 check.
  - Renamed init function to something more specific to the device.
  - Cherry-picked probe magic data patch.
  - Rebased onto 6.2-rc6
v2 changes:
  - rewrote initialization code to be more concise, and less error-prone, thanks
  Dan Carpenter & José Expósito for pointers!
  - less struct duplication, it now uses compatiable UGEE v2 ones.
  - uclogic_extra_input_mapping is now static, thanks José again!
  - straightened out dial transformation, now there's just the two cases and
  they're decimal.
  - fixed the patch formatting, it should be easier to apply now.
  - rebased onto 6.2-rc2

Joshua Goins (1):
  HID: uclogic: Add support for XP-PEN Artist 22R Pro

José Expósito (1):
  HID: uclogic: Refactor UGEEv2 probe magic data

 drivers/hid/hid-ids.h            |   1 +
 drivers/hid/hid-uclogic-core.c   |  66 +++++++++++++-
 drivers/hid/hid-uclogic-params.c | 143 +++++++++++++++++++++++++++++--
 drivers/hid/hid-uclogic-params.h |   5 ++
 drivers/hid/hid-uclogic-rdesc.c  |  50 +++++++++++
 drivers/hid/hid-uclogic-rdesc.h  |   9 ++
 6 files changed, 264 insertions(+), 10 deletions(-)


base-commit: 0136d86b78522bbd5755f8194c97a987f0586ba5
-- 
2.39.1

