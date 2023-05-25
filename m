Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19EF6710321
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 04:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237374AbjEYC5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 22:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjEYC5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 22:57:48 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4724213A
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 19:57:44 -0700 (PDT)
X-QQ-mid: bizesmtp63t1684983436tc4md4by
Received: from localhost.localdomain ( [221.226.144.218])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 25 May 2023 10:57:13 +0800 (CST)
X-QQ-SSF: 01200000000000303000000A0000000
X-QQ-FEAT: jXjag1m6xl5ZXRPvlfx7FOzns583Qa4+KA3B6kg49g6czQo1AbT32d+KPrxfJ
        cmTlBr1DnsRyQbPDfKLGciMk4B+ylpOzsOX9RctduYLeEuAlmq3E4sKqYDVfFaw3cfqE12o
        gVQCC2bD77/rUkQERGv3c8q3Pdpmr/Re0hCdHFBb8aoXMeALLHzg1HGymZHQ4pyy9AiadRT
        GzJtw8hLQcWzaK8WWd4Jrebu8d3OZaVHCQWP3TEYqZ/NpQ/3Ca8xG5DZSdH3vd7cTEGx5tA
        68Lr6WidVIkVvna98ZlnltddOPkyhLIU7kqoI+O+w+yDmu5sv4ksyG2yTbgofNf3x1CuPZs
        wKRROMB8p3ftAGiD+3zDxXtcb7o7DR3omGM25n6AWxR9d/vzsFxxjG13oeWybHUksvhorRL
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13095273285713463459
From:   Song Shuai <songshuaishuai@tinylab.org>
To:     catalin.marinas@arm.com, will@kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, chris@zankel.net,
        jcmvbkbc@gmail.com, songshuaishuai@tinylab.org,
        steven.price@arm.com, vincenzo.frascino@arm.com, pcc@google.com,
        wangxiang@cdjrlc.com, ajones@ventanamicro.com,
        conor.dooley@microchip.com, jeeheng.sia@starfivetech.com,
        leyfoon.tan@starfivetech.com
Cc:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH 3/4] riscv: hibernate: remove WARN_ON in save_processor_state
Date:   Thu, 25 May 2023 10:55:54 +0800
Message-Id: <20230525025555.24104-4-songshuaishuai@tinylab.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230525025555.24104-1-songshuaishuai@tinylab.org>
References: <20230525025555.24104-1-songshuaishuai@tinylab.org>
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

During hibernation or restoration, freeze_secondary_cpus
checks num_online_cpus via BUG_ON, and the subsequent
save_processor_state also does the checking with WARN_ON.

So remove the unnecessary checking in save_processor_state.

Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
---
 arch/riscv/kernel/hibernate.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/kernel/hibernate.c b/arch/riscv/kernel/hibernate.c
index 395f835f067c..86f1c9ab6b0b 100644
--- a/arch/riscv/kernel/hibernate.c
+++ b/arch/riscv/kernel/hibernate.c
@@ -119,7 +119,6 @@ int pfn_is_nosave(unsigned long pfn)
 
 void notrace save_processor_state(void)
 {
-	WARN_ON(num_online_cpus() != 1);
 }
 
 void notrace restore_processor_state(void)
-- 
2.20.1

