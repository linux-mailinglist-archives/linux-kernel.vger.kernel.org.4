Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A273D70439A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 04:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjEPCvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 22:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjEPCvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 22:51:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1181E48;
        Mon, 15 May 2023 19:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=Jmfb0+AMOohyZqKXEeXp7ZN9Wbo6dEb6Z8dicoVNm0c=; b=CvAYWrgRgNwh9w1ywla/f13+sJ
        uCyP8lhHKxVwGD3LL4GjnSF3AncQCnoiUA5/A8bvG1Ek6aT7+u/djGSDwlB7nGH+zo+KkiGZEaPIi
        YtnAkpX9yNWI8FBqsbXUGBOeeflIEdgPXN5cWACrFw2KslzsJqgkWuMYLpbgvxSZCzAE40DjUKKNy
        8Iec6eOUp9jPTKQjxMUHhqMkkFQ73ZX5FNVhyJ7keucZiZRJTmaiC52SqlMvOBAcQivnTucKQLf3F
        BDVpcHPdiDyQfv0em6fhK2UBDBBoT2GL1PSK7znrvq/p5aD3fayZGOAf81cfUkXC8GH90uOuOsyC2
        CtF6aoBQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pykms-004Bav-1h;
        Tue, 16 May 2023 02:51:42 +0000
Message-ID: <1538d954-864e-3a07-594a-dfe6d3178a72@infradead.org>
Date:   Mon, 15 May 2023 19:51:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: linux-next: Tree for May 15 (config SERIAL_CPM)
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
References: <20230515141235.0777c631@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230515141235.0777c631@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/14/23 21:12, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20230512:
> 

commit e3e7b13bffae
Author: Jiri Slaby <jirislaby@kernel.org>
Date:   Thu Apr 21 12:17:08 2022 +0200

    serial: allow COMPILE_TEST for some drivers

See this portion of that commit:

--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -783,7 +783,7 @@ config SERIAL_PMACZILOG_CONSOLE
 
 config SERIAL_CPM
        tristate "CPM SCC/SMC serial port support"
-       depends on CPM2 || CPM1
+       depends on CPM2 || CPM1 || (PPC32 && COMPILE_TEST)


When PPC32=y and COMPILE_TEST=y but CPM1 is not set and CPM2 is not set:

/opt/crosstool/gcc-12.2.0-nolibc/powerpc-linux/bin/powerpc-linux-ld: drivers/tty/serial/cpm_uart/cpm_uart_core.o: in function `cpm_uart_release_port':
cpm_uart_core.c:(.text+0x598): undefined reference to `cpm_uart_freebuf'
/opt/crosstool/gcc-12.2.0-nolibc/powerpc-linux/bin/powerpc-linux-ld: drivers/tty/serial/cpm_uart/cpm_uart_core.o: in function `cpm_uart_set_termios':
cpm_uart_core.c:(.text+0x8e0): undefined reference to `__cpm2_setbrg'
/opt/crosstool/gcc-12.2.0-nolibc/powerpc-linux/bin/powerpc-linux-ld: drivers/tty/serial/cpm_uart/cpm_uart_core.o: in function `cpm_uart_break_ctl':
cpm_uart_core.c:(.text+0xb10): undefined reference to `cpm_line_cr_cmd'
/opt/crosstool/gcc-12.2.0-nolibc/powerpc-linux/bin/powerpc-linux-ld: cpm_uart_core.c:(.text+0xb6c): undefined reference to `cpm_line_cr_cmd'
/opt/crosstool/gcc-12.2.0-nolibc/powerpc-linux/bin/powerpc-linux-ld: drivers/tty/serial/cpm_uart/cpm_uart_core.o: in function `cpm_uart_startup':
cpm_uart_core.c:(.text+0x1d48): undefined reference to `cpm_line_cr_cmd'
/opt/crosstool/gcc-12.2.0-nolibc/powerpc-linux/bin/powerpc-linux-ld: drivers/tty/serial/cpm_uart/cpm_uart_core.o: in function `cpm_uart_request_port':
cpm_uart_core.c:(.text+0x1ddc): undefined reference to `cpm_uart_allocbuf'
/opt/crosstool/gcc-12.2.0-nolibc/powerpc-linux/bin/powerpc-linux-ld: cpm_uart_core.c:(.text+0x2170): undefined reference to `cpm_line_cr_cmd'
/opt/crosstool/gcc-12.2.0-nolibc/powerpc-linux/bin/powerpc-linux-ld: drivers/tty/serial/cpm_uart/cpm_uart_core.o: in function `cpm_uart_probe':
cpm_uart_core.c:(.text+0x2474): undefined reference to `cpm_uart_map_pram'
/opt/crosstool/gcc-12.2.0-nolibc/powerpc-linux/bin/powerpc-linux-ld: cpm_uart_core.c:(.text+0x2724): undefined reference to `cpm_uart_unmap_pram'
/opt/crosstool/gcc-12.2.0-nolibc/powerpc-linux/bin/powerpc-linux-ld: cpm_uart_core.c:(.text+0x2838): undefined reference to `cpm_uart_map_pram'
/opt/crosstool/gcc-12.2.0-nolibc/powerpc-linux/bin/powerpc-linux-ld: drivers/tty/serial/cpm_uart/cpm_uart_core.o: in function `cpm_uart_shutdown':
cpm_uart_core.c:(.text+0x2aa8): undefined reference to `cpm_line_cr_cmd'
/opt/crosstool/gcc-12.2.0-nolibc/powerpc-linux/bin/powerpc-linux-ld: cpm_uart_core.c:(.text+0x2ba4): undefined reference to `cpm_line_cr_cmd'


-- 
~Randy
