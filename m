Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0E9607FC1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 22:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiJUUYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 16:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiJUUYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 16:24:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1D32EF2A;
        Fri, 21 Oct 2022 13:24:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3DB39B82C93;
        Fri, 21 Oct 2022 20:24:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9DE2C433D6;
        Fri, 21 Oct 2022 20:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666383875;
        bh=rDscKKakNbmSy+jMyqCXZDGCynr0gxx6xJRRolCx1bM=;
        h=From:To:Cc:Subject:Date:From;
        b=R/pq6X7cgLokoxyBWfHndFE1O01694dZ/Pnp+Ot1T/ZNZoHxHif9o8vPZEmtvkGNg
         IY5+BhV9+W378adX7NN1scUVIt3VPoypLVMx5HPOWINPddHp1ce1E0Bfka/o7BRDcw
         ogjgXjSGb4Mh6kBzVoqQ5eBR5kLxJ0xejaBzlrzIRMzD5M6eaOrkEnl3FW3moKi45c
         XdwlZp+z1Sw89adA99ruv8rjplP51O9E2mngdMEFFI8xnmlxZdQwHa25y173q3z1cx
         zPo9ee3Ifqd0+VetrugyIdFSNtMXZ033jlgjuXz08OFsF9SuZPGr+WpJN7GvrSW44+
         J3uD3dvoLR5qQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH REPOST v2 0/4] sh: remove unused SLOW_DOWN_IO
Date:   Fri, 21 Oct 2022 15:24:20 -0500
Message-Id: <20221021202424.307531-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

[Sorry for the noise; I sent this a few minutes ago, but it bounced from
all the individual recipients because of DMARC issues]

Only alpha and sh define SLOW_DOWN_IO, and there are no uses of it.  Remove
it from sh and clean up some nearby macros.

These were previously posted 4/15/2022 at
  https://lore.kernel.org/all/20220415190817.842864-1-helgaas@kernel.org/
and reposted 10/13/2022 at
  https://lore.kernel.org/all/20221014001911.3342485-1-helgaas@kernel.org/

Changes from v1 to v2:
  - Drop the ia64 patch because Andrew applied it
      https://lore.kernel.org/all/20221021045245.99636C433C1@smtp.kernel.org/

  - Fix the sh build issues reported by the kernel test robot:
      https://lore.kernel.org/all/202210181211.ItV2YuJI-lkp@intel.com/

  - Add minor sh cleanup patches to __BUILD_IOPORT_SINGLE(),
    __BUILD_IOPORT_PFX(), and __BUILD_MEMORY_STRING()

  - Split sh and alpha to separate series

Bjorn Helgaas (4):
  sh: remove unused SLOW_DOWN_IO
  sh: remove unused __BUILD_IOPORT_SINGLE 'pfx' parameter
  sh: remove unnecessary __BUILD_IOPORT_PFX()
  sh: remove unnecessary __BUILD_MEMORY_STRING() 'pfx' parameter

 arch/sh/include/asm/io.h | 42 +++++++++++++---------------------------
 1 file changed, 13 insertions(+), 29 deletions(-)
