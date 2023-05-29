Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACDA47147C8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 12:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbjE2KPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 06:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbjE2KPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 06:15:49 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3CBC4
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 03:15:47 -0700 (PDT)
X-QQ-mid: bizesmtp84t1685355326tejjficc
Received: from localhost.localdomain ( [221.226.144.218])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 29 May 2023 18:15:25 +0800 (CST)
X-QQ-SSF: 01200000000000304000000A0000000
X-QQ-FEAT: q+EIYT+FhZoX3l1jn5qzJL6M/L6SLyhFd6WSXwZbekqfsXe4BK/504CJqpwHH
        IpLCLDhljGvBZdLZQPpV4TuS3K5Vgydh9hUyyHE0in0H2h0iDbvPLIkYWfRod6+709bClut
        7U7WCHCspLZe5UE0Dl+RkckTmtarCPxWRO811vkH37tuNSukWQoGDh2WWWjWomL+kDVNe7P
        UXXyDvH6Tq63uzsMcZ2gyJmRn/TzefecAQfO+7CCaDf3YMX91crBfA4WwrHtAud+w/3rAIZ
        N4zYz1wsO1AXf6LltY5zPRq/VaJlJJGeALqkXPZTX2aTsjVodht05cMO8z65Ldp+fck1Q3g
        hC2ZTZYZJ3TUd/n3mJ3pfG7R7FUU9hGTlYYgAsT
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13277533693592484538
From:   Song Shuai <songshuaishuai@tinylab.org>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, conor@kernel.org, suagrfillet@gmail.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Song Shuai <songshuaishuai@tinylab.org>
Subject: [PATCH] riscv: Enable ARCH_SUSPEND_POSSIBLE for s2idle
Date:   Mon, 29 May 2023 18:15:24 +0800
Message-Id: <20230529101524.322076-1-songshuaishuai@tinylab.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With this configuration opened, the basic platform-independent s2idle is
provided by the sole "s2idle" string in `/sys/power/mem_sleep`.

At the end of s2idle, harts will hit the `wfi` instruction or enter the
SUSPENDED state through the sbi_cpuidle driver. The interrupt of possible
wakeup devices will be kept to wake the system up.

And platform-specific sleep states can be provided by future ACPI and
SBI SUSP extension support.

Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
---
 arch/riscv/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 348c0fa1fc8c..4bb818035585 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -805,6 +805,9 @@ config ARCH_HIBERNATION_POSSIBLE
 config ARCH_HIBERNATION_HEADER
 	def_bool HIBERNATION
 
+config ARCH_SUSPEND_POSSIBLE
+	def_bool y
+
 endmenu # "Power management options"
 
 menu "CPU Power Management"
-- 
2.20.1

