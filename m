Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1075D710A5E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 12:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240780AbjEYKxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 06:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233943AbjEYKxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 06:53:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5B290
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 03:53:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FA026442B
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 10:53:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A14CC433D2;
        Thu, 25 May 2023 10:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685011989;
        bh=DGZUNnKLpFIKKgAIoq8KpqEt+LPmKrgx96HvrKtT9Yw=;
        h=From:Date:Subject:To:Cc:From;
        b=Dft2P935xbpmZpkslBzCWrsDqbaeVKgPg3BoZ5+uADaeCLyX91goudh/37PWofh5j
         YKZkCYWz+F0uWy56wWc5BSRRRTx7Pf6VvqulpN/Q3LoBo1NnJNS0yj++edEeri0DdZ
         KfjL2vUmtjaAo38IuDuhlje4cSdsr9IWyyhvV5qIozhc1H76JayVKB4xYPrKO7mwqt
         5rZ77eCbN8cVz3Nh4YgO12xlgfdpkmsgTRPVG7Oh37iKlPkzv1zGPOJPjArM/9NGWI
         VaWQmNQXR5J4WyPKyl2Ig2sQF24+A9JNxW2I+jh5XKv5uApSVSni5S0D36RFXjgLe5
         rWHWzZ/xO294Q==
From:   Simon Horman <horms@kernel.org>
Date:   Thu, 25 May 2023 12:52:58 +0200
Subject: [PATCH net] ice: Don't dereference NULL in ice_gns_read error path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230525-null-ice-v1-1-30d10557b91e@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAk+b2QC/x2M0QqDMBAEf0XuuQcmqaX4K6UPMa71QK6SVBHEf
 /fs4ywzu1NBFhRqq50yVinyVQN3qyiNUT9g6Y3J1z7UjW9Yl2liSeDQu2d8hOEe4Mj0LhZwl6O
 m0YJLs3HOGGT7/79I8aP3cZzb+JqMdAAAAA==
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Karol Kolacinski <karol.kolacinski@intel.com>,
        Sudhansu Sekhar Mishra <sudhansu.mishra@intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If pf is NULL in ice_gns_read() then it will be dereferenced
in the error path by a call to dev_dbg(ice_pf_to_dev(pf), ...).

Avoid this by simply returning in this case.
If logging is desired an alternate approach might be to
use pr_err() before returning.

Flagged by Smatch as:

  .../ice_gnss.c:196 ice_gnss_read() error: we previously assumed 'pf' could be null (see line 131)

Fixes: 43113ff73453 ("ice: add TTY for GNSS module for E810T device")
Signed-off-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_gnss.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_gnss.c b/drivers/net/ethernet/intel/ice/ice_gnss.c
index 2ea8a2b11bcd..3d0663840aa1 100644
--- a/drivers/net/ethernet/intel/ice/ice_gnss.c
+++ b/drivers/net/ethernet/intel/ice/ice_gnss.c
@@ -128,12 +128,7 @@ static void ice_gnss_read(struct kthread_work *work)
 	int err = 0;
 
 	pf = gnss->back;
-	if (!pf) {
-		err = -EFAULT;
-		goto exit;
-	}
-
-	if (!test_bit(ICE_FLAG_GNSS, pf->flags))
+	if (!pf || !test_bit(ICE_FLAG_GNSS, pf->flags))
 		return;
 
 	hw = &pf->hw;
@@ -191,7 +186,6 @@ static void ice_gnss_read(struct kthread_work *work)
 	free_page((unsigned long)buf);
 requeue:
 	kthread_queue_delayed_work(gnss->kworker, &gnss->read_work, delay);
-exit:
 	if (err)
 		dev_dbg(ice_pf_to_dev(pf), "GNSS failed to read err=%d\n", err);
 }

