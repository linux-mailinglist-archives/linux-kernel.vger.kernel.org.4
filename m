Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B670654E2C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 10:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236108AbiLWJMf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 23 Dec 2022 04:12:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236051AbiLWJM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 04:12:29 -0500
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CADF3137A;
        Fri, 23 Dec 2022 01:12:26 -0800 (PST)
X-QQ-mid: bizesmtp81t1671786703twus74c8
Received: from [192.168.3.2] ( [111.196.135.79])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 23 Dec 2022 17:11:41 +0800 (CST)
X-QQ-SSF: 01200000002000C0C000B00A0000000
X-QQ-FEAT: Qawnk02X7V/3XgZ2fM/jaE0BV64IhsybXxGbCgGgdSjq/pQgCE9fY4YxKS69I
        lDjwVxohnmpJtxN9bWL0Y5nR8nj2NtA0rw4Hxb2AjPqO+R1Ck65jLpoRASyyBBuqOjhXI0o
        bTNSgmMn0vS6HN5AfKKREc1jChYjO1pBJLE+Z+29XjVr6DbqivZoWNsZ3UnLf5XQmr+G/ft
        w3snpVgKBYGtqmYA7Lcs59ndbseq90J9dRVcaemaRNSJpOS1ZsP0pNwvMTtinmQwH+D4iPu
        DImOuCqmvDV8VsLzo0SNgk2vHCJ+rWdoJ0rWrZxXQjIBDZj9nk9VxKe9JxFz33/o/8KDYiV
        MsY1vptl+ym8KpBypAMM+t6v7Jf46ypq+O+WNkK
X-QQ-GoodBg: 0
From:   "Bin Meng" <bmeng@tinylab.org>
To:     "Sergey Matyukevich" <geomatsi@gmail.com>
Subject: Re: [PATCH v3 0/3] serial: Add RISC-V support to the earlycon semihost driver
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        aou <aou@eecs.berkeley.edu>,
        "catalin.marinas" <catalin.marinas@arm.com>,
        gregkh <gregkh@linuxfoundation.org>,
        jirislaby <jirislaby@kernel.org>, palmer <palmer@dabbelt.com>,
        "paul.walmsley" <paul.walmsley@sifive.com>,
        linux <linux@armlinux.org.uk>, will <will@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Date:   Fri, 23 Dec 2022 09:11:42 +0000
Message-Id: <em1edb1bed-77fc-4deb-9de1-7f35bc962d0e@a9022134.com>
In-Reply-To: <Y6S4v7t0n0BI1P7d@curiosity>
References: <20221209150437.795918-1-bmeng@tinylab.org> <Y6S4v7t0n0BI1P7d@curiosity>
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

Hi Sergey,

On 2022/12/23 4:06:23, "Sergey Matyukevich" <geomatsi@gmail.com> wrote:

>Hi Bin,
>
>>  RISC-V semihosting spec [1] is built on top of the existing Arm one;
>>  we can add RISC-V earlycon semihost driver easily.
>>
>>  This series refactors the existing driver a little bit, to move smh_putc()
>>  variants in respective arch's semihost.h, then we can implement RISC-V's
>>  version in the riscv arch directory.
>>
>>  Link: https://github.com/riscv/riscv-semihosting-spec/blob/main/riscv-semihosting-spec.adoc [1]
>>
>>  Changes in v3:
>>  - add #ifdef in the header to prevent from multiple inclusion
>>  - add forward-declare struct uart_port
>>  - add a Link tag in the commit message
>>
>>  Changes in v2:
>>  - new patch: "serial: earlycon-arm-semihost: Move smh_putc() variants in respective arch's semihost.h"
>>  - Move the RISC-V implementation to semihost.h
>>
>>  Bin Meng (3):
>>    serial: earlycon-arm-semihost: Move smh_putc() variants in respective
>>      arch's semihost.h
>>    riscv: Implement semihost.h for earlycon semihost driver
>>    serial: Rename earlycon semihost driver
>>
>>   arch/arm/include/asm/semihost.h               | 30 +++++++++++++++++++
>>   arch/arm64/include/asm/semihost.h             | 24 +++++++++++++++
>>   arch/riscv/include/asm/semihost.h             | 26 ++++++++++++++++
>>   drivers/tty/serial/Kconfig                    | 14 ++++-----
>>   drivers/tty/serial/Makefile                   |  2 +-
>>   ...con-arm-semihost.c => earlycon-semihost.c} | 25 +---------------
>>   6 files changed, 89 insertions(+), 32 deletions(-)
>>   create mode 100644 arch/arm/include/asm/semihost.h
>>   create mode 100644 arch/arm64/include/asm/semihost.h
>>   create mode 100644 arch/riscv/include/asm/semihost.h
>>   rename drivers/tty/serial/{earlycon-arm-semihost.c => earlycon-semihost.c} (57%)
>
>Tested-by: Sergey Matyukevich <sergey.matyukevich@syntacore.com>
>
>Applied the patches on top of Linux 6.1 and tested earlycon logs from
>RISC-V target in OpenOCD.
>

Thanks for your testing!

Regards,
Bin
