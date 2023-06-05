Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE65722016
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjFEHvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjFEHvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:51:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C668FB7;
        Mon,  5 Jun 2023 00:51:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B23161088;
        Mon,  5 Jun 2023 07:51:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70AFEC433D2;
        Mon,  5 Jun 2023 07:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685951493;
        bh=Mmp32lKbk9EzJkxKXA959mR3TzvW5Q3iXzlTBMxFbE8=;
        h=From:To:Cc:Subject:Date:From;
        b=ysBCz7Jf1OD6vm4BI7bpodVZ1toBXfrp5fl3Bljc1cliYoVysCyGVQrizEMs4Reci
         ZPmOi88P0faiHMjHdkstJyu4CsjEh2nBZ9LBAp03HaQNOX6g9XRZsYWggTeYOMEaMU
         8yLAc+mmqt2d/qg8dE6KNCLSERP5AL8J/nP8yFeY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.4.245
Date:   Mon,  5 Jun 2023 09:51:25 +0200
Message-ID: <2023060519-remedy-device-a06c@gregkh>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 5.4.245 kernel.

All users of the 5.4 kernel series must upgrade.

The updated 5.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.4.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                             |    2 
 drivers/android/binder.c                             |   26 -
 drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c |   35 +
 drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h |    2 
 drivers/net/usb/cdc_ncm.c                            |  435 ++++++++++++++-----
 drivers/net/usb/huawei_cdc_ncm.c                     |    8 
 drivers/power/supply/bq24190_charger.c               |   13 
 drivers/power/supply/bq27xxx_battery.c               |    4 
 drivers/power/supply/power_supply_core.c             |   57 +-
 fs/io_uring.c                                        |    8 
 include/linux/fs.h                                   |   40 -
 include/linux/power_supply.h                         |    5 
 include/linux/usb/cdc_ncm.h                          |   15 
 include/net/ip.h                                     |    2 
 include/uapi/linux/in.h                              |    2 
 net/bluetooth/hci_sock.c                             |   28 +
 net/ipv4/ip_sockglue.c                               |   12 
 net/ipv4/raw.c                                       |    5 
 net/ipv6/raw.c                                       |    3 
 net/netfilter/nf_conntrack_netlink.c                 |    8 
 20 files changed, 520 insertions(+), 190 deletions(-)

Alexander Bersenev (2):
      cdc_ncm: Implement the 32-bit version of NCM Transfer Block
      cdc_ncm: Fix the build warning

Carlos Llamas (1):
      binder: fix UAF caused by faulty buffer cleanup

Greg Kroah-Hartman (1):
      Linux 5.4.245

Hans de Goede (3):
      power: supply: bq27xxx: After charger plug in/out wait 0.5s for things to stabilize
      power: supply: core: Refactor power_supply_set_input_current_limit_from_supplier()
      power: supply: bq24190: Call power_supply_changed() after updating input current

Hao Ge (1):
      fs: fix undefined behavior in bit shift for SB_NOUSER

Jens Axboe (3):
      io_uring: always grab lock in io_cancel_async_work()
      io_uring: don't drop completion lock before timer is fully initialized
      io_uring: have io_kill_timeout() honor the request references

Mark Bloch (1):
      net/mlx5: devcom only supports 2 ports

Nicolas Dichtel (1):
      ipv{4,6}/raw: fix output xfrm lookup wrt protocol

Paul Blakey (1):
      netfilter: ctnetlink: Support offloaded conntrack entry deletion

Ruihan Li (1):
      bluetooth: Add cmd validity checks at the start of hci_sock_ioctl()

Shay Drory (1):
      net/mlx5: Devcom, serialize devcom registration

Tudor Ambarus (1):
      net: cdc_ncm: Deal with too low values of dwNtbOutMaxSize

