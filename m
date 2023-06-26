Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2FA173EE57
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 00:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjFZWHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 18:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbjFZWGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 18:06:55 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15F01999
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 15:03:13 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-666edfc50deso2504967b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 15:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687816992; x=1690408992;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=t29Nyoq0sCG+QQJT6RRc1wswLqkrP2lzDbM08iFudzY=;
        b=pyK6FH23VOtakuzS8YTMmfpCyAvPH+c7tghVLT/GJ9BDiCXQs/iERVyXOlSgpEP1PW
         PafsujvWzXUTOO1B/h6yD3HiDve7PxoyTVUhIWmjKqiCvqI6yXnVmsuraQaoIPMR0T9R
         3mZp+ezemFNm708zBnWB48tcZ1uNZ0KQdqHxBe7YHgoWc//eo2UtyfDtQWdwy7CEO/f2
         ZLk5jE9nQSDSeQhlM+0ZcD5HvayiC55HodrJFSdWOlTc0Fq8uF5DQpo6HfaOQN+8fL8P
         B73F0s03Lg7PS3tfX8fv/g+QtEpwcM9KVAp818wm9va61IDxOqz5ncw8b8e3K+h76HwV
         iUgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687816992; x=1690408992;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t29Nyoq0sCG+QQJT6RRc1wswLqkrP2lzDbM08iFudzY=;
        b=FaCcN1zmJbrZ4S0DfilSOgazxwsxCyxGoeyy4/ZeaozfriEZqSy/ZY7N5nZFF0/kD1
         forJ/NSjFD5bMFwWABmGjxqYUyGkCvyLWu0L8EzhtugycbNeJ4Ltg7pxx6zewr5Xed3M
         8Iz47QtGiFhUZvWKXh42MEG6JqwA9HU9qkE92HVChvhNK6+UF7pzubHJnc3ibdYExlzz
         jD+CkAamAmVhGS8kEbYVhfNIt5Q7WcZid1Lh099+Ny07Fy/MpPqlTxUSUKLPhE+BKopC
         VK3KKokR0eXjHH6YYf2xBzRjIfhhsy0X9KoiMq6YOtMAAAm6QAJaOTynSbJVzrk7xm2s
         CoPQ==
X-Gm-Message-State: AC+VfDy7TO/04JRjim9WBHH6EylFkH/K1IsnGSLl+5U0FM3lfATI3GAG
        HeB3yVh4ZNUzvdsFk1K1Q9E=
X-Google-Smtp-Source: ACHHUZ7Mta+s90GH4V8YPCTQBtCLKtcz2/L+0odFjNCDHvlt2ZlP9kNmr1FeiBuLVRTEbbHUNVL1nQ==
X-Received: by 2002:a05:6a20:748c:b0:106:9266:4448 with SMTP id p12-20020a056a20748c00b0010692664448mr45207749pzd.16.1687816992042;
        Mon, 26 Jun 2023 15:03:12 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id m26-20020a056a00165a00b006675c242548sm4247468pfc.182.2023.06.26.15.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 15:03:11 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 26 Jun 2023 12:03:11 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] workqueue: Ordered workqueue creation cleanups for v6.5
