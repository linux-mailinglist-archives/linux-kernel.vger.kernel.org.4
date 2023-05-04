Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC91C6F6811
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 11:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjEDJNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 05:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjEDJNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 05:13:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0271640E0
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 02:13:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7191433931;
        Thu,  4 May 2023 09:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683191583; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=zg7g2BOvhmWFc3dhiKasbnCc51IssmQS3By3r+3Vyvc=;
        b=MC29e/jxsi3vii+r1q6FTuTeZ9+h8d2o2nRI1YT0GHIb8b+3hY5D/cK/bB6+235xHyv3Zk
        xmwAzcsL6Z7Ut13HNOfM6sqA3t1xUUIR+PeeHvsazShHC9J0k3sxzDInfOjw9e1sByNXkN
        A+6XzUMKhiPoDYHdkpvkkuQ/MXa+cHc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683191583;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=zg7g2BOvhmWFc3dhiKasbnCc51IssmQS3By3r+3Vyvc=;
        b=ACIw7b/wmBFXaY6PHIuXXxbUkH5YR7XgPgF79dscbQGvzVoOyB1BddNCfwMy2WE9gsV7Mt
        C3T5oV8jOfQ8LMCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6127013444;
        Thu,  4 May 2023 09:13:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WK+qFx93U2TVTwAAMHmgww
        (envelope-from <dwagner@suse.de>); Thu, 04 May 2023 09:13:03 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [RFC v3 0/9] Unifying fabrics drivers
Date:   Thu,  4 May 2023 11:12:50 +0200
Message-Id: <20230504091259.29100-1-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've rebased on nvme-6.4 and gave it a bit of testing. Up to the last patch it seems to
work fine, at least blktests doesn't trigger any errors.

I've tried to split the pure moving code around part from the part where we need
to change some code. That means the last two patches highlight the problems I
run into with this attempt to implement the setup_transport() callback

changes:
v2:
  - move the complete ctrl state machine to fabrics.c
  - https://lore.kernel.org/linux-nvme/20230306093244.20775-1-dwagner@suse.de/ 
  
v1:
  - https://lore.kernel.org/linux-nvme/20230301082737.10021-1-dwagner@suse.de/


Daniel Wagner (9):
  nvme-rdma: stream line queue functions arguments
  nvme-rdma: factor rdma specific queue init code out
  nvme-tcp: move error and connect work to nvme_ctrl
  nvme-rdma: use error and connect work from nvme_ctrl
  nvme-fabrics: add fabric state machine
  nvme-tcp: replace state machine with generic one
  nvme-rdma: replace state machine with generic one
  nvme: move queue flags to middle layer
  nvme: introduce setup_transport()

 drivers/nvme/host/fabrics.c | 513 +++++++++++++++++++++++++
 drivers/nvme/host/fabrics.h |  24 ++
 drivers/nvme/host/nvme.h    |  19 +
 drivers/nvme/host/rdma.c    | 720 ++++++++++--------------------------
 drivers/nvme/host/tcp.c     | 706 ++++++++---------------------------
 5 files changed, 913 insertions(+), 1069 deletions(-)

-- 
2.40.0

