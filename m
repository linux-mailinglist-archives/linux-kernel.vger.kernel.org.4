Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD146367DA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 18:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239173AbiKWR5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 12:57:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239092AbiKWR5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 12:57:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40AE725DC
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 09:57:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 468C361E34
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 17:57:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D91BC433D6;
        Wed, 23 Nov 2022 17:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669226222;
        bh=6aDFV5RMFM5DBqnyJB1qLRpyfmh7jSd5EtX3DfmwNSg=;
        h=From:To:Cc:Subject:Date:From;
        b=Ym0VZzwIOsstyS8D5VA1M1eFTiNe6v/3kXa0eSggXOtR6ZzzUtHZ3woFScjuQXA3x
         7+s/BaSS/yc14eBcbHjSOp4nKydL0JB8PicV/xl4ulzC1hQvDwA8RB3YnTt8YeFFa4
         MiJRrP3j1bIYheQHGh6AmHrcwa8GxbcOUp967j147j6krPcp7kDfRaUoeZB7zfDQuJ
         HZroZ/z2lYnBSA2csJBaV1+fRSt7nBcOSxi7n0SOIwBHlaNjOBfyHeYv1eJ9p2LPc4
         UGzRXyootOIIs+d7kltwh1wmBUo1o/KdmPtga/94RnYjKX1loXkkPIKI9qhE2HiU+C
         gaC6vDwpk4Obg==
From:   Conor Dooley <conor@kernel.org>
To:     Conor Dooley <conor.dooley@microchip.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Daire McNamara <daire.mcnamara@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] mpfs: fix handling failed service requests
Date:   Wed, 23 Nov 2022 17:56:50 +0000
Message-Id: <20221123175652.327859-1-conor@kernel.org>
X-Mailer: git-send-email 2.38.1
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

Changes since v2:
- Stop redefining the already existing #defines for status register.

Changes since v1:
- Send the patches I meant to send, with an extraneous ; removed.

Conor Dooley (2):
  soc: microchip: mpfs: handle failed system service requests
  mailbox: mpfs: read the system controller's status

 drivers/mailbox/mailbox-mpfs.c              | 31 +++++++++++++++++++--
 drivers/soc/microchip/mpfs-sys-controller.c |  6 ++++
 2 files changed, 34 insertions(+), 3 deletions(-)

-- 
2.38.1

