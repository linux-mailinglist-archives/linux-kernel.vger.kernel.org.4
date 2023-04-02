Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9952D6D39A1
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 19:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjDBR7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 13:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjDBR7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 13:59:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44DE4EFD
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 10:59:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A3CA612D1
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 17:59:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB2EC433D2;
        Sun,  2 Apr 2023 17:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680458344;
        bh=hypU8I+jGgfmux7jn63x7uy8u7xkg961ImzN1SN31nk=;
        h=From:To:Cc:Subject:Date:From;
        b=taE1iN91ihIB4QdUqvXHcKjh1UsDchKGI7ms0t/lQXLD6TkFitithwtw98gsTVEyi
         fEjBizI3MC4sLJzRqjazplZKgJvH2BkGQ+ThVmycKUJpgh0xK0DBl/XQe80ZPHB471
         fcaxJiydybCtrzZNX8/0ozmEqh6IA67kOIKg+by0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 0/5] driver core: class: allow struct class to be static
Date:   Sun,  2 Apr 2023 19:58:45 +0200
Message-Id: <2023040244-duffel-pushpin-f738@gregkh>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Lines:  49
X-Developer-Signature: v=1; a=openpgp-sha256; l=2507; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=hypU8I+jGgfmux7jn63x7uy8u7xkg961ImzN1SN31nk=; b=owGbwMvMwCRo6H6F97bub03G02pJDCmah0LvuhTL7fzeajfz38f1C7K8L2W0HW2zP7xJP0vt2 vIDy3hOdcSyMAgyMciKKbJ82cZzdH/FIUUvQ9vTMHNYmUCGMHBxCsBE2ngYFjRuPLCNpTpVx9Fm 1usv9aELJqmeFGCYX83o/pRRmIn/zM6CCteFi9qvCm4wBgA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's been a semi-slow drip of driver core struct class changes
recently, and here's the final bit to the core that makes it possible
for 'struct class' to be moved into read-only memory.  And as proof, the
last patch in the series does just that for the tty classes.

After this series, there's some tree-wide cleanups needed to move away
from the class_create() api back to class_register() to move the
structures into read-only memory.  The class_create() api was a good
idea when it was created (as struct class was a dynamic structure), but
that got changed a long time ago and that's not necessary anymore.  But
that can wait for after 6.4-rc1 is out as they can all go through the
different relevant subsystems if wanted.

All of these apply on top of my latest driver-core.git driver-core-next
branch (or linux-next), as they require the current set of struct class
and struct bus_type reworks and have been tested locally (I'm typing
this and will send them out on a kernel running these changes).

Greg Kroah-Hartman (5):
  driver core: class: mark class_release() as taking a const *
  driver core: class: make class_register() take a const *
  driver core: class: mark the struct class in struct class_interface
    constant
  driver core: class: remove struct class_interface * from callbacks
  tty: make tty_class a static const structure

 drivers/base/base.h                      |  2 +-
 drivers/base/class.c                     | 14 +++++++-------
 drivers/base/core.c                      | 10 ++++------
 drivers/hwmon/drivetemp.c                |  4 ++--
 drivers/net/rionet.c                     |  3 +--
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c   |  6 ++----
 drivers/pcmcia/cs.c                      |  2 +-
 drivers/pcmcia/ds.c                      |  6 ++----
 drivers/pcmcia/rsrc_nonstatic.c          |  6 ++----
 drivers/rapidio/devices/rio_mport_cdev.c |  7 ++-----
 drivers/rapidio/rio_cm.c                 |  8 ++------
 drivers/scsi/ses.c                       |  6 ++----
 drivers/scsi/sg.c                        |  8 ++++----
 drivers/tty/pty.c                        |  2 +-
 drivers/tty/tty_io.c                     | 24 +++++++++++-------------
 drivers/tty/vt/vt.c                      |  2 +-
 include/linux/device/class.h             | 10 +++++-----
 include/linux/tty.h                      |  2 +-
 kernel/time/alarmtimer.c                 |  3 +--
 19 files changed, 52 insertions(+), 73 deletions(-)

-- 
2.40.0

