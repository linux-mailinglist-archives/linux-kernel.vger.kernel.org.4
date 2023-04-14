Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6AFC6E237E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 14:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjDNMjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 08:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjDNMjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 08:39:14 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16EC026B8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 05:39:13 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id f2so9663324pjs.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 05:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20221208.gappssmtp.com; s=20221208; t=1681475952; x=1684067952;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6HYNyUUEorOF+isbH7MLUIuEp6e49eMyp3D2Mh/QBec=;
        b=sX9xudieMQAT6uk2HyEujcuXLPGCVhLkbBS1MEggluyv2/BWsKTprUIhVNVt6ta/eD
         d98sadGF1z6Q/jfpnFqkVPTHYZbJI2PTpdLqsBjTS7+cCgAdc/8BOQHqNNqHPuJr6K89
         87mCXFZ5OFk1G0Jl7vPpBXS5iv9eOBQMlapv1bOtbl1ZPPBN/KZ/TRyvmmbjUZWP/MRM
         ytMhjPizvYkw5flS0uc35OUOggApRHBcgNjjhj1zHv+91dP05JQx/leVr7yL4zJaZQlt
         fUjct8dYbxDSu67+/cDb8jqZBQTwXnEGzsPNa4WogomhoENfUXiaDEPgIRaNfJ3nTQww
         BkGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681475952; x=1684067952;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6HYNyUUEorOF+isbH7MLUIuEp6e49eMyp3D2Mh/QBec=;
        b=kQkdTty2xhTdvjoXpd80d9ISwmvQo01yIj1TE3IM15zXe11fnIYNP/cknBwj0CNpN0
         Z38aDhCK8sY/MDhPKenhYQliId7/CsKyTBlc/2jHNPQB06ehxaylfNltRKaAqtbOXlxw
         bgUjoOcORt7JEvxuvY3sDNyjbKP7ezcIwElcj69v+XpS1TV8JyyFoHSGq7JXMCIj5v0o
         cY9hylCiEL3ghJJGE8FJiCBfp+V4i4PZPPKQcw+TAY+Rh/65aG+SCaQ54VMxpR6kSEr3
         3NEGMtF7Z0w/AqWf2xrgGZn6QHXP+2Avv0Q1L3Uy+9wBl63O8Ds7GRx/s/KH3qGWKXcL
         qY/Q==
X-Gm-Message-State: AAQBX9fto0M1XvBk2UiceacOnabVc0y6kTtWvHqXkjo+VAHhGWLPOZ3L
        e7H39jXWxVvTBzpS4JMZpz4uDg==
X-Google-Smtp-Source: AKy350YpGxzPLIwor8+DKH5UMTOv8E83Zu2LeKHX4c7FkRKlCbIlCR8cBym6UhA2y6HclkSFaFD8Zg==
X-Received: by 2002:a17:903:24d:b0:1a6:4a25:c7f7 with SMTP id j13-20020a170903024d00b001a64a25c7f7mr2653035plh.6.1681475952405;
        Fri, 14 Apr 2023 05:39:12 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id v21-20020a1709028d9500b001a527761c31sm3015366plo.79.2023.04.14.05.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 05:39:12 -0700 (PDT)
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
Subject: [RFC PATCH 0/3] Introduce a PCIe endpoint virtio console
Date:   Fri, 14 Apr 2023 21:39:00 +0900
Message-Id: <20230414123903.896914-1-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PCIe endpoint framework provides APIs to implement PCIe endpoint function.
This framework allows defining various PCIe endpoint function behaviors in
software. This patch extend the framework for virtio pci device. The
virtio is defined to communicate guest on virtual machine and host side.
Advantage of the virtio is the efficiency of data transfer and the conciseness
of implementation device using software. It also be applied to PCIe
endpoint function.

We designed and implemented a PCIe EP virtio console function driver using
the extended PCIe endpoint framework for virtio. It can be communicate
host and endpoint over virtio as console.

An architecture of the function driver is following:

 ┌────────────┐         ┌──────────────────────┬────────────┐
 │virtio      │         │                      │virtio      │
 │console drv │         ├───────────────┐      │console drv │
 ├────────────┤         │(virtio console│      ├────────────┤
 │ virtio bus │         │ device)       │◄────►│ virtio bus │
 ├────────────┤         ├---------------┤      └────────────┤
 │            │         │ pci ep virtio │                   │
 │  pci bus   │         │  console drv  │                   │
 │            │  pcie   ├───────────────┤                   │
 │            │ ◄─────► │  pci ep Bus   │                   │
 └────────────┘         └───────────────┴───────────────────┘
   PCIe Root              PCIe Endpoint

Introduced driver is `pci ep virtio console drv` in the figure. It works
as ep function for PCIe root and virtual virtio console device for PCIe
endpoint. Each side of virtio console driver has virtqueue, and
introduced driver transfers data on the virtqueue to each other. A data
on root tx queue is transfered to endpoint rx queue and vice versa.

This patchset is depend follwing patches which are under discussion.

- [RFC PATCH 0/3] Deal with alignment restriction on EP side
link: https://lore.kernel.org/linux-pci/20230113090350.1103494-1-mie@igel.co.jp/
- [RFC PATCH v2 0/7] Introduce a vringh accessor for IO memory
link: https://lore.kernel.org/virtualization/20230202090934.549556-1-mie@igel.co.jp/

First of this patchset is introduce a helper function to realize pci
virtio function using PCIe endpoint framework. The second one is adding
a missing definition for virtio pci header. The last one is for PCIe
endpoint virtio console driver.

This is tested on linux-20230406 and RCar S4 board as PCIe endpoint.

Shunsuke Mie (3):
  PCI: endpoint: introduce a helper to implement pci ep virtio function
  virtio_pci: add a definition of queue flag in ISR
  PCI: endpoint: Add EP function driver to provide virtio-console
    functionality

 drivers/pci/endpoint/functions/Kconfig        |  19 +
 drivers/pci/endpoint/functions/Makefile       |   2 +
 drivers/pci/endpoint/functions/pci-epf-vcon.c | 554 ++++++++++++++++++
 .../pci/endpoint/functions/pci-epf-virtio.c   | 469 +++++++++++++++
 .../pci/endpoint/functions/pci-epf-virtio.h   | 123 ++++
 include/uapi/linux/virtio_pci.h               |   3 +
 6 files changed, 1170 insertions(+)
 create mode 100644 drivers/pci/endpoint/functions/pci-epf-vcon.c
 create mode 100644 drivers/pci/endpoint/functions/pci-epf-virtio.c
 create mode 100644 drivers/pci/endpoint/functions/pci-epf-virtio.h

-- 
2.25.1

