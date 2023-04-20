Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3636E9952
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 18:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbjDTQQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 12:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjDTQP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 12:15:58 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD703596;
        Thu, 20 Apr 2023 09:15:57 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 4038C2AE;
        Thu, 20 Apr 2023 16:15:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4038C2AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1682007357; bh=dIoh7Uzva2QsUh5vyGcccNj94Y882Db73hATcucqawE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=VANjqdpHV1W5XdXIB/wV+x8VC4ql3kGUs/Per8arX/UNuGOuxeKFb/7Av0anFrvms
         k2opc6Z1dgRJBQh0L+vo4aO3IZ6rk1D1BicOJephalElMdkwyzKggqcxWNqG4OVJLo
         KloTTSAaHOH4IGy3uYVMjyqnHdaIJTj7zO3MOaqMsisjTVETjJkOO66AcYdmNbZn3D
         xcJNJf0KQeN4YWpLFn2TkGN+FDvBF6CFmG6Ph9Y320FpFKBVDL1z2sFaliP6/C7v4y
         FTZSDSMqKbWjWmDM4+nEUU8ASgxHKz0/vH/CfYklDAAipUkksA5j/Ri8cMe226p3TD
         Mktp/fj4YA+LA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Brian Masney <bmasney@redhat.com>, sboyd@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: clk: add documentation to log which clocks have
 been disabled
In-Reply-To: <20230411192153.289688-1-bmasney@redhat.com>
References: <20230411192153.289688-1-bmasney@redhat.com>
Date:   Thu, 20 Apr 2023 10:15:56 -0600
Message-ID: <87y1mmsf5v.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Masney <bmasney@redhat.com> writes:

> The existing clk documentation has a section that talks about the
> clk_ignore_unused kernel parameter. Add additional documentation that
> describes how to log which clocks the kernel disables on bootup. This
> will log messages like the following to the console on bootup:
>
>     [    1.268115] clk: Disabling unused clocks
>     [    1.272167] clk_disable: gcc_usb_clkref_en
>     [    1.276389] clk_disable: gcc_usb30_sec_sleep_clk
>     [    1.281131] clk_disable: gcc_usb30_prim_sleep_clk
>     ...
>
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---
>  Documentation/driver-api/clk.rst | 5 +++++
>  1 file changed, 5 insertions(+)

I've applied this, but...

> diff --git a/Documentation/driver-api/clk.rst b/Documentation/driver-api/clk.rst
> index 3cad45d14187..2199c0042e75 100644
> --- a/Documentation/driver-api/clk.rst
> +++ b/Documentation/driver-api/clk.rst
> @@ -258,6 +258,11 @@ clocks properly but rely on them being on from the bootloader, bypassing
>  the disabling means that the driver will remain functional while the issues
>  are sorted out.
>  
> +You can see which clocks have been disabled by booting your kernel with these
> +parameters:

...I took the liberty of making that "parameters::" so that the options
would be formatted as a literal block.

> + tp_printk trace_event=clk:clk_disable
> +
>  To bypass this disabling, include "clk_ignore_unused" in the bootargs to the
>  kernel.

Thanks,

jon
