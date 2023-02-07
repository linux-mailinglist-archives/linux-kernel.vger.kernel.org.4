Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A851668DE1A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 17:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjBGQlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 11:41:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbjBGQlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 11:41:09 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E628D241C4;
        Tue,  7 Feb 2023 08:41:05 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1675788063;
        bh=qr3AcQssClMMVdNH5khir/oD6p0qCE1J/uJe5ZVdNpQ=;
        h=From:Subject:Date:To:Cc:From;
        b=pDgCaDVO0TzDRX4F3xlLkT9VVNXLD12i6lr8jSUWvi8KnPGt8veU5F4ejtYbAbO1i
         DCCayOEKNQqHB7GEhudqL8xubNzRycbAFRAOJXGjaU3jHGFEWacJTb9jrFULuj32x+
         xlzy2Y5a9P8r7unVGe3QcB5A+wbBlsFtZXqzFTzs=
Subject: [PATCH 0/3] platform/x86: Make kobj_type structures constant
Date:   Tue, 07 Feb 2023 16:40:43 +0000
Message-Id: <20230207-kobj_type-pdx86-v1-0-8e2c4fb83105@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAt/4mMC/x2NWwrCMBAAr1L224WYQBSvIiJ5rGY1pCFpJVJ6d
 xc/Z2CYDTo1pg6XaYNGH+48F4HjYYKQXHkSchQGrbRRWp3wPfvXfflWwhrH2aIOVpGxwZroQSr
 vOqFvroQkXVlzFlkbPXj8N9fbvv8A+N94z3YAAAA=
To:     Divya Bharathi <divya.bharathi@dell.com>,
        Prasanth Ksr <prasanth.ksr@dell.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Mark Pearson <markpearson@lenovo.com>,
        Justin Ernst <justin.ernst@hpe.com>
Cc:     Dell.Client.Kernel@dell.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1675788060; l=928;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=qr3AcQssClMMVdNH5khir/oD6p0qCE1J/uJe5ZVdNpQ=;
 b=YEuK9xZSllKFAfSiWbVi8sWgjp0Sak22mUEyLm98OBcIWJ2dvEpDYVjgCPC2QtReHbL/tH6Au
 xCcbQ0oVMKZD5WP8dFkZ1I9GWxhxrhzGCAcvOKChALXtkd29EnFm292
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

Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
the driver core allows the usage of const struct kobj_type.

Take advantage of this to constify the structure definitions to prevent
modification at runtime.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (3):
      platform/x86: dell-wmi-sysman: Make kobj_type structure constant
      platform/x86: think-lmi: Make kobj_type structure constant
      x86/platform/uv: Make kobj_type structure constant

 drivers/platform/x86/dell/dell-wmi-sysman/sysman.c | 2 +-
 drivers/platform/x86/think-lmi.c                   | 4 ++--
 drivers/platform/x86/uv_sysfs.c                    | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)
---
base-commit: d2d11f342b179f1894a901f143ec7c008caba43e
change-id: 20230207-kobj_type-pdx86-2c60e36c63db

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

