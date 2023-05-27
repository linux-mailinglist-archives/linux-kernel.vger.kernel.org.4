Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8687132A9
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 07:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjE0FrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 01:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjE0FrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 01:47:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C98114
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 22:47:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32E8F60F18
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 05:47:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB3F3C433D2;
        Sat, 27 May 2023 05:46:54 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Juxin Gao <gaojuxin@loongson.cn>
Subject: [PATCH 0/2] Add machanism to limit msi allocation for Loongson
Date:   Sat, 27 May 2023 13:46:31 +0800
Message-Id: <20230527054633.704916-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Loongson machines can have as many as 256 logical cpus, but the maximum
of msi vectors in one irqchip is also 256 (practically that is less than
256, because pch-pic consumes some of them). Even on a 64-core machine,
256 irqs can be easily exhausted if there are several NICs (NICs usually
allocate msi irqs depending on the number of online cpus). So we want to
limit the msi allocation.

Patch-1 adjusts the return value semanteme of msi_domain_prepare_irqs(),
allowing us to modify the input "nvec" by overriding the msi_domain_ops
::msi_prepare().
    
Patch-2 adds a machanism to limit msi allocation:
1, Modify input "nvec" by overriding the msi_domain_ops::msi_prepare();
2, The default limit is 256, which is compatible with the old behavior;
3, Add a cmdline parameter "loongson_msi_limit=xxx" to control the limit.

Huacai Chen and Juxin Gao(2):
 PCI: Omit pci_disable_device() in .shutdown().
 PCI: loongson: Improve the MRRS quirk for LS7A.

Signed-off-by: Juxin Gao <gaojuxin@loongson.cn> 
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
2.27.0

