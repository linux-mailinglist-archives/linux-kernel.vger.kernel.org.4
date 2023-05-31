Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68CF1717AE5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 10:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbjEaI6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 04:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234644AbjEaI6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 04:58:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D64121;
        Wed, 31 May 2023 01:58:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1F6B634A5;
        Wed, 31 May 2023 08:58:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21EFCC4339C;
        Wed, 31 May 2023 08:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685523518;
        bh=mJSo8BBhwI/dxw8GdROOGb5gjgq5W1wrGSLzQKQwoBM=;
        h=From:To:Cc:Subject:Date:From;
        b=EdgHBh4fKoarUjaCHDjrTETCm9eZRtZK+xB4AF1Cvyzt8RfhXhvfpaI39jYisNGel
         W+1HCggsHBWceZ+Wbd/KdUfbPmF6jywdVc49MKy+6LtxnZYzank29gYJh8Yjnm72HR
         vnIvAFUIM51knHrRGnCdp/UdStJKvbSIsem/YbdfN2tFUZ2H11UB1OpMz7eZNo8dU7
         t/FDcSmg6o4Ji/IcGysS32iTV+6O25M7sJpMFOVmtFXdcdYyhqDdw5I2pPamrtIA+U
         qLIm1/9xqFneZmU5u5Ys37xbGukQj5AEcSQ68iZJHxMq5X3aCH8zmJVt/0ceSN1WYv
         vtPKAv85S5MSA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1q4HfE-0000jj-Ss; Wed, 31 May 2023 10:58:41 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH RESEND 0/2] Bluetooth: fix debugfs registration
Date:   Wed, 31 May 2023 10:57:57 +0200
Message-Id: <20230531085759.2803-1-johan+linaro@kernel.org>
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

The HCI controller debugfs interface is created during setup or when a
controller is configured, but there is nothing preventing a controller
from being configured multiple times (e.g. by setting the device
address), which results in a host of errors in the logs:

	debugfs: File 'features' in directory 'hci0' already present!
	debugfs: File 'manufacturer' in directory 'hci0' already present!
	debugfs: File 'hci_version' in directory 'hci0' already present!
	...
	debugfs: File 'quirk_simultaneous_discovery' in directory 'hci0' already present!

The Qualcomm driver suffers from a related problem for controllers with
non-persistent setup.

Johan


Johan Hovold (2):
  Bluetooth: fix debugfs registration
  Bluetooth: hci_qca: fix debugfs registration

 drivers/bluetooth/hci_qca.c | 6 +++++-
 include/net/bluetooth/hci.h | 1 +
 net/bluetooth/hci_sync.c    | 3 +++
 3 files changed, 9 insertions(+), 1 deletion(-)

-- 
2.39.3

