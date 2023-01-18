Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8298671BCB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 13:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjARMSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 07:18:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjARMQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 07:16:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A4C88745;
        Wed, 18 Jan 2023 03:38:41 -0800 (PST)
Date:   Wed, 18 Jan 2023 11:38:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674041920;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J4rOdGazLwqJl2droFxjKDvA7hJVxHlo7hiVAnNC8uw=;
        b=MxYy96mDPDSBhRSjNdIee+SYI+8E/4axNZH9efBsFaI4/lHEVeaPWxh3hZcwipzKASYxbH
        JGHDVgINZp0A/wwBdeSySAbQXaRdWR9F9U7d0L6ym4iEI8rQPXUDvKVqDX+qyeZKsrPTJU
        nSf1923Iud6rvn/gdz+XY1hYvvY7gjaHv2z6nG3ioo49JZ7c3A0ZVgccxERjqLu1HBobUd
        QdODkQheO6OdqKebXnTgrrys5qxAo+kJ2mSbQXAoSUtN7I1FvU9j4qswBtdTstnNF3prpb
        jxYLAd9X/sVvplEW26iOnuztGXVEET3WPiTStUF4DOI/CMCZLquweZNGXIE1Lw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674041920;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J4rOdGazLwqJl2droFxjKDvA7hJVxHlo7hiVAnNC8uw=;
        b=DNXEYM961ypvgCEXd2vf3uV8GGcJzFJ5ajINOwdMXyq0zp7eGmHl4+wHCvGwu1jQnOJmQD
        QYHEP6JR9q4s8YAQ==
From:   "tip-bot2 for Guangju Wang[baidu]" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode: Use the DEVICE_ATTR_RO() macro
Cc:     "Guangju Wang[baidu]" <wgj900@163.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230118023554.1898-1-wgj900@163.com>
References: <20230118023554.1898-1-wgj900@163.com>
MIME-Version: 1.0
Message-ID: <167404192010.4906.907537462344732818.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     59047d942bedc4ce88a2121a9f9e656b9532dd30
Gitweb:        https://git.kernel.org/tip/59047d942bedc4ce88a2121a9f9e656b9532dd30
Author:        Guangju Wang[baidu] <wgj900@163.com>
AuthorDate:    Wed, 18 Jan 2023 10:35:54 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 18 Jan 2023 12:02:20 +01:00

x86/microcode: Use the DEVICE_ATTR_RO() macro

Use DEVICE_ATTR_RO() helper instead of open-coded DEVICE_ATTR(),
which makes the code a bit shorter and easier to read.

No change in functionality.

Signed-off-by: Guangju Wang[baidu] <wgj900@163.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230118023554.1898-1-wgj900@163.com
---
 arch/x86/kernel/cpu/microcode/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 712aaff..99abb31 100644
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
