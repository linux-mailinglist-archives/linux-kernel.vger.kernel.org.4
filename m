Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8074867113D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 03:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjARCg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 21:36:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjARCg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 21:36:57 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB5D04FAE3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 18:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=FsRc3
        dlPiXgB3LAPOlDQBAkajjF4w8XOLXJBAk9YV2g=; b=oGBXlAHdCmM+qEztlkGMX
        8bumnnMIXcid4d9LNV2urZhqIfsmmTXzzjG6nTXBwVXb9lbww8nLWEgUU/Gxieey
        8Pf9bBouL6XteQvZbC3UUF0LQGE6nS9NDyZ7yrvk35j72i3E7Wua6/7umJ7jXyo7
        puyLjQCiRjk6wb06CZh0MU=
Received: from FB9D8C53FFFC188.internal.baidu.com (unknown [111.206.214.32])
        by zwqz-smtp-mta-g2-4 (Coremail) with SMTP id _____wDnVtsPW8djvAoSAw--.61937S2;
        Wed, 18 Jan 2023 10:35:59 +0800 (CST)
From:   Guangju Wang <wgj900@163.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/microcode: Use DEVICE_ATTR_RO macro
Date:   Wed, 18 Jan 2023 10:35:54 +0800
Message-Id: <20230118023554.1898-1-wgj900@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDnVtsPW8djvAoSAw--.61937S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zw1DCry8WrW7GF17CF1xXwb_yoW8Gr1fpF
        15Gay8KF48W3WDAa95Xrs7Zry5Aw1jg34fXws2gwn3K3W3t3srXa4xA34avry5u34rKa1S
        gFZ2vFyxAFWxCrJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j0_M-UUUUU=
X-Originating-IP: [111.206.214.32]
X-CM-SenderInfo: pzjmmiqq6rljoofrz/1tbiMBf6tlWB0aDO9AAAs0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Guangju Wang[baidu]" <wgj900@163.com>

Use DEVICE_ATTR_RO() helper instead of plain DEVICE_ATTR(),
which makes the code a bit shorter and easier to read.

Signed-off-by: Guangju Wang[baidu] <wgj900@163.com>
---
 arch/x86/kernel/cpu/microcode/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 712aafff96e0..99abb318aa7f 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -507,7 +507,7 @@ static ssize_t version_show(struct device *dev,
 	return sprintf(buf, "0x%x\n", uci->cpu_sig.rev);
 }
 
-static ssize_t pf_show(struct device *dev,
+static ssize_t processor_flags_show(struct device *dev,
 			struct device_attribute *attr, char *buf)
 {
 	struct ucode_cpu_info *uci = ucode_cpu_info + dev->id;
@@ -515,8 +515,8 @@ static ssize_t pf_show(struct device *dev,
 	return sprintf(buf, "0x%x\n", uci->cpu_sig.pf);
 }
 
-static DEVICE_ATTR(version, 0444, version_show, NULL);
-static DEVICE_ATTR(processor_flags, 0444, pf_show, NULL);
+static DEVICE_ATTR_RO(version);
+static DEVICE_ATTR_RO(processor_flags);
 
 static struct attribute *mc_default_attrs[] = {
 	&dev_attr_version.attr,
-- 
2.25.1

