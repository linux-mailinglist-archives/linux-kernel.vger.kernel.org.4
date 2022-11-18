Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4865562FFF5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 23:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbiKRWWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 17:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbiKRWVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 17:21:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F24B73B1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 14:21:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EA266279B
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 22:21:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57381C433C1;
        Fri, 18 Nov 2022 22:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668810066;
        bh=4DoYnw76fqOF8eoz1c60HE/LDDgiMmHOaEFrZSG7zM8=;
        h=From:To:Cc:Subject:Date:From;
        b=toPfbsH/EUCweFHQkkcTAJAYHlBhpjWw6HJuieDCirr45iDNrounR1QQbmJu3XkbT
         SQTLhLHW+fTgvDx8tt5VSbBO4EI73wCapTukbtkBQRtfJHD0R9sCAOwNEay+zl9PaK
         hVxQ0i/j9Rpqr3ljz16xoInTo/spcexxVq9gIdN668vjKAtoqefmcmDz/DcBOQQxNe
         OrId17JArabETsrwELjHo9VaRVM8Mo9sfkiVlTPF7ZOk2F8TsSiXU5RfV3AF2yWWQD
         u3TdTCADxuAfV0cKjafQcn3aSEJJWLnGr4VMvJ71WwvA9H8P4fqXxWUzPwNbZz84Qp
         0NeCaeR4vIFaQ==
From:   Conor Dooley <conor@kernel.org>
To:     Conor Dooley <conor.dooley@microchip.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Daire McNamara <daire.mcnamara@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] mpfs: fix handling failed service requests
Date:   Fri, 18 Nov 2022 22:20:42 +0000
Message-Id: <20221118222043.1214776-1-conor@kernel.org>
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

Changes since v1:
- Send the patches I meant to send, with an extraneous ; removed.

Conor Dooley (2):
  soc: microchip: mpfs: handle failed system service requests
  mailbox: mpfs: read the system controller's status

 drivers/mailbox/mailbox-mpfs.c              | 31 +++++++++++++++++++--
 drivers/soc/microchip/mpfs-sys-controller.c |  6 ++++
 2 files changed, 35 insertions(+), 2 deletions(-)

-- 
2.37.2