Message-ID: <ZJoLH3Mlw7b2ylpC@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ba0ad6ed89fd5dada3b7b65ef2b08e95d449d4ab:

  media: nxp: imx8-isi: fix buiding on 32-bit (2023-05-08 09:10:07 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.5-cleanup-ordered

for you to fetch changes up to 78ef970385ea4d02a44af2776e4f4c74d4fce3d4:

  rxrpc: Use alloc_ordered_workqueue() to create ordered workqueues (2023-05-25 12:15:36 -1000)

----------------------------------------------------------------
workqueue: Ordered workqueue creation cleanups

For historical reasons, unbound workqueues with max concurrency limit of 1
are considered ordered, even though the concurrency limit hasn't been
system-wide for a long time. This creates ambiguity around whether ordered
execution is actually required for correctness, which was actually confusing
for e.g. btrfs (btrfs updates are being routed through the btrfs tree).

There aren't that many users in the tree which use the combination and there
are pending improvements to unbound workqueue affinity handling which will
make inadvertent use of ordered workqueue a bigger loss. This pull request
clarifies the situation for most of them by updating the ones which require
ordered execution to use alloc_ordered_workqueue().

There are some conversions being routed through subsystem-specific trees and
likely a few stragglers. Once they're all converted, workqueue can trigger a
warning on unbound + @max_active==1 usages and eventually drop the implicit
ordered behavior.

----------------------------------------------------------------
Tejun Heo (17):
      powerpc, workqueue: Use alloc_ordered_workqueue() to create ordered workqueues
      greybus: Use alloc_ordered_workqueue() to create ordered workqueues
      net: thunderx: Use alloc_ordered_workqueue() to create ordered workqueues
      net: octeontx2: Use alloc_ordered_workqueue() to create ordered workqueues
      virt: acrn: Use alloc_ordered_workqueue() to create ordered workqueues
      xen/pvcalls: Use alloc_ordered_workqueue() to create ordered workqueues
      wifi: iwlwifi: Use default @max_active for trans_pcie->rba.alloc_wq
      wifi: mwifiex: Use default @max_active for workqueues
      wifi: ath10/11/12k: Use alloc_ordered_workqueue() to create ordered workqueues
      crypto: octeontx2: Use alloc_ordered_workqueue() to create ordered workqueues
      media: coda: Use alloc_ordered_workqueue() to create ordered workqueues
      scsi: NCR5380: Use default @max_active for hostdata->work_q
      media: amphion: Use alloc_ordered_workqueue() to create ordered workqueues
      dm integrity: Use alloc_ordered_workqueue() to create ordered workqueues
      net: wwan: t7xx: Use alloc_ordered_workqueue() to create ordered workqueues
      net: qrtr: Use alloc_ordered_workqueue() to create ordered workqueues
      rxrpc: Use alloc_ordered_workqueue() to create ordered workqueues

 arch/powerpc/kernel/tau_6xx.c                        |  2 +-
 arch/powerpc/platforms/pseries/dlpar.c               |  3 +--
 drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c   | 12 ++++++------
 drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c   |  6 +++---
 drivers/greybus/connection.c                         |  4 ++--
 drivers/greybus/svc.c                                |  2 +-
 drivers/md/dm-integrity.c                            |  4 ++--
 drivers/md/dm.c                                      |  2 +-
 drivers/media/platform/amphion/vpu_core.c            |  2 +-
 drivers/media/platform/amphion/vpu_v4l2.c            |  2 +-
 drivers/media/platform/chips-media/coda-common.c     |  2 +-
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c    |  3 +--
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c      |  5 ++---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c | 13 +++++--------
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c |  5 ++---
 drivers/net/wireless/ath/ath10k/qmi.c                |  3 +--
 drivers/net/wireless/ath/ath11k/qmi.c                |  3 +--
 drivers/net/wireless/ath/ath12k/qmi.c                |  3 +--
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c      |  2 +-
 drivers/net/wireless/marvell/mwifiex/cfg80211.c      |  4 ++--
 drivers/net/wireless/marvell/mwifiex/main.c          |  8 ++++----
 drivers/net/wwan/t7xx/t7xx_hif_cldma.c               | 13 +++++++------
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c           |  5 +++--
 drivers/scsi/NCR5380.c                               |  2 +-
 drivers/virt/acrn/ioreq.c                            |  4 ++--
 drivers/xen/pvcalls-back.c                           |  4 ++--
 net/qrtr/ns.c                                        |  2 +-
 net/rxrpc/af_rxrpc.c                                 |  2 +-
 28 files changed, 57 insertions(+), 65 deletions(-)
