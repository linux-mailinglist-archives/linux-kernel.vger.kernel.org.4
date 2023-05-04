Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7CD6F0460
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 12:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243598AbjD0Ko4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 06:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243607AbjD0Kos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 06:44:48 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FAF524F
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 03:44:46 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-63b52ad6311so9663717b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 03:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20221208.gappssmtp.com; s=20221208; t=1682592286; x=1685184286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fuOjoATSwNwQ5isXLaWbsITf7ep/YO9eHaGnk3Xv1+k=;
        b=hYqAufa4TE3E13v6DVzZqXL2LgZM3tGhzXzeC/RXQWeCPnDroXtW4401AHTsakrrdT
         YpglWLsLyen3dm0MQ1ZSumQ35y/2jEcCxe5PxefBZJNacdGnp2pc/+KWPC4QsPUeDezv
         OIkYvSC1wmhp4a7aDsv9swfYcTz3yay3GKiwRKLY+yFiT3ntA88bIc+wIWiTWy8uIY7+
         au0hiN//H59a1eX/a9u2DyAFGu4VWjqACeWmAV6pKzl+Pa+1/xEytXMTRBlMcaF4vRBU
         iG618MyM93PzNbUfej9In1yxqCTt5tmKV7cX6D1WkwqMTf6/zlT9scMIMmP2C5MediIO
         AVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682592286; x=1685184286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fuOjoATSwNwQ5isXLaWbsITf7ep/YO9eHaGnk3Xv1+k=;
        b=J8U2EBuJI6S/J/3qQPrcxGG6AvVmx3HbpfWtoFjrzveuTA0LYMCuLTKrjqe7SMw2xk
         mgHQ5+IZ7TE5JfXpUwFemPrGxW4lbS6XXtqgWkRUC9yRsNhHMhpsv0IffT8Wy6GN+Rsr
         4NRIbGfgsyHPXTPvmMx0huy+6olEa6I4lGf95rJpyHMy5tD2Y5wP0q+pXm52ORTnrKwW
         yVLokOTvYyd4Dx4aTF/huVuDnSWvUXr1ijGvou+p8nz6W+LJf8gGEJti5akaHbKQ0EqS
         lp3uMib/2YZDyQrkOp9jmFzcTNmnCvk1ojgaX4IeTgjPeqk4WcfU1C5opGp61nqXqmTF
         TZkA==
X-Gm-Message-State: AC+VfDyrPIp24y+93qT9cPtCvd4BqQIV69AZvV/sLX0Iceqok5N74Nav
        P/1NQxeAoAjPRqjlQjGyg9/VVg==
X-Google-Smtp-Source: ACHHUZ6+mO8MNfDjediiWb04QBeKKlGEKAVthfq82g/F9dpwMpBpxs0PCUGgTwMThDQwB6uxdelnbw==
X-Received: by 2002:a05:6a20:3c8b:b0:f2:93b7:a452 with SMTP id b11-20020a056a203c8b00b000f293b7a452mr1632523pzj.4.1682592285840;
        Thu, 27 Apr 2023 03:44:45 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id b3-20020a631b03000000b0050f93a3586fsm11029042pgb.37.2023.04.27.03.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 03:44:45 -0700 (PDT)
From:   Shunsuke Mie <mie@igel.co.jp>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Shunsuke Mie <mie@igel.co.jp>, Frank Li <Frank.Li@nxp.com>,
        Jon Mason <jdmason@kudzu.us>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ren Zhijie <renzhijie2@huawei.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [RFC PATCH v2 2/3] virtio_pci: add a definition of queue flag in ISR
Date:   Thu, 27 Apr 2023 19:44:27 +0900
Message-Id: <20230427104428.862643-3-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230427104428.862643-1-mie@igel.co.jp>
References: <20230427104428.862643-1-mie@igel.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Already it has beed defined a config changed flag of ISR, but not the queue
flag. Add a macro for it.

Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
 include/uapi/linux/virtio_pci.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
index f703afc7ad31..d405bea27240 100644
--- a/include/uapi/linux/virtio_pci.h
+++ b/include/uapi/linux/virtio_pci.h
@@ -94,6 +94,9 @@
 
 #endif /* VIRTIO_PCI_NO_LEGACY */
 
+/* Bits for ISR status field:only when if MSI-X is disabled */
+/* The bit of the ISR which indicates a queue entry update. */
+#define VIRTIO_PCI_ISR_QUEUE		0x1
 /* The bit of the ISR which indicates a device configuration change. */
 #define VIRTIO_PCI_ISR_CONFIG		0x2
 /* Vector value used to disable MSI for queue */
-- 
2.25.1

