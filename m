Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33CB95BD6A8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 23:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiISV4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 17:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiISV4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 17:56:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6412740BE5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 14:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663624560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=vk1Ze0QikRNRp6V9q10zrhsQU9uIHN6Gzr8BWetL4M8=;
        b=hEF9jh4wr0sNc4ar9ubVlO+OBIaI9w4s8QcYShefyyYDKKs+qgmvXim5/9l6QATnO3NgW4
        8v1g0QeQ3F+FyMmrWNcNAUVo6MdfTIxXfBdiOw28oC0tprblZiubNJP3oXro7CP5Xl22HE
        yJr9pXb5jBEZg0r1ENXhPIwqTw1t0ac=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-646-sgwP5cssOQGpB1FOwovw7w-1; Mon, 19 Sep 2022 17:55:56 -0400
X-MC-Unique: sgwP5cssOQGpB1FOwovw7w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A2B3E857F92;
        Mon, 19 Sep 2022 21:55:55 +0000 (UTC)
Received: from cantor.redhat.com (unknown [10.2.16.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E73C440C2064;
        Mon, 19 Sep 2022 21:55:54 +0000 (UTC)
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 0/2] dmaengine: idxd: Fix up re-enabling device workqueues
Date:   Mon, 19 Sep 2022 14:55:51 -0700
Message-Id: <20220919215553.600246-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently if a software reset is attempted on an idxd device
the workqueues will not be re-enabled, because it will see
incorrectly see that wq->state is already set to IDXD_WQ_ENABLED.
So set the workqueue state to disabled in idxd_wq_disable_cleanup(),
and use a bitmap to track which workqueues have been enabled so they
can be re-enabled during device re-initialization.

Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Vinod Koul <vkoul@kernel.org>

Jerry Snitselaar (2):
  dmaengine: idxd: Set wq state to disabled in idxd_wq_disable_cleanup()
  dmaengine: idxd: track enabled workqueues in bitmap

 drivers/dma/idxd/device.c | 4 +++-
 drivers/dma/idxd/idxd.h   | 2 ++
 drivers/dma/idxd/init.c   | 6 ++++++
 drivers/dma/idxd/irq.c    | 4 ++--
 drivers/dma/idxd/sysfs.c  | 1 +
 5 files changed, 14 insertions(+), 3 deletions(-)

-- 
2.37.2

