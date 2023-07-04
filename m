Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD277472A2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 15:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjGDNVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 09:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbjGDNVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 09:21:19 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3FF4210E0;
        Tue,  4 Jul 2023 06:21:10 -0700 (PDT)
Received: from loongson.cn (unknown [10.2.9.158])
        by gateway (Coremail) with SMTP id _____8DxxPDFHKRkuQYAAA--.96S3;
        Tue, 04 Jul 2023 21:21:09 +0800 (CST)
Received: from kvm-1-158.loongson.cn (unknown [10.2.9.158])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxbSPEHKRk7zYbAA--.34335S3;
        Tue, 04 Jul 2023 21:21:08 +0800 (CST)
From:   Bibo Mao <maobibo@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jianmin Lv <lvjianmin@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
Subject: [PATCH 1/2] irqchip/loongson-eiointc: fix return value checking of eiointc_index
Date:   Tue,  4 Jul 2023 21:21:07 +0800
Message-Id: <20230704132108.1096940-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230704132108.1096940-1-maobibo@loongson.cn>
References: <20230704132108.1096940-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxbSPEHKRk7zYbAA--.34335S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tFW3Zr4DCFyfZF1fZr4kZrc_yoW8JFyUpF
        W3AFZFvr15Wa4xCrZrKF48JryYyws3t3y7tayxJay7XFs8J34DJr4rA3Z0yr10krW3uFy2
        gF4rXFWUC3Z8AwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUU9jb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4j6r4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
        Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_
        Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
        xGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWU
        XVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
        kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY
        6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
        vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2Kfnx
        nUUI43ZEXa7IU8q2NtUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

return value of function eiointc_index is int, however it is
converted uint32_t when used. This causes logic problem when
checking return value. There is eioi initial problem on qemu
virt-machine where there is only one eioi node and more than 4
vcpus, external device intr can only be routed to vcpu 0-3.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 drivers/irqchip/irq-loongson-eiointc.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
index 92d8aa28bdf5..1c5a5b59f199 100644
--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -144,12 +144,14 @@ static int eiointc_router_init(unsigned int cpu)
 	int i, bit;
 	uint32_t data;
 	uint32_t node = cpu_to_eio_node(cpu);
-	uint32_t index = eiointc_index(node);
+	int index = eiointc_index(node);
 
-	if (index < 0) {
-		pr_err("Error: invalid nodemap!\n");
-		return -1;
-	}
+	/*
+	 * qemu virt-machine has only one eio intc and more than four cpus
+	 * irq from eio can only be routed to cpu 0-3 on virt machine
+	 */
+	if (index < 0)
+		return 0;
 
 	if ((cpu_logical_map(cpu) % CORES_PER_EIO_NODE) == 0) {
 		eiointc_enable();
-- 
2.27.0

