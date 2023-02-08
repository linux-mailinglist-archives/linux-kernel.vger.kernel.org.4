Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE7F68ED8D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 12:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjBHLOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 06:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjBHLNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 06:13:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4894B2659D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 03:13:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D881F61156
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 11:13:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E126FC433D2;
        Wed,  8 Feb 2023 11:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675854822;
        bh=T46tXjAqJt8qFrwAGWcwbQFneNO1ZDw3Sb9SGT5jx1k=;
        h=From:To:Cc:Subject:Date:From;
        b=2nneWM/zymBt8y5CJT8DMCX7ttceR/AxxAkqOW6/2iPKpAZkzu5SsSi9zJud3hfTo
         PllcibCsgo7Z2BW4R5hEUoJLI5sV4JnbJ8HhICW2m9CgIH7u9NqlQWzl4QqpQ0qnTq
         qG1z0k6v+fyl5hypFfNHT5jF+tnbv3CNPhB6lfGw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 00/21] driver core: bus: remove private "backpointer" from struct bus_type
Date:   Wed,  8 Feb 2023 12:13:09 +0100
Message-Id: <20230208111330.439504-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2989; i=gregkh@linuxfoundation.org; h=from:subject; bh=T46tXjAqJt8qFrwAGWcwbQFneNO1ZDw3Sb9SGT5jx1k=; b=owGbwMvMwCRo6H6F97bub03G02pJDMmPm6849r0re1Alv2fB3TvZ+f07OG92sAR+kJZxOrSE91G6 SvG7jlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZhI6nWGBVOPMIR+sZAuXS+1OmpT+s Xn0V6/6hjmysz26fw/baGD8L1e2y9dgb4vzllcAgA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to make all struct bus_type constant in the kernel,
allowing them to move into read-only memory, this patch series goes
through the steps in getting rid of the "private" pointer in struct
bus_type.  It does so primarily by relying on the already-present list
of subsystems in the driver core and looking up the struct bus_type from
that list when needed, or looking up the private structure from the bus
pointer, depending on what is needed.

Overall, more lines of code are added, but we now have the additional
safely that the internal subsystem private type is properly reference
counted.  We "got away" with not incrementing reference counts because
we relied on the caller of functions to have a valid reference when
calling into the core.  That's not really the proper way to handle
reference counts, so as part of the conversion, reference counts are now
correctly handled.

There are still some remaining steps to be able to have bus_type be
constant everywhere in the kernel, but this series is a great first step
and is the "hard part" of the work.  The rest involves changing the
callback sysfs file functions and handling the dev_root pointer
properly.  Those changes will be forthcoming after these as they involve
lots more minor driver changes all over the kernel.

This has been build-tested by the 0-day bot for a while, and is being
used by me right now to send this series out, so it "works for me!"

This series is based against my current driver-core-next branch that is
in linux-next.

Greg Kroah-Hartman (21):
  driver core: add local subsys_get and subsys_put functions
  driver core: bus: implement bus_get/put() without the private pointer
  driver core: bus: constantify the bus_find_* functions
  driver core: bus: convert bus_create/remove_file to be constant
  driver core: bus: sysfs function cleanups
  driver core: bus: bus_add/probe/remove_device() cleanups
  driver core: bus: bus_register/unregister() cleanups
  driver core: bus: subsys_interface_register/unregister() cleanups
  driver core: bus: bus_get_kset() cleanup
  driver core: bus: bus_register/unregister_notifier() cleanups
  driver core: bus: bus_add/remove_driver() cleanups
  driver core: bus: bus iterator cleanups
  driver core: bus: clean up bus_sort_breadthfirst()
  driver core: move driver_find() to bus.c
  driver core: bus: clean up driver_find()
  driver core: create bus_is_registered()
  driver core: remove private pointer from struct bus_type
  driver core: bus: constify bus_register/unregister_notifier()
  driver core: bus: constify bus_get_kset()
  driver core: bus: constify some internal functions
  driver core: bus: constify bus_unregister()

 drivers/base/base.h        |  14 ++
 drivers/base/bus.c         | 491 ++++++++++++++++++++++++++-----------
 drivers/base/driver.c      |  29 +--
 include/linux/device/bus.h |  37 ++-
 4 files changed, 375 insertions(+), 196 deletions(-)

-- 
2.39.1

