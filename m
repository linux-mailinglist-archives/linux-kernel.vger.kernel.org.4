Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16C06EA1DD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 04:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbjDUCuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 22:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbjDUCuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 22:50:51 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D6AE75
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 19:50:50 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1a6670671e3so16587725ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 19:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682045450; x=1684637450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=bKGjsyIEQfA0iO8Nku1mJhtuZxj/3k7VoGXX+ZH1FoA=;
        b=aLqkSbyit+G7yJW3MnX4Cxl1GxeuxG5/Mo7SlaFjDU6AEr92CkIzV4iFbOsoCSU0JL
         JxnbufKvNpZQVRWToz6+hEPcQhLZoVoteLhhdCTZFgLsuee4vgieciKYTy6hQ+AeIBP3
         vZKkeMcmvhLdS/1OIijTw+6rfij0aP0K6b7MSAY5N1LmbfizzFevFw40TWKoq9ZdLeIQ
         rjBJBqyirKKjYdj+0Lu02i5SqQDcbfeMtN4dR+qGcCse6BjVEYtOrtr7EDyerVxrHB4z
         JRUS3vXlNm86iNDPVxZrn/LCyAa+xY2tnLB6520hw0qU9f6C0lXAZ+zpymSmQEKwmXU+
         cP1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682045450; x=1684637450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bKGjsyIEQfA0iO8Nku1mJhtuZxj/3k7VoGXX+ZH1FoA=;
        b=fc/Kul4ktlSn1PYuqSD/gsl2EqvhQNkMk7rvlA2sBX/51TT+ApzrX5IMlv93STOoKD
         yLQhPtAFbRZGlpPdWBOkIaL11sA43UJeH8JNYKL8DdoIyFBNY2YN8ESxqMnXXFXVhCUz
         dYwH2C4bFaPnSlSZcv7zYu+kmvt8c9hYG8r7ygAf0jkwai+zZLmQP8xlDboVz4QAP9KP
         Ny+JN9+I76JU9i0uEW2GIxaJb7TDGZUq4Ma6uBL2LvGnZO+sBU/vJxwMNW820MqjwMtF
         hCEek93iZQrfy7jyAJWJua5OVuwuXYj9HDDfM9GfvhLJ83e4slMyftUg72EX0WreBrGy
         pgtQ==
X-Gm-Message-State: AAQBX9drlyCPKhf8cmcaRDxAHrl3mke+Mo6EhAsskCg+Q0JdihC8PyAL
        l3Nfwoj7ZA74XGdhoody/GmE6NhA73o=
X-Google-Smtp-Source: AKy350a1pJG3riRlVZkuCSz2gmRC0GwtBnFOzgdsCEzLWhv2uOMmD0pqpwaqRbrWPEZFXgwWxeed+A==
X-Received: by 2002:a17:902:e848:b0:1a1:ab92:5c88 with SMTP id t8-20020a170902e84800b001a1ab925c88mr4577298plg.13.1682045449782;
        Thu, 20 Apr 2023 19:50:49 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id c5-20020a170902aa4500b001a24cded097sm1722878plr.236.2023.04.20.19.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 19:50:49 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: [PATCHSET wq/for-6.5] workqueue: Ordered workqueue creation cleanup
Date:   Thu, 20 Apr 2023 16:50:24 -1000
Message-Id: <20230421025046.4008499-1-tj@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hello,

When multiple work items are queued to a workqueue, their execution order
doesn't match the queueing order. They may get executed in any order and
simultaneously. When fully serialized execution - one by one in the queueing
order - is needed, an ordered workqueue should be used which can be created
with alloc_ordered_workqueue().

