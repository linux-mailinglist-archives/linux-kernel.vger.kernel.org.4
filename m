Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7A7745383
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 03:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjGCB1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 21:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjGCB1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 21:27:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FA212E
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 18:27:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEC4460CA5
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 01:27:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B35DCC433C8;
        Mon,  3 Jul 2023 01:27:38 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="jvP9A47q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1688347656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/8FNBpNat7e309IgNwWfqNiKa7gq9pqAeqIgNCoAAOY=;
        b=jvP9A47qBYvZk6koIP8i4z89ZNHmYlqsDJUlnD2KrYYpVpJgq1Vugz0wW8/f4x11n0REyW
        zIV3Wj66diR++67tI0jx8N0X2kVqpVkhcb8M04ISIa9LMVHcVMZgM4CIjJ1VXefD6/H9La
        oWfvRMh++DRWCRuyeYPHHdmywq+Fp+Q=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 27e20959 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 3 Jul 2023 01:27:34 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH net 0/3] wireguard fixes for 6.4.2/6.5-rc1
Date:   Mon,  3 Jul 2023 03:27:03 +0200
Message-ID: <20230703012723.800199-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jakub,

Sorry to send these patches during the merge window, but they're net
fixes, not netdev enhancements, and while I'd ordinarily wait anyway,
I just got a first bug report for one of these fixes, which I originally
had thought was mostly unlikely. So please apply the following three
patches to net:

1) Make proper use of nr_cpu_ids with cpumask_next(), rather than
   awkwardly using modulo, to handle dynamic CPU topology changes.
   Linus noticed this a while ago and pointed it out, and today a user
   actually got hit by it.

2) Respect persistent keepalive and other staged packets when setting
   the private key after the interface is already up.

3) Use timer_delete_sync() instead of del_timer_sync(), per the
   documentation.

Thanks,
Jason

Jason A. Donenfeld (3):
  wireguard: queueing: use saner cpu selection wrapping
  wireguard: netlink: send staged packets when setting initial private
    key
  wireguard: timers: move to using timer_delete_sync

 drivers/net/wireguard/netlink.c            | 14 ++++++----
 drivers/net/wireguard/queueing.c           |  1 +
 drivers/net/wireguard/queueing.h           | 25 ++++++++----------
 drivers/net/wireguard/receive.c            |  2 +-
 drivers/net/wireguard/send.c               |  2 +-
 drivers/net/wireguard/timers.c             | 10 ++++----
 tools/testing/selftests/wireguard/netns.sh | 30 +++++++++++++++++++---
 7 files changed, 54 insertions(+), 30 deletions(-)

-- 
2.41.0

