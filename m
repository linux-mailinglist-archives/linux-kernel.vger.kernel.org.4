Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28AEF5E9820
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 05:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbiIZDCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 23:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233248AbiIZDCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 23:02:05 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857CA2C117;
        Sun, 25 Sep 2022 20:02:03 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MbS8q6skqzHtnq;
        Mon, 26 Sep 2022 10:57:15 +0800 (CST)
Received: from dggpeml500008.china.huawei.com (7.185.36.147) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 11:02:01 +0800
Received: from huawei.com (10.67.175.34) by dggpeml500008.china.huawei.com
 (7.185.36.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 26 Sep
 2022 11:02:01 +0800
From:   Ren Zhijie <renzhijie2@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <ben-linux@fluff.org>
CC:     <linux-serial@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Ren Zhijie" <renzhijie2@huawei.com>
Subject: [PATCH -next] serial: stm32: Fix unused-variable warning
Date:   Mon, 26 Sep 2022 02:58:26 +0000
Message-ID: <20220926025826.44145-1-renzhijie2@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.175.34]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500008.china.huawei.com (7.185.36.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_SERIAL_EARLYCON and CONFIG_OF are both not set,
gcc warns about unused variable:

drivers/tty/serial/stm32-usart.c:83:32: error: ‘stm32h7_info’ defined but not used [-Werror=unused-variable]
 static struct stm32_usart_info stm32h7_info = {
                                ^~~~~~~~~~~~
drivers/tty/serial/stm32-usart.c:61:32: error: ‘stm32f7_info’ defined but not used [-Werror=unused-variable]
 static struct stm32_usart_info stm32f7_info = {
                                ^~~~~~~~~~~~
drivers/tty/serial/stm32-usart.c:40:32: error: ‘stm32f4_info’ defined but not used [-Werror=unused-variable]
 static struct stm32_usart_info stm32f4_info = {
                                ^~~~~~~~~~~~
cc1: all warnings being treated as errors

Mark these variables as __maybe_unused  to fix this.

Fixes: c7039ce904c0 ("serial: stm32: make info structs static to avoid sparse warnings")
Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>
---
 drivers/tty/serial/stm32-usart.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 0b18615b2ca4..22013b12f471 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -37,7 +37,7 @@
 
 
 /* Register offsets */
-static struct stm32_usart_info stm32f4_info = {
+static struct stm32_usart_info __maybe_unused stm32f4_info = {
 	.ofs = {
 		.isr	= 0x00,
 		.rdr	= 0x04,
@@ -58,7 +58,7 @@ static struct stm32_usart_info stm32f4_info = {
 	}
 };
 
-static struct stm32_usart_info stm32f7_info = {
+static struct stm32_usart_info __maybe_unused stm32f7_info = {
 	.ofs = {
 		.cr1	= 0x00,
 		.cr2	= 0x04,
@@ -80,7 +80,7 @@ static struct stm32_usart_info stm32f7_info = {
 	}
 };
 
-static struct stm32_usart_info stm32h7_info = {
+static struct stm32_usart_info __maybe_unused stm32h7_info = {
 	.ofs = {
 		.cr1	= 0x00,
 		.cr2	= 0x04,
-- 
2.17.1