However, alloc_ordered_workqueue() was a later addition. Before it, an
ordered workqueue could be obtained by creating an UNBOUND workqueue with
@max_active==1. This originally was an implementation side-effect which was
broken by 4c16bd327c74 ("workqueue: restore WQ_UNBOUND/max_active==1 to be
ordered"). Because there were users that depended on the ordered execution,
5c0338c68706 ("workqueue: restore WQ_UNBOUND/max_active==1 to be ordered")
made workqueue allocation path to implicitly promote UNBOUND workqueues w/
@max_active==1 to ordered workqueues.

While this has worked okay, overloading the UNBOUND allocation interface
this way creates other issues. It's difficult to tell whether a given
workqueue actually needs to be ordered and users that legitimately want a
min concurrency level wq unexpectedly gets an ordered one instead. With
planned UNBOUND workqueue updates to improve execution locality and more
prevalence of chiplet designs which can benefit from such improvements, this
isn't a state we wanna be in forever.

This patch series audits all callsites that create an UNBOUND workqueue w/
@max_active==1 and converts them to alloc_ordered_workqueue() as necessary
and contains the following 22 patches.

 0001-powerpc-workqueue-Use-alloc_ordered_workqueue-to-cre.patch
 0002-greybus-Use-alloc_ordered_workqueue-to-create-ordere.patch
 0003-IB-hfi1-Use-alloc_ordered_workqueue-to-create-ordere.patch
 0004-dm-integrity-Use-alloc_ordered_workqueue-to-create-o.patch
 0005-media-amphion-Use-alloc_ordered_workqueue-to-create-.patch
 0006-net-thunderx-Use-alloc_ordered_workqueue-to-create-o.patch
 0007-net-octeontx2-Use-alloc_ordered_workqueue-to-create-.patch
 0008-wifi-ath10-11-12k-Use-alloc_ordered_workqueue-to-cre.patch
 0009-wifi-iwlwifi-Use-alloc_ordered_workqueue-to-create-o.patch
 0010-wifi-mwifiex-Use-alloc_ordered_workqueue-to-create-o.patch
 0011-net-wwan-t7xx-Use-alloc_ordered_workqueue-to-create-.patch
 0012-scsi-Use-alloc_ordered_workqueue-to-create-ordered-w.patch
 0013-virt-acrn-Use-alloc_ordered_workqueue-to-create-orde.patch
 0014-soc-qcom-qmi-Use-alloc_ordered_workqueue-to-create-o.patch
 0015-xen-pvcalls-Use-alloc_ordered_workqueue-to-create-or.patch
 0016-btrfs-Use-alloc_ordered_workqueue-to-create-ordered-.patch
 0017-cifs-Use-alloc_ordered_workqueue-to-create-ordered-w.patch
 0018-net-qrtr-Use-alloc_ordered_workqueue-to-create-order.patch
 0019-rxrpc-Use-alloc_ordered_workqueue-to-create-ordered-.patch
 0020-crypto-octeontx2-Use-alloc_ordered_workqueue-to-crea.patch
 0021-media-coda-Use-alloc_ordered_workqueue-to-create-ord.patch
 0022-workqueue-Don-t-implicitly-make-UNBOUND-workqueues-w.patch

0001-0021 convert the existing users and 0022 drops the implicit ordered
promotion logic from alloc_workqueue(). I'll keep an eye out for a while
after merging 0022. Thankfully, these are pretty easy to grep for. The
patches can also be found in the following git branch.

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git ordered-cleanup

diffstat follows. Thanks.

 arch/powerpc/kernel/tau_6xx.c                        |    2 -
 arch/powerpc/platforms/pseries/dlpar.c               |    3 --
 drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c   |   12 ++++-----
 drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c   |    6 ++--
 drivers/greybus/connection.c                         |    4 +--
 drivers/greybus/svc.c                                |    2 -
 drivers/infiniband/hw/hfi1/init.c                    |    7 ++---
 drivers/md/dm-integrity.c                            |    4 +--
 drivers/md/dm.c                                      |    2 -
 drivers/media/platform/amphion/vpu_core.c            |    2 -
 drivers/media/platform/amphion/vpu_v4l2.c            |    2 -
 drivers/media/platform/chips-media/coda-common.c     |    2 -
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c    |    3 --
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c      |    5 +---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c |   13 ++++------
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c |    5 +---
 drivers/net/wireless/ath/ath10k/qmi.c                |    3 --
 drivers/net/wireless/ath/ath11k/qmi.c                |    3 --
 drivers/net/wireless/ath/ath12k/qmi.c                |    3 --
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c      |    4 +--
 drivers/net/wireless/marvell/mwifiex/cfg80211.c      |   13 ++++------
 drivers/net/wireless/marvell/mwifiex/main.c          |   22 ++++++++----------
 drivers/net/wwan/t7xx/t7xx_hif_cldma.c               |   13 +++++-----
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c           |    5 ++--
 drivers/scsi/NCR5380.c                               |    5 +---
 drivers/scsi/hosts.c                                 |   12 ++++-----
 drivers/scsi/libiscsi.c                              |    5 +---
 drivers/soc/qcom/qmi_interface.c                     |    2 -
 drivers/virt/acrn/ioreq.c                            |    4 +--
 drivers/xen/pvcalls-back.c                           |    4 +--
 fs/btrfs/disk-io.c                                   |    2 -
 fs/btrfs/scrub.c                                     |    6 +++-
 fs/cifs/dfs_cache.c                                  |    2 -
 include/linux/workqueue.h                            |    4 ---
 kernel/workqueue.c                                   |   23 +++----------------
 net/qrtr/ns.c                                        |    2 -
 net/rxrpc/af_rxrpc.c                                 |    2 -
 37 files changed, 92 insertions(+), 121 deletions(-)

