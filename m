Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7435F717B2B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 11:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235327AbjEaJFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 05:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235265AbjEaJEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 05:04:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB82132;
        Wed, 31 May 2023 02:04:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C68796311E;
        Wed, 31 May 2023 09:04:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C4A9C4339C;
        Wed, 31 May 2023 09:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685523889;
        bh=oOGs9tMwzah4+TxwgR87Vqa86XZhF17++9U0nz5jqQc=;
        h=From:To:Cc:Subject:Date:From;
        b=GHprpvKBDrvMHlnkzUfG/zVo6OOctfBecJxrmF4nIhc4Pa+X0A+IffcCQGQE7U9H8
         LIODuR9NRX9i3S2m/15zIrtf24lKMKeoYyqIMEC96DTkgF26NBzBllcGBWl8IvelZ3
         UGccZXZ5NhTcAuhkDlgQ7hzNjPXcXSMMXTOVrSOpWzPQA+NFdsG38uCtsVr+7oRF5t
         djX4RR1D6Jmcg1PRkjxNnRTYUp4zfOoDDnMg9JGc57r2hYjPhv/+8OVmK3I9AdXXkO
         A3UUS0CcdKx5T5S8Jmn2bQzxFsjTSNdsSzcVwwuOm0SCexmEBRTmwiR/dThBRqZi2g
         VAfaiRnDJ/obQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1q4HlE-0000qL-Vz; Wed, 31 May 2023 11:04:53 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH RESEND 0/2] Bluetooth: fix bdaddr quirks
Date:   Wed, 31 May 2023 11:04:22 +0200
Message-Id: <20230531090424.3187-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches fix a couple of issues with the two bdaddr quirks:

The first one allows HCI_QUIRK_INVALID_BDADDR to be used with
HCI_QUIRK_NON_PERSISTENT_SETUP.

The second patch restores the original semantics of the
HCI_QUIRK_USE_BDADDR_PROPERTY so that the controller is marked as
unconfigured when no device address is specified in the devicetree (as
the quirk is documented to work).

This specifically makes sure that Qualcomm HCI controllers such as
wcn6855 found on the Lenovo X13s are marked as unconfigured until user
space has provided a valid address.

Long term, the HCI_QUIRK_USE_BDADDR_PROPERTY should probably be dropped
in favour of HCI_QUIRK_INVALID_BDADDR and always checking the devicetree
property.

Johan


Johan Hovold (2):
  Bluetooth: fix invalid-bdaddr quirk for non-persistent setup
  Bluetooth: fix use-bdaddr-property quirk

 net/bluetooth/hci_sync.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

-- 
2.39.3

