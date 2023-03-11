Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12966B57FA
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 04:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjCKDPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 22:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjCKDO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 22:14:59 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F75133A6D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 19:14:58 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1678504495;
        bh=P3sGu23vXEJSpxv1yNaxJPobO0txNvJMebLgCj29y3g=;
        h=From:Subject:Date:To:Cc:From;
        b=B0BkYlZ1K8VoWyc4iJQGaD6WVMoCqLRyEaJKAL+i1e+btabtP9Ceg3EzPqEaBV6hJ
         5f8LTILg+UYDS1uneGkDQoU9+fJVQLXNdRhoSeiI7VCCPgulQ+RSHPi7mFx/c5LdD7
         HNH6o4zfno4JtELT/xWj12sgJXxnanXKvFGTRVfU=
Subject: [PATCH 0/4] kobject: properly warn on missing release function
Date:   Sat, 11 Mar 2023 03:14:45 +0000
Message-Id: <20230311-kobject-warning-v1-0-1ebba4f71fb5@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACXyC2QC/x2NywqDQAwAf0VybsBdUUt/pfSQXaOmlViyfQjiv
 zf0OAPD7FDYhAtcqh2MP1JkVYdwqiDPpBOjDM4Q69jUTQj4WNOd8wu/ZCo64XDuKY59arnrwKt
 EhTEZaZ690/eyuHwaj7L9N9fbcfwAZ8L2e3YAAAA=
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678504493; l=1240;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=P3sGu23vXEJSpxv1yNaxJPobO0txNvJMebLgCj29y3g=;
 b=dlONdNxc27k82JsoXnUNrRFpHp7tDF7bQ7EIyBrRA0JqxR3s8sJO4y/XmLxahOG/cuFWe/3Wz
 LnU0wSmGxbDBtFcy7U3r2AApctfJchb65UIl5NuC2I3vv9nZWR4etn4
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains:
* Patch 1 & 2: some cleanups for the logging in kobject.c
* Patch 3: Moves the validation of the release function from cleanup()
  to add() so the messages are not shown during shutdown where they are
  hard to see.
* Patch 4: Increases the logging level for the release function
  validation.

Please note that Patch 4 will trigger warnings on boot on at least all
machines with ACPI or block devices.
So this patch should probably not be applied yet.

The block dev part is being worked on here:
https://lore.kernel.org/lkml/20230309-kobj_release-gendisk_integrity-v2-0-761a50d71900@weissschuh.net/

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (4):
      kobject: define common logging prefix
      kobject: align stacktrace levels to logging message
      kobject: validate ktype release function during add
      kobject: upgrade log of missing release func to warn

 lib/kobject.c | 42 +++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)
---
base-commit: 55a21105ecc156495446d8ae75d7d73f66baed7b
change-id: 20230311-kobject-warning-d87a2f7b5e66

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

