Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C771662FFC3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 23:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbiKRWId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 17:08:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbiKRWI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 17:08:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82231CCB
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 14:08:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 28B30B8244B
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 22:08:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA198C433C1;
        Fri, 18 Nov 2022 22:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668809302;
        bh=1wQ7JjkjhAaO9Ity46ObMNK9mNLSNyW/QVbeLpROsMw=;
        h=From:To:Cc:Subject:Date:From;
        b=F+N6AsMUrOfRP9wtEAmh3z3seyOLituSlGhUgmw5UCukH7jLh5J1TMFEYIj1Py2/t
         pgSstGTM3P1MVTrihu2KY70ofIpGUra+kJkfYUjUXD+7Q4kQZVsVehUXgRWRXJsGdx
         ssGKtwkJ25kRFGlwvjSeSD/yWfsHMswBcowfg4Tu+Qp7mm8wL0+wMmo5fH2+PuMecJ
         uTW25lRqVUdzr17DQhxkYNzRSEUpwr1NcNzGvhFZDL3rt60UZCClrFbas2DjS4p7Oi
         PsOEGqmsYTW2EVK72jfs1uJ85nuajlwmcfek+haV24QEhzEOm8jzbzpcJXCMocwqll
         DFEmGOQT/fQJA==
From:   Conor Dooley <conor@kernel.org>
To:     Conor Dooley <conor.dooley@microchip.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Daire McNamara <daire.mcnamara@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] mpfs: fix handling failed service requests
Date:   Fri, 18 Nov 2022 22:07:57 +0000
Message-Id: <20221118220758.1101409-1-conor@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

As things stand, if a service request fails, we never know about it as
the status register is not read. This is quite obviously far from ideal,
as we would be reading garbage from the mailbox if a service was to
fail.

This pair of patches adds handling of the service status to both sides
of the mailbox implementation.

@Jassi, there should be no build, or really functional, dependency here
between patches. In the failing case, the buffer is allocated by the
service driver, so things will "work" just as badly as they did before
if only one of the patches is present. As a result, should be safe to do
the mailbox patch via your tree & the client via the soc tree.

Thanks,
Conor.

Conor Dooley (2):
  soc: microchip: mpfs: handle failed system service requests
  mailbox: mpfs: read the system controller's status

 drivers/mailbox/mailbox-mpfs.c              | 31 +++++++++++++++++++--
 drivers/soc/microchip/mpfs-sys-controller.c |  6 ++++
 2 files changed, 35 insertions(+), 2 deletions(-)

-- 
2.37.2

