Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774F567459B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 23:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjASWNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 17:13:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjASWMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 17:12:13 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98095966EB;
        Thu, 19 Jan 2023 13:49:23 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 496BF84F5C;
        Thu, 19 Jan 2023 22:49:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1674164960;
        bh=w1XzXfuAXzBz16MZy6W/qy1mZRIIitbpfYJMS40Elrc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ji3CtlqoKKSnPqZeVBQem2W8j/dhuXzRMgo/MhNUkpzhJ/ZoZFipaJU7muow7avjV
         ZMc7NOQGvgM8W7+d9RyJbHFNoRGAd7wGXRA3RrD+UplHD52SjErBlT1+1YpLE3gJw2
         kjGq6wifGPhGa+9Zrl0O95qpRAjLr9IANOEbrxDLN10SfTU6fPI/ipYFIXNkZGtQ91
         2udCXFDh+l+2kyc+bi87F8Kq3yGol8YhWYsu+Brzngu5NUiV8kHWLbpH9Pw+PbQS3i
         tCv5GFKN0I2k+xaZdy5vHD4+9aMuPBfLr5ZOHd/8mNuN69KcYIpXRJBiidOgSosJup
         wEU6gCBH/UcVw==
Message-ID: <fea0fa6e-c2c6-f904-4e9b-94f40fa443ea@denx.de>
Date:   Thu, 19 Jan 2023 22:49:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: linux-next: build failure after merge of the tty.current tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>, Greg KH <greg@kroah.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>
References: <20230120075832.02bc1124@canb.auug.org.au>
Content-Language: en-US
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20230120075832.02bc1124@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/23 21:58, Stephen Rothwell wrote:
> Hi all,

Hi,

> After merging the tty.current tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> drivers/tty/serial/stm32-usart.c: In function 'stm32_usart_interrupt':
> drivers/tty/serial/stm32-usart.c:804:62: error: 'flags' undeclared (first use in this function)
>    804 |                 uart_unlock_and_check_sysrq_irqrestore(port, flags);
>        |                                                              ^~~~~
> drivers/tty/serial/stm32-usart.c:804:62: note: each undeclared identifier is reported only once for each function it appears in
> 
> Caused by commit
> 
>    f24771b62a83 ("serial: stm32: Merge hard IRQ and threaded IRQ handling into single IRQ handler")
> 
> I have used the tty.current tree from next-20230119 for today.

I already proposed a fix in the build robot report

[tty:tty-linus 4/7] drivers/tty/serial/stm32-usart.c:804:62: error: 
'flags' undeclared

Now waiting for Johan to confirm that's the correct approach.
