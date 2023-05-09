Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C926FBCA9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 03:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbjEIBum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 21:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233535AbjEIBuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 21:50:37 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC76A24E
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 18:50:36 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6436e075166so3935179b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 18:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683597036; x=1686189036;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=4tIk4qo2wN6Su9YDYjJOTioyDLLZxRyG9tB0Rh2uIVk=;
        b=Ys9QkmlbWJeMCCSQKHe0QIfTuNsFlXX5oi4S7hnRHFLD40pVpcfeeF9lUK9EGyiYeT
         Qz/FutL28nEHBoacyKApAUOo46g8gIXxjHt+vqvwoOLA8n7CZRQfEdnjNFtSRuR+spEK
         pr+0LySQiocr+IaLGC6eKhlcxP2F2S7gdybvWAlau13NbvxIoJIZ5/oC5vZSZQyPS30a
         R+kMm+RsPKcWcU6t/t8l0dh2nQzk9g4OUwHBsuWGmuDU1npOgnuySllFJ4OgEJTgokkQ
         De0/aZ9HVdbtB/eFxrOHtOOJRbzJG/vF8otQynITbwUQm54IT2hgxpe393kVDUavFk/x
         IC5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683597036; x=1686189036;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4tIk4qo2wN6Su9YDYjJOTioyDLLZxRyG9tB0Rh2uIVk=;
        b=SlL2FIMOq55rsuC2FUmdmC3iPh05aDiskKqmJH1QtTtNjKiSegwIHLezbEKsdqiuGL
         hyqdGOkNEB4I80gQajVvS/yjQU+TwnElouH1lEorSSPbguzbZM+YmDfjGIi4aQN31b4a
         pV5+CPpUzFT1qwBQwLmZUthRFENbh4iyUpm29JqKS0LbVddkyzzNieMH0gmtZSI+h8qp
         oH8PEHgYX6Im0ctdX1dfIle877vvCtiDMbi6MAZy+Tg+Wc06xHYtknuAUqEUmUlKPWFp
         mlheI3CSDw+JPSSaveoYEGXdQIzZeDj9gN0Vu7N5zt0VAwiS9fFuVQpbDqRe8yFwzxLO
         C6nA==
X-Gm-Message-State: AC+VfDzzljA+JXJ5v7W9ktkEinSIeVgIB8vcBmQpfcGSlsHp2A+rGMsl
        ygjn8IWvCS25IWQMnqOg+2w=
X-Google-Smtp-Source: ACHHUZ7UShsXpOyCKSiCVknzKT/sZQGejBoz5a+srEiWvXANlC69OKyOJp/7Fa1kLo6/PtLNuQ40IA==
X-Received: by 2002:a05:6a00:1681:b0:639:c88b:c3e0 with SMTP id k1-20020a056a00168100b00639c88bc3e0mr16550634pfc.22.1683597035485;
        Mon, 08 May 2023 18:50:35 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id y13-20020a655b4d000000b00524dde7231dsm146502pgr.9.2023.05.08.18.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 18:50:35 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: [PATCHSET v2 wq/for-6.5-cleanup-ordered] workqueue: Ordered workqueue creation cleanup
Date:   Mon,  8 May 2023 15:50:19 -1000
Message-Id: <20230509015032.3768622-1-tj@kernel.org>
X-Mailer: git-send-email 2.40.1
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

v2: Acked patches are applied to wq/for-6.5-cleanup-ordered. Some conversion
    patches were dropped (e.g. because they were using WQ_SYSFS and thus
    can't be ordered) and fixed. The final patch to remove implicit ordered
    promotion logic was broken and could trigger WARN spuriously. Fixed.

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
and contains the following 13 patches on top of wq/for-6.5-cleanup-ordered
branch.

 0001-scsi-ncr53c8xx-Use-default-max_active-for-hostdata-w.patch
 0002-wifi-mwifiex-Use-default-max_active-for-workqueues.patch
 0003-dm-integrity-Use-alloc_ordered_workqueue-to-create-o.patch
 0004-media-amphion-Use-alloc_ordered_workqueue-to-create-.patch
 0005-wifi-ath10-11-12k-Use-alloc_ordered_workqueue-to-cre.patch
 0006-net-wwan-t7xx-Use-alloc_ordered_workqueue-to-create-.patch
 0007-soc-qcom-qmi-Use-alloc_ordered_workqueue-to-create-o.patch
 0008-btrfs-Use-alloc_ordered_workqueue-to-create-ordered-.patch
 0009-net-qrtr-Use-alloc_ordered_workqueue-to-create-order.patch
 0010-rxrpc-Use-alloc_ordered_workqueue-to-create-ordered-.patch
 0011-crypto-octeontx2-Use-alloc_ordered_workqueue-to-crea.patch
 0012-media-coda-Use-alloc_ordered_workqueue-to-create-ord.patch
 0013-workqueue-Don-t-implicitly-make-UNBOUND-workqueues-w.patch

0001-0012 convert the existing users and 0013 drops the implicit ordered
promotion logic from alloc_workqueue(). I'll keep an eye out for a while
after merging 0022. Thankfully, these are pretty easy to grep for. The
patches can also be found in the following git branch.

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git cleanup-ordered-v2

diffstat follows. Thanks.

 drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c |   12 ++++++------
 drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c |    6 +++---
 drivers/md/dm-integrity.c                          |    4 ++--
 drivers/md/dm.c                                    |    2 +-
 drivers/media/platform/amphion/vpu_core.c          |    2 +-
 drivers/media/platform/amphion/vpu_v4l2.c          |    2 +-
 drivers/media/platform/chips-media/coda-common.c   |    2 +-
 drivers/net/wireless/ath/ath10k/qmi.c              |    3 +--
 drivers/net/wireless/ath/ath11k/qmi.c              |    3 +--
 drivers/net/wireless/ath/ath12k/qmi.c              |    3 +--
 drivers/net/wireless/marvell/mwifiex/cfg80211.c    |    4 ++--
 drivers/net/wireless/marvell/mwifiex/main.c        |    8 ++++----
 drivers/net/wwan/t7xx/t7xx_hif_cldma.c             |   13 +++++++------
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c         |    5 +++--
 drivers/scsi/NCR5380.c                             |    2 +-
 drivers/soc/qcom/qmi_interface.c                   |    2 +-
 fs/btrfs/disk-io.c                                 |    2 +-
 fs/btrfs/scrub.c                                   |    6 ++++--
 include/linux/workqueue.h                          |    4 +---
 kernel/workqueue.c                                 |   23 ++++-------------------
 net/qrtr/ns.c                                      |    2 +-
 net/rxrpc/af_rxrpc.c                               |    2 +-
 22 files changed, 48 insertions(+), 64 deletions(-)

