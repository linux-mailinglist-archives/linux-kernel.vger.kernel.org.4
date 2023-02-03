Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A72A6894C2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 11:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbjBCKFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 05:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbjBCKEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 05:04:51 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D735B23119
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 02:04:31 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id 144so3162843pfv.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 02:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqPOa6wQ7me1yaZ8gWql2+REBdfg2nWO86T9Pc9DfW4=;
        b=JTIWKvUBIafMXOXAwc5zu2jHnnG/zaLppVGuVMB3fRUCLIHSZaQjW7WBErdSad8Nf2
         Y7QmZCVReYCUEF5lS+pVLUizADK3zOavCz3cOrNBj8GLcxWP5cxEm7rJCn6ItoVliBi6
         lcKWfrPNPeNRTj74y1vbst6LBm+f9aZWrah8AUR/P+C98SVcjoRQGpMNsPM7WSo7AmNy
         JmM4wG4D2ADLxi3UDyVCMJcI13G/vJRDdQ1ijc4redm6X7jcVkB9FkFB7LgVLZFc/SKk
         iCSyl+CF2tZi0IkwTHPTV1DfE4XvJAJXZg1yPsDgPSZ1T+W/Xq63z73Twbv6F37RKok/
         wvWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vqPOa6wQ7me1yaZ8gWql2+REBdfg2nWO86T9Pc9DfW4=;
        b=ADyMQVoErK5msbeMD+lNcl/85E6bRRY4hMBJKZTQWRx6/uJgizXncAja30u5VVhApm
         7cjenJ2u18FBJ33gSTsgLoNXUDnYARFbVhHN4O26ju86Ci/GruCeoIEHskyIKy1ZfSrZ
         FS+g2llrm/NuPD5qL3Z9B1BmFEzXtcnfDoOpMMb+SIGmKbxdqj+wzGuUpdNiYJss/+3L
         8qLhl/2uQUMcPv81x51blGYTSIcRYbSU1TAmiSoV4ANQUJi44GNRD3o80PuNhAG2uka6
         SIrV/KlLIyHHd4V2NGKyVAo7zeiTQzl+1J7P7AWRm0jhQO96zFhU3y84ThxAihHUGbc6
         p/hA==
X-Gm-Message-State: AO0yUKUi3uAxd2YePnQ/hViXOUfkZCR3mVKV9iNyGQZjsi0j3gJnhm0T
        PRo3kIZugWLZMi/D2AGmQFd4Qg==
X-Google-Smtp-Source: AK7set8Y4kcnE70IRY7UtJdoEwFc/ieWHA4OwVMuzDLqXN/hzEi8OHAQTbL4MZdtSXQdly1zS67Qcw==
X-Received: by 2002:a05:6a00:2409:b0:593:5e76:b0 with SMTP id z9-20020a056a00240900b005935e7600b0mr9875294pfh.2.1675418671319;
        Fri, 03 Feb 2023 02:04:31 -0800 (PST)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id d3-20020aa797a3000000b0058d8f23af26sm1278885pfq.157.2023.02.03.02.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 02:04:31 -0800 (PST)
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
        Ren Zhijie <renzhijie2@huawei.com>,
        Takanari Hayama <taki@igel.co.jp>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [RFC PATCH 1/4] virtio_pci: add a definition of queue flag in ISR
Date:   Fri,  3 Feb 2023 19:04:15 +0900
Message-Id: <20230203100418.2981144-2-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230203100418.2981144-1-mie@igel.co.jp>
References: <20230203100418.2981144-1-mie@igel.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Already it has beed defined a config changed flag of ISR, but not the queue
flag. Add a macro for it.

Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
Signed-off-by: Takanari Hayama <taki@igel.co.jp>
---
 include/uapi/linux/virtio_pci.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
index f703afc7ad31..fa82afd6171a 100644
--- a/include/uapi/linux/virtio_pci.h
+++ b/include/uapi/linux/virtio_pci.h
@@ -94,6 +94,8 @@
 
 #endif /* VIRTIO_PCI_NO_LEGACY */
 
+/* Ths bit of the ISR which indicates a queue entry update */
+#define VIRTIO_PCI_ISR_QUEUE		0x1
 /* The bit of the ISR which indicates a device configuration change. */
 #define VIRTIO_PCI_ISR_CONFIG		0x2
 /* Vector value used to disable MSI for queue */
-- 
2.25.1

