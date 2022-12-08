Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539B4646BF9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 10:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiLHJd0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 8 Dec 2022 04:33:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiLHJdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 04:33:23 -0500
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA1759FDE;
        Thu,  8 Dec 2022 01:33:16 -0800 (PST)
X-QQ-mid: bizesmtp80t1670491970tmadzmjb
Received: from [192.168.3.2] ( [111.196.135.79])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 08 Dec 2022 17:32:48 +0800 (CST)
X-QQ-SSF: 01200000000000B0B000000A0000000
X-QQ-FEAT: zX46NWeZQGEPkwa09vvX1e9B/NktWgMjOM4wpw+/LIo80yqhwau4SCVAglcsW
        9vsBVIHhCU9XlW9C/ACb/6mMlDXDUOlYQ36EXhCDA5boUGbllxcBEHLmNSXc2s3hXMCbtf0
        RTJXfEdQWQnUzHr/ri13d1YrvY8+oCMmAwqK7DoYT8tcO0NqZQXJnA4B70etX7aItOsQjwY
        M1wXkiYNJ0lqlMmHeQU388p4klUI6z3WLOtdfra37UihjKn0gZIuNhijHRPBp4wCt/SnebH
        A652eiO6RR81OjgRhHYJSzeQ4MVQ9ACl5U2OHqBJTiMJLIc6q80/PBAtBa059m2JzfICZ2j
        jwbaEhlvS3fBLJJ0QY=
X-QQ-GoodBg: 0
From:   "Bin Meng" <bmeng@tinylab.org>
To:     "Jiri Slaby" <jirislaby@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] serial: earlycon-arm-semihost: Move smh_putc() variants in
 respective arch's semihost.h
Cc:     "catalin.marinas" <catalin.marinas@arm.com>,
        gregkh <gregkh@linuxfoundation.org>,
        linux <linux@armlinux.org.uk>, will <will@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Date:   Thu, 08 Dec 2022 09:32:48 +0000
Message-Id: <em14380c7e-ee2b-45d5-8879-dde687f03b2b@eea79fc7.com>
In-Reply-To: <0443d5e9-b2ce-7e6b-c69b-708d67a5bf97@kernel.org>
References: <20221207135352.592556-1-bmeng@tinylab.org>
 <0443d5e9-b2ce-7e6b-c69b-708d67a5bf97@kernel.org>
Reply-To: "Bin Meng" <bmeng@tinylab.org>
User-Agent: eM_Client/9.2.1222.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvr:qybglogicsvr3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/8 14:08:33, "Jiri Slaby" <jirislaby@kernel.org> wrote:

>On 07. 12. 22, 14:53, Bin Meng wrote:
>>Move smh_putc() variants in respective arch/*/include/asm/semihost.h,
>>in preparation to add RISC-V support.
>>
>>Signed-off-by: Bin Meng <bmeng@tinylab.org>
>...
>>--- /dev/null
>>+++ b/arch/arm/include/asm/semihost.h
>>@@ -0,0 +1,23 @@
>>+/* SPDX-License-Identifier: GPL-2.0 */
>>+/*
>>+ * Copyright (C) 2012 ARM Ltd.
>>+ * Author: Marc Zyngier <marc.zyngier@arm.com>
>>+ *
>>+ * Adapted for ARM and earlycon:
>>+ * Copyright (C) 2014 Linaro Ltd.
>>+ * Author: Rob Herring <robh@kernel.org>
>>+ */
>
>Much better. There are three minor issues:
>1) protection against multiple #include-s is missing here.

Oops, will add in v3.

>
>
>>+#ifdef CONFIG_THUMB2_KERNEL
>>+#define SEMIHOST_SWI	"0xab"
>>+#else
>>+#define SEMIHOST_SWI	"0x123456"
>>+#endif
>>+
>>+static inline void smh_putc(struct uart_port *port, unsigned char c)
>
>2) port is unused in all implementations. So it should be dropped.
>3) can you make "c" an explicit u8?

The smh_putc function signature is defined by the uart_console_write 
helper. I don't think we can change it.

>
>>+{
>>+	asm volatile("mov  r1, %0\n"
>>+		     "mov  r0, #3\n"
>>+		     "svc  " SEMIHOST_SWI "\n"
>>+		     : : "r" (&c) : "r0", "r1", "memory");
>>+}

Regards,
Bin
