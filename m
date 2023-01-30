Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F90E680726
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 09:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235899AbjA3IMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 03:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235911AbjA3IMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 03:12:18 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 65646101;
        Mon, 30 Jan 2023 00:11:43 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 30U8AYMh006342;
        Mon, 30 Jan 2023 09:10:34 +0100
Date:   Mon, 30 Jan 2023 09:10:34 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Hongyu Xie <xiehongyu1@kylinos.cn>
Cc:     sfr@canb.auug.org.au, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org
Subject: Re: Report a compile err
Message-ID: <20230130081034.GA6262@1wt.eu>
References: <20230130165442.29f65a51@canb.auug.org.au>
 <20230130073012.374172-1-xiehongyu1@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130073012.374172-1-xiehongyu1@kylinos.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 03:30:12PM +0800, Hongyu Xie wrote:
> source code:
>   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> base:
>   ae0c77e1bc6963c67c6c09e8c72959fcb1ed8d5f
> config tested:
>   x86_64_defconfig
>   defconfig(arm64)
> toolchain:
>   gcc version 10.4.0 (Ubuntu 10.4.0-4ubuntu1~22.04)
> cross compile toolchain:
>   gcc version 10.4.0 (Ubuntu 10.4.0-4ubuntu1~22.04)
> 
> reproduce compile err:
>   CONFIG_WERROR=y && CONFIG_PRINTK=n && CONFIG_UBSAN_ALIGNMENT=y &&
>   CONFIG_UBSAN_SANITIZE_ALL=y
> 
> compile err log:
> kernel/printk/printk.c: In function 'console_flush_all':
> kernel/printk/printk.c:2845:17: error: array subscript 0 is outside array
> bounds of 'char[0]' [-Werror=array-bounds]
>  2845 |  char *outbuf = &pbufs.outbuf[0];
>       |                 ^~~~~~~~~~~~~~~~
> In file included from kernel/printk/printk.c:61:
> kernel/printk/internal.h:87:7: note: while referencing 'outbuf'
>    87 |  char outbuf[PRINTK_MESSAGE_MAX];
>       |       ^~~~~~
> kernel/printk/printk.c:2842:31: note: defined here 'pbufs'
>  2842 |  static struct printk_buffers pbufs;
>       |                               ^~~~~
>
> I applied the way 5a41237ad1d4 in mainline did for gcc 10, problem goes
> away. I'm guessing this is a gcc bug.

I think it's similar to this one I reported two years ago, that others
also faced, and was apparently only fixed in later versions:

    https://gcc.gnu.org/bugzilla/show_bug.cgi?id=98503

Most likely the workaround in 5a41237ad1d4 should be extended to gcc-10.

Willy
